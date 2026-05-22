Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526C3115A5;
	Fri, 22 May 2026 05:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427488; cv=fail; b=qbz22SIXAjAgqDqetR+dZNfJsKk9jpOzYr56BFIMoBTN8nxNl5spWO3f0IrAba+dMR30dqB5zT1vKO2URAjrYPx3LgjhI5v8sp18JYaxliQLEmdy//s753D6V9WEHiN8MtbybGpFIgm3E9a1sLEg6ew5ZFto9bj9lmCwggYLAtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427488; c=relaxed/simple;
	bh=xoqbA/iZAaeVTiwosyaBiJvf+fXownsmX1ExOiw3hqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jSXZbie8ahHMfhvCCZzb3KaBC1ZuWCMkiMDYpSc71WiNbixK1votjO0SkKAWKLLBPCgNGVDE2CjomcKMyVaZek71/xxQs2Uwd6zwlLzC+F3L27ZXvgSVf3iMo5Ns5fPlMdDWr8X9eiyw94VEvKn/L5yzprAzI80qp1gA3SWHLpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FM+idV8U; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FM+idV8U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TGut/lc8d53oF7IHgXt/BVyLFx/lGGmfHzw8Lljhwb4Vtfte6nrlkI9r93hmmivrwhRtcVKGtQmRC5T3ASFTHTVvhEkr+sH2yI5FdFzo6Gmi+IOak7GENBm5tEjcJHclVhtYLC77iW3m1zB33aZTaafO7XYhubUWQWoHCtRFbOOSO0BgmU67F41bXrp2aGOhilD37wgwgLzhs4r+3tKx5Yuz9PlpjQaW3D2eJDKYqja1IJAPs25NY+EkPYTk5L1p2Pw8ud5boP24n6ULZoh9Z5EhUaqpVTGVzclEnxx4pQNf0PQt7gYmErBVJhk1W6vhaUCXpvhQSeDM2eTTTPxYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyegXvSY4GdAXMkYzbm/vCYF3nn4dAH9nr2mE60uoZE=;
 b=IrmRvNNhW327u/7i8jhMEeYNNkUE+GTwyTOnrbgV+Hfup0Hb8wLTkc1fljikvjLDRHVdbFCg7WfOrWzxs4xORlqobA+5VWmguBsVfRf6vjJU/LMmqLMWdGHNBlWSx6lskrKUrgYbVIACPAp8qCDHKv1cZ66LKN5JCbCJrT9BXu86F4XT9tISmCJcdjXZE/tmFeCFyiyNvFCfS+LJmwqV9oHup359YpLWK/0ieiBxG9l7u8S4IOi0nM2H3IoTIjgyfdTqHt0usbR6EbKSN4JWFz0siUvaNyvKvwsgPjj88yYMtcWLMIPL9V6xpX85Sd7H1OvsSr9jh79C8ZVATw0rng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyegXvSY4GdAXMkYzbm/vCYF3nn4dAH9nr2mE60uoZE=;
 b=FM+idV8UJPSIv+RZT2Zr+ahnNj9yYuJjnkvUOQaXY6RwHGXKfJTwDeJ52o+bYYGzE8bNPx8rad+ggmiS63Go3VDHKLcYB0aA9jXSDM7N8rJViKjMc++jroGt/XACZe8m4WbGcc9rMxkcUzLgBMySjQoPoJKMEO6Mq0ybK2PTq48=
Received: from BY5PR13CA0022.namprd13.prod.outlook.com (2603:10b6:a03:180::35)
 by DS4PPF0FF25AAD9.namprd10.prod.outlook.com (2603:10b6:f:fc00::d09) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 05:24:43 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:180:cafe::d) by BY5PR13CA0022.outlook.office365.com
 (2603:10b6:a03:180::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via Frontend Transport; Fri, 22
 May 2026 05:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 05:24:41 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 00:24:40 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 22 May
 2026 00:24:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 22 May 2026 00:24:40 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64M5OZpV1350956;
	Fri, 22 May 2026 00:24:36 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v4 0/4] PCI: Add DOE support for endpoint
