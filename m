Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F64C2F90C5;
	Mon,  3 Aug 2026 22:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785795661; cv=fail; b=OnFWtFKntInYudIV4IOD81GLW4FtHOQ6Ogw6hoQBKQxMMSF8pbfQlNT/BDlgaw3ps8VuLQaqO7l9y8+YC2sP50VdAjKRffcfvl0fGMqO8WadQ8HFKYqQ4I00WwaL+zOSn1TfSEjYpjsgYfbkrCnK355OcCxhC+9kIGsAUHi0lVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785795661; c=relaxed/simple;
	bh=zj9X9tlhCcbUzCYnsoZoFokCNy2VA+tG0RIrT1jqVbc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGf0wJWKvuFjBQGkEmvl9Tf2qiW+y8IjglnCbVWehqVPgViHnRIxyw+IpEBnkgUq8vOKHFCu7OkJ1epnSRSX6LBHGfUeAun8FCOP+Cgxq+a2OSoOw6it6SMaevHFzsLBXbQvLFwYOs65GnUU0rkW8oZj0eARu3K8VW3XjFek3RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zL3mwmwc; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zL3mwmwc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbE6n94TsrWBs8IIRM27AGLPT73hsSW259Zz5BDttwZ5fw2qc5UObOFGm2oCN82ydNlF/525GqTQotl5ge8J9/n+2gfY9kGDOZVvQhp5oC1Af+am/01ujbBXknBc+IHjSCWanTqL4MRbgWeAq07zBlBWitPq8EpS5UKm/xTqmpiLU2CUCYuYW/cTK9HXHJgqmWL9DsX8F/oAKdlatBRKuFu37HFoXsssPwtW0WBuR0mLgx9oIM0ObwaS3AQnkEamawh+0efyetdLAhcmsqNazWm5byAZAYgBtzg119Zr5Fj1e5GmN325z9fRJxTpfLP8t42ubTADcOm6oYKjxCJo1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUIAGBEZj4PJkZsDnvADwdB6gTMOLdb9iiEvGBMzypA=;
 b=T//Tjm24xtcKD/N/yvFkts6bORSfFazUWQ/I/sJgoLspeY2fXyApYRaK75ddvEFJH/KsGukW3Nk6lBbiL33ZznYCRwCelCNGimHUkT370cjFh8L6SsFOcu004GQfFAO0bkm4QSc4vhh+A33W+1x+H9iDR1pVGrgq5IyT+wpRy5DE6qtLNDsdoJZvrIbtbX3iYePV2gHs7klK2bBtKs4stH7q2VXx8W87KjRXy3GKqStNDsxq+YDPbE8w4AUM9kuFk6qGk4ZtLaZcu5ke+NhGJu988G/2Dyhth+vVluW8UAgiUwAbxnmqfSlVDVCaqIM+JX34Pbi9/YY8h7PyF5LbkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUIAGBEZj4PJkZsDnvADwdB6gTMOLdb9iiEvGBMzypA=;
 b=zL3mwmwcB/Hg7pcfVMEs83m+Ua1tznE8Df9SGpGL0pzHljTgj/GIxd2iKNNQyP6LhQIV8ALx71R90xehH60JKWsNUzXspv/z5j5PvtValx6c7SEQAu+dgY1xRWJslYqeFX4OKTprokt//+4R/1KEj6P8jv01jTW3UAmCDJSJ6qY=
