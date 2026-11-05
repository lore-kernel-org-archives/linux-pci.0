Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793905184;
	b=Oxgn7GrbiO3F9bH6P2LixE+EawIoUL23mw5ndPlRkqb3CoYuJBlKu6gXOUfLf2tPkvn7
	 +QWhXDEzN39S3z6YFPEEbSD2uvE1cR/y0pdSlwr4GI3RWRjbemZtmrMHiHYcwKawWvNW1
	 /OyyQQtX5vxN3Ng5IAHBB2l2pleee37cB6H9GyELMVknVWofOfkcV6w00pxBCpd96BTh4
	 djyrNRzxWyBEBCU3MSv2HmpccfzRMk4io8tljRuvGt4AfDWrCCyVzAfwz3hp8oQBiLiTS
	 pQM2URD4vKguXFttwDoLT8tSglnmw2Kzbg/LrxBq90W/pBo8Lz2onE3HgwexrpgjMGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905184;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=D22Eto6SWUY9bX8zpUzw3ydhFMkAGr5zHcVdyn/IfMU=;
	b=WiQ4TxP2lPmh6Y6WunlBBg3g3ejnSUK+qaGaj6cWAPSSHLLpeRRm9YQfdZRoZzObtxNv
	 lLkpoR7TAwSolS7geXHrCtIq/PkfzA0EwngkJMHswybpdK0JzCi0zr7PbT1jOkE066/eh
	 v/AnS73lQvDruYOuMpgVgTzWN8wWdKNjOU1yFeaM46HV5yEio06POY5uGBguRhTPQM3MA
	 2oaMOE/wd1q5i489ij4CWP6PVutB23U7WKYE7I5L/zP8KXcwrLTcydbX+hNt+Q2qG3owr
	 MvS604o6EXz6UcVBVAycQ2TqdoAZ/gDF2CyhhtpeNd25vSZrzsbMNZhjSvEeVWcEOMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZYaYcX2C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.18
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011018.outbound.protection.outlook.com [40.107.208.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF75D606EE86;
	Thu,  5 Nov 2026 18:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF75D606EE86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZYaYcX2C
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGYHNFZbv9b7OP6/+tCV5HCPo0cKojPgs9h8cpAjHKsJWF3FnRJWxzoEoH3R7d217P2d1dvqVlZJ3v8cAbhOIuloqIE/jKxn3DDayDY3tLeZYKP2msj7I9hDChXHRjBR3+4tIie/17n7jQjnUXyRyLosIChbFEZrfeoQl69o2/KWyGDTD2gkOzhTPNRFV1WXGziPBI27e6IbdJGTQ1IM60gxzUZK/p2JbsVGIVX+wshjgbhX/11sXSt+pvxQPBQAA6IqrH2XGWCji15eVSI4zlNPxt+gZT+eGM1eX74loc0iue0C8j4ZdXny8u8ye+YJK7X5qbSTyIRn5qqo1DbPfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D22Eto6SWUY9bX8zpUzw3ydhFMkAGr5zHcVdyn/IfMU=;
 b=YUJt7vPozjJTEwZ99BqPc1vvCXUh6uYKvH/CurZSV9qYvIlhQvkxUJCH6hYz5ynKuxiG07+U4dw45lelGK7GMMRsc+MNn+VzyDDcGGtQUmudeoWwDBiRLxk732DcHnnZqTdwX85efpHwtokcwh64Brq9h/HXzlureHQeEY4xkNqEJK7W+uj8xYFKJQoJy0zLz6YSWziXfuFRHaJ6G9TW2J0yh2jOLCd8QrfsnOZwxXI8Nx5ByGFvZgNyJBAbOTGXttdUcuWTzL1JmMtoE+qT0QV6LyuGc4yDY9l0Rg0B6XPoOJblC6YDBOfov6GUf4giraWJSuSqH7PplOUqMdPbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D22Eto6SWUY9bX8zpUzw3ydhFMkAGr5zHcVdyn/IfMU=;
 b=ZYaYcX2CRn2G8sD9cdSaHYeerWsjRvjDZu05VewFS5aLvRxMm0zPR5838AyD9K+2CsJs99Nt5qpbhxSbOsG0hZ5Ehl3h2ttEfmPK1VgXyeKg2hTMLJrAnejJwmpejm4xYk6y2idGAWKsTgc/UXHox1i+EgB/T3Qk9cUmo30tDlNzIGymS8CamCUAG3xdUuvqDKukfaqRvlRWrIJBB6SF4VFPgNPgK/TLFNZ29MCnOuFhDQTS9Mi2aqjeSUx0Vdz10CNWpUJSAMzg0g5mXkVaQiPHTX05JVywa4TPBTliXd9S8WKXn7NXvdSVDkEsEtVkVAXPi+Uiiyl/avH2tC0qTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5) by SN7PR12MB7884.namprd12.prod.outlook.com
 (2603:10b6:806:343::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:59:30 +0000
Received: from LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522]) by LY0PR12MB727857.namprd12.prod.outlook.com
 ([fe80::843e:82cd:41ca:f522%5]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 18:59:30 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ira Weiny <iweiny@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Ming <ming.li@zohomail.com>,
	Joshua Machauer <machaujo@amazon.de>,
	Alex Williamson <alex.williamson@redhat.com>,
	vsethi@nvidia.com,
	alwilliamson@nvidia.com,
	Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
	Vishal Aslot <vaslot@nvidia.com>,
	Manish Honap <mhonap@nvidia.com>,
	Jiandi An <jan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-tegra@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v17 04/19] cxl: Embed decoder configuration in a standalone structure
