Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887AB345EA9;
	Mon,  3 Aug 2026 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795585; cv=fail; b=NrSdgRIhmkcVhaPgcGI20heY+ewxQbQ86lzsdIfRhTt6SQZAYakLd0G67hzy7jUPMjbMzg4LRbd1Ia86xfOysXW8uj6t8j5cSndik5cC8VXpNwK+AtRMO80qL1csCZ65vx6h0BNJqlqFA5226O62+GIyge4q7pSYiY7PXhfIvQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795585; c=relaxed/simple;
	bh=BmMGu4AvBqgaL72H7H8G/3zpYT4Z5gtbI7h/HFQ1DhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlpwKrfhVHZNdRMsFYflAmUhhJt4CmtYHktEIwCs871KN0+wGYDx24uHVTgzehU7wunkEoMPOVP0D3YfenlZFy44ntWGhwQGSUrWIdRHh9+EMRLerhCos53O7gMHHWt8MiLozgzvkmkN/Y2Y1tOcNZ0CCbfE5jGkdpl+zMQzgtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hqGbYTSW; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hqGbYTSW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NRlN31K5p4KTaBvtj1Bd4Pj7pcAv24ayKkD1hwWwBx4xM0O00GxQf+34YV5aEm0P1mn8xNJjek5wNc/0L6JEnGUNblPLoPnIs/yD/QdjM3fK3CZZUOoYJvXUBlpsLUrBELXAPkbpSOOvsmBi12FiAjJ5gjhULAx24goRTK5KGTGUBz4Si3QPIPvh1S3KAEVG2+vNA9UNsDyS5WhMQ1b2tH6/EBPXvRNJfP5t0lmdDjp7Af3mGs++o87jjZOX4kZod5rm0O6R1aL3GrGAoU3b3njKsoysnFhtL9N057v8hO3miY1qomaLcWyHrUJDpJgtHgaNt605utuTZuiwHl9AMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3Qgrw4OKOFRZjzGa+HGRXhhKDXm/GgAmM/9sWmiMIc=;
 b=V57klBREmz3bdO/pLjDdSELAIhDJI7f+C0OSMdEU5lC/ouzDWg+bd/AcMsmnqy8f6Yh0xyREZysl8PFEiruMVWL3uceoklTxir+LqYUIE4qL9Yy3sRQcifRXArxtSjTZ8O6AZSgzFlQ7nUQuxFNrxPuaqrUickVV+Qyt1NhJtLIYg8632qUp19c9s6R4hdf0z+cn13JasA1x2yJi5L4j3ZInXx+mvqO+d0ydSIgexcYdrZm5vdMRANgKo/xmzbrqAZvrdwNftTBcXjvpJSV7dwTqYuHJXkCpPNFCRmBajpig693U4n2Zq5Mv9w4Didreu3bYutfW6XXsBEJoeBMFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3Qgrw4OKOFRZjzGa+HGRXhhKDXm/GgAmM/9sWmiMIc=;
 b=hqGbYTSW9XvZfnYGzaD2+ZjfkDDqWWQq0CGqcjx+JSF5YBXDNa0g7MFhLkVVAZeFYn3MKyhXtvw10xOjyiWWjWyrdz8AFRyTubmkNEZEZa6PxEQfpmsVIy60aMGm3+uRYhUfuXh8GA2trwVZLgG8CKK8hqsAJu1X6Vg2cLbAHQc=
