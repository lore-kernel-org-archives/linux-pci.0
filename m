Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89D54949EA;
	Tue,  5 May 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002322; cv=fail; b=pKGVa5KchN934cGBb/jv4Ks0LURod7LF5hmZCuo84LAg/OdAZSzi4hhkH9MceyifqeMXU1UXKQK4KV6TvTbF4gFDohtTofsr7cRmkxYRZGbjgj5I4slsXpxe/TJBN3Ng22TkIZuIbqeLB+pECOxH4FJaoDIAygenWJ9EOYnGKB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002322; c=relaxed/simple;
	bh=JNTqwgYuV2ZLxnrVNSI7OQTXxOGjnpGfid0m472Uu3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkAQRGdaAHEmzWy9QfUqLqI/c9CBkaoYEODIh3xT483yIs7iy8Kksfr3UL5m7UcNvJ1iSV1+lYawaX0BUfuLl5COXiM+3b25ktAg771eIBNTjgPXx/A9Sm/7Eg2MB4Ob68ggRUEVvNglQJHwLejSLOlL/R7CBbkw59yN90PSTak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g27u6I6D; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g27u6I6D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0hWhQZ580MGfP/a53k1NNlzfv4Tl75NGFKGbefUTGwdg3DQRZFX5aXH5ZPgVwAGZ/mbStHZWJExUM69YVGBvUc54wv89iy+4Jg0mXZUGmhubpNqiy4VteKvEqEg19lJRzWLqlmpOi0QpEf/Yb4c7GVeoreBjRkP2J3hvNgHKVAhLjOGO35acbIW+EFn7Fk2lF2hOX/1AJy9S3kv+pjKDzF/DpEZWXFPyVNmwDV3aiK1oZkEdskQPTRdTzy81h783hg5CdEw2fr4v0mMOq/K9jyI6Heu8+OIGqVtwyFXOeVJpQEFCNboZ/F9hmtE647XZo1NLG6NdBIC2sN15rkskg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taXR3SbKTQp+rxGjx9QQYjrhaYQw/pkBucaKiYOGNq8=;
 b=sSS+lXSuEZDdHks8gQpcThc+U6eaf7cvVmK5v/EPIEt0mQ7RZJEM7eaPeJMKHz0AQ5E9cfaolqqDPGkJhpX75of+fvWSnug7lzqH8wXPKoqZqLkLgpI53mq+lxt8JbSnPcK+xIFBWqZi7mafStAPmWhlXWL1QHs5U+N5bKLOPF1S5MTaYcdHncv3WLCC3DHQZzMVQL+ybOajKLumVB1Yop7rnJhgnYuFRyORCs3b54f2GdOuh+cN60arwZop3h8Z3gefw+EkEpKstojD2h+YYKeqClI5gXl4IkbPnY03HeHS8EmSXKAgv3yEaH/dUTUuer64kaDvOPKj563NCNnilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taXR3SbKTQp+rxGjx9QQYjrhaYQw/pkBucaKiYOGNq8=;
 b=g27u6I6Dl+JcwTRqj9qAT4X+lZurdYzWP9opryPdEUGPBYN1iR7BukyIXZusyZOh1FNNRcmkr5rv35+n6EovUaKBhHrFZIgcjf8XCCzBswjyy5go5Ut7yhWo/Cc8JCKbvAw+JvG/qrCSb8bSYe02fPHo2Dbm33m/D8n249W/uac=
