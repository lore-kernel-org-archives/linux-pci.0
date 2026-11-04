Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793780767;
	b=lm+aIqblcEyKQNYgk7VGapeQwGYQgH6dwEzNOhaDehljHUyDXgUT7eL0IMhovWri3Cmk
	 8uCqdOwyXOWBojugip/5aQLxB/v+taWCp9yl+tYtJo4SuT58rp1pWRUWtGrA4R5QbQgyd
	 1cdO09BU3R5AeFGniv9+p/y8neQyW5Hi2BKMnKwcYbDlZqxNFiOr7TbmLXo7h765fvRt0
	 gQPR3mOhjdw4LcNrN0zwbCUP9Q0QiRiZlPEs063iQUh7CMWsqiKFkCdqXx31NvdseTucE
	 qd6Qt0TTf67sBSTJoTPLJUGdsmKLwbXhsV1WNgpURIcdQIxYY2sPEAscQy+52w01wCA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780767;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=v4v4sNUl6GWDCP+3zk/+VmR7QPxdjAQeiwe8qXJeozU=;
	b=47J3c2mDeW0LjfGlpmNVIDhuN3QSjZkLAP/oMmSA3lnXtMsgsJ7gAIGiHbvauyYfdtdY
	 srrETvCQ+qKcpIyMkDM4hLIJ0sNgaq8O0TcS/+Lp3pSPwM4D9adyW7bPcHFzvjNj2J5gA
	 +yt4s2SWJkSVU7NJ+oIrvip2TX+ihBZcVFCmSR+HEi7V1vpcmHEGDwylesfRNWjG+7BF1
	 KL+hsv/FJlknezAz3HjQuuq6FQQuIxgIRlneEMRUKJFWgMm2mT5jn5MGBZygVVNTi8Dgb
	 JrsYLS8JZQtNBUqZ2wXhdIfZCLu6JRyKr0rqpdfRQaj6ceEylhONEhIqbq/TWQZRoWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XLCtql8a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.53
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86382606A328;
	Wed,  4 Nov 2026 08:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86382606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XLCtql8a
