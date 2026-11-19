Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120018;
	b=xqEQVyjD7by1T7D9k/AKbervOJfnyw8knCfWXdeF5rOmh8n36U+NACEiYTxlUE8ZVdqg
	 VidzZR37M66JcGGv2H9NE450k/4vjD5tUv366HcML2iq4GX7U8CvaQo29jDG4ydsSH49u
	 USBP/C4JuivPt0V3YMxgRNF9phdeBE4FpeVU9bp2Wy5SYMYf2AcRkCYLEhzPKitrz34DI
	 UIniy20YpJwb/CxGK31yqLrg4P7hj5uKTyMDVZZfHniZw8GmbhGbwF4rbkyscYCwXBBK5
	 0KmfinnL+BOh6rYS3N25QpOPBopDwhH0FDk5+R4xIZGn505yTZt7+e2wgzdSIGTsttA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120018;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=kwhfIORSjjSFU/L7EUY8OX30KZRf/NQnP1tIOpA/Me8=;
	b=5PaQidWJ7yhnECuPB99ucY5q+pDt3jENIRitlDi1vdmunNk9/qnoPGpyAWIp8mumRXIx
	 fOwziODnItCg7pdKm0v3zeRvGrGqS0DYha+N605lOkiFJnzgWU8mwJVFY1g/FvgzSXtSG
	 4txPrFJFYivqtwJhATqqIjF+9Ha5Bo/sFJqcWdDa/4hb2qgLM0d8FiwwvgVccLBRJtyo7
	 pxMFqkr7Vun8YjAZsOnTSQGTDQn2+wZ0m6NEA0kiiIdZSnPFQ2JklPxUiyxWqo040AlMl
	 SpA/JE+GrYT4STv+QebaAijfkqtFyB9DlFow6l6yKLpaDQS2YtoJkSQDT4QsuyYXdmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h7FXoFmt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.19
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBD1606A33B;
	Thu, 19 Nov 2026 20:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCBD1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h7FXoFmt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTFiRMqCj2BFcYmNelBf5Y5X7AXnnGq0mSgsysJjmXgGpqS+PVgpwqtQ9xD4MxUqxqhYo/HdTYHkm2mkvy6CevKAKT0mfulNKQynL/mjXfXnFMPOuKGq6NAkYtj5BovcxlUOVfXWNXZU7QlbU/yRMU2IMsoybAxAbvxhoBhBG8X6OmcxlemDfAD3eGicTHG9RVToCqJYEprOA5trk40B4e/FaR6niLDKIjVF8cxjrpaoWxIJj9/5tYBmkCeSX3CI63Ejea5oBwDMy+O6TN9u/DtSbXSVPTOpuNgh9kGD064CjOfNLrbtDB5oWg3c7YSwKXwpxdSue+dVXrR59v1wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwhfIORSjjSFU/L7EUY8OX30KZRf/NQnP1tIOpA/Me8=;
 b=J7sdhqFz8WGCR+hrCd7dH5NWD7rH0UDbcTfg8h9wxPcuA6qV9RLJ2t+ajcRpH2wKXG4PYddC387x3fosHDz9BpMmXkH4/OKA/IFsZx+AD3QuVIbkjU3BuNj29ohQzNBdQpD2Rvc3hCf/mBUGdE+y25KGzAn4n3l8HzcMt7JwrM63L7HiodK23kZOK2+jR1gE52dzO7Vanp9ZskSsMbGMtUhZ2DnQyE8rPys8oQLgUQreDbM1M24fToFqlH3v4wjEloANevHtNF/az8hcfZg0+177wBBlA68OHM60+9564vFv6DprIKCWDGhjb41jKGNxri2sawZhPwRnvenF5Wnd0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwhfIORSjjSFU/L7EUY8OX30KZRf/NQnP1tIOpA/Me8=;
 b=h7FXoFmtVVdpc/2JAKq2nONmWCjAjLHCuYbAVcehIo4JWn01Yh6cdKp9M/jq2VcuV9/+4RPyYf6XI8Lc2zCDSqnxI1P4KlShByf/Ot08M9Rw2zbmKqknWOiEAwxwh34+u+wh04ZQw7sDzkXc8aFh6l+uUv9aBtuy09sWmrcagzA=
