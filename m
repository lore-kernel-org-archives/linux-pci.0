Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061942F1FE7;
	Sun, 15 Feb 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771173551; cv=fail; b=d2rIlnzU7qvbRSa791pdI7yiFvGwgKbgqWOCilO3gx0gcxmz9g5D8suNm8WdjvdROyGnLwm9/N8O0+CXuRXS+mYV4nuccIz09tqbs/TRlry12m3IxmdmN2D7FY5jQ86Yu+2vqoxBObQb2/kYtdMAJjJMUt8Ii4vuqL+3zE/TdF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771173551; c=relaxed/simple;
	bh=yYPpkjnhy0ZFLQ37LXaMIFbOH9NQvFdbcGMcU5dJDEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5vbT3VJjn+lUYx3QwADvm3T8p6jYXLgXwxYmr9VyX6IpviO0g8RoX7RRk4u//PzsuOIGyDIUz2MGlST7ZDOG5jISpB6wJZikf/SmRUMfkM6W8JxZQuEoPVPMN7o3LwGeob4ZmRoLjcPZuCDhpTC0eIBOuGv7EGIPbbdB32hcWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=WUsiEFdV; arc=fail smtp.client-ip=52.101.229.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="WUsiEFdV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTIcL10kR3YeWhcjGKTGGzgcF9XiI+VHRVvusUXoG2tWJHALHs8U6dsROAj/EfLtg08CvcnuCOd8590/4kPu2QToMntlvwbXUX/6YwBl2UCh2eqvuay1A/wsvriUgq/8EdD+ve8FqkMqb2l/QvYxqe/ELAIaGMYLYGMR6gDdTd7hH/HTLExWsBfAiwuPXa8U8vYUYEyioxomWz1KmjJYWZjmn3umzIInpYcOCbsGfSVjLTUAzBgOpd6wXuAJTfrDKL8t0+auCDRaA2PeTThun4H+Bb9PHQlrSpZIjTizlkJsHKBYn/jijkS4R9tD6xGtj/dAIK0js24cCtYMqEmsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpMBWHmKo9m4Bn5DsWqxUnKAG8hRFfAVV32vx7GzjJU=;
 b=V5yu+dhhvCz8Z07fb23p5wy+7EySqINRh5JrMyXadQR3RaA0Tepe3CvbsV/76+zhPcKWnp+74+cS2YfbtEOnmd4qP8Edk8YMw+7gVsH7rGGGgGVs9rhQSmGkd+oD+DfzCMV/xP86BVdmXkpreSfCMIzMmEJ3TCVydQ4oRDv97QjQXc+eySFzFvmfODwa3E0V7voqvRZ1Uox5kpxv3ZG9VWLHCL0/UCRrKACWfsOc8i8xI7PKYXRJCHp2UMv4+Smdd0RJ+zVI5OpNU+NGElKrOsupDTn6Oqykd3koTDEIUKO1hzO2mz0iU/9LY+A97fa2b7CgrUj9tnckKSh5OoMyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpMBWHmKo9m4Bn5DsWqxUnKAG8hRFfAVV32vx7GzjJU=;
 b=WUsiEFdVNlzjYtD2Joqtn6M+2mQ7sJHU5SoQta/bAeEe4njf665eU0Uf2WNj3KNIW941Wsa6RH7Y7OcuAeKS+tii2I1Df/Q7dWHt1nyXUAuSZjNsD9TAyn7q8vA1sNOrMWQOc/mBQzR2lmpZLZ1DPVkRZZ20dufIHZdS6NvKzUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5196.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:34b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 16:39:05 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 16:39:05 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	heiko@sntech.de,
	kishon@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	cassel@kernel.org,
	shawn.lin@rock-chips.com,
	Frank.Li@nxp.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	ntb@lists.linux.dev