Received: from CH0PR13CA0020.namprd13.prod.outlook.com (2603:10b6:610:b1::25)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:31:56 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::3d) by CH0PR13CA0020.outlook.office365.com
 (2603:10b6:610:b1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 17:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:31:56 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:31:55 -0500
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
Subject: [PATCH v17 06/11] PCI: Establish common CXL Port protocol error flow
Date: Tue, 5 May 2026 12:30:24 -0500
Message-ID: <20260505173029.2718246-7-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf99330-d85f-489c-a792-08deaacc3478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	O5MXE1QQjveqlp09tTdYYooIWyD3i1rzJGjZcUpB3kyymTPGgqoqy1DO4O9uUJqy1egbRXg41e3JQHFxSDkT5bh3D2Td37krps0GtyXPR2q3aqXPzIPMju263acdxwk2eZJ4XNCe/RkQDVDCndlRlRJU3qBczGP1eDuQKmWfieKo6aUzXRawb9Wjdr/lQpy4go82scGfcxZHJFYzYBRdpZUpTg9Rfis6WUCU/ewaFkEFe2Cj8fpJ7OOy+fn5xGeOcKDCTqeQ2yQL1j3G8XOUkS7m5gG3VF1iuOMsGWdwmE3GOPz4zNZ8Upeqpd7dadyIXnapi1flJGmJejQub3s0Im6GxO3CiKCmQcZcNzsP7lnXnlndfjagGA5VL5cEvL8haO7dQT8M8uG2DqWHo5RU6EKd1seO8QCFYjcWwSTllbdn9cO3qWohVbrUcuE5uLO9f4GN9zq2LuUnSZfgADZB22l1Jd0G4dIf6aSHw56yWYVQ0sO6KtQ146hUqKJI66d8X1erXSerwl+kufJsOFjfAEL4ljs3tD3kf9Bq0HzMsPj0fvlcpIhji9788gcP3B/er8xOfEMGsf/rbfiqH92HSOhce6hthxeIDnM9pWxEE93t7LpR4FHpBfvq5H8vLQj6tX5ddcuqT5/FTdP5n6OTUpmRuXBAQk4Xhr6t3ichKbDTo5370DYjyhoLICH5gmqFeRhB6Nay0SG9Id8AvCqhFpxEhKuJ+KcQioe8lcmGZY6OuTky9BlhAywK1f+fiGEoyWWbTpOyKGrDbZ80MnTJMQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QpI90ykrObgWhmiFg1iIU41gE5NEGJ18FUkdtzVvC/LYUxsXVyb9cRu2JtGfPNIuDqPeF6uTv+rnrXflOXUeIv2pypyd6qmt8qS7L+GqYp86OFeb3KYF5U23K2LgjHq00p5k8f8+0kVhFcUImNnCLpTIZrvQicgMBO/fWJdlMDEfgn6WMJQDdEbfiBj7PACJb105z5oMaBRsXNbcyAVfYjLofNz8S+XnaOFORPDr2N1QiUlvckTCSNetG+lz3pMXaPHyFR2MtnLD7wFVMGLK1c5JMRGigUFRmUWdDeGclJQi25IDiSydnA9KqkCgYvgLBRn/iVRKYYz6nQKT+U3CpJroiK3GqgC9U0HE+Mk/aHr6TEazmUigJgAK+cMiUlJGtP5hQgew+5tYFI3V6/+xcMHAcJuKspSHIEdLisD16kuU8fT+MWZf+WxLAxzJcdm7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:31:56.2781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf99330-d85f-489c-a792-08deaacc3478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597

Add CXL Port protocol error handling callbacks to unify detection,
logging, and recovery across CXL Ports and Endpoints. Establish a
common flow for correctable and uncorrectable CXL protocol errors.
RCH Downstream Port error handling is added in a following patch.

Add cxl_handle_proto_error() to dispatch correctable and uncorrectable
errors through the CXL RAS helpers. Add cxl_do_recovery() to coordinate
uncorrectable recovery. Panic via panic() on any uncorrectable CXL RAS
error. CXL.cachemem traffic cannot be safely recovered from an
uncorrectable protocol error in software, so panic regardless of the
AER severity reported. Gate error handling on the port driver being
bound to avoid processing errors on disabled devices.

Panic explicitly on pci_dev_is_disconnected() before accessing the RAS
registers. A CXL device disconnecting during an uncorrectable error event
is itself unrecoverable, particularly for devices in interleaved HDM
regions. Relying on the status readl() returning ~0u to trip the existing
panic path leaves the cause ambiguous.

The panic policy applies to the RAS register block of the device whose
error triggered the recovery: Root/Downstream Port RAS for VH Ports,
Endpoint Port RAS for VH Endpoints and RCDs. Upstream RCH Downstream
Port RAS UEs handled via cxl_handle_rdport_errors() are logged only, as
before this series. Only the RCD Endpoint's own RAS UE drives the panic.

Add to_ras_base() to centralize the RAS base lookup. It selects
dport->regs.ras for Root/Downstream Ports and port->regs.ras for
Upstream Ports and Endpoints.

Export pcie_clear_device_status() and pci_aer_clear_fatal_status() so
cxl_core can clear PCIe/AER state during recovery.

Wire the AER core to the kfifo in this commit by adding the
is_cxl_error() switch in handle_error_source() alongside the consumer
registration. This way the producer and consumer go live in the same
commit, so CXL errors are not silently dropped during bisect.

The correctable AER status is cleared by the producer in
cxl_forward_error().

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v16->v17:
- get_cxl_port() -> find_cxl_port_by_dev()
- Simplified find_cxl_port_by_dev()
- Replace and remove cxl_serial_number() w/ pci_get_dsn()
- cxl_get_ras_base() -> to_ras_base()
- Drop dependency on PCI_ERS_RESULT_PANIC; cxl_do_recovery() panics
  directly. (PANIC enum patch dropped from series.)
- Clarify panic semantics: panic on any uncorrectable CXL RAS error, not
  only AER-FATAL severities.
- Drop the redundant PCI_ERR_COR_STATUS RMW in cxl_handle_proto_error();
  cxl_forward_error() already acks the correctable AER status.
- Add is_cxl_error() switch in handle_error_source() here, paired with the
  kfifo consumer registration, to keep each commit bisect-safe.
- Drop pcie_aer_is_native() guard in cxl_do_recovery() (always native).
- Swap order with the "Limit" patch for bisectability w/ cxl_ras_exit()
- Reword for "any uncorrectable" CXL RAS error panics.
- Restore log messages for port-not-found and port-unbound cases.
- Whitespace cleanup (Jonathan)
- Update to get_cxl_port() documentation (Terry)
- Fix __cxl_proto_err_work_fn() to return 0 for transient errors.
- Drop !port check in cxl_do_recovery(), caller already validated
- Fix kerneldoc @pdev -> @dev in find_cxl_port_by_dev()
- Fix missing space in pr_err_ratelimited()
- Add disconnect check before access
- Made pcie_clear_device_status() and pci_aer_clear_fatal_status()
  EXPORT_SYMBOL_FOR_MODULES("cxl_core") (Dan)
- Move find_cxl_port_by_dport() and find_cxl_port_by_uport()
  de-staticisation and core.h declarations from the rename patch to
  here, where the first cross-file callers in find_cxl_port_by_dev()
  land.

Changes in v15->v16:
- get_ras_base(), initialize dport to NULL (Jonathan)
- Remove guard(device)(&cxlmd->dev) (Jonathan)
- Fix dev_warns() (Jonathan)
- Remove comment in cxl_port_error_detected() (Dan)
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
 drivers/cxl/core/ras.c        | 139 +++++++++++++++++++++++++++++++---
 drivers/pci/pci.c             |   1 +
 drivers/pci/pci.h             |   2 -
 drivers/pci/pcie/aer.c        |   6 +-
 drivers/pci/pcie/aer_cxl_vh.c |   9 ++-
 include/linux/aer.h           |   2 +
 include/linux/pci.h           |   2 +
 9 files changed, 152 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 132ac9c1ebf4..bc36cd1575a4 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -210,6 +210,9 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
+					struct cxl_dport **dport);
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index b35a9016fc81..bf417a6aeade 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1398,8 +1398,8 @@ static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
  * Return a 'struct cxl_port' with an elevated reference if found. Use
  * __free(put_cxl_port) to release.
  */