Received: from CH2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:52::23)
 by PH6PR12MB345224.namprd12.prod.outlook.com (2603:10b6:510:3da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 20:26:52 +0000
Received: from DM3PEPF000265B7.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::1c) by CH2PR04CA0013.outlook.office365.com
 (2603:10b6:610:52::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 20:26:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B7.mail.protection.outlook.com (10.167.23.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 20:26:51 +0000
Received: from weiserver.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 14:26:50 -0600
From: Wei Huang <wei.huang2@amd.com>
To: <dmaengine@vger.kernel.org>
CC: <vkoul@kernel.org>, <Frank.Li@kernel.org>, <shuah@kernel.org>,
	<nathan.lynch@amd.com>, <wei.huang2@amd.com>, <mario.limonciello@amd.com>,
	<Stephen.Bates@amd.com>, <tycho@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<rientjes@google.com>, <John.Kariuki@amd.com>, <jic23@kernel.org>,
	<weixugc@google.com>, <bhelgaas@google.com>, <Shyam.Iyer@dell.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v1 17/44] dmaengine: sdxi: implement fixed-size ioctl dispatch
Date: Thu, 19 Nov 2026 14:22:53 -0600
Message-ID: <20261119202321.1734355-18-wei.huang2@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119202321.1734355-1-wei.huang2@amd.com>
References: <20261119202321.1734355-1-wei.huang2@amd.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B7:EE_|PH6PR12MB345224:EE_
X-MS-Office365-Filtering-Correlation-Id: f2e61d6d-f6f1-4972-1b88-08df467b71e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|7416014|18002099003|261009223027099003|22082099003|6133799003|11063799006|261026121527099003|261026140227099003|56012099006|5023799004|261021135927099003|261021121427099003|261021123027099003|261028144727099003|261022105027099003|261102123227099003|10067099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	gyT7y1Qj5d5qi4VYh6vGpHaYI/YWxEZNeqOyTIcMTX8iJ/KyCdBbGbEZlxeA9a4d1Dq4Iesk+7tySa0F25ofJMTRsmGeBgqeDiYfvBQvHxKyULGf7vABQHYvMiGlNBGL/VaWN2JBXk1QoX3w4phb7fE3RCBEeYy38TZcPBjjP/P4kvjQ1bgXz7V0ohIPqzU/x+Zt8KBpcEEevseEIGRS7t++f4uZubT3Y9Ni7SZN/G6z8sTCGgeXlfQyTjttLVm0ERRQv86Gs/Gu3JTu/GG2CmHmPcrTDaTQ+cDYgk2myevLOh2Ae8Ry1KgxZQAf52sCb4gaNKYW1SKzwLelLH94GbSxoo7WK/ELWAi1rhnkQnntz4a8Lu+xLdTvcWo2r9a/z6lyFbBqDE3a2T+nPxAWweBwRWzXI52JmSWzykMR2pVfeBGQQwWZMWTv//CnR/fxOMkGHZtyhUOY5w3Aw8TorInn21QFH8p8R90ZR3J3Z6f3tpXfLzMSx3uX9H23unqF2qAzm8Q1gYMizhqrFW/H2BdCoFMQme72lnFiKu9ljNKLEaVxHyZIFMsmmY1HdSPfYkds88opY1xtDPv5P+fQ52DsqlHO14uqKexkYBySlfXce5Sq3n+L+sMfVfvJ1b4jNwzBuVgSRxLL/dImcCSIidk0SdUyNrRJvBsdU0lZ62eunlBXpfTg48YSy8kvy0VtE3JclMnrQ8h2szf7UuDqHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(7416014)(18002099003)(261009223027099003)(22082099003)(6133799003)(11063799006)(261026121527099003)(261026140227099003)(56012099006)(5023799004)(261021135927099003)(261021121427099003)(261021123027099003)(261028144727099003)(261022105027099003)(261102123227099003)(10067099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mEYeJhNMoHU2adxCoaD0k4wNzeTknVQSJNf7qhILrDSYh/592f7alNDshoquwSZ8eKDdy3eXKufSGpO7ZqBe1kcbq/dvqK2Z4MQ1z2DTfjb8j7gbCL3vAbKgpCTAUznRrR3D2OgdguoXi5AzjIG3cYVuCZeHtzTW6xE51pRPc3HZAXhKM5fArkBzFR93Gp4bncrQGSyQ4bOxe9aVYY6u2JqgCi7hLZzfW4ayKEEUxsyt0ODKPfNzox+4jeuYju3MXDdIH4DjA1CcnhOXicaBQH8Hwn45LAFsozpihGSsgobLxCJjHwBC93mJtBJ88WcHpD/bet4BOdPOjEK4IInhBStGyq1CTszi81OF425VQvoWuPw0UFf/ZtJPPUQ6Q4BDMWehNyAm1XpX+7bzdNb4eyZBM74hKbG3m6QeH6LBP9lPh6qMEpLFPc6mS+jk9LqJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 20:26:51.4846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2e61d6d-f6f1-4972-1b88-08df467b71e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM3PEPF000265B7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB345224

Add the final ioctl table and access-class checks, with unsupported
rows for features that are not wired yet. Implement UAPI discovery,
device information UAPI, and bounded device attributes while advertising
only those alive capabilities.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/dma/sdxi/device.c |   9 +-
 drivers/dma/sdxi/error.c  |   4 +
 drivers/dma/sdxi/ioctl.c  | 413 +++++++++++++++++++++++++++++++++++++-
 drivers/dma/sdxi/ioctl.h  |   1 -
 drivers/dma/sdxi/sdxi.h   |   1 +
 5 files changed, 420 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/sdxi/device.c b/drivers/dma/sdxi/device.c
index ff5b5d932bc9..b5960619d511 100644
--- a/drivers/dma/sdxi/device.c
+++ b/drivers/dma/sdxi/device.c
@@ -110,12 +110,14 @@ static const unsigned long gsv_transition_timeout_us = USEC_PER_SEC * 1;
 
 static void sdxi_write_fn_gsr(struct sdxi_dev *sdxi, enum sdxi_fn_gsr cmd)
 {
-	u64 ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
+	u64 ctl0;
 
+	mutex_lock(&sdxi->reg_lock);
+	ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
 	dev_dbg(sdxi->dev, "MMIO_CTL0.fn_gsr = %#x (%s)\n", cmd, gsr_str(cmd));
-
 	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_GSR, &ctl0, cmd);
 	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
+	mutex_unlock(&sdxi->reg_lock);
 }
 
 /*
@@ -319,11 +321,13 @@ static int sdxi_fn_prepare(struct sdxi_dev *sdxi)
 	if (err)
 		return err;
 
+	mutex_lock(&sdxi->reg_lock);
 	ctl0 = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
 	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &ctl0, 0);
 	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_PASID_VL, &ctl0, 0);
 	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_PASID, &ctl0, 0);
 	sdxi_write64(sdxi, SDXI_MMIO_CTL0, ctl0);
+	mutex_unlock(&sdxi->reg_lock);
 
 	/* Restore CTL2's reset limits, with operation groups disabled. */
 	cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1);
