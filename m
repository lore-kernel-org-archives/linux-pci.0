Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D1345EB2;
	Mon,  3 Aug 2026 22:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795649; cv=fail; b=CJ4K1JFJF8m3b0iDyT18n83BXiUNUqSfelrk0VRFL0Ow856HFPtiLX1YeQrfGheOjB1Ho3K31VzIwo9GUi3978jyjBqNUCUPpsYaoZWPk8MnfofTS/K/Vq7+yGSZmWqgfQUEynRjOpS2LKgJbbCDkN0jIyHJdsrgp50RjN7SdO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795649; c=relaxed/simple;
	bh=/dknC5hY6oBafMjVbzTrFUw1chkWz3+Hj9AvtKDNwKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CS8iXi3mDyZq8GmytZTFBHJXDlZqO0LrAT69LiuRpq3DBUqPY0HbSL9ghmcA5BHjuugzjj/CriDdVVoJkJ3tOL+Q73ON8Y+wgs6n6c12dDHcfnPH6HoXcgmKlKDbR+cT87S6LK2xaVmFti13ZiLJZWI+mXbQTkx8LKhz6R5KiPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mfvIj2Sw; arc=fail smtp.client-ip=40.93.198.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mfvIj2Sw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6aFI2a5iN61zJU6ZXq6j6CrJy98zGDxHahkA9L37gjuBw6gSQgOOrhyXCHO7zaEx+S0FLIlbPEmN3ucLw/CFLRSbtx5Ucu443AB72nrK5wkTkPl7jAthag+L+DKqeBol24PHvLFqxzTe3ib0QGT4WihVKCNbiePgAkiH+YWWRMDWEmtBIu2F5vRXMe/a0QJFRO0ERe6rWxYLNxM1Hbp0OUtNsIzjNBUBgn+26LVg84Wl9jS7e5E3z7VN3PEubwNMtYFI7OEQS1kDjihVHwwyw+b2DGT5/S8Gyfh/aXDjRFto9MpuTunVr59enxLX/HxWflrr8JNh6OyHhgve369Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tOhKt43DWJyaft+UADfdUdIQ9ggYBpXSeMU2L4map0=;
 b=wEApjZ2OUCnZ/I2f5H0CRbn2kpqbwwttOKeVdlqc7cCeZyIBEJ9zdbAeHtgsyP/T9q/UMZhLOtK5Imf01D0dtpQ5nRk/BOTb38KzMjSJyAvXnXKrm2bUpW4gpgxZJhh+tt1rRr4dBEztgiJW1GDUdGWImEpqASBdckfnrdUO1eS+n448ZYsmWR8mS/BanIyZpdQIv5WPga6JmpenhDoMWE79Mwkx9AALBzfvd5Wnlk+e567/hlJ/BdG3LfHnbZ51ZT33hYsLIctsU2rIE1M2r53ITxPmAy+Ree8Tyq4m3kVqnghc9Qdsd6QBJXB/SyqTDvrGohAamICKmYvNXKnB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tOhKt43DWJyaft+UADfdUdIQ9ggYBpXSeMU2L4map0=;
 b=mfvIj2SwRyKtUTm+UtSfxVv9nRJJDDa37J7kJyv+vqWfs+FKBsW+I/aCjYn3XOU6OWyoCf675BosUT1RoOvG0kpG2frhLn83wNWuSqPT2+QNqbzJQ1pJ4jivfLGPHIf6twi4FU4cgEnsGF7OV1AETbbjkr9ol/ZQTpZG0X+TPwg=
Received: from BLAPR03CA0154.namprd03.prod.outlook.com (2603:10b6:208:32f::28)
 by SJ5PPFCD5E2E1DE.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 22:20:43 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::c) by BLAPR03CA0154.outlook.office365.com
 (2603:10b6:208:32f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 22:20:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:20:42 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:20:41 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, <linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 13/14] PCI/CXL: Mask/Unmask CXL protocol errors
