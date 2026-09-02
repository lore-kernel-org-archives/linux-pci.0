Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160D49CF59;
	Wed,  2 Sep 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356417; cv=fail; b=nS+vSqQq+bBB4vhi9a9kVj/7RciyUWYp4AWuWLhppW4dbXWPP135XO6CO/GtezdNJqwbeO+2mpvE720YALBhiob1CfgwB7TjSHh4JQ8Kbqzp4SxpaKVYPggdDMsq4bg7FmrQQDRKN0V3VRJWK66LBcYq71UQHZ9eKTly3DkXL5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356417; c=relaxed/simple;
	bh=lZI+MvaPvEaFYl0vBM5w0ESmqITUEiWpee+Hzfe3mUk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWNJgIJcuaEvw60IPz6ujI0sWlepoixUjNJqjtIzpXael8MV3FWb78ZHtoIXfAVzdjEJc6SHAYuqCKdKN2s2wVMTTx783PMLyA34LSzDMcJGfemG8dLxRg51C0Dm6RHIRmATANmbiahc7cy/fakmbhr20VN5gV/hS7Qj/khfsqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DIDBkS5p; arc=fail smtp.client-ip=40.107.209.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DIDBkS5p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2zDc2YMlMj18BGQeu+/VTxsuEnsdp/KW2Z0pimheJrXJoHr8mkKzZPNGR+MnfY6u7/eQ0ZHw0AhiKAE7Tjb9+kR8dfovaNxSoE8afMvFU4yBxqs7gHyC0qTTVAN7snhsf/rPyh0GjsG0jBJqYmfI/u6FiI1wMCWGUlVwNGIg5FX/ClY0iWdXUcWWED4X5jDjnweNbgwp9pNopJWhnH1mwqciLvzeHsS8xYAjsgHH5GF7ulzALaiKr+LsiVZUIbEqrduMvqq1Z70Lc3b/BSgtBnUx1mLUwWH+qFC4GNH/1J9WkNFYi86KKrMl0veZHztSrf9VtBQ7JngZRMlyz+dtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGxhqRFe7ie6RHbJzxeoAMchr6RJhP7leB38KNQHmTs=;
 b=Sm7eZSXB+9Yl3I1hZStMLHAxmzbD9OjtpybtkOC5695mo/ffAj5VKQ+LY1QZeFCV6Q1r0ikKAYiRt730fTwrBpdga27tVAwM1nULXvrxGaKSh4kj4FK2bHw48hVgfemq+/3AhypadpM02mS6jfqegNQQ8gxgOoc/gAC9M2YeJSQOHAdQyfHyd9VGUWD9ioh/vpGDGHlIeHPl9pf6toSncK+c3PLDLpgmwgt+tFRXi9GK8NA0lcRe/xyWUUXudjDqpNebrYm1+5uRnZpEY1GpRO7aPKyNUYelmCu3TiVUmR/UNqWe8DwtZRLBXtf07ZQpGMewNAehMTRCuvpzemXuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGxhqRFe7ie6RHbJzxeoAMchr6RJhP7leB38KNQHmTs=;
 b=DIDBkS5pp0qELCj+sZLV6SPsI4Ou0itiEKk/NmWZeVNXAgGcgnMXqK6/Yg69Vq+yF4ilq1wWHRiRR/QmNDevC+oqgNgcPy83KKEzAKoTFEKkqV4mAEzKo9vszYtXJJPT+9TkvRQpomm73hHzSZyM2hoq8pv+8LnRUkpIYUezhxo=