Received: from IA3PR12MB692094.namprd12.prod.outlook.com
 (2603:10b6:208:712::7) by IA1PR12MB6259.namprd12.prod.outlook.com
 (2603:10b6:208:3e5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 08:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBw5YrLWRq6VTPrt2aH13/bYppPtxP7O5dGig2e2ucDw4CBj09acVzoR6oDhg4UrViPfQTMYohr5gCsxjXCAhHZ//r2RzbVxAxEmmJWHuacivZfW3QTcX64+PiNE9ZetOwuKid19ryWI8f3xCpUzVL6d7Pypvh5HVSinyUt7yYX5aIgzXsS6lcQCPSWzKoaf+pXMdYCk+DHZ4GqAPSG13b+1qnf3bXXqs+1TVQ35lOE+ZCGEM+t0/+gaHlrhYHyFPPSLGdlpoKHZCWjqPZwjz5uLEDcvc21n4LfUgrhZfWtHhpoLIo0Z+qxJGH+Ubohh9VMoxmq0uv+0JTGBXyVOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4v4sNUl6GWDCP+3zk/+VmR7QPxdjAQeiwe8qXJeozU=;
 b=LF+WcwSKcV/gx5e9gMXLaCM49liyu4yt7nlXTYqbaeRCeGgVREFbzDH4xPq0guG3MfshaReRSvYdQuOPFbrJyFa8dV/aM86nW6nHcFs9u1DkweOQ/SBUGN2IjUJ5JqbzkRVmIEI+x5HXYMn3DdrJdWhEOH6VkH6AXXaoJcTUIil+LG0OF4uxEQv4xB2CIvTq0fFg9lOtW4pNrjXHEArp5E2C91xsw7b5DNUISxgGGKMAYQ7HrPpVvyY6lYOcu/saQLG9XIvNINEKgLg9sYtol9EeN5Zmtio8DwKgc2bGH5/4fq127uZkaw1JyISRX7b3KZLgj5IUN9UZWv2uvrQCnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4v4sNUl6GWDCP+3zk/+VmR7QPxdjAQeiwe8qXJeozU=;
 b=XLCtql8anJ6TYRtqUkB4MNsKVDWh46Z0QpxXaWNohK+xty0T61erCbSqGx4zD+zvaiIcNNCOpu0vWSVGsWJvMWDkLdbf11kVsi/y2hh3ei0Sy/TB2lS3KhGLCVt0PiHORxdaBH2KQja7sRkQFmSiBsxoHCqnjWA9dxhF4TF+BQA=
Received: from PH8PR15CA0021.namprd15.prod.outlook.com (2603:10b6:510:2d2::24)
 by IA3PR12MB692094.namprd12.prod.outlook.com (2603:10b6:208:712::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 08:23:12 +0000
Received: from CY8PEPF00000057.namprd21.prod.outlook.com
 (2603:10b6:510:2d2:cafe::38) by PH8PR15CA0021.outlook.office365.com
 (2603:10b6:510:2d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 08:23:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000057.mail.protection.outlook.com (10.167.247.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Wed, 4 Nov 2026 08:23:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 02:23:11 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 02:23:11 -0600
Received: from xhddevverma40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 4 Nov 2026 02:23:08 -0600
From: Devendra K Verma <devverma@amd.com>
To: <mani@kernel.org>, <vkoul@kernel.org>, <frank.li@kernel.org>,
	<den@valinux.co.jp>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>, <devverma@amd.com>
Subject: [PATCH RESEND v3 2/2] dmaengine: dw-edma: correct IP name in xilinx_cpm6_dma_data comment
Date: Wed, 4 Nov 2026 13:53:02 +0530
Message-ID: <20261104082302.3819409-3-devverma@amd.com>
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
X-MS-TrafficTypeDiagnostic:
	CY8PEPF00000057:EE_|IA3PR12MB692094:EE_|IA1PR12MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 2890caef-e5ad-4f88-1a5c-08df3a4cddc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261102123227099003|261021123027099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
 qMGMEd4vVaDvKXm39WiA47ifyyvXp9pQUIu+B+U6YOqMiqVGB6nbWAQ3wxjqcUrMCu1MexkBkqSxAntt7mljHenNFQ7lTx+DmTqQ/0pBHQxYdHPMqLu1ZspTc9vTWIrOIaabaJCOqNw1iMvrELZ6QxaNyTC+uhr9ojzaZ04a7vPinoqdEzFrhNOg70e2XLJrBbxgwYL39z3CTOKRUx1yk9YVYpcxAlkgsHmxo6nPbd51lwoUiOmI4YwlLhYM4+DB7qqlZGDtSN6cy//rkG7GloXZ8r82LDP0LAYoEPHt+G1P/Hu29vGqWffz8bumdJytmqGuJxSFT4MbyHHWuPAZ4NQCPFKPCF9SWMoWgk0Cuy2mZ8ob+paszJ2U3XkzOpss41oBcpqdN4aBr+ngG3klIgynyEbEZxDhTw0n/l6rvypFOU2OHitxDaCumRu5ZI9A+qgP2GHYGbt5Pj0ZG4sR3B2YB7BR6vBW2WyAh5oVEymoGzAFXNDF5uaomQ1TdZuT1W2kzwMKGxoIJJGpx59vA7jkoSpLRNEU0t2+yrYmdjsnyZ6zXI3KHEn/n/O4XMhq8Vt1DuFhrIAC7RmgUSbZWLtr73UzWfy5PE6n/b0n5TvsiL3HePBr6WK6v/ouNbXSPMB6balF/nGbncI8hSGc0eJFqrmgsDE9mAGd4ljFGQgn9SqDjWBnaD4aPtLpdXOUqX7zGw1krOTlRT4WW8wO3A==
X-Forefront-Antispam-Report:
 CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 Gg5MlXjrAPbBKZvU4Iq3nNXXTc7KmiKEZ+QR9z8cnJxFm7XnML7TmwhCDSySEzUesoHDQX66DyYbgx2WtHN3uBlr7xJIdD6TOi3KwMaNLmGTbSUvTb6FZp3wXqwHofgvSLOeqDLmBkudPVRA6KFUfWxfRxUVV5/b65iO2LTBAphlLhOPLZr2wdFDBjIQTv8q99Sr9zV15fDQ9kuX1IGUFBwcZdhwL/XdSSiNYXkqKo46A99IQAkBlc565Wx/B9ufUqWm2OhGMYs0vrAyAElZKQutmlIRrCco/BiScqoenPrcYLvRjq2w9d2WhzUyN6JNdbntszrTaDkxXOx+I4O7OKtm2o8dtgvQymJvDVSYVPc92mDGwZeEpAZSLOCDnwNizaFXBfbpbvlaZ5odvnDR7kuAjqsEoYEo/RfZUbbHcufCrqDkBKGQkagLQRzbXHB0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 08:23:12.1763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2890caef-e5ad-4f88-1a5c-08df3a4cddc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
 CY8PEPF00000057.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB692094
X-OriginatorOrg: amd.com

Replace 'MDB' with 'CPM6' in the xilinx_cpm6_dma_data comment to
fix the IP name typo.
No functional change.

Signed-off-by: Devendra K Verma <devverma@amd.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
  o Rebased to dma/next branch

Changes in v1:
  o Corrected heading and body as per reviewer's suggestion
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 83f8353d89d0..62efe1954e43 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -151,7 +151,7 @@ static const struct dw_edma_pcie_data xilinx_mdb_data = {
 };
 
 static const struct dw_edma_pcie_data xilinx_cpm6_dma_data = {
-	/* MDB registers location */
+	/* CPM6 registers location */
 	.rg.bar				= BAR_0,
 	.rg.off				= SZ_4K,	/*  4 Kbytes */
 	.rg.sz				= SZ_8K,	/*  8 Kbytes */
-- 
2.43.0

