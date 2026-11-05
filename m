Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793892585;
	b=ipywr4LaOipUGMeQTxnCWafg2YB8BE5WLpfDpvJv6PcKFO+/gh2+4TZPdbE9cATvOn17
	 HcCzX99aKRAZznuTFeDwFuQJn3WM2Y2fZTTjO9uqRmBEnyfIrPhDOYAX+BEZYBdkKGMCP
	 +MWTitHi7AittjE8TNgxwkkK5gGKpn2K8h7na34/9As8KpirVlev36qCNUCRiyKTeRe2h
	 l8If7wqpBaGiMJ/dg8YPV4BvcMgKauQ70mSBv4cUes2nnrjZIMAiwfX3KJ6POfzfct25P
	 eA3QaFD8pEwVYzqWYoVvRAlm8a8bSoG8C3ZaoubUJlc3iv188Rdv/j9m7a1Hn0KTI2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892585;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
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
	bh=qDGsxnsID9JABLE6+VvkbPhVMdX+4zcbNLKGiAy6DMU=;
	b=eey3nC/vOSOVuYxvMfPCR4xpATn9j4taVWqmFj2tY5+UwE3q701Hx6tQlptmw5e4a/GE
	 k5Evw6/JNyRpCn9A4y4QpIDwEHZcLWxe+0XhGQ2W3uPQE+u1g1fcT96IPshz1ZD0X4LcC
	 FWOiebuZqoU8E5Lnqrepz0cIUbspg4Q12LbVV2sQ2RnHyzSjYcLARjCnGouGuGfmZsnTw
	 Bbqcq5CSSRcyyhHb+GR/qk1wvStlt57k+KdaE8/YY3wAaZcjyWf6y9IXu9iaFJDPrHn3F
	 Udi/848xhcJzeBqXfbDhXgO7qnJdjDTluYiB0pw8Us5ttuQuKhsfsXi0oQj/10rUYQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RZiCvPWa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.50
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4F606EEAB;
	Thu,  5 Nov 2026 15:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5C4F606EEAB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RZiCvPWa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlIzZZ+L63ce18tJUjLtriLWLYxE5OXKfPQ7aFOCJypxwph8UxLPiNOE1jLO4rLGS23w6L9TqeXQx1fcpo/F73bydVKQx056pXFMM7/CifZqGl9YNwmAB0B+9qR5YKP+xy5Bz7LWVfRJ+AU2XOG+kwWnhYzTcjSQZRgqQTQpwUK2e+gtsMfCTu7Y9tNp91r79oimgxZ2IOkOQ7xJlSxfL4LmUr6tb4m05k68NPQPqHomy75B+P19XjFqmDHXbqxnXnmc3hr9ONupDlM0JBJFYWj9vA7wNFPrIR6rgzKdpT02Gjlse1H7S0vgShFvm8p/PjRN2bBs0tuhIlfrEkk6uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDGsxnsID9JABLE6+VvkbPhVMdX+4zcbNLKGiAy6DMU=;
 b=SfXXN2QmjzikDnxzU9OQvYI0QOwRyHtdJUOwN9CJ+GhJJpxwERB2jYnYF/gUG39SoICuxa/OJ1eHwQHNC7nE3FnygzV+yfnJcRDv8K54o9AQcpDMR/XbFWRnQ/UC90MJdXeIGcNiCyQDqIRujxR2Veq6X/MKuOvkEUMK76Yf/BMlLPYGSK6SxpE95o66XA3tHAmlBoZOAKxqtGnTW5cnV/jj4gZmUbVzkH9BpVMZqrlV4j68tO38tpNUZjIlpHoFoItoA8qD4gtYwjpeW5b04HzSOKDRa6Ji8fUR108OgH1E4u4StbEXmiNZptWV/IMDJse/xw2MeLKUHbA+FCn+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDGsxnsID9JABLE6+VvkbPhVMdX+4zcbNLKGiAy6DMU=;
 b=RZiCvPWaJyJbiZQHQ6ibHNNawDqSmi/lTfqMoC3wZ52irBpKTJksT03IMu78eTHN99vE1uo5oQlAZ2P9bk3aTzFrLt++Mnqpi94Z0dBLkQv7qO2C8uEClX0Kd2itUO/LejbQifVQYHjYfvT5mGj7tbRf/v7v1gOj5CuH5EEzhYhgqTi6RmcOqFBXbAWeqETr+aY7iAa4G3Pis+zL8odZBv90QDCOMxPqMeSaphzntM3ObBghUvRVnG3Co/iMteKZF5CWMSTWR00ILBS8/i0kjrl1w4N/NOUjFB1GvgYc0t1PKXdN1xiUy859ivTM6oMMxLk/Q4MJNfIBQw5TLISiLw==
