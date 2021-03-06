USE [PandaMarketCMS]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_ruleRoutes_Category]    Script Date: 3/30/2020 3:53:28 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_ruleRoutes_Category](
	[CatId] [int] IDENTITY(1,1) NOT NULL,
	[R_CatName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_ruleRoutes_Category] PRIMARY KEY CLUSTERED 
(
	[CatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_ruleRoutes_Main]    Script Date: 3/30/2020 3:53:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_ruleRoutes_Main](
	[rulerouteID] [int] IDENTITY(1,1) NOT NULL,
	[ruleRouteURL] [nvarchar](max) NOT NULL,
	[ruleRouteName] [nvarchar](max) NULL,
	[ruleRouteCatId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_ADMIN_ruleRoutes_Main] PRIMARY KEY CLUSTERED 
(
	[rulerouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ON 

INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (1, N'تمامی دسته بندی ها')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (2, N'سر دسته ی محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (3, N'گروه اصلی محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (4, N'گروه محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (5, N'ویژگی های محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (6, N'جزئیات ویژگی ها')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (7, N'برچسب های اصلی')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (8, N'برچسب محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (9, N'صفحه ساز')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (10, N'محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (11, N'ادمین')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ON 

INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (1, N'/Product/ShowCatTree', N'نمایش تمامی دسته بندی ها', 1)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2, N'/MS/Add_Type', N'نمایش صفحه ی سردسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (3, N'/MS/TypePage', N'اضافه کردن و ویرایش سر دسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (4, N'/MS/table_Type', N'نمایش جدول سر دسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (5, N'/MS/Type_Switch', N' ویرایش ،حذف ، فعال و غیر فعال کردن سر دسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (6, N'/MS/maincat', N' نمایش صفحه ی گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (7, N'/MS/CatPage', N' اضافه کردن و ویرایش گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (8, N'/MS/table_Cat', N' نمایش جدول گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (9, N'/MS/Cat_Switch', N' ویرایش ،حذف ، فعال و غیر فعال کردن گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (10, N'/MS/SubCat', N' نمایش صفحه گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (11, N'/MS/SubPage', N' اضافه کردن و ویرایش گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (12, N'/MS/table_Sub', N' نمایش جدول گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (13, N'/MS/Sub_Switch', N' ویرایش ،حذف ، فعال و غیر فعال کردن گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (14, N'/MS/SubCatKey', N' نمایش صفحه ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (15, N'/MS/SCKPage', N' اضافه کردن و ویرایش ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (16, N'/MS/table_SCK', N' نمایش جدول ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (17, N'/MS/SCK_Switch', N' ویرایش ،حذف ، فعال و غیر فعال کردن ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (18, N'/MS/New_SCV', N' نمایش صفحه جزئیات ویژگی ها', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (19, N'/MS/SCV_Add_Update', N'اضافه کردن ، ویرایش و حذف جزئیات ویژگی ها', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (20, N'/MS/SCV_table', N'نمایش جدول جزئیات ویژگی ها', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (21, N'/Product/Product_List', N'نمایش جدول محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (22, N'/Product/Add_Product', N'اضافه کردن محصول', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (23, N'/Product/Options_Table', N'نمایش جدول ویژگی های مشترک محصول', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (24, N'/Product/Op_delete_edit', N'اضافه کردن ، ویرایش و حذف ویژگی های مشترک محصول', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (25, N'/Product/UploadPage', N'آپلود عکس محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (26, N'/Product/Update_Product', N'ویرایش محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (28, N'/Product/ProductDetails', N'نمایش و ویرایش قیمت جزئیات محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (29, N'/Product/Product_Actions', N'حذف ، فعال و غیر فعال کردن محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (30, N'/Product/AddTag', N' نمایش صفحه برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (31, N'/Product/Add_MainTag', N' نمایش صفحه برچسب های اصلی', 7)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (32, N'/Product/MainTag_Add_Update', N' اضافه کردن ، ویرایش و حذف برچسب های اصلی', 7)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (33, N'/Product/Tag_Add_Update', N' اضافه کردن ، ویرایش و حذف برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (34, N'/Product/TagsTable', N' نمایش جدول برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (35, N'/Product/MainTag_table', N' نمایش جدول برچسب های اصلی', 7)
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] OFF
