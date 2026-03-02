Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011024.outbound.protection.outlook.com [40.93.194.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4735C3A8755;
	Mon,  2 Mar 2026 20:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483876; cv=fail; b=BqPzKP4zmG4kg6RVW74RuzuwN1+KTFdNyFT5zz9tpCxPR6Ad7nyddv/McH1I2ejRH6oytwAHEWiktAWllnmGPif87xRVY4Ed5iCpyY4CKmdIwFxMy18j6uYX11XqhM/e3hEtie0py+LOYjfjq81AllG16+GQPLdro41mf5dpGek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483876; c=relaxed/simple;
	bh=yz7UNLs20rVPh4AEtT2K1JoGCV1/T7S4LvmFiu11ypQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxVjkNeMvaDzyEwdB7WLevpxmCg0GGMoW1DLNllOi94Y5Bs6EuZ3Ar2edS80y4PF9NTWwg9+UvRmDF5iabPvJG/ONERQ7wXJft8QPjPHFm1mkZGTBZvL4udCwkSP9nMigXDpYWzk2DtEyjYJDw3/UBnhnsJX+4WwmaIGlGfNX5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=esP2DLWy; arc=fail smtp.client-ip=40.93.194.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="esP2DLWy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZyXymG+qxZsVs2OtEwXmrc+f5MreuXNm0eDnYOwnkG3W1jIxw+zM0dCu25B3pBhRs5d4cVW7nqhUHTtAYdKRBS8rQcwO5jZscnp7gXFMidmvfn/TXBFjLRTuqF1DOilueBsK5PYYr2F2H4Acyjd68c+B2xlD2Cm/eXihv6qnM8iZK9mWWSs7XPcReptklM/3aDO7RB+fjGTLBSf4k3Za7vvI7TjVJgxcwvvyweO/9EMoO+JRMhXKMBidIff59WQ/tbrv2JV2eUwKzfqVf8hCDICQ1lxWWuU81iqvoiHNwJb61o30YvIfVI2YOJ1oWwdEqsH1LT7g70TFRRYhXzJ59w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFmsJGECf3umf8204wZIAgwxJOJJmDrHzvJv6lothYU=;
 b=WqTtQXjppQ0A+aa539KxLHbOmd/3NDbMfCRy+H6T5B4/Z/CKNvs0QuzOb5xXKRaFZ+L1/KzD9Pyy2jcwo78eEyhcLSsMsh5ULETDaYKjpF0oMPWIta39quAFp4BNba8GiBB9DhilI7JsXSlWcZ4Nq5/BtvAqZuJusHQpSx6ht4u8oUFPOAV2tsW+9g0b7W/qrt2b7IweStr2SxcU/booQV9JvZLXOgAyERJxcHhzT+eZiynLtY/nInam2th3JyAoXc+/kuWJw92TwyeU6sIaL4W6+6hYv2puYU34ctlIM6H3rpr5d7AB69cYBBp77InvUGhJwK2HlxaSVYQtVA7Csg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFmsJGECf3umf8204wZIAgwxJOJJmDrHzvJv6lothYU=;
 b=esP2DLWyKvcCnF4SCIhWY7hgvhLXqzOf0MTI3mR+OFpL11Efix1nU6NdSKsE0fsj2begwvmGZ36ZXBq/hXEG/2FJLg72t5M4q2kzV4xS7ewXNG8meA20kXWEbZV6MG6muD6zp8qmq5FNItcv2hMlTdsyBi/8FPD+2sitkU2HRUw=
Received: from MN2PR06CA0028.namprd06.prod.outlook.com (2603:10b6:208:23d::33)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 20:37:50 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::a4) by MN2PR06CA0028.outlook.office365.com
 (2603:10b6:208:23d::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 20:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 20:37:49 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 14:37:48 -0600
From: Terry Bowman <terry.bowman@amd.com>
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<terry.bowman@amd.com>
Subject: [PATCH v16 05/10] PCI: Establish common CXL Port protocol error flow
Date: Mon, 2 Mar 2026 14:36:43 -0600
Message-ID: <20260302203648.2886956-6-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302203648.2886956-1-terry.bowman@amd.com>
References: <20260302203648.2886956-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 626a1d93-7896-46d8-03a7-08de789b9206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	UWqQyPWHW9s9PK4cMUI+y1Ee46OhJfsL5+kinLe021CsINehlJaL4/neplqjwlhAzi8Hx0UG3I7Vd14PuNCd6pDY9SjNVIbAY6MSQ/1lK/yvMIF87PdlnPoO5I5hY0mYX4AR8O44CwQCkdVF6v6xDdkPYYFvXkD+QAZJ+dVZOEHWWQN/uTfIijRNgJqc8BSr4Ujxq5QEL84KJweHZpQ6wds4tLSwGUf1cdIoQ4GTX7tm0kUZXJd26GDA5GNPNpskK19cXSIDZNAyXwfnSovAWO/lW4c2yUwW6KFMMDHTniZ0W3374wBCFU/CycK/GOg3G8ramLWQaXwG43TJIgL2+9LVhaWgw1eY2OWwd9Ro7NfOM2ZVjop6Nvm6Do/1C8PouE+0WRQ+dzxeaguvEZN3h8Od7QosessKz17lmFF1SOPNOdxwD8OrAEelm1G20nP+LHAV8D4ppfn4Rc1wZfoLyAv1NUSl0xkYw9k75uuxwJXbYrgPqkqhyl4b974t3K1kUZeIP4HEVUfT+NpeJpaEie9rRrQx0CETCRXIo50jSeurnGW7KuYHlqenycaFpkv4LbOBDIeFr4f0eqopBNYMBG2GGsr+P2o6epCBQb/rg9m3IP1gER7HuZ0LGcsaNSvsnm3ABozpZO7mD1jH1asyET1c2iNgezru6AJuWkYK94mkj+OE1mGuH3ApUQffQp4oHR3Q7I6Q8XrY7cOZAuG2l4wPkEWwkP21ur/C2Xy5fuajygSLYXSsgIdQUR7J1NPZLp/2IdxQEgAfbxIQrtIHksDP3SFAT3c3yBJg8fXMJEy2obvhqO+TvG1gwTpGL3I1FZGUZyNZOmbXd44xGju8t+deP9m2exrfva8l6TsJwr0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KYY3I0nN2tZ1vJdPTC6ERAE4vF+TlX7BuTY/iBFz/FOGP2Z7ylNrmwym8TZcSzA1BYeDnt6G7sCLmmUXvNGZ4H4IsShbch8S4lMm2SHO3JRTond59KmilNwT9stUz0ED92mpVbz2D1ZOTB33yG0+gdp0nk49kVRGeB9gx7jXCL6wd6Prc76ZPRIEBik3luaLCl+fnY5+sQqQRKRStHPG80cUjhSQftNefX6poD5uFsm0ybzd8QX5Usw0g4pmhGpbUkU7lS98gMsEWMlpTOVpeHk16/uTStbWhuxAStRUgsnz3aMkqjjl/qCrTk4+PJ01Q8hPtXS9rJWQWGRe5Y4lCPRUsRCFbXHxLLv+KSmF2XoNGgsenmkfneej2gtlwh+CT2xepQKwiqST4mtqMMYSta9v8TcoFsjpVdk3UBo4o/gQsXzdp3heDkSXqD0gcFI0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 20:37:49.7881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 626a1d93-7896-46d8-03a7-08de789b9206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

Introduce CXL Port protocol error handling callbacks to unify detection,
logging, and recovery across CXL Ports and Endpoints. Establish a consistent
flow for correctable and uncorrectable CXL protocol errors. Support for RCH
Downstream Port error handling will be added in a future patch.

Provide the solution by adding cxl_port_cor_error_detected() and
cxl_port_error_detected() to handle correctable and uncorrectable handling
through CXL RAS helpers, coordinating uncorrectable recovery in
cxl_do_recovery(), and panicking when the handler returns PCI_ERS_RESULT_PANIC
to preserve fatal cachemem behavior. Gate Endpoint handling on the Endpoint
driver being bound to avoid processing errors on disabled devices.

Centralize the RAS base lookup in cxl_get_ras_base(), selecting the
downstream-port dport->regs.ras for Root/Downstream Ports and port->regs.ras
for Upstream Ports/Endpoints.

Export pcie_clear_device_status() and pci_aer_clear_fatal_status() to enable
cxl_core to clear PCIe/AER state in these flows.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

Changes in v15->v16:
- get_ras_base(), initialize dport to NULL (Jonathan)
- Remove guard(device)(&cxlmd->dev) (Jonathan)
- Fix dev_warns() (Jonathan)
- Remove comment in cxl_port_error_detected() (Dan)
- Made pcie_clear_device_status() and pci_aer_clear_fatal_status()
  "CXL" Export namespace (Dan)
- Update switch-case brackets to follow clang-format (Dan)
- Add PCI_EXP_TYPE_RC_END for cxl_get_ras_base() (Terry)
- Add NULL port check in cxl_serial_number() (Terry)

Changes in v14->v15:
- Update commit message and title. Added Bjorn's ack.
- Move CE and UCE handling logic here

Changes in v13->v14:
- Add Dave Jiang's review-by
- Update commit message & headline (Bjorn)
- Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
  one line (Jonathan)
- Remove cxl_walk_port() (Dan)
- Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
  sufficient (Dan)
- Remove device_lock_if()
- Combined CE and UCE here (Terry)

Changes in v12->v13:
- Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
  patch (Terry)
- Remove EP case in cxl_get_ras_base(), not used. (Terry)
- Remove check for dport->dport_dev (Dave)
- Remove whitespace (Terry)

Changes in v11->v12:
- Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
  pci_to_cxl_dev()
- Change cxl_error_detected() -> cxl_cor_error_detected()
- Remove NULL variable assignments
- Replace bus_find_device() with find_cxl_port_by_uport() for upstream
  port searches.

Changes in v10->v11:
- None
---
 drivers/cxl/core/core.h       |   3 +
 drivers/cxl/core/port.c       |   6 +-
 drivers/cxl/core/ras.c        | 189 ++++++++++++++++++++++++++++++++--
 drivers/pci/pci.c             |   1 +
 drivers/pci/pci.h             |   2 -
 drivers/pci/pcie/aer.c        |   1 +
 drivers/pci/pcie/aer_cxl_vh.c |   5 +-
 include/linux/aer.h           |   2 +
 include/linux/pci.h           |   2 +
 9 files changed, 195 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 5051800882c5..0eb2e28bb2c2 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -208,6 +208,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport);
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0c5957d1d329..27271402915f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1386,8 +1386,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev,
-				      struct cxl_dport **dport)
+struct cxl_port *find_cxl_port(struct device *dport_dev,
+			       struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
@@ -1582,7 +1582,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 {
 	struct device *dev;
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 44791f6d7d50..1d4be2d78469 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -119,16 +119,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-int cxl_ras_init(void)
-{
-	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
-}
-
-void cxl_ras_exit(void)
-{
-	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
-}
-
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -185,6 +175,117 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
+/*
+ * get_cxl_port - Return the parent CXL Port of a PCI device
+ * @pdev: PCI device whose parent CXL Port is being queried
+ *
+ * Looks up and returns the parent CXL Port associated with @pdev. On
+ * success, the returned port has its reference count incremented and must
+ * be released by the caller. Returns NULL if no associated CXL port is
+ * found.
+ *
+ * Return: Pointer to the parent &struct cxl_port or NULL on failure
+ */
+static struct cxl_port *get_cxl_port(struct pci_dev *pdev)
+{
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM: {
+		struct cxl_dport *dport;
+		struct cxl_port *port = find_cxl_port(&pdev->dev, &dport);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_RC_END: {
+		struct cxl_port *port = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port;
+	}
+	}
+
+	pr_err_ratelimited("%s: Error - Unsupported device type (%#x)",
+			   pci_name(pdev), pci_pcie_type(pdev));
+	return NULL;
+}
+
+static u64 cxl_serial_number(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+	struct device *port_dev = port ? port->uport_dev : NULL;
+	struct cxl_memdev *cxlmd;
+
+	if (!port_dev || !is_cxl_memdev(dev))
+		return 0;
+
+	cxlmd = to_cxl_memdev(port_dev);
+	return cxlmd->cxlds->serial;
+}
+
+static void __iomem *cxl_get_ras_base(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM: {
+		struct cxl_dport *dport = NULL;
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port(&pdev->dev, &dport);
+
+		if (!dport) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return dport->regs.ras;
+	}
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_RC_END: {
+		struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
+
+		if (!port) {
+			pci_err(pdev, "Failed to find the CXL device");
+			return NULL;
+		}
+		return port->regs.ras;
+	}
+	}
+	dev_warn_once(dev, "Error: Unsupported device type (%#x)", pci_pcie_type(pdev));
+	return NULL;
+}
+
+static void cxl_do_recovery(struct pci_dev *pdev)
+{
+	struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+	struct device *dev = &pdev->dev;
+	pci_ers_result_t status;
+
+	if (!port) {
+		pci_err(pdev, "Failed to find the CXL device\n");
+		return;
+	}
+
+	status =  cxl_handle_ras(dev, cxl_serial_number(dev), cxl_get_ras_base(dev));
+	if (status == PCI_ERS_RESULT_PANIC)
+		panic("CXL cachemem error.");
+
+	if (pcie_aer_is_native(pdev)) {
+		pcie_clear_device_status(pdev);
+		pci_aer_clear_nonfatal_status(pdev);
+		pci_aer_clear_fatal_status(pdev);
+	}
+}
+
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -327,3 +428,71 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+
+static void cxl_handle_proto_error(struct pci_dev *pdev, int severity)
+{
+	if (severity == AER_CORRECTABLE) {
+		struct device *dev = &pdev->dev;
+
+		if (!pcie_aer_is_native(pdev))
+			return;
+
+		if (pdev->aer_cap)
+			pci_clear_and_set_config_dword(pdev,
+						       pdev->aer_cap + PCI_ERR_COR_STATUS,
+						       0, PCI_ERR_COR_INTERNAL);
+
+		cxl_handle_cor_ras(dev, cxl_serial_number(dev),
+				   cxl_get_ras_base(dev));
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(pdev);
+	}
+}
+
+static void cxl_proto_err_work_fn(struct work_struct *work)
+{
+	struct cxl_proto_err_work_data wd;
+
+	/*
+	 * Dequeue work forwarded from the AER driver
+	 * See cxl_forward_error() for matching pci_dev_get()
+	 */
+	while (cxl_proto_err_kfifo_get(&wd)) {
+		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;
+		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
+
+		if (!port) {
+			pr_err_ratelimited("%s: Failed to find parent port device in CXL topology\n",
+					   pci_name(pdev));
+			continue;
+		}
+
+		guard(device)(&port->dev);
+		if (!port->dev.driver) {
+			pr_err_ratelimited("%s: Port device is unbound, abort error handling\n",
+					    dev_name(&port->dev));
+			continue;
+		}
+
+		cxl_handle_proto_error(pdev, wd.severity);
+	}
+}
+
+static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
+
+int cxl_ras_init(void)
+{
+	if (cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work))
+		pr_err("Failed to initialize CXL RAS CPER\n");
+
+	cxl_register_proto_err_work(&cxl_proto_err_work);
+
+	return 0;
+}
+
+void cxl_ras_exit(void)
+{
+	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
+	cxl_unregister_proto_err_work();
+}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8479c2e1f74f..2c4bad5ad2b1 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2246,6 +2246,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
 	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
 }