Received: from SJ0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:a03:331::18)
 by DS6PR12MB312928.namprd12.prod.outlook.com (2603:10b6:8:532::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:40:03 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::a1) by SJ0PR03CA0073.outlook.office365.com
 (2603:10b6:a03:331::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:40:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:40:03 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:40:02 -0500
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
Subject: [PATCH v20 2/9] PCI: Establish common CXL Port protocol error flow
Date: Wed, 2 Sep 2026 08:39:26 -0500
Message-ID: <20260902133933.2992457-3-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|DS6PR12MB312928:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4ee997-042e-4097-d318-08df08f7b167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|7416014|82310400026|10067099003|6133799003|3023799007|18002099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	j/FN19PF3R7biwmpBf3FZWPp0mphGEFoGnaPXsH3mTOWrQVJi9ZgggSISiRKmOfFUh7OEMpNqp67eNUmN629TIkQdKUoLnnEp+As8nrPJRVSf1rHvyprq4mFRM9IVBCj7QK1KrrRifD5K1XL17l9rwDjHOVAO25/8Z8wUdKre55Pr+gJOe/BwdSjR+rtrzlbPTPvWQZlqtutgkxtRLo7pgBzZp8fL47Tly8/2wQvN7LPKCzuV0OuuDyKIBCb0nIyxNcqV0MLdjaDgaMD+vzq9pVLPCuu0n2H1MfNC2XfOiX1oYv70/mGZ2URDSBrjOVWshSq9H3yZEoxJkQ2xgCS46AIn+SGOhgzCXn5VlGpTpqQAtpwfOnXi/dT2qDOZxp0QTKOm8GqXjlwyUCjEIm2eA6lIwPQGbzgTGz9+OFKNn0SBvATfrJwhevfJ1F8fYjyqnkg5In1/8ZfMco9U8OSpG41+xZzewVJrvVsb2bO5VJKtbCzsaMxJO0o8vzWKluQYqcLwvzltf+U3IQXicfsAwIL2O2DngUd9elXJMxnzDYt5olLe+oHyDZPPWKelj5z/eNHgCx1axMnOoCV+XB5hmd/2h0kanQRW2XYypPbBWbYEOKJrow4qPKA1ElpCnFKGlpmSx8KYixkx0AoG3rWvgaXedAVQs+9Jjfe154PoFDyOfpbzVYLkuH3KcOs694yR5E/6LzjxDQk/VowljZscQxM1h5cAwHA6E4ysbgdeIeAXy6CehosNLTZ2lY6TxbE
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(7416014)(82310400026)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	evMrHFLiUPYNDMmVulYj5wlnunWwgN8xL0Fwt7IdOUrNT+JQj85vkytlNCve8qPTWn3aKRveaw7WLgDUmd41SGWjSsVCpIbddnJxJk8spWCYt1Tr+hyZJAsbgsQKktnLuncn0sPvcjC3pBvZWOaeSRXvc8t7WKbTlKPfHNJ8JjawSRt/UCwtdZzqqlQReOliE8gRGnMo4TCJqWIueCOnTToxCMOb2S0R3MyB/sBeXsQgWBk8PseVWgjdaUXBbIB3qZ+2vlCR1rO6dC31xAXH9xurKz+V4T3Q2BHVQMH+dTq8Ptgy7Kk2eYZnEg+FkERPaY88POFS6ruVMXWPtKo0NaI1rC4+fFz0sJj65wjN/ns25em0hpNO7SBBocOgZcMRZirxZWF57XicFbEPDO5dacTetqWHDqawI6W2c0FvD9J8TyWY53Li7lteRQJ2I5Mc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:40:03.4795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4ee997-042e-4097-d318-08df08f7b167
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB312928

Establish a single CXL protocol error path shared by CXL Virtual
Hierarchy (VH) and Restricted CXL Host (RCH) topologies. AER dispatch in
handle_error_source() routes CXL protocol errors, gated by
is_cxl_error(), through the AER-CXL kfifo to a cxl_core consumer for
logging and recovery. Producer and consumer go live together so no CXL
error is silently dropped across a bisect.

is_cxl_error() expands from Endpoint-only to also cover Root Port,
Upstream Port, and Downstream Port. RCDs report on behalf of an upstream
RCH Downstream Port and instead reach the kfifo via
cxl_rch_handle_error().

For uncorrectable errors, cxl_proto_err_wait_for_empty() drains the CXL
plane (RAS read, panic policy, state clear) before pci_aer_handle_error()
drives PCIe recovery, so recovery does not tear down RAS iomaps while the
consumer is still reading them. Correctable errors run asynchronously.

Panic policy: cxl_do_recovery() panics on a confirmed UCE, and also when
the RAS registers cannot be mapped -- an unconfirmable UCE is treated
conservatively as fatal since CXL.mem coherency may be lost. A
mapped-but-clear status is logged as spurious with no panic.

to_ras_base() centralizes RAS base lookup (dport->regs.ras for
Root/Downstream Ports, port->regs.ras otherwise) and provides an
injection point for RAS status simulation during testing. The
cxl_cor_error_detected() AER callback is removed; correctable Endpoint
errors now route through the kfifo like every other CXL protocol error.

Update cxl_handle_rdport_errors() with locking to prevent dport from
being freed and RAS from being unmapped.

At this step cxl_handle_rdport_errors() still dispatches a single
severity per pass (matching the pre-series baseline). The following
patch, "cxl/ras: Handle RCH correctable and uncorrectable errors in one
pass", processes a simultaneously signalled CE and UCE together.

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>

---

Changes in v19->v20:
- Condense commit message (Jonathan)
- Document simultaneous RCH CE+UCE handling in next patch
- Document the cxl_handle_rdport() dport lock

Changes in v18->v19:
- Merge "Establish common CXL Port protocol error flow" and "PCI/CXL: Add
  RCH support to CXL handlers" into a single patch; route RCD correctable
  errors through the AER-CXL kfifo and remove cxl_cor_error_detected().
- Rename cxl_proto_err_flush() to cxl_proto_err_wait_for_empty()
- Use guard(device) in __cxl_proto_err_work_fn() instead of scoped_guard
- Reword "silent data corruption" comment; drop "interleaved HDM
  regions"
- Add blank line after the port lookup in __cxl_proto_err_work_fn()
- Change cxl_do_recovery() to panic if to_ras_base() returns NULL
- Clarify Port driver bound gates RAS access
- Add review-by for DaveJ

Changes in v17->v18:
- Fix pre-existing race: hold memdev device lock around
  cxl_handle_rdport_errors(), release before port lock
- Fix handle_error_source() to call pci_aer_handle_error() unconditionally
  so AER handling always runs after cxl_forward_error()
- Add cxl_proto_err_flush() call for CXL UCE to drain kfifo before AER
  recovery tears down the device
- Fix NULL dereference of dport->dport_dev in cxl_handle_cor_ras() and
  cxl_handle_ras() for UPSTREAM/ENDPOINT port types: use dport->dport_dev
  when dport is non-NULL, else fall back to port->uport_dev
- Remove duplicate pcie_clear_device_status() call from
  cxl_handle_proto_error() CE path; pci_aer_handle_error() already clears it
- Clarify panic policy: panic only on confirmed UCE via RAS status read
- Document kfifo consumer serialization against driver unbind via
  guard(device)(&port->dev) and port->dev.driver check

Changes in v16->v17:
- get_cxl_port() -> find_cxl_port_by_dev()
- Simplified find_cxl_port_by_dev()
- Replace and remove cxl_serial_number() w/ pci_get_dsn()
- cxl_get_ras_base() -> to_ras_base()
- Drop dependency on PCI_ERS_RESULT_PANIC; cxl_do_recovery() panics
  directly. (PANIC enum patch dropped from series.)
- Clarify panic semantics: panic on any uncorrectable CXL RAS error, not
  only AER-FATAL severities.
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
 drivers/cxl/core/core.h        |  17 ++-
 drivers/cxl/core/port.c        |   6 +-
 drivers/cxl/core/ras.c         | 225 +++++++++++++++++++++++++--------
 drivers/cxl/core/ras_rch.c     |  22 +++-
 drivers/cxl/cxlpci.h           |   3 -
 drivers/cxl/pci.c              |   1 -
 drivers/pci/pci.h              |   1 -
 drivers/pci/pcie/aer.c         |  13 +-
 drivers/pci/pcie/aer_cxl_rch.c |  39 +++---
 drivers/pci/pcie/aer_cxl_vh.c  |  16 ++-
 drivers/pci/pcie/portdrv.h     |   4 +-
 11 files changed, 249 insertions(+), 98 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9c..645824167f788 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -188,10 +188,13 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
 void cxl_ras_init(void);
 void cxl_ras_exit(void);
 bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
+void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
+		     struct cxl_dport *dport);
 void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
 void cxl_dport_map_rch_aer(struct cxl_dport *dport);
 void cxl_disable_rch_root_ints(struct cxl_dport *dport);
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
+void cxl_handle_rdport_errors(struct pci_dev *pdev);
+void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport);
 void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
 #else
 static inline void cxl_ras_init(void) { }
