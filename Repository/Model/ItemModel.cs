using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.ComponentModel.DataAnnotations;

namespace Repository.Model
{
   public class ItemModel
    {
        public int Item_ID { get; set; }

        [Required(ErrorMessage = "Item Name is required !!")]
        public string Item_Name { get; set; }

        [Required(ErrorMessage = "Price is required !!")]
        [RegularExpression(@"[0-9]*\.?[0-9]+", ErrorMessage = "{0} must be a Number !!")]
        public Nullable<decimal> Price { get; set; }

        [Required(ErrorMessage = "Description is required !!")]
        [MaxLength(ErrorMessage = "content not exceed to 500 characters !!")]
        public string Description { get; set; }
    }
}
