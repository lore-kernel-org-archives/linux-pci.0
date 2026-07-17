Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013019.outbound.protection.outlook.com [40.93.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD963AB277;
	Fri, 17 Jul 2026 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784327351; cv=fail; b=rdAfcL/DlriIsQIfkUaMDkezMT6eIcj9OSOx+5lJ0LiS2dVCSdayCFv3X0H6GIQiGt9Z4Lf+rXmSJyzHPiG9KLR+uMXP/SBnoDHgaB9IVXWF18h8YoZDboS41fQLVD9phgLdYnPQuENSe87Ew9LXO1nHignRPcaJx1LzTXdLbnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784327351; c=relaxed/simple;
	bh=ugWDciJOgfOEB3OGkAiVc2fnAdYzv0yUJD+4sIDze6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VfaTGGOLVLSJgcIr9wpdtsx44HKXsZTzXo9gcLkdcmFEUX/4so8jG4BA+ppAm4LabGMiv74WIbuaFEInW9v7cYnKIOjD63PTJZe2VdGlr8D2H44y8KDFM/7qBUAIpr1r0v/dovuku86iJWvVZRlFWc8FZ+G8IcjLvB7om1mpu1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DSSCHmh4; arc=fail smtp.client-ip=40.93.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DSSCHmh4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmFGbaa1BmivdV2xApIv0bEoB0AcG5H7VaZs8NqHv2DRKkE/wqcxM1jI9PTffEVqgqOL7OL6dyS64nvRhm20jSyEZ31tWOIQRXFVDTSV89taHg2PC36jh8IjXF0K/GfW6dCJ2aJ7ez+C4Nwz2K8pfpC6ZQP+oEQumcI75UBaMiITB4shH3r8DV0XCcEMVxP+ep8PDY39fpAGOFoyAsHLLe7Q0+XScTY3UnCU9qHlP5zp0IjwhnZe9+A7m+To+PtyOjAxOMh1JP6jykvvkAW5WoKJeFLKymCuQqFjM3f78EQchZntbx8dJMoSt4KAUq0OGPFNZXXHVI+CLTEgBJlNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlH/rkQRn6pHy65fySPQxNCdMy89oqfVOouGR8zWGpQ=;
 b=lgxr8zsjmYRPL1sbLgXh066yh/WdI6RQBrdQp/fjDnSHxPL/lGXeXDopGwmmF1/9CnIeRoTZrK1qpGw5q2s24pGXE+R21e8xZE+83AoD1xXiOcRlCQOtcSoKO3iCdvasM1Tx2jNWl9iiU31X02TZz6+B+RmiuLgQmn79sK94MG/q1v/btqVukxEeP8KJigMkFbl1O1h19N5CVhKaHBkEMF+GXOFjKmWAcsatsORyo6Y+y1tU5Run62eeBxhMzlghznB8D4b+IoIkaEiIRq+lA6oh7JC9VIBDxKIn8eLunX+3lzgMJAjcEmTiCCchHe59FpOCAk4oG/43iQjYNMzt2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlH/rkQRn6pHy65fySPQxNCdMy89oqfVOouGR8zWGpQ=;
 b=DSSCHmh4GrqmqAQ9PfcvRX6AnZxTIHPTDobJdKAdKt0IrvGWEbrlJSCUMy1WRXCqUYo6WNGGkXHWnguWVYSk8NBoZuqPEuByN0oBFUuQOH8TzLp3So/vtZpH9PnnxxOCbGu82nTFlssFMmnHEwhHo6qB/2+ClmxzEmdFq9bIA5Q=
Received: from BY3PR04CA0008.namprd04.prod.outlook.com (2603:10b6:a03:217::13)
 by DS5PPF5A66AFD1C.namprd12.prod.outlook.com (2603:10b6:f:fc00::64d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 22:28:57 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::2c) by BY3PR04CA0008.outlook.office365.com
 (2603:10b6:a03:217::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 22:28:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 22:28:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 17 Jul
 2026 17:28:55 -0500
From: Terry Bowman <terry.bowman@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>, "Dave
 Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Robert Richter <rrichter@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, "Alejandro
 Lucero" <alucerop@amd.com>, Alison Schofield <alison.schofield@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben
 Cheatham" <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno
 Leitao" <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M .
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
	<gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming <ming.li@zohomail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>, Shiju Jose
	<shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, Terry Bowman
	<terry.bowman@amd.com>, Tony Luck <tony.luck@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>
Subject: [PATCH v18 09/13] cxl: Update CXL Endpoint AER handler
Date: Fri, 17 Jul 2026 17:27:02 -0500
Message-ID: <20260717222706.3540281-10-terry.bowman@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717222706.3540281-1-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|DS5PPF5A66AFD1C:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cab59a0-21f3-4bb2-cac1-08dee452ca7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|30052699003|376014|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	FS9SrtXXoQ1oGe868UEoM8r/9DFDYYueME6HBjiZyol+i4GMlz9sBZSNZ6KVy9XUHGs/MzB1WoCTxgAGYWPnBcplV+wFteqmoe9PjPGcHrwFAUNBslqdUuTOulyG/yEphqMZqTR6V4DMS1QnkT3UunLOcnBg+01OOBB4d8lI3eSiCiwdalZPkcDnXcLXR+Y8yiQpRZxIpd8hIYGakxOVkcUEtYD2tFGfaxdcBR25UUC17cO3416pwohSKHus0KQoK1hMLzV9jjRVQR0e/Fz066AC6WQazgrigBBM0pyfKupw2bkJa1UT2hXZb4jVxSXSZ5h71Jmf/nEgj7Nro5go4G3EoVFoSBiyPQL+fQzyKIILw/y4lCRpw0t6Al7avTqtOxlkPJ1Kz/VrzBvjnYcS4+r4vLEilDm4MFvt4TOupUQcruWmsBknA0dG/HBVgMMFjKcmSz23Ms8hV8m5BGFgsQTJ8bNWygKkvVqMn9YbISNKX9hD2ElcGSnWPapN2uazeUEVJOoo2yajiqK7oE3/f4yvHNvR5LjgsO7FQMTYItVWxmlJZ67W5U9HhBZSN/W+U5VF9Q7jLgxRCXB0qCbofMGZ5X1R77JLk51E/MvXjFSsnXAaZuriJY35F2l9gt7Ph3YP8zQxGHEh9Ps9aVTCIkucQYYbDVkCnKzNY/79ebZTJbo1HMzchRxXyz/dEPXZqIfyWCYirRpleVYWZsY67g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(30052699003)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4aHafssT+fW4NHzbUq0LAsrR30Mv48d+nvlNpnDG98q5PyAXPvuS5kZjg8GhcEkVA0aKEpmX+fYfvh9TkZ0IdrRpHgRaAtdulQr62waVE2QqKVXadrM7AKcgGMG/YEijTz6gsu+ZT1TR6ySf70dMeKZeS8aUw4uVNetFvee5reIprhj+HoZBa9myVdHz/Qey4JenYnlgqsHdBaPL2Y8IdCB+y+mC3cgRpzjd+X9ZzzAEruTEZtWIul8vlbcmU1+zdo/kcWRgBguRNWttJJZ3YX/fblA4SbudjPv4QS89FCFw5laO7rE48beoW3z2sdFhjv4dl1IgKcYsijaHwpWGUfmaaR25gWL61iitGpPj53INtaDlTjI4517544m8oeFzJ6RDxzjDPaRSWtsNwhI6ZHmZD2N/QtDwQ9qCFU1z+4GOPt9WN/lF2dWVDEsIdqkG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 22:28:56.7560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cab59a0-21f3-4bb2-cac1-08dee452ca7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5A66AFD1C

Rename cxl_error_detected() to cxl_pci_error_detected() and rename
the struct pci_error_handlers instance to cxl_pci_error_handlers to
avoid shadowing the struct type tag.

Document the unconditional CXL RAS read policy: on a dead link,
readl() returns 0xFFFFFFFF which is interpreted as UCE bits set and
triggers a panic. If RAS registers are not mapped the read is
skipped and the frozen/perm_failure switch cases defer to AER
recovery for devices without active CXL.mem traffic.

Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v17->v18:
- Fix cxl_pci_error_detected() to use find_cxl_port_by_uport() and port->uport_dev
- Read CXL RAS unconditionally; panic on UCE regardless of channel state
- Document unconditional read policy and 0xFFFFFFFF behavior in comment
- Drop guard removal paragraph from commit message (not in this diff)
- Drop Reviewed-by tags pending re-review after message change

Changes in v16->v17:
- Rename pci_error_handlers struct instance to cxl_pci_error_handlers to
  avoid shadowing the struct type tag.
- Restore scoped_guard(device) and dev->driver check around AER read.
- NULL-check find_cxl_port_by_dev() before deref of port->uport_dev.
- Updated commit message. (Terry)
- Add scope cleanup for port variable in cxl_pci_error_detected() (Terry)
- Drop cxl_uncor_aer_present(), rely on AER state

Changes in v15->v16:
- Update commit message (DaveJ)
- s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
- cxl_uncor_aer_present(): Leave original result calculation based on
  if a UCE is present and the provided state (Terry)
- Add call to pci_print_aer(). AER fails to log because is upstream
  link (Terry)

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
 drivers/cxl/core/ras.c | 24 +++++++++++++++---------
 drivers/cxl/cxlpci.h   |  8 ++++----
 drivers/cxl/pci.c      | 12 ++++++------
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 6f4a3c1b0bb85..d5dc2c22565da 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -328,10 +328,8 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
 	return true;
 }
 
-
-
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state)
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t state)
 {
 	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
 	bool ue = false;
@@ -349,10 +347,18 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 		}
 
 		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