-static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
-					       struct cxl_dport **dport)
+struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
+					struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
@@ -1594,7 +1594,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 {
 	struct device *dev;
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index 9193dac4e507..0a552d5a236e 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -66,17 +66,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-int cxl_ras_init(void)
-{
-	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
-	return 0;
-}
-
-void cxl_ras_exit(void)
-{
-	cxl_cper_unregister_prot_err_work();
-}
-
 static void cxl_dport_map_ras(struct cxl_dport *dport)
 {
 	struct cxl_register_map *map = &dport->reg_map;
@@ -133,6 +122,67 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
+/**
+ * find_cxl_port_by_dev - Use @dev as hint to do a _by_dport or _by_uport lookup
+ * @dev: generic device that may either be a companion of port or target dport
+ * @dport: output parameter; set to the matched dport for dport-class
+ * lookups (Root Port, Downstream Port), NULL otherwise.
+ *
+ * Return a 'struct cxl_port' with an elevated reference if found. Use
+ * __free(put_cxl_port) to release.
+ */
+static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dport **dport)
+{
+	struct pci_dev *pdev;
+
+	*dport = NULL;
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	pdev = to_pci_dev(dev);
+
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		return find_cxl_port_by_dport(dev, dport);
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_RC_END:
+		return find_cxl_port_by_uport(dev);
+	}
+
+	return NULL;
+}
+
+static void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
+{
+	if (!port)
+		return NULL;
+
+	if (dport)
+		return dport->regs.ras;
+
+	return port->regs.ras;
+}
+
+static void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
+{
+	struct device *dev = &pdev->dev;
+	bool ue;
+
+	if (pci_dev_is_disconnected(pdev))
+		panic("CXL cachemem error: device disconnected during UE recovery");
+
+	ue = cxl_handle_ras(dev, pci_get_dsn(pdev),
+			    to_ras_base(port, dport));
+	if (ue)
+		panic("CXL cachemem error.");
+
+	pcie_clear_device_status(pdev);
+	pci_aer_clear_nonfatal_status(pdev);
+	pci_aer_clear_fatal_status(pdev);
+}
+
 void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -275,3 +325,70 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+