@@ -534,6 +538,7 @@ int sdxi_register(struct device *dev, const struct sdxi_bus_ops *ops)
 	ida_init(&sdxi->vectors);
 	xa_init_flags(&sdxi->client_cxts, XA_FLAGS_ALLOC1);
 	mutex_init(&sdxi->cxt_lock);
+	mutex_init(&sdxi->reg_lock);
 	mutex_init(&sdxi->admin_lock);
 	mutex_init(&sdxi->rkey_lock);
 	sdxi->error_irq = -1;
diff --git a/drivers/dma/sdxi/error.c b/drivers/dma/sdxi/error.c
index 4d8607b3bbec..d4c1e64dbf2b 100644
--- a/drivers/dma/sdxi/error.c
+++ b/drivers/dma/sdxi/error.c
@@ -267,6 +267,7 @@ int sdxi_error_init(struct sdxi_dev *sdxi)
 	sdxi_write64(sdxi, SDXI_MMIO_ERR_WRT, 0);
 	sdxi_write64(sdxi, SDXI_MMIO_ERR_RD, 0);
 
+	mutex_lock(&sdxi->reg_lock);
 	reg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CTL);
 	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 1);
 	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
@@ -274,6 +275,7 @@ int sdxi_error_init(struct sdxi_dev *sdxi)
 	reg = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
 	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &reg, 1);
 	sdxi_write64(sdxi, SDXI_MMIO_CTL0, reg);
