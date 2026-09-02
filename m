Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544EB486E4D;
	Wed,  2 Sep 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356522; cv=fail; b=LD6XEh5iqvCcFEIPEsnzSXhcqSb+g7qKZyADvyIi7eT9LC+EGsJ/II9ojp3OZo012yPFgOoQYRjiaMjqPvYZK5kxuUTcM1cJZeS1F0+e8JmHg7rnz2SCquz03cGeyE443w5bs0fy21z7kghpoysTLD4njIsVu9u4CqlQJpkw+7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356522; c=relaxed/simple;
	bh=rHxny8saZ08zm5SonRqI1tX7C8Ldx9QJ0nI14fZ2pIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KI8EKeRElV4KUNl4jHQmKBRP1R+uLETBDecsLUEoYz/oLXbcPHqJFTlCT7sK/0YuHDoOu9y7d5zztRGrWnHnRYdp1m8O2lrUUGb0gnSNzzbb/yKuERoBAHWlmUnWPfviNZSIUdSzZs2BHrKKX6tkFXJiJPDW4PYv3/rmqq+0pwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kGRCXO3Q; arc=fail smtp.client-ip=52.101.85.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kGRCXO3Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHrv+U44jHRhMSdkuj4bkpjFAV9oB8LVHv8uW7f8+wOBjS4C7FrWeEvcw6QmqLbWAlGvzcIiNa5Qt27hmxdypVRtZExqVCqUyqPxBdPnYkBlK3fBE2dwuG//5ithurnV4XtOYESkAEm2Ia1Avggj6iGZTaxReiQ00Uq33LpbdogQoRZy/U+1kOVzarmgUiY8rBugoRegJ/NF9DuWsVnNfLEHI2sAIrymWcuOOlFVvqHkn+IQLvFwNy+LO9YIqLKwZ99B9o3BUpNr/ZHCPvT04uSalw0DRkp442ZuV/QumSEGBjD1/1WJ3WZPptCFhgJR3CD3zeaVebkf5Ox8RpkPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpYcVkNykWRZyqaCecPD/IfiO6idOU8WfzFb1zL/cOc=;
 b=gKzSJqrZLAgQCSc8WfW9A7NlSjfWMmR+9XUDtjHjrqW2UseWkky27kqtDDtQxFW98xzye4R2R95O8cxcRFqH4jnTo0BxYPJstienwYfGi+YwKe2Unnpu0pGCgB+xqSy+ZVhF32EaxKcORNwBDkUZ4fqT1cejVKx1qKzYXoJuyE16EndMm9qj5gYi678hslMy2/7Q4dS1Eo/RJ52xZhWFZvCrW3pS1T15iGXlIfflz0LFFJU/5a9+0GT06h9JtSdiIrCbgwpMn64DPmWqUky+HsGgJxiFCIQ8U8QLW/vvUItCP1AR/6b3b9idnX+R8yuICqHw25w2AKGFDZhx5tGfdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpYcVkNykWRZyqaCecPD/IfiO6idOU8WfzFb1zL/cOc=;
 b=kGRCXO3QrxrC4fND7UIsCn5fJGEqyjgrWHdYD+6AqytGMLf85cyjQvDrHHT8L6gsgV2dBVU8sHvhgSggy4Ohgpt3YB7jO/u9jkxPk3MXXTmAcqvs01VFQyRp62CsZ6eK1SLzPZaws6aqDpRfSRW3s+UZWgA3opM2nPbPoJm33d0=