+EXPORT_SYMBOL_NS_GPL(pcie_clear_device_status, "CXL");
 #endif
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 13d998fbacce..780f262d2c3c 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -263,7 +263,6 @@ void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
-void pcie_clear_device_status(struct pci_dev *dev);
 void pcie_clear_root_pme_status(struct pci_dev *dev);
 bool pci_check_pme_status(struct pci_dev *dev);
 void pci_pme_wakeup_bus(struct pci_bus *bus);
@@ -1291,7 +1290,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2e996e339d7c..871fa633b4da 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -295,6 +295,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_NS_GPL(pci_aer_clear_fatal_status, "CXL");
 
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index ebca1112652a..818ec0d0a012 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -33,7 +33,10 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	if (!info || !info->is_cxl)
 		return false;
 
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
 		return false;
 
 	return is_aer_internal_error(info);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index f351e41dd979..c1aef7859d0a 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -65,6 +65,7 @@ struct cxl_proto_err_work_data {
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
@@ -72,6 +73,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0d6ad11e3422..e7ed8da4844f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1938,8 +1938,10 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
 
 #ifdef CONFIG_PCIEAER
 bool pci_aer_available(void);
+void pcie_clear_device_status(struct pci_dev *dev);
 #else
 static inline bool pci_aer_available(void) { return false; }
+static inline void pcie_clear_device_status(struct pci_dev *dev) { }
 #endif
 
 bool pci_ats_disabled(void);
-- 
2.34.1