@@ -200,14 +203,24 @@ static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 {
 	return false;
 }
+static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
+				   struct cxl_dport *dport) { }
 static inline void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base) { }
 static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
 static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
-static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
+static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
+static inline void __iomem *to_ras_base(struct cxl_port *port,
+					 struct cxl_dport *dport)
+{
+	return NULL;
+}
 static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
 #endif /* CONFIG_CXL_RAS */
 
 int cxl_gpf_port_setup(struct cxl_dport *dport);
+struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
+					struct cxl_dport **dport);
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev);
 
 struct cxl_hdm;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 625e4aa427db0..9a746be6f1967 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1400,8 +1400,8 @@ static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
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
@@ -1596,7 +1596,7 @@ static int match_port_by_uport(struct device *dev, const void *data)
  * Function takes a device reference on the port device. Caller should do a
  * put_device() when done.
  */
-static struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
+struct cxl_port *find_cxl_port_by_uport(struct device *uport_dev)
 {
 	struct device *dev;
 
diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
index e307361bb39e4..02c791f149270 100644
--- a/drivers/cxl/core/ras.c
+++ b/drivers/cxl/core/ras.c
@@ -77,6 +77,35 @@ static int match_memdev_by_parent(struct device *dev, const void *uport)
 	return 0;
 }
 
