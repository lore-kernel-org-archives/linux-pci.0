Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793780593;
	b=Dg4+/DaU19Ty5E94+xK6bu89Q8GRFxWTfZosvEm4Bd5GjusU1vZOPyDlPpycX8A/ETkG
	 bfglEtWota8zdhB8ldaBDS/gPEXOOnCV8exwnN1ujG/pj9287U6xVAUKQ9rdl8QXOuamF
	 QQQ/MWeb5MAMHBXhEtRksZ9pWbCAzkellDRSpOiTwVcwxtVVy/qiwUMVwL3imdg5M9Faq
	 B3g1AEdTsAt8x7GkXSoQgR4U9+4okiXQyAw3v9SMlSW9VHZwiE1CO+NzuVrrc0BYAPP7P
	 JoOp35BaFvl7ctxAu+LWDLvJKMpcc0m98iK6pk295BMjFhggG8rtwOTnh9as4/EjxIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780593;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=UQDVj9XiQcCABiv3yXPGxcXW7Jhj3NzlOWEBDsB6m+4=;
	b=xRnw0eAlceAAHlnS8QlN+sy3uFr+7QLczJlExQjzd/ZLrR0wlyPOZUOpl8k3IsDCnSWo
	 EvfnskylG+X/GD7eVHryQiFBpK9ejVmigMizX9KsbWGBOuVz0WCOz1Vr+ilqiPf7b6HDQ
	 9BmK2KoRWyazzxeKPP3BckS5nC0z2Z0X7xUZ80uguPY5m7g5apCGGIDclquUa2Ei4tLE5
	 15K/SUFH0Dj6NYlAc3boQM1dcL4CZuQ5oxbMb5+nfnXHvochx/3CNFsPOw3NLcw0cfDgm
	 KFTwkV+qUwapfwv2aGNkiGP0YT1GYbij2EMK3swciZ6zB3rg3khmpcftGcM0wcVui/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SJtKhd37;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.5
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73626606A31B;
	Wed,  4 Nov 2026 08:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73626606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=SJtKhd37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSisEOQKHRbC46z+R+AvvHIBdjxGd4KcegBDYisegbetWOoNjZoNci1d0KkhH277QLj3ra1P75jVgtFRz506f0BRd7qP5Sh4YAqMd+u9KvYi0Z93hjosOi1DfSqgMQUVY0Yl6yl1pQmdZpYNLy7k8j8U88fmZ0m1/iP3HsbO+qYKWr0wlIuNNgp4LtIj4l0sSE5OL3mFCktFLXBzh6pwcwBgWVcXmu+wEqUP5AJS5KvZFdULYuGVevWgPAgeuY8/gW9+Qn9I0wVtDFKkhoHzyFtH659Rbkrw5fm0Dp4qyl/XjO+d4DDag7UpU2movU13WC/1+LCwv6rLucDIxgc/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQDVj9XiQcCABiv3yXPGxcXW7Jhj3NzlOWEBDsB6m+4=;
 b=s7yRD7zITmV7IYNJPsu4qe3kxicA3KIRCtKBinBbVZXEq+Y68ximkpytmKQqfnJNk7J8QiDBU8u2iSLo8R23PAA/Iuk/QCP25iHl9KjCAcCVxN+C1UPXqRev4W2ILPzOzcMbqG4YvffzYHEjnZn4C0jyMzHyE56Esyk+pAx8LOCOCfUgtVd5ZflX1WiXOLdPwcDQOmaDUtQLL1BjjJKlukMcQD0T4PvR/xMV4s+1vI9145R0lY9NaC8p/Ne3O+fzSzpIAX0hEYSz7rvZWaAZ9pvnaOlNzLZr1t9S+ww1cdF/p9NUNqaN8jNyYtVbXEJYnPNWg6YHOZT4lNNMHkvwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQDVj9XiQcCABiv3yXPGxcXW7Jhj3NzlOWEBDsB6m+4=;
 b=SJtKhd37SrMHzJ4tHoHX/ne41uVyI5aZgXi2TpvdGpLzbU+jbHh6a2om41/0Dqei0oz/iJ4ax40ehZukqE5BxOgyIqX5K/40U8NZDWXdytkTlbLIXX9y/5t2YpRxYKcabqh/HJJRakkbpAIrwbpOP4sYbuqy/N57EJzrJ16KTu8=
