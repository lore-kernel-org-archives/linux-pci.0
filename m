Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884F638E5F9;
	Tue,  5 May 2026 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002338; cv=fail; b=CHO739tX4gARl+fCNtLRM1Zh2KKhm2E6vY5ngP9otNO37fMwUDOZa2yD0kV0i1SdAFwH4QPXzXNVale/LxI+Oer4zjgljBcFs4MFGNSFi0kbzGaxQlC/Hv8To4HydscsG/+P07cVIBsnKaYAbeEpkTmsgBUbxOb99wPC8BSU0Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002338; c=relaxed/simple;
	bh=uJJqBQnkFc/+M/S/I/kpQTqJ5kcWo8+dICSVm68JA+U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SL0EN0lX/7bOzi50A+ozrO7Gm2NBpRQYkPQ+ixvl8YPxbybzriBwtO4PkZvh1Xz4Ywp2BwGEsvlMMxjJQRLrPctboITinvQnako3NlwwzwevM03z+5u0Z3vS1MeA11nxBQ084BO+zJvl2xmgcxinNDcVGxsWKMF9ZWxRpyoHjMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=20NprxnM; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="20NprxnM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e82m5w3BR4hsEt861QiYljOZVABca144VkOC8wwVFxC8lgkKXyuE0iV7KIGrUPFUDpotkeDeSkpfwRJ0RQ2U8xdBroDEXjR+4LmuWU3zclRRQ4zoCaWlaIbhy5Mbj6B8X+P6q1aPi1KPbjrt22mZFveBHLQwGOpYjsWbLaIhSRw3P2Bsxb62Hg8t7VkaPQD/FCNLhNqYkXFLzs9cL8NFWBiNP0IlWoT5ALzqywn8ZQJP5Qm3zrjI1IWlfnOWBGQegz585WWqj9qd9D4n57+4NgSaIFwy6VMQbDNugxQ2zmqgctV4hT1ED3FVRZTyPb8Od6KS/xiJt6UPRIQxDCVGgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/J9DdylZ7SjYLLITJjp/ySfvTV3/KeXze3aVV5QxH4=;
 b=FGR5Kf+zuFWSQiJ87guj32q8oX3yCNha+33CbmSLNmwLp30et8jNFJvB6tDgdL2j58beggF7qRsEBcbFWK+LFWUjpWqr4GUEyUFDT/EZeBxgh/13x9yDnEFzA2buNAxagQHlVui7yxcBAvKOuH8E4W1ml9yLuiWfF781hNQGNdK3d/1vCD6X7rldHTfjQW9lfec9DUzO4iInLHnCPoPD7wc8RmHb8YMp3KDRV6VH8vgwYsFelFUFIuC2KjQG3nG+1Sof0zQtPQ1jB/QUt4F1KiszOdYP2zirSYb36qd2gWEpMh6adNZZjKf97TL5H0Oc7XnpoHSHfXcWoAKc3S9voA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/J9DdylZ7SjYLLITJjp/ySfvTV3/KeXze3aVV5QxH4=;
 b=20NprxnMZBYYm/itZQzVzUl+JXjfhskmL2Pu1Kg1pNi1utPHkzNXurngVmppe73SHWrMSxRGr26I0BtoRPZ0Pvo1aPd6XOALkYN6Yg4rMjuBanL1uYhLkJt4IeDODfF8r0ckFnWDH8LNn9ypKSZEeKVdJqdj+C8/+cZHiIh01Yw=