+	mutex_unlock(&sdxi->reg_lock);
 
 	size_order = ilog2(SDXI_ERRLOG_SIZE) - ilog2(SZ_4K);
 	reg = FIELD_PREP(SDXI_MMIO_ERR_CFG_PTR,
@@ -294,6 +296,7 @@ void sdxi_error_exit(struct sdxi_dev *sdxi)
 
 	sdxi_write64(sdxi, SDXI_MMIO_ERR_CFG, 0);
 
+	mutex_lock(&sdxi->reg_lock);
 	reg = sdxi_read64(sdxi, SDXI_MMIO_ERR_CTL);
 	FIELD_MODIFY(SDXI_MMIO_ERR_CTL_EN, &reg, 0);
 	sdxi_write64(sdxi, SDXI_MMIO_ERR_CTL, reg);
@@ -301,6 +304,7 @@ void sdxi_error_exit(struct sdxi_dev *sdxi)
 	reg = sdxi_read64(sdxi, SDXI_MMIO_CTL0);
 	FIELD_MODIFY(SDXI_MMIO_CTL0_FN_ERR_INTR_EN, &reg, 0);
 	sdxi_write64(sdxi, SDXI_MMIO_CTL0, reg);
+	mutex_unlock(&sdxi->reg_lock);
 
 	if (sdxi->error_irq >= 0)
 		devm_free_irq(sdxi->dev, sdxi->error_irq, sdxi);
diff --git a/drivers/dma/sdxi/ioctl.c b/drivers/dma/sdxi/ioctl.c
index 17661fca54a7..b25f8bc273c8 100644
--- a/drivers/dma/sdxi/ioctl.c
+++ b/drivers/dma/sdxi/ioctl.c
@@ -6,13 +6,21 @@
  */
 
 #include <linux/cdev.h>
+#include <linux/bitfield.h>
+#include <linux/capability.h>
+#include <linux/compat.h>
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/idr.h>
+#include <linux/mm.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/sdxi.h>
 
 #include "ioctl.h"
+#include "mmio.h"
 #include "process.h"
 #include "sdxi.h"
 
@@ -22,10 +30,405 @@ static dev_t sdxi_devt;
 static struct class *sdxi_class;
 static DEFINE_IDA(sdxi_minor_ida);
 
-static long sdxi_ioctl_unsupported(struct file *file, unsigned int cmd,
-				   unsigned long arg)
+static int sdxi_file_check_owner(const struct sdxi_process *process)
 {
-	return -ENOTTY;
+	if (process->lead_thread != current->group_leader ||
+	    process->mm != current->mm)
+		return -EBADF;
+
+	return 0;
+}
+
+static int sdxi_ioctl_unsupported(struct file *file, struct sdxi_file *sf,
+				  void *data)
+{
+	return -EOPNOTSUPP;
+}
+
+static int sdxi_ioctl_get_uapi_info(struct file *file, struct sdxi_file *sf,
+				    void *data)
+{
+	struct sdxi_uapi_info_args *args = data;
+
+	if (args->argsz < sizeof(*args) || args->flags || args->rsvd0)
+		return -EINVAL;
+
+	*args = (typeof(*args)) {
+		.argsz = sizeof(*args),
+		.uapi_major = SDXI_UAPI_MAJOR,
+		.uapi_minor = SDXI_UAPI_MINOR,
+		.cap_words = SDXI_UAPI_CAP_WORDS,
+		.caps = {
+			SDXI_UAPI_CAP_DEV_INFO |
+			SDXI_UAPI_CAP_DEV_ATTR_MGMT,
+		},
+	};
+
+	return 0;
+}
+
+static int sdxi_ioctl_get_dev_info(struct file *file, struct sdxi_file *sf,
+				   void *data)
+{
+	struct sdxi_dev_info_args *args = data;
+	struct sdxi_dev *sdxi = sf->process->sdxi;
+	size_t i;
+
+	if (args->argsz < sizeof(*args) || args->flags)
+		return -EINVAL;
+	if (args->rsvd0)
+		return -EINVAL;
+	for (i = 0; i < ARRAY_SIZE(args->rsvd1); i++)
+		if (args->rsvd1[i])
+			return -EINVAL;
+
+	*args = (typeof(*args)) {
+		.argsz = sizeof(*args),
+		.hw_major = sdxi->sdxi_version.major,
+		.hw_minor = sdxi->sdxi_version.minor,
+		.cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0),
+		.cap1 = sdxi_read64(sdxi, SDXI_MMIO_CAP1),
+		.sts0 = sdxi_read64(sdxi, SDXI_MMIO_STS0),
+	};
+
+	return 0;
+}
+
+enum {
+	SDXI_DEV_ATTR_F_RO = BIT(0),
+};
+
+struct sdxi_dev_attr_desc {
+	u32 reg;
+	u64 mask;
+	u32 cap_reg;
+	u64 cap_mask;
+	unsigned int flags;
+	int (*get)(struct sdxi_dev *sdxi, u64 *value);
+};
+
+static int sdxi_dev_attr_get_rkey_entries(struct sdxi_dev *sdxi, u64 *value)
+{
+	*value = sdxi->rkey_cap ? sdxi->rkey_entries : 0;
+	return 0;
+}
+
+static const struct sdxi_dev_attr_desc sdxi_dev_attrs[] = {
+	[SDXI_DEV_ATTR_GSR] = {
+		.reg = SDXI_MMIO_CTL0,
+		.mask = SDXI_MMIO_CTL0_FN_GSR,
+		.flags = SDXI_DEV_ATTR_F_RO,
+	},
+	[SDXI_DEV_ATTR_GRP_ID] = {
+		.reg = SDXI_MMIO_CTL0,
+		.mask = SDXI_MMIO_CTL0_FN_GRP_ID,
+	},
+	[SDXI_DEV_ATTR_MAX_BUFFER] = {
+		.reg = SDXI_MMIO_CTL2,
+		.mask = SDXI_MMIO_CTL2_MAX_BUFFER,
+		.cap_reg = SDXI_MMIO_CAP1,
+		.cap_mask = SDXI_MMIO_CAP1_MAX_BUFFER,
+	},
+	[SDXI_DEV_ATTR_MAX_AKEY_SZ] = {
+		.reg = SDXI_MMIO_CTL2,
+		.mask = SDXI_MMIO_CTL2_MAX_AKEY_SZ,
+		.cap_reg = SDXI_MMIO_CAP1,
+		.cap_mask = SDXI_MMIO_CAP1_MAX_AKEY_SZ,
+	},
+	[SDXI_DEV_ATTR_MAX_RKEY_SZ] = {
+		.flags = SDXI_DEV_ATTR_F_RO,
+		.get = sdxi_dev_attr_get_rkey_entries,
+	},
+	[SDXI_DEV_ATTR_MAX_CXT] = {
+		.reg = SDXI_MMIO_CTL2,
+		.mask = SDXI_MMIO_CTL2_MAX_CXT,
+		.cap_reg = SDXI_MMIO_CAP1,
+		.cap_mask = SDXI_MMIO_CAP1_MAX_CXT,
+	},
+};
+
+static const struct sdxi_dev_attr_desc *sdxi_dev_attr_lookup(u64 attr)
+{
+	const struct sdxi_dev_attr_desc *desc;
+
+	if (!attr || attr >= ARRAY_SIZE(sdxi_dev_attrs))
+		return NULL;
+
+	desc = &sdxi_dev_attrs[attr];
+	if (!desc->mask && !desc->get)
+		return NULL;
+
+	return desc;
+}
+
+static int sdxi_dev_attr_read(struct sdxi_dev *sdxi,
+			      const struct sdxi_dev_attr_desc *desc, u64 *value)
+{
+	unsigned int shift;
+
+	if (desc->get)
+		return desc->get(sdxi, value);
+
+	shift = __ffs64(desc->mask);
+	*value = (sdxi_read64(sdxi, desc->reg) & desc->mask) >> shift;
+	return 0;
+}
+
+static int sdxi_dev_attr_write(struct sdxi_dev *sdxi,
+			       const struct sdxi_dev_attr_desc *desc, u64 value)
+{
+	unsigned int shift;
+	u64 maximum;
+	u64 register_value;
+
+	if (desc->flags & SDXI_DEV_ATTR_F_RO)
+		return -EOPNOTSUPP;
+
+	shift = __ffs64(desc->mask);
+	maximum = desc->mask >> shift;
+	if (value > maximum)
+		return -EINVAL;
+
+	mutex_lock(&sdxi->reg_lock);
+	if (desc->cap_reg) {
+		u64 capability;
+
+		capability = (sdxi_read64(sdxi, desc->cap_reg) &
+			      desc->cap_mask) >> __ffs64(desc->cap_mask);
+		if (value > capability) {
+			mutex_unlock(&sdxi->reg_lock);
+			return -EINVAL;
+		}
+	}
+
+	register_value = sdxi_read64(sdxi, desc->reg);
+	register_value &= ~desc->mask;
+	register_value |= (value << shift) & desc->mask;
+	sdxi_write64(sdxi, desc->reg, register_value);
+	mutex_unlock(&sdxi->reg_lock);
+	return 0;
+}
+
+static bool sdxi_dev_attr_args_valid(const struct sdxi_dev_attr_args *args)
+{
+	size_t i;
+
+	if (args->argsz < sizeof(*args) || args->flags)
+		return false;
+	for (i = 0; i < ARRAY_SIZE(args->rsvd0); i++)
+		if (args->rsvd0[i])
+			return false;
+
+	return true;
+}
+
+static int sdxi_ioctl_get_dev_attr(struct file *file, struct sdxi_file *sf,
+				   void *data)
+{
+	struct sdxi_dev_attr_args *args = data;
+	const struct sdxi_dev_attr_desc *desc;
+	int ret;
+
+	if (!sdxi_dev_attr_args_valid(args))
+		return -EINVAL;
+
+	desc = sdxi_dev_attr_lookup(args->attr);
+	if (!desc)
+		return -EOPNOTSUPP;
+
+	ret = sdxi_dev_attr_read(sf->process->sdxi, desc, &args->val);
+	if (!ret)
+		args->argsz = sizeof(*args);
+	return ret;
+}
+
+static int sdxi_ioctl_set_dev_attr(struct file *file, struct sdxi_file *sf,
+				   void *data)
+{
+	struct sdxi_dev_attr_args *args = data;
+	const struct sdxi_dev_attr_desc *desc;
+	int ret;
+
+	if (!sdxi_dev_attr_args_valid(args))
+		return -EINVAL;
+
+	desc = sdxi_dev_attr_lookup(args->attr);
+	if (!desc)
+		return -EOPNOTSUPP;
+
+	ret = sdxi_dev_attr_write(sf->process->sdxi, desc, args->val);
+	if (ret)
+		return ret;
+
+	args->argsz = sizeof(*args);
+	return sdxi_dev_attr_read(sf->process->sdxi, desc, &args->val);
+}
+
+#define SDXI_IOCTL_DEF(_nr, _cmd, _func, _files, _access)	\
+	[_nr] = {						\
+		.cmd = (_cmd),					\
+		.file_flags = (_files),				\
+		.access = (_access),				\
+		.func = (_func),					\
+	}
+
+static const struct sdxi_ioctl_desc sdxi_ioctls[] = {
+	SDXI_IOCTL_DEF(0x01, SDXI_GET_UAPI_INFO, sdxi_ioctl_get_uapi_info,
+		       SDXI_IOCTL_F_DEVICE | SDXI_IOCTL_F_CONTEXT,
+		       SDXI_IOCTL_A_PUBLIC_DEVICE),
+	SDXI_IOCTL_DEF(0x02, SDXI_GET_DEV_INFO, sdxi_ioctl_get_dev_info,
+		       SDXI_IOCTL_F_DEVICE | SDXI_IOCTL_F_CONTEXT,
+		       SDXI_IOCTL_A_PUBLIC_DEVICE),
+	SDXI_IOCTL_DEF(0x03, SDXI_GET_DEV_ATTR, sdxi_ioctl_get_dev_attr,
+		       SDXI_IOCTL_F_DEVICE | SDXI_IOCTL_F_CONTEXT,
+		       SDXI_IOCTL_A_PUBLIC_DEVICE),
+	SDXI_IOCTL_DEF(0x04, SDXI_SET_DEV_ATTR, sdxi_ioctl_set_dev_attr,
+		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
+	SDXI_IOCTL_DEF(0x05, SDXI_GET_RKEY_LIST, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
+	SDXI_IOCTL_DEF(0x06, SDXI_GET_RKEYS, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
+	SDXI_IOCTL_DEF(0x07, SDXI_SET_RKEYS, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_ADMIN_DEVICE),
+	SDXI_IOCTL_DEF(0x08, SDXI_CREATE_CXT, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_PUBLIC_DEVICE),
+	SDXI_IOCTL_DEF(0x09, SDXI_CXT_EVENTFD, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
+	SDXI_IOCTL_DEF(0x0a, SDXI_GET_AKEY_LIST, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
+	SDXI_IOCTL_DEF(0x0b, SDXI_GET_AKEYS, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
+	SDXI_IOCTL_DEF(0x0c, SDXI_SET_AKEYS, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
+	SDXI_IOCTL_DEF(0x0d, SDXI_ADMIN_DISC, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_PUBLIC_DEVICE),
+	SDXI_IOCTL_DEF(0x0e, SDXI_ADMIN_VENDOR, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_DEVICE, SDXI_IOCTL_A_VENDOR_HANDLER),
+	SDXI_IOCTL_DEF(0x0f, SDXI_QUIESCE_CXT, sdxi_ioctl_unsupported,
+		       SDXI_IOCTL_F_CONTEXT, SDXI_IOCTL_A_CONTEXT_OWNER),
+};
+
+static int sdxi_ioctl_permit(const struct sdxi_ioctl_desc *desc)
+{
+	switch (desc->access) {
+	case SDXI_IOCTL_A_PUBLIC_DEVICE:
+	case SDXI_IOCTL_A_CONTEXT_OWNER:
+		return 0;
+	case SDXI_IOCTL_A_ADMIN_DEVICE:
+		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
+	case SDXI_IOCTL_A_VENDOR_HANDLER:
+		return -EOPNOTSUPP;
+	}
+
+	return -EINVAL;
+}
+
+static bool sdxi_ioctl_has_trailing_payload(unsigned int cmd)
+{
+	return cmd == SDXI_GET_RKEY_LIST || cmd == SDXI_GET_RKEYS ||
+	       cmd == SDXI_SET_RKEYS || cmd == SDXI_GET_AKEY_LIST ||
+	       cmd == SDXI_GET_AKEYS || cmd == SDXI_SET_AKEYS;
+}
+
+static long sdxi_ioctl_live(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	const struct sdxi_ioctl_desc *desc;
+	struct sdxi_file *sf = file->private_data;
+	unsigned int canonical_size;
+	unsigned int user_size;
+	unsigned int size;
+	unsigned int nr;
+	char stack_data[128];
+	void *data = stack_data;
+	bool allowed;
+	int ret;
+
+	if (_IOC_TYPE(cmd) != SDXI_IOCTL_BASE)
+		return -ENOTTY;
+
+	nr = _IOC_NR(cmd);
+	if (nr >= ARRAY_SIZE(sdxi_ioctls) || !sdxi_ioctls[nr].cmd)
+		return -ENOTTY;
+
+	desc = &sdxi_ioctls[nr];
+	if (_IOC_DIR(cmd) != _IOC_DIR(desc->cmd))
+		return -ENOTTY;
+	if (!sf || !sf->process)
+		return -EINVAL;
+
+	ret = sdxi_file_check_owner(sf->process);
+	if (ret)
+		return ret;
+
+	switch (sf->type) {
+	case SDXI_FILE_DEVICE:
+		allowed = desc->file_flags & SDXI_IOCTL_F_DEVICE;
+		break;
+	case SDXI_FILE_CONTEXT:
+		allowed = desc->file_flags & SDXI_IOCTL_F_CONTEXT;
+		break;
+	default:
+		allowed = false;
+		break;
+	}
+	if (!allowed)
+		return -ENOTTY;
+
+	ret = sdxi_ioctl_permit(desc);
+	if (ret)
+		return ret;
+
+	canonical_size = _IOC_SIZE(desc->cmd);
+	user_size = _IOC_SIZE(cmd);
+	size = max(canonical_size, user_size);
+	if (size > PAGE_SIZE)
+		return -E2BIG;
+
+	if (size > sizeof(stack_data)) {
+		data = kzalloc(size, GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+	} else {
+		memset(data, 0, size);
+	}
+
+	if ((_IOC_DIR(cmd) & _IOC_WRITE) &&
+	    copy_from_user(data, (void __user *)arg, user_size)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	ret = desc->func(file, sf, data);
+
+	if ((_IOC_DIR(cmd) & _IOC_READ) && user_size > canonical_size &&
+	    !sdxi_ioctl_has_trailing_payload(desc->cmd))
+		memset((u8 *)data + canonical_size, 0,
+		       user_size - canonical_size);
+	if ((_IOC_DIR(cmd) & _IOC_READ) &&
+	    copy_to_user((void __user *)arg, data, user_size))
+		ret = -EFAULT;
+
+out:
+	if (data != stack_data)
+		kfree(data);
+	return ret;
+}
+
+static long sdxi_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct sdxi_file *sf = file->private_data;
+	struct sdxi_dev *sdxi;
+	long ret;
+
+	if (!sf || !sf->process)
+		return -EINVAL;
+	sdxi = sf->process->sdxi;
+
+	down_read(&sdxi->state_lock);
+	ret = sdxi->online ? sdxi_ioctl_live(file, cmd, arg) : -ENODEV;
+	up_read(&sdxi->state_lock);
+	return ret;
 }
 
 static int sdxi_open(struct inode *inode, struct file *file)
@@ -77,8 +480,8 @@ static const struct file_operations sdxi_fops = {
 	.owner = THIS_MODULE,
 	.open = sdxi_open,
 	.release = sdxi_release,
-	.unlocked_ioctl = sdxi_ioctl_unsupported,
-	.compat_ioctl = sdxi_ioctl_unsupported,
+	.unlocked_ioctl = sdxi_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 int sdxi_chardev_init(void)
diff --git a/drivers/dma/sdxi/ioctl.h b/drivers/dma/sdxi/ioctl.h
index 8677f3e62e93..a6c53758c8b9 100644
--- a/drivers/dma/sdxi/ioctl.h
+++ b/drivers/dma/sdxi/ioctl.h
@@ -42,7 +42,6 @@ struct sdxi_ioctl_desc {
 	unsigned int file_flags;
 	enum sdxi_ioctl_access_class access;
 	sdxi_ioctl_t *func;
-	const char *name;
 };
 
 #define SDXI_IOCTL_F_DEVICE	BIT(0)
diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
index 98d2baffbbdf..03a85a1575e7 100644
--- a/drivers/dma/sdxi/sdxi.h
+++ b/drivers/dma/sdxi/sdxi.h
@@ -96,6 +96,7 @@ struct sdxi_dev {
 	dma_addr_t L1_dma[SDXI_L2_TABLE_ENTRIES];
 	u16 L1_users[SDXI_L2_TABLE_ENTRIES];
 	struct mutex cxt_lock;		/* context table serialization */
+	struct mutex reg_lock;		/* MMIO register updates */
 
 	/* RKey table */
 	struct mutex rkey_lock;
-- 
2.56.1