Date: Mon, 3 Aug 2026 17:18:09 -0500
Message-ID: <20260803221810.3685703-14-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803221810.3685703-1-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SJ5PPFCD5E2E1DE:EE_
X-MS-Office365-Filtering-Correlation-Id: 3570d009-f72f-4177-1a9f-08def1ad74c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|3023799007|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	I9S3oB7anQ0jg1DRa3xaoNNT/PiWXp1bD8PLqaPNYeQTIPeuh2mrAmEUjAsBZzuFLufzhxxVI3EkAN8Yi18ZFJhopiFct4W7hkhj3AAjGG/GEFmBgZtX3P5SFzynGpfAmYnm0e7te//q2y4r/bA/cMOxjug9Nc3M2KC2OjQ4DxePTDGVwWTAuWbC/yImE7vPCdKgl/7VBy79qtlA66ek348T0AGempvCIqUdXWwonjocvCO5vDMoQx88CTORX+txihED0TEFzMxUm6jvG0PKSWwukiXFm/cOiSUmNfnrt3Isvlh73N6eP6kjF1L2pz4AbsV7jX+l8xSo0AaSy7sFn1wGsnubP5uezqHioOyKDeFDTLVKX7eylR6sREW6crwZMm43LGg1i+bWRK5cCWR1aTbH0GKqshFAIG1X89OaHosz8AWvPo5O2NYPLT2aYFkrnAbMLe61is5ub5bsHC5gyzrjuhCHRYMBlcsT+Fx83V87lHBDA9f1NrsZ/BJd2+QXgIZHtLaaHE4mDq30W9j0KkNaooW05AvkbKMW1ZVoRkCaVqlgj0IpmBc87Q+VZCcpQ+CJYJwkkVuWJiYLse7UVEBvknbeRuP4v7LYpoH4rk/Nd/LLf5/Xy2Ij2kXQRWi4EHP6aaNIgUcoWDdgtkFrmlI7BadA2VBCPMql0IZHQgXUWDrlPf9aCpozz+6CfFWEEj07YY0yzn5QJgcgNolDPQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3qHO1paPigQ/EfsOrs5OsHGWy+MM2Cm0+CHdkKd8713DJP+kmRdhIPwclD2l2W1U1N57P2bIW/Y3vjjduFAiNY36PT6LvZeC14Fe8BZJqSfZwFbExYmpjGs5rSAW52I5WIyA0kniyv4q7Brd8cshl15TNSi27Z11LE6H/NyyTWCCJUB157gmdEdobvniqeTao+xHUeE28GaCTwAf5A7w5V4vy7MlejbWnzHcbtq2AO5IsZe30+BCCNEuJ8DHBFw5fP2ng02Syv7X8IraR1oa3l/ORVNM2VSl5Cm01YswUZD3hbn9JPwpTzBcM8/2PJvRukftAmzo4T6IVZrA4VB20bUobtFTtOSfut27zvTE4NlyUfA3msPiX+xEISz/8OC2BohAw4tuEvuc9VPKBOtKVyMDWdAHUp7q3q+0sYZLtsOmzfCtnaNUPxi8elsxUHrb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:20:42.3189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3570d009-f72f-4177-1a9f-08def1ad74c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCD5E2E1DE

CXL protocol errors must be unmasked to be reported. Add
pci_aer_mask_internal_errors() as the symmetric counterpart to
pci_aer_unmask_internal_errors() and export both for cxl_core.

Unmask CXL internal errors in cxl_dport_map_ras() and
devm_cxl_port_ras_setup() after the RAS register block is
successfully mapped. Register a devm action to restore the mask
on teardown. The unmask/mask helpers gate on dev_is_pci() and
pcie_aer_is_native() internally so callers need no special-casing.

Remove the dev_is_pci(dport->dport_dev) guard in
devm_cxl_dport_rch_ras_setup(). On RCH systems dport->dport_dev
is the pci_host_bridge device which is not on pci_bus_type, so
this guard blocked real hardware. The caller already gates on
dport->rch.

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---

Changes in v18 -> v19:
- Reworded commit message to be more concise.
- Use pci_clear_and_set_config_dword() in pci_aer_mask_internal_errors()
- Add review-by for DaveJ and Jonathan

Changes in v17->v18:
- Make cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts() static
- Remove dev_is_pci() guard from devm_cxl_dport_rch_ras_setup(); the guard
  blocked real RCH hardware because pci_host_bridge is not on pci_bus_type

Changes in v16->v17:
- Drop redundant cxl_mask_proto_interrupts() calls from unregister_port()
  and cxl_dport_remove(); the devres action registered alongside the unmask
  is the sole mask path.
- Update title
- Remove unnecessary check for aer_capabilities
- Gate cxl_unmask_proto_interrupts() on pcie_aer_is_native()
- Add pci_aer_mask_internal_errors() and cxl_mask_proto_interrupts()
- Only unmask on successful cxl_map_component_regs()
- NULL-check @dev in cxl_{un,}mask_proto_interrupts()
- Drop static and declare in core/core.h

Change in v15 -> v16:
- None

Change in v14 -> v15:
- None

Changes in v13->v14:
- Update commit title's prefix (Bjorn)

Changes in v12->v13:
- Add dev and dev_is_pci() NULL checks in cxl_unmask_proto_interrupts() (Terry)
- Add Dave Jiang's and Ben's review-by

Changes in v11->v12:
- None
---
 drivers/cxl/core/ras.c        | 73 +++++++++++++++++++++++++++++++----
 drivers/pci/pcie/aer.c        | 22 +++++++++--
 include/linux/aer.h           |  2 +
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/mock.c | 12 ++++++
 5 files changed, 99 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 0254b7ec64c30..40a8a03070652 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -114,16 +114,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+static void cxl_unmask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+	if (!pcie_aer_is_native(pdev))
