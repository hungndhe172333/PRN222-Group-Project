
GO
/****** Object:  Table [dbo].[About]    Script Date: 1/19/2025 10:24:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[About](
	[AboutId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NULL,
	[ImageURL] [varchar](255) NULL,
	[Content] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[AboutId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bill]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill](
	[bill_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NOT NULL,
	[total] [money] NOT NULL,
	[payment] [varchar](250) NOT NULL,
	[address] [ntext] NOT NULL,
	[date] [date] NOT NULL,
	[phone] [bigint] NOT NULL,
 CONSTRAINT [PK_bill] PRIMARY KEY CLUSTERED 
(
	[bill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bill_detail]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill_detail](
	[detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[bill_id] [bigint] NOT NULL,
	[product_id] [varchar](100) NOT NULL,
	[quantity] [int] NOT NULL,
	[size] [nchar](10) NOT NULL,
	[color] [nvarchar](150) NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_bill_detail] PRIMARY KEY CLUSTERED 
(
	[detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[brand]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brand](
	[brand_id] [int] IDENTITY(1,1) NOT NULL,
	[brand_name] [nvarchar](255) NOT NULL,
	[brand_description] [nvarchar](max) NULL,
	[brand_country] [nvarchar](100) NULL,
	[brand_logo] [varchar](255) NULL,
 CONSTRAINT [PK_brand] PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bundle_detail]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bundle_detail](
	[bundle_id] [bigint] NOT NULL,
	[product_id] [varchar](100) NOT NULL,
 CONSTRAINT [PK_bundle_detail] PRIMARY KEY CLUSTERED 
(
	[bundle_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cart]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart](
	[cart_id] [bigint] NOT NULL,
	[product_id] [varchar](100) NOT NULL,
	[product_name] [varchar](255) NOT NULL,
	[product_img] [varchar](255) NOT NULL,
	[product_price] [float] NOT NULL,
	[total] [float] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_cart] PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[category]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](255) NULL,
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [varchar](100) NOT NULL,
	[category_id] [int] NOT NULL,
	[product_name] [nvarchar](max) NOT NULL,
	[product_price] [money] NOT NULL,
	[product_describe] [nvarchar](max) NOT NULL,
	[quantity] [int] NOT NULL,
	[img] [nvarchar](50) NOT NULL,
	[brand_id] [int] NULL,
	[warranty_months] [int] NULL,
	[technical_specs] [nvarchar](max) NULL,
	[model_number] [varchar](100) NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_active]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_active](
	[product_id] [varchar](100) NOT NULL,
	[active] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_bundle]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_bundle](
	[bundle_id] [bigint] IDENTITY(1,1) NOT NULL,
	[bundle_name] [nvarchar](255) NOT NULL,
	[bundle_description] [nvarchar](max) NULL,
	[discount_percentage] [decimal](5, 2) NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
 CONSTRAINT [PK_product_bundle] PRIMARY KEY CLUSTERED 
(
	[bundle_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_color]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_color](
	[product_id] [varchar](100) NOT NULL,
	[color] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_comment]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_comment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [varchar](100) NULL,
	[user_id] [bigint] NULL,
	[created_at] [datetime] NULL,
	[Rating] [int] NULL,
	[comment] [nvarchar](255) NULL,
	[user_name] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_saleOFF]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_saleOFF](
	[sale_id] [int] NOT NULL,
	[product_id] [varchar](100) NULL,
	[discount_percentage] [decimal](5, 2) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[sale_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_size]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_size](
	[product_id] [varchar](100) NOT NULL,
	[size] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[repair_request]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[repair_request](
	[request_id] [bigint] IDENTITY(1,1) NOT NULL,
	[warranty_id] [bigint] NOT NULL,
	[user_id] [bigint] NOT NULL,
	[request_date] [datetime] NOT NULL,
	[problem_description] [nvarchar](max) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[technician_note] [nvarchar](max) NULL,
	[estimated_cost] [money] NULL,
	[completion_date] [datetime] NULL,
 CONSTRAINT [PK_repair_request] PRIMARY KEY CLUSTERED 
(
	[request_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[report]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[report](
	[id_report] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [bigint] NULL,
	[content_report] [nvarchar](max) NULL,
	[subject_report] [nvarchar](255) NULL,
	[user_email] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_report] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shipping]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shipping](
	[shipping_id] [bigint] IDENTITY(1,1) NOT NULL,
	[bill_id] [bigint] NOT NULL,
	[shipping_method] [nvarchar](100) NOT NULL,
	[shipping_status] [nvarchar](50) NOT NULL,
	[tracking_number] [varchar](100) NULL,
	[estimated_delivery_date] [date] NULL,
	[actual_delivery_date] [date] NULL,
	[shipping_fee] [money] NOT NULL,
	[shipping_address] [nvarchar](max) NOT NULL,
	[receiver_name] [nvarchar](200) NOT NULL,
	[receiver_phone] [varchar](20) NOT NULL,
 CONSTRAINT [PK_shipping] PRIMARY KEY CLUSTERED 
(
	[shipping_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[technical_specifications]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[technical_specifications](
	[spec_id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_id] [varchar](100) NOT NULL,
	[spec_name] [nvarchar](100) NOT NULL,
	[spec_value] [nvarchar](255) NOT NULL,
	[spec_group] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_technical_specifications] PRIMARY KEY CLUSTERED 
(
	[spec_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transaction_history]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transaction_history](
	[transaction_id] [bigint] IDENTITY(1,1) NOT NULL,
	[bill_id] [bigint] NULL,
	[user_id] [bigint] NOT NULL,
	[transaction_type] [nvarchar](50) NOT NULL,
	[amount] [money] NOT NULL,
	[transaction_date] [datetime] NOT NULL,
	[payment_method] [nvarchar](100) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[reference_number] [varchar](100) NULL,
	[description] [nvarchar](max) NULL,
 CONSTRAINT [PK_transaction_history] PRIMARY KEY CLUSTERED 
(
	[transaction_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[user_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_name] [nvarchar](200) NULL,
	[user_email] [varchar](255) NOT NULL,
	[user_pass] [nvarchar](255) NOT NULL,
	[isAdmin] [nvarchar](50) NULL,
	[dateOfBirth] [varchar](255) NULL,
	[address] [varchar](255) NULL,
	[phoneNumber] [varchar](10) NULL,
	[banned] [bit] NULL,
	[adminReason] [nvarchar](50) NULL,
	[isStoreStaff] [nvarchar](50) NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[warranty]    Script Date: 1/19/2025 10:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[warranty](
	[warranty_id] [bigint] IDENTITY(1,1) NOT NULL,
	[product_id] [varchar](100) NOT NULL,
	[bill_id] [bigint] NOT NULL,
	[warranty_start_date] [date] NOT NULL,
	[warranty_end_date] [date] NOT NULL,
	[serial_number] [varchar](100) NOT NULL,
	[warranty_status] [nvarchar](50) NOT NULL,
	[warranty_note] [nvarchar](max) NULL,
 CONSTRAINT [PK_warranty] PRIMARY KEY CLUSTERED 
(
	[warranty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[About] ON 

INSERT [dbo].[About] ([AboutId], [Title], [ImageURL], [Content]) VALUES (12, N'Câu chuyện You&Me', N'images/about3.jpg', N'You and Me là một cửa hàng quần áo nhỏ nằm trên con phố nhộn nhịp của thành phố. Được thành lập bởi đôi bạn thân từ thời đại học, cửa hàng này mang đậm phong cách thời trang cá nhân của họ. Với sứ mệnh mang đến sự tự tin và thoải mái cho khách hàng, You and Me tập trung vào việc cung cấp những bộ trang phục trẻ trung, hiện đại và độc đáo. Mỗi chiếc áo, chiếc váy đều được chọn lọc kỹ càng từ các nhà thiết kế uy tín. Cửa hàng còn nổi bật với dịch vụ tư vấn thời trang nhiệt tình và chuyên nghiệp, giúp khách hàng tìm được phong cách riêng. Chính sự tâm huyết và tình bạn bền chặt đã tạo nên thành công của You and Me.')
INSERT [dbo].[About] ([AboutId], [Title], [ImageURL], [Content]) VALUES (13, N'Giới thiệu', N'images/about2.jpg', N'Các sản phẩm phong phú từ các bộ sưu tập thời trang cho nam, nữ và trẻ em.  Điểm nổi bật của You&Me:  Chất lượng sản phẩm: You&Me cam kết mang đến những sản phẩm quần áo được làm từ chất liệu cao cấp, bền đẹp và thoải mái cho người mặc.  Phong cách đa dạng: Cửa hàng có các bộ sưu tập thời trang phong phú, từ phong cách cổ điển, thanh lịch đến hiện đại, cá tính, phù hợp với nhiều đối tượng khách hàng.  Dịch vụ khách hàng: You&Me luôn đặt khách hàng lên hàng đầu, với đội ngũ nhân viên thân thiện, nhiệt tình và chuyên nghiệp, sẵn sàng hỗ trợ và tư vấn khách hàng trong quá trình mua sắm.  Chính sách đổi trả: Với chính sách đổi trả linh hoạt, khách hàng có thể yên tâm mua sắm và đổi trả sản phẩm dễ dàng nếu không hài lòng.  Giá cả hợp lý: Cửa hàng luôn có các chương trình khuyến mãi hấp dẫn và giá cả cạnh tranh, mang đến giá trị tốt nhất cho khách hàng.  Các sản phẩm chính tại You&Me:  Quần áo nam: áo sơ mi, áo thun, quần jeans, quần kaki, áo khoác, vest,... Quần áo nữ: váy, đầm, áo thun, áo sơ mi, quần jeans, châ')
SET IDENTITY_INSERT [dbo].[About] OFF
GO
SET IDENTITY_INSERT [dbo].[bill] ON 

INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (45, 5, 648000.0000, N'MOMO', N'Tiền Hải,Thái Bình', CAST(N'2024-05-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (46, 5, 298000.0000, N'MOMO', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (47, 5, 378000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (48, 5, 270000.0000, N'Chua thanh toán (VNPAY)', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (49, 5, 417000.0000, N'Chua thanh toán (VNPAY)', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (50, 5, 567000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (51, 5, 278000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-04' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (52, 5, 189000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (53, 5, 259000.0000, N'MOMO', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (54, 5, 270000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (55, 5, 259000.0000, N'MOMO', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (56, 5, 810000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (57, 5, 149000.0000, N'MOMO', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (58, 5, 417000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (59, 5, 149000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (60, 5, 517000.0000, N'MOMO', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (61, 5, 139000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (62, 13, 2750000.0000, N'MOMO', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (63, 13, 2880000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (64, 1, 240000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (65, 1, 169000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (66, 1, 210000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (67, 1, 1450000.0000, N'VNPAY', N'Thái Bình', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (68, 16, 600000.0000, N'COD', N'Thái Bình', CAST(N'2024-06-05' AS Date), 98272722)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (69, 1, 150000.0000, N'MOMO', N'daihocfpt', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (70, 17, 298000.0000, N'MOMO', N'daihocfpt', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (71, 17, 1240000.0000, N'COD', N'daihocfpt', CAST(N'2024-06-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (73, 17, 100000.0000, N'COD', N'Ha Noi', CAST(N'2024-05-05' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (74, 14, 120000.0000, N'MOMO', N'Thai Binh', CAST(N'2024-06-14' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (75, 5, 150000.0000, N'MOMO', N'Thai Binh', CAST(N'2024-06-14' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (76, 5, 60000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-14' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (77, 8, 398000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-19' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (78, 1, 25000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-22' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (79, 1, 420000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-23' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (80, 1, 300000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-23' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (81, 1, 644000.0000, N'COD', N'hhhh', CAST(N'2024-06-23' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (82, 1, 199000.0000, N'VNPAY', N'hhhh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (83, 1, 250000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (84, 1, 349000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (85, 1, 420000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (86, 1, 290000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (87, 1, 544000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (88, 1, 259000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (89, 1, 877000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-25' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (90, 1, 300000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (91, 1, 60000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (92, 1, 60000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (93, 1, 300000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (94, 1, 300000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (95, 1, 300000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (96, 10, 300000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-06-26' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (97, 13, 300000.0000, N'COD', N'Thai Binh', CAST(N'2024-06-28' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (98, 10, 599000.0000, N'COD', N'ha noi', CAST(N'2024-07-01' AS Date), 348956375)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (99, 10, 99000.0000, N'VNPAY', N'ha noi', CAST(N'2024-07-01' AS Date), 348956375)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (100, 10, 290000.0000, N'VNPAY', N'thai binh', CAST(N'2024-07-01' AS Date), 348956375)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (101, 10, 169000.0000, N'VNPAY', N'thai binh', CAST(N'2024-07-01' AS Date), 348956375)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (102, 15, 290000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-07-09' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (103, 15, 300003.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-07-09' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (104, 13, 429000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-07-09' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (105, 14, 25000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-07-10' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (106, 16, 300003.0000, N'COD', N'Thai Binh', CAST(N'2024-07-11' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (107, 16, 278000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-07-11' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (108, 18, 700000.0000, N'COD', N'Thai Binh', CAST(N'2024-07-11' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (109, 17, 1000000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-07-19' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (110, 13, 599000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-07-22' AS Date), 348956373)
INSERT [dbo].[bill] ([bill_id], [user_id], [total], [payment], [address], [date], [phone]) VALUES (111, 13, 2600000.0000, N'VNPAY', N'Thai Binh', CAST(N'2024-07-26' AS Date), 348956373)
SET IDENTITY_INSERT [dbo].[bill] OFF
GO
SET IDENTITY_INSERT [dbo].[bill_detail] ON 

INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (40, 45, N'T2129', 1, N'XS        ', N'White', 270000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (41, 45, N'T2099', 2, N'S         ', N'Purple', 378000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (42, 46, N'AT533', 2, N'S         ', N'White', 298000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (43, 47, N'T2099', 2, N'L         ', N'Purple', 378000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (44, 48, N'T2129', 1, N'XS        ', N'White', 270000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (45, 49, N'AT536', 3, N'S         ', N'Red', 417000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (46, 50, N'T2099', 3, N'S         ', N'Purple', 567000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (47, 51, N'AT536', 2, N'S         ', N'Red', 278000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (48, 52, N'T2099', 1, N'S         ', N'Purple', 189000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (49, 53, N'T2127', 1, N'L         ', N'Black', 259000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (50, 54, N'T2129', 1, N'XS        ', N'White', 270000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (51, 55, N'T2128', 1, N'XS        ', N'White', 259000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (52, 56, N'T2129', 3, N'XS        ', N'White', 810000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (53, 57, N'AT533', 1, N'S         ', N'White', 149000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (54, 58, N'AT536', 3, N'S         ', N'Red', 417000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (55, 59, N'AT533', 1, N'S         ', N'White', 149000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (56, 60, N'T2099', 2, N'S         ', N'Purple', 378000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (57, 60, N'AT536', 1, N'L         ', N'Red', 139000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (58, 61, N'AT536', 1, N'S         ', N'Red', 139000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (59, 62, N'H1004', 3, N'S         ', N'Brown', 510000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (60, 62, N'S1203', 4, N'S         ', N'White', 2240000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (61, 63, N'T2130', 12, N'S         ', N'Grey', 2880000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (62, 64, N'T2130', 1, N'S         ', N'Grey', 240000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (63, 65, N'TD509', 1, N'S         ', N'Purple', 169000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (64, 66, N'SW6002', 1, N'S         ', N'Black', 210000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (65, 67, N'T3000', 5, N'S         ', N'Black', 1450000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (66, 68, N'AS8004', 10, N'S         ', N'White', 600000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (67, 69, N'AS8000', 1, N'S         ', N'Green', 150000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (68, 70, N'AT533', 2, N'S         ', N'Black', 298000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (69, 71, N'SW6000', 2, N'S         ', N'Red', 340000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (70, 71, N'AS8001', 3, N'S         ', N'Black', 900000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (71, 74, N'AS8004', 2, N'S         ', N'White', 120000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (72, 75, N'AS8000', 1, N'S         ', N'Green', 150000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (73, 76, N'AS8004', 1, N'S         ', N'White', 60000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (74, 77, N'S1201', 2, N'S         ', N'White', 398000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (75, 78, N'T2130', 1, N'S         ', N'Grey', 25000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (76, 79, N'SW6003', 1, N'S         ', N'Yellow', 420000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (77, 80, N'AS8001', 1, N'S         ', N'Black', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (78, 81, N'SW6009', 1, N'S         ', N'Blue', 644000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (79, 82, N'S1201', 1, N'S         ', N'White', 199000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (80, 83, N'T2131', 1, N'L         ', N'Grey', 250000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (81, 84, N'S4007', 1, N'S         ', N'White', 349000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (82, 85, N'SW6003', 1, N'S         ', N'Yellow', 420000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (83, 86, N'T3000', 1, N'S         ', N'Black', 290000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (84, 87, N'SW6007', 1, N'S         ', N'Blue', 544000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (85, 88, N'T2127', 1, N'L         ', N'Black', 259000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (86, 89, N'SW6008', 1, N'S         ', N'Blue', 544000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (87, 89, N'SA7002', 1, N'S         ', N'Blue', 333000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (88, 90, N'AS8001', 1, N'S         ', N'Black', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (89, 91, N'AS8004', 1, N'S         ', N'White', 60000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (90, 92, N'AS8004', 1, N'S         ', N'White', 60000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (91, 93, N'AS8001', 1, N'S         ', N'Black', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (92, 94, N'AS8001', 1, N'S         ', N'Black', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (93, 95, N'AS8001', 1, N'S         ', N'Black', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (94, 96, N'AS8001', 1, N'S         ', N'Black', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (95, 97, N'AS8001', 1, N'S         ', N'Black', 300000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (96, 98, N'H1002', 1, N'S         ', N'Green', 599000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (97, 99, N'PL1', 1, N'S         ', N'PINK', 99000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (98, 100, N'L1', 1, N'M         ', N'Black', 290000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (99, 101, N'TD509', 1, N'S         ', N'Purple', 169000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (100, 102, N'L11', 1, N'M         ', N'Black', 290000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (101, 103, N'AS8001', 1, N'S         ', N'Black', 300003.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (102, 104, N'AT536', 1, N'S         ', N'Red', 139000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (103, 104, N'T3000', 1, N'S         ', N'Black', 290000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (104, 105, N'T2130', 1, N'S         ', N'Grey', 25000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (105, 106, N'AS8001', 1, N'S         ', N'Black', 300003.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (106, 107, N'AT536', 2, N'S         ', N'Red', 278000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (107, 108, N'H1', 2, N'XL        ', N'Black', 700000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (108, 109, N'S4002', 2, N'S         ', N'White', 1000000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (109, 110, N'H1002', 1, N'S         ', N'Green', 599000.0000)
INSERT [dbo].[bill_detail] ([detail_id], [bill_id], [product_id], [quantity], [size], [color], [price]) VALUES (110, 111, N'v1', 2, N'M         ', N'Black', 2600000.0000)
SET IDENTITY_INSERT [dbo].[bill_detail] OFF
GO
SET IDENTITY_INSERT [dbo].[brand] ON 

INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (1, N'Brand A', N'High-quality electronics', N'USA', N'logo_a.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (2, N'Brand B', N'Innovative tech gadgets', N'Japan', N'logo_b.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (3, N'Brand C', N'Affordable home appliances', N'Germany', N'logo_c.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (4, N'Brand D', N'Premium smartphones', N'South Korea', N'logo_d.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (5, N'Brand E', N'Sporting goods and apparel', N'China', N'logo_e.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (6, N'Brand F', N'Luxury watches and accessories', N'Switzerland', N'logo_f.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (7, N'Brand G', N'Eco-friendly products', N'Canada', N'logo_g.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (8, N'Brand H', N'Stylish fashion wear', N'Italy', N'logo_h.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (9, N'Brand I', N'Home furniture and decor', N'USA', N'logo_i.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (10, N'Brand J', N'Beauty and skincare products', N'France', N'logo_j.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (11, N'Brand K', N'Gaming consoles and accessories', N'UK', N'logo_k.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (12, N'Brand L', N'Musical instruments', N'USA', N'logo_l.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (13, N'Brand M', N'Pet supplies and accessories', N'Australia', N'logo_m.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (14, N'Brand N', N'Car parts and accessories', N'Germany', N'logo_n.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (15, N'Brand O', N'Outdoor gear and equipment', N'New Zealand', N'logo_o.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (16, N'Brand P', N'Portable electronics', N'South Korea', N'logo_p.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (17, N'Brand Q', N'Kitchen appliances', N'China', N'logo_q.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (18, N'Brand R', N'Educational toys and games', N'Japan', N'logo_r.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (19, N'Brand S', N'Health and fitness equipment', N'USA', N'logo_s.png')
INSERT [dbo].[brand] ([brand_id], [brand_name], [brand_description], [brand_country], [brand_logo]) VALUES (20, N'Brand T', N'DIY tools and accessories', N'UK', N'logo_t.png')
SET IDENTITY_INSERT [dbo].[brand] OFF
GO
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (1, N'H1')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (1, N'H2')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (1, N'H3')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (2, N'H4')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (2, N'H5')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (2, N'H6')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (3, N'H7')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (3, N'H8')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (3, N'H9')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (4, N'K10')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (4, N'K11')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (4, N'K12')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (5, N'K13')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (5, N'K14')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (5, N'K15')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (6, N'K16')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (6, N'K17')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (6, N'K18')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (7, N'K19')
INSERT [dbo].[bundle_detail] ([bundle_id], [product_id]) VALUES (7, N'K20')
GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([category_id], [category_name]) VALUES (1, N'ÁO SƠ MI')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (2, N'ÁO THUN')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (3, N'ÁO KHOÁC')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (4, N'ÁO HOODIES')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (5, N'QUẦN SHORT')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (6, N'GIÀY')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (14, N'ÁO LEN')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (15, N'ÁO POLO')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (16, N'QUẦN BÒ')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (17, N'ÁO VEST')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (18, N'ÁO BA LỖ')
INSERT [dbo].[category] ([category_id], [category_name]) VALUES (22, N'S')
SET IDENTITY_INSERT [dbo].[category] OFF
GO
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'AS8000', 6, N'Giầy Lười Cảnh đồ Du Lịch', 150000.0000, N'<p>Gi&agrave;y thể thao nam Mulgati Leather Sneaker - F23305 được l&agrave;m từ chất liệu da cao cấp. - Thiết kế form gi&agrave;y chuẩn đẹp, đường kh&acirc;u tinh tế, chắc chắn</p>
', 101, N'images/null', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'AS8001', 6, N'SNAKE', 300003.0000, N'<p>Gi&agrave;y thể thao nam Mulgati Leather Sneaker - F23305 được l&agrave;m từ chất liệu da cao cấp. - Thiết kế form gi&agrave;y chuẩn đẹp, đường kh&acirc;u tinh tế, chắc chắn - Đế gi&agrave;y được l&agrave;m từ cao su lưu h&oacute;a, độ bền cao - L&oacute;t gi&agrave;y &ecirc;m &aacute;i, gi&uacute;p ch&acirc;n lu&ocirc;n thoải m&aacute;i.</p>
', 92, N'images/AS8001.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'AS8004', 6, N'Dép unisex ', 60000.0000, N'<p>chất liệu da tho&aacute;ng m&aacute;t, &ecirc;m ch&acirc;n v&agrave; c&oacute; thể đi được nước. 🔸Form slim fit c&oacute; phần viền &ocirc;m dọc theo chiều d&agrave;i của ch&acirc;n gi&uacute;p t&ocirc;n d&aacute;ng v&agrave; thoải m&aacute;i</p>
', 186, N'images/AS8004.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'AT533', 2, N'Champion Graphic Big Logo T-Shirt', 149000.0000, N'<p>Cổ Tr&ograve;nVạt NgangTay NgắnH&igrave;nh In Trướ</p>
', 184, N'images/AT533.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'AT536', 2, N'Champion Change The World', 139000.0000, N'<p>Cổ Tr&ograve;nVạt NgangTay NgắnH&igrave;nh Th&ecirc;u Trước</p>
', 446, N'images/AT536.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H1', 4, N'hoodies 1', 350000.0000, N'hoodies 1', 698, N'images/hoodie1.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H10', 4, N'hoodies 10', 350000.0000, N'hoodies 10', 700, N'images/hoodie10.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H1001', 4, N'Áo hoodie động vật Bluza cắt dạ dày, nhân sư, động vật', 190000.0000, N'<p>Thiết kế trẻ trung,chất liệu vải si&ecirc;u mềm</p>
', 40, N'images/H1001.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H1002', 4, N'Áo hoodie đôi Navy ', 599000.0000, N'<p>&Aacute;o đ&ocirc;i gi&agrave;nh cho c&aacute;c cặp đ&ocirc;i,thiết kế thon gọn,trẻ trung,chất liệu vải cotton mang đến cho kh&aacute;ch h&agrave;ng cảm gi&aacute;c &ecirc;m &aacute;i</p>
', 498, N'images/H1002.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H1004', 4, N'Áo hoodie Loose Fit', 170000.0000, N'<p>In h&igrave;nh Loose Fit mang tới cảm gi&aacute;c trẻ trung</p>
', 273, N'images/H1004.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H1005', 4, N'Áo hoodie in hình Loose Fit', 249000.0000, N'<p>Phong c&aacute;ch thời thượng</p>
', 166, N'images/H1005.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H1006', 4, N'Áo hoodie Regular Fit', 299000.0000, N'<p>Thiết kế trẻ trung,ấm &aacute;p</p>
', 675, N'images/H1006.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H2', 4, N'hoodies 2', 350000.0000, N'hoodies 2', 700, N'images/hoodie2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H3', 4, N'hoodies 3', 350000.0000, N'hoodies 3', 700, N'images/hoodie3.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H4', 4, N'hoodies 4', 350000.0000, N'hoodies 4', 700, N'images/hoodie4.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H5', 4, N'hoodies 5', 350000.0000, N'hoodies 5', 700, N'images/hoodie5.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H6', 4, N'hoodies 6', 350000.0000, N'hoodies 6', 700, N'images/hoodie6.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H7', 4, N'hoodies 7', 350000.0000, N'hoodies 7', 700, N'images/hoodie7.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H8', 4, N'hoodies 8', 350000.0000, N'hoodies 8', 700, N'images/hoodie8.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'H9', 4, N'hoodies 9', 350000.0000, N'hoodies 9', 700, N'images/hoodie9.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'k1', 3, N'Khoac1', 299000.0000, N'k1', 900, N'images/k1.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K10', 3, N'Khoac10', 299000.0000, N'k10', 900, N'images/K10.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K11', 3, N'Khoac11', 299000.0000, N'k11', 900, N'images/K11.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K12', 3, N'Khoac12', 299000.0000, N'k12', 900, N'images/K12.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K13', 3, N'Khoac13', 299000.0000, N'k13', 900, N'images/K13.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K14', 3, N'Khoac14', 299000.0000, N'k14', 900, N'images/K14.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K15', 3, N'Khoac15', 299000.0000, N'k15', 900, N'images/K15.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K16', 3, N'Khoac16', 299000.0000, N'k16', 900, N'images/K16.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K17', 3, N'Khoac17', 299000.0000, N'k17', 900, N'images/K1.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K18', 3, N'Khoac18', 299000.0000, N'k18', 900, N'images/K2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K19', 3, N'Khoac19', 299000.0000, N'k19', 900, N'images/K2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K2', 3, N'Khoac2', 299000.0000, N'k2', 900, N'images/K2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K20', 3, N'Khoac20', 299000.0000, N'k20', 900, N'images/K2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K3', 3, N'Khoac3', 299000.0000, N'k3', 900, N'images/K3.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K4', 3, N'Khoac4', 299000.0000, N'k4', 900, N'images/K4.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K5', 3, N'Khoac5', 299000.0000, N'k5', 900, N'images/K5.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K6', 3, N'Khoac6', 299000.0000, N'k6', 900, N'images/K6.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K7', 3, N'Khoac7', 299000.0000, N'k7', 900, N'images/K7.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K8', 3, N'Khoac8', 299000.0000, N'k8', 900, N'images/K8.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'K9', 3, N'Khoac9', 299000.0000, N'k9', 900, N'images/K9.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L1', 14, N'len1', 290000.0000, N'len 1', 499, N'images/len1.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L10', 14, N'len10', 290000.0000, N'len 10', 500, N'images/len10.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L11', 14, N'len11', 290000.0000, N'len 11', 499, N'images/len11.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L2', 14, N'len2', 290000.0000, N'len 2', 500, N'images/len2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L3', 14, N'len3', 290000.0000, N'len 3', 500, N'images/len3.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L4', 14, N'len4', 290000.0000, N'len 4', 500, N'images/len4.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L5', 14, N'len5', 290000.0000, N'len 5', 500, N'images/len5.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L6', 14, N'len6', 290000.0000, N'len 6', 500, N'images/len6.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L7', 14, N'len7', 290000.0000, N'len 7', 500, N'images/len7.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L8', 14, N'len8', 290000.0000, N'len 8', 500, N'images/len8.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'L9', 14, N'len9', 290000.0000, N'len 9', 500, N'images/len9.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len12', 14, N'LEN12', 120000.0000, N'len12', 600, N'images/len12.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len13', 14, N'LEN13', 120000.0000, N'len13', 600, N'images/len13.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len14', 14, N'LEN14', 120000.0000, N'len14', 600, N'images/len14.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len15', 14, N'LEN15', 120000.0000, N'len15', 600, N'images/len15.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len16', 14, N'LEN16', 120000.0000, N'len16', 600, N'images/len16.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len17', 14, N'LEN17', 120000.0000, N'len17', 600, N'images/len17.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len18', 14, N'LEN18', 120000.0000, N'len18', 600, N'images/len18.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len19', 14, N'LEN19', 120000.0000, N'len19', 600, N'images/len19.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len20', 14, N'LEN20', 120000.0000, N'len20', 600, N'images/len20.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'len21', 14, N'LEN21', 120000.0000, N'len21', 600, N'images/len21.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL1', 15, N'Áo polo nam Bird', 99000.0000, N'<ul>
	<li><strong>Chất liệu:</strong>&nbsp;Thun c&aacute; sấu cotton lục gi&aacute;c. Chất mềm m&aacute;t, thấm mồ h&ocirc;i tốt, co gi&atilde;n 4 chiều</li>
</ul>
', 99, N'images/PL1.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL10', 15, N'Ok1', 120000.0000, N'SSS', 101, N'images/PL10.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL2', 15, N'Ok1', 120000.0000, N'SSS', 101, N'images/PL2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL3', 15, N'Ok1', 120000.0000, N'SSS', 101, N'images/PL3.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL4', 15, N'Ok1', 120000.0000, N'SSS', 101, N'images/PL4.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL5', 15, N'Ok1', 120000.0000, N'SSS', 101, N'images/PL5.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL6', 15, N'Ok1', 120000.0000, N'SSS', 101, N'images/PL6.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL7', 15, N'Ok1', 120000.0000, N'SSS', 101, N'images/PL7.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL8', 15, N'Ok1', 120000.0000, N'SSS', 101, N'images/PL8.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'PL9', 15, N'Ok1', 120000.0000, N'<p>SSS</p>
', 101, N'images/PL9.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS1', 5, N'Short1', 140000.0000, N's1', 499, N'images/QS1.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS10', 5, N'Short10', 140000.0000, N's10', 499, N'images/QS10.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS11', 5, N'Short11', 140000.0000, N's11', 499, N'images/QS11.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS12', 5, N'Short12', 140000.0000, N's12', 499, N'images/QS12.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS13', 5, N'Short13', 140000.0000, N's13', 499, N'images/QS13.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS14', 5, N'Short14', 140000.0000, N's14', 499, N'images/QS14.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS15', 5, N'Short15', 140000.0000, N's15', 499, N'images/QS15.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS16', 5, N'Short16', 140000.0000, N's16', 499, N'images/QS16.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS17', 5, N'Short17', 140000.0000, N's17', 499, N'images/QS17.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS18', 5, N'Short18', 140000.0000, N's18', 499, N'images/QS18.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS19', 5, N'Short19', 140000.0000, N's19', 499, N'images/QS19.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS2', 5, N'Short2', 140000.0000, N's2', 499, N'images/QS2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS20', 5, N'Short20', 140000.0000, N's20', 499, N'images/QS20.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS21', 5, N'Short21', 140000.0000, N's21', 499, N'images/QS21.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS22', 5, N'Short22', 140000.0000, N's22', 499, N'images/QS22.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS3', 5, N'Short3', 140000.0000, N's3', 499, N'images/QS3.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS4', 5, N'Short4', 140000.0000, N's4', 499, N'images/QS4.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS5', 5, N'Short5', 140000.0000, N's5', 499, N'images/QS5.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS6', 5, N'Short6', 140000.0000, N's6', 499, N'images/QS6.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS7', 5, N'Short7', 140000.0000, N's7', 499, N'images/QS7.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS8', 5, N'Short8', 140000.0000, N's8', 499, N'images/QS8.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'QS9', 5, N'Short9', 140000.0000, N's9', 499, N'images/QS9.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S1201', 5, N'Quần Short Kaki Big Size Navy', 199000.0000, N'<p>Sản phẩm c&oacute; đủ size từ 50kg-160kg. Form &ocirc;m. Chất vải Kaki th&agrave;nh phần cotton cao n&ecirc;n thoải m&aacute;i khi sử dụng</p>
', 263, N'images/S1200.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S1202', 5, N'QUẦN SHORT JEANS BIG SIZE LƯNG THUN NAVY', 430000.0000, N'<p>l&agrave;m từ chất liệu jeans, c&oacute; độ co gi&atilde;n tốt v&agrave; c&oacute; lưng thun rộng</p>
', 454, N'images/S1203.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S1203', 5, N'QUẦN JOGGER MLB BASIC', 560000.0000, N'Thiết kế độc đáo,trẻ trung', 440, N'images/S1204.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S4000', 15, N'DRACO POLO SHIRT', 250000.0000, N'<p>Chất liệu: Thun c&aacute; sấu 2 chiều, định lượng 230gsm. &Aacute;o thun polo cổ dệt m&agrave;u xanh tiffany, chất liệu d&agrave;y vừa phải kh&ocirc;ng cứng. Chi tiết rồng th&ecirc;u n&eacute;t nổi, chi tiết chữ LD th&ecirc;u x&ugrave; hoạ tiết. &Aacute;o phom rộng vừa, thiết kế unisex.</p>
', 456, N'images/S4000.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S4001', 1, N'LIDERISM CUBAN SHIRT', 690000.0000, N'<p>Chất liệu: Cotton polyester xốp.&Aacute;o sơ mi cổ ve lật, d&aacute;ng boxy, chất liệu đứng d&aacute;ng.Chi tiết t&uacute;i &aacute;o c&oacute; th&ecirc;u chữ nổi. &Aacute;o c&oacute; thiết kế unisex.</p>
', 6, N'images/S4001.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S4002', 1, N'LIDERISM CUBAN SHIRT', 500000.0000, N'<p>Chất liệu: Cotton polyester xốp. &Aacute;o sơ mi cổ ve lật, d&aacute;ng boxy, chất liệu đứng d&aacute;ng. Chi tiết t&uacute;i &aacute;o c&oacute; th&ecirc;u chữ nổi. &Aacute;o c&oacute; thiết kế unisex.</p>
', 6, N'images/S4002.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S4004', 1, N'NINTH SAREALM SHIRT', 700000.0000, N'<p>Chất liệu: Denim định lượng 12OZ d&agrave;y dặn. &Aacute;o sơ mi d&aacute;ng rộng, thiết kế unisex. &Aacute;o c&oacute; chi tiết tay &aacute;o c&oacute; thể th&aacute;o rời, được cố định bằng kho&aacute; zip -&gt; C&oacute; thể kết hợp như sơ mi tay ngắn hoặc tay d&agrave;i. Chi tiết n&oacute;n c&oacute; thể th&aacute;o rời, c&oacute; thể kết hợp c&ugrave;ng &aacute;o hoặc đội ri&ecirc;ng lẻ.</p>
', 9, N'images/S4004.png', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S4005', 1, N'LINEN CLASSIC SHIRT ', 215000.0000, N'<p>Chất liệu: Linen Bamboo - kết hợp sợi lanh v&agrave; sợi dệt từ c&acirc;y tre.&Aacute;o c&oacute; độ mềm, rũ, tho&aacute;ng m&aacute;t v&agrave; thấm h&uacute;t mồ h&ocirc;i tốt.&Aacute;o sơ mi tay d&agrave;i thiết kế unisex, d&aacute;ng d&agrave;i rộng.Chi tiết logo th&ecirc;u nổi th&acirc;n trước v&agrave; th&acirc;n sau &aacute;o.</p>
', 600, N'images/S4005.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S4006', 1, N'THEEIGHTH JERSEY SHIRT', 299000.0000, N'<p>Chất liệu: Polyester 2 da. &Aacute;o thun cổ ve lật, tay d&agrave;i raglan c&oacute; r&atilde; phối viền vải trắng. C&aacute;c chi tiết trước v&agrave; sau được in phồng. Cổ &aacute;o v&agrave; cổ tay bo dệt d&agrave;y dặn. &Aacute;o gồm size XS (d&aacute;ng cropped) v&agrave; size S-M-L (d&aacute;ng rộng oversized).</p>
', 700, N'images/S4006.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'S4007', 1, N'NECKLINE ZIPPED CROPPED SHIRT ', 349000.0000, N'<p>Chất liệu: Nỉ ch&acirc;n cua định lượng 400gsm d&agrave;y vừa.&Aacute;o sweatshirt d&aacute;ng ngắn, thiết kế unisex.Chi tiết cổ cao c&oacute; kho&aacute; k&eacute;o, c&oacute; thể tuỳ chỉnh cổ &aacute;o th&agrave;nh cổ lật hoặc cổ lọ.Gấu &aacute;o c&oacute; bo dệt bản 6cm d&agrave;y dặn.</p>
', 297, N'images/S4007.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SA7001', 15, N'Polo Basic 1', 233000.0000, N'<p>&Aacute;o polo đen trắng đẹp lắm</p>
', 600, N'images/SA7001.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SA7002', 15, N'Polo Basic 2', 333000.0000, N'<p>Polo X&aacute;m tho&aacute;ng m&aacute;t ph&ugrave; hợp với mọi hoạt động&nbsp;</p>
', 599, N'images/SA7002.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SA7003', 15, N'Polo Basic 3', 353000.0000, N'<p>&Aacute;o polo kẻ chất lượng cao&nbsp;</p>
', 600, N'images/SA7003.JPG', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SA7004', 15, N'Polo Basic 4', 153000.0000, N'<p>&Aacute;o polo đen cơ bản ph&ugrave; hợp mọi lứa tuổi&nbsp;</p>
', 600, N'images/SA7004.JPG', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SA7005', 15, N'Polo Basic 5', 264000.0000, N'<p>&Aacute;o polo trắng sang trọng&nbsp;</p>
', 600, N'images/SA7005.JPG', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SA7006', 15, N'Polo Basic 6', 244000.0000, N'<p>&Aacute;o polo x&aacute;m đầy nam t&iacute;nh&nbsp;</p>
', 600, N'images/SA7006.JPG', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM1', 1, N'SM1', 160000.0000, N'somi1', 900, N'images/SM1.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM10', 1, N'SM10', 160000.0000, N'somi10', 900, N'images/SM10.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM11', 1, N'SM11', 160000.0000, N'somi11', 900, N'images/SM11.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM12', 1, N'SM12', 160000.0000, N'somi12', 900, N'images/SM12.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM2', 1, N'SM2', 160000.0000, N'somi2', 900, N'images/SM2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM3', 1, N'SM3', 160000.0000, N'somi3', 900, N'images/SM3.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM4', 1, N'SM4', 160000.0000, N'somi4', 900, N'images/SM4.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM5', 1, N'SM5', 160000.0000, N'somi5', 900, N'images/SM5.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM6', 1, N'SM6', 160000.0000, N'somi6', 900, N'images/SM6.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM7', 1, N'SM7', 160000.0000, N'somi7', 900, N'images/SM7.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM8', 1, N'SM8', 160000.0000, N'somi8', 900, N'images/SM8.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SM9', 1, N'SM9', 160000.0000, N'somi9', 900, N'images/SM9.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'ST300', 2, N'Ao ST1', 300000.0000, N'<p>&Aacute;o d&agrave;i tay</p>
', 600, N'images/SW6001.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6000', 3, N'Áo Gió Red', 170000.0000, N'<p>Thiết kế sang trọng</p>
', 797, N'images/SW6000.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6001', 3, N'áo gió DEST', 400000.0000, N'<p>chất liệu da,ấm &aacute;p</p>
', 677, N'images/SW6001.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6002', 3, N'Áo phông Blazer ', 210000.0000, N'<p>Sang trọng</p>
', 699, N'images/SW6002.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6003', 3, N'Áo Khoác Màu Vàng', 420000.0000, N'<p>Thiết kế m&agrave;u sắc,y&ecirc;u đời</p>
', 653, N'images/SW6003.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6004', 3, N'Áo gió nam Uniqlo', 130000.0000, N'<p>Thiết kế đơn giản</p>
', 100, N'images/SW6004.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6005', 14, N'Áo len cơ bản 1', 444000.0000, N'<p>&Aacute;o l&ecirc;n d&agrave;y m&agrave; xanh dương với hoạt tiết bắt mắt</p>
', 600, N'images/SW6005.JPG', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6006', 14, N'Áo len cơ bản 2', 344000.0000, N'<p>&Aacute;o len đỏ đẹp nhở</p>
', 600, N'images/SW6006.JPG', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6007', 14, N'Áo len cơ bản 3', 544000.0000, N'<p>&Aacute;o len trắng với nhiều hoạt tiết đẹp</p>
', 199, N'images/SW6007.JPG', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6008', 14, N'Áo len cơ bản 4', 544000.0000, N'<p>&Aacute;o m&agrave;u xanh trời</p>
', 199, N'images/SW6008.JPG', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'SW6009', 14, N'Áo len cơ bản 5', 644000.0000, N'<p>&Aacute;o l&ecirc;n m&agrave;u xanh lục&nbsp;</p>
', 199, N'images/SW6009.JPG', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T10', 2, N'THUN10', 99000.0000, N't9', 500, N'images/T10.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T11', 2, N'THUN11', 99000.0000, N't10', 500, N'images/T11.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T12', 2, N'THUN12', 99000.0000, N't11', 500, N'images/T12.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T13', 2, N'THUN13', 99000.0000, N't12', 500, N'images/T13.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T14', 2, N'THUN14', 99000.0000, N't13', 500, N'images/T14.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T15', 2, N'THUN15', 99000.0000, N't14', 500, N'images/T15.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T16', 2, N'THUN16', 99000.0000, N't15', 500, N'images/T16.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T17', 2, N'THUN17', 99000.0000, N't16', 500, N'images/T17.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T18', 2, N'THUN18', 99000.0000, N't17', 500, N'images/T18.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2', 2, N'THUN2', 99000.0000, N't1', 500, N'images/T2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2099', 2, N'Áo Thun Polo Tay Ngắn Valentino Creations', 189000.0000, N'Chất liệu: thun cao cấp.Sản phẩm nhẹ, thoáng mát giúp người mặc luôn cảm thấy thoải mái.Thiết kế sang trọng, lịch lãm, dễ phối theo nhiều phong cách khác nhau', 69, N'images/T2099.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2106', 2, N'Shin-chan Tee', 229000.0000, N'<p>Chất liệu: thun cao cấp. Sản phẩm nhẹ, tho&aacute;ng m&aacute;t gi&uacute;p người mặc lu&ocirc;n cảm thấy thoải m&aacute;i. Thiết kế sang trọng, lịch l&atilde;m, dễ phối theo nhiều phong c&aacute;ch kh&aacute;c nhau.</p>
', 95, N'images/T2106.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2109', 2, N'Tie Dye Orange Mint Tee', 290000.0000, N'<p>Chất liệu: thun cao cấp. Sản phẩm nhẹ, tho&aacute;ng m&aacute;t gi&uacute;p người mặc lu&ocirc;n cảm thấy thoải m&aacute;i. Thiết kế sang trọng, lịch l&atilde;m, dễ phối theo nhiều phong c&aacute;ch kh&aacute;c nhau.</p>
', 75, N'images/T2109.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2119', 2, N'The Sun Tie Dye', 280000.0000, N'<p>Chất liệu: thun cao cấp. Sản phẩm nhẹ, tho&aacute;ng m&aacute;t gi&uacute;p người mặc lu&ocirc;n cảm thấy thoải m&aacute;i. Thiết kế sang trọng, lịch l&atilde;m, dễ phối theo nhiều phong c&aacute;ch kh&aacute;c nhau.</p>
', 82, N'images/T2119.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2127', 2, N'Fucking Awesome Tee In Black', 259000.0000, N'<p>Chất liệu: thun cao cấp. Sản phẩm nhẹ, tho&aacute;ng m&aacute;t gi&uacute;p người mặc lu&ocirc;n cảm thấy thoải m&aacute;i. Thiết kế sang trọng, lịch l&atilde;m, dễ phối theo nhiều phong c&aacute;ch kh&aacute;c nhau.</p>
', 93, N'images/T2127.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2128', 2, N'Fucking Awesome Tee', 259000.0000, N'<p>Chất liệu: thun cao cấp. Sản phẩm nhẹ, tho&aacute;ng m&aacute;t gi&uacute;p người mặc lu&ocirc;n cảm thấy thoải m&aacute;i. Thiết kế sang trọng, lịch l&atilde;m, dễ phối theo nhiều phong c&aacute;ch kh&aacute;c nhau.</p>
', 62, N'images/T2128.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2129', 2, N'I''m Not Psycho Tee', 270000.0000, N'<p>Sản phẩm nhẹ, tho&aacute;ng m&aacute;t gi&uacute;p người mặc lu&ocirc;n cảm thấy thoải m&aacute;i. Thiết kế sang trọng, lịch l&atilde;m, dễ phối theo nhiều phong c&aacute;ch kh&aacute;c nhau.</p>
', 102, N'images/T2129.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2130', 2, N'Acid Washed Dark', 25000.0000, N'<p>Sản phẩm nhẹ, tho&aacute;ng m&aacute;t gi&uacute;p người mặc lu&ocirc;n cảm thấy thoải m&aacute;i. Thiết kế sang trọng, lịch l&atilde;m, dễ phối theo nhiều phong c&aacute;ch kh&aacute;c nhau.</p>
', 285, N'images/T2130.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T2131', 2, N'Exceptional Tee With Distressed', 250000.0000, N'<p>Sản phẩm nhẹ, tho&aacute;ng m&aacute;t gi&uacute;p người mặc lu&ocirc;n cảm thấy thoải m&aacute;i. Thiết kế sang trọng, lịch l&atilde;m, dễ phối theo nhiều phong c&aacute;ch kh&aacute;c nhau.</p>
', 197, N'images/T2131.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T3', 2, N'THUN3', 99000.0000, N'<p>t2</p>
', 500, N'images/T3.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T3000', 2, N'T-shirt black', 290000.0000, N'<p>Thiết kế m&aacute;t mẻ,trẻ trung</p>
', 136, N'images/T3000.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T3132', 2, N'Ao T1', 300000.0000, N'<p>&Aacute;o Xịn N&egrave;</p>
', 600, N'images/T2132.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T4', 2, N'THUN4', 99000.0000, N't3', 500, N'images/T4.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T5', 2, N'THUN5', 99000.0000, N't4', 500, N'images/T5.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T6', 2, N'THUN6', 99000.0000, N't5', 500, N'images/T6.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T7', 2, N'THUN7', 99000.0000, N't6', 500, N'images/T7.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T8', 2, N'THUN8', 99000.0000, N't7', 500, N'images/T8.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'T9', 2, N'THUN9', 99000.0000, N't8', 500, N'images/T9.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'TD481', 14, N'''''Sinner'''' Sweater', 360000.0000, N'<p>Cổ Tr&ograve;n Vạt Ngang Tay D&agrave;i Bo H&igrave;nh In Mặt Trước V&agrave; Sau</p>
', 29, N'images/TD481.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'TD509', 14, N'Champion Sweater', 169000.0000, N'<p>Cổ Tr&ograve;n Vạt Ngang Tay D&agrave;i Bo H&igrave;nh Th&ecirc;u Trước</p>
', 445, N'images/TD509.png', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v1', 17, N'vest1', 1300000.0000, N'Áo vest nam cao cấp được thiết kế tinh tế, mang đến phong cách lịch lãm và sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải mái và bền bỉ qua thời gian.', 198, N'images/v1.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v10', 17, N'vest10', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v10.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v11', 17, N'vest11', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v11.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v12', 17, N'vest12', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v12.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v2', 17, N'vest2', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v2.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v3', 17, N'vest3', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v3.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v4', 17, N'vest4', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v4.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v5', 17, N'vest5', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v5.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v6', 17, N'vest6', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v6.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v7', 17, N'vest7', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v7.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v8', 17, N'vest8', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v8.jpg', NULL, NULL, NULL, NULL)
INSERT [dbo].[product] ([product_id], [category_id], [product_name], [product_price], [product_describe], [quantity], [img], [brand_id], [warranty_months], [technical_specs], [model_number]) VALUES (N'v9', 17, N'vest9', 1300000.0000, N'<p>&Aacute;o vest nam cao cấp được thiết kế tinh tế, mang đến phong c&aacute;ch lịch l&atilde;m v&agrave; sang trọng cho người mặc. Sản phẩm được may từ chất liệu vải cao cấp, đảm bảo sự thoải m&aacute;i v&agrave; bền bỉ qua thời gian.</p>
', 200, N'images/v9.jpg', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'AT536', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H1', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H10', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H1001', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H1002', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H1004', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H1005', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H1006', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'H9', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'k1', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K10', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K11', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K12', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K13', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K14', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K15', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K16', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K17', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K18', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K19', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K20', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'K9', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L1', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L10', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L11', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'L9', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len12', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len13', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len14', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len15', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len16', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len17', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len18', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len19', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len20', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'len21', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL1', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL10', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'PL9', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS1', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS10', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS11', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS12', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS13', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS14', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS15', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS16', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS17', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS18', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS19', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS20', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS21', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS22', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'QS9', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S1201', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S1202', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4000', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4001', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4002', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4004', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4005', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4006', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'S4007', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SA7001', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SA7002', N'True')
GO
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SA7005', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SA7006', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM1', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM10', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM11', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM12', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SM9', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'ST300', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'SW6000', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T10', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T11', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T12', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T13', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T14', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T15', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T16', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T17', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T18', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2106', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2109', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2119', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2127', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2128', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2129', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2130', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T2131', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T3000', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T3132', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'T9', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'TD481', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'TD509', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v1', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v10', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v11', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v12', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v2', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v3', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v4', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v5', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v6', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v7', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v8', N'True')
INSERT [dbo].[product_active] ([product_id], [active]) VALUES (N'v9', N'True')
GO
SET IDENTITY_INSERT [dbo].[product_bundle] ON 

INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (1, N'Summer Sale', N'Discount on summer products', CAST(15.00 AS Decimal(5, 2)), CAST(N'2025-06-01' AS Date), CAST(N'2025-06-30' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (2, N'Winter Fest', N'Special discounts on winter essentials', CAST(20.00 AS Decimal(5, 2)), CAST(N'2025-12-01' AS Date), CAST(N'2025-12-31' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (3, N'Back to School', N'Discounts on school supplies', CAST(10.00 AS Decimal(5, 2)), CAST(N'2025-08-01' AS Date), CAST(N'2025-08-15' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (4, N'Holiday Special', N'Exclusive holiday deals', CAST(25.00 AS Decimal(5, 2)), CAST(N'2025-11-15' AS Date), CAST(N'2025-11-30' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (5, N'Black Friday', N'Biggest sale of the year', CAST(50.00 AS Decimal(5, 2)), CAST(N'2025-11-24' AS Date), CAST(N'2025-11-25' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (6, N'Cyber Monday', N'Special online discounts', CAST(40.00 AS Decimal(5, 2)), CAST(N'2025-11-27' AS Date), CAST(N'2025-11-28' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (7, N'New Year Offer', N'Celebrate New Year with discounts', CAST(30.00 AS Decimal(5, 2)), CAST(N'2025-12-31' AS Date), CAST(N'2026-01-05' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (8, N'Valentine Bundle', N'Gifts for your loved ones', CAST(20.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), CAST(N'2025-02-14' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (9, N'Easter Deals', N'Special offers for Easter', CAST(18.00 AS Decimal(5, 2)), CAST(N'2025-04-01' AS Date), CAST(N'2025-04-10' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (10, N'Summer Clearance', N'Clearance sale on summer stocks', CAST(35.00 AS Decimal(5, 2)), CAST(N'2025-07-01' AS Date), CAST(N'2025-07-15' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (11, N'Autumn Delight', N'Discounts on autumn collections', CAST(22.00 AS Decimal(5, 2)), CAST(N'2025-09-01' AS Date), CAST(N'2025-09-30' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (12, N'Fitness Bundle', N'Offers on fitness products', CAST(12.00 AS Decimal(5, 2)), CAST(N'2025-01-15' AS Date), CAST(N'2025-01-31' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (13, N'Gadget Fest', N'Deals on latest gadgets', CAST(25.00 AS Decimal(5, 2)), CAST(N'2025-03-01' AS Date), CAST(N'2025-03-15' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (14, N'Beauty Bundle', N'Skincare and beauty discounts', CAST(18.00 AS Decimal(5, 2)), CAST(N'2025-05-01' AS Date), CAST(N'2025-05-20' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (15, N'Home Essentials', N'Offers on home products', CAST(15.00 AS Decimal(5, 2)), CAST(N'2025-06-10' AS Date), CAST(N'2025-06-20' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (16, N'Travel Deals', N'Discounts on travel accessories', CAST(20.00 AS Decimal(5, 2)), CAST(N'2025-07-20' AS Date), CAST(N'2025-07-30' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (17, N'Kids Special', N'Offers on kids’ products', CAST(10.00 AS Decimal(5, 2)), CAST(N'2025-08-10' AS Date), CAST(N'2025-08-20' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (18, N'Food Fiesta', N'Deals on food and beverages', CAST(8.00 AS Decimal(5, 2)), CAST(N'2025-09-15' AS Date), CAST(N'2025-09-25' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (19, N'Electronics Sale', N'Special discounts on electronics', CAST(30.00 AS Decimal(5, 2)), CAST(N'2025-10-01' AS Date), CAST(N'2025-10-10' AS Date))
INSERT [dbo].[product_bundle] ([bundle_id], [bundle_name], [bundle_description], [discount_percentage], [start_date], [end_date]) VALUES (20, N'Christmas Offers', N'Celebrate Christmas with discounts', CAST(25.00 AS Decimal(5, 2)), CAST(N'2025-12-20' AS Date), CAST(N'2025-12-25' AS Date))
SET IDENTITY_INSERT [dbo].[product_bundle] OFF
GO
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2130', N'Grey')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2129', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'AT536', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2109', N'Orange')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7006', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1001', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1001', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6000', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6000', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7006', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4006', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T3132', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T3132', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T3132', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T3000', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7006', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'ST300', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'ST300', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'ST300', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2099', N'Purple')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7002', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6003', N'Yellow')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1004', N'Brown')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S1201', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S1201', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1005', N'Brown')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1005', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1006', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1006', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1006', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7002', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4004', N'Brown')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4002', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4002', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4002', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7002', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7001', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S1203', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S1203', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S1203', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7001', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7001', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL1', N'PINK')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6006', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6006', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6006', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6007', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL4', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6007', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6007', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6007', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6008', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6008', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6008', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6008', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6009', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6009', N'Green')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6009', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6009', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6001', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6002', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6004', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6004', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6004', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7003', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7003', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7003', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7004', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7004', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7004', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6005', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6005', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SW6005', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL10', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L4', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L8', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L9', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L10', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H4', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H8', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL8', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L6', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H6', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL6', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L1', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H9', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H10', N'Black')
GO
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L11', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1002', N'Green')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1002', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL9', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S1202', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4005', N'Orange')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4005', N'Yelllow')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4001', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD481', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2128', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2128', N'Green')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2119', N'Pink')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2119', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4007', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7005', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7005', N'Red')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SA7005', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'S4000', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD509', N'Purple')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD509', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD509', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'TD509', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2131', N'Grey')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2131', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2127', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2106', N'Yellow')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL4', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL6', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL8', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL10', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L1', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L6', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L9', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L10', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H6', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H10', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T4', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H4', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H8', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H9', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T8', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T11', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T12', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T15', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T16', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len12', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len13', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len16', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len17', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len20', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len21', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K2', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K3', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K6', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K9', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K10', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K12', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K13', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K16', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K17', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K20', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS1', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS2', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS8', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS9', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS12', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS13', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS16', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS17', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS20', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS21', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM1', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM2', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM3', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM6', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM10', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM11', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v1', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v4', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v9', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v10', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v12', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v8', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL7', N'Black')
GO
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L4', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L8', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L11', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H1', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H4', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H8', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H9', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL3', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL6', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'PL10', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L1', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'L9', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H6', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'H10', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T6', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T10', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T14', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T18', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS4', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS7', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS11', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS15', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS19', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len15', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len19', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K8', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM7', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'k1', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K5', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM5', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T7', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T9', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T13', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'T17', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len14', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'len18', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K7', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K11', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K15', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K19', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS3', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS5', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS6', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS10', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS14', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS18', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'QS22', N'Blue')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM9', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K4', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM4', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v11', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v5', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K14', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'K18', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM8', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'SM12', N'White')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v2', N'Black')
INSERT [dbo].[product_color] ([product_id], [color]) VALUES (N'v6', N'Black')
GO
SET IDENTITY_INSERT [dbo].[product_comment] ON 

INSERT [dbo].[product_comment] ([id], [product_id], [user_id], [created_at], [Rating], [comment], [user_name]) VALUES (2, N'AS8004', 1, CAST(N'2024-06-28T08:43:10.670' AS DateTime), 5, N'ok nhé', NULL)
INSERT [dbo].[product_comment] ([id], [product_id], [user_id], [created_at], [Rating], [comment], [user_name]) VALUES (4, N'H1002', 10, CAST(N'2024-07-01T14:06:09.260' AS DateTime), 5, N'đã mua áo đẹp lắm', N'test8')
INSERT [dbo].[product_comment] ([id], [product_id], [user_id], [created_at], [Rating], [comment], [user_name]) VALUES (5, N'AS8001', 16, CAST(N'2024-07-11T08:23:36.400' AS DateTime), 5, N'good', N'phung an')
INSERT [dbo].[product_comment] ([id], [product_id], [user_id], [created_at], [Rating], [comment], [user_name]) VALUES (6, N'AT536', 16, CAST(N'2024-07-11T08:26:36.337' AS DateTime), 4, N'OK', N'phung an')
INSERT [dbo].[product_comment] ([id], [product_id], [user_id], [created_at], [Rating], [comment], [user_name]) VALUES (8, N'AS8001', 17, CAST(N'2024-07-11T08:44:09.717' AS DateTime), 5, N'ok', N'Doanh')
SET IDENTITY_INSERT [dbo].[product_comment] OFF
GO
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (1, N'H1', CAST(10.00 AS Decimal(5, 2)), CAST(N'2025-01-01' AS Date), CAST(N'2025-01-15' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (2, N'H2', CAST(15.00 AS Decimal(5, 2)), CAST(N'2025-01-05' AS Date), CAST(N'2025-01-20' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (3, N'H3', CAST(20.00 AS Decimal(5, 2)), CAST(N'2025-01-10' AS Date), CAST(N'2025-01-25' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (4, N'H4', CAST(5.00 AS Decimal(5, 2)), CAST(N'2025-01-15' AS Date), CAST(N'2025-01-30' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (5, N'H5', CAST(25.00 AS Decimal(5, 2)), CAST(N'2025-01-20' AS Date), CAST(N'2025-02-05' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (6, N'H6', CAST(30.00 AS Decimal(5, 2)), CAST(N'2025-01-25' AS Date), CAST(N'2025-02-10' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (7, N'H7', CAST(40.00 AS Decimal(5, 2)), CAST(N'2025-01-30' AS Date), CAST(N'2025-02-15' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (8, N'H8', CAST(50.00 AS Decimal(5, 2)), CAST(N'2025-02-01' AS Date), CAST(N'2025-02-20' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (9, N'H9', CAST(10.00 AS Decimal(5, 2)), CAST(N'2025-02-05' AS Date), CAST(N'2025-02-25' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (10, N'H10', CAST(15.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), CAST(N'2025-03-01' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (11, N'K10', CAST(20.00 AS Decimal(5, 2)), CAST(N'2025-01-01' AS Date), CAST(N'2025-01-15' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (12, N'K11', CAST(30.00 AS Decimal(5, 2)), CAST(N'2025-01-05' AS Date), CAST(N'2025-01-20' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (13, N'K12', CAST(40.00 AS Decimal(5, 2)), CAST(N'2025-01-10' AS Date), CAST(N'2025-01-25' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (14, N'K13', CAST(10.00 AS Decimal(5, 2)), CAST(N'2025-01-15' AS Date), CAST(N'2025-01-30' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (15, N'K14', CAST(25.00 AS Decimal(5, 2)), CAST(N'2025-01-20' AS Date), CAST(N'2025-02-05' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (16, N'K15', CAST(5.00 AS Decimal(5, 2)), CAST(N'2025-01-25' AS Date), CAST(N'2025-02-10' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (17, N'K16', CAST(15.00 AS Decimal(5, 2)), CAST(N'2025-01-30' AS Date), CAST(N'2025-02-15' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (18, N'K17', CAST(35.00 AS Decimal(5, 2)), CAST(N'2025-02-01' AS Date), CAST(N'2025-02-20' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (19, N'K18', CAST(50.00 AS Decimal(5, 2)), CAST(N'2025-02-05' AS Date), CAST(N'2025-02-25' AS Date))
INSERT [dbo].[product_saleOFF] ([sale_id], [product_id], [discount_percentage], [start_date], [end_date]) VALUES (20, N'K19', CAST(20.00 AS Decimal(5, 2)), CAST(N'2025-02-10' AS Date), CAST(N'2025-03-01' AS Date))
GO
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2129', N'XS')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2129', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2129', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1006', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1006', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2109', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2109', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1001', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1001', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T3000', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6000', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6000', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7006', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T3132', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T3132', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T3132', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2130', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2130', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2129', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7006', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7006', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2099', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2099', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2099', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6000', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1001', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'ST300', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'ST300', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'ST300', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7002', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7002', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7002', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6003', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6003', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1004', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1004', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1004', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S1203', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S1203', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4004', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4006', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4004', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4004', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4006', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'AT536', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S1201', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S1201', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1005', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1005', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL1', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL1', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4002', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4002', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6001', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7001', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL1', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7001', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7001', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7003', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL2', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL3', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL5', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL10', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L3', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L4', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7003', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7003', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L7', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6006', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6006', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6006', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6002', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6002', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7004', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7004', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7004', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6005', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6005', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6005', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6007', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6007', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6007', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6008', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6008', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6008', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6009', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6009', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6009', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6004', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SW6004', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L8', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L9', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L10', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H3', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H4', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H7', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H8', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL8', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L2', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L6', N'M')
GO
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H2', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H6', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL7', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL6', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL4', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L1', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L5', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H5', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H9', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H10', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L11', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1002', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1002', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1002', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL9', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S1202', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4005', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4005', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4005', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4001', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD481', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD481', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2128', N'XS')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2128', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2128', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2119', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2119', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4007', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4007', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4007', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7005', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7005', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SA7005', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'S4000', N'')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD509', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD509', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD509', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'TD509', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2131', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2131', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2131', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2127', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'XXL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2106', N'3XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL2', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL3', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL5', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL8', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T2', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL10', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L2', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L6', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L9', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L10', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H3', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H7', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'k1', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L3', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L7', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H4', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H8', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T10', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T11', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T14', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T15', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T18', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K2', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T6', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T7', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len12', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len15', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len16', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len19', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len20', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K5', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K6', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K7', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K8', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K9', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K12', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K15', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K16', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K19', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K20', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS1', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS4', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS7', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS8', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS11', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS12', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS15', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS16', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS19', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS20', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM3', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM5', N'S')
GO
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM6', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM9', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM10', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v1', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v2', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v5', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v6', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v11', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL7', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L3', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L4', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L7', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L8', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L11', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H1', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H4', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H5', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H8', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H9', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL2', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL3', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL6', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'PL10', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L1', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L5', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'L9', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H2', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H6', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H7', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'H10', N'XL')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T5', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T9', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T13', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T17', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS3', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS6', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS10', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS14', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS18', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS22', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v4', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v8', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T4', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T7', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len14', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len18', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T3', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K11', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS5', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v9', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K4', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM4', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v10', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v3', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v7', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T6', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T8', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T12', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'T16', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len13', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len17', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'len21', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K10', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K14', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K18', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS2', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS9', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS13', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS17', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'QS21', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM1', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM8', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM12', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'v12', N'M')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K3', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM2', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM7', N'S')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K13', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'K17', N'L')
INSERT [dbo].[product_size] ([product_id], [size]) VALUES (N'SM11', N'S')
GO
SET IDENTITY_INSERT [dbo].[repair_request] ON 

INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (2, 2, 4, CAST(N'2025-01-02T00:00:00.000' AS DateTime), N'Battery draining quickly', N'In Progress', N'Battery replacement required', 50.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (3, 3, 5, CAST(N'2025-01-03T00:00:00.000' AS DateTime), N'Laptop not turning on', N'Completed', N'Power supply replaced', 100.0000, CAST(N'2025-01-10T00:00:00.000' AS DateTime))
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (4, 4, 7, CAST(N'2025-01-04T00:00:00.000' AS DateTime), N'Overheating issue', N'Pending', N'Diagnosis required', 0.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (5, 5, 8, CAST(N'2025-01-05T00:00:00.000' AS DateTime), N'Broken keyboard', N'In Progress', N'Replacement in process', 70.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (6, 6, 10, CAST(N'2025-01-06T00:00:00.000' AS DateTime), N'Touchscreen unresponsive', N'Pending', N'Parts ordered', 120.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (7, 7, 12, CAST(N'2025-01-07T00:00:00.000' AS DateTime), N'Speakers not working', N'Completed', N'Replaced speakers', 30.0000, CAST(N'2025-01-15T00:00:00.000' AS DateTime))
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (8, 8, 13, CAST(N'2025-01-08T00:00:00.000' AS DateTime), N'Wi-Fi not connecting', N'Pending', N'Hardware diagnosis pending', 0.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (9, 9, 14, CAST(N'2025-01-09T00:00:00.000' AS DateTime), N'Cracked screen', N'In Progress', N'Screen replacement ordered', 150.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (10, 10, 15, CAST(N'2025-01-10T00:00:00.000' AS DateTime), N'Charging port issue', N'Completed', N'Repaired charging port', 60.0000, CAST(N'2025-01-14T00:00:00.000' AS DateTime))
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (11, 11, 16, CAST(N'2025-01-11T00:00:00.000' AS DateTime), N'Camera not working', N'Pending', N'Diagnosis required', 0.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (12, 12, 17, CAST(N'2025-01-12T00:00:00.000' AS DateTime), N'Hard drive failure', N'In Progress', N'Data recovery ongoing', 200.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (13, 13, 18, CAST(N'2025-01-13T00:00:00.000' AS DateTime), N'Touchpad malfunctioning', N'Completed', N'Replaced touchpad', 80.0000, CAST(N'2025-01-18T00:00:00.000' AS DateTime))
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (14, 14, 19, CAST(N'2025-01-14T00:00:00.000' AS DateTime), N'Bluetooth not working', N'Pending', N'Parts diagnosis required', 0.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (15, 15, 21, CAST(N'2025-01-15T00:00:00.000' AS DateTime), N'System crashes frequently', N'In Progress', N'Software reinstallation required', 40.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (16, 16, 23, CAST(N'2025-01-16T00:00:00.000' AS DateTime), N'Fan making noise', N'Completed', N'Fan replaced', 90.0000, CAST(N'2025-01-20T00:00:00.000' AS DateTime))
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (17, 17, 24, CAST(N'2025-01-17T00:00:00.000' AS DateTime), N'Device not charging', N'Pending', N'Charger replacement diagnosis pending', 0.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (18, 18, 30, CAST(N'2025-01-18T00:00:00.000' AS DateTime), N'Touchscreen calibration issue', N'In Progress', N'Software update required', 20.0000, NULL)
INSERT [dbo].[repair_request] ([request_id], [warranty_id], [user_id], [request_date], [problem_description], [status], [technician_note], [estimated_cost], [completion_date]) VALUES (19, 19, 31, CAST(N'2025-01-19T00:00:00.000' AS DateTime), N'USB ports not working', N'Completed', N'Replaced USB module', 50.0000, CAST(N'2025-01-25T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[repair_request] OFF
GO
SET IDENTITY_INSERT [dbo].[report] ON 

INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email]) VALUES (1, 30, N'tôi muốn biết rõ ràng kích thước sản phẩm', N'Vấn đề về tư vấn sản phẩm ', N'anpgkhe172101@fpt.edu.vn')
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email]) VALUES (2, 30, N'kiem tra report', N'toi khong report duoc', N'anpgkhe172101@fpt.edu.vn')
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email]) VALUES (3, 30, N'Tôi không thể đổi mật khẩu trong tài khoản của tôi được', N'Vấn đề về đổi mật khẩu', N'anpgkhe172101@fpt.edu.vn')
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email]) VALUES (4, 30, N'Tôi không thể đổi mật khẩu trong tài khoản của tôi được', N'Vấn đề về đổi mật khẩu', N'anpgkhe172101@fpt.edu.vn')
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email]) VALUES (5, 30, N'Tôi không hiện thông báo gửi phản hồi thành công', N'Vấn đề về thông báo', N'anpgkhe172101@fpt.edu.vn')
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email]) VALUES (6, 30, N'Tôi không hiện thông báo gửi phản hồi thành công lần thứ 2', N'Vấn đề về thông báo', N'anpgkhe172101@fpt.edu.vn')
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email]) VALUES (9, 10, N'xau', N'san pham', N'test8@gmail.com')
INSERT [dbo].[report] ([id_report], [user_id], [content_report], [subject_report], [user_email]) VALUES (10, 13, N'w', N'ed', N'testtest@gmail.com')
SET IDENTITY_INSERT [dbo].[report] OFF
GO
SET IDENTITY_INSERT [dbo].[shipping] ON 

INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (2, 45, N'Express', N'Delivered', N'TRK789001', CAST(N'2025-01-15' AS Date), CAST(N'2025-01-14' AS Date), 15.9900, N'123 Oak Street, Portland, OR 97201', N'John Smith', N'503-555-0101')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (3, 48, N'Standard', N'In Transit', N'TRK789002', CAST(N'2025-01-20' AS Date), NULL, 8.9900, N'456 Pine Ave, Seattle, WA 98101', N'Sarah Johnson', N'206-555-0102')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (4, 52, N'Next Day', N'Processing', N'TRK789003', CAST(N'2025-01-21' AS Date), NULL, 25.9900, N'789 Maple Dr, San Francisco, CA 94102', N'Michael Brown', N'415-555-0103')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (5, 55, N'Express', N'Delivered', N'TRK789004', CAST(N'2025-01-16' AS Date), CAST(N'2025-01-15' AS Date), 15.9900, N'321 Cedar Lane, Los Angeles, CA 90001', N'Emma Davis', N'213-555-0104')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (6, 60, N'Standard', N'Delivered', N'TRK789005', CAST(N'2025-01-18' AS Date), CAST(N'2025-01-17' AS Date), 8.9900, N'654 Birch Road, San Diego, CA 92101', N'William Wilson', N'619-555-0105')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (7, 65, N'Express', N'In Transit', N'TRK789006', CAST(N'2025-01-22' AS Date), NULL, 15.9900, N'987 Elm Street, Las Vegas, NV 89101', N'Olivia Martinez', N'702-555-0106')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (8, 70, N'Standard', N'Processing', N'TRK789007', CAST(N'2025-01-23' AS Date), NULL, 8.9900, N'147 Spruce Way, Phoenix, AZ 85001', N'James Taylor', N'602-555-0107')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (9, 75, N'Next Day', N'Delivered', N'TRK789008', CAST(N'2025-01-17' AS Date), CAST(N'2025-01-17' AS Date), 25.9900, N'258 Willow Ave, Denver, CO 80201', N'Sophia Anderson', N'303-555-0108')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (10, 80, N'Express', N'In Transit', N'TRK789009', CAST(N'2025-01-21' AS Date), NULL, 15.9900, N'369 Redwood Blvd, Salt Lake City, UT 84101', N'Lucas Garcia', N'801-555-0109')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (11, 85, N'Standard', N'Processing', N'TRK789010', CAST(N'2025-01-24' AS Date), NULL, 8.9900, N'159 Aspen Court, Boise, ID 83701', N'Isabella Lopez', N'208-555-0110')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (12, 90, N'Express', N'Delivered', N'TRK789011', CAST(N'2025-01-18' AS Date), CAST(N'2025-01-18' AS Date), 15.9900, N'753 Pine Street, Austin, TX 78701', N'Benjamin Lee', N'512-555-0111')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (13, 95, N'Next Day', N'In Transit', N'TRK789012', CAST(N'2025-01-20' AS Date), NULL, 25.9900, N'951 Oak Avenue, Houston, TX 77001', N'Mia Thompson', N'713-555-0112')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (14, 98, N'Standard', N'Processing', N'TRK789013', CAST(N'2025-01-25' AS Date), NULL, 8.9900, N'357 Cedar Street, Dallas, TX 75201', N'Ethan White', N'214-555-0113')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (15, 100, N'Express', N'Delivered', N'TRK789014', CAST(N'2025-01-19' AS Date), CAST(N'2025-01-18' AS Date), 15.9900, N'852 Maple Street, Miami, FL 33101', N'Ava Rodriguez', N'305-555-0114')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (16, 102, N'Standard', N'In Transit', N'TRK789015', CAST(N'2025-01-22' AS Date), NULL, 8.9900, N'753 Birch Avenue, Orlando, FL 32801', N'Daniel Martin', N'407-555-0115')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (17, 104, N'Next Day', N'Processing', N'TRK789016', CAST(N'2025-01-21' AS Date), NULL, 25.9900, N'159 Elm Road, Atlanta, GA 30301', N'Chloe Clark', N'404-555-0116')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (18, 106, N'Express', N'Delivered', N'TRK789017', CAST(N'2025-01-20' AS Date), CAST(N'2025-01-19' AS Date), 15.9900, N'357 Spruce Street, Charlotte, NC 28201', N'Alexander Scott', N'704-555-0117')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (19, 108, N'Standard', N'In Transit', N'TRK789018', CAST(N'2025-01-23' AS Date), NULL, 8.9900, N'951 Willow Lane, Nashville, TN 37201', N'Victoria King', N'615-555-0118')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (20, 110, N'Express', N'Processing', N'TRK789019', CAST(N'2025-01-24' AS Date), NULL, 15.9900, N'753 Redwood Drive, Chicago, IL 60601', N'David Baker', N'312-555-0119')
INSERT [dbo].[shipping] ([shipping_id], [bill_id], [shipping_method], [shipping_status], [tracking_number], [estimated_delivery_date], [actual_delivery_date], [shipping_fee], [shipping_address], [receiver_name], [receiver_phone]) VALUES (21, 111, N'Next Day', N'Delivered', N'TRK789020', CAST(N'2025-01-21' AS Date), CAST(N'2025-01-21' AS Date), 25.9900, N'357 Aspen Lane, New York, NY 10001', N'Sofia Wright', N'212-555-0120')
SET IDENTITY_INSERT [dbo].[shipping] OFF
GO
SET IDENTITY_INSERT [dbo].[technical_specifications] ON 

INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (2, N'H1', N'Display Size', N'6.1 inches', N'Display')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (3, N'H1', N'Resolution', N'2532 x 1170 pixels', N'Display')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (4, N'H2', N'Processor', N'A15 Bionic', N'Performance')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (5, N'H2', N'RAM', N'6GB', N'Performance')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (6, N'H3', N'Storage', N'256GB', N'Storage')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (7, N'H3', N'Battery', N'4000mAh', N'Power')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (8, N'H4', N'Camera Resolution', N'48MP Main + 12MP Ultra Wide', N'Camera')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (9, N'H4', N'Operating System', N'iOS 15', N'Software')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (10, N'H5', N'Weight', N'175g', N'Physical')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (11, N'H5', N'Water Resistance', N'IP68', N'Build')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (12, N'K10', N'Fast Charging', N'20W', N'Power')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (13, N'K11', N'Wireless Charging', N'15W', N'Power')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (14, N'K12', N'Screen Technology', N'OLED', N'Display')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (15, N'K13', N'Refresh Rate', N'120Hz', N'Display')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (16, N'K14', N'GPU', N'Apple GPU (5-core)', N'Performance')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (17, N'K15', N'Face Recognition', N'Face ID', N'Security')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (18, N'K16', N'Bluetooth Version', N'5.3', N'Connectivity')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (19, N'K17', N'Wi-Fi', N'Wi-Fi 6E', N'Connectivity')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (20, N'K18', N'NFC', N'Yes', N'Connectivity')
INSERT [dbo].[technical_specifications] ([spec_id], [product_id], [spec_name], [spec_value], [spec_group]) VALUES (21, N'K19', N'5G Support', N'Yes', N'Connectivity')
SET IDENTITY_INSERT [dbo].[technical_specifications] OFF
GO
SET IDENTITY_INSERT [dbo].[transaction_history] ON 

INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (29, 45, 1, N'Purchase', 500.0000, CAST(N'2025-01-01T00:00:00.000' AS DateTime), N'Credit Card', N'Completed', N'REF001', N'Transaction for order 45')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (30, 46, 13, N'Refund', -200.0000, CAST(N'2025-01-02T00:00:00.000' AS DateTime), N'Bank Transfer', N'Completed', N'REF002', N'Refund for order 46')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (31, 47, 14, N'Purchase', 300.0000, CAST(N'2025-01-03T00:00:00.000' AS DateTime), N'PayPal', N'Pending', N'REF003', N'Transaction for order 47')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (32, 48, 15, N'Purchase', 700.0000, CAST(N'2025-01-04T00:00:00.000' AS DateTime), N'Credit Card', N'Completed', N'REF004', N'Transaction for order 48')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (33, 49, 16, N'Refund', -150.0000, CAST(N'2025-01-05T00:00:00.000' AS DateTime), N'Cash', N'Completed', N'REF005', N'Refund for order 49')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (34, 50, 17, N'Purchase', 400.0000, CAST(N'2025-01-06T00:00:00.000' AS DateTime), N'Credit Card', N'Completed', N'REF006', N'Transaction for order 50')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (35, 51, 18, N'Purchase', 350.0000, CAST(N'2025-01-07T00:00:00.000' AS DateTime), N'PayPal', N'Completed', N'REF007', N'Transaction for order 51')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (36, 52, 19, N'Purchase', 250.0000, CAST(N'2025-01-08T00:00:00.000' AS DateTime), N'Credit Card', N'Pending', N'REF008', N'Transaction for order 52')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (37, 54, 21, N'Purchase', 600.0000, CAST(N'2025-01-10T00:00:00.000' AS DateTime), N'Cash', N'Completed', N'REF010', N'Transaction for order 54')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (38, 56, 23, N'Refund', -300.0000, CAST(N'2025-01-12T00:00:00.000' AS DateTime), N'PayPal', N'Completed', N'REF012', N'Refund for order 56')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (39, 57, 24, N'Purchase', 500.0000, CAST(N'2025-01-13T00:00:00.000' AS DateTime), N'Credit Card', N'Completed', N'REF013', N'Transaction for order 57')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (40, 58, 4, N'Purchase', 700.0000, CAST(N'2025-01-14T00:00:00.000' AS DateTime), N'Bank Transfer', N'Pending', N'REF014', N'Transaction for order 58')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (41, 59, 5, N'Refund', -200.0000, CAST(N'2025-01-15T00:00:00.000' AS DateTime), N'Cash', N'Completed', N'REF015', N'Refund for order 59')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (42, 60, 7, N'Purchase', 300.0000, CAST(N'2025-01-16T00:00:00.000' AS DateTime), N'Credit Card', N'Completed', N'REF016', N'Transaction for order 60')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (43, 61, 8, N'Purchase', 400.0000, CAST(N'2025-01-17T00:00:00.000' AS DateTime), N'PayPal', N'Completed', N'REF017', N'Transaction for order 61')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (44, 62, 10, N'Refund', -100.0000, CAST(N'2025-01-18T00:00:00.000' AS DateTime), N'Bank Transfer', N'Completed', N'REF018', N'Refund for order 62')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (45, 63, 30, N'Purchase', 350.0000, CAST(N'2025-01-19T00:00:00.000' AS DateTime), N'Credit Card', N'Completed', N'REF019', N'Transaction for order 63')
INSERT [dbo].[transaction_history] ([transaction_id], [bill_id], [user_id], [transaction_type], [amount], [transaction_date], [payment_method], [status], [reference_number], [description]) VALUES (46, 64, 31, N'Purchase', 250.0000, CAST(N'2025-01-20T00:00:00.000' AS DateTime), N'Cash', N'Pending', N'REF020', N'Transaction for order 64')
SET IDENTITY_INSERT [dbo].[transaction_history] OFF
GO
SET IDENTITY_INSERT [dbo].[users] ON 

INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (1, N'ADMIN', N'doanhtnhe172637@fpt.edu.vn', N'Dtran4673', N'TRUE', N'2003-04-03', N'Thai Binh', N'0348956373', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (4, N'AN', N'AN@gmail.com', N'1423', N'TRUE', N'2003-12-02', N'Ha Noi', N'0999999999', 0, N'Good', N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (5, N'Tran Doanh', N'trandoanh@gmail.com', N'123', N'FALSE', N'2003-04-03', N'Thai Binh', N'0999999999', 0, N'tốt', N'TRUE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (7, N'test5', N'test5@gmail.com', N'Dtran4673', N'FALSE', N'2003-04-03', N'Thai Binh', N'0999999999', 1, N'ok', N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (8, N'test6', N'test6@gmaii.com', N'123', N'False', N'2003-04-03', N'Thai Binh', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (10, N'test8', N'test8@gmail.com', N'Dtran4673', N'FALSE', N'2003-04-03', N'Thai Binhh', N'0999999999', 1, NULL, N'TRUE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (12, N'Doanh', N'doanh@gmail.com', N'Dtran4673', N'TRUE', N'2003-04-03', N'Thai Binh', N'0999999999', 0, N'chăm chỉ', N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (13, N'testhi', N'testtest@gmail.com', N'Dtran4673', N'False', N'2004-04-12', N'Thai Binh', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (14, N'test10', N'dtran9@gmail.com', N'1', N'False', N'2003-04-03', N'Thai Binh', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (15, N'thanh', N'test15@gmail.com', N'1', N'False', N'2003-04-03', N'Ha Noi', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (16, N'phung an', N'dtran04032003@gmail.com', N'1', N'False', N'2003-04-03', N'Ha Noi', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (17, N'Doanh', N'doanhdoanh@gmail.com', N'1', N'False', N'2003-04-03', N'Ha Noi', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (18, N'Doanh', N'doanhtran1@gmail.com', N'123', N'False', N'2003-04-03', N'Ha Noi', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (19, N'Doanh', N'dtran99@gmail.com', N'Dtran99', N'False', N'2003-04-03', N'Thai Binh', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (21, N'thanh', N'test100@gmail.com', N'123', N'False', N'2003-04-03', N'Thai Binh', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (23, N'Doanh', N'doanhtest@gmail.com', N'1', N'False', N'2003-04-03', N'Thai Binh', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (24, N'Doanh', N'testhihi@gmail.com', N'1', N'False', N'2003-04-03', N'Thai Binh', N'0999999999', 0, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (30, N'an', N'anpgkhe172101@fpt.edu.vn', N'505932', N'False', N'2003-04-03', N'Thai Binh', N'0999999999', 1, NULL, N'FALSE')
INSERT [dbo].[users] ([user_id], [user_name], [user_email], [user_pass], [isAdmin], [dateOfBirth], [address], [phoneNumber], [banned], [adminReason], [isStoreStaff]) VALUES (31, N'', N'dtran4673@gmail.com', N'Dtran4673', N'False', N'', N'', N'', 0, N'', N'False')
SET IDENTITY_INSERT [dbo].[users] OFF
GO
SET IDENTITY_INSERT [dbo].[warranty] ON 

INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (2, N'H1', 45, CAST(N'2025-01-01' AS Date), CAST(N'2026-01-01' AS Date), N'SN1001', N'Active', N'Warranty valid for one year')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (3, N'H2', 46, CAST(N'2025-01-02' AS Date), CAST(N'2026-01-02' AS Date), N'SN1002', N'Active', N'Standard warranty')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (4, N'H3', 47, CAST(N'2025-01-03' AS Date), CAST(N'2026-01-03' AS Date), N'SN1003', N'Active', N'Manufacturer warranty')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (5, N'H4', 48, CAST(N'2025-01-04' AS Date), CAST(N'2026-01-04' AS Date), N'SN1004', N'Active', N'Warranty includes parts and labor')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (6, N'H5', 49, CAST(N'2025-01-05' AS Date), CAST(N'2026-01-05' AS Date), N'SN1005', N'Expired', N'Warranty expired due to time limit')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (7, N'H6', 50, CAST(N'2025-01-06' AS Date), CAST(N'2026-01-06' AS Date), N'SN1006', N'Void', N'Warranty void due to misuse')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (8, N'H7', 51, CAST(N'2025-01-07' AS Date), CAST(N'2026-01-07' AS Date), N'SN1007', N'Active', N'Extended warranty purchased')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (9, N'H8', 52, CAST(N'2025-01-08' AS Date), CAST(N'2026-01-08' AS Date), N'SN1008', N'Active', N'Covers accidental damage')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (10, N'H9', 53, CAST(N'2025-01-09' AS Date), CAST(N'2026-01-09' AS Date), N'SN1009', N'Expired', N'Warranty expired')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (11, N'H10', 54, CAST(N'2025-01-10' AS Date), CAST(N'2026-01-10' AS Date), N'SN1010', N'Active', N'Warranty includes replacement')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (12, N'K11', 55, CAST(N'2025-01-11' AS Date), CAST(N'2026-01-11' AS Date), N'SN1011', N'Active', N'Standard one-year warranty')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (13, N'K12', 56, CAST(N'2025-01-12' AS Date), CAST(N'2026-01-12' AS Date), N'SN1012', N'Void', N'Warranty void due to unauthorized repair')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (14, N'K13', 57, CAST(N'2025-01-13' AS Date), CAST(N'2026-01-13' AS Date), N'SN1013', N'Active', N'Covers manufacturing defects')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (15, N'K14', 58, CAST(N'2025-01-14' AS Date), CAST(N'2026-01-14' AS Date), N'SN1014', N'Active', N'Warranty extended with additional payment')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (16, N'K15', 59, CAST(N'2025-01-15' AS Date), CAST(N'2026-01-15' AS Date), N'SN1015', N'Expired', N'Warranty expired after one year')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (17, N'K16', 60, CAST(N'2025-01-16' AS Date), CAST(N'2026-01-16' AS Date), N'SN1016', N'Active', N'Covers electrical failures')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (18, N'K17', 61, CAST(N'2025-01-17' AS Date), CAST(N'2026-01-17' AS Date), N'SN1017', N'Active', N'Standard coverage')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (19, N'K18', 62, CAST(N'2025-01-18' AS Date), CAST(N'2026-01-18' AS Date), N'SN1018', N'Void', N'Warranty void due to physical damage')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (20, N'K19', 63, CAST(N'2025-01-19' AS Date), CAST(N'2026-01-19' AS Date), N'SN1019', N'Active', N'Covers all parts')
INSERT [dbo].[warranty] ([warranty_id], [product_id], [bill_id], [warranty_start_date], [warranty_end_date], [serial_number], [warranty_status], [warranty_note]) VALUES (21, N'K20', 64, CAST(N'2025-01-20' AS Date), CAST(N'2026-01-20' AS Date), N'SN1020', N'Active', N'Warranty includes service at authorized centers')
SET IDENTITY_INSERT [dbo].[warranty] OFF
GO
ALTER TABLE [dbo].[product_comment] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[transaction_history] ADD  DEFAULT (getdate()) FOR [transaction_date]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT ((0)) FOR [banned]
GO
ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FK_bill_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FK_bill_users]
GO
ALTER TABLE [dbo].[bill_detail]  WITH CHECK ADD  CONSTRAINT [FK_bill_detail_bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[bill] ([bill_id])
GO
ALTER TABLE [dbo].[bill_detail] CHECK CONSTRAINT [FK_bill_detail_bill]
GO
ALTER TABLE [dbo].[bill_detail]  WITH CHECK ADD  CONSTRAINT [FK_bill_detail_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[bill_detail] CHECK CONSTRAINT [FK_bill_detail_product]
GO
ALTER TABLE [dbo].[bundle_detail]  WITH CHECK ADD  CONSTRAINT [FK_bundle_detail_bundle] FOREIGN KEY([bundle_id])
REFERENCES [dbo].[product_bundle] ([bundle_id])
GO
ALTER TABLE [dbo].[bundle_detail] CHECK CONSTRAINT [FK_bundle_detail_bundle]
GO
ALTER TABLE [dbo].[bundle_detail]  WITH CHECK ADD  CONSTRAINT [FK_bundle_detail_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[bundle_detail] CHECK CONSTRAINT [FK_bundle_detail_product]
GO
ALTER TABLE [dbo].[cart]  WITH CHECK ADD  CONSTRAINT [FK_cart_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[cart] CHECK CONSTRAINT [FK_cart_product]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_brand] FOREIGN KEY([brand_id])
REFERENCES [dbo].[brand] ([brand_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_brand]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_category]
GO
ALTER TABLE [dbo].[product_active]  WITH CHECK ADD  CONSTRAINT [FK_ProductActive_Product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_active] CHECK CONSTRAINT [FK_ProductActive_Product]
GO
ALTER TABLE [dbo].[product_color]  WITH CHECK ADD  CONSTRAINT [FK_product_color_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_color] CHECK CONSTRAINT [FK_product_color_product]
GO
ALTER TABLE [dbo].[product_comment]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_comment]  WITH CHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[product_saleOFF]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_size]  WITH CHECK ADD  CONSTRAINT [FK_product_size_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[product_size] CHECK CONSTRAINT [FK_product_size_product]
GO
ALTER TABLE [dbo].[repair_request]  WITH CHECK ADD  CONSTRAINT [FK_repair_request_warranty] FOREIGN KEY([warranty_id])
REFERENCES [dbo].[warranty] ([warranty_id])
GO
ALTER TABLE [dbo].[repair_request] CHECK CONSTRAINT [FK_repair_request_warranty]
GO
ALTER TABLE [dbo].[report]  WITH CHECK ADD  CONSTRAINT [FK_user_id] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[report] CHECK CONSTRAINT [FK_user_id]
GO
ALTER TABLE [dbo].[shipping]  WITH CHECK ADD  CONSTRAINT [FK_shipping_bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[bill] ([bill_id])
GO
ALTER TABLE [dbo].[shipping] CHECK CONSTRAINT [FK_shipping_bill]
GO
ALTER TABLE [dbo].[technical_specifications]  WITH CHECK ADD  CONSTRAINT [FK_technical_specifications_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[technical_specifications] CHECK CONSTRAINT [FK_technical_specifications_product]
GO
ALTER TABLE [dbo].[transaction_history]  WITH CHECK ADD  CONSTRAINT [FK_transaction_history_bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[bill] ([bill_id])
GO
ALTER TABLE [dbo].[transaction_history] CHECK CONSTRAINT [FK_transaction_history_bill]
GO
ALTER TABLE [dbo].[transaction_history]  WITH CHECK ADD  CONSTRAINT [FK_transaction_history_user] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([user_id])
GO
ALTER TABLE [dbo].[transaction_history] CHECK CONSTRAINT [FK_transaction_history_user]
GO
ALTER TABLE [dbo].[warranty]  WITH CHECK ADD  CONSTRAINT [FK_warranty_bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[bill] ([bill_id])
GO
ALTER TABLE [dbo].[warranty] CHECK CONSTRAINT [FK_warranty_bill]
GO
ALTER TABLE [dbo].[warranty]  WITH CHECK ADD  CONSTRAINT [FK_warranty_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[warranty] CHECK CONSTRAINT [FK_warranty_product]
GO
