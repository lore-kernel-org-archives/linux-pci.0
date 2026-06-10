Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512153E3160;
	Wed, 10 Jun 2026 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085815; cv=fail; b=Nv/3ACIKOV4qRNRNodd4N57j7Sw0riSFJrsook0Fc4edYBwp2gRfptYDpXn8fA3kVXgzCG1ZOfGkKC3wAPnmjF19ACEd7h3cRx0iKQLAEpANSVL5e1rhCJJF+syioojrewmIbumzHrZMsgbmU/Qh/175uFHKOoN+qgJwGAFVSm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085815; c=relaxed/simple;
	bh=7OzAq23nSdPmQeKXCdaFZyEGGkRv8hw1BLvTQiVM+us=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IPqOhetOCW1oOzhIdvH5edQ7JYj2Kldc+PJVGclNzJCFZqz5GC0y44vYilPmL+6wsOqQ5Lr9S/xijkArWw8yg+r3X12at0XNdPn3oXqJjUc2902h6MM2RwOWRg8eSkIEycxpXCaixkgxJI/yO/VHwwuclNmTxQaN5eJ3Z8c8n/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B4cm70d/; arc=fail smtp.client-ip=52.101.53.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B4cm70d/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiOXi5HL/AUPDBf2UhGpYRxGGU1w8SdbTPtJ96RQqOk6rV8BIjH3bZgmmBsvXvmQHpMJOv60Y55YiVEtRraz1Rgo+oOF7v5VztvuQl1BPwo7ZelUGWcQXXVe382V9YOlsBCEXf1/wFpU9eKf2JUKex711KxNcmtiH4E3yQ1N8kLNT03JGwiJNoVTq5aqq2xJUbp63ZS4zbCUaIYnsgSagMLCcTxeB16j82zTh6ka6YPkHZXQ9PAurq+0H0F8OsMKgGxR8Tcj9PxhSorVebcP99CR+zuJR+9IJVJhDJ4vgeoO8I+G3k5x0SkRtD0B0fGD5nYsraRHxA06RUYH/2cNHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ncw9Rul5OuhTdncVfuy85kUSOEPsy64A/byN++d+2s=;
 b=MRgv4v8OcIiMmfLtpnAsBB/hGut6RqoBw5skMsLOKcuHcMAOyWdaCMcmrW/yhJtTuPc7jz1pufhgMvjo/O5DDVBXtv3OF61OkCnkVFYhx2+s9IGq4iv68NN6/Ap4Xr+4B1RyFwbfPNDHKeO6SOusEN5nRi+bS+EDkEyGrepMcUSjjyMRFiG6EcqQUYKmJZgfdKlOxFOStq/6JLVFOBIQZ4OAJWvcBKhB3rwFzxuQsViUl9c0Udp1og/sJwpIWPi7xsnVXQwoBuqWjIFickzKla8E7JkjsAOgN4AlXAKxu2vGxB9+oLFpulcIlSjlZT0zrzFI8IRe+9tponxPYdNzXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ncw9Rul5OuhTdncVfuy85kUSOEPsy64A/byN++d+2s=;
 b=B4cm70d/VRuiqbCMN7wVFOcu5ar3vG+XUt29hqQbHS41ncum2dJ2G3CjgmLHlRMGzWkJOXOXi+khbymQhBeubbVD2vCrQw+CaLjqIyiLg0UiBcB2m0OQZ8Myk0qzZF+JcgdOWLQJ/N2vQxpM/xpFIJ1Pl948drXls/Y0qKV9TG4=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by PH0PR10MB6959.namprd10.prod.outlook.com (2603:10b6:510:28f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 10:03:28 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::86) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 10:03:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 10:03:27 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 05:03:02 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 05:03:02 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 10 Jun 2026 05:03:02 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65AA2u8u3620198;
	Wed, 10 Jun 2026 05:02:57 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<mani@kernel.org>, <kwilczynski@kernel.org>, <bhelgaas@google.com>,
	<corbet@lwn.net>, <kishon@kernel.org>, <skhan@linuxfoundation.org>,
	<lukas@wunner.de>, <cassel@kernel.org>, <alistair@alistair23.me>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<s-vadapalli@ti.com>, <danishanwar@ti.com>, <srk@ti.com>, <a-garg7@ti.com>