Subject: [PATCH v7 4/9] PCI: dwc: Record integrated eDMA register window
Date: Mon, 16 Feb 2026 01:38:42 +0900
Message-ID: <20260215163847.3522572-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215163847.3522572-1-den@valinux.co.jp>
References: <20260215163847.3522572-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0030.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab20b88-e354-40dc-e397-08de6cb0bb91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iJdOfjIOFZ4yFjyh5FyO87sxuUu0rg7+kmB0eO7f56WQ4QQ994DpG2J7xcJj?=
 =?us-ascii?Q?WYrOoZQCzCkFaoUiRfCuskfsgzWpGFljZ6bWzWNltWDtb3bONUHqyxvQY0zW?=
 =?us-ascii?Q?Op9jA6dyDqvyn1Nt1qGd2KWeHLce74cD5pd+/cwx3z7cDSwHpA5Zyq38nvLY?=
 =?us-ascii?Q?5Pg8M1ka7rUm6xoeGCcQWZnXhhQPzNZI8lmMBVQ6PacHe5pvWTqhRfjNrZSh?=
 =?us-ascii?Q?QJuAF35zDkA1+3S1Y2a9vZNiGzHg3P3MGnjSl4Mz8viRAOW3zfwPT/+i7I8m?=
 =?us-ascii?Q?kWko2B35lu76392Zwl6E/O97HovqI8jWE586WpadAiL/cVEREtIH7S2hXbib?=
 =?us-ascii?Q?jkOG88o5hnGK4ztjDvaECEBEzoC03EuusxyRRpSNUeL97bKzIgj2BHNODxc9?=
 =?us-ascii?Q?nLmQv3tTdhQP336Vq6ZqwnIJEIjXTsWTYdlQLc5rtXPv/Rwy0QpjNE7Q2wAJ?=
 =?us-ascii?Q?5c6LPrlvd/WFHHtQjdni9rd5wpv9BY0ibkeF6vWNj1wHv9areBXLtdAtzGxV?=
 =?us-ascii?Q?ZqbBUwQwMZrXVEZ7mtLuRusQhpYd+e4aAghVLJutm6+BZKl++lrxnTnkzdvZ?=
 =?us-ascii?Q?3n3AyzusUoLGDUcMJ7+UbmoHSgWxoQjwR4PgLRxlYBVF+t9WRozvgMQmvelO?=
 =?us-ascii?Q?jOY2aEvYTb+NndjG3zjrJ/fPsXk7ZtnPSLAAyNZFLpIEiNjscQC91mv/wcH0?=
 =?us-ascii?Q?bMB0sxIV9dprJnjOQgBaEtYyKPJHVBMoS79F8DIDGafsliEAG6kHsxsxjPjF?=
 =?us-ascii?Q?y5e8cEsrS81mTgAVw1bs38qPSg/CPKigwpYZ+RyIWIBcjDZYYuVQ4VIxs5EX?=
 =?us-ascii?Q?c3NJ5VKPvbgTi8avFfkw/r6XvwYoO0Yb3FKJdRfu6zDCAzn/CHXF9QRlEYTc?=
 =?us-ascii?Q?pt1HY5/0hvICOYErBuXJcnU1EKvpkJqD6wkrAKkwcheRBFwt58P0ZgdR3tS5?=
 =?us-ascii?Q?iKeeWXC19tp4k8XxROfOqUTflZ93PY4zAz7ufplmltxdKg1TeqkUejvchTEm?=
 =?us-ascii?Q?KQS4Af1REc2YlJqKoW/WbYDJFb1wrVD315LVx1H6FUQOwvjEo7v4aRGMznfI?=
 =?us-ascii?Q?mSh2FEjFS5oKdn39HzzDPGo+WzJXq4G14WirCoFH3KH/Q+F0ntngl8CvLueB?=
 =?us-ascii?Q?UmhqEjA2AFsk8PXThWRuN4Tk4mlCjAcp/C9wx8GqI0ZbzqSegTq29P1YZTMC?=
 =?us-ascii?Q?k8bNmlEuDqTIMOf3lhH73IVgbWaz/FkKkbe44OTjpu9p1zHDD8jxZA/EVZ6/?=
 =?us-ascii?Q?kp+Rp/a6LqSZbBaNE5V0ziGIT96khvY/+iRkQgVfuMiE2mkwTDDJCinpdTep?=
 =?us-ascii?Q?PfcLNAmm3Optriyp1ui8cn4ExQ7b3VTBy2xfXZIVPuEFqRTpDr3chg48kSJu?=
 =?us-ascii?Q?zn7AWV8C1IcV3J3Fpq5lb03XhLJhx5avfrtJx8sDZFGJeqPkC4rZxvN/3woI?=
 =?us-ascii?Q?Un7R/ZzYqqssn1P/8ai653mf50dkiIdNTSa7weN8gYuziaFTbFlNwcbZiXmX?=
 =?us-ascii?Q?bkVa/ccx+9Kl5eZAHhwHBFoy9onOL7exw+qWRNslq5+ssD9VP947RffalM26?=
 =?us-ascii?Q?Mm9iCzkf/yZ5ZoBx5G8y5tzo3THY10jI80X54OrNTc3eA4OpWZlBTHfsGG3O?=
 =?us-ascii?Q?RA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rcP7IzkN6CBclMVwMxL0WjovxTQp9TRaXn2sPr+VJeCIu3QUPXx7Oefvxt3+?=
 =?us-ascii?Q?mL2khNuJfef4hP9M4PTods1+o4PNasHKRmOmJO79gulG3RiUnhKdVwEv7HmH?=
 =?us-ascii?Q?BUxqQs7PMYTnBuDhI2rP7NCQLnK+aFXCbjWsBbxX9/RewSTV3uVwhP/NN0b5?=
 =?us-ascii?Q?2X5kQgB0dIsth8SoA/QY+97GVIQNl+9IA1VVHdPQ+lHQq/DFpZxhlc4sYf67?=
 =?us-ascii?Q?QJ0y7PShX8ECaboq0JnwqRV5mtG9To6r2HAkXjpU2sAPkbBupE2QoePtJL8F?=
 =?us-ascii?Q?4TJtTKck6h31anXWvjPVp8zo5O5Xc5MmV0tDA4SlaOOS0eT1M4qdU03InCXc?=
 =?us-ascii?Q?9S11KoWsp+D3FJVbCUz+W8rpqGGKL98cCJaDKf169lcU2G4aZCFR/kvIudOm?=
 =?us-ascii?Q?ldgSuI1zL6vpa6/bei5MPNHAUVhqeEU1SYrMjX+fFmMwyRKXKv9nDmFnBuRP?=
 =?us-ascii?Q?xTXJObt8R2hh6hHaOEsJs1mb3RV2xbEofkMUYatMg/ETcK6vURNj2PJOSa1k?=
 =?us-ascii?Q?IusPPpdU+1FIUfQhgoR5f48lAxpSXp1iCvnpS/KUoaklNO8plQIRtj0t1JKD?=
 =?us-ascii?Q?aI1WFtUAhDel1AmAMSKdceIoym8Y1niHZARDCu7SY+t7byau0qUiPTrdL5UD?=
 =?us-ascii?Q?rkm5VambGz6vIzCS3nJFKneHIjl+KK1+soP6+Ti5vR/UPzuLs70bxC7VEgKh?=
 =?us-ascii?Q?1K8fD/aPhuJ6VlLRpEQ9hdsbCY/lltC1EwQnyz2mdoRlqHxF6qS9QusglndF?=
 =?us-ascii?Q?0NMZJW+cY+mCWHPdUmzvN7EKEv3xIKdrfxd2IeeS0Yqe97AXwu23U3RBjIEe?=
 =?us-ascii?Q?KwoOFg6FqdAt+27sjQjKyYDi3CpJ3fD9lQ+ozpiKge6BLUMFNIAfLuK8GeVM?=
 =?us-ascii?Q?FOvP8UfR/EoEbYOfa75eLjLruWApkOXvDkICzs6shLBxM/h34jgmX9isjevF?=
 =?us-ascii?Q?y5CiOKXvhHVGOzhmokqBATYohbtTd7AQ+8UzXXkRaqoiLEebt6XHN+eeQSMk?=
 =?us-ascii?Q?JwyrgY2/q+z3vHOh9QOLaxznFjoiSZ9j/03xOYIQvwYbQr4tEAZFt3pArkfh?=
 =?us-ascii?Q?p++43flIscRjBIKGPIKeG++IlK1VzP6Ti5nUPfq14ChlN4DughK8cgPy98O3?=
 =?us-ascii?Q?bhm2Fn0MyZR6vYJ0Uocne5baQ/Wyn2vc+W9oNum+c6kEK6HxB1w878QB54/O?=
 =?us-ascii?Q?0mLWxidwI6PQC6VxJClDwuXjNj2nefBGlTqAMGkQsupL7AGzezUiVwsgwDlR?=
 =?us-ascii?Q?DtbgQ0oZ83RmYtaJ5NCzu9q6BGQUj905LUGbAWPRaC5z9o3UfMUUCekfPANt?=
 =?us-ascii?Q?PlHsEh0/EclLJI7EGXKeyBCgklPkL08ia00y/E0S/LGxyckta4eczoCZ3+8z?=
 =?us-ascii?Q?iz+/YpKXjQ7CkADxh+C37T0ekXSEM1lRFOUpH8t1URUVN/HwtjwUwJ5t1O+c?=
 =?us-ascii?Q?BAqacqtDOHq3fCb7L+cWeCUu/2+gYk0g9Nu3S178NtSou8i1DmkenZ+prpPa?=
 =?us-ascii?Q?qfr/HOcCqFG8tMcaNwCz3yf3ySvx9Aa/lUcQ88L1IphGbdQjE2NjdSqca1X0?=
 =?us-ascii?Q?yp98+y0/TdyI1B/Dv8zVPcxS00ItGYHoBcBA8kjaZzOMo/EAUkxHApvlQH7J?=
 =?us-ascii?Q?CSTmkkwCB4rBwQsKRlyuEYIMC9FpFH0lq1cR17KCNGK6DZ4BUwfy9kAlQfRH?=
 =?us-ascii?Q?KGwmtzKKm6IhbAr2WuZ4YirdfFZX3QSsco5W2VrDiCkub8aHlpL9WRcLk2po?=
 =?us-ascii?Q?3ssQDC2ceB0Tgbn0oh+mQsO0TleZXMvnjaKdncJ7+kcnM4FwiTYV?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab20b88-e354-40dc-e397-08de6cb0bb91
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 16:39:05.0491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YKEytzJbQbLhgu6W1DzOO4MxiaQAglo4pR5jFZ0iJfut1riEwZqxBmdZVWo9xU0O9jN6Lkda/1CqoBwHfK2Sow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5196

Some DesignWare PCIe controllers integrate an eDMA block whose registers
are located in a dedicated register window. Endpoint function drivers
may need the physical base and size of this window to map/expose it to a
peer.

Record the physical base and size of the integrated eDMA register window
in struct dw_pcie.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/controller/dwc/pcie-designware.c | 4 ++++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 5741c09dde7f..f82ed189f6ae 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -162,8 +162,12 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->edma.reg_base))
 				return PTR_ERR(pci->edma.reg_base);
+			pci->edma_reg_phys = res->start;
+			pci->edma_reg_size = resource_size(res);
 		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
 			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_phys = pci->atu_phys_addr + DEFAULT_DBI_DMA_OFFSET;
+			pci->edma_reg_size = pci->atu_size - DEFAULT_DBI_DMA_OFFSET;
 		}
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae6389dd9caa..52f26663e8b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -541,6 +541,8 @@ struct dw_pcie {
 	int			max_link_speed;
 	u8			n_fts[2];
 	struct dw_edma_chip	edma;
+	phys_addr_t		edma_reg_phys;
+	resource_size_t		edma_reg_size;
 	bool			l1ss_support;	/* L1 PM Substates support */
 	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
 	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
-- 
2.51.0