+		 * The CXL RAS read is unconditional regardless of channel
+		 * state.  Any uncorrectable error bit set in the CXL RAS
+		 * status register triggers a panic because CXL.mem cache
+		 * coherency is already lost; continuing risks silent data
+		 * corruption across interleaved HDM regions.
+		 *
+		 * On a dead link readl() returns 0xFFFFFFFF which sets all
+		 * UCE bits and also triggers the panic - this is intentional.
+		 * If RAS registers are not mapped the read is skipped, the
+		 * panic is not reached, and the frozen/perm_failure switch
+		 * cases below handle AER recovery for devices without active
+		 * CXL.mem traffic.
 		 */
 		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
 	}
@@ -380,7 +386,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	}
 	return PCI_ERS_RESULT_NEED_RESET;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
 
 static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
 				   struct cxl_dport *dport, int severity)
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 06c46adcf0f6c..8aeb80a4e5732 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -89,13 +89,13 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-				    pci_channel_state_t state);
+pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+					pci_channel_state_t state);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
-static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
-						  pci_channel_state_t state)
+static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
+						      pci_channel_state_t state)
 {
 	return PCI_ERS_RESULT_NONE;
 }
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5c21db36073fe..6cf1db7b85020 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1000,18 +1000,18 @@ static void cxl_reset_done(struct pci_dev *pdev)
 	}
 }
 
-static const struct pci_error_handlers cxl_error_handlers = {
-	.error_detected	= cxl_error_detected,
-	.slot_reset	= cxl_slot_reset,
-	.resume		= cxl_error_resume,
-	.reset_done	= cxl_reset_done,
+static const struct pci_error_handlers cxl_pci_error_handlers = {
+	.error_detected		= cxl_pci_error_detected,
+	.slot_reset		= cxl_slot_reset,
+	.resume			= cxl_error_resume,
+	.reset_done		= cxl_reset_done,
 };
 
 static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
-	.err_handler		= &cxl_error_handlers,
+	.err_handler		= &cxl_pci_error_handlers,
 	.dev_groups		= cxl_rcd_groups,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
-- 
2.34.1

