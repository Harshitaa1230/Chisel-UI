import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

const supabaseUrl = 'YOUR_SUPABASE_URL';
const supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

// Fetch all components
export async function fetchComponents() {
  const { data, error } = await supabase
    .from('components')
    .select('*')
    .order('category')
    .order('name');
  
  if (error) {
    console.error('Error fetching components:', error);
    return [];
  }
  return data;
}

// Fetch components by category
export async function fetchComponentsByCategory(category) {
  const { data, error } = await supabase
    .from('components')
    .select('*')
    .eq('category', category)
    .order('name');
  
  if (error) {
    console.error('Error fetching components:', error);
    return [];
  }
  return data;
}

// Fetch all categories
export async function fetchCategories() {
  const { data, error } = await supabase
    .from('categories')
    .select('*')
    .order('sort_order');
  
  if (error) {
    console.error('Error fetching categories:', error);
    return [];
  }
  return data;
}

// Search components
export async function searchComponents(query) {
  const { data, error } = await supabase
    .from('components')
    .select('*')
    .or(`name.ilike.%${query}%,category.ilike.%${query}%`)
    .order('category')
    .order('name');
  
  if (error) {
    console.error('Error searching components:', error);
    return [];
  }
  return data;
}

// Create component
export async function createComponent(component) {
  const { data, error } = await supabase
    .from('components')
    .insert([component])
    .select()
    .single();
  
  if (error) {
    console.error('Error creating component:', error);
    return null;
  }
  return data;
}

// Update component
export async function updateComponent(id, updates) {
  const { data, error } = await supabase
    .from('components')
    .update(updates)
    .eq('id', id)
    .select()
    .single();
  
  if (error) {
    console.error('Error updating component:', error);
    return null;
  }
  return data;
}

// Delete component
export async function deleteComponent(id) {
  const { error } = await supabase
    .from('components')
    .delete()
    .eq('id', id);
  
  if (error) {
    console.error('Error deleting component:', error);
    return false;
  }
  return true;
}

// Get component stats
export async function getComponentStats() {
  const { data, error } = await supabase
    .from('components')
    .select('category');
  
  if (error) {
    console.error('Error getting stats:', error);
    return null;
  }
  
  const total = data.length;
  const categories = {};
  const newCount = data.filter(c => c.is_new).length;
  
  data.forEach(c => {
    categories[c.category] = (categories[c.category] || 0) + 1;
  });
  
  return { total, categories, newCount };
}
