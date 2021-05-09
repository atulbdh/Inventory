using Repository.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.Repo
{
    public class RepoItemMaster : IRepoItemMaster
    {
        public  List<USP_Get_Item_Result> GetItems(int itemid)
        {
            using (Inventory_DBEntities dbCtx = new Inventory_DBEntities())
            {
                return  dbCtx.USP_Get_Item(itemid).ToList();
            }
        }

        public string DeleteItem(int itemid)
        {
            using (Inventory_DBEntities dbCtx = new Inventory_DBEntities())
            {
                return dbCtx.USP_Del_Item(itemid).FirstOrDefault();
            }
        }

        public string SaveItem(ItemModel _Item_Master)
        {
            using (Inventory_DBEntities dbCtx = new Inventory_DBEntities())
            {
                int Item_ID = _Item_Master.Item_ID;
                string Item_Name = _Item_Master.Item_Name;
                decimal? Price = _Item_Master.Price;
                string Description = _Item_Master.Description;
                int Add_By = 0;
                return dbCtx.USP_Ins_Item(Item_ID, Item_Name, Price, Description, Add_By).FirstOrDefault();
            }
        }
    }
}