Received: from BLAP220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::31)
 by BN7PPF48E601ED5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ce) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 22:20:53 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::90) by BLAP220CA0026.outlook.office365.com
 (2603:10b6:208:32c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Mon, 3
 Aug 2026 22:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Mon, 3 Aug 2026 22:20:53 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 3 Aug
 2026 17:20:52 -0500
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
Subject: [PATCH v19 14/14] Documentation: cxl: Document CXL protocol error handling
Date: Mon, 3 Aug 2026 17:18:10 -0500
Message-ID: <20260803221810.3685703-15-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|BN7PPF48E601ED5:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3fee1d-f533-4de5-c559-08def1ad7b75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	bA7BUPWov29J76fMCh6u/lMRVWTnLF0GHTCi0kbgcm2HN/HDHU7G6Oe3sTNRY1canh2j73rVP4UcJwqEoQh6BJJUO4uMzMse1E5bxw3niLbiRaeEttWuqQk5iA1ceDi6PNswVLcrkdSK8oxD/ZugnsPb89vvTF8OXLtnGBfRMFmcL9vIfpkiFZWQwJ71P7+swTds7aPxMt6YlYV6LnRrmoQONxF29K2WykCdqhIeCzvZY5RJNrwxd1kEpXJH9U5KXtPHZ4jBPqfaKx3IUJCsCmZ+1zbw4nQk7P92e8CbXdqIrs1qEFhLKTgTpNuIh9SljLd/52A9+XV3MkXBz4YbsXkiA5AtqMQUN2NBgJkTLg1cZ+y1Rl1+jnWRVVufMt+R8pWjSYY/3SQ7pswQHle8NdgRkganvvyes0mdEeEI/Iu1Q4PFZEkRJGzc78sVblCaCNRqV5tGQQs1h1DjGjOap3AfV/R5emEPq0fFcEiTszQyVomhFTNt0ux37r8vE1AM/gxQh9eETxLuX8o+6OEvAPOq0H4JMI4mSzdGgilF3Pu7/niTKvmg9XLeIP2ARtid+IhKPRXSoadGe1sRoo5upzg+8Ebjnj6qOahRheBD46mQ51n2Mljt0QYaYa7YvzZeJO87DWwILUFQVQqhRSdiKpNrWOX8MxIrz3FbYPe8k0T3tDAJfovqJb3ppD/4jMeGc2mVJsd4oaIweqWP3F2/Fg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JLs/0WHCGfz+wo1S+6O2YuzH7jb6MAuL2GEkunq7qePf1L5afxbC5y32w8h+Po+a0Hvyw/vPbZ5dQ2l6itCEdz/qMHzNpGstE0GA3TtCAw5ir0Gu6OH1smk5TbWhHtgGXMru+qEI1E+Klom4kvEe7FtU3AaAvPrFXSWo0S/FMJU+rVvW/16sgglxhl3aWJvi6DxeCzOxdDaYquUc7UnAjH3ZVnQCXlvybO8R7SSNJwv8/HdfKGDbGKLjNTL2VWZSM796bA8LVXCB+gtelJwgrGsbWhpNSVMSFNlcGu7rT4Ggza5MyOIbLa+c5dCwFQLQA0azotZlxC9bbgW57gxYis6iIzPmDshlMtkp+JYAUMHtM2zmVPLfNwjGvkRl03uijV8jaA8Cq1sd48r2bV1s+rfCSUUtDz+4m0WvW1NtSMZJHbR8Oq5SW+IFJz0m7AyT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 22:20:53.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3fee1d-f533-4de5-c559-08def1ad7b75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF48E601ED5

Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
describing the end-to-end CXL protocol error path: AER ingress, the
AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
cases, severity policy, trace events, and a source code map.

This documents the architecture introduced by the preceding patches in
this series.

Assisted-by: Claude:claude-opus-4.9
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

---

Changes in v18->v19:
- Alignment fixes
- Add RC_END/RCiEP to diagram
- Wrap past 80 columns.
- Update cxl_forward_error() return-value behavior
- Add review-by for Jonathan Cameron
- Document the CPER/firmware-first flow (GHES + ext-log producers,
  CPER-CXL kfifo, trace-only consumer)
- Document the fatal EP/RCD UCE flow via the .error_detected
  (cxl_pci_error_detected) RAS path, including channel-state handling
- Add an "AER handlers vs RAS handlers" section clarifying the two
  handler layers and their relationship

Changes in v17->v18:
- Simplify document for readability (Jonathan)
- Drop historical context that goes stale (Jonathan)
- Shorten ASCII flow diagram (Jonathan)
- Drop manual backtick markup, use automarkup (Jonathan)
- Clarify USP/DSP as single switch component (Dave)
- Fix line wrapping to 80 chars (Jonathan)
---
 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/linux/protocol-error-handling.rst     | 401 ++++++++++++++++++
 2 files changed, 402 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/protocol-error-handling.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 3dfae1d310ca5..6861b2e5726a3 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -42,6 +42,7 @@ that have impacts on each other.  The docs here break up configurations steps.
    linux/dax-driver
    linux/memory-hotplug
    linux/access-coordinates
+   linux/protocol-error-handling
 
 .. toctree::
    :maxdepth: 2
diff --git a/Documentation/driver-api/cxl/linux/protocol-error-handling.rst b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
new file mode 100644
index 0000000000000..da598ec43b3b0
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
@@ -0,0 +1,401 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+CXL Protocol Error Handling
+==============================
+
+CXL devices report protocol-layer failures (CXL.cachemem RAS) as PCIe AER
+Internal Errors: PCI_ERR_COR_INTERNAL for correctable events and
+PCI_ERR_UNC_INTN for uncorrectable events. The actual fault information
+lives in CXL RAS capability registers, not in the PCIe AER status registers.
+
+The kernel routes every CXL Internal Error through a producer/consumer
+pipeline shared by all CXL device types: Root Ports, Upstream/Downstream
+Switch Ports, Endpoints, and Restricted CXL Devices (RCDs).
+
+Errors are delivered by one of two mechanisms. On native-AER platforms the
+kernel takes the AER interrupt and reads the CXL RAS registers itself. On
+firmware-first (CPER/GHES) platforms, platform firmware handles the error
+and hands the kernel a CPER record; that path is trace-only. Both converge
+on the same cxl_core RAS handlers.
+
+
+Architecture
+============
+
+Two error planes run side by side:
+
+* The **PCIe AER plane** handles native PCIe errors (receiver overflows,
+  malformed TLPs, completion timeouts, etc.). This includes CXL.io, which
+  is functionally PCIe and reports through native AER status registers.
+* The **CXL protocol error plane** handles CXL.cachemem (CXL.cache and
+  CXL.mem) protocol errors. These have no native AER status; they are
+  signaled as AER Internal Errors, with the fault detail held in the CXL
+  RAS capability registers. The AER core forwards them to cxl_core via a
+  dedicated kfifo; cxl_core reads the CXL RAS registers, emits trace
+  events, and applies recovery/panic policy.
+
+The boundary between the two planes is enforced by is_cxl_error() in
+aer_cxl_vh.c. It checks info->is_cxl, the PCIe device type (Endpoint,
+Root Port, Upstream, or Downstream), and whether the AER status word
+indicates an internal error. RC_END devices are excluded from
+is_cxl_error() because they reach the kfifo via the separate
+cxl_rch_handle_error() path instead.
+
+The pipeline:
+
+1. **Producer** (aer_cxl_vh.c, aer_cxl_rch.c) - AER threaded handler
+   context. Classifies and enqueues a struct cxl_proto_err_work_data
+   into the kfifo.
+2. **Queue** - the AER-CXL kfifo plus a backing work_struct.
+3. **Consumer** (cxl_core/ras.c) - workqueue context. Resolves the CXL
+   port topology and dispatches to CE/UE handlers.
+
+
+AER handlers vs RAS handlers
+============================
+
+Two distinct handler layers cooperate; keeping them separate is central to
+the design:
+
+* **AER handlers** run in PCIe AER context (aer.c, aer_cxl_vh.c,
+  aer_cxl_rch.c). They own the PCIe side: they observe the Internal Error,
+  classify it with is_cxl_error(), and act only as the *producer* - they
+  enqueue a work item into the AER-CXL kfifo. AER handlers never touch the
+  CXL RAS capability registers and never make a recovery/panic decision.
+
+* **RAS handlers** run in cxl_core (cxl_core/ras.c, cxl_core/ras_rch.c).
+  They are the *consumers*: they read the CXL RAS capability registers,
+  emit the CXL trace events, and apply the CE/UCE severity policy (clear
+  correctable status, or panic on an uncorrectable error). A RAS handler
+  is where the actual CXL fault information is decoded, because that
+  information lives in the RAS registers, not in the PCIe AER status word.
+
+The AER handler and the RAS handler are decoupled by the kfifo: the AER
+handler cannot block on RAS register access (which may sleep) and the RAS
+handler runs in workqueue context where it can safely take port locks. The
+same RAS handlers are reached through three different entry paths, and only
+the entry path differs - the RAS decode/policy is identical:
+
+* the AER-CXL kfifo consumer (native AER, VH and RCH),
+* the pci_error_handlers .error_detected callback (fatal EP/RCD UCE, where
+  no AER status is available), and
+* the CPER-CXL kfifo consumer (firmware-first CPER/GHES, trace-only).
+
+
+Topologies
+==========
+
+Virtual Hierarchy (VH)
+----------------------
+
+Standard PCIe topology: Root Port, optional switch (Upstream Port with one
+or more Downstream Ports), and Endpoints. Each component raises Internal
+Errors directly via the Root Port's AER interrupt.
+
+Producer: cxl_forward_error() in aer_cxl_vh.c.
+
+Restricted CXL Host (RCH)
+--------------------------
+
+A Root Complex Event Collector (RCEC) aggregates errors from RCDs attached
+as Root Complex Integrated Endpoints. The AER driver iterates RCDs beneath
+the RCEC via pcie_walk_rcec() and forwards each qualifying device through
+cxl_forward_error() into the same kfifo.
+
+Producer: cxl_forward_error() in aer_cxl_vh.c, called from
+cxl_rch_handle_error_iter() via pcie_walk_rcec().
+
+
+Error flow
+==========
+
+.. code-block:: text
+
+   CXL device raises AER Internal Error
+   (PCI_ERR_COR_INTERNAL or PCI_ERR_UNC_INTN)
+                   |
+                   v
+   +--------------------------------------+
+   | AER core (aer.c)                     |
+   |  aer_irq() -> aer_isr()              |
+   |  -> find_source_device()             |
+   |  -> handle_error_source(dev, info)   |
+   +--------------------------------------+
+                   |
+                   v
+   +--------------------------------------+
+   | handle_error_source() dispatch       |
+   |                                      |
+   |  1. cxl_rch_handle_error()           |
+   |     [always; filters internally.     |
+   |      RC_END enters the kfifo here    |
+   |      via pcie_walk_rcec(), NOT via   |
+   |      is_cxl_error() below]           |
+   |                                      |
+   |  2. if is_cxl_error():               |
+   |       cxl_forward_error()            |
+   |       [enqueue to kfifo; EP/RP/USP/  |
+   |        DSP only, RC_END excluded]    |
+   |                                      |
+   |  3. if cxl_pending && non-CE:        |
+   |       cxl_proto_err_wait_for_empty() |
+   |       [sync drain before recovery]   |
+   |                                      |
+   |  4. pci_aer_handle_error() [always]  |
+   +--------------------------------------+
+                   |
+          (kfifo -> workqueue)
+                   |
+                   v
+   +--------------------------------------+
+   | __cxl_proto_err_work_fn() consumer   |
+   |                                      |
+   |  if is_cxl_restricted(pdev):         |
+   |    cxl_handle_rdport_errors()        |
+   |    [RCH dport RAS first]             |
+   |                                      |
+   |  cxl_handle_proto_error()            |
+   +--------------------------------------+
+            |                |
+            v                v
+   +-----------------+  +--------------------+
+   | CE              |  | UCE                |
+   | cxl_handle_     |  | cxl_do_recovery()  |
+   |   cor_ras()     |  |  read RAS status   |
+   | trace + clear   |  |  trace + panic     |
+   +-----------------+  +--------------------+
+
+cxl_do_recovery() first checks whether the CXL RAS register block is
+mapped. If it is not (to_ras_base() returns NULL), the kernel panics
+immediately without reading any register or emitting a trace event,
+because a signaled UCE cannot be confirmed or cleared. Otherwise it
+reads the CXL RAS uncorrectable status register. If UE bits are set, it
+emits the trace event and panics. If no bits are set (e.g. RAS mapped but
+error already cleared), it logs a debug diagnostic and defers to AER
+recovery.
+
+
+Fatal UCE flow for Endpoints and RCDs
+=====================================
+
+For a fatal (AER_FATAL) uncorrectable error, aer_get_device_error_info()
+reads the AER uncorrectable status register only for Root Ports, RC Event
+Collectors, and Downstream Ports; it skips the read for Endpoints and
+Upstream Ports because their link is presumed down. With info->status left
+zero, is_cxl_error() cannot classify the event as a CXL protocol error, so
+it never enters the AER-CXL kfifo. This is a severity/device-type property,
+not an RCH-specific one: it affects every Endpoint (VH Endpoint and RCD
+alike) and every Upstream Port.
+
+Endpoints instead reach the RAS handler through the pci_error_handlers
+.error_detected callback (cxl_pci_error_detected()), which is registered by
+the CXL memdev driver and fires for both VH Endpoints and RCDs. The only
+RCD-specific step is the leading cxl_handle_rdport_errors() call, which
+processes the RCH Downstream Port's RAS registers first; the Endpoint RAS
+read and panic policy that follow are identical for VH and RCH:
+
+.. code-block:: text
+
+   Fatal UCE on Endpoint (VH Endpoint or RCD; link down, no AER status)
+                   |
+                   v
+   +--------------------------------------+
+   | PCIe core error recovery             |
+   |  pcie_do_recovery()                  |
+   |  -> report_error_detected()          |
+   |  -> cxl_pci_error_detected()         |
+   |     [pci_error_handlers callback in  |
+   |      cxl_core/ras.c; the RAS handler,|
+   |      NOT the AER kfifo path]         |
+   +--------------------------------------+
+                   |
+                   v
+   +--------------------------------------+
+   | cxl_pci_error_detected()             |
+   |                                      |
+   |  if is_cxl_restricted(pdev):         |
+   |    cxl_handle_rdport_errors()        |
+   |    [RCD-only: RCH Dport RAS first]   |
+   |                                      |
+   |  cxl_handle_ras(port, NULL,          |
+   |                 to_ras_base(...))    |
+   |    [unconditional EP RAS read;       |
+   |     dead link readl()==0xFFFFFFFF    |
+   |     sets all UE bits -> panic]       |
+   |                                      |
+   |  if ue: panic("CXL cachemem error")  |
+   |                                      |
+   |  else switch (channel state):        |
+   |    io_normal      -> CAN_RECOVER     |
+   |    io_frozen      -> release driver, |
+   |                      NEED_RESET      |
+   |    perm_failure   -> DISCONNECT      |
+   +--------------------------------------+
+
+This path handles both severities: a non-fatal EP UCE arrives as
+pci_channel_io_normal and a fatal EP UCE as pci_channel_io_frozen. Either
+way the CXL RAS read runs first, so a real CXL.mem UCE always panics; only
+when no CXL UE bit is set (or RAS is unmapped) does the channel state drive
+ordinary AER recovery. Endpoint unbind therefore does not depend on the
+AER-status-to-RAS coupling that the kfifo path relies on.
+
+Upstream Ports bound to portdrv have no such .error_detected callback and
+fall back to standard AER recovery - this is a known limitation.
+
+
+CPER / firmware-first flow
+==========================
+
+On firmware-first platforms, CXL protocol errors are delivered by platform
+firmware as an ACPI CPER record (CPER_SEC_CXL_PROT_ERR) instead of a native
+AER interrupt. These records already contain a snapshot of the CXL RAS
+capability registers, so the RAS handler does not read hardware; it only
+emits trace events. Firmware-first is therefore trace-only and never
+panics or drives recovery - the platform owns the recovery decision.
+
+CPER protocol-error records are delivered by the GHES/APEI firmware-first
+path:
+
+* **GHES/APEI** (ghes.c) - the common firmware-first path. Its producer,
+  cxl_cper_post_prot_err(), enqueues a struct cxl_cper_prot_err_work_data
+  into a dedicated CPER-CXL kfifo (cxl_cper_prot_err_fifo, depth 8) and
+  schedules the cxl_core consumer work item.
+
+.. code-block:: text
+
+   Platform firmware CPER record (CPER_SEC_CXL_PROT_ERR)
+            |
+            v
+   +----------------------+
+   | GHES/APEI (ghes.c)   |
+   |  ghes_do_proc()      |
+   |  cxl_cper_post_      |
+   |    prot_err()        |
+   |  kfifo_put(CPER-CXL) |
+   |  schedule_work()     |
+   +----------------------+
+            |
+            v
+   +----------------------+
+   | CPER-CXL kfifo       |
+   | + work_struct        |
+   +----------------------+
+            |
+            v
+   +----------------------+
+   | cxl_cper_prot_err_   |
+   |   work_fn() consumer |
+   | (cxl_core/ras.c)     |
+   |  drain kfifo ->      |
+   +----------------------+
+            |
+            v
+   +--------------------------------+
+   | cxl_cper_handle_prot_err()     |
+   |  pci_get_domain_bus_and_slot() |
+   |  find_cxl_port_by_dev()        |
+   |  cxl_find_dport_by_dev()       |
+   |                                |
+   |  if CE: trace correctable      |
+   |  else:  trace uncorrectable    |
+   |  [trace-only; no panic,        |
+   |   no cxl_do_recovery()]        |
+   +--------------------------------+
+
+The consumer work item is registered with GHES via
+cxl_cper_register_prot_err_work() when cxl_core loads and torn down with
+cxl_cper_unregister_prot_err_work(), which cancels any pending work and
+resets the kfifo so stale records are not replayed on the next module load.
+
+
+Severity policy
+===============
+
+**CE** - cxl_handle_cor_ras() reads the CXL RAS correctable status register,
+clears set bits, and emits a cxl_aer_correctable_error trace event. No
+recovery action.
+
+**UCE (non-fatal, and fatal on Root Port/Downstream Port)** -
+cxl_do_recovery() reads the CXL RAS uncorrectable status register. If UE
+bits are set, the kernel panics. If the CXL RAS register block is not
+mapped (to_ras_base() returns NULL), cxl_do_recovery() panics before any
+register read and emits no trace event, since the UCE cannot be confirmed.
+CXL.cachemem traffic cannot be safely recovered once an uncorrectable error
+is signaled; continuing risks silent data corruption. This panic policy
+applies to the native AER path. On firmware-first (CPER/GHES) platforms the
+CPER handler emits trace events only and does not call cxl_do_recovery().
+
+**Fatal UCE on EP/USP** - A fatal event brings the link down, so the AER
+core reads no AER status and is_cxl_error() cannot enqueue the event to the
+kfifo. Endpoints and RCDs are instead handled through the
+pci_error_handlers .error_detected callback (cxl_pci_error_detected()),
+which reads the CXL RAS registers unconditionally and panics on any UE bit.
+Upstream Ports bound to portdrv fall back to standard AER recovery - a known
+limitation. See "Fatal UCE flow for Endpoints and RCDs" above for the full
+path and channel-state handling.
+
+
+RCH special case
+================
+
+When the consumer sees is_cxl_restricted(pdev), it calls
+cxl_handle_rdport_errors() first to process the RCH Downstream Port's RAS
+registers (accessed via RCRB, not standard config space). It then
+continues to process the RCD Endpoint's own RAS registers via the common
+path. Both register blocks are checked because errors can appear in either
+independently.
+
+cxl_handle_rdport_errors() acquires the port lock internally. Callers must
+not hold it.
+
+
+Trace events
+============
+
+Two trace events cover all device types and both the native AER and
+CPER/GHES firmware-first paths:
+
+* cxl_aer_correctable_error
+* cxl_aer_uncorrectable_error
+
+Fields:
+
+* ``memdev`` - memdev name for Endpoints; empty for non-Endpoints.
+* ``port`` - CXL port device name.
+* ``dport`` - Downstream Port device name; empty when not applicable.
+* ``host`` - parent host bridge or uport device name.
+* ``serial`` - PCI Device Serial Number from pdev->dsn (cached at
+  enumeration; no config-space read in the error path).
+
+
+Interrupt masking
+=================
+
+CXL Internal Error bits (PCI_ERR_UNC_INTN and PCI_ERR_COR_INTERNAL) are
+unmasked in the AER capability only after the CXL RAS register block is
+successfully mapped. A devm teardown action restores the mask when the
+port or dport is removed, ensuring clean state after driver removal.
+
+
+Source files
+============
+
+.. list-table::
+   :header-rows: 1
+
+   * - File
+     - Role
+   * - drivers/pci/pcie/aer.c
+     - AER core; IRQ, dispatch
+   * - drivers/pci/pcie/aer_cxl_vh.c
+     - VH AER producer; AER-CXL kfifo
+   * - drivers/pci/pcie/aer_cxl_rch.c
+     - RCH AER dispatch; RCEC walk
+   * - drivers/cxl/core/ras.c
+     - RAS handlers; AER-CXL and CPER-CXL kfifo consumers;
+       .error_detected callback (cxl_pci_error_detected)
+   * - drivers/cxl/core/ras_rch.c
+     - RCH Downstream Port RAS handling
+   * - drivers/acpi/apei/ghes.c
+     - CPER/GHES producer; CPER-CXL kfifo
-- 
2.34.1