+/**
+ * find_cxl_port_by_dev - Use @dev as hint to do a _by_dport or _by_uport lookup
+ * @dev: generic device that may either be a companion of port or target dport
+ * @dport: optional output; if non-NULL, set to the matched dport for
+ * Root Port and Downstream Port lookups, NULL for all other types.
+ *
+ * Return a 'struct cxl_port' with an elevated reference if found. Use
+ * __free(put_cxl_port) to release.
+ */
+static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dport **dport)
+{
+	if (dport)
+		*dport = NULL;
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	switch (pci_pcie_type(to_pci_dev(dev))) {
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
 void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
 {
 	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
@@ -129,16 +158,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
 }
 static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
 
-void cxl_ras_init(void)
-{
-	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
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
@@ -195,6 +214,32 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_port_ras_setup, "CXL");
 
+void __iomem *to_ras_base(struct cxl_port *port, struct cxl_dport *dport)
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
+void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dport *dport)
+{
+	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
+	void __iomem *ras_base = to_ras_base(port, dport);
+
+	if (!ras_base)
+		panic("CXL: UCE with unmapped RAS registers");
+
+	if (cxl_handle_ras(dev, ras_base))
+		panic("CXL cachemem error");
+
+	dev_dbg(&pdev->dev,
+		"CXL UCE signaled but no CXL RAS status bits set\n");
+}
+
 void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 {
 	void __iomem *addr;
@@ -207,7 +252,10 @@ void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base)
 	status = readl(addr);
 	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
 		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
-		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		if (is_cxl_memdev(dev))
+			trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
+		else
+			trace_cxl_port_aer_correctable_error(dev, status);
 	}
 }
 
@@ -259,73 +307,61 @@ bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
 	}
 
 	header_log_copy(ras_base, hl);
-	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	if (is_cxl_memdev(dev))
+		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
+	else
+		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
+
 	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
 
 	return true;
 }
 