Received: from DM6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:333::30)
 by LV8PR12MB9689.namprd12.prod.outlook.com (2603:10b6:408:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 5 May
 2026 17:32:11 +0000
Received: from DM2PEPF00003FC5.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::40) by DM6PR03CA0097.outlook.office365.com
 (2603:10b6:5:333::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 17:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC5.mail.protection.outlook.com (10.167.23.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:32:10 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:32:07 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <djbw@kernel.org>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <vishal.l.verma@intel.com>,
	<alucerop@amd.com>, <ira.weiny@intel.com>, <corbet@lwn.net>,
	<rafael@kernel.org>, <xueshuai@linux.alibaba.com>,
	<linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v17 07/11] PCI/CXL: Add RCH support to CXL handlers
Date: Tue, 5 May 2026 12:30:25 -0500
Message-ID: <20260505173029.2718246-8-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260505173029.2718246-1-terry.bowman@amd.com>
References: <20260505173029.2718246-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC5:EE_|LV8PR12MB9689:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d243d6-f822-4103-628b-08deaacc3cd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700016|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nkLLT25W6rHJnff16VAn9DnNBwiuCtXIY4fW+1w3PAJ5jxIrnQQnKX977gz9JR2E9Vv8I1dCNpxAvfgMjrGVOcC0ntSRHHXt+KGA5SnkA1Hff2zg34fOfKZzhs0EPC34m7xwfT7fTivkxPfGdN8OVJIcQspezbLWFCIF4qh/bmvW+E65/feqCr13sSB+7R+VVhIxnik98zO9fjygQ/BRMR27/S/gNcQklwJZN/Tj5eg6avTdgQ/6UqQMeKmQYatunTe4VIcFX+1s7rIMrjpTeRgp5y+py82fsPGmWnAzUU8VTwDOyofLpJpc3A6v6l7ovmm0qQTi8ZcXFvtdMQIAVhrLD45HQ2Cko/wL7RT4Bd5aP3b3Ui7zUD/aVU8/KAXTsc5ALzMrezqBXtQCWgo0MGzhRDWrzha8rwci6Ccu2PeKH3YKhkdpEfbyJRt19/6tSjDjAqAfdYaUDpxh4IRE5b6I5QQ6CSoKi0xnThhSuhSvhQSWmVdy/jEamBR/pLNUrD1cBaoSjT6155hw1IICwzFhQYW2FI3staVATuoJPfy5QeXTq69T+bf+/DkpJq5IjRcgGaZ5Gw5p3q7y5ULtGzkjszzIlGUVGZdcCmoGPIWYVx6PVWoGO4s7UD5ZPJTCYaKVFCBO7A7fH0VUBUL7q4x/vCi0I/3GH7wwgqlrBD3eHR3f9kGiDRkaZQ+VVhKEDkb8r2k30YcYTw2zK4LF3fLP155mK8kxhR5w/w5qisi9QVE8ZSIl7azg7tw6CYKbxAzmX2rTj+4lS84NnGGduw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700016)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YocQtIonfNXtZ+HJHFJH2WfLMkkTxvJR66BAH0/uJrDgR0RqJApeOLDKjIQpldeZYy6EQqzvhMnnITFChmj2j+dFZK+Kkr+uaEgLdzhBYfl5LxJRpFf2QMqwBaCSd/jwyxxDwKP17+qBDsEi6Ig+0ufIleomd160422m1WJjqwOaXYCDtAXPVGgdx8MkUmkQI80ei5c2krhwpLHA0Bd29VpP004EXY47b0Z2sPEPLLLbrWMqv+iUa3trgjFhuokkVD8xq7lbZvpNnCrEilf7NzYMgeSNcP2KWWnesr5H2ZtO7DHc0uJcmeWmsqZ670+8kd7lJG/kg/iCDJFWnll+xmpHvFcBXsig8a4vMCie11R3sLl22+8kz+6paUhwUyXQ6P6TtYxT7z8FycuUVysl3tUV4obXAiFaj9MxQSlhoxcBZJBMR4bADOUyWkyLjl4K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:32:10.3275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d243d6-f822-4103-628b-08deaacc3cd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9689

Restricted CXL Host (RCH) error handling is a separate path from the
new CXL Port error handling flow. Fold RCH error handling into the
Port flow so both share a common entry point.

Update cxl_rch_handle_error_iter() to forward RCH protocol errors
through the AER-CXL kfifo.

Update cxl_handle_proto_error() to dispatch RCH errors via
cxl_handle_rdport_errors(). cxl_handle_rdport_errors() handles both
correctable and uncorrectable RCH protocol errors.

Behavior change: an RCD uncorrectable CXL RAS error now panics via
cxl_do_recovery(). Before this patch the RCH path returned
PCI_ERS_RESULT_NEED_RESET via cxl_pci's err_handler. After this patch
the same condition panics. This matches the panic policy added in the
common CXL Port protocol error flow. CXL.cachemem traffic cannot be
safely recovered from an uncorrectable protocol error in software.

Change cxl_handle_rdport_errors() to take a PCI device instead of a
CXL device state, matching the new caller context. The error trace events
emitted from this path now report device=<PCI BDF> instead of device=<memN>,
matching the rest of the unified CXL trace events. Userspace consumers keyed
off the memdev name need to map the PCI BDF back to a memdev.

