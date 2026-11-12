Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794493157;
	b=ct+UwrpU+BLoPmrlHat6WiBq85Xt/2ZQVJXmRcB04ru2DmAN4KLycEGiCzfU3PBXVDJw
	 T2ZbRqMjpWPvxSo32TvAiy/aKC9LJ5VgOdqTuktXwLkylHIm4oEQoSIPmaLPqFFqpkyKA
	 pYBAJTXVZFCm8cBOf1nra6bH6j83JxKj2swfzqiE+tCpesw3fSy2a5HH2Y9Y+R9zyTN7r
	 TnZxO2x88hSE9WDulKlM4Winwd3kY7ehFHp+EhO65hToSvqr82Ze+jnH5WLnN3LDwPI0/
	 yP7mLiNC7wgpstHO263yeb4gSxo70izc2VHZ47v9gZQ1VlHmgIC3hLQS1o8NUKeFNHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493157;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=FjcptbZKjfmcf/jJSQ7TZrPRqTJcydL9Rle+jXfe298=;
	b=MrICQF3pMBFzC31QfbJMfpQ5G5Cog5Lq32BLN4VDiiJ4d6pqI/cswDi8Ix64nmmRzmpp
	 e9P+25UcFYV2+II8iKAYCFLlphyTvqrLZHgrm4/4u9dQLFTU7gXGxmMAvF9lb6c7Ss98H
	 vQ0KurPGrZ0mQTURKMDy4/JSdZfoDdmOBUFq2B7suIfqnbML5FdBlJpcrSStuR/307Apa
	 ozr12+UMO454lhTXfo2p3wcGVNFKjQe6FCx7j+JY8TbDLF6kP67RbgyQGtf5dVzhDfpLp
	 ukIkCNpzyGaet04D3It2WFBSarXR1aFmOXUte97KnR9rsTDaMyY3MEN0nawA+2M99Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RyC7rnbP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.6
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96322606E65E;
	Thu, 12 Nov 2026 14:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96322606E65E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RyC7rnbP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWi3xaIZUzMg3zxwTkHgu23ihqHB21Da3PBmG9Lp8nDPz/ngcpnU2qSLL2xvFOQ8AjrJSQz+rIPmatC1OvpkzuJs2fvzqa0wuEg4Ut2wVOUHdZz7sc1RwnbzzNjRUUwbPwrIALR+V686E+wkZRppUUyMZ6adHGbd6l4gckLZBk/VYIDDnhaSGCx3dz0fawPti7GHf5jsXm1rrOBK+1AVFhKmnfBfvu9LmwFK8eJDD0C/qZfmjQ3+IdRVrU6OB23U38OJtj+P5pn91Z7os4sPpuyif+k90iZkVKCtgYSODHMcPAq/APjUMxcgn73iVxtJ1V6o/ttDWFuISBFgf0axiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjcptbZKjfmcf/jJSQ7TZrPRqTJcydL9Rle+jXfe298=;
 b=VCX+fJf0FdjSQIh6koi4hdIUzBv00yXjJszNX9M5F+eg3DZhc7h2/+GlO/OPa9ap34c3PIEk3plQ0OOWJNRPR4xPuaimLNDhPXopIZfbTM0xu07kBA79dOyI0se0TPCW+5gycgmC3ayZeSXfJ3EiQ+9YUnnvANjY243hkM8rd7e6f/ZCfP0jukWV1cgYrJ/groW/9NdbMuXThVuoOXcHH/aCM7HhBWt5BKY7TKbjXcF/3LhFYb+4xlwiHjygjyB8fi7TAuOpiI2HyKO33FAzJ9jbj1zJLjIw7BCxUM/kRXp7qOFpsxfBPfAoD+ahaB5pUr2CYEHSUE9mYjK9f3BYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjcptbZKjfmcf/jJSQ7TZrPRqTJcydL9Rle+jXfe298=;
 b=RyC7rnbPYqMB+Gxog7wmFhEC2mj+Q+O1ZZH7YMbJtZfyUyKjt1XCQ3vcQJOE6KsJv5aflVmYEAAtPSktEqLwa6ZMfaTaotP+zEyjbK4lUurUOjUeyg1QEHbt1SRVx8569KS4zEoOpaKgf+KJJdd11HkLCZTbdMZTCf+qVWC+8nLPaGxkN6NTG7ceAfWCh3j7on8Y3FJNLNza/p9pEUdxYtRFA5RpicTj1/CA06cLaSTRUVQTp38Djv0KEIn12KOmTR/Ri5hVie/Eq5jvyKcnyW4KHD/uNhjQ3mlUXUzXWMmPxdtteBQZW7EKFpHfS1zc5T595fsY+u0+g+c2A5+DnA==
