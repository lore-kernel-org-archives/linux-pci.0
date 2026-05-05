Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012051.outbound.protection.outlook.com [40.107.209.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6454A2E32;
	Tue,  5 May 2026 17:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002379; cv=fail; b=tD444dy+hrCOZHxWF+EF7xPRYF1k/L+HvUTgVrorH5Ic60W3vNj3dKpu2LhGPza7toyJDMCpstvacbCAUcHGdhsaEkyS4iyOzgbsUJygzax85DBZPNkyRE7OUMGcLELS4D5gI+aExw9WdJJ+Ap+yC+3nUcYXA+uuzhQZvHTm6/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002379; c=relaxed/simple;
	bh=AYUcDU6evgUzGdu2Q7XeyLY/ZKPAUgf8zWJBNKlzF8Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mf2OBe+cstUjGhSQqDCpwnuuTEBoAZTpKCeptK28OR/vVXUZPWb76ojy8ue2bz/1KBJ/KYxR1swqq52J9JFNh4vJqaGukhj/ySbOKZgVjZVWNEVWDhmzYtoqiOyDT1pEa3/v+m5/63nHX6UmQy3/ut9z7lC2fhZl559pnjNE1Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OB288ZfI; arc=fail smtp.client-ip=40.107.209.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OB288ZfI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5zxmCN0NaniPlEAIMaVxE7t/0h1J4biPcsFNkXR49cz1hHcbza1tPG108PjoNC2mOgS3hFdSwXp9c6S6ApMclZ6LKzfsXHozC+xBWhs7WVxGci9fotIWbNcITo+wXYrws5+TXcKhE6w6k+IAc4tbegkR5SQg8J2Is8Gkbqtldc53AjvNfOBdZYpwCbs6Gps+xKKl9DOcl0dYcCT37Ce0mF71ryjxy+jLE9803Uo6rM3OFBCr1d5tmogkCZg0rUKZhKwQtjzDVINQweX9Im63g+ge8P5lPAXrsKLkOA5y/y/Ucrpc8xf4QtKNw8aXqRrQjz9366za3rXY3BdmCB28A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ei6oSCwyFnpIQ/m7nfi54sVw9V4iBOeHqp/ziOcVZ4=;
 b=UHpP6hgOIpte1x/AUlbrEeESmZkuvl8790bfUnM8AQVKVh0qhX3GURcB+pxDSP/j5M0jk17BHa3aMyzMDCANf+77zmULxvmRHWePJaMdWY9VYQMXphPR7hNGWQL4A8hWLam5YmJ7+lGeskjTl9IP8Y9EzXGnJcgeZ3wf0qczVt8eicNz8YuIQ1PhAhNya8l0G31CYFXPchWCKCS+Luejkw+W8BzvRWseTmFq9N+ixZfcGYrIc7OTUKWSLMfkrMVKy1XOCyIuDo21j6bVsLV42mMuSSeXQisFChB5DSvfhNpv+fHiP6qgJM+9HRwUXBnoev3stFVmsWxzcciapwDsUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ei6oSCwyFnpIQ/m7nfi54sVw9V4iBOeHqp/ziOcVZ4=;
 b=OB288ZfI+MuROn3sKXqDAekMBtjQOKGjSYLzd4NaI7XVZoCyFsJXPgiIAYk6Yv9FA60K+Ng4LMBJG61t6mFSiL6TOsZq96zSf9JLPWTVGXNSUJt5hQUURDryNtbqYLHWFriprZEkPCLLG/kgcSZGqdWI7dNtTQh8GY+IOzob3dk=
Received: from DM6PR08CA0050.namprd08.prod.outlook.com (2603:10b6:5:1e0::24)
 by DS0PR12MB8787.namprd12.prod.outlook.com (2603:10b6:8:14e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Tue, 5 May
 2026 17:32:45 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::a3) by DM6PR08CA0050.outlook.office365.com
 (2603:10b6:5:1e0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 17:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:32:44 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:32:43 -0500
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
Subject: [PATCH v17 10/11] PCI/CXL: Mask/Unmask CXL protocol errors
Date: Tue, 5 May 2026 12:30:28 -0500
Message-ID: <20260505173029.2718246-11-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|DS0PR12MB8787:EE_
X-MS-Office365-Filtering-Correlation-Id: a10c4559-103b-466a-acd0-08deaacc511b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7YXNvnHg0aVln920mk7sZpBs6sDKE0IiZq8EqagR3H8eyyJAoNSVknA2Ynj3cX7tkWuIAT32IOCNQCHjlYH4W1IRelgWknKiaesP72gj4ubwQnvyBHAK3jLQQwKbif2gNrQmCMRUhDEDfNJP539jAlXLa7OHM634Ff/avOLOHdTK3uaso3DmWnndPPBI1cfkibmwTbQDUyeyCIdPwaONVjo58CErbfSDpdl7WxEc5auzg5PJCN/2ytmxGFAM8KDg1ZQeuvRKgbWWLHtSxHWM8IqIg7VbnrnXJMVZo1Iv7oqe1yFrnaPFmbkHUqPoR6tzJDOk/aasioX+CDcss2E1jebQHtDNVbyqjA2UXarq4ahBilFbmk1U20rzQ0n0QQW0vYaUmh9JTx+qZBW4/PQVqU1bFBS5rGJBREYi55rZFGCOC9eWRQNC7s5glGOc2KbKZHPjIyAdR6K5K+r7o4bz+AC+yrAX4+USmtQrni1JHyFygGyin3O+yjxRl3pHdtaEA3oMV6iqPvGX6sUUeHDeXewGdnY134kvQ/7KjT0uPt/RinQPQZ3yjKlcR47Njda8uRCOAa+UAZdjffyvC23umRbslXJVnbJ78PqHBNriK0Np+i8S8SuI8zoElrIySRwDBDxfTOFHQQMTUr+0m+CTOIeGfvNobPq9ZI7kZ5cLsPO7hhhXNw912xQKvZkc42owykT/2yjs+2usepyCiKRJrpHihoAlrkZGQCZHL94ps9bIsLo4xZN0ZZ2K07pTEQcwvxGWdDFGsdyVl6Q4pHUiqg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lQTuERPp2TZi/xjGVId9GusYQ+TL14voFLr3yYVO/dBqE5WwLI4EiHQtBBJI2LBZN7fhxZUSihjmHe5g71j24xuBdgZYY7bVhYAo0s2k/ki0wU8sRtp7h/lpgMHwHmqRRj3FslButomQYjkkEu/oes20AXQwlE4yyWbi/78S7JW1772ohivvqkK4K8asMlD2XMqfGDyhfMi2L3wczryfjEPrY4JIu36958b1ZlnkNs5d1M4YMWVmqk3eW0lRqji4BD/LqWzdQ8Pg1mX7DNMsjKksVpg/p+HMuNGFeGJt4WUtdvfQjIYyv9pGEXBRNlB6/x3DWCbYhkiOcUH3b7DtrZP9sRrKpCaSmbKGrdNWzOLMZtwJeyNHzKzGVGFu25/BhY8RnViHtFHg1TLyTRk/nyWKnHG1rbOItnXF9Xp9mUba9JivlzdVBQ0x9vaAat99
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:32:44.3450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a10c4559-103b-466a-acd0-08deaacc511b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8787

CXL protocol errors are not enabled for all CXL devices after boot. They
must be enabled in order to process CXL protocol errors. Provide matching
teardown helpers so the masks are restored when a CXL Port or Downstream
Port goes away.

Add pci_aer_mask_internal_errors() as the symmetric counterpart to
pci_aer_unmask_internal_errors() and export both for the cxl_core module.

Introduce cxl_unmask_proto_interrupts() and cxl_mask_proto_interrupts()
in cxl_core to wrap the PCI helpers with the dev_is_pci() and
pcie_aer_is_native() gating CXL needs. Both helpers tolerate a NULL
@dev so teardown callers do not have to special-case it.

Wire cxl_unmask_proto_interrupts() into the success path of
cxl_dport_map_ras() and devm_cxl_port_ras_setup() so the unmask only
runs when the RAS register block was actually mapped. Pair each unmask
with a devm_add_action_or_reset() registration of
cxl_mask_proto_interrupts() scoped to the cxl_port device. The mask is
then restored when the cxl_port device releases its devres. This
applies to Endpoints, Upstream Switch Ports, Downstream Switch Ports,
and Root Ports.

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

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
 drivers/cxl/core/core.h |  4 +++
 drivers/cxl/core/ras.c  | 63 ++++++++++++++++++++++++++++++++++++++---
 drivers/pci/pcie/aer.c  | 25 ++++++++++++++++
 include/linux/aer.h     |  2 ++
 4 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 2c7387506dfb..ff39985d363f 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -190,6 +190,8 @@ void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
 void cxl_handle_rdport_errors(struct pci_dev *pdev);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
+void cxl_unmask_proto_interrupts(struct device *dev);
+void cxl_mask_proto_interrupts(struct device *dev);
 #else
 static inline int cxl_ras_init(void)
 {
@@ -207,6 +209,8 @@ static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
 static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
 static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
+static inline void cxl_unmask_proto_interrupts(struct device *dev) { }
+static inline void cxl_mask_proto_interrupts(struct device *dev) { }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index a98ce0f412ad..b45e2b539b5f 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -66,16 +66,59 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
+void cxl_unmask_proto_interrupts(struct device *dev)
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
+void cxl_mask_proto_interrupts(struct device *dev)
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
+	cxl_unmask_proto_interrupts(dev);
+	if (devm_add_action_or_reset(dport_to_host(dport),
+				     cxl_mask_proto_irqs, dev))
+		dev_warn(dev, "failed to register CXL proto-irq mask cleanup\n");
 }
 
 /**
@@ -109,6 +152,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_dport_rch_ras_setup, "CXL");
 void devm_cxl_port_ras_setup(struct cxl_port *port)
 {
 	struct cxl_register_map *map = &port->reg_map;
+	struct device *dev;
 
 	if (!map->component_map.ras.valid) {
 		dev_dbg(&port->dev, "RAS registers not found\n");
@@ -117,8 +161,19 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 
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
+	if (devm_add_action_or_reset(&port->dev, cxl_mask_proto_irqs, dev))
+		dev_warn(&port->dev,
+			 "Failed to register CXL proto-irq mask cleanup\n");
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b9c6c7b97217..eaa36fe0eb31 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1151,6 +1151,31 @@ void pci_aer_unmask_internal_errors(struct pci_dev *dev)
  */
 EXPORT_SYMBOL_FOR_MODULES(pci_aer_unmask_internal_errors, "cxl_core");
 
+/**
+ * pci_aer_mask_internal_errors - mask internal errors
+ * @dev: pointer to the pci_dev data structure
+ *
+ * Mask internal errors in the Uncorrectable and Correctable Error
+ * Mask registers.
+ *
+ * Note: AER must be enabled and supported by the device which must be
+ * checked in advance, e.g. with pcie_aer_is_native().
+ */
+void pci_aer_mask_internal_errors(struct pci_dev *dev)
+{
+	int aer = dev->aer_cap;
+	u32 mask;
+
+	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	mask |= PCI_ERR_UNC_INTN;
+	pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_MASK, mask);
+
+	pci_read_config_dword(dev, aer + PCI_ERR_COR_MASK, &mask);
+	mask |= PCI_ERR_COR_INTERNAL;
+	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
+}
+EXPORT_SYMBOL_FOR_MODULES(pci_aer_mask_internal_errors, "cxl_core");
+
 /**
  * pci_aer_handle_error - handle logging error into an event log
  * @dev: pointer to pci_dev data structure of error source device
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 979ed2f9fd38..c52db62d4c7e 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -71,6 +71,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
 void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
+void pci_aer_mask_internal_errors(struct pci_dev *dev);
 #else
 static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
@@ -79,6 +80,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
+static inline void pci_aer_mask_internal_errors(struct pci_dev *dev) { }
 #endif
 
 #ifdef CONFIG_CXL_RAS
-- 
2.34.1

