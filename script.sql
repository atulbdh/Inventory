USE [Inventory_DB]
GO
/****** Object:  Table [dbo].[Item_Master]    Script Date: 5/9/2021 9:53:51 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Item_Master](
	[Item_ID] [int] IDENTITY(1,1) NOT NULL,
	[Item_Name] [nvarchar](150) NULL,
	[Price] [decimal](18, 2) NULL,
	[Description] [nvarchar](500) NULL,
	[Add_By] [int] NULL,
	[Add_Date] [datetime] NULL,
	[Edit_By] [int] NULL,
	[Edit_Date] [datetime] NULL,
	[Delete_By] [int] NULL,
	[Delete_Date] [datetime] NULL,
	[Status] [bit] NULL,
	[Deleted] [bit] NULL,
 CONSTRAINT [PK_Item_Master] PRIMARY KEY CLUSTERED 
(
	[Item_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Item_Master] ON 

INSERT [dbo].[Item_Master] ([Item_ID], [Item_Name], [Price], [Description], [Add_By], [Add_Date], [Edit_By], [Edit_Date], [Delete_By], [Delete_Date], [Status], [Deleted]) VALUES (1, N'bb', CAST(58.00 AS Decimal(18, 2)), N'test', 1, CAST(N'2021-05-07T18:13:50.943' AS DateTime), 0, CAST(N'2021-05-08T00:45:17.730' AS DateTime), NULL, CAST(N'2021-05-07T18:35:28.703' AS DateTime), 1, 0)
INSERT [dbo].[Item_Master] ([Item_ID], [Item_Name], [Price], [Description], [Add_By], [Add_Date], [Edit_By], [Edit_Date], [Delete_By], [Delete_Date], [Status], [Deleted]) VALUES (2, N'ass', CAST(58.00 AS Decimal(18, 2)), N'test', 1, CAST(N'2021-05-07T18:14:50.107' AS DateTime), 0, CAST(N'2021-05-08T00:45:06.100' AS DateTime), NULL, CAST(N'2021-05-07T18:35:28.703' AS DateTime), 1, 0)
INSERT [dbo].[Item_Master] ([Item_ID], [Item_Name], [Price], [Description], [Add_By], [Add_Date], [Edit_By], [Edit_Date], [Delete_By], [Delete_Date], [Status], [Deleted]) VALUES (3, N'cc', CAST(58.00 AS Decimal(18, 2)), N'test', 1, CAST(N'2021-05-07T18:16:26.377' AS DateTime), 0, CAST(N'2021-05-08T00:42:37.183' AS DateTime), NULL, CAST(N'2021-05-07T18:35:28.703' AS DateTime), 1, 0)
INSERT [dbo].[Item_Master] ([Item_ID], [Item_Name], [Price], [Description], [Add_By], [Add_Date], [Edit_By], [Edit_Date], [Delete_By], [Delete_Date], [Status], [Deleted]) VALUES (4, N'vv', CAST(58.00 AS Decimal(18, 2)), N'test', 0, CAST(N'2021-05-08T00:25:00.470' AS DateTime), 0, CAST(N'2021-05-08T00:42:37.183' AS DateTime), NULL, NULL, 1, 0)
INSERT [dbo].[Item_Master] ([Item_ID], [Item_Name], [Price], [Description], [Add_By], [Add_Date], [Edit_By], [Edit_Date], [Delete_By], [Delete_Date], [Status], [Deleted]) VALUES (5, N'rt', CAST(58.00 AS Decimal(18, 2)), N'test', 0, CAST(N'2021-05-08T00:25:47.207' AS DateTime), 0, CAST(N'2021-05-08T00:42:37.183' AS DateTime), NULL, CAST(N'2021-05-08T00:38:44.470' AS DateTime), 1, 1)
INSERT [dbo].[Item_Master] ([Item_ID], [Item_Name], [Price], [Description], [Add_By], [Add_Date], [Edit_By], [Edit_Date], [Delete_By], [Delete_Date], [Status], [Deleted]) VALUES (6, N'sar', CAST(58.00 AS Decimal(18, 2)), N'test', 0, CAST(N'2021-05-08T00:31:47.137' AS DateTime), 0, CAST(N'2021-05-08T00:42:37.183' AS DateTime), NULL, NULL, 1, 0)
SET IDENTITY_INSERT [dbo].[Item_Master] OFF
GO
ALTER TABLE [dbo].[Item_Master] ADD  CONSTRAINT [DF_Item_Master_Add_Date]  DEFAULT (getdate()) FOR [Add_Date]
GO
ALTER TABLE [dbo].[Item_Master] ADD  CONSTRAINT [DF_Item_Master_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Item_Master] ADD  CONSTRAINT [DF_Item_Master_Deleted]  DEFAULT ((0)) FOR [Deleted]
GO
/****** Object:  StoredProcedure [dbo].[USP_Del_Item]    Script Date: 5/9/2021 9:53:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Del_Item] 
(
@Item_ID int
)
AS
SET NOCOUNT ON;
BEGIN try	
BEGIN TRAN
	Begin
	IF (EXISTS (SELECT Item_ID FROM Item_Master where Item_ID =@Item_ID and Deleted=0))
	begin
			UPDATE       Item_Master
			SET  deleted = 1,  Delete_Date =getdate()	where Item_ID =@Item_ID	
			select 'Item has been deleted successfully !' msg
	end		
	else
		select 'Item not exist in database !' msg
	End
COMMIT TRAN 
END try

begin catch
IF @@TRANCOUNT > 0
select 'Something went wrong !' msg
ROLLBACK TRAN
end catch



GO
/****** Object:  StoredProcedure [dbo].[USP_Get_Item]    Script Date: 5/9/2021 9:53:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[USP_Get_Item] 
(
@Item_ID int=0
)
AS
SET NOCOUNT ON;
SELECT       Item_ID, Item_Name, Price, Description
FROM            Item_Master
where  (0=@Item_ID or Item_ID=@Item_ID) and deleted=0





GO
/****** Object:  StoredProcedure [dbo].[USP_Ins_Item]    Script Date: 5/9/2021 9:53:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[USP_Ins_Item] 
(
@Item_ID int,@Item_Name nvarchar(150), @Price decimal(18,2), @Description nvarchar(150), @Add_By int
)
AS
SET NOCOUNT ON;
BEGIN try	
BEGIN TRAN
	Begin
	IF (NOT EXISTS (SELECT Item_ID FROM Item_Master where (Item_Name=@Item_Name) and (@Item_ID = 0 OR Item_ID !=@Item_ID)))
	begin
		if(@Item_ID=0)
		begin
			INSERT INTO Item_Master
								 (Item_Name, Price, Description, Add_By)
			VALUES        (@Item_Name, @Price, @Description, @Add_By)
			select 'Item has been saved successfully !' msg
		end
		else
		begin
			UPDATE       Item_Master
			SET  Item_Name = @Item_Name, Price = @Price, Description = @Description, Edit_By =@Add_By, Edit_Date =getdate()	
			where Item_ID =@Item_ID
			select 'Item has been updated successfully !' msg
		end
	end
	else
		select 'Item already exist in database !' msg
	End
COMMIT TRAN 
END try

begin catch
IF @@TRANCOUNT > 0
select 'Something went wrong !' msg
ROLLBACK TRAN
end catch



GO