-void cxl_cor_error_detected(struct pci_dev *pdev)
-{
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlds->cxlmd->dev;
-
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
-			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
-			return;
-		}
-
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
-
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
-
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state)
 {
-	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
-	struct cxl_memdev *cxlmd = cxlds->cxlmd;
-	struct device *dev = &cxlmd->dev;
-	bool ue;
+	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
+	bool ue = false;
+
+	if (!port)
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	if (is_cxl_restricted(pdev))
+		cxl_handle_rdport_errors(pdev);
 
-	scoped_guard(device, dev) {
-		if (!dev->driver) {
+	scoped_guard(device, &port->dev) {
+		if (!port->dev.driver) {
 			dev_warn(&pdev->dev,
-				 "%s: memdev disabled, abort error handling\n",
-				 dev_name(dev));
+				 "%s: port disabled, abort error handling\n",
+				 dev_name(&port->dev));
 			return PCI_ERS_RESULT_DISCONNECT;
 		}
 
-		if (cxlds->rcd)
-			cxl_handle_rdport_errors(cxlds);
 		/*
-		 * A frozen channel indicates an impending reset which is fatal to
-		 * CXL.mem operation, and will likely crash the system. On the off
-		 * chance the situation is recoverable dump the status of the RAS
-		 * capability registers and bounce the active state of the memdev.
+		 * The CXL RAS read is unconditional regardless of channel
+		 * state. Any uncorrectable error bit set in the CXL RAS
+		 * status register triggers a panic below because CXL.mem
+		 * cache coherency is already lost; continuing risks silent
+		 * data corruption.
 		 */
-		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlmd->endpoint->regs.ras);
+		ue = cxl_handle_ras(port->uport_dev, to_ras_base(port, NULL));
 	}
 
+	/*
+	 * CXL.mem UCE means cache coherency is lost. Continuing risks
+	 * silent data corruption.
+	 */
+	if (ue)
+		panic("CXL cachemem error");
+
 	switch (state) {
 	case pci_channel_io_normal:
-		if (ue) {
-			device_release_driver(dev);
-			return PCI_ERS_RESULT_NEED_RESET;
-		}
 		return PCI_ERS_RESULT_CAN_RECOVER;
 	case pci_channel_io_frozen:
 		dev_warn(&pdev->dev,
 			 "%s: frozen state error detected, disable CXL.mem\n",
-			 dev_name(dev));
-		device_release_driver(dev);
+			 dev_name(port->uport_dev));
+		device_release_driver(port->uport_dev);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(&pdev->dev,
@@ -335,3 +371,82 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
+
+static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
+				   struct cxl_dport *dport, int severity)
+{
+	struct device *dev = dport ? dport->dport_dev : port->uport_dev;
+
+	if (severity == AER_CORRECTABLE)
+		cxl_handle_cor_ras(dev, to_ras_base(port, dport));
+	else
+		cxl_do_recovery(pdev, port, dport);
+}
+
+static void __cxl_proto_err_work_fn(struct cxl_proto_err_work_data *wd)
+{
+	struct cxl_dport *dport;
+	struct device *host;
+
+	/*
+	 * For RCD devices, handle RCH Downstream Port errors first.
+	 * cxl_handle_rdport_errors() does its own port lookup and locking,
+	 * keeping the Downstream Port lock separate from the Endpoint Port
+	 * lock taken below.
+	 */
+	if (is_cxl_restricted(wd->pdev))
+		cxl_handle_rdport_errors(wd->pdev);
+
+	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&wd->pdev->dev, NULL);
+	if (!port) {
+		dev_err_ratelimited(&wd->pdev->dev,
+				    "Failed to find parent port device in CXL topology\n");
+		return;
+	}
+
+	host = is_cxl_root(port) ? port->uport_dev : &port->dev;
+
+	guard(device)(host);
+	if (!host->driver) {
+		dev_err_ratelimited(host,
+				    "Port host device is unbound, abort error handling\n");
+		return;
+	}
+
+	dport = cxl_find_dport_by_dev(port, &wd->pdev->dev);
+	if (!dport && (pci_pcie_type(wd->pdev) == PCI_EXP_TYPE_ROOT_PORT ||
+		       pci_pcie_type(wd->pdev) == PCI_EXP_TYPE_DOWNSTREAM)) {
+		dev_err_ratelimited(&wd->pdev->dev,
+				    "Failed to find dport device in CXL topology\n");
+		return;
+	}
+
+	cxl_handle_proto_error(wd->pdev, port, dport, wd->severity);
+}
+
+static void cxl_proto_err_work_fn(struct work_struct *work)
+{
+	struct cxl_proto_err_work_data wd;
+
+	for_each_cxl_proto_err(&wd, __cxl_proto_err_work_fn);
+}
+
+static DECLARE_WORK(cxl_proto_err_work, cxl_proto_err_work_fn);
+
+static void cxl_proto_err_do_flush(void)
+{
+	flush_work(&cxl_proto_err_work);
+}
+
+void cxl_ras_init(void)
+{
+	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
+	cxl_register_proto_err_work(&cxl_proto_err_work,
+				   cxl_proto_err_do_flush);
+}
+
+void cxl_ras_exit(void)
+{
+	cxl_unregister_proto_err_work();
+	cxl_cper_unregister_prot_err_work();
+}
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index e0e01aa5eba6c..ddaa3d7781678 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2025 AMD Corporation. All rights reserved. */
 
-#include <linux/types.h>
 #include <linux/aer.h>
 #include "cxl.h"
 #include "core.h"
@@ -110,18 +109,27 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
 	return false;
 }
 