Received: from BLAPR03CA0030.namprd03.prod.outlook.com (2603:10b6:208:32b::35)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 15:29:33 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::10) by BLAPR03CA0030.outlook.office365.com
 (2603:10b6:208:32b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Thu, 5
 Nov 2026 15:29:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 15:29:33 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 07:29:11 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 07:29:11 -0800
Received: from localhost (10.127.8.12) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 5 Nov 2026 07:29:11 -0800
From: Ankit Agrawal <ankita@nvidia.com>
To: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>, <jgg@nvidia.com>,
	<aneesh.kumar@kernel.org>, <aik@amd.com>, <yilun.xu@linux.intel.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <icheng@nvidia.com>,
	<bhelgaas@google.com>, <smadhavan@nvidia.com>, <ankita@nvidia.com>,
	<ilpo.jarvinen@linux.intel.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<andriy.shevchenko@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<terry.bowman@amd.com>, <nik.borisov@suse.com>, <brads@mainlining.org>,
	<lukas@wunner.de>, <rrichter@amd.com>, <gourry@gourry.net>
Subject: [RFC PATCH v2 3/5] PCI/TSM: Derive the coherent-range IPA from CXL
Date: Thu, 5 Nov 2026 15:29:07 +0000
Message-ID: <20261105152909.53452-4-ankita@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105152909.53452-1-ankita@nvidia.com>
References: <20261105152909.53452-1-ankita@nvidia.com>
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
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: f2dc598b-648f-4adc-8c07-08df3b5197dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|7416014|376014|56012099006|11063799006|261009223027099003|261102123227099003|261021123027099003|261022105027099003|261028144727099003|261102130727099003|261021121427099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kIPzmFrnY/biY+tNHZzCHi/GsWAYgjXNLQwONhSUGbxSQ0PUJoLWqwItcpQDwLjflf66ij4uZetMeHN5/e1/ONKxRbSPPiyRHlDU6ZZAcQ8+FiXmi2lXPxfL5MSwxOgzQeN7p5xNC6DpSONoGYpuRWIK12ujhKC3kV7fw5yVpUZh6WLAchX7yJ15BpVNWVsjr0wkJ10lBMBglAsY5Px3i+bWg9OrtZUWWPvCZm3J8W3iaplowONKhZE9DaLVaWLEeEPuTLzTbCRwVOpa+UNZ42vn17d2E0Dcmq8AFkjbfFD38umua/HdcubjLmfwUv0DK326Cn/1SLlliTa5McepgzfdyIWbfE1fLQXWoUz5r/jqCvPhGRnhWV7GPDBYroqxmbaK4ObwdAL/eulkIt4LytG9XCEG8mYvfjoWVbPnenF66K1DIMcKFRZxdWEaZwJgcPgaqjMbOhkM9J/6U0v93AN24EtYk2vKdi1HwSobVjqrm2kAnBBL9RIC5I4YW6KNKUGu4UIPTFMAW9Suq7DlFqTXJpzbom0frn6jlNTLYMJVz0he9i0fKGTrl0yCRRXbN/N1IS1lAHXlwDL+DPiNxsnm3mG4IDYKRLYvRiykCT43NxJyptxZkdnbZxlrh0ql/eZKhPCc35vDD1oRuZiVKMuWU+YQPReegmxi40v4TVKtmn9kbHgL9EinNe/zLH4SAVoi1IFq19NZWW4bUyhTFQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(7416014)(376014)(56012099006)(11063799006)(261009223027099003)(261102123227099003)(261021123027099003)(261022105027099003)(261028144727099003)(261102130727099003)(261021121427099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZdZ4z22lx/y3Rd3o9Gvl7wXr9/29icgg793BvCnoJcRgqK4K0yqo+yVGqNxAYp+eyX2WGMuJDG0SgiwRt35ahNrrWCzMvcW2QD9L5OZTqb2zTGfXMr1zUPcSPVae1lmI7fk8fVfBLTr0WbvO1uLEw0WMWNc+mOlZfrCw5rhJNbz86pr8Gw5jnt5AbQDeHfrEtTKSxGq0JKMbJwGwiNxMbEu6pgHsNI2RaMS4UkQ5LYtfbDld5jDJw7jf3Dnx/tuJ+pHcSpJD7PRr8j+2A4luraMXn7yfUP/Yd+5WktduQzhr+e+NHKLkHkzw801g2CMClaaZifxk5QnWz/kPO7w+x6FPLS1ep6x5xN5yxR7hMtyayc4h3uy/XvRq8ljxzgJ1yix3H+NaRZzzT/WIKDidn2M8UiMPQ+1YBhHl1OLUDCLuBWl22DgFEK2sqvcYVhO0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 15:29:33.4147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2dc598b-648f-4adc-8c07-08df3b5197dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

The DevIf report range with range ID 0xffff describes the device's
coherent (CXL) memory window and unlike every other reported range
carries no BAR number. Recognize
PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT and recover that window's
address from the CXL side of the device instead of treating it as a
BAR-relative offset.

pci_tsm_retrieve_coherent_range() resolves the window from
pdev->coh_resource[], snapshotted once with the committed CXL HDM
decoders range. The range to IPA conversion is applied onto
range_base/range_len using pdev->coh_resource[]. The ascending BAR order
checks stay on the BAR path only. The coherent range is required to be
the last report entry and is not part of the BAR sequence.

An HDM decoded window lives in the CXL Fixed Memory Window and is not
part of a BAR. So by construction, no pci_dev resource contains it. So
the function pci_tsm_coh_resource_contains() validates the range against
pdev->coh_resource[] instead; the same known-good snapshot
pci_tsm_retrieve_coherent_range() already trusts.

Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
---
 drivers/pci/Kconfig     |  12 ++++
 drivers/pci/tsm.c       | 119 ++++++++++++++++++++++++++++------------
 include/linux/pci-tsm.h |  75 +++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 16fbd4212e0f..22c416c84a6f 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -139,6 +139,18 @@ config PCI_TSM
 
 	  Enable a platform TSM driver to use this capability.
 
+config PCI_TSM_CXL_COHERENT
+	bool "PCI TSM: CXL coherent range support"
+	depends on PCI_TSM && CXL_RESET
+	default y
+	help
+	  Enables helper functions to manage coherent regions on CXL devices
+	  for TSM. The device CXL coherent (CXL.mem) ranges could be tracked
+	  and fetched across subsystems to be reported in a TDISP Device
+	  Interface Report.
+
+	  If unsure, say Y.
+
 config PCI_DOE
 	bool "Enable PCI Data Object Exchange (DOE) support"
 	help
diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
index d074bfd18d40..bc3218c58ff0 100644
--- a/drivers/pci/tsm.c
+++ b/drivers/pci/tsm.c
@@ -939,8 +939,9 @@ int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
 		return -EBUSY;
 
 	for (i = 0; i < mmio->nr; i++) {
-		struct resource *res = pci_tsm_mmio_resource(mmio, i);
-		int j;
+		struct pci_tsm_mmio_entry *entry = pci_tsm_mmio_entry(mmio, i);
+		struct resource *res = &entry->res;
+		bool coherent = entry->flags & PCI_TSM_MMIO_F_COHERENT;
 
 		if (resource_size(res) == 0 || !(res->flags & IORESOURCE_MEM))
 			break;
@@ -950,13 +951,28 @@ int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
 					     pci_name(pdev), IORESOURCE_MEM,
 					     IORES_DESC_ENCRYPTED);
 
-		for (j = 0; j < PCI_NUM_RESOURCES; j++)
-			if (resource_contains(pci_resource_n(pdev, j), res))
+		/*
+		 * The coherent (CXL.mem) range isn't BAR-backed, so check it
+		 * against pdev->coh_resource[] instead of pci_resource_n().
+		 */
+		if (coherent) {
+			if (!pci_tsm_coh_resource_contains(pdev, res))
 				break;
-
-		/* Request is outside of device MMIO */
-		if (j >= PCI_NUM_RESOURCES)
-			break;
+		} else {
+			struct resource *r;
+			bool contained = false;
+
+			pci_dev_for_each_resource(pdev, r) {
+				if (resource_contains(r, res)) {
+					contained = true;
+					break;
+				}
+			}
+
+			/* Request is outside of device MMIO */
+			if (!contained)
+				break;
+		}
 
 		if (insert_resource(&encrypted_iomem_resource, res) != 0)
 			break;
@@ -988,6 +1004,7 @@ EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
 #define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
+#define PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT 0xffff
 
 /* An interface report 'pfn' is 4K in size */
 struct pci_tsm_devif_mmio {
@@ -1043,6 +1060,7 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 		return NULL;
 
 	for (i = 0; i < mmio_range_count; i++) {
+		struct range window;
 		u64 range_off;
 		struct range range;
 		const struct pci_tsm_devif_mmio *mmio_data = &devif_report->mmio[i];
@@ -1053,33 +1071,58 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 		u32 attr = __le32_to_cpu(mmio_data->attributes);
 		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
 				    attr);
+		bool coherent =
+			bar == PCI_TSM_DEVIF_REPORT_MMIO_RANGE_ID_COHERENT;
 
-		if (bar >= PCI_STD_NUM_BARS ||
-		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
-		    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
-			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
-			return NULL;
-		}
-
-		if (last_bar > bar) {
-			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
-			return NULL;
-		}
-
-		if (last_bar < bar) {
-			resource_size_t mask = pci_resource_len(pdev, bar) - 1;
-
-			/* Transition to a new bar */
-			last_bar = bar;
+		if (coherent) {
+			if (i != mmio_range_count - 1) {
+				pci_dbg(pdev, "Coherent reporting range is not last\n");
+				return NULL;
+			}
 
 			/*
-			 * Determine the obfuscated base of the BAR. BAR
-			 * offsets are never obfuscated.
+			 * No BAR names the coherent range, so fail closed if
+			 * neither a CXL region nor a committed HDM decoder
+			 * resolves its address.
 			 */
-			reporting_bar_base = tsm_offset & ~mask;
-		} else if (tsm_offset < last_reporting_end) {
-			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
-			return NULL;
+			if (pci_tsm_retrieve_coherent_range(pdev, &window)) {
+				pci_dbg(pdev, "No CXL region or committed HDM decoder for coherent reporting range\n");
+				return NULL;
+			}
+
+			reporting_bar_base = tsm_offset &
+					     ~((u64)range_len(&window) - 1);
+		} else {
+			if (bar >= PCI_STD_NUM_BARS ||
+			    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM) ||
+			    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
+				pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
+				return NULL;
+			}
+
+			if (last_bar > bar) {
+				pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
+				return NULL;
+			}
+
+			if (last_bar < bar) {
+				resource_size_t mask = pci_resource_len(pdev, bar) - 1;
+
+				/* Transition to a new bar */
+				last_bar = bar;
+
+				/*
+				 * Determine the obfuscated base of the BAR. BAR
+				 * offsets are never obfuscated.
+				 */
+				reporting_bar_base = tsm_offset & ~mask;
+			} else if (tsm_offset < last_reporting_end) {
+				pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
+				return NULL;
+			}
+
+			window.start = pci_resource_start(pdev, bar);
+			window.end = pci_resource_end(pdev, bar);
 		}
 
 		/* Per spec the tsm_offset never results in overflow / underflow */
@@ -1090,19 +1133,21 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 		}
 
 		range_off = tsm_offset - reporting_bar_base;
-		if (pci_resource_len(pdev, bar) < range_off + size) {
-			pci_dbg(pdev, "Reporting range larger than BAR size\n");
+
+		if (range_len(&window) < range_off + size) {
+			pci_dbg(pdev, "Reporting range larger than %s size\n",
+				coherent ? "coherent range" : "BAR");
 			return NULL;
 		}
 
-		range.start = pci_resource_start(pdev, bar) + range_off;
+		range.start = window.start + range_off;
 		range.end = range.start + size - 1;
 
 		/* Only record the TEE ranges for later consideration by ioremap() */
 		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
 			      attr)) {
-			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
-				bar, &range);
+			pci_dbg(pdev, "Skipping non-TEE range, %s %pra\n",
+				coherent ? "coherent range" : "BAR", &range);
 			continue;
 		}
 