Received: from PH0PR07CA0026.namprd07.prod.outlook.com (2603:10b6:510:5::31)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 14:19:10 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:510:5:cafe::54) by PH0PR07CA0026.outlook.office365.com
 (2603:10b6:510:5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 14:19:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 14:19:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:44 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 06:18:41 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <ankita@nvidia.com>,
	<nathanc@nvidia.com>, <mochs@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [RFC PATCH v3 16/20] vfio/pci: Restore device state from slot_reset()
Date: Thu, 12 Nov 2026 14:16:28 +0000
Message-ID: <20261112141632.918954-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112141632.918954-1-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
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
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2607b5-b7c0-469b-1151-08df40c7eb45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003|6133799003|261021123027099003|261009223027099003|261026121527099003|261102130727099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261102123227099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	rmU0CZxg9L4Iimm1mhIp+YsbJMykQidxdsz+aWUjRCB6DwWHfFnWMx1r8OcnUSG9E714exX4/T+qrEZAeW2HgwVwXZ4aEiIzRiPlhuF47SweoYGqebEo6stGu2rdr4LGkyuYyWEPJiVJo35V7RB4NuheavK/SBmnNok+eMUIiH94jbS90z5OBcGTYSol+4bj+p56lEbJXkQGwPrmK48wdUmPMWlRNDgfC35Z9wzkyneIox8efUvDR9TXpOUzDFckMN3r2PrYwcbHnySYc2W6dWUwOJ2RQPq2EmIyfx9sl3IVZX/cFJtAySNpkUvpedPe1TYu5iLs886F2SgWfExjMC60bYeQGkC5vdcp7fqRuFGfUoIhOJ2bf6N9Ojd+rvpetKfLE0fEVs9ti0B6Qqf21Py6iK4K/5I1d/WfeaZFSJh5UW3IKunpV1UFOCnnprDfSKXLK5dvvrq4jKf0B3HYD/+9GEjENR8bDmig1YeDYBk/xWkVod3GB8OdxiMxvTTUr0r3/j59/8fcyukkCfZySQedcB3MFfEVmNWTB9raEYnnKmiXlD8iJ6k6q1VGII07bQc7jPfwi+FPndX7uAZRRZSOxDxNyk9RCAq9PIu93xaRYmFAAJv04TfXI/FX5I1Hs6CPU1BAQc0o4dW+rngvxXG1wnEK4lZ+5DHDkNOegQJ5I/BiWvrZkgdmizIm6gRLQ2Nz3o3Zz9r68Ou1qwod5Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003)(6133799003)(261021123027099003)(261009223027099003)(261026121527099003)(261102130727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261102123227099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	upR2Id7TOnsSxLdXkIrV7OxWmo+cZaRe13f4Dg9bK6CWJx25coKioFSKuHw0AwgXOwG1hBRqloFU/TD0yg4MdKp/LSTWoJ6RJ/R+O7GUUiFdz7WrbKVFzinZh0PWTYzTKuhcsavvA03V6AWR7meYfb9t4dAm+MSsdQqHtzkEilixupxKy6Y7ADCqcWl4jpoLBZZIBRc8TOGwFmeX2rK9iCjVAQeccpN7rHmPYJuvNqk2PAkgouejoiYQO2xg6olqgwWPJMQPGaIR+eh5Uv9XFbDuyxdKhBPmgy5alJ+7eLIqs8rnndnqu8Z4nKxWsJBd9RE0Sise63S8/4zOk06m72HohI3xrJi1LhyEFZB6bwNqR0lBHRt00GtDqLCVMWSH7ufeRL99uuQutbJjb8Iyv8RzI3c1Pod1qMgEMtdm2niusodI9aL88Ld7sA+GSBcs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:19:09.8725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2607b5-b7c0-469b-1151-08df40c7eb45
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

A host reset loses device configuration and IRQ state. Add slot_reset()
to restore the configuration saved at open, discard the old PM snapshot
and tear down IRQ configuration for userspace to rebuild. Record RESET
before restoration so failures also report that a reset occurred. Leave
failed devices blocked.

Use the locked PCI power helper because native PCI recovery already
holds pci_bus_sem for reading. Taking it again could deadlock behind a
queued writer.

Preserve NoINTx and recovery masking when restoring saved configuration.
The state saved at open predates the NoINTx correction. Route PM
restoration through access ops while the device is open. Open and close
continue to restore state directly.

Keep the original error_detected-only callback table for Xen PV and EEH-
enabled builds. Xen treats a missing slot_reset callback as recovered
but treats NONE from a callback as failure. EEH also uses callback
presence to decide whether to keep a device. Disabling the new feature
alone would not preserve these decisions.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_priv.h |   2 +
 include/linux/vfio_pci_core.h    |   1 +
 drivers/vfio/pci/vfio_pci.c      |  17 +++++
 drivers/vfio/pci/vfio_pci_core.c | 112 ++++++++++++++++++++++++++++++-
 4 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index e4f3e4f51180..bb22f0a15416 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -98,6 +98,8 @@ struct vfio_pci_access_ops {
 			vfio_pci_access_fn fn, void *data);
 	/* Caller holds memory_lock. */
 	int (*set_power_state)(struct vfio_pci_core_device *vdev, pci_power_t state);
+	/* Used by PM restoration while the device is open. */
+	void (*restore_config)(struct vfio_pci_core_device *vdev);
 	/* Caller holds memory_lock. */
 	void (*restore_dmabufs)(struct vfio_pci_core_device *vdev);
 	/* Caller holds the PCI device lock. The device need not be open. */
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index fadbbaa58770..d36bca65d180 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -288,6 +288,7 @@ int vfio_pci_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,
 int vfio_pci_core_runtime_suspend(struct vfio_pci_core_device *vdev);
 int vfio_pci_core_runtime_resume(struct vfio_pci_core_device *vdev);
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vdev);
+pci_ers_result_t vfio_pci_core_aer_slot_reset(struct vfio_pci_core_device *vdev);
 
 /*
  * Per-driver PM/AER trampolines. driver_data points to the driver's private
diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index e7c012febe91..b4b3351cbd85 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <xen/xen.h>
 
 #include "vfio_pci_priv.h"
 
@@ -249,8 +250,20 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
 	return vfio_pci_core_aer_err_detected(vdev);
 }
 
+static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = pci_get_drvdata(pdev);
+
+	return vfio_pci_core_aer_slot_reset(vdev);
+}
+
+static const struct pci_error_handlers vfio_pci_legacy_err_handlers = {
+	.error_detected = vfio_pci_aer_err_detected,
+};
+
 static const struct pci_error_handlers vfio_pci_err_handlers = {
 	.error_detected = vfio_pci_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 
 static struct pci_driver vfio_pci_driver = {
@@ -309,6 +322,10 @@ static int __init vfio_pci_init(void)
 {
 	int ret;
 
+	/* Xen PV and EEH check for callbacks. Keep the original table. */
+	if (xen_pv_domain() || IS_ENABLED(CONFIG_EEH))
+		vfio_pci_driver.err_handler = &vfio_pci_legacy_err_handlers;
+
 	/* Register and scan for devices */
 	ret = pci_register_driver(&vfio_pci_driver);
 	if (ret)
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 0ef51810254e..039fd864119b 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -312,6 +312,16 @@ static void vfio_pci_probe_power_state(struct vfio_pci_core_device *vdev)
 	vdev->needs_pm_restore = !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET);
 }
 