Include the RCD Endpoint serial number in RCH log messages so the RCH
can be associated with its RCD.

Remove the cxlds->rcd check from cxl_cor_error_detected() and
cxl_error_detected(). RCH errors are now forwarded by
cxl_rch_handle_error_iter() through the AER-CXL kfifo to
cxl_handle_proto_error(), so cxl_pci's err_handler no longer sees
them.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v16->v17:
- Drop now-dead cxlds->rcd branches from cxl_{cor_,}error_detected().
- Drop duplicate subject line from commit body.
- Document panic-on-uncorrectable behavior change for RCD path.
- Document trace event device-name change (memN -> PCI BDF) for RCH path.
- Rewrite cxl_handle_proto_error() RC_END comment to clarify RCD/RCH shared
  interrupt relationship
- Rewrite commit message

Changes in v16:
- New commit
---
 drivers/cxl/core/core.h        |  4 ++--
 drivers/cxl/core/ras.c         | 14 +++++++++-----
 drivers/cxl/core/ras_rch.c     |  8 +++-----
 drivers/pci/pcie/aer_cxl_rch.c | 17 +----------------
 4 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index bc36cd1575a4..2c7387506dfb 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -188,7 +188,7 @@ void cxl_handle_cor_ras(struct device *dev, u64 serial,
 			void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
+void cxl_handle_rdport_errors(struct pci_dev *pdev);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 #else
 static inline int cxl_ras_init(void)
@@ -205,7 +205,7 @@ static inline void cxl_handle_cor_ras(struct device *dev, u64 serial,
 				      void __iomem *ras_base) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
-static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
 static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 #endif /* CONFIG_CXL_RAS */
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 0a552d5a236e..1f1dd20623f6 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -267,9 +267,6 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
 			return;
 		}
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-
 		cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
 				   cxlmd->endpoint->regs.ras);
 	}
@@ -292,8 +289,6 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 			return PCI_ERS_RESULT_DISCONNECT;
 		}
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
 		/*
 		 * A frozen channel indicates an impending reset which is fatal to
 		 * CXL.mem operation, and will likely crash the system. On the off
@@ -329,6 +324,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
 static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
 {
+	/*
+	 * An RC_END device is an RCD (Restricted CXL Device). Its AER
+	 * interrupt is shared with the RCH Downstream Port, so handle RCH
+	 * Downstream Port protocol errors first before processing the RCD's
+	 * own errors. See CXL spec r3.1 s12.2.
+	 */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
+		cxl_handle_rdport_errors(pdev);
+
 	if (severity == AER_CORRECTABLE) {
 		cxl_handle_cor_ras(&pdev->dev, pci_get_dsn(pdev),
 				   to_ras_base(port, dport));
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index 61835fbafc0f..cbd02cabefbc 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2025 AMD Corporation. All rights reserved. */
 
-#include <linux/types.h>
 #include <linux/aer.h>
 #include "cxl.h"
 #include "core.h"
@@ -95,9 +94,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 	return false;
 }
 
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+void cxl_handle_rdport_errors(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
 	struct cxl_dport *dport;
 	int severity;
@@ -115,9 +113,9 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
+		cxl_handle_cor_ras(&pdev->dev, pci_get_dsn(pdev),
 				   dport->regs.ras);
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, pci_get_dsn(pdev),
+		cxl_handle_ras(&pdev->dev, pci_get_dsn(pdev),
 			       dport->regs.ras);
 }
diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index e471eefec9c4..83142eac0cab 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -37,26 +37,11 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
 	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
 
 	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
 		return 0;
 
-	guard(device)(&dev->dev);
-
-	err_handler = dev->driver ? dev->driver->err_handler : NULL;
-	if (!err_handler)
-		return 0;
-
-	if (info->severity == AER_CORRECTABLE) {
-		if (err_handler->cor_error_detected)
-			err_handler->cor_error_detected(dev);
-	} else if (err_handler->error_detected) {
-		if (info->severity == AER_NONFATAL)
-			err_handler->error_detected(dev, pci_channel_io_normal);
-		else if (info->severity == AER_FATAL)
-			err_handler->error_detected(dev, pci_channel_io_frozen);
-	}
+	cxl_forward_error(dev, info);
 	return 0;
 }
 
-- 
2.34.1