+static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
+				   struct cxl_dport *dport, int severity)
+{
+	if (severity == AER_CORRECTABLE) {
+		cxl_handle_cor_ras(&pdev->dev, pci_get_dsn(pdev),
+				   to_ras_base(port, dport));
+		pcie_clear_device_status(pdev);
+	} else {
+		cxl_do_recovery(pdev, port, dport);
+	}
+}
+
+static int __cxl_proto_err_work_fn(struct cxl_proto_err_work_data *wd)
+{
+	struct cxl_dport *dport;
+	struct cxl_port *port __free(put_cxl_port) =
+		find_cxl_port_by_dev(&wd->pdev->dev, &dport);
+
+	if (!port) {
+		dev_err_ratelimited(&wd->pdev->dev,
+				    "Failed to find parent port device in CXL topology\n");
+		return 0;
+	}
+
+	/*
+	 * Hold the port device lock and verify a driver is bound before
+	 * handling errors. Protects against NULL deref if an error is
+	 * dispatched before probe completion or after driver removal.
+	 */
+	guard(device)(&port->dev);
+	if (!port->dev.driver) {
+		dev_err_ratelimited(&port->dev,
+				    "Port device is unbound, abort error handling\n");
+		return 0;
+	}
+
+	cxl_handle_proto_error(wd->pdev, port, dport, wd->severity);
+
+	return 0;
+}
+
+static void cxl_proto_err_work_fn(struct work_struct *work)
+{
+	struct cxl_proto_err_work_data wd;
+	int rc;
+
+	rc = for_each_cxl_proto_err(&wd, __cxl_proto_err_work_fn);
+	if (rc)
+		pr_err_ratelimited("Failed to handle the CXL error (%d)\n", rc);
+}
+
+static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
+
+int cxl_ras_init(void)
+{
+	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	cxl_register_proto_err_work(&cxl_proto_err_work);
+
+	return 0;
+}
+
+void cxl_ras_exit(void)
+{
+	cxl_cper_unregister_prot_err_work();
+	cxl_unregister_proto_err_work();
+}
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8f7cfcc00090..e4b225dd6075 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2245,6 +2245,7 @@ void pcie_clear_device_status(struct pci_dev *dev)
 				   PCI_EXP_DEVSTA_CED | PCI_EXP_DEVSTA_NFED |
 				   PCI_EXP_DEVSTA_FED | PCI_EXP_DEVSTA_URD);
 }
+EXPORT_SYMBOL_FOR_MODULES(pcie_clear_device_status, "cxl_core");
 #endif
 
 /**
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..29e588f5289e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -265,7 +265,6 @@ void pci_refresh_power_state(struct pci_dev *dev);
 int pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
-void pcie_clear_device_status(struct pci_dev *dev);
 void pcie_clear_root_pme_status(struct pci_dev *dev);
 bool pci_check_pme_status(struct pci_dev *dev);
 void pci_pme_wakeup_bus(struct pci_bus *bus);
@@ -1296,7 +1295,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c5bce25df51c..b9c6c7b97217 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -295,6 +295,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (status)
 		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
 }
+EXPORT_SYMBOL_FOR_MODULES(pci_aer_clear_fatal_status, "cxl_core");
 
 /**
  * pci_aer_raw_clear_status - Clear AER error registers.
@@ -1186,7 +1187,10 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	cxl_rch_handle_error(dev, info);
-	pci_aer_handle_error(dev, info);
+	if (is_cxl_error(dev, info))
+		cxl_forward_error(dev, info);
+	else
+		pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
 
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index c0fea2c2b9bc..3c54c1647417 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -45,8 +45,15 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	if (!info || !info->is_cxl)
 		return false;
 
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_ENDPOINT:
+	case PCI_EXP_TYPE_ROOT_PORT:
+	case PCI_EXP_TYPE_UPSTREAM:
+	case PCI_EXP_TYPE_DOWNSTREAM:
+		break;
+	default:
 		return false;
+	}
 
 	return is_aer_internal_error(info);
 }
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 78841cf4268c..979ed2f9fd38 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -68,6 +68,7 @@ typedef int (*cxl_proto_err_fn_t)(struct cxl_proto_err_work_data *wd);
 
 #if defined(CONFIG_PCIEAER)
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
+void pci_aer_clear_fatal_status(struct pci_dev *dev);
 int pcie_aer_is_native(struct pci_dev *dev);
 void pci_aer_unmask_internal_errors(struct pci_dev *dev);
 #else
@@ -75,6 +76,7 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
 static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
 #endif
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..39a386871bcb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1941,8 +1941,10 @@ static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
 
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

