using Repository.Repo;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Threading;
using System.Threading.Tasks;
using Repository.Model;

namespace InvotoryAPI.Controllers
{
    public class ItemController : ApiController
    {
        private IRepoItemMaster _IRepoItemMaster = null;
        public ItemController(IRepoItemMaster obj) 
        {
            _IRepoItemMaster = obj;
        }       

        [HttpGet]
        [Route("api/ItemMaster/GetItem")]
        public async Task<IHttpActionResult> GetItems()
        {
            try
            {
                var Result =await Task.Run(()=> _IRepoItemMaster.GetItems(0));
                return Ok(Result);
            }
            catch(Exception Ex) {
                return InternalServerError(Ex);
            }
            
        }
        [HttpPost]
        [Route("api/ItemMaster/CreateItem")]
        public async Task<IHttpActionResult> CreateItem([FromBody]ItemModel mdl)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var Result = await Task.Run(() => _IRepoItemMaster.SaveItem(mdl));
                    return Ok(Result);
                }
                else
                {
                    return BadRequest(ModelState);
                }
                   
            }
            catch (Exception Ex)
            {
                return InternalServerError(Ex);
            }

        }
        
        [HttpPut]
        [Route("api/ItemMaster/UpdateItem")]
        public async Task<IHttpActionResult> UpdateItem([FromBody] ItemModel mdl)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    var Result = await Task.Run(() => _IRepoItemMaster.SaveItem(mdl));
                    return Ok(Result);
                }
                else
                {
                    return BadRequest(ModelState);
                }
            }
            catch (Exception Ex)
            {
                return InternalServerError(Ex);
            }

        }

        [HttpDelete]
        [Route("api/ItemMaster/DeleteItem")]
        public async Task<IHttpActionResult> DeleteItem([FromUri]int id)
        {
            try
            {
                if (id == 0)
                {
                    return BadRequest("id parameter must be greater than 0");                    
                }
                else
                {
                    var Result = await Task.Run(() => _IRepoItemMaster.DeleteItem(id));
                    return Ok(Result);
                }
            }
            catch (Exception Ex)
            {
                return InternalServerError(Ex);
            }

        }
    }
}