+		return;
+
+	pci_aer_unmask_internal_errors(pdev);
+}
+
+static void cxl_mask_proto_interrupts(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return;
+
+	pdev = to_pci_dev(dev);
+	if (!pcie_aer_is_native(pdev))
+		return;
+
+	pci_aer_mask_internal_errors(pdev);
+}
+
+static void cxl_mask_proto_irqs(void *dev)
+{
+	cxl_mask_proto_interrupts(dev);
+}
+
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
 	struct device *dev = dport->dport_dev;
 
-	if (!map->component_map.ras.valid)
+	if (!map->component_map.ras.valid) {
 		dev_dbg(dev, "RAS registers not found\n");
-	else if (cxl_map_component_regs(map, &dport->regs.component,
-					BIT(CXL_CM_CAP_CAP_ID_RAS)))
+		return;
+	}
+
+	if (cxl_map_component_regs(map, &dport->regs.component,
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(dev, "Failed to map RAS capability.\n");
+		return;
+	}
+
+	if (!dev_is_pci(dev))
+		return;
+
+	cxl_unmask_proto_interrupts(dev);
+	if (devm_add_action_or_reset(dport_to_host(dport),
+				     cxl_mask_proto_irqs, dev)) {
+		dev_warn(dev, "failed to defer CXL proto-irq mask; CXL protocol error reporting disabled\n");
+		dport->regs.component.ras = NULL;
+	}
 }
 
 /**
@@ -140,9 +188,6 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
 {
 	struct pci_host_bridge *host_bridge;
 
-	if (!dev_is_pci(dport->dport_dev))
-		return;
-
 	devm_cxl_dport_ras_setup(dport);
 
 	host_bridge = to_pci_host_bridge(dport->dport_dev);
@@ -157,6 +202,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
 void devm_cxl_port_ras_setup(struct cxl_port *port)
 {
 	struct cxl_register_map *map = &port->reg_map;
+	struct device *dev;
 
 	if (!map->component_map.ras.valid) {
 		dev_dbg(&port->dev, "RAS registers not found\n");
@@ -165,8 +211,21 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 
 	map->host = &port->dev;
 	if (cxl_map_component_regs(map, &port->regs,
-				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
+				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
 		dev_dbg(&port->dev, "Failed to map RAS capability\n");
+		return;
+	}
+
+	dev = is_cxl_endpoint(port) ? port->uport_dev->parent : port->uport_dev;
+	if (!dev_is_pci(dev))
+		return;
+
+	cxl_unmask_proto_interrupts(dev);
+	if (devm_add_action_or_reset(&port->dev, cxl_mask_proto_irqs, dev)) {
+		dev_warn(&port->dev,
+			 "failed to defer CXL proto-irq mask; CXL protocol error reporting disabled\n");
+		port->regs.ras = NULL;
+	}
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0155f3923c1fd..d461f281e5372 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1143,12 +1143,26 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
 	mask &= ~PCI_ERR_COR_INTERNAL;
 	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
 }
+EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
 
-/*
- * Internal errors are too device-specific to enable generally, however for CXL
- * their behavior is standardized for conveying CXL protocol errors.
+/**
+ * pci_aer_mask_internal_errors - mask internal errors
+ * @dev: pointer to the pci_dev data structure
+ *
+ * Mask internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
  */
-EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
+void pci_aer_mask_internal_errors(struct pci_dev *dev)
+{
+	pci_clear_and_set_config_dword(dev, dev->aer_cap + PCI_ERR_UNCOR_MASK,
+				       0, PCI_ERR_UNC_INTN);
+	pci_clear_and_set_config_dword(dev, dev->aer_cap + PCI_ERR_COR_MASK,
+				       0, PCI_ERR_COR_INTERNAL);
+}
+EXPORT_SYMBOL_FOR_MODULES(pci_aer_mask_internal_errors, "cxl_core");
 
 /**
  * pci_aer_handle_error - handle logging error into an event log
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 8eba3192e2d15..b3657b80564b9 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -58,6 +58,7 @@ struct aer_capability_regs {
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+void pci_aer_mask_internal_errors(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
@@ -65,6 +66,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
+static inline void pci_aer_mask_internal_errors(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_CXL_RAS
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 2be1df80fcc93..957945201f04d 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -6,6 +6,7 @@ ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=cxl_await_media_ready
 ldflags-y += --wrap=devm_cxl_add_rch_dport
+ldflags-y += --wrap=devm_cxl_dport_rch_ras_setup
 ldflags-y += --wrap=cxl_endpoint_parse_cdat
 ldflags-y += --wrap=devm_cxl_endpoint_decoders_setup
 ldflags-y += --wrap=hmat_get_extended_linear_cache_size
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 6454b868b122c..5ad3243da8d29 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -220,6 +220,18 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
 
+void __wrap_devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
+{
+	int index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (!ops || !ops->is_mock_port(dport->dport_dev))
+		devm_cxl_dport_rch_ras_setup(dport);
+
+	put_cxl_mock_ops(index);
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_dport_rch_ras_setup, "CXL");
+
 void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
 	int index;
-- 
2.34.1