Received: from SJ0PR03CA0283.namprd03.prod.outlook.com (2603:10b6:a03:39e::18)
 by PH7PR12MB8055.namprd12.prod.outlook.com (2603:10b6:510:268::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:41:52 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::a3) by SJ0PR03CA0283.outlook.office365.com
 (2603:10b6:a03:39e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 13:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:41:50 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:41:15 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Rafael J .
 Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-cxl@vger.kernel.org>
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, "Hanjun
 Guo" <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Shuai Xue" <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Ira
 Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Richard Cheng <icheng@nvidia.com>, Robert Richter <rrichter@amd.com>, "Lukas
 Wunner" <lukas@wunner.de>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v20 8/9] PCI/CXL: Mask/Unmask CXL protocol errors
Date: Wed, 2 Sep 2026 08:39:32 -0500
Message-ID: <20260902133933.2992457-9-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902133933.2992457-1-terry.bowman@amd.com>
References: <20260902133933.2992457-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|PH7PR12MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c6b79f-37d4-4b74-909b-08df08f7f10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700016|23010399003|82310400026|3023799007|10067099003|11063799006|56012099006|921020|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	T6AfvcaM6EmobhZVXEenDKCS1KEJ89jcNdSPUqQww9S/UHk5GSV3EqCurdhr8b44Ffllorhwd6f/dt1a0c1ZsGNHLSvCG4YKgwHbM967Eh+knDyD7jAsLmRjTeiDYjb3NxFV+AmhtETCHivACYUvZ3EeOoEm42H3NWwYjE/m5Zu5yT39SXvtFAtb253EeavFJpfwErSll8jyT5hcgkw2pR6HqqPfx8dk1cj1m30vrkJC0BvscvkwCJ89cih5gxYGPquGibSzwzZF0KfthTzXuc3zBnUpFCTHVVwTsO+hRJfqJL+grFBG/aaH17/g0/YrM0HnEss8bd+n+yQSTwG1BH9uHarPKaxY00cfa71laTl5tNLDbX8pAcjruR+e5dWVAHr+spQH4E/X/+jwa0XN47H8KuW0EKmX2jAaQj8cHaUVLtrit0cV6DAdP6Sxhs8mApFQ2kXDFouWH6OFdOj1AU3Npp1VyY5OjEADnb/YuEUIJLQpwXISdUChNI9i0ZAA48wUukcsKZSTvVyUlhf66omsBC663aJc97Y10mYVRnXrzN1MBgghrebVbczZTBlsQm0cOW5rmlRSF5A3/JQWyP0y2awV4qXIVznyKJYnGGJp4x2bvc/Q5ROXkbKAuN3NYhNKGowHReo08/YPoxmhdie5SFo+W/5jUSTqz3zHMwNDa37Zk3SwzKORFwXMCg9xG8fsIic8/VBT8jOYO793x5CZlb3loSDMX35bpcLzRakHpSqpejv+UOqstCCCbtIs
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(23010399003)(82310400026)(3023799007)(10067099003)(11063799006)(56012099006)(921020)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xhGci1agWi3yAASoCKEHD7wvTraqrLDFzjFk4QpzCS1G1Qluw01zhGsC6SIlAZo+XpjUMFz2KRqNXV51M7NUYBZbRgH9ZObjdVu5KulPvlM04FFOYaTc6HbIAzYWrOMTGhzxgZF2fMaZvs1BW3cpx8rgyKaF2o4PVmsEvBoI1UsEtBz0QJw/PzjJ3XDGk+j78TDceb3H6N3LuHzZiSV819S5QrQRDP+ZRMQERe/mqWeD26wL29iYEviebZ9I0yzgfxO1xarsIDcYUlLUbWNW2u9UQmTYC6jAVnPZf2Lvug31MV/P8kK744FNWi95YICim6jT5ofDLHCQc5FwCPU0lIXQjIVxYMY7YUkyRDErn675WYXBwsKr6ZNBVGPiu7xbfZa0gHOJTAQmfl1PZ0NNWX1y3rs5XotZfUtE444xGfQhfqBt9Bvvg71p4c7UfycE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:41:50.2727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c6b79f-37d4-4b74-909b-08df08f7f10c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8055

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
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

---

Changes in v19 -> v20:
- None

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
index fac37b6fd882f..f1e05d240059b 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -124,16 +124,64 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
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
@@ -150,9 +198,6 @@ void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport)
 {
 	struct pci_host_bridge *host_bridge;
 
-	if (!dev_is_pci(dport->dport_dev))
-		return;
-
 	devm_cxl_dport_ras_setup(dport);
 
 	host_bridge = to_pci_host_bridge(dport->dport_dev);
@@ -167,6 +212,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
 void devm_cxl_port_ras_setup(struct cxl_port *port)
 {
 	struct cxl_register_map *map = &port->reg_map;
+	struct device *dev;
 
 	if (!map->component_map.ras.valid) {
 		dev_dbg(&port->dev, "RAS registers not found\n");
@@ -175,8 +221,21 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 
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
index 8c998cffa89e4..1b182b9cc9553 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1281,12 +1281,26 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
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