Date: Thu,  5 Nov 2026 18:59:02 +0000
Message-ID: <20261105185917.2667656-5-smadhavan@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105185917.2667656-1-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::30) To LY0PR12MB727857.namprd12.prod.outlook.com
 (2603:10b6:408:3ba::5)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR12MB727857:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 66021169-8d11-4365-b5a0-08df3b6eec20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|261026121527099003|56012099006|261102123227099003|261009221727099003|261021123027099003|261009223327099003|261022105027099003|261021121427099003|261022075727099003|261009220027099003|261009221227099003|261026140227099003|11063799006|261009223027099003|261028144727099003|921020|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mGFc3oA209APQWugjIjyW1UtUIs6loRFklUOR/Xd6NJuiawBuSkEzGwTr720XG6LZYuNC8i2beD8Qsp9lhiJ0f+wvXxwsIzW2wWoRGCLwTLweOMtUxrPuUfpSDpbhQJIyr/qG6SfTrIIBgYQLDSCK0PeU6M8LBhzT7Nlfwq6bfC45tEOqpPhaVd6FxZDR81QBLTQaExLE1g2yBkidHvZwpTtgtWYglVePUI+0sfzlm7WoTgWYOFn45Aa5C2ahtawUmzaOtAJL5z7pwhD3RRoTU66uwrB/4JFFFCU333XREquWPhAglrfGtB/gPvMCO12tUdY7BrkF3FmnIea/PaxeEpBJCnq1h4EHujpea2MJaLWh7MM6DxlXO+KuKVtd64a/HW7/joAgJ2kh503Ck9UI5VEsw4Z0sUjdjWx44lLmoITzqux1vYV5ReIuwpZNznbcXGes2u8s8Hi7xMEG1V/J+DfQ0Yk/j+qRHbsVKwvxPwlYAkN1GNR7T8mlN2AJUJwDOuQ42MXMqRvc/Tf8tPb8tM1bDtm4ZdkbyUHOr8SVFzAqIy59/wjNgjMfa8oDvYeCnYvRJjz0hhdSgdhMZxqFk44sm+5QTLA70Ir/VkxbIN3mPX43PjXWpEN77iMRlLaXFbgOewjBA9q+jRLZ1FuUr4t7156+NZRO5FGrAUhDFhjU+BOkB8LzxHUw/WMN7Mx1SjLyG0Jlp7aeEpUsb7KlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LY0PR12MB727857.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261026121527099003)(56012099006)(261102123227099003)(261009221727099003)(261021123027099003)(261009223327099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009220027099003)(261009221227099003)(261026140227099003)(11063799006)(261009223027099003)(261028144727099003)(921020)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+wgO7KL0c314idq0GGiNmofw71k0HJOGiewJ2X9pVLDC/5BZvwoolpO46Ow?=
 =?us-ascii?Q?fcdXhsVwEq5LjI/cM2vPxAgTt1WKt7ozmucIHWekEXCX3XpNCl59ztEd+Plm?=
 =?us-ascii?Q?VzIskv9KWxa0LN5peR2k6KHLZtAAaQ/6pvDaioz1ddgOvTgw6Atc8jiYoxvk?=
 =?us-ascii?Q?b6Hw94skoR2BuJZ6AzKS2O10jE8a+mSciEp6mSZhgAJbJF1l5U4nNDbYoREc?=
 =?us-ascii?Q?Z0ObDnhScOV+Jdoc0MYIFUOI2et9nbnNMbK3dbTS3BckwwT/w4rU8BQOxTgA?=
 =?us-ascii?Q?IMe8rL6Pb4GVmMgy7PcH+MW7ec9/+yrB8w2kWpPjQZBnVsXIzbo66Q7cNc3D?=
 =?us-ascii?Q?Mjtvs4QjOUcqvuHwuapoCrOU5OgXUuRniEXIFFLBfpmJ18vJknUkoiw1mr96?=
 =?us-ascii?Q?gv3VPTvF1vMPKbGm8zAcm5+/NhogaFU2L5q1STte/v2iB5oXCLSWLatPYMD/?=
 =?us-ascii?Q?3iytyhSA9zJRc0J/Hzpdv/S2b8jcQJpnlp7/XyRuSkTFmVBGjS7P2ObcIWVR?=
 =?us-ascii?Q?rWHJcfx3/642End+nDJ5E/vQPLk4URlM9x0k0x6/6mmhi3l/0gNQolrdAvcL?=
 =?us-ascii?Q?YEh8LDrLnNTbOoQC/zJcEL+tVeW/zPZKhNWRr9SyO8nKBvLi7O55GFyuXUn2?=
 =?us-ascii?Q?YU3byyCIumK0JeHEVNgbF2Jak1MmdLeaZDiCg6LA/UdPNz6WskBQErjirKHR?=
 =?us-ascii?Q?qslPjQp0RIFDjX/hdcGD58UUA0qU/vbCs9ka3A8y8B+U8+5jQOPgQ+5pkBNx?=
 =?us-ascii?Q?ikwVFbgh+RCLpZOxy/AtqpMOiPgoCaSMBUV6vMEtvCOMDZnpaHVonfI1EG7D?=
 =?us-ascii?Q?GcoKd9b4JHNfjWlaafkbrDwnCv36uSSEKHULLqi1XuQTaVSPfreeLfBlySXt?=
 =?us-ascii?Q?pGBdVvJXcyRvx2x8yl57crMqm+kwhbyKxR8NQfU2ZtziYRIyRHphm440uuOv?=
 =?us-ascii?Q?I6WnnM+Fd2FTqE9GkZBZsNL4ddw7lmv7uFW1A64Xn6w9e0uQCYLd5FzcXKtD?=
 =?us-ascii?Q?lW4ffKqBPtEeT1pO1DM9JYEwmjpJfpBOxt+y7rtr5diD69iKV00q6ZLLyYev?=
 =?us-ascii?Q?5i//qb8nlYXdL3yoRu4K26wbwXlbc6PJeLT5Ts8g+RDKhvaLc5Lb6z/RlzFw?=
 =?us-ascii?Q?VJaCeQc+Jjk7CtZTDk0ZPDb2+xGSroORPObL22q6XocbCK6wnAMUH5EXr9XJ?=
 =?us-ascii?Q?VIQYLg49fKhvGPbIB1g8EOJbejcEMyZ5apRFgAJxIy5SBegOmFC7goVy6MVi?=
 =?us-ascii?Q?Cm9Deyb/zpv6XsAiOtgE+6LuJfDAcQyV5EHugS/B7AXun5G1MB2hLljBDfLy?=
 =?us-ascii?Q?BNFP80f7DKzOU6gPXbidzHXzi93e8e0miCZF61u/hWaoNzFMpHveaPxxkyfg?=
 =?us-ascii?Q?4ik8sfR/Iv8G7C7SlJSerCD1AsWKXR6ybZp7GHe6SNS4L9PpFXtxhN17v0dQ?=
 =?us-ascii?Q?m3IO6hR8C/1VcSCOWxvyRSX5lJ02TkKxjh2PvBOyBVawypj+1E/yrNH9bc3N?=
 =?us-ascii?Q?TpPr1jIt0FBlKdS+Xura5U6828zXCAFFWkIBy0isvENG8bDZsqXOPA1zAfZn?=
 =?us-ascii?Q?KOus03BU6cqkP7Kzhx2YOxyQ+9NJOm8ohf8rRTVxru0Etc0negGWdwxoFD5i?=
 =?us-ascii?Q?sNpJFvLboTBSsjxNPmUPc+fIHb5moN4vShbLnsH6cV+ANB7qIZ6wcQygWOT0?=
 =?us-ascii?Q?gukWIh8l4CexMHKiWb3Sx5nL2CoWzvbhjQvm8i/3xl13RwfwopmQB8NSspbV?=
 =?us-ascii?Q?oH4/h+UyCw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66021169-8d11-4365-b5a0-08df3b6eec20
X-MS-Exchange-CrossTenant-AuthSource: LY0PR12MB727857.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:59:30.5275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WPtK5pDoDQOPgVLbsxj/5LT72fRYgUUeUvGnvFM2UF2kYBgB22zHMT9O28lNb1oz0U1FqxDSG2bQ0b4WkkrfIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

