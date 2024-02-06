module ApplicationHelper
    def truncate_rich_text(content, length: 150, omission: '...')
        stripped_content = strip_tags(content.to_s)
        truncated_text = truncate(stripped_content, length: length, omission: omission)
        sanitize(truncated_text, tags: %w(p br)) # Ensure HTML tags are preserved
    end 
end