-void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
+void cxl_handle_rdport_errors(struct pci_dev *pdev)
 {
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
 	struct aer_capability_regs aer_regs;
 	struct cxl_dport *dport;
 	int severity;
 
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
+	struct cxl_port *port __free(put_cxl_port) = cxl_pci_find_port(pdev, NULL);
 	if (!port)
 		return;
 
+	/*
+	 * The RCH Downstream Port is the Root Port's dport
+	 * (dport free and RAS iomap) is hosted on the CXL Host Bridge
+	 * (port->uport_dev), not &port->dev. Hold that device's lock so the
+	 * dport cannot be freed and its registers unmapped while in use here.
+	 */
+	guard(device)(port->uport_dev);
+	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
+	if (!dport)
+		return;
+
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
 
@@ -130,7 +138,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_cor_ras(dport->dport_dev, to_ras_base(port, dport));
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_do_recovery(pdev, dport->port, dport);
 }
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 110ec9c44f09f..606fadd2476f3 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -79,14 +79,11 @@ struct cxl_dev_state;
 void read_cdat_data(struct cxl_port *port);
 
 #ifdef CONFIG_CXL_RAS
-void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
 void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
 void devm_cxl_port_ras_setup(struct cxl_port *port);
 #else
-static inline void cxl_cor_error_detected(struct pci_dev *pdev) { }
-
 static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 						  pci_channel_state_t state)
 {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c7c91e8dc51dc..fe11be7fd9aab 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1002,7 +1002,6 @@ static const struct pci_error_handlers cxl_error_handlers = {
 	.error_detected	= cxl_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ba3c3fddddc23..6c7decfb171b0 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1344,7 +1344,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 21dfc9c933d77..8c998cffa89e4 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1328,7 +1328,18 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
-	cxl_rch_handle_error(dev, info);
+	bool cxl_pending = cxl_rch_handle_error(dev, info);
+
+	if (is_cxl_error(dev, info))
+		cxl_pending |= cxl_forward_error(dev, info);
+
+	/*
+	 * Wait for UCE CXL work to complete before AER recovery
+	 * tears down the device. CE can run asynchronously.
+	 */
+	if (cxl_pending && info->severity != AER_CORRECTABLE)
+		cxl_proto_err_wait_for_empty();
+
 	pci_aer_handle_error(dev, info);
 	pci_dev_put(dev);
 }
diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index e471eefec9c40..ab31c4281b483 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -34,42 +34,37 @@ static bool cxl_error_is_native(struct pci_dev *dev)
 	return (pcie_ports_native || host->native_aer);
 }
 
+struct cxl_rch_error_ctx {
+	struct aer_err_info *info;
+	bool enqueued;
+};
+
 static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
 {
-	struct aer_err_info *info = (struct aer_err_info *)data;
-	const struct pci_error_handlers *err_handler;
+	struct cxl_rch_error_ctx *ctx = data;
 
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
+	if (cxl_forward_error(dev, ctx->info))
+		ctx->enqueued = true;
 	return 0;
 }
 
-void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
+bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 {
+	struct cxl_rch_error_ctx ctx = { .info = info };
+
 	/*
-	 * Internal errors of an RCEC indicate an AER error in an
-	 * RCH's downstream port. Check and handle them in the CXL.mem
-	 * device driver.
+	 * An RCEC AER internal error indicates an error in an
+	 * associated RCH Downstream Port or RCD device or both.
+	 * Forward to the cxl_core module for handling.
 	 */
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
 	    is_aer_internal_error(info))
-		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
+		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, &ctx);
+
+	return ctx.enqueued;
 }
 
 static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
diff --git a/drivers/pci/pcie/aer_cxl_vh.c b/drivers/pci/pcie/aer_cxl_vh.c
index 9fc12d4e644bc..d04296c01e446 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -54,8 +54,22 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
 	if (!info || !info->is_cxl)
 		return false;
 
-	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT)
+	/*
+	 * RCD (PCI_EXP_TYPE_RC_END) is not included here because RCDs
+	 * report errors on behalf of upstream RCH Downstream Port and thus
+	 * require a unique discovery detailed in CXL4.0 spec (12.2.1.1).
+	 * The RCH device error discovery and RCD forwarding flow begins
+	 * in cxl_rch_handle_error().
+	 */
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
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 357310916088f..b13b9ac9571dc 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -128,14 +128,14 @@ struct aer_err_info;
 
 #ifdef CONFIG_CXL_RAS
 bool is_aer_internal_error(struct aer_err_info *info);
-void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
+bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info);
 void cxl_rch_enable_rcec(struct pci_dev *rcec);
 bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
 bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
 void cxl_proto_err_wait_for_empty(void);
 #else
 static inline bool is_aer_internal_error(struct aer_err_info *info) { return false; }
-static inline void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { }
+static inline bool cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info) { return false; }
 static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
 static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
 static inline bool cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
-- 
2.34.1