Date: Fri, 22 May 2026 10:54:30 +0530
Message-ID: <20260522052434.802034-1-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DS4PPF0FF25AAD9:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aae50e3-567c-4815-2088-08deb7c26d15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|82310400026|18002099003|56012099003|921020|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info:
	VnXYTPtPM5uRgbBrsGz0DU/lZQ+9duQoVGu1kYxli+vK5JYaXzRhCvIetSHVOPe3KtHPP2nR9FkT9QjASgeoTlFd1wvJXD8TyGoNw1vmlKzXNxi2HTzYxZhkqokMLzK0Zo8jielRNB4YEbnB2CSGGGE1FC8bXqfqq5Xlc+xZ0UTnu9XN+7JuW5QkGuJiC36pyh+XuUDBiKIgsJPNyOdRO9sAKiNFEWGVpXy8wq2k5bccX3IdyGAvsAqgE/BjYlpjS7VxEM3sP4Rf29xGO7WfMr288hyYJCtgV2IuRDNFprmeLbuUDkC2JUSwwrG9m2AHYUvLnlmhrepzgteaRFh4LzwliSOaleKMeK7DiJMA4UKeC52bbqwFSHL/slSV516LVJ1sWSvrbifDobhOQEiJFt3ZqQBy7sH9u0BaeLxEiQa9b5m7vvdF3skfTlHXL/fDeyKZ4uO2sOWSj1nqO61jtCXi+u5GfeJUrNLBXudWLWwVtvP8oQ3beoIdG91zdxV4JAIIxbtNkuAYuopshLrnyCcprmbsXR1oBwfrn97qkyIvJg9Rkdsoqc1EXKoJHH8qbGdZPXLsL1/Iwygy5BEvmQosVMcGr16yESYkLjUmJRilmrokTDk+13nKLPLCcjjMeQXzmnl6PSubeA/pkrj5TfiPs4Nqn2RxDCrSrzDDFAZU8k6uyKbD5cYnPIgm6fzknfgbRExoipjJAwAJ4gEZA/qOTKQEWI1qesVY/bA5J68uNguRyCnF33WUB/Ol1dXx9X4uiTS99XiqXRsHKIAMZWIH/Lv+TGrR8BFJgD/fXsU=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(921020)(6133799003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VOjZ1mMDQQngXt2vgloQ8B2Vk/WGpP2DqqEvvSDx04Btjz9fDvrnITtbJ7wozTFABYQX+I2C/a/fDmowtI1Vei16r3fYur5+6abvc3nXFZuUPj9TquuI+OlUSqn1gCWYSeFprASvph+/KVCT9GEGGveY9wG9f7I1C5iNqqn96Xo9HGg0KCOUqP0jWhsNANzNmDMULXERWfpzs5zGGS0edVQWVjUSJNiBhILoqHrPp+RgBV6lU4j2sDIkD3hHF16K0aaCAAZIhYUBVXUXhrszh+BPaKayjQKUploLqSYDIKtfEMtXXn1QFZ25CvqSCYGdEj3GZP9v0r8G+wCyH712dAupEMeem/N3F5x1fdDgxDR9Bjwncut42elDCC8TStVb20ow+5QGXsxudwkLJhMTVhZSnggY8l1pR+h06CQ53Y8v2GUaZaOUKjxchw4wkfTx
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 05:24:41.3541
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aae50e3-567c-4815-2088-08deb7c26d15
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF0FF25AAD9

This patch series introduces the framework for supporting the Data
Object Exchange (DOE) feature for PCIe endpoint devices. Please refer
to the documentation added in patch 4 for details on the feature and
implementation architecture.

The implementation provides a common framework for all PCIe endpoint
controllers, not specific to any particular SoC vendor.

The changes since v1 are documented in the respective patch descriptions.

v3: https://lore.kernel.org/all/20260427051725.223704-1-a-garg7@ti.com/
v2: https://lore.kernel.org/all/20260401073022.215805-1-a-garg7@ti.com/
v1 (RFC): https://lore.kernel.org/all/20260213123603.420941-1-a-garg7@ti.com/

Below is a code demonstration showing the integration of DOE-EP APIs with
EPC drivers.

Note: The provided code is just to show how an EPC driver is expected to
      utilize the pci_ep_doe_process_request() and pci_ep_doe_abort() APIs,
      and might not cover all the corner cases. The below implementation
      also expects the EPC hardware to have some memory buffer to store the
      data from(for) write_mailbox(read_mailbox) DOE capability registers.

============================================================================

/* ========== DOE Completion Callback (invoked by DOE-EP core) ========== */

static void doe_completion_cb(struct pci_epc *epc, u8 func_no, u16 cap_offset,
			       int status, u16 vendor, u8 type,
			       void *response_pl, size_t response_pl_sz)
{
	struct epc_driver *drv = epc_get_drvdata(epc);
	u32 *response = (u32 *)response_pl;
	u32 header1, header2;
	int payload_dw, i;

	if (status < 0) {
		/* Error: set ERROR bit in DOE Status register */
		writel(1 << DOE_STATUS_ERROR,
		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
		goto free;
	}

	if (readl(drv->base + PF_DOE_CTRL_REG(func_no, cap_offset)) & DOE_CTRL_ABORT) {
		/* Aborted: do not send response */
		goto free;
	}

	/* Success: write DOE headers first, then response to the read memory */

	/* Header 1: Vendor ID (bits 15:0) | Type (bits 23:16) */
	header1 = (type << 16) | vendor;
	writel(header1, drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));

	/* Header 2: Length in DW (including 2 DW of headers + payload) */
	payload_dw = DIV_ROUND_UP(response_pl_sz, sizeof(u32));
	header2 = 2 + payload_dw;  /* 2 header DWs + payload */
	writel(header2, drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));
	
	/* Set READY bit to signal response ready */
	writel(1 << DOE_STATUS_READY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));

	/* Write response payload DWORDs to Read memory */
	for (i = 0; i < payload_dw; i++)
		writel(response[i],
		       drv->base + PF_DOE_RD_MEMORY_WR_REG(func_no, cap_offset));

	/* Wait for the memory to empty before clearing the READY bit */
	while (!RD_MEMORY_EMPTY()) {/* wait */}

	writel(0 << DOE_STATUS_READY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
	
	/* unset BUSY bit */
	writel(0 << DOE_STATUS_BUSY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
free:
	kfree(response_pl);
}

/* ========== DOE Interrupt Handler (triggered on GO bit from root complex) ========== */

static irqreturn_t doe_interrupt_handler(int irq, void *priv)
{
	struct epc_driver *drv = priv;
	u16 cap_offset = extract_cap_offset_from_irq(irq);
	u8 func_no = extract_func_from_irq(irq);
	u32 header1, header2, length_dw, *request;
	u16 vendor;
	u8 type;
	int i, ret;

	/* Read first header DWORD: Vendor ID (bits 15:0) | Type (bits 23:16) */
	header1 = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
	vendor = header1 & 0xFFFF;
	type = (header1 >> 16) & 0xFF;

	/* Read second header DWORD: Length in DW (includes 2 DW of headers) */
	header2 = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
	length_dw = header2 & 0x3FFFF;  /* Bits 17:0 */

	if (!length_dw)
		length_dw = PCI_DOE_MAX_LENGTH;

	length_dw -= 2;  /* Subtract 2 DW of headers to get payload length */
	/* Allocate buffer for complete request (headers + payload) */
	request = kzalloc(length_dw * sizeof(u32), GFP_ATOMIC);
	if (!request) {
		writel(1 << DOE_STATUS_ERROR,
		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
		return IRQ_HANDLED;
	}

	/* Read remaining payload DWORDs from Write memory */
	for (i = 0; i < length_dw; i++) {
		while (WR_MEMORY_EMPTY()) { /* wait */ }
		request[i] = readl(drv->base + PF_DOE_WR_MEMORY_RD_REG(func_no, cap_offset));
	}
	/* Set BUSY bit */
	writel(1 << DOE_STATUS_BUSY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));

	/* Hand off to DOE-EP core for asynchronous processing */
	ret = pci_ep_doe_process_request(drv->epc, func_no, cap_offset,
					 vendor, type, (void *)request,
					 length_dw * sizeof(u32),
					 doe_completion_cb);
	if (ret) {
		writel(1 << DOE_STATUS_ERROR,
		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
		kfree(request);
	}

	return IRQ_HANDLED;
}

/* ========== Abort Handler (triggered on ABORT bit from root complex) ========== */

static irqreturn_t doe_abort_handler(int irq, void *priv)
{
	struct epc_driver *drv = priv;
	u16 cap_offset = extract_cap_offset_from_irq(irq);
	u8 func_no = extract_func_from_irq(irq);

	/* Abort pending/in-flight operations in DOE-EP core */
	pci_ep_doe_abort(drv->epc, func_no, cap_offset);

	/* Discard Write memory contents */
	writel(DOE_WR_MEMORY_CTRL_DISCARD,
	       drv->base + PF_DOE_WR_MEMORY_CTRL_REG(func_no, cap_offset));

	/* Clear status bits */
	writel((0 << DOE_STATUS_ERROR) | (0 << DOE_STATUS_BUSY) |
	       (0 << DOE_STATUS_READY),
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));

	return IRQ_HANDLED;
}

====================================================================================

Aksh Garg (4):
  PCI/DOE: Move common definitions to the header file
  PCI: endpoint: Add DOE mailbox support for endpoint functions
  PCI: endpoint: Add support for DOE initialization and setup in EPC
    core
  Documentation: PCI: Add documentation for DOE endpoint support

 Documentation/PCI/endpoint/index.rst          |   1 +
 .../PCI/endpoint/pci-endpoint-doe.rst         | 329 +++++++++++
 drivers/pci/doe.c                             |  11 -
 drivers/pci/endpoint/Kconfig                  |  14 +
 drivers/pci/endpoint/Makefile                 |   1 +
 drivers/pci/endpoint/pci-ep-doe.c             | 553 ++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           |  92 +++
 drivers/pci/pci.h                             |  48 ++
 include/linux/pci-doe.h                       |   8 +
 include/linux/pci-epc.h                       |   9 +
 10 files changed, 1055 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst
 create mode 100644 drivers/pci/endpoint/pci-ep-doe.c

-- 
2.34.1

