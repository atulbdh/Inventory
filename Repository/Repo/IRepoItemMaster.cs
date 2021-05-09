using Repository.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.Repo
{
    public interface IRepoItemMaster
    {
        List<USP_Get_Item_Result> GetItems(int itemid);
        string SaveItem(ItemModel _Item_Master);
        string DeleteItem(int itemid);
    }
}