Define cxl_decoder_config independently and embed it in cxl_decoder. Update
decoder field accesses without changing behavior, so reset snapshots can
reuse the configuration type without struct_group_tagged().

Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/acpi.c           |  26 +++---
 drivers/cxl/core/atl.c       |   4 +-
 drivers/cxl/core/hdm.c       | 114 ++++++++++++-------------
 drivers/cxl/core/pci.c       |   8 +-
 drivers/cxl/core/port.c      |  42 +++++-----
 drivers/cxl/core/region.c    | 102 +++++++++++-----------
 drivers/cxl/cxl.h            |   2 +-
 drivers/cxl/pci.c            |   2 +-
 drivers/cxl/port.c           |   4 +-
 include/cxl/cxl.h            |  29 +++++--
 tools/testing/cxl/test/cxl.c | 158 +++++++++++++++++------------------
 11 files changed, 249 insertions(+), 242 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3b818adbd38b..692a4e067678 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -109,16 +109,16 @@ static int cxl_parse_cxims(union acpi_subtable_headers *header, void *arg,
 		return rc;
 
 	/* Does this CXIMS entry apply to the given CXL Window? */
-	if (hbig != cxld->interleave_granularity)
+	if (hbig != cxld->config.interleave_granularity)
 		return 0;
 
 	/* IW 1,3 do not use xormaps and skip this parsing entirely */
-	if (is_power_of_2(cxld->interleave_ways))
+	if (is_power_of_2(cxld->config.interleave_ways))
 		/* 2, 4, 8, 16 way */
-		nr_maps = ilog2(cxld->interleave_ways);
+		nr_maps = ilog2(cxld->config.interleave_ways);
 	else
 		/* 6, 12 way */
-		nr_maps = ilog2(cxld->interleave_ways / 3);
+		nr_maps = ilog2(cxld->config.interleave_ways / 3);
 
 	if (cxims->nr_xormaps < nr_maps) {
 		dev_dbg(dev, "CXIMS nr_xormaps[%d] expected[%d]\n",
@@ -363,7 +363,7 @@ static int add_or_reset_cxl_resource(struct resource *parent, struct resource *r
 static void cxl_setup_extended_linear_cache(struct cxl_root_decoder *cxlrd)
 {
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
-	struct range *hpa = &cxld->hpa_range;
+	struct range *hpa = &cxld->config.hpa_range;
 	resource_size_t size = range_len(hpa);
 	resource_size_t start = hpa->start;
 	resource_size_t cache_size;
@@ -436,13 +436,13 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 		return PTR_ERR(cxlrd);
 
 	cxld = &cxlrd->cxlsd.cxld;
-	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-	cxld->hpa_range = (struct range) {
+	cxld->config.flags = cfmws_to_decoder_flags(cfmws->restrictions);
+	cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->config.hpa_range = (struct range) {
 		.start = cfmws->base_hpa,
 		.end = cfmws->base_hpa + cfmws->window_size - 1,
 	};
-	cxld->interleave_ways = ways;
+	cxld->config.interleave_ways = ways;
 	for (i = 0; i < ways; i++)
 		cxld->target_map[i] = cfmws->interleave_targets[i];
 	/*
@@ -451,7 +451,7 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
 	 */
 	if (ways == 1)
 		ig = CXL_DECODER_MIN_GRANULARITY;
-	cxld->interleave_granularity = ig;
+	cxld->config.interleave_granularity = ig;
 
 	if (cfmws->interleave_arithmetic == ACPI_CEDT_CFMWS_ARITHMETIC_XOR) {
 		if (ways != 1 && ways != 3) {
@@ -752,7 +752,7 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
 		return 0;
 
 	cxld = to_cxl_decoder(match);
-	if (!(cxld->flags & CXL_DECODER_F_PMEM))
+	if (!(cxld->config.flags & CXL_DECODER_F_PMEM))
 		return 0;
 
 	cxl_nvb = devm_cxl_add_nvdimm_bridge(host, root_port);
@@ -869,8 +869,8 @@ static int pair_cxl_resource(struct device *dev, void *data)
 		struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
 		struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 		struct resource res = {
-			.start = cxld->hpa_range.start,
-			.end = cxld->hpa_range.end,
+			.start = cxld->config.hpa_range.start,
+			.end = cxld->config.hpa_range.end,
 			.flags = IORESOURCE_MEM,
 		};
 
diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
index 310668786189..07ce7c50c47a 100644
--- a/drivers/cxl/core/atl.c
+++ b/drivers/cxl/core/atl.c
@@ -172,8 +172,8 @@ static int cxl_prm_setup_root(struct cxl_root *cxl_root, void *data)
 	 *
 	 * Indicate that Normalized Addressing is enabled.
 	 */
-	cxld->flags |= CXL_DECODER_F_LOCK;
-	cxld->flags |= CXL_DECODER_F_NORMALIZED_ADDRESSING;
+	cxld->config.flags |= CXL_DECODER_F_LOCK;
+	cxld->config.flags |= CXL_DECODER_F_NORMALIZED_ADDRESSING;
 
 	ctx->hpa_range = hpa_range;
 	ctx->interleave_ways = ways;
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 39fe283cbc74..9e05032a5426 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -384,11 +384,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 
 	if (cxled->dpa_res) {
 		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
-			port->id, cxled->cxld.id, cxled->dpa_res);
+			port->id, cxled->cxld.config.id, cxled->dpa_res);
 		return -EBUSY;
 	}
 
-	if (port->hdm_end + 1 != cxled->cxld.id) {
+	if (port->hdm_end + 1 != cxled->cxld.config.id) {
 		/*
 		 * Assumes alloc and commit order is always in hardware instance
 		 * order per expectations from 8.2.5.12.20 Committing Decoder
@@ -396,7 +396,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		 * decoder[m+1] commit start.
 		 */
 		dev_dbg(dev, "decoder%d.%d: expected decoder%d.%d\n", port->id,
-			cxled->cxld.id, port->id, port->hdm_end + 1);
+			cxled->cxld.config.id, port->id, port->hdm_end + 1);
 		return -EBUSY;
 	}
 
@@ -409,7 +409,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 				     dev_name(&cxled->cxld.dev));
 	if (IS_ERR(res)) {
 		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
-			port->id, cxled->cxld.id);
+			port->id, cxled->cxld.config.id);
 		if (skipped)
 			release_skip(cxlds, base - skipped, skipped);
 		return PTR_ERR(res);
@@ -432,7 +432,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	/* Empty decoders may not be contained by a partition boundary */
 	if (cxled->part < 0 && resource_size(res))
 		dev_warn(dev, "decoder%d.%d: %pr does not map any partition\n",
-			 port->id, cxled->cxld.id, res);
+			 port->id, cxled->cxld.config.id, res);
 
 	port->hdm_end++;
 	get_device(&cxled->cxld.dev);
@@ -580,11 +580,11 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
 			dev_name(&cxled->cxld.region->dev));
 		return -EBUSY;
 	}
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+	if (cxled->cxld.config.flags & CXL_DECODER_F_ENABLE) {
 		dev_dbg(dev, "decoder enabled\n");
 		return -EBUSY;
 	}
-	if (cxled->cxld.id != port->hdm_end) {
+	if (cxled->cxld.config.id != port->hdm_end) {
 		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
 			port->hdm_end);
 		return -EBUSY;
@@ -603,7 +603,7 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
 	int part;
 
 	guard(rwsem_write)(&cxl_rwsem.dpa);
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
+	if (cxled->cxld.config.flags & CXL_DECODER_F_ENABLE)
 		return -EBUSY;
 
 	for (part = 0; part < cxlds->nr_partitions; part++)
@@ -641,7 +641,7 @@ static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
 		return -EBUSY;
 	}
 
-	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
+	if (cxled->cxld.config.flags & CXL_DECODER_F_ENABLE) {
 		dev_dbg(dev, "decoder enabled\n");
 		return -EBUSY;
 	}
@@ -716,12 +716,12 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 	 * Input validation ensures these warns never fire, but otherwise
 	 * suppress unititalized variable usage warnings.
 	 */
-	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
-		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
+	if (WARN_ONCE(ways_to_eiw(cxld->config.interleave_ways, &eiw),
+		      "invalid interleave_ways: %d\n", cxld->config.interleave_ways))
 		return;
-	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
+	if (WARN_ONCE(granularity_to_eig(cxld->config.interleave_granularity, &eig),
 		      "invalid interleave_granularity: %d\n",
-		      cxld->interleave_granularity))
+		      cxld->config.interleave_granularity))
 		return;
 
 	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
@@ -732,14 +732,14 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
 static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
 {
 	u32p_replace_bits(ctrl,
-			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
+			  !!(cxld->config.target_type == CXL_DECODER_HOSTONLYMEM),
 			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
 }
 
 static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 {
 	struct cxl_dport **t = &cxlsd->target[0];
-	int ways = cxlsd->cxld.interleave_ways;
+	int ways = cxlsd->cxld.config.interleave_ways;
 
 	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
 	if (ways > 1)
@@ -786,16 +786,16 @@ static int cxld_await_commit(void __iomem *hdm, int id)
 
 static void setup_hw_decoder(struct cxl_decoder *cxld, void __iomem *hdm)
 {
-	int id = cxld->id;
+	int id = cxld->config.id;
 	u64 base, size;
 	u32 ctrl;
 
 	/* common decoder settings */
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->config.id));
 	cxld_set_interleave(cxld, &ctrl);
 	cxld_set_type(cxld, &ctrl);
-	base = cxld->hpa_range.start;
-	size = range_len(&cxld->hpa_range);
+	base = cxld->config.hpa_range.start;
+	size = range_len(&cxld->config.hpa_range);
 
 	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
@@ -830,9 +830,9 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	int id = cxld->id, rc;
+	int id = cxld->config.id, rc;
 
-	if (cxld->flags & CXL_DECODER_F_ENABLE)
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE)
 		return 0;
 
 	if (cxl_num_decoders_committed(port) != id) {
@@ -865,14 +865,14 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
 		setup_hw_decoder(cxld, hdm);
 
-	rc = cxld_await_commit(hdm, cxld->id);
+	rc = cxld_await_commit(hdm, cxld->config.id);
 	if (rc) {
 		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
 			dev_name(&cxld->dev), rc);
 		return rc;
 	}
 	port->commit_end++;
-	cxld->flags |= CXL_DECODER_F_ENABLE;
+	cxld->config.flags |= CXL_DECODER_F_ENABLE;
 
 	return 0;
 }
@@ -886,8 +886,8 @@ static int commit_reap(struct device *dev, void *data)
 		return 0;
 
 	cxld = to_cxl_decoder(dev);
