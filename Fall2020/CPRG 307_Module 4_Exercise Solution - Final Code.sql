/* ************************************************************************* **
** This program will populate the inventory value in the category table      **
** to hold all DVDs that are available for that category                     **
** ************************************************************************* */

DECLARE

-- Get all categories from the database
  CURSOR c_category IS
    SELECT category_code
      FROM cp_category;

-- Store current category code	  
  v_category  cp_category.category_code%TYPE;

-- Get all DVDs from the database for the current category  
  CURSOR c_title IS
    SELECT dvd_number
      FROM cp_title ti, cp_dvd dvd
     WHERE ti.title_code = dvd.title_code
       AND category_code = v_category;

-- Counter variable	   
  v_count NUMBER := 0;

BEGIN

-- Outer loop that cycles through all categories
  FOR r_category IN c_category LOOP
  
-- Store the current category code to link the inner and outer cursors
    v_category := r_category.category_code ;
	
-- Initialize counter variable	
    v_count := 0;

-- Inner loop that cycles through all DVDs for the current category	
    FOR r_title IN c_title LOOP
	
-- Increment counter	
      v_count := v_count + 1;
    END LOOP;

-- If no DVDs, the value saved in the database should be NULL
	IF (v_count = 0) THEN
	  v_count := NULL;
	END IF;
	
-- Update the number of DVDs in the inventory counter	
    UPDATE cp_category
       SET category_inventory = v_count
     WHERE category_code = r_category.category_code;
  END LOOP;

-- Save data changes
  COMMIT;
  
END;
/
  