+/* Keep NoINTx and recovery INTx masking when loading saved state. */
+static void vfio_pci_recovery_mask_saved_intx(struct vfio_pci_core_device *vdev)
+{
+	if (vdev->nointx ||
+	    (vdev->pci_2_3 &&
+	     READ_ONCE(vdev->irq_type) == VFIO_PCI_INTX_IRQ_INDEX))
+		vdev->pdev->saved_config_space[PCI_COMMAND / 4] |=
+			PCI_COMMAND_INTX_DISABLE;
+}
+
 static int vfio_pci_sriov_configure_live(struct vfio_pci_core_device *vdev,
 					 int nr_virtfn);
 static int vfio_pci_prepare_hot_reset(struct vfio_pci_core_device *vdev);
@@ -329,6 +339,11 @@ static long vfio_pci_access_blocked(struct vfio_pci_core_device *vdev,
 	return -EIO;
 }
 
+static void vfio_pci_restore_config(struct vfio_pci_core_device *vdev)
+{
+	pci_restore_state(vdev->pdev);
+}
+
 static int vfio_pci_power_blocked(struct vfio_pci_core_device *vdev,
 				  pci_power_t state)
 {
@@ -339,6 +354,12 @@ static void vfio_pci_restore_dmabufs_blocked(struct vfio_pci_core_device *vdev)
 {
 }
 
+static void vfio_pci_restore_config_blocked(struct vfio_pci_core_device *vdev)
+{
+	vfio_pci_recovery_mask_saved_intx(vdev);
+	pci_restore_state(vdev->pdev);
+}
+
 static int vfio_pci_sriov_configure_blocked(struct vfio_pci_core_device *vdev,
 					    int nr_virtfn)
 {
@@ -351,6 +372,7 @@ static int vfio_pci_sriov_configure_blocked(struct vfio_pci_core_device *vdev,
 static const struct vfio_pci_access_ops vfio_pci_live_ops = {
 	.execute = vfio_pci_access_live,
 	.set_power_state = vfio_pci_try_set_power_state,
+	.restore_config = vfio_pci_restore_config,
 	.restore_dmabufs = vfio_pci_dma_buf_restore,
 	.sriov_configure = vfio_pci_sriov_configure_live,
 	.prepare_hot_reset = vfio_pci_prepare_hot_reset,
@@ -361,6 +383,7 @@ static const struct vfio_pci_access_ops vfio_pci_live_ops = {
 static const struct vfio_pci_access_ops vfio_pci_blocked_ops = {
 	.execute = vfio_pci_access_blocked,
 	.set_power_state = vfio_pci_power_blocked,
+	.restore_config = vfio_pci_restore_config_blocked,
 	.restore_dmabufs = vfio_pci_restore_dmabufs_blocked,
 	.sriov_configure = vfio_pci_sriov_configure_blocked,
 	.prepare_hot_reset = vfio_pci_prepare_hot_reset_blocked,
@@ -476,7 +499,11 @@ static int __vfio_pci_set_power_state(struct vfio_pci_core_device *vdev,
 			vdev->pm_save = pci_store_saved_state(pdev);
 		} else if (needs_restore) {
 			pci_load_and_free_saved_state(pdev, &vdev->pm_save);
-			pci_restore_state(pdev);
+			/* Open and close restore state without reopening access. */
+			if (!READ_ONCE(vdev->device_open))
+				pci_restore_state(pdev);
+			else
+				vfio_pci_access_ops(vdev)->restore_config(vdev);
 		}
 	}
 
@@ -2640,6 +2667,89 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct vfio_pci_core_device *vde
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
+/*
+ * The caller holds memory_lock. Discard the PM state saved before reset.
+ * Supported native PCI recovery paths already hold pci_bus_sem for reading.
+ * Taking it again could deadlock behind a queued writer.
+ */
+static int vfio_pci_recovery_restore_state(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int ret;
+
+	if (!vdev->pci_saved_state)
+		return -ENODATA;
+	ret = pci_load_saved_state(pdev, vdev->pci_saved_state);
+	if (ret)
+		return ret;
+
+	kfree(vdev->pm_save);
+	vdev->pm_save = NULL;
+	ret = pci_set_power_state_locked(pdev, PCI_D0);
+	if (ret)
+		return ret;
+
+	vfio_pci_recovery_mask_saved_intx(vdev);
+	pci_restore_state(pdev);
+	return 0;
+}
+
+pci_ers_result_t vfio_pci_core_aer_slot_reset(struct vfio_pci_core_device *vdev)
+{
+	int ret = 0;
+
+	mutex_lock(&vdev->access_lock);
+	if (!(vdev->pci_recovery_flags & VFIO_PCI_RECOVERY_IN_PROGRESS) ||
+	    !vdev->device_open) {
+		mutex_unlock(&vdev->access_lock);
+		return PCI_ERS_RESULT_NONE;
+	}
+
+	/* The host reset completed even if restoring the device fails. */
+	WRITE_ONCE(vdev->pci_recovery_flags,
+		   vdev->pci_recovery_flags | VFIO_PCI_RECOVERY_RESET);
+
+	/*
+	 * Load the configuration saved at open before entering D0, which may
+	 * restore BARs from that state. IRQ teardown needs the BARs restored so
+	 * MSI-X shutdown can access its table after the host reset.
+	 */
+	down_write(&vdev->memory_lock);
+	ret = vfio_pci_recovery_restore_state(vdev);
+	up_write(&vdev->memory_lock);
+	if (ret)
+		goto out_failed;
+
+	/*
+	 * Close clears device_open under access_lock before tearing down IRQs,
+	 * so this callback cannot race with that teardown.
+	 */
+	mutex_lock(&vdev->igate);
+	if (vdev->irq_type < VFIO_PCI_NUM_IRQS)
+		ret = vfio_pci_set_irqs_ioctl(vdev,
+					      VFIO_IRQ_SET_DATA_NONE |
+					      VFIO_IRQ_SET_ACTION_TRIGGER,
+					      vdev->irq_type, 0, 0, NULL);
+	mutex_unlock(&vdev->igate);
+	if (ret)
+		goto out_failed;
+
+	mutex_unlock(&vdev->access_lock);
+
+	return PCI_ERS_RESULT_RECOVERED;
+
+out_failed:
+	WRITE_ONCE(vdev->pci_recovery_flags,
+		   (vdev->pci_recovery_flags | VFIO_PCI_RECOVERY_FAILED) &
+		   ~VFIO_PCI_RECOVERY_IN_PROGRESS);
+	vdev->pci_recovery_command_valid = false;
+	mutex_unlock(&vdev->access_lock);
+
+	/* Allow recovery of other devices under the bridge to continue. */
+	return PCI_ERS_RESULT_NONE;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_aer_slot_reset);
+
 static int vfio_pci_sriov_configure_live(struct vfio_pci_core_device *vdev,
 					 int nr_virtfn)
 {
-- 
2.43.0