-	if (port->commit_end == cxld->id &&
-	    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
+	if (port->commit_end == cxld->config.id &&
+	    ((cxld->config.flags & CXL_DECODER_F_ENABLE) == 0)) {
 		port->commit_end--;
 		dev_dbg(&port->dev, "reap: %s commit_end: %d\n",
 			dev_name(&cxld->dev), port->commit_end);
@@ -919,13 +919,13 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
-	int id = cxld->id;
+	int id = cxld->config.id;
 	u32 ctrl;
 
-	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
+	if ((cxld->config.flags & CXL_DECODER_F_ENABLE) == 0)
 		return;
 
-	if (cxld->flags & CXL_DECODER_F_LOCK)
+	if (cxld->config.flags & CXL_DECODER_F_LOCK)
 		return;
 
 	if (port->commit_end == id)
@@ -944,7 +944,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
 
-	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
 
 	/* Userspace is now responsible for reconfiguring this decoder */
 	if (is_endpoint_decoder(&cxld->dev)) {
@@ -971,23 +971,23 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	if (!len)
 		return -ENOENT;
 
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->commit = NULL;
 	cxld->reset = NULL;
-	cxld->hpa_range = info->dvsec_range[which];
+	cxld->config.hpa_range = info->dvsec_range[which];
 
 	/*
 	 * Set the emulated decoder as locked pending additional support to
 	 * change the range registers at run time.
 	 */
-	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
-	port->commit_end = cxld->id;
+	cxld->config.flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	port->commit_end = cxld->config.id;
 
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
 	if (rc) {
 		dev_err(&port->dev,
 			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
-			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
+			port->id, cxld->config.id, *dpa_base, *dpa_base + len - 1, rc);
 		return rc;
 	}
 	*dpa_base += len;
@@ -1030,36 +1030,36 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		size = 0;
 	if (base == U64_MAX || size == U64_MAX) {
 		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
-			 port->id, cxld->id);
+			 port->id, cxld->config.id);
 		return -ENXIO;
 	}
 
 	if (info)
 		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-	cxld->hpa_range = (struct range) {
+	cxld->config.hpa_range = (struct range) {
 		.start = base,
 		.end = base + size - 1,
 	};
 
 	/* decoders are enabled if committed */
 	if (committed) {
-		cxld->flags |= CXL_DECODER_F_ENABLE;
+		cxld->config.flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
-			cxld->flags |= CXL_DECODER_F_LOCK;
+			cxld->config.flags |= CXL_DECODER_F_LOCK;
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl))
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+			cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
 		else
-			cxld->target_type = CXL_DECODER_DEVMEM;
+			cxld->config.target_type = CXL_DECODER_DEVMEM;
 
 		guard(rwsem_write)(&cxl_rwsem.region);
-		if (cxld->id != cxl_num_decoders_committed(port)) {
+		if (cxld->config.id != cxl_num_decoders_committed(port)) {
 			dev_warn(&port->dev,
 				 "decoder%d.%d: Committed out of order\n",
-				 port->id, cxld->id);
+				 port->id, cxld->config.id);
 			return -ENXIO;
 		}
 
-		port->commit_end = cxld->id;
+		port->commit_end = cxld->config.id;
 	} else {
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1070,46 +1070,46 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			 * more precision.
 			 */
 			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
-				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+				cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
 			else
-				cxld->target_type = CXL_DECODER_DEVMEM;
+				cxld->config.target_type = CXL_DECODER_DEVMEM;
 		} else {
 			/* To be overridden by region type at commit time */
-			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+			cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
 		}
 
 		if (!FIELD_GET(CXL_HDM_DECODER0_CTRL_HOSTONLY, ctrl) &&
-		    cxld->target_type == CXL_DECODER_HOSTONLYMEM) {
+		    cxld->config.target_type == CXL_DECODER_HOSTONLYMEM) {
 			ctrl |= CXL_HDM_DECODER0_CTRL_HOSTONLY;
 			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 		}
 	}
 	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
-			  &cxld->interleave_ways);
+			  &cxld->config.interleave_ways);
 	if (rc) {
 		dev_warn(&port->dev,
 			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
+			 port->id, cxld->config.id, ctrl);
 		return rc;
 	}
 	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
-				 &cxld->interleave_granularity);
+				 &cxld->config.interleave_granularity);
 	if (rc) {
 		dev_warn(&port->dev,
 			 "decoder%d.%d: Invalid interleave granularity (ctrl: %#x)\n",
-			 port->id, cxld->id, ctrl);
+			 port->id, cxld->config.id, ctrl);
 		return rc;
 	}
 
 	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
-		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
-		cxld->interleave_ways, cxld->interleave_granularity);
+		port->id, cxld->config.id, cxld->config.hpa_range.start, cxld->config.hpa_range.end,
+		cxld->config.interleave_ways, cxld->config.interleave_granularity);
 
 	if (!cxled) {
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
 		target_list.value = (hi << 32) + lo;
-		for (i = 0; i < cxld->interleave_ways; i++)
+		for (i = 0; i < cxld->config.interleave_ways; i++)
 			cxld->target_map[i] = target_list.target_id[i];
 
 		return 0;
@@ -1118,11 +1118,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (!committed)
 		return 0;
 
-	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
+	dpa_size = div_u64_rem(size, cxld->config.interleave_ways, &remainder);
 	if (remainder) {
 		dev_err(&port->dev,
 			"decoder%d.%d: invalid committed configuration size: %#llx ways: %d\n",
-			port->id, cxld->id, size, cxld->interleave_ways);
+			port->id, cxld->config.id, size, cxld->config.interleave_ways);
 		return -ENXIO;
 	}
 	lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
@@ -1132,7 +1132,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (rc) {
 		dev_err(&port->dev,
 			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
-			port->id, cxld->id, *dpa_base,
+			port->id, cxld->config.id, *dpa_base,
 			*dpa_base + dpa_size + skip - 1, rc);
 		return rc;
 	}
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 905892cfedef..f72cd8f50e77 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -231,10 +231,10 @@ static int dvsec_range_allowed(struct device *dev, const void *arg)
 
 	cxld = to_cxl_decoder(dev);
 
-	if (!(cxld->flags & CXL_DECODER_F_RAM))
+	if (!(cxld->config.flags & CXL_DECODER_F_RAM))
 		return 0;
 
-	return range_contains(&cxld->hpa_range, dev_range);
+	return range_contains(&cxld->config.hpa_range, dev_range);
 }
 
 static void disable_hdm(void *_cxlhdm)
@@ -668,12 +668,12 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
 		return 0;
 
 	cxld = to_cxl_decoder(dev);
-	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
+	if ((cxld->config.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
 	cxlhdm = dev_get_drvdata(&port->dev);
 	hdm = cxlhdm->regs.hdm_decoder;
-	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->config.id));
 
 	return !FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl);
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5dc2815d82d8..84374873f3d0 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -129,7 +129,7 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%#llx\n", cxld->hpa_range.start);
+	return sysfs_emit(buf, "%#llx\n", cxld->config.hpa_range.start);
 }
 static DEVICE_ATTR_ADMIN_RO(start);
 
@@ -138,7 +138,7 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->hpa_range));
+	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->config.hpa_range));
 }
 static DEVICE_ATTR_RO(size);
 
@@ -149,7 +149,7 @@ static ssize_t name##_show(struct device *dev,                       \
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);              \
                                                                      \
 	return sysfs_emit(buf, "%s\n",                               \
-			  (cxld->flags & (flag)) ? "1" : "0");       \
+			  (cxld->config.flags & (flag)) ? "1" : "0");       \
 }                                                                    \
 static DEVICE_ATTR_RO(name)
 
