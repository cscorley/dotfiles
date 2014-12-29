class Redwood::ThreadIndexMode
  def archive_and_delete
    t = cursor_thread or return
    multi_read_and_archive [t]
    multi_toggle_deleted [t]
  end
end

class Redwood::ThreadViewMode
    def archive_delete_and_next
        archive_delete_and_then :next
    end
    def archive_delete_and_then op
        dispatch op do
            @thread.remove_label :inbox
            @thread.apply_label :deleted
            UpdateManager.relay self, :archived, @thread.first
            UpdateManager.relay self, :deleted, @thread.first
            Index.save_thread @thread
            UndoManager.register "archiving and deleting 1 thread" do
                @thread.apply_label :inbox
                @thread.remove_label :deleted
                Index.save_thread @thread
                UpdateManager.relay self, :undeleted, @thread.first
                UpdateManager.relay self, :unarchived, @thread.first
            end
        end
    end
end
