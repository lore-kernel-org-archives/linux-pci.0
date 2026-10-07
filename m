Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012017.outbound.protection.outlook.com [40.93.195.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F18485502;
	Wed,  7 Oct 2026 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791367441; cv=fail; b=UmXenSYs08zBGVbo9dBqaznfKBAQQRwgd0iui9rIh2vdWF7iflbi5LQcUsCn87yjAo2v4RlfHJt4xmMYZiwwtFJVgmtYw6wAXbPu/tdwoYaVnelELoMUtc9061VUWanI29HJBrSVh74BWpjlRLTKSKvECQZQZhNA6VQA6kb2js0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791367441; c=relaxed/simple;
	bh=M0QZYWg1ot0kGgPWnJ+JYVrLEJZ+uKfmnkab2hwf/Jk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1klKEeGLKVW+8bbaQ9gx7sDWEaUVdWS4OaGvd0ebLdk1W0nXGWH7lj+mdBHBhGAokZZBYuZaehx5WP6SWCXj3tfPL1dD3NN8rw5ZoseQQD/FZ2buB/zQKN90gbBE1udZYu0gK/WLgEcuhR6l/fPgescWkvc7iIFW3PsWt9cNZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3P6tbuEt; arc=fail smtp.client-ip=40.93.195.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3P6tbuEt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ityM4DZ3KUElKdCgi+k2VsqcT0jlvqY6TuXvvxex5rx6iLnvG5pNemQ7MixSAnKrwITsCjXxFjNH8xfQnCf/OKeEMdmdOqr9S2mni9ktQz8L9F4atN7uP+3Xok8LGDOcP+LltQkzj/p4kcZbFcKaHmEfEy4aSjwcicHgWhn2pJlqe1WUPjKN8Z7rzkKgxoaElp5ycJuJbilNxjEavqlC8++JkachzqcU0nItl+nfexa9c8OlBZtGrMV0y9RkFHpC83Z5LQC+zJmJxWRufR790/1YkWzl3FTEKESog/HYwwfIi7DJWSSRFcI+ALf006auYScY6czOvk7wwAc9CrpsTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFtVXCgJKgzsumYnAHcWYSUXA3WQMGsZAdOjreLwXRk=;
 b=T7xX0PAb3orStne2XhGZE+qylnutOteRxVtpYkarGp/RqsJz313ZoTJfqrH2ZFBspndjBPZPyocg3YaSJ8Q4idwnucQvapGCbF52x3atlTlBgjOIkG1ZH175dKMLJLIfqyxX8adpYzS3yPzGhj8ba2kaJdGd5QGHXpemQjsgN8gNViZDLSzhX5Xl86cJi3r7XzJhNpO2v4Me0NXeUm65jrImpIhy/d5l/Dr043Zwi5jU9x8qqcqBRHn7oC4TV6ljre1Jj5bY5mJXrhQfWvuWU3PZgp5aXNpTp0fIvgiBafY/heHdGJf91aQs7bMXLJ64vfFyVU557XJroNiOcEn5sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFtVXCgJKgzsumYnAHcWYSUXA3WQMGsZAdOjreLwXRk=;
 b=3P6tbuEt/v+PrqK61o13pKJOs4E3Hkpe3QNUV9Cf3jiGVWvDlruoaGuDm6dhy3tR76utOMZM99bgCSYLgqFShqpEC0p+oNx4kdFkRXhEBqXA6tClwCDDpABN25TnMHwuwu+xH+oQtSonQKLEedsx+e8ZkpjY4BW4bKIp20L4CnM=
Received: from SJ0PR03CA0052.namprd03.prod.outlook.com (2603:10b6:a03:33e::27)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Wed, 7 Oct
 2026 10:03:43 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::27) by SJ0PR03CA0052.outlook.office365.com
 (2603:10b6:a03:33e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 10:03:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 10:03:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 05:03:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 05:03:41 -0500
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Wed, 7 Oct 2026 05:03:39 -0500
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH RESEND v2 1/2] dmaengine: dw-edma: Sort Register Field Macros by Bit Position
Date: Wed, 7 Oct 2026 15:33:35 +0530
Message-ID: <20261007100336.4009004-2-devverma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007100336.4009004-1-devverma@amd.com>
References: <20261007100336.4009004-1-devverma@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: ed263882-3e3a-4224-8eac-08df245a450c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	WXtHD0+/44iNhxT4woybel0CmltTibPw+q57gpKcWTnCI54XXOG0mAdYhzJfgs13VThJgkOKYnKp4cxuk2ggCrOjesV/suNyVOUplfoBdXVo2Oh3NLqCdDQ/wiisHm8ixpwxS6aPIdLtK5ZWlEUUJmS1hyvKIVVc2Qi89ztOHRSJ52x9B/q0Fv8GdJBj3M6cwgm+WW+UUowxjOHgMsN3OzAsgZql4vHvVnLxmj+pQsd8f/yDt44DBxHaDn8zCoJZ0sQATKmH6JDLomWZj+PA1YZqkdhtsz74CdiazFV63huchpMPeAR79IJR+yNUOYwOA5ZixPB9nE+FS97dCaI0HacjCOe3oRe2OfqN0Nws6efRb8NBzz9hmXwE5xH9TJk5JW4tpd+9ZaBE1rgxm5FRVZthuj1TShiVYdT+leaS0Mn1wzoNaB1jUaVMIPttW1duxrvUSiT26T/zKwirR1uULfn4/i4KhPbqUtPA3yr4QfnuoZAR4FWOQEoCsWIh3k9CYdDLyK6Au9gRl67CASFIwKsQ8NzLCOitGbUNjd1A4gH+DB5EUqGV63cS/iKhnYT9DdLh3ydFpJ6SfdnM/RR8vzGslPWKfYBIF6yMbCHrsrGnLTLR/7Tg4LgPrCPqpOJur6/Xm3BpnEM0dcXYNq7QRBrsWl5kJSx5YNxe/MqTg3/eRIy5Kcl/cPxdFoch8l5e6JFy37jdzRiGWVw8EcZTqw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	C2hg+9LYLeAT/iq1gwDUOlqmNSxUntV4gTlVtq0MR7daQF3S4UHC9t3RkI3hcGf2elxOiRnXjcVr0vUr/YoPsD2D1DLqMPaUP7CrWNIf8V4pACSVQJmj92tQ1DA1hvktH3zjFZHU7NJXXriUr7Kx7Mh/107/00a7WHtJPQEdL6RFTsdB/O95+ubopGuEzU+juJTP86tP5RCX18/OucBGQWEugwMIGf+fGwNS8eHtiB/jrS5tjHF/PZG7ivkXlQY34ab7JCCttRvJBlttvsSNtEZdAKRQ1N+8zIeWKyLfewfp4jH48AQXFFV2a5EV8ajaqTT4MNDNmY0HYfTeYPH1VdxM3WmyWP7EvtFuQTIjqlu9tHICu3tcdH+Wyb9AVoMurD+jy48Jkjj2Hby2fYJakBBd7vJdUnY9ysiIWc6y7htXA7BUXUJBmkzz7C7ut7/c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 10:03:43.2972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed263882-3e3a-4224-8eac-08df245a450c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

Sort register field macros by bit position to improve readability.
No functional change.

Signed-off-by: Devendra K Verma <devverma@amd.com>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 9f237ba916de..006dea7d6322 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -31,8 +31,8 @@
 
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
 #define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
-#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
 #define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
 
-- 
2.43.0

