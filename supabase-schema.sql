-- =============================================
-- CHISEL UI - Supabase Database Setup
-- Run this in Supabase SQL Editor
-- =============================================

-- Create components table
CREATE TABLE components (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  variants INTEGER DEFAULT 1,
  states INTEGER DEFAULT 1,
  is_new BOOLEAN DEFAULT false,
  is_updated BOOLEAN DEFAULT false,
  figma_url TEXT,
  cover_image TEXT,
  video_url TEXT,
  preview_color TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create categories table
CREATE TABLE categories (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  slug TEXT NOT NULL UNIQUE,
  sort_order INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert default categories
INSERT INTO categories (name, slug, sort_order) VALUES
  ('Forms', 'forms', 1),
  ('Navigation', 'navigation', 2),
  ('Feedback', 'feedback', 3),
  ('Data Display', 'data-display', 4),
  ('Layout', 'layout', 5),
  ('Overlays', 'overlays', 6),
  ('Typography', 'typography', 7);

-- Enable Row Level Security
ALTER TABLE components ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- Policy: Allow public read access
CREATE POLICY "Allow public read" ON components
  FOR SELECT USING (true);

CREATE POLICY "Allow public read" ON categories
  FOR SELECT USING (true);

-- Policy: Allow authenticated users to insert/update/delete
CREATE POLICY "Allow authenticated insert" ON components
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow authenticated update" ON components
  FOR UPDATE USING (true);

CREATE POLICY "Allow authenticated delete" ON components
  FOR DELETE USING (true);

-- Insert sample components
INSERT INTO components (name, category, variants, states, is_new, is_updated, figma_url) VALUES
  ('Button', 'Forms', 3, 4, false, false, '#'),
  ('Input', 'Forms', 2, 4, false, true, '#'),
  ('Textarea', 'Forms', 2, 3, false, false, '#'),
  ('Select', 'Forms', 3, 4, false, false, '#'),
  ('Checkbox', 'Forms', 2, 3, false, false, '#'),
  ('Radio', 'Forms', 2, 3, false, false, '#'),
  ('Toggle', 'Forms', 2, 3, false, false, '#'),
  ('Slider', 'Forms', 2, 3, false, false, '#'),
  ('Date Picker', 'Forms', 2, 2, true, false, '#'),
  ('File Upload', 'Forms', 2, 3, true, false, '#'),
  ('Form Layout', 'Forms', 4, 2, false, false, '#'),
  ('Search Input', 'Forms', 2, 3, false, true, '#'),
  ('Tabs', 'Navigation', 3, 3, false, false, '#'),
  ('Breadcrumb', 'Navigation', 2, 2, false, false, '#'),
  ('Pagination', 'Navigation', 2, 3, false, false, '#'),
  ('Navbar', 'Navigation', 3, 2, false, false, '#'),
  ('Sidebar Nav', 'Navigation', 2, 2, false, false, '#'),
  ('Menu', 'Navigation', 3, 3, false, false, '#'),
  ('Dropdown', 'Navigation', 2, 2, false, false, '#'),
  ('Stepper', 'Navigation', 2, 3, true, false, '#'),
  ('Alert', 'Feedback', 4, 2, false, false, '#'),
  ('Toast', 'Feedback', 3, 2, false, false, '#'),
  ('Progress', 'Feedback', 3, 3, false, false, '#'),
  ('Spinner', 'Feedback', 4, 2, false, false, '#'),
  ('Skeleton', 'Feedback', 3, 2, false, true, '#'),
  ('Empty State', 'Feedback', 3, 2, true, false, '#'),
  ('Table', 'Data Display', 4, 3, false, false, '#'),
  ('Card', 'Data Display', 4, 2, false, false, '#'),
  ('List', 'Data Display', 3, 3, false, false, '#'),
  ('Avatar', 'Data Display', 4, 2, false, false, '#'),
  ('Badge', 'Data Display', 4, 2, false, false, '#'),
  ('Chip', 'Data Display', 3, 2, false, false, '#'),
  ('Tooltip', 'Data Display', 3, 2, false, false, '#'),
  ('Stat', 'Data Display', 3, 2, false, false, '#'),
  ('Chart', 'Data Display', 5, 2, true, false, '#'),
  ('Divider', 'Layout', 2, 2, false, false, '#'),
  ('Grid', 'Layout', 3, 2, false, false, '#'),
  ('Stack', 'Layout', 3, 2, false, false, '#'),
  ('Container', 'Layout', 2, 2, false, false, '#'),
  ('Responsive Frame', 'Layout', 4, 2, false, true, '#'),
  ('Modal', 'Overlays', 2, 2, true, false, '#'),
  ('Dialog', 'Overlays', 2, 2, false, false, '#'),
  ('Drawer', 'Overlays', 3, 2, false, false, '#'),
  ('Popover', 'Overlays', 2, 2, false, false, '#'),
  ('Heading', 'Typography', 6, 2, false, false, '#'),
  ('Text', 'Typography', 4, 2, false, false, '#'),
  ('Link', 'Typography', 3, 3, false, false, '#');

-- Create function to get component count by category
CREATE OR REPLACE FUNCTION get_component_count()
RETURNS TABLE(category TEXT, count BIGINT) AS $$
BEGIN
  RETURN QUERY
  SELECT components.category, COUNT(*)::BIGINT
  FROM components
  GROUP BY components.category;
END;
$$ LANGUAGE plpgsql;

-- Create function to get total component count
CREATE OR REPLACE FUNCTION get_total_count()
RETURNS BIGINT AS $$
BEGIN
  RETURN (SELECT COUNT(*) FROM components);
END;
$$ LANGUAGE plpgsql;