Received: from PH8PR15CA0001.namprd15.prod.outlook.com (2603:10b6:510:2d2::13)
 by LV0PR12MB142838.namprd12.prod.outlook.com (2603:10b6:408:3de::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 08:23:09 +0000
Received: from CY8PEPF00000057.namprd21.prod.outlook.com
 (2603:10b6:510:2d2:cafe::95) by PH8PR15CA0001.outlook.office365.com
 (2603:10b6:510:2d2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 08:23:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000057.mail.protection.outlook.com (10.167.247.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Wed, 4 Nov 2026 08:23:08 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 02:23:08 -0600
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 4 Nov 2026 02:23:05 -0600
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH RESEND v3 1/2] dmaengine: dw-edma: Sort Register Field Macros by Bit Position
Date: Wed, 4 Nov 2026 13:53:01 +0530
Message-ID: <20261104082302.3819409-2-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104082302.3819409-1-devverma@amd.com>
References: <20261104082302.3819409-1-devverma@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000057:EE_|LV0PR12MB142838:EE_
X-MS-Office365-Filtering-Correlation-Id: dba39d5a-3697-40b0-183e-08df3a4cdbcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	JE/f6Zhbu8TCZ6NoA3oz76aV/H868PYWybnGnJoN4LM7c5/minKaZ9l4cASO6ABocO4Yo4y4NYbfjHmezeyVrPU5eMgiCKDNNe4QwRFp593S916761QN92it2y8GYvK9cZ7WJUrmGc0MjJDYRy+IT+kFOuDotY2RxTsSwEQbRcQd3x72/zfFD/TYq5F08JyQ5HiT68t/sZIIj9WLLhAmf7Y9CpDbMlfq6wyIGBxrYsGuVS8a6K15LGHtPU/4Pwq39SwsRLxPvhBh6bJHcD6NwU6iuW9DiNoydL9Dc01+J3B407RMm6SGxLG8nX2c51nY3yrqeD7gopeJDfRXbkg9CkSaA1jGTFWDU6X6sKzUPBf3lizYOHKCWsZcoWSCEDg8kSs9zmppgRjXmsp3SkKjEMJ+IU1Zr22yAFiGjsaw1XuGkSGmipsW20jb8hL5M4EMnhoS0YioZux7HS2URADuyci6tY1IuxUVvagNmAJj96oftPqfYn98m+scGCSK1SXVPPhLbHR3S2ByPE5wuOeEiN2fkIYo19CVAeTi2K5ZY5JpP4HIYJjGc658WGWPWYjAZz+/kOqAqhPm1x/u+hghQdZiTluNKh9zGh5BfNP9o98R18dFpbxxNI+4SGrt6PPFRaUapNVEfAPxK+VVSwCbTMBbEIh5Z9TjXPxDf12LAZxtIdvbQbX7S9wcpMt81j0x2Rlbht2LEK7O4r1Svprc7A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IWdYWzdXpLxJhv4QYnHYvyx8Ojhe6XvaM5Y5DdJRCP35aHBGi1lJumC6EJbqqDC0K+WQfZMg9CqsFMJ1PUxh3gcr87AaGHMn9J1sAW3DRAk9it69l8FQNYDl3weL3C3ZeIYY1Ko2yGmT/GIfSoRRYPosjBwWqETm9eFq05GopXyNcSnwUI9xdPnuNkAvVwg6aTsdmjNKShwz2hxClE1DwRokAzTFdtaVVtujuMOYKt4JjlWsRq8Y5Com9VTUEDpi5W6seYqbxMDXQbuM0elqOLHdM2803wUXHgNnZCrTf0tC5zCfnSO1GScLZT39dcFl2sxUvtE6sE0un8oQILAPgNhLVTEvkH1v0QigPKBISGA8yM0oemYUyK+SbZ8ayvpSOc7Or96PqdqiSfX4wNY1tfX6PN/L68FSeTi/Bx+Htf4A3uPRcqlbKeUxXdxVrjGp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 08:23:08.8847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba39d5a-3697-40b0-183e-08df3a4cdbcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF00000057.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB142838

Sort register field macros by bit position to improve readability.
No functional change.

Signed-off-by: Devendra K Verma <devverma@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
  o Rebased to dma/next branch as per reviewer's suggestion

Changes in v1:
  o Corrected heading and body as per reviewer's suggestion
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index fab4faf68b77..83f8353d89d0 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -31,8 +31,8 @@
 
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
 #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 /* AMD CPM6 (Xilinx) supported cap */
 #define DW_PCIE_XILINX_CPM6_VSEC_CH_SEP		GENMASK(18, 16)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
-- 
2.43.0