Subject: [PATCH v5 0/4] PCI: Add DOE support for endpoint
Date: Wed, 10 Jun 2026 15:32:52 +0530
Message-ID: <20260610100256.1889111-1-a-garg7@ti.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|PH0PR10MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c82312-d5c0-4656-2849-08dec6d78443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|36860700016|82310400026|6133799003|921020|5023799004|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MaSduyizkIIyJ6coP437696SsHUwTNadgmsyFohy7NQOv1gffCtHRIq8EmZHdonrGqZ5vzI0yFOtUUOIhQwGms0CryGDDllsdYvJVb+aiE1FZrsOcns6CIKkE8+NuiKYJp702JlzZ+kUPB5XQ72pHM7NILLUrCU0immvIVjNXaVSpg45YJp6bgLGt53YRN17sg3NzyCqzzdO5kXgbjLqdMdmauZGK2msRYqMvXdxEXvtDRpIQjyqDRmx46ukl02z6yCJQHrViilkf5Qq2g6X/th/qOsDWOuAXPqLAvVrpZkpJOZjoCK+/VeMP+vkb+n7nYZmfeRyoFr5f6LAo8wyjYMKSKemFxk2OfoxZgeGcBzM+H0Mix35L1MIzhgytd72z21aiCiYs/HThCnWq48ll7KdfE1rNMfUm1MYWRZ5ts08+Fgqx8XOib89ayv8tAZf9Wh9ZW1T2zHWfbM+n+SCHKjU1UpLU3BXLwCj6V58LEpcSI0mV55hXF1S4BV+h4QBEjPnnKOsaLjtrJo9b6kzMPsnoCy/C29lrgKE667rIBqF8s7J++70gZ2bZqg0H2sY0xh8sRNRUSbx0caAxH10SrFQYrNx0MMwJ7qlgGE9DHFvGmHROKtwLkjaxW84C/fjh1oPZazU6xJWbyh+FoIQ11i/0sYQXGuvSUBkvohp0D6fm4LSVeG9LWJ3E+QHsa5YfNBdKf9AsghGXfpejy1jX73M1C3AGa7O07TBGh6tu/zAJle3YshsJMNClW8QhCnsQQVUwE/Pdk9/qeEOvQr2mwpZrEu/EIooD9qvgyLxSYs=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(36860700016)(82310400026)(6133799003)(921020)(5023799004)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	titbil0RSc1xYjy1rOlC1U7EO4c6jhGgUS17qkVe1ZioTMsfK6BT+kXgpUQF8L9ljFLycNmv3ZXaQR8CpEYf6BoOpj+PJzPEX5/+vQv/1ZPMKuLCEgt4qfP81saOMtO2RTWL//rkjHzhcMjZGu+b6ZYQVZJaZgRFF9USxBq55fP5B6r0IDtd5/zymMggUQL9rPvsloGRF6kvjWHQzOdNT8ze3mFAEzmR7kET72ClofclKAW4jpFunQWjj/bKtMWy+P4K3MYBKA3Bu2uemw1M+1vFIKtGUxBAZp5mBa6ESWUgq9tfXdtn9XOr7x4yfYc2fOIYlvEf1H/a9ZlX1/p4iw59ab8ozgw0TCmrjIBlC2qvTEx9QJNfqQqBD7VGKvEO9cs12TpWDydZwPP2KbWRNO79qd924keRWg+Gn/M+umbEV7GobZkxS1KVHx5fGjrM
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:03:27.1643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c82312-d5c0-4656-2849-08dec6d78443
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6959

This patch series introduces the framework for supporting the Data
Object Exchange (DOE) feature for PCIe endpoint devices. Please refer
to the documentation added in patch 4 for details on the feature and
implementation architecture.

The implementation provides a common framework for all PCIe endpoint
controllers, not specific to any particular SoC vendor.

The changes since v1 are documented in the respective patch descriptions.

v4: https://lore.kernel.org/all/20260522052434.802034-1-a-garg7@ti.com/
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
	
	if (readl(drv->base + PF_DOE_CTRL_REG(func_no, cap_offset)) & DOE_CTRL_ABORT) {
		/* Aborted: do not send response */
		goto free;
	}

	if (status < 0) {
		/* Error: set ERROR bit in DOE Status register */
		writel(1 << DOE_STATUS_ERROR,
		       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
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

free:
	/* unset BUSY bit */
	writel(0 << DOE_STATUS_BUSY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));

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
	
	mutex_lock(&lock);
	/* Check the ABORT bit, if set then return */
	if (readl(drv->base + PF_DOE_CTRL_REG(func_no, cap_offset)) & DOE_CTRL_ABORT) {
		kfree(request);
		mutex_unlock(&lock);
		return IRQ_HANDLED;
	}

	/* Set BUSY bit */
	writel(1 << DOE_STATUS_BUSY,
	       drv->base + PF_DOE_STATUS_REG(func_no, cap_offset));
	mutex_unlock(&lock);

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
	
	mutex_lock(&lock);
	
	/* call abort API only if BUSY bit set (pci_ep_doe_process_request() called) */
	if (readl(drv->base + PF_DOE_STATUS_REG(func_no, cap_offset)) & DOE_STATUS_BUSY)
		pci_ep_doe_abort(drv->epc, func_no, cap_offset);
	
	mutex_unlock(&lock);

	/* Discard Write memory contents */
	writel(DOE_WR_MEMORY_CTRL_DISCARD,
	       drv->base + PF_DOE_WR_MEMORY_CTRL_REG(func_no, cap_offset));

	/* Clear status bits */
	writel((0 << DOE_STATUS_ERROR) | (0 << DOE_STATUS_READY),
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
 .../PCI/endpoint/pci-endpoint-doe.rst         | 333 ++++++++++
 drivers/pci/doe.c                             |  11 -
 drivers/pci/endpoint/Kconfig                  |  14 +
 drivers/pci/endpoint/Makefile                 |   1 +
 drivers/pci/endpoint/pci-ep-doe.c             | 594 ++++++++++++++++++
 drivers/pci/endpoint/pci-epc-core.c           | 104 +++
 drivers/pci/pci.h                             |  48 ++
 include/linux/pci-doe.h                       |   8 +
 include/linux/pci-epc.h                       |   9 +
 10 files changed, 1112 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-endpoint-doe.rst
 create mode 100644 drivers/pci/endpoint/pci-ep-doe.c

-- 
2.34.1