Received: from BLAPR03CA0154.namprd03.prod.outlook.com (2603:10b6:208:32f::28)
 by CY3PR12MB9605.namprd12.prod.outlook.com (2603:10b6:930:103::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:19:35 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::38) by BLAPR03CA0154.outlook.office365.com
 (2603:10b6:208:32f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Mon, 3
 Aug 2026 22:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:19:35 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:19:34 -0500
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
Subject: [PATCH v19 07/14] PCI: Establish common CXL Port protocol error flow
Date: Mon, 3 Aug 2026 17:18:03 -0500
Message-ID: <20260803221810.3685703-8-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CY3PR12MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: 582d222f-345f-4339-0ac7-08def1ad4cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|23010399003|18002099003|22082099003|11063799006|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	a4g5BzZAxsUXin1OfKu4W5kaeBh7Y5FR5kugWKjCyYezN82ka7FE89nt942jg4pVDHOioPeUSmgZnUUBiWriI4LpgrIjXlRfIdnEqcM4VDQ1g92lyEgiBlZ/30BKFYAB6AvPuCz5wFMWolJLDup1entqxcNEWd/ERViGLQ/YpWcI64/v4c1rRZLXISgT6C8DdkXprAO8h6+KS2LKvBI3Pvd0LlCgE10pleB9OoiDcFMHqLL56avR6Ft2C+rxvR8DR8K6uoOX16GWSEpaiFfvery1YpO4R0ZYblID2I7dJ/1MNVNOO1tDWw5IovLStuYuAWQNo7dSRprSAGoPbj4NPIFZUe54nt889EwDsKUL8OmnFliJZgUkDZ8DcP3x7sBuN2v1uSoABqCGS90mZ6rpa07PHvDU+JTgfhpVmE3yIEhqWKwYdawVWfbt9uVp3oyGCzR6vwDTDaX3Muzl0MVCx2ZSHxT0gyXr1lHwvYk0luvtapl3/YX9VEBmPRPUx5+7taYIloAeNZT5FsfDIojwZ6FWc8Vx07eyHPrbAk302TS0RN9fWeRRM7Y703ScPpyxrqxjKNUNEmU5LDx5NwiBiIE8ZvxdGqOGd+L6MGuo1qpNOdcpqOVWrIqmykRLPBfp9oi05Zadim1FkA6uHIyozLt+aXmgRk2wbcfCSz0k3FUqF+037Ev7Of0h0vLLProrWD+xsq5yf/yhFxRQ9IxNmw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JgjHWDMspyvg/2K+aqYO/CSVA15qQLMLY+YAf95aX/EJVqFVkAYDI1CxgCSV+A7OLDRGwla4JtyBjLQN4NEIcGnJ1jahksD3epAEePvdgbuvYlG2qzdDhY/zhwa2ksBpOTm37ta9H01/Q/XfdbK3+UUuMQWViu83va8qZ6BwtCVKl0rt+WsezKn1z7bfVVfbP+BjwGSgNwHbCbRu7UHS+vBNwt4xLPzd8THGT3+XCzWkuE6J0Sx3hZoFxWNZxSPESB7w34mTSthXAKKioba84jjgA1ujjUsLUAvYnmS+JCOFTPCb1Jse/1/xY2Jq0ztnH/BbqPlogGlYvqqQ2VDwr3wnHqWl+LUPg3t/QHPy4+Dac/zz8IZeQyncvXC8hYWOtoVGmW9ygQt1GpzMvDHLRDh7kjl8sbQOL5ZXXgLUf4L5yAG7rOSlf2Q9P44fsneQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:19:35.4084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 582d222f-345f-4339-0ac7-08def1ad4cdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605

Establish a single CXL protocol error path shared by both CXL Virtual
Hierarchy (VH) and Restricted CXL Host (RCH) topologies. AER dispatch in
handle_error_source() uses is_cxl_error() and cxl_forward_error() to route
CXL protocol errors through the AER-CXL kfifo to a cxl_core consumer for
logging and recovery. The producer and consumer go live together so CXL
errors are never silently dropped across a bisect.

Expand is_cxl_error() from Endpoint-only to also cover Root Port, Upstream
Port, and Downstream Port. RCDs (PCI_EXP_TYPE_RC_END) are intentionally
excluded here: they report on behalf of an upstream RCH Downstream Port and
reach the kfifo via cxl_rch_handle_error() instead. cxl_rch_handle_error()
forwards RCH protocol errors through the same kfifo and returns bool so
handle_error_source() knows whether to wait for the consumer before AER
recovery proceeds.

For uncorrectable events, call cxl_proto_err_wait_for_empty() so the CXL
RAS registers are read, the panic policy is applied, and CXL state is
cleared before pci_aer_handle_error() drives PCIe recovery. Without it, AER
recovery can tear down drivers and unmap the CXL RAS iomaps while the
consumer is still reading them. Correctable events do not need the wait and
run asynchronously.

Add cxl_handle_proto_error() to dispatch CE and UCE events to the CXL RAS
helpers, and cxl_do_recovery() for UCE recovery. Panic on a confirmed UCE,
or when the RAS registers cannot be mapped (to_ras_base() returns NULL): an
unmappable UCE cannot be confirmed and is conservatively treated as fatal
because CXL.mem cache coherency may be lost. If the RAS registers are mapped
but report no uncorrectable status, the UCE is logged and treated as
spurious (no panic).

The kfifo consumer (__cxl_proto_err_work_fn) holds the Port device lock and
skips handling when the Port driver is unbound, so RAS register iomaps are
not torn down while the handler reads them. For RCDs it first calls
cxl_handle_rdport_errors(), which does its own RCH Downstream Port lookup
and locking, keeping the Downstream Port lock separate from the Endpoint
Port lock.

Add to_ras_base() to centralize RAS base lookup: dport->regs.ras for
Root/Downstream Ports, port->regs.ras for Upstream Ports and Endpoints.
Routing all RAS access through it also provides an injection point for CXL
RAS status simulation during testing.

cxl_handle_rdport_errors() takes a struct pci_dev * and resolves the RCH
Downstream Port under the owning port's device lock. The former
cxl_cor_error_detected() AER callback and its .cor_error_detected
registration are removed; correctable Endpoint errors now route through the
kfifo like every other CXL protocol error.

Co-developed-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

---

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
 drivers/cxl/core/ras.c         | 222 +++++++++++++++++++++++++--------
 drivers/cxl/core/ras_rch.c     |  16 +--
 drivers/cxl/cxlpci.h           |   3 -
 drivers/cxl/pci.c              |   1 -
 drivers/pci/pci.h              |   1 -
 drivers/pci/pcie/aer.c         |  13 +-
 drivers/pci/pcie/aer_cxl_rch.c |  39 +++---
 drivers/pci/pcie/aer_cxl_vh.c  |  16 ++-
 drivers/pci/pcie/portdrv.h     |   4 +-
 11 files changed, 240 insertions(+), 98 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 23fe40ddf4c6b..272634ff2615b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -186,10 +186,13 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
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
@@ -198,14 +201,24 @@ static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
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
index cadb51f70f854..a76f3ee05cba8 100644
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
index e307361bb39e4..83df544e5a656 100644
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
@@ -335,3 +371,79 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
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
+	guard(device)(&port->dev);
+	if (!port->dev.driver) {
+		dev_err_ratelimited(&port->dev,
+				    "Port device is unbound, abort error handling\n");
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
index e0e01aa5eba6c..41959c0333711 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2025 AMD Corporation. All rights reserved. */
 
-#include <linux/types.h>
 #include <linux/aer.h>
 #include "cxl.h"
 #include "core.h"
@@ -110,18 +109,21 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
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
 
+	guard(device)(&port->dev);
+	dport = cxl_find_dport_by_dev(port, pdev->dev.parent);
+	if (!dport)
+		return;
+
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
 
@@ -130,7 +132,7 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 
 	pci_print_aer(pdev, severity, &aer_regs);
 	if (severity == AER_CORRECTABLE)
-		cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_handle_cor_ras(&pdev->dev, to_ras_base(port, dport));
 	else
-		cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
+		cxl_do_recovery(pdev, dport->port, dport);
 }
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index b826eb53cf7ba..06c46adcf0f6c 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -89,14 +89,11 @@ struct cxl_dev_state;
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
index 7c6faee7f85ed..5c21db36073fe 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -1004,7 +1004,6 @@ static const struct pci_error_handlers cxl_error_handlers = {
 	.error_detected	= cxl_error_detected,
 	.slot_reset	= cxl_slot_reset,
 	.resume		= cxl_error_resume,
-	.cor_error_detected	= cxl_cor_error_detected,
 	.reset_done	= cxl_reset_done,
 };
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c1..a83e2aef75912 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1296,7 +1296,6 @@ void pci_restore_aer_state(struct pci_dev *dev);
 static inline void pci_no_aer(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
-static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
 static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
 static inline void pci_save_aer_state(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c5bce25df51cb..0155f3923c1fd 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1185,7 +1185,18 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 
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
index cd921ade1a38f..2edfa69d8a5be 100644
--- a/drivers/pci/pcie/aer_cxl_vh.c
+++ b/drivers/pci/pcie/aer_cxl_vh.c
@@ -51,8 +51,22 @@ bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
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