@@ -164,7 +164,7 @@ static ssize_t target_type_show(struct device *dev,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	switch (cxld->target_type) {
+	switch (cxld->config.target_type) {
 	case CXL_DECODER_DEVMEM:
 		return sysfs_emit(buf, "accelerator\n");
 	case CXL_DECODER_HOSTONLYMEM:
@@ -180,14 +180,14 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
 	ssize_t offset = 0;
 	int i, rc = 0;
 
-	for (i = 0; i < cxld->interleave_ways; i++) {
+	for (i = 0; i < cxld->config.interleave_ways; i++) {
 		struct cxl_dport *dport = cxlsd->target[i];
 		struct cxl_dport *next = NULL;
 
 		if (!dport)
 			break;
 
-		if (i + 1 < cxld->interleave_ways)
+		if (i + 1 < cxld->config.interleave_ways)
 			next = cxlsd->target[i + 1];
 		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
 				   next ? "," : "");
@@ -314,7 +314,7 @@ static ssize_t interleave_granularity_show(struct device *dev,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%d\n", cxld->interleave_granularity);
+	return sysfs_emit(buf, "%d\n", cxld->config.interleave_granularity);
 }
 
 static DEVICE_ATTR_RO(interleave_granularity);
@@ -324,7 +324,7 @@ static ssize_t interleave_ways_show(struct device *dev,
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
 
-	return sysfs_emit(buf, "%d\n", cxld->interleave_ways);
+	return sysfs_emit(buf, "%d\n", cxld->config.interleave_ways);
 }
 
 static DEVICE_ATTR_RO(interleave_ways);
@@ -368,14 +368,14 @@ static bool can_create_pmem(struct cxl_root_decoder *cxlrd)
 {
 	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM;
 
-	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
+	return (cxlrd->cxlsd.cxld.config.flags & flags) == flags;
 }
 
 static bool can_create_ram(struct cxl_root_decoder *cxlrd)
 {
 	unsigned long flags = CXL_DECODER_F_TYPE3 | CXL_DECODER_F_RAM;
 
-	return (cxlrd->cxlsd.cxld.flags & flags) == flags;
+	return (cxlrd->cxlsd.cxld.config.flags & flags) == flags;
 }
 
 static umode_t cxl_root_decoder_visible(struct kobject *kobj, struct attribute *a, int n)
@@ -450,7 +450,7 @@ static void __cxl_decoder_release(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 
-	ida_free(&port->decoder_ida, cxld->id);
+	ida_free(&port->decoder_ida, cxld->config.id);
 	put_device(&port->dev);
 }
 
@@ -1646,7 +1646,7 @@ static int update_decoder_targets(struct device *dev, void *data)
 	cxld = &cxlsd->cxld;
 	guard(rwsem_write)(&cxl_rwsem.region);
 
-	for (i = 0; i < cxld->interleave_ways; i++) {
+	for (i = 0; i < cxld->config.interleave_ways; i++) {
 		if (cxld->target_map[i] == dport->port_id) {
 			cxlsd->target[i] = dport;
 			dev_dbg(dev, "dport%d found in target list, index %d\n",
@@ -1952,7 +1952,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 		return 0;
 
 	guard(rwsem_write)(&cxl_rwsem.region);
-	for (i = 0; i < cxlsd->cxld.interleave_ways; i++) {
+	for (i = 0; i < cxlsd->cxld.config.interleave_ways; i++) {
 		struct cxl_dport *dport = find_dport(port, cxld->target_map[i]);
 
 		if (!dport) {
@@ -1988,7 +1988,7 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 
 	/* need parent to stick around to release the id */
 	get_device(&port->dev);
-	cxld->id = rc;
+	cxld->config.id = rc;
 
 	dev = &cxld->dev;
 	device_initialize(dev);
@@ -1998,10 +1998,10 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 	dev->bus = &cxl_bus_type;
 
 	/* Pre initialize an "empty" decoder */
-	cxld->interleave_ways = 1;
-	cxld->interleave_granularity = PAGE_SIZE;
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-	cxld->hpa_range = (struct range) {
+	cxld->config.interleave_ways = 1;
+	cxld->config.interleave_granularity = PAGE_SIZE;
+	cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->config.hpa_range = (struct range) {
 		.start = 0,
 		.end = -1,
 	};
@@ -2172,7 +2172,7 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld)
 	if (WARN_ON_ONCE(IS_ERR(cxld)))
 		return PTR_ERR(cxld);
 
-	if (cxld->interleave_ways < 1)
+	if (cxld->config.interleave_ways < 1)
 		return -EINVAL;
 
 	dev = &cxld->dev;
@@ -2182,14 +2182,14 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld)
 		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
 
 		rc = decoder_populate_targets(cxlsd, port);
-		if (rc && (cxld->flags & CXL_DECODER_F_ENABLE)) {
+		if (rc && (cxld->config.flags & CXL_DECODER_F_ENABLE)) {
 			dev_err(&port->dev,
 				"Failed to populate active decoder targets\n");
 			return rc;
 		}
 	}
 
-	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
+	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->config.id);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index bb51e67f25f5..8cfc06df3134 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -502,8 +502,8 @@ static int set_interleave_ways(struct cxl_region *cxlr, int val)
 	 * Even for x3, x6, and x12 interleaves the region interleave must be a
 	 * power of 2 multiple of the host bridge interleave.
 	 */
-	if (!is_power_of_2(val / cxld->interleave_ways) ||
-	    (val % cxld->interleave_ways)) {
+	if (!is_power_of_2(val / cxld->config.interleave_ways) ||
+	    (val % cxld->config.interleave_ways)) {
 		dev_dbg(&cxlr->dev, "invalid interleave: %d\n", val);
 		return -EINVAL;
 	}
@@ -580,7 +580,7 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
 	 * with a granularity greater than the root interleave result in invalid
 	 * DPA translations (invalid to support).
 	 */
-	if (cxld->interleave_ways > 1 && val != cxld->interleave_granularity)
+	if (cxld->config.interleave_ways > 1 && val != cxld->config.interleave_granularity)
 		return -EINVAL;
 
 	lockdep_assert_held_write(&cxl_rwsem.region);
@@ -880,7 +880,7 @@ static int check_commit_order(struct device *dev, void *data)
 	 * order shutdown has occurred, block further allocations until
 	 * that is resolved
 	 */
-	if (((cxld->flags & CXL_DECODER_F_ENABLE) == 0))
+	if (((cxld->config.flags & CXL_DECODER_F_ENABLE) == 0))
 		return -EBUSY;
 	return 0;
 }
@@ -896,7 +896,7 @@ static int match_free_decoder(struct device *dev, const void *data)
 
 	cxld = to_cxl_decoder(dev);
 
-	if (cxld->id != port->commit_end + 1)
+	if (cxld->config.id != port->commit_end + 1)
 		return 0;
 
 	if (cxld->region) {
@@ -942,7 +942,7 @@ static int match_auto_decoder(struct device *dev, const void *data)
 		return 0;
 
 	cxld = to_cxl_decoder(dev);
-	r = &cxld->hpa_range;
+	r = &cxld->config.hpa_range;
 
 	if (spa_maps_hpa(p, r))
 		return 1;
@@ -1003,10 +1003,10 @@ static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_iter,
 	 * starting address has the lesser id.
 	 */
 	dev_dbg(&cxld->dev, "check for HPA violation %s:%d < %s:%d\n",
-		dev_name(&cxld->dev), cxld->id,
-		dev_name(&cxld_iter->dev), cxld_iter->id);
+		dev_name(&cxld->dev), cxld->config.id,
+		dev_name(&cxld_iter->dev), cxld_iter->config.id);
 
-	if (cxld_iter->id > cxld->id)
+	if (cxld_iter->config.id > cxld->config.id)
 		return true;
 
 	return false;
@@ -1137,11 +1137,11 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
 	 */
 	dev_WARN_ONCE(&cxlr->dev,
 		      port == cxled_to_port(cxled) &&
-			      cxld->target_type != cxlr->type,
+			      cxld->config.target_type != cxlr->type,
 		      "%s:%s mismatch decoder type %d -> %d\n",
 		      dev_name(&cxled_to_memdev(cxled)->dev),
-		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
-	cxld->target_type = cxlr->type;
+		      dev_name(&cxld->dev), cxld->config.target_type, cxlr->type);
+	cxld->config.target_type = cxlr->type;
 	cxl_rr->decoder = cxld;
 	return 0;
 }
@@ -1162,12 +1162,12 @@ static void cxl_region_setup_flags(struct cxl_region *cxlr,
 			set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
 	}
 
-	if (cxld->flags & CXL_DECODER_F_LOCK) {
+	if (cxld->config.flags & CXL_DECODER_F_LOCK) {
 		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
 		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
 	}
 
-	if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
+	if (cxld->config.flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
 		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
 }
 
@@ -1483,7 +1483,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			distance *= cxl_rr_iter->nr_targets;
 			iter = to_cxl_port(iter->dev.parent);
 		} while (!is_cxl_root(iter));
-		distance *= cxlrd->cxlsd.cxld.interleave_ways;
+		distance *= cxlrd->cxlsd.cxld.config.interleave_ways;
 
 		for (i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
@@ -1505,7 +1505,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 		 * root IG != region IG.
 		 */
 		parent_ig = p->interleave_granularity;
-		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
+		parent_iw = cxlrd->cxlsd.cxld.config.interleave_ways;
 		/*
 		 * For purposes of address bit routing, use power-of-2 math for
 		 * switch ports.
@@ -1518,8 +1518,8 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
 		parent_rr = cxl_rr_load(parent_port, cxlr);
 		parent_cxld = parent_rr->decoder;
-		parent_ig = parent_cxld->interleave_granularity;
-		parent_iw = parent_cxld->interleave_ways;
+		parent_ig = parent_cxld->config.interleave_granularity;
+		parent_iw = parent_cxld->config.interleave_ways;
 	}
 
 	rc = granularity_to_eig(parent_ig, &peig);
@@ -1575,10 +1575,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 	}
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
-		if (cxld->interleave_ways != iw ||
-		    (iw > 1 && cxld->interleave_granularity != ig) ||
-		    !spa_maps_hpa(p, &cxld->hpa_range) ||
-		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
+		if (cxld->config.interleave_ways != iw ||
+		    (iw > 1 && cxld->config.interleave_granularity != ig) ||
+		    !spa_maps_hpa(p, &cxld->config.hpa_range) ||
+		    ((cxld->config.flags & CXL_DECODER_F_ENABLE) == 0)) {
 			dev_err(&cxlr->dev,
 				"%s:%s %s expected iw: %d ig: %d %pr\n",
 				dev_name(port->uport_dev), dev_name(&port->dev),
@@ -1586,10 +1586,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			dev_err(&cxlr->dev,
 				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
 				dev_name(port->uport_dev), dev_name(&port->dev),
-				__func__, cxld->interleave_ways,
-				cxld->interleave_granularity,
-				str_enabled_disabled(cxld->flags & CXL_DECODER_F_ENABLE),
-				cxld->hpa_range.start, cxld->hpa_range.end);
+				__func__, cxld->config.interleave_ways,
+				cxld->config.interleave_granularity,
+				str_enabled_disabled(cxld->config.flags & CXL_DECODER_F_ENABLE),
+				cxld->config.hpa_range.start, cxld->config.hpa_range.end);
 			return -ENXIO;
 		}
 	} else {
@@ -1602,9 +1602,9 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 			return rc;
 		}
 
-		cxld->interleave_ways = iw;
-		cxld->interleave_granularity = ig;
-		cxld->hpa_range = (struct range) {
+		cxld->config.interleave_ways = iw;
+		cxld->config.interleave_granularity = ig;
+		cxld->config.hpa_range = (struct range) {
 			.start = p->res->start,
 			.end = p->res->end,
 		};
@@ -1657,7 +1657,7 @@ static void cxl_port_reset_targets(struct cxl_port *port,
 	cxl_rr->nr_targets_set = 0;
 
 	cxld = cxl_rr->decoder;
-	cxld->hpa_range = (struct range) {
+	cxld->config.hpa_range = (struct range) {
 		.start = 0,
 		.end = -1,
 	};
@@ -1804,7 +1804,7 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
 	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
 	struct cxl_decoder *cxld = &cxlsd->cxld;
-	int iw = cxld->interleave_ways;
+	int iw = cxld->config.interleave_ways;
 	struct cxl_port *iter;
 	int rc;
 
@@ -1902,7 +1902,7 @@ static int match_switch_decoder_by_range(struct device *dev,
 		return 0;
 
 	cxlsd = to_cxl_switch_decoder(dev);
-	r1 = &cxlsd->cxld.hpa_range;
+	r1 = &cxlsd->cxld.config.hpa_range;
 
 	if (is_root_decoder(dev))
 		return range_contains(r1, r2);
@@ -1929,7 +1929,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
 		return rc;
 	}
 	cxlsd = to_cxl_switch_decoder(dev);
-	*ways = cxlsd->cxld.interleave_ways;
+	*ways = cxlsd->cxld.config.interleave_ways;
 
 	for (int i = 0; i < *ways; i++) {
 		if (cxlsd->target[i] == port->parent_dport) {
@@ -2105,10 +2105,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (cxled->cxld.target_type != cxlr->type) {
+	if (cxled->cxld.config.target_type != cxlr->type) {
 		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
 			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
-			cxled->cxld.target_type, cxlr->type);
+			cxled->cxld.config.target_type, cxlr->type);
 		return -ENXIO;
 	}
 
@@ -2194,9 +2194,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		cxl_region_shared_upstream_bandwidth_update(cxlr);
 	}
 
-	cxled->cxld.interleave_ways = p->interleave_ways;
-	cxled->cxld.interleave_granularity = p->interleave_granularity;
-	cxled->cxld.hpa_range = (struct range) {
+	cxled->cxld.config.interleave_ways = p->interleave_ways;
+	cxled->cxld.config.interleave_granularity = p->interleave_granularity;
+	cxled->cxld.config.hpa_range = (struct range) {
 		.start = p->res->start,
 		.end = p->res->end,
 	};
@@ -2320,7 +2320,7 @@ __cxl_decoder_detach(struct cxl_region *cxlr,
 	}
 	p->targets[cxled->pos] = NULL;
 	p->nr_targets--;
-	cxled->cxld.hpa_range = (struct range) {
+	cxled->cxld.config.hpa_range = (struct range) {
 		.start = 0,
 		.end = -1,
 	};
@@ -2992,7 +2992,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	}
 
 	/* Iterate until commit_end is reached */
-	if (cxled->cxld.id == ctx->port->commit_end) {
+	if (cxled->cxld.config.id == ctx->port->commit_end) {
 		ctx->offset = cxled->dpa_res->end + 1;
 		ctx->part = cxled->part;
 		return 1;
@@ -3315,10 +3315,10 @@ static u64 restore_parent(u64 addr, u64 pos, u64 gran, u64 ways)
 static u64 unaligned_dpa_to_hpa(struct cxl_decoder *cxld,
 				struct cxl_region_params *p, int pos, u64 dpa)
 {
-	int ways_port = p->interleave_ways / cxld->interleave_ways;
+	int ways_port = p->interleave_ways / cxld->config.interleave_ways;
 	int gran_port = p->interleave_granularity;
-	int gran_hb = cxld->interleave_granularity;
-	int ways_hb = cxld->interleave_ways;
+	int gran_hb = cxld->config.interleave_granularity;
+	int ways_hb = cxld->config.interleave_ways;
 	int pos_port, pos_hb, gran_shift;
 	u64 hpa_port = 0;
 
@@ -3365,7 +3365,7 @@ static bool region_is_unaligned_mod3(struct cxl_region *cxlr)
 	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
 	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
 	struct cxl_region_params *p = &cxlr->params;
-	int hbiw = cxld->interleave_ways;
+	int hbiw = cxld->config.interleave_ways;
 	u64 rem;
 
 	if (is_power_of_2(hbiw))
@@ -3480,8 +3480,8 @@ static int unaligned_region_offset_to_dpa_result(struct cxl_region *cxlr,
 	 * a dpa_offset independent of the target device and then enumerate
 	 * and test that dpa_offset against each candidate endpoint decoder.
 	 */
-	gran = cxld->interleave_granularity;
-	interleave_width = gran * cxld->interleave_ways;
+	gran = cxld->config.interleave_granularity;
+	interleave_width = gran * cxld->config.interleave_ways;
 	interleave_index = div64_u64(offset, interleave_width);
 	gran_offset = do_div(tmp, gran);
 
@@ -3581,7 +3581,7 @@ static int match_root_decoder(struct device *dev, const void *data)
 		return 0;
 
 	cxlrd = to_cxl_root_decoder(dev);
-	r1 = &cxlrd->cxlsd.cxld.hpa_range;
+	r1 = &cxlrd->cxlsd.cxld.config.hpa_range;
 
 	return range_contains(r1, r2);
 }
@@ -3786,7 +3786,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
 				       atomic_read(&cxlrd->region_id),
-				       cxled->cxld.target_type);
+				       cxled->cxld.config.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {
@@ -3829,9 +3829,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
 
 	ctx = (struct cxl_region_context) {
 		.cxled = cxled,
-		.hpa_range = cxled->cxld.hpa_range,
-		.interleave_ways = cxled->cxld.interleave_ways,
-		.interleave_granularity = cxled->cxld.interleave_granularity,
+		.hpa_range = cxled->cxld.config.hpa_range,
+		.interleave_ways = cxled->cxld.config.interleave_ways,
+		.interleave_granularity = cxled->cxld.config.interleave_granularity,
 	};
 
 	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 44ff3334648c..688350c7c5fb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -281,7 +281,7 @@ enum cxl_decoder_state {
  * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
  * @cxld: base cxl_decoder_object
  * @dpa_res: actively claimed DPA span of this decoder
- * @skip: offset into @dpa_res where @cxld.hpa_range maps
+ * @skip: offset into @dpa_res where @cxld.config.hpa_range maps
  * @state: autodiscovery state
  * @part: partition index this decoder maps
  * @pos: interleave position in @cxld.region
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c7c91e8dc51d..9a0cbcd230b2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -966,7 +966,7 @@ static int cxl_endpoint_decoder_clear_reset_flags(struct device *dev, void *data
 		return 0;
 
 	cxled = to_cxl_endpoint_decoder(dev);
-	cxled->cxld.flags &= ~CXL_DECODER_F_RESET_MASK;
+	cxled->cxld.config.flags &= ~CXL_DECODER_F_RESET_MASK;
 
 	return 0;
 }
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c12fd0b89883..b369d3e3876d 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -40,7 +40,7 @@ static int discover_region(struct device *dev, void *unused)
 		return 0;
 
 	cxled = to_cxl_endpoint_decoder(dev);
-	if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
+	if ((cxled->cxld.config.flags & CXL_DECODER_F_ENABLE) == 0)
 		return 0;
 
 	if (cxled->state != CXL_DECODER_STATE_AUTO)
@@ -56,7 +56,7 @@ static int discover_region(struct device *dev, void *unused)
 	rc = cxl_add_to_region(cxled);
 	if (rc)
 		dev_dbg(dev, "failed to add to region: %#llx-%#llx\n",
-			cxled->cxld.hpa_range.start, cxled->cxld.hpa_range.end);
+			cxled->cxld.config.hpa_range.start, cxled->cxld.config.hpa_range.end);
 
 	return 0;
 }
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 613dab8150c7..6d6e564be27a 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -36,15 +36,31 @@ enum cxl_decoder_type {
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
 /**
- * struct cxl_decoder - Common CXL HDM Decoder Attributes
- * @dev: this decoder's device
+ * struct cxl_decoder_config - common CXL decoder configuration and state
  * @id: kernel device name id
  * @hpa_range: Host physical address range mapped by this decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
- * @region: currently assigned region for this decoder
  * @flags: memory type capabilities and locking
+ *
+ * This is not a complete snapshot of the hardware registers. Switch target
+ * lists and endpoint DPA skip values are not tracked in this common structure.
+ */
+struct cxl_decoder_config {
+	int id;
+	struct range hpa_range;
+	int interleave_ways;
+	int interleave_granularity;
+	enum cxl_decoder_type target_type;
+	unsigned long flags;
+};
+
+/**
+ * struct cxl_decoder - Common CXL HDM Decoder Attributes
+ * @dev: this decoder's device
+ * @config: common decoder configuration and state
+ * @region: currently assigned region for this decoder
  * @target_map: cached copy of hardware port-id list, available at init
  *              before all @dport objects have been instantiated. While
  *              dport id is 8bit, CFMWS interleave targets are 32bits.
@@ -53,13 +69,8 @@ enum cxl_decoder_type {
 */
 struct cxl_decoder {
 	struct device dev;
-	int id;
-	struct range hpa_range;
-	int interleave_ways;
-	int interleave_granularity;
-	enum cxl_decoder_type target_type;
+	struct cxl_decoder_config config;
 	struct cxl_region *region;
-	unsigned long flags;
 	u32 target_map[CXL_DECODER_MAX_INTERLEAVE];
 	int (*commit)(struct cxl_decoder *cxld);
 	void (*reset)(struct cxl_decoder *cxld);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 2921f1111870..034d3a923b2c 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -773,7 +773,7 @@ static int map_targets(struct device *dev, void *data)
  * id into the low bits.
  *
  * The key is formed as:
- *     ((unsigned long)port->uport_dev << 4) | cxld->id
+ *     ((unsigned long)port->uport_dev << 4) | cxld->config.id
  *
  * The low bits hold the decoder id (which must fit in 4 bits) while
  * the remaining bits identify the upstream port. This key is only used
@@ -783,9 +783,9 @@ static unsigned long cxld_registry_index(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
 
-	dev_WARN_ONCE(&port->dev, cxld->id >= 16,
-		      "decoder id:%d out of range\n", cxld->id);
-	return (((unsigned long)port->uport_dev) << 4) | cxld->id;
+	dev_WARN_ONCE(&port->dev, cxld->config.id >= 16,
+		      "decoder id:%d out of range\n", cxld->config.id);
+	return (((unsigned long)port->uport_dev) << 4) | cxld->config.id;
 }
 
 struct cxl_test_decoder {
@@ -801,14 +801,15 @@ static struct cxl_test_decoder *cxld_registry_find(struct cxl_decoder *cxld)
 	return xa_load(&decoder_registry, cxld_registry_index(cxld));
 }
 
-#define dbg_cxld(port, msg, cxld)                                                       \
-	do {                                                                            \
-		struct cxl_decoder *___d = (cxld);                                      \
-		dev_dbg((port)->uport_dev,                                              \
+#define dbg_cxld(port, msg, cxld)                                      \
+	do {                                                              \
+		struct cxl_decoder *___d = (cxld);                        \
+		const struct cxl_decoder_config *___c = &___d->config;    \
+		dev_dbg((port)->uport_dev,                                \
 			"decoder%d: %s range: %#llx-%#llx iw: %d ig: %d flags: %#lx\n", \
-			___d->id, msg, ___d->hpa_range.start,                           \
-			___d->hpa_range.end + 1, ___d->interleave_ways,                 \
-			___d->interleave_granularity, ___d->flags);                     \
+			___c->id, msg, ___c->hpa_range.start,               \
+			___c->hpa_range.end + 1, ___c->interleave_ways,     \
+			___c->interleave_granularity, ___c->flags);         \
 	} while (0)
 
 static int mock_decoder_commit(struct cxl_decoder *cxld);
@@ -817,12 +818,7 @@ static void init_disabled_mock_decoder(struct cxl_decoder *cxld);
 
 static void cxld_copy(struct cxl_decoder *a, struct cxl_decoder *b)
 {
-	a->id = b->id;
-	a->hpa_range = b->hpa_range;
-	a->interleave_ways = b->interleave_ways;
-	a->interleave_granularity = b->interleave_granularity;
-	a->target_type = b->target_type;
-	a->flags = b->flags;
+	a->config = b->config;
 	a->commit = mock_decoder_commit;
 	a->reset = mock_decoder_reset;
 }
@@ -847,7 +843,7 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
 		struct cxl_switch_decoder *cxlsd =
 			to_cxl_switch_decoder(&cxld->dev);
 
-		if (!(td->cxlsd.cxld.flags & CXL_DECODER_F_ENABLE))
+		if (!(td->cxlsd.cxld.config.flags & CXL_DECODER_F_ENABLE))
 			return 0;
 
 		dbg_cxld(port, "restore", &td->cxlsd.cxld);
@@ -860,13 +856,13 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
 			cxld->target_map[i] = td->cxlsd.cxld.target_map[i];
 		}
 
-		port->commit_end = cxld->id;
+		port->commit_end = cxld->config.id;
 
 	} else {
 		struct cxl_endpoint_decoder *cxled =
 			to_cxl_endpoint_decoder(&cxld->dev);
 
-		if (!(td->cxled.cxld.flags & CXL_DECODER_F_ENABLE))
+		if (!(td->cxled.cxld.config.flags & CXL_DECODER_F_ENABLE))
 			return 0;
 
 		dbg_cxld(port, "restore", &td->cxled.cxld);
@@ -881,7 +877,7 @@ static int cxld_registry_restore(struct cxl_decoder *cxld,
 			init_disabled_mock_decoder(cxld);
 			return rc;
 		}
-		port->commit_end = cxld->id;
+		port->commit_end = cxld->config.id;
 	}
 
 	return 0;
@@ -915,7 +911,7 @@ static void __cxld_registry_save(struct cxl_test_decoder *td,
 		td->cxled.state = cxled->state;
 		td->cxled.skip = cxled->skip;
 
-		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
+		if (!(cxld->config.flags & CXL_DECODER_F_ENABLE)) {
 			td->dpa_range.start = 0;
 			td->dpa_range.end = -1;
 		} else if (cxled->dpa_res) {
@@ -952,9 +948,9 @@ static void cxld_registry_update(struct cxl_decoder *cxld)
 static int mock_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
-	int id = cxld->id;
+	int id = cxld->config.id;
 
-	if (cxld->flags & CXL_DECODER_F_ENABLE)
+	if (cxld->config.flags & CXL_DECODER_F_ENABLE)
 		return 0;
 
 	dev_dbg(&port->dev, "%s commit\n", dev_name(&cxld->dev));
@@ -967,7 +963,7 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 	}
 
 	port->commit_end++;
-	cxld->flags |= CXL_DECODER_F_ENABLE;
+	cxld->config.flags |= CXL_DECODER_F_ENABLE;
 	if (is_endpoint_decoder(&cxld->dev)) {
 		struct cxl_endpoint_decoder *cxled =
 			to_cxl_endpoint_decoder(&cxld->dev);
@@ -982,9 +978,9 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 static void mock_decoder_reset(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
-	int id = cxld->id;
+	int id = cxld->config.id;
 
-	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
+	if ((cxld->config.flags & CXL_DECODER_F_ENABLE) == 0)
 		return;
 
 	dev_dbg(&port->dev, "%s reset\n", dev_name(&cxld->dev));
@@ -994,7 +990,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 		dev_dbg(&port->dev,
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
-	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+	cxld->config.flags &= ~CXL_DECODER_F_ENABLE;
 
 	if (is_endpoint_decoder(&cxld->dev)) {
 		struct cxl_endpoint_decoder *cxled =
@@ -1005,7 +1001,7 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 	}
 	if (decoder_reset_preserve_registry)
 		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
-			cxld->id);
+			cxld->config.id);
 	else
 		cxld_registry_update(cxld);
 }
@@ -1030,12 +1026,12 @@ static struct cxl_test_decoder *cxld_registry_new(struct cxl_decoder *cxld)
 
 static void init_disabled_mock_decoder(struct cxl_decoder *cxld)
 {
-	cxld->hpa_range.start = 0;
-	cxld->hpa_range.end = -1;
-	cxld->interleave_ways = 1;
-	cxld->interleave_granularity = 0;
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-	cxld->flags = 0;
+	cxld->config.hpa_range.start = 0;
+	cxld->config.hpa_range.end = -1;
+	cxld->config.interleave_ways = 1;
+	cxld->config.interleave_granularity = 0;
+	cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->config.flags = 0;
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 
@@ -1058,14 +1054,14 @@ static void init_disabled_mock_decoder(struct cxl_decoder *cxld)
 
 static void default_mock_decoder(struct cxl_decoder *cxld)
 {
-	cxld->hpa_range = (struct range){
+	cxld->config.hpa_range = (struct range){
 		.start = 0,
 		.end = -1,
 	};
 
-	cxld->interleave_ways = 1;
-	cxld->interleave_granularity = 256;
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->config.interleave_ways = 1;
+	cxld->config.interleave_granularity = 256;
+	cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 
@@ -1080,7 +1076,7 @@ static int match_decoder_by_index(struct device *dev, const void *data)
 	if (!is_switch_decoder(dev))
 		return 0;
 	cxld = to_cxl_decoder(dev);
-	return cxld->id == target_id;
+	return cxld->config.id == target_id;
 }
 
 /*
@@ -1093,11 +1089,11 @@ static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
 {
 	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
 
-	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
-	cxld->interleave_ways = 2;
-	cxld->interleave_granularity = 4096;
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxld->config.hpa_range = DEFINE_RANGE(base, base - 1);
+	cxld->config.interleave_ways = 2;
+	cxld->config.interleave_granularity = 4096;
+	cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->config.flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
 	cxled->state = CXL_DECODER_STATE_AUTO;
 	/* decoder[0] reserved [0, size/2), empty decoders sit at that watermark */
 	devm_cxl_dpa_reserve(cxled, mock_auto_region_size / 2, 0, 0);
@@ -1108,11 +1104,11 @@ static void size_zero_mock_decoder_ep(struct cxl_decoder *cxld, u64 base)
 static void size_zero_mock_decoder_sw(struct cxl_decoder *cxld, u64 base,
 				      int level)
 {
-	cxld->flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-	cxld->interleave_ways = level == 0 ? 2 : 1;
-	cxld->interleave_granularity = 4096;
-	cxld->hpa_range = DEFINE_RANGE(base, base - 1);
+	cxld->config.flags = CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->config.interleave_ways = level == 0 ? 2 : 1;
+	cxld->config.interleave_granularity = 4096;
+	cxld->config.hpa_range = DEFINE_RANGE(base, base - 1);
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 }
@@ -1147,7 +1143,7 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > (mock_zero_size_decoders ? 2 : 0))
+	    pdev->id > 4 || cxld->config.id > (mock_zero_size_decoders ? 2 : 0))
 		return MOCK_DECODER_INIT_DEFAULT;
 
 	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
@@ -1159,9 +1155,9 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
 	bool enabled;
 
 	if (is_switch_decoder(&cxld->dev))
-		enabled = td->cxlsd.cxld.flags & CXL_DECODER_F_ENABLE;
+		enabled = td->cxlsd.cxld.config.flags & CXL_DECODER_F_ENABLE;
 	else
-		enabled = td->cxled.cxld.flags & CXL_DECODER_F_ENABLE;
+		enabled = td->cxled.cxld.config.flags & CXL_DECODER_F_ENABLE;
 
 	if (enabled)
 		return !cxld_registry_restore(cxld, td);
@@ -1183,19 +1179,19 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 	int id = 0;
 
 	base = window->base_hpa;
-	cxld->hpa_range = (struct range) {
+	cxld->config.hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
 	};
 
-	cxld->interleave_ways = 1;
-	eig_to_granularity(window->granularity, &cxld->interleave_granularity);
-	cxld->target_type = CXL_DECODER_DEVMEM;
-	cxld->flags = CXL_DECODER_F_ENABLE;
+	cxld->config.interleave_ways = 1;
+	eig_to_granularity(window->granularity, &cxld->config.interleave_granularity);
+	cxld->config.target_type = CXL_DECODER_DEVMEM;
+	cxld->config.flags = CXL_DECODER_F_ENABLE;
 	cxled->state = CXL_DECODER_STATE_AUTO;
-	port->commit_end = cxld->id;
+	port->commit_end = cxld->config.id;
 	devm_cxl_dpa_reserve(cxled, 0,
-			     mock_auto_region_size / cxld->interleave_ways, 0);
+			     mock_auto_region_size / cxld->config.interleave_ways, 0);
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 
@@ -1216,13 +1212,13 @@ static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
 
 	cxlsd = to_cxl_switch_decoder(dev);
 	cxld = &cxlsd->cxld;
-	cxld->target_type = CXL_DECODER_DEVMEM;
-	cxld->flags = CXL_DECODER_F_ENABLE;
+	cxld->config.target_type = CXL_DECODER_DEVMEM;
+	cxld->config.flags = CXL_DECODER_F_ENABLE;
 	root_port->commit_end = 0;
-	cxld->interleave_ways = 1;
-	cxld->interleave_granularity = 4096;
+	cxld->config.interleave_ways = 1;
+	cxld->config.interleave_granularity = 4096;
 	cxld->target_map[0] = dport->port_id;
-	cxld->hpa_range = (struct range) {
+	cxld->config.hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
 	};
@@ -1258,7 +1254,7 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 	int i;
 
 	/* Simulate missing cxl_mem.4 configuration */
-	if (hb0 && pdev->id == 4 && cxld->id == 0 && fail_autoassemble) {
+	if (hb0 && pdev->id == 4 && cxld->config.id == 0 && fail_autoassemble) {
 		default_mock_decoder(cxld);
 		return;
 	}
@@ -1274,25 +1270,25 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 	 * points at a zero-size decoder, exercising the zero-size
 	 * reservation and poison-by-endpoint code paths.
 	 */
-	if (cxld->id == 1 || cxld->id == 2) {
+	if (cxld->config.id == 1 || cxld->config.id == 2) {
 		size_zero_mock_decoder_ep(cxld, base);
-		port->commit_end = cxld->id;
+		port->commit_end = cxld->config.id;
 		WARN_ON_ONCE(!cxld_registry_new(cxld));
 		return;
 	}
-	cxld->hpa_range = (struct range) {
+	cxld->config.hpa_range = (struct range) {
 		.start = base,
 		.end = base + mock_auto_region_size - 1,
 	};
 
-	cxld->interleave_ways = 2;
-	eig_to_granularity(window->granularity, &cxld->interleave_granularity);
-	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-	cxld->flags = CXL_DECODER_F_ENABLE;
+	cxld->config.interleave_ways = 2;
+	eig_to_granularity(window->granularity, &cxld->config.interleave_granularity);
+	cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->config.flags = CXL_DECODER_F_ENABLE;
 	cxled->state = CXL_DECODER_STATE_AUTO;
-	port->commit_end = cxld->id;
+	port->commit_end = cxld->config.id;
 	devm_cxl_dpa_reserve(cxled, 0,
-			     mock_auto_region_size / cxld->interleave_ways, 0);
+			     mock_auto_region_size / cxld->config.interleave_ways, 0);
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 
@@ -1326,19 +1322,19 @@ static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 			cxlsd->cxld.target_map[0] = dport->port_id;
 		}
 		cxld = &cxlsd->cxld;
-		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
-		cxld->flags = CXL_DECODER_F_ENABLE;
+		cxld->config.target_type = CXL_DECODER_HOSTONLYMEM;
+		cxld->config.flags = CXL_DECODER_F_ENABLE;
 		iter->commit_end = 0;
 		/*
 		 * Switch targets 2 endpoints, while host bridge targets
 		 * one root port
 		 */
 		if (i == 0)
-			cxld->interleave_ways = 2;
+			cxld->config.interleave_ways = 2;
 		else
-			cxld->interleave_ways = 1;
-		cxld->interleave_granularity = 4096;
-		cxld->hpa_range = (struct range) {
+			cxld->config.interleave_ways = 1;
+		cxld->config.interleave_granularity = 4096;
+		cxld->config.hpa_range = (struct range) {
 			.start = base,
 			.end = base + mock_auto_region_size - 1,
 		};
-- 
2.43.0

