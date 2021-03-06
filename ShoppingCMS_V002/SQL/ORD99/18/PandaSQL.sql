
USE [PandaMarketCMS]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Categories]    Script Date: 5/7/2020 7:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[Is_Disabled] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
 CONSTRAINT [PK_Categories_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Post]    Script Date: 5/7/2020 7:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Post](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Text_min] [nvarchar](max) NULL,
	[Text] [nvarchar](max) NULL,
	[WrittenBy_AdminId] [int] NULL,
	[Date] [datetime] NULL,
	[weight] [int] NULL,
	[IsImportant] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
	[Is_Disabled] [tinyint] NULL,
	[Cat_Id] [int] NULL,
	[GroupId] [int] NULL,
	[TypeId] [int] NULL,
 CONSTRAINT [PK_Post_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_main]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_main](
	[id_Admin] [int] IDENTITY(1,1) NOT NULL,
	[ad_typeID] [int] NOT NULL,
	[ad_username] [nvarchar](max) NULL,
	[ad_password] [nvarchar](max) NULL,
	[ad_firstname] [nvarchar](100) NULL,
	[ad_lastname] [nvarchar](200) NULL,
	[ad_avatarprofile] [nvarchar](max) NULL,
	[ad_email] [nvarchar](max) NULL,
	[ad_phone] [nvarchar](20) NULL,
	[ad_mobile] [nvarchar](20) NULL,
	[ad_has2stepSecurity] [tinyint] NOT NULL,
	[ad_isActive] [tinyint] NOT NULL,
	[ad_isDelete] [tinyint] NOT NULL,
	[ad_lastseen] [datetime] NULL,
	[ad_lastlogin] [datetime] NULL,
	[ad_loginIP] [nvarchar](50) NULL,
	[ad_regdate] [datetime] NOT NULL,
	[ad_personalColorHexa] [nvarchar](max) NULL,
	[AdminModeID] [int] NULL,
	[ad_NickName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_main] PRIMARY KEY CLUSTERED 
(
	[id_Admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Groups]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Groups](
	[G_Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[Is_Disabled] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
	[GpToken] [nvarchar](50) NULL,
 CONSTRAINT [PK_Groups_tbl] PRIMARY KEY CLUSTERED 
(
	[G_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Blog_SinglePost]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Blog_SinglePost]
AS
SELECT        dbo.tbl_BLOG_Post.Cat_Id, dbo.tbl_BLOG_Post.GroupId, dbo.tbl_BLOG_Groups.name AS Gpname, dbo.tbl_BLOG_Categories.name AS CatName, dbo.tbl_BLOG_Post.Title, dbo.tbl_BLOG_Post.Text_min, dbo.tbl_BLOG_Post.Text,
                          dbo.tbl_BLOG_Post.Date, dbo.tbl_BLOG_Post.weight, dbo.tbl_BLOG_Post.IsImportant, dbo.tbl_BLOG_Post.Id AS PostID, dbo.tbl_BLOG_Post.WrittenBy_AdminId, dbo.tbl_ADMIN_main.ad_firstname, 
                         dbo.tbl_ADMIN_main.ad_lastname, dbo.tbl_ADMIN_main.ad_avatarprofile
FROM            dbo.tbl_BLOG_Categories INNER JOIN
                         dbo.tbl_BLOG_Post ON dbo.tbl_BLOG_Categories.Id = dbo.tbl_BLOG_Post.Cat_Id INNER JOIN
                         dbo.tbl_BLOG_Groups ON dbo.tbl_BLOG_Post.GroupId = dbo.tbl_BLOG_Groups.G_Id INNER JOIN
                         dbo.tbl_ADMIN_main ON dbo.tbl_BLOG_Post.WrittenBy_AdminId = dbo.tbl_ADMIN_main.id_Admin
WHERE        (dbo.tbl_BLOG_Post.Is_Disabled <> 1) AND (dbo.tbl_BLOG_Post.Is_Deleted <> 1) AND (dbo.tbl_BLOG_Groups.Is_Deleted <> 1) AND (dbo.tbl_BLOG_Groups.Is_Disabled <> 1) AND (dbo.tbl_BLOG_Categories.Is_Deleted <> 1) AND
                          (dbo.tbl_BLOG_Categories.Is_Disabled <> 1)
GO
/****** Object:  Table [dbo].[tbl_BLOG_Pic_Connector]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Pic_Connector](
	[PostId] [int] NOT NULL,
	[PicId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploaderStructure]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploaderStructure](
	[PicID] [int] IDENTITY(1,1) NOT NULL,
	[PicCategoryType] [int] NULL,
	[ISDELETE] [tinyint] NULL,
	[alt] [nvarchar](max) NULL,
	[uploadPicName] [nvarchar](max) NULL,
	[Descriptions] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_ADMIN_UploaderStructure] PRIMARY KEY CLUSTERED 
(
	[PicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_PicConnector]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PicConnector](
	[id_MProduct] [int] NOT NULL,
	[PicID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploaderStructure_ImageSize]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploaderStructure_ImageSize](
	[picSizeType] [int] IDENTITY(1,1) NOT NULL,
	[picSizeTypeName] [nvarchar](max) NULL,
	[picSizeTypeWidth] [float] NULL,
	[picSizeTypeHeight] [float] NULL,
 CONSTRAINT [PK_tbl_ADMIN_UploaderStructure_ImageSize] PRIMARY KEY CLUSTERED 
(
	[picSizeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic](
	[PicCategoryType] [int] IDENTITY(1,1) NOT NULL,
	[PicCategoryTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_UploaderStructure_CategoryPic] PRIMARY KEY CLUSTERED 
(
	[PicCategoryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploadStructure_ImageAddress]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploadStructure_ImageAddress](
	[PicID] [int] NOT NULL,
	[PicSizeType] [int] NOT NULL,
	[PicAddress] [nvarchar](max) NOT NULL,
	[PicThumbnailAddress] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Images]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Images]
AS
SELECT        dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeTypeName, dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeTypeWidth, dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeTypeHeight, 
                         dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicID, dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicAddress, dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicThumbnailAddress, 
                         dbo.tbl_ADMIN_UploaderStructure_CategoryPic.PicCategoryTypeName, dbo.tbl_ADMIN_UploaderStructure.alt, dbo.tbl_ADMIN_UploaderStructure.uploadPicName, dbo.tbl_ADMIN_UploaderStructure.ISDELETE, 
                         dbo.tbl_ADMIN_UploaderStructure.Descriptions, dbo.tbl_Product_PicConnector.id_MProduct, dbo.tbl_ADMIN_UploaderStructure.CreatedDate
FROM            dbo.tbl_ADMIN_UploadStructure_ImageAddress INNER JOIN
                         dbo.tbl_ADMIN_UploaderStructure_ImageSize ON dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicSizeType = dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeType INNER JOIN
                         dbo.tbl_ADMIN_UploaderStructure ON dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicID = dbo.tbl_ADMIN_UploaderStructure.PicID INNER JOIN
                         dbo.tbl_ADMIN_UploaderStructure_CategoryPic ON dbo.tbl_ADMIN_UploaderStructure.PicCategoryType = dbo.tbl_ADMIN_UploaderStructure_CategoryPic.PicCategoryType LEFT OUTER JOIN
                         dbo.tbl_Product_PicConnector ON dbo.tbl_ADMIN_UploaderStructure.PicID = dbo.tbl_Product_PicConnector.PicID
GO
/****** Object:  View [dbo].[v_Blog_AllImages]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Blog_AllImages]
AS
SELECT        dbo.tbl_BLOG_Pic_Connector.PicId, dbo.tbl_BLOG_Pic_Connector.PostId, dbo.v_Images.picSizeTypeName, dbo.v_Images.picSizeTypeWidth, dbo.v_Images.picSizeTypeHeight, dbo.v_Images.PicID AS Expr1, 
                         dbo.v_Images.PicAddress, dbo.v_Images.PicThumbnailAddress, dbo.v_Images.PicCategoryTypeName, dbo.v_Images.alt, dbo.v_Images.uploadPicName, dbo.v_Images.ISDELETE, dbo.v_Images.Descriptions
FROM            dbo.v_Images INNER JOIN
                         dbo.tbl_BLOG_Pic_Connector ON dbo.v_Images.PicID = dbo.tbl_BLOG_Pic_Connector.PicId
GO
/****** Object:  Table [dbo].[tbl_ADMIN_types]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_types](
	[ad_typeID] [int] IDENTITY(1,1) NOT NULL,
	[ad_type_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tbl_ADMIN_types] PRIMARY KEY CLUSTERED 
(
	[ad_typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ADMIN_mainView]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ADMIN_mainView]
AS
SELECT        dbo.tbl_ADMIN_types.ad_type_name, dbo.tbl_ADMIN_main.ad_typeID, dbo.tbl_ADMIN_main.id_Admin, dbo.tbl_ADMIN_main.ad_username, dbo.tbl_ADMIN_main.ad_password, dbo.tbl_ADMIN_main.ad_firstname, 
                         dbo.tbl_ADMIN_main.ad_lastname, dbo.tbl_ADMIN_main.ad_avatarprofile, dbo.tbl_ADMIN_main.ad_email, dbo.tbl_ADMIN_main.ad_NickName, dbo.tbl_ADMIN_main.AdminModeID, dbo.tbl_ADMIN_main.ad_personalColorHexa, 
                         dbo.tbl_ADMIN_main.ad_loginIP, dbo.tbl_ADMIN_main.ad_regdate, dbo.tbl_ADMIN_main.ad_lastlogin, dbo.tbl_ADMIN_main.ad_lastseen, dbo.tbl_ADMIN_main.ad_isDelete, dbo.tbl_ADMIN_main.ad_isActive, 
                         dbo.tbl_ADMIN_main.ad_has2stepSecurity, dbo.tbl_ADMIN_main.ad_mobile, dbo.tbl_ADMIN_main.ad_phone
FROM            dbo.tbl_ADMIN_main INNER JOIN
                         dbo.tbl_ADMIN_types ON dbo.tbl_ADMIN_main.ad_typeID = dbo.tbl_ADMIN_types.ad_typeID
GO
/****** Object:  Table [dbo].[tbl_ADMIN_adminMode]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_adminMode](
	[AdminModeID] [int] IDENTITY(1,1) NOT NULL,
	[adminModeName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_ADMIN_adminMode] PRIMARY KEY CLUSTERED 
(
	[AdminModeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_ruleRoutes_Category]    Script Date: 5/7/2020 7:41:29 PM ******/
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
/****** Object:  Table [dbo].[tbl_ADMIN_ruleRoutes_Main]    Script Date: 5/7/2020 7:41:29 PM ******/
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
/****** Object:  Table [dbo].[tbl_ADMIN_types_ruleRoute_Connection]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_types_ruleRoute_Connection](
	[ad_typeID] [int] NOT NULL,
	[rulerouteID] [int] NOT NULL,
	[HasAccess] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Comment]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[message] [nvarchar](max) NULL,
	[Name] [nvarchar](100) NULL,
	[PostId] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
	[Date] [int] NULL,
 CONSTRAINT [PK_Comment_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_CustomersMessge]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_CustomersMessge](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
	[Job] [nvarchar](max) NULL,
	[message] [nvarchar](max) NULL,
	[star] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
 CONSTRAINT [PK_CustomersMessge_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_EmailModule]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_EmailModule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](max) NULL,
 CONSTRAINT [PK_EmailModule_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_EmailTemplate]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_EmailTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [nvarchar](50) NULL,
	[HtmlCode] [nvarchar](max) NULL,
 CONSTRAINT [PK_EmailTemplate_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_PostType]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_PostType](
	[B_TypeId] [int] IDENTITY(1,1) NOT NULL,
	[B_TypeToken] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_BLOG_PostType] PRIMARY KEY CLUSTERED 
(
	[B_TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Reply]    Script Date: 5/7/2020 7:41:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Reply](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Name] [nvarchar](100) NULL,
	[Message] [nvarchar](max) NULL,
	[commentId] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
	[Date] [int] NULL,
 CONSTRAINT [PK_Reply_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_TagConnector]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_TagConnector](
	[Post_Id] [int] NOT NULL,
	[Tag_Id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Tags]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Tags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[CtegoryId] [int] NULL,
	[Is_Disabled] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
 CONSTRAINT [PK_Tags_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_TeamMembers]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_TeamMembers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Job] [nvarchar](100) NULL,
	[Tozihat] [nvarchar](max) NULL,
	[github] [nvarchar](max) NULL,
	[Linkedin] [nvarchar](max) NULL,
	[Instagram] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
 CONSTRAINT [PK_TeamMembers_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_CotactUs]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_CotactUs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[Subject] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_CotactUs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Customer_Address]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Customer_Address](
	[id_CAddress] [int] IDENTITY(1,1) NOT NULL,
	[id_Customer] [int] NOT NULL,
	[ID_Shahr] [int] NOT NULL,
	[C_AddressHint] [nvarchar](max) NOT NULL,
	[C_FullAddress] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Customer_Address] PRIMARY KEY CLUSTERED 
(
	[id_CAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Customer_Favorites]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Customer_Favorites](
	[CustomerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Customer_Main]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Customer_Main](
	[id_Customer] [int] IDENTITY(1,1) NOT NULL,
	[C_regDate] [datetime] NOT NULL,
	[C_Mobile] [nvarchar](max) NOT NULL,
	[C_FirstName] [nvarchar](max) NULL,
	[C_LastNAme] [nvarchar](max) NULL,
	[C_Description] [nvarchar](max) NULL,
	[C_ISActivate] [int] NULL,
	[C_ActivationToken] [int] NULL,
	[C_ActivateDate] [datetime] NULL,
	[C_Password] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Customer_Main] PRIMARY KEY CLUSTERED 
(
	[id_Customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Enum_Shahr]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Enum_Shahr](
	[ID_Shahr] [int] NULL,
	[Shahr_Name] [nvarchar](max) NULL,
	[Shahr_OstanConnection] [int] NULL,
	[Ostan_name] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_FACTOR_Items]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FACTOR_Items](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Pro_Id] [int] NULL,
	[number] [int] NULL,
	[PriceDateId] [int] NULL,
	[FactorId] [int] NULL,
 CONSTRAINT [PK_tbl_FACTOR_Items] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_FACTOR_Main]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FACTOR_Main](
	[Factor_Id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_Id] [int] NULL,
	[AddressId] [int] NULL,
	[date] [datetime] NULL,
	[Off_Code] [nvarchar](max) NULL,
	[toality] [bigint] NULL,
	[deposit_price] [bigint] NULL,
	[IsDeleted] [tinyint] NULL,
	[delete_by_Id] [int] NULL,
	[delete_UserType] [tinyint] NULL,
	[EditedFactorId] [int] NULL,
	[EditedByUserId] [int] NULL,
	[Done] [tinyint] NULL,
	[PaymentSerial] [nvarchar](max) NULL,
	[PaymentToken] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_FACTOR_Main] PRIMARY KEY CLUSTERED 
(
	[Factor_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product](
	[id_MProduct] [int] IDENTITY(1,1) NOT NULL,
	[IS_AVAILABEL] [tinyint] NOT NULL,
	[id_CreatedByAdmin] [int] NOT NULL,
	[id_DraftLevel] [int] NULL,
	[id_Type] [int] NOT NULL,
	[id_MainCategory] [int] NOT NULL,
	[id_SubCategory] [int] NOT NULL,
	[idMPC_WhichTomainPrice] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[DateCreated] [datetime] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Seo_Description] [nvarchar](max) NOT NULL,
	[Seo_KeyWords] [nvarchar](max) NOT NULL,
	[IS_AD] [tinyint] NOT NULL,
	[Search_Gravity] [int] NOT NULL,
	[Is_IntheDraft] [tinyint] NOT NULL,
	[ISDELETE] [tinyint] NOT NULL,
 CONSTRAINT [PK_tbl_Product] PRIMARY KEY CLUSTERED 
(
	[id_MProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Comment]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[ProductId] [int] NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_ProductComment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_ConnectorSCOK_Product]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_ConnectorSCOK_Product](
	[id_MProduct] [int] NOT NULL,
	[id_SCOK] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_connectorToMPC_SCOV]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_connectorToMPC_SCOV](
	[id_MPC] [int] NOT NULL,
	[id_SCOV] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_MainCategory]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_MainCategory](
	[id_MC] [int] IDENTITY(1,1) NOT NULL,
	[id_PT] [int] NOT NULL,
	[MCName] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_MainCategory] PRIMARY KEY CLUSTERED 
(
	[id_MC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_MainStarTags]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_MainStarTags](
	[id_MainStarTag] [int] IDENTITY(1,1) NOT NULL,
	[MST_Description] [nvarchar](max) NOT NULL,
	[MST_Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_MainStarTags] PRIMARY KEY CLUSTERED 
(
	[id_MainStarTag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_MoneyType]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_MoneyType](
	[MoneyId] [int] IDENTITY(1,1) NOT NULL,
	[MoneyTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Product_MoneyType] PRIMARY KEY CLUSTERED 
(
	[MoneyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_OffType]    Script Date: 5/7/2020 7:41:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_OffType](
	[OffType] [int] NOT NULL,
	[OffType_Description] [nvarchar](max) NOT NULL,
	[OffType_Symbol] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_OffType] PRIMARY KEY CLUSTERED 
(
	[OffType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Opinion]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Opinion](
	[id_Opinion] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[id_Customer] [int] NOT NULL,
	[id_AccByAdmin] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[DateAccepted] [datetime] NULL,
	[Is_Accepted] [tinyint] NOT NULL,
	[OpinionDescription] [nvarchar](max) NOT NULL,
	[Rate] [int] NOT NULL,
	[ISDELETE] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_PastProductHistory]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PastProductHistory](
	[id_PPH] [int] IDENTITY(1,1) NOT NULL,
	[id_MPC] [int] NOT NULL,
	[PriceXquantity] [bigint] NOT NULL,
	[PricePerquantity] [bigint] NOT NULL,
	[PriceOff] [bigint] NULL,
	[OffType] [int] NULL,
	[id_MainStarTag] [int] NOT NULL,
	[ChangedDate] [datetime] NOT NULL,
	[OffTypeValue] [bigint] NULL,
 CONSTRAINT [PK_tbl_Product_PastProductHistory] PRIMARY KEY CLUSTERED 
(
	[id_PPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Pic]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Pic](
	[PicID] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[BigPicAddress] [nvarchar](max) NOT NULL,
	[ThumbnailPicAddress] [nvarchar](max) NOT NULL,
	[ISDELETE] [tinyint] NULL,
	[alt] [nvarchar](max) NULL,
	[uploadPicName] [nvarchar](max) NULL,
	[Descriptions] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Product_Pic] PRIMARY KEY CLUSTERED 
(
	[PicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_PriceShow]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PriceShow](
	[PriceShowId] [int] IDENTITY(1,1) NOT NULL,
	[PriceShowformat] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Product_PriceShow] PRIMARY KEY CLUSTERED 
(
	[PriceShowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_ProductQuantityType]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_ProductQuantityType](
	[id_PQT] [int] IDENTITY(1,1) NOT NULL,
	[PQT_Description] [nvarchar](max) NULL,
	[PQT_Demansion] [nvarchar](10) NOT NULL,
	[PQT_Quantom] [int] NOT NULL,
 CONSTRAINT [PK_tbl_Product_ProductQuantityType] PRIMARY KEY CLUSTERED 
(
	[id_PQT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Reply]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Reply](
	[RepId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[ProductId] [int] NULL,
	[CommentId] [int] NULL,
	[date] [datetime] NULL,
 CONSTRAINT [PK_ProductReply] PRIMARY KEY CLUSTERED 
(
	[RepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_SubCategory]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_SubCategory](
	[id_SC] [int] IDENTITY(1,1) NOT NULL,
	[id_MC] [int] NOT NULL,
	[SCName] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_SubCategory] PRIMARY KEY CLUSTERED 
(
	[id_SC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_SubCategoryOptionKey]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_SubCategoryOptionKey](
	[id_SCOK] [int] IDENTITY(1,1) NOT NULL,
	[id_SC] [int] NOT NULL,
	[SCOKName] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_SubCategoryKey] PRIMARY KEY CLUSTERED 
(
	[id_SCOK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_SubCategoryOptionValue]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_SubCategoryOptionValue](
	[id_SCOV] [int] IDENTITY(1,1) NOT NULL,
	[id_SCOK] [int] NOT NULL,
	[SCOVValueName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_SubCategoryOptionValue] PRIMARY KEY CLUSTERED 
(
	[id_SCOV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_tagConnector]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_tagConnector](
	[id_MPC] [int] NOT NULL,
	[id_TE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_TagEnums]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_TagEnums](
	[id_TE] [int] IDENTITY(1,1) NOT NULL,
	[TE_name] [nvarchar](max) NOT NULL,
	[SubCatId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_Product_TagEnums] PRIMARY KEY CLUSTERED 
(
	[id_TE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_tblOptions]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_tblOptions](
	[id_Op] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[KeyName] [nvarchar](max) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_tblOptions] PRIMARY KEY CLUSTERED 
(
	[id_Op] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Type]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Type](
	[id_PT] [int] IDENTITY(1,1) NOT NULL,
	[PTname] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_Type] PRIMARY KEY CLUSTERED 
(
	[id_PT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SecurityQuestionEnums]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SecurityQuestionEnums](
	[idSecurityQuestion] [int] IDENTITY(1,1) NOT NULL,
	[Question] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_SecurityQuestionEnums] PRIMARY KEY CLUSTERED 
(
	[idSecurityQuestion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SecurityQuestionUserAns]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SecurityQuestionUserAns](
	[id_User] [int] NOT NULL,
	[userTypesID] [int] NOT NULL,
	[idSecurityQuestion] [int] NOT NULL,
	[userANS] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_APIvals]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_APIvals](
	[sms_irUserAPIKey] [nvarchar](max) NULL,
	[sms_irSecretKey] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_CustomerKeys]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_CustomerKeys](
	[sms_irSentKeyID] [int] IDENTITY(1,1) NOT NULL,
	[id_Customer] [int] NOT NULL,
	[sms_irKeyType] [int] NULL,
	[sms_irSentKey] [nvarchar](max) NULL,
	[sms_irKeyGeneratedDate] [datetime] NULL,
	[sms_irIsKeyAlive] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_KeyTypes]    Script Date: 5/7/2020 7:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_KeyTypes](
	[sms_irKeyType] [int] IDENTITY(1,1) NOT NULL,
	[sms_irKeyTypeName] [nvarchar](max) NULL,
	[sms_irKeyTypeAliveTimer] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_LOG]    Script Date: 5/7/2020 7:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_LOG](
	[id_Customer] [int] IDENTITY(1,1) NOT NULL,
	[sms_irLogID] [int] NOT NULL,
	[sms_irMessageType] [int] NULL,
	[sms_irMessage] [nvarchar](max) NULL,
	[sms_irSendDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_Template]    Script Date: 5/7/2020 7:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_Template](
	[sms_irTemplate] [int] IDENTITY(1,1) NOT NULL,
	[sms_irMessageType] [int] NULL,
	[sms_irTemplateAPIKey] [int] NULL,
	[TemplatePandaToken] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_irMessageType]    Script Date: 5/7/2020 7:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_irMessageType](
	[sms_irMessageType] [int] IDENTITY(1,1) NOT NULL,
	[sms_irMessageTypeName] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_UserController_UserTypes]    Script Date: 5/7/2020 7:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UserController_UserTypes](
	[UserTypeID] [int] IDENTITY(1,1) NOT NULL,
	[UserTypeName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_UserController_UserTypes] PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Product_MainProductConnector]    Script Date: 5/7/2020 7:41:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Product_MainProductConnector](
	[id_MPC] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PriceXquantity] [bigint] NOT NULL,
	[PricePerquantity] [bigint] NOT NULL,
	[PriceOff] [bigint] NULL,
	[offTypeValue] [bigint] NULL,
	[OffType] [int] NULL,
	[id_MainStarTag] [int] NOT NULL,
	[ISDELETE] [tinyint] NULL,
	[OutOfStock] [tinyint] NULL,
	[id_PQT] [int] NULL,
	[DateToRelease] [datetime] NULL,
	[PriceModule] [int] NULL,
	[PriceShow] [int] NULL,
	[describtion] [nvarchar](max) NULL,
 CONSTRAINT [PK_tlb_Product_ConnectorToMainProductID] PRIMARY KEY CLUSTERED 
(
	[id_MPC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [PandaMarketCMS] SET  READ_WRITE 
GO