@@ -1110,6 +1155,8 @@ struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev,
 		entry->res.end = range.end;
 		entry->res.flags = IORESOURCE_MEM;
 		entry->tsm_offset = tsm_offset;
+		if (coherent)
+			entry->flags |= PCI_TSM_MMIO_F_COHERENT;
 		mmio->nr++;
 	}
 
diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index e54ad057fa8e..7c29f10e7795 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -1,8 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __PCI_TSM_H
 #define __PCI_TSM_H
+#include <linux/bits.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/range.h>
 #include <linux/sockptr.h>
 
 struct pci_tsm;
@@ -199,15 +201,20 @@ enum pci_tsm_req_scope {
 	PCI_TSM_REQ_DEBUG_WRITE = 3,
 };
 
+/* The range is the device's CXL coherent (CXL.mem) window, not BAR-backed */
+#define PCI_TSM_MMIO_F_COHERENT BIT(0)
+
 /**
  * struct pci_tsm_mmio_entry - an encrypted MMIO range
  * @res: MMIO address range (typically Guest Physical Address, GPA)
  * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
  *		Translates report addresses to GPA.
+ * @flags: PCI_TSM_MMIO_F_* attributes for the range
  */
 struct pci_tsm_mmio_entry {
 	struct resource res;
 	u64 tsm_offset;
+	u32 flags;
 };
 
 struct pci_tsm_mmio {
@@ -227,6 +234,74 @@ static inline struct resource *pci_tsm_mmio_resource(struct pci_tsm_mmio *mmio,
 	return &mmio->mmio[idx].res;
 }
 
+#ifdef CONFIG_PCI_TSM_CXL_COHERENT
+/*
+ * pci_tsm_coh_resource_contains() - check a coherent range against the
+ * PCI-core coh_resource[] snapshot
+ * @pdev: device owner of @res
+ * @res: candidate coherent MMIO range to validate
+ *
+ * The coherent (CXL.mem) range isn't BAR-backed. So pci_resource_n()
+ * containment doesn't apply. Check against pdev->coh_resource[] instead.
+ *
+ * Return: true if @res falls within a populated coh_resource[] entry.
+ */
+static inline bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
+						 const struct resource *res)
+{
+	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
+		struct resource *coh_res = &pdev->coh_resource[i];
+
+		if (resource_type(coh_res) == IORESOURCE_MEM &&
+		    resource_contains(coh_res, res))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * pci_tsm_retrieve_coherent_range() - resolve the device's coherent CXL window
+ * @pdev: device owner of the reported ranges
+ * @out: host physical (guest IPA) range of the coherent window
+ *
+ * The coherent range carries no BAR number, so its address comes from
+ * pdev->coh_resource[], a pre-driver-bind snapshot of committed CXL HDM
+ * decoders.
+ *
+ * Return: 0 with *@out set from the first populated entry, or -ENODEV if no
+ * entry is populated.
+ */
+static inline int pci_tsm_retrieve_coherent_range(struct pci_dev *pdev,
+						  struct range *out)
+{
+	for (int i = 0; i < PCI_CXL_MAX_COHERENT_RANGES; i++) {
+		struct resource *res = &pdev->coh_resource[i];
+
+		if (resource_type(res) != IORESOURCE_MEM)
+			continue;
+
+		out->start = res->start;
+		out->end = res->end;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+#else
+static inline bool pci_tsm_coh_resource_contains(struct pci_dev *pdev,
+						 const struct resource *res)
+{
+	return false;
+}
+
+static inline int pci_tsm_retrieve_coherent_range(struct pci_dev *pdev,
+						  struct range *out)
+{
+	return -ENODEV;
+}
+#endif /* CONFIG_PCI_TSM_CXL_COHERENT */
+
 #ifdef CONFIG_PCI_TSM
 int pci_tsm_register(struct tsm_dev *tsm_dev);
 void pci_tsm_unregister(struct tsm_dev *tsm_dev);
-- 
2.53.0

