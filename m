Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F52495051;
	Wed,  2 Sep 2026 13:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356522; cv=fail; b=klobn1TnAPupp8W7oiTvELh0F2nwbQ3+6tltw8KN6fHdjHt0eA+KyVanjHCTtZP93c4C+A1edrxoUFB648nfiLPQqwwKOEXbIDOK+1/fkQIhCNlcVtbNSYXC1K7EGgK/kiRy4qZsh+C+wEsE5S36jREqhaAbq7/clY2XVQPsHkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356522; c=relaxed/simple;
	bh=Xc0go6bp3IW65nIwgZbiqkID3Ed/pSq5+unqrmHjG2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QogSAqHfOe1erjmkevaoDDzX7fkPSOB8/nV9mck5Khq135M0ciO36CJxCTyUsYL5hf/qoRBoyeMW4YOxE7wvRRa9lOSdy0On60S2cCPMkBoUyBIdrQaJjeTdcJ3cv7TSERh8mZJeMGbX8LyGdE6y5nOI31+EBf22lSOVBWn7qvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kLUMl8eP; arc=fail smtp.client-ip=52.101.62.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kLUMl8eP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HH1KAL31ZiTSe7DiM+DhL1J2SQaFxim7eoJbDKlPG9fK5SkfhL3wN5mZNkiIG9EN1B8aKugZR9hCQeffqTfheJM3/rTb3PxFHr9XGr/FsWp6MQv5OWqpVhEzQGqM1hPOomdy//CAEflxoJ0p8KgiqmNsS2pd2/9qGHQCKcHn4ewcmpDoCtfhrtqpJu6E9DswdUh5qwKMQveNBC5vGd3TGnkQcv15sza6ravk+RRA+mVxNst0VUzu8d8jG8GAOqg87BI9SDSs69KbCpnLaj44MZFvCKPmXrPYz6lUtbWjZvyRoPKjTB5UmgucbU893ALnfJV+Hr8cKZF2NgZ6tUsrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gGV35TzI2IX8yyudghxEcHPGGRW+9KX9XzCTfjVV7Q=;
 b=eFoKuNFPPEV3um6nrDL0LDunpMEMIoTpOL/N5b0M4vGhlGtj/02njuiaTMi3l+IsTNpfxHkGHzjvxsZ8Zf+vyn54ULsziZ3PxzeSbtNeEqkWmMQp3Bt4cmRp2EyVsgbeamWZ9r31NzddTZpTqmhoLReWDUgkhaN7WOCB7wJHUS7BddNg/sZ2q/W83j2SpMkTyCdMVJjbDeVX2IGp9SLTN6IAVOxrBe7AzivdIpaClDhlQrXOcomU4UA+/kgQaz2vJqCAtIFIQyqW98zcZR3uSdRRUU1orIaBuG8JeR2GsfsdCSgjUAyxNvF5w9odmzvDSdih9tXQidsY/zEF2n2Ceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gGV35TzI2IX8yyudghxEcHPGGRW+9KX9XzCTfjVV7Q=;
 b=kLUMl8ePXO+X/9XphMQA6UbWPWoBzARadt3WMOtmv4wJefUtHXc3SPqMzMojqad/9JW7Os5Oh5yJ+WPgZY2WcgZWY/KA/gEohb5Auo3Yj/6QxRH++8etrTBofTwbwImOrrD85CU8o7ChqYtBbNOsZEpPtL479brTZvEz/pG8MRc=
Received: from SJ0PR03CA0271.namprd03.prod.outlook.com (2603:10b6:a03:39e::6)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 13:41:55 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::80) by SJ0PR03CA0271.outlook.office365.com
 (2603:10b6:a03:39e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 13:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 13:41:53 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 08:41:26 -0500
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
Subject: [PATCH v20 9/9] Documentation: cxl: Document CXL protocol error handling
Date: Wed, 2 Sep 2026 08:39:33 -0500
Message-ID: <20260902133933.2992457-10-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: a12354dc-2a31-43b9-04d6-08df08f7f32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|18002099003|22082099003|56012099006|3023799007|10067099003|6133799003|921020|11063799006;
X-Microsoft-Antispam-Message-Info:
	zxFHku2pX6yfe57MAK2c60NbUWdm6TTzbY0CcKbYzAb5LAB/VrxMmmp97gE86Tr+8Rxxn6FJLP8CgfutTCI0Tuut2vfofbjXg0E/fadE+7SWYBQ41nT8UrtTJiKvMWm7W8CRmtnxEHjnPPbjQbOhaahVai/zEe3WugnlUrnttk+VBinzGhUolzqyQUz0Bit/m4L0oIW6a0Ee5+3GcOVoj2zhK1OSbEDoASU6OVJf2BtpTGwI2bQuB/VgKxk+pfHQ5LQm98f8hIQSLOkmpAGgRWeTDdhjGeF4OH3F564HhilNS4GBtA/0oDBIurnswsKv9U74zDDPNiBK8IIN4UtH4D50ZGimtbZTQKO4/NiS0emhCAaZsq4EJqVSnMrPKm85luWH7QoL+lJSrwQ89uRttQsfWenB/Njmiau1xPWFfp+nMe48/r1r0ewbPcbyj8vV0URKMjQlNqsBWqcWnq41NpA8wRkBAZyU2OVhqZuWVXPrMbDTxM/B6DyIqeW1cGwl1jlRxFBo9ScW+E01hR70v9zesbUBkikFFFLe78lB660Zg+2Adi1YARhqRjSD9CoQjQxrI+A289S1Z4+4OGGsQmSb1ZCV6yhfJZ090njH9jL/TX3Bjc/qE7i51fkbgsc3XlGTJyuFUXOCJI+r7ArY+wuVPYmwicNBXzHP1j3QIT4ADycekCmFDl+npIqR93dlr6tnEENcv6xv9weVAIPFiV0LLh7dpSRnRN6v1Oq9+rseObtW069coIoCpVIWRowo
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003)(6133799003)(921020)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0VYbiFQGkAbgu8I6vbw/3AuOAaNTbl1NwzBFVog38vpfmeOZh1LC1LtZHvqIsmVzdVQldRc166ip6OMkdNwuzKs1AHq+cbE5xXGEmhxuBToOgxKiqvB5NZxpQvYTii7zsHEBWcVfiuaMOoC3zNRnKmBqpoN05Koz/2p+fmtswwSB/lipo3cbf+Ht7hRv21XKiA2YMABqvQSMIfYhVWFk019HOXfFHyG5feUAtXHJwX69jwcmZixAWYPJ/NMIFhnsfrEYumI+cDOeR/n2J6lzE3fykwMngfJxX/ze8xpQ+mycreqsTfPGSVKXCDHcUxyP1INyTSPkLux39J3b18N34+LmzuBsrR07UJAMHYP9g8xa62tuLkajK2MKiUx50LBVLZ+WCAORoaCmtuTinRWVk5/oLwim1Lhci2sS4OQeOoe3mBTT/lQfcFKeuAEVycT7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 13:41:53.8415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a12354dc-2a31-43b9-04d6-08df08f7f32d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
describing the end-to-end CXL protocol error path: AER ingress, the
AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
cases, severity policy, trace events, and a source code map.

This documents the architecture introduced by the preceding patches in
this series.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

---

Changes in v19 -> v20:
- Document the kfifo-overflow panic policy
- Name the CXL Host Bridge device lock (port->uport_dev) in RCH case
- Reword the cxl_do_recovery() no-UE-bits path
- Fix CPER path description: firmware-first is trace-only, no panic
- Diagram: EP RAS read is channel-state independent, not "unconditional"
- Fix cxl_handle_ras() argument count in the fatal-UCE diagram
- Clarify .error_detected skips RAS read without panic when unmapped

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
 .../cxl/linux/protocol-error-handling.rst     | 441 ++++++++++++++++++
 2 files changed, 442 insertions(+)
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
index 0000000000000..1da71d0409a05
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
@@ -0,0 +1,441 @@
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
+  CXL RAS capability registers and, in the normal path, make no
+  recovery/panic decision. The one exception is kfifo overflow: if the
+  AER-CXL kfifo is full, cxl_forward_error() drops a correctable error but
+  panics on a non-correctable one, since a dropped uncorrectable protocol
+  error can no longer be confirmed via CXL RAS (see "Severity policy").
+
+* **RAS handlers** run in cxl_core (cxl_core/ras.c, cxl_core/ras_rch.c).
+  They are the *consumers*: they read the CXL RAS capability registers,
+  emit the CXL trace events, and apply the CE/UCE severity policy (clear
+  correctable status, or panic on an uncorrectable error). A RAS handler
+  is where the actual CXL fault information is decoded, because that
+  information lives in the RAS registers, not in the PCIe AER status word.
+
+The AER handler and the RAS handler are decoupled by the kfifo: the AER
+handler cannot acquire the sleeping port device lock, and the RAS handler
+runs in workqueue context where it can safely take port locks. The
+same RAS decode is reached through three different entry paths:
+
+* the AER-CXL kfifo consumer (native AER, VH and RCH),
+* the pci_error_handlers .error_detected callback (fatal EP/RCD UCE, where
+  no AER status is available), and
+* the CPER-CXL kfifo consumer (firmware-first CPER/GHES, trace-only).
+
+The first two paths share the same decode and severity policy (read the
+RAS registers, clear correctable status, panic on an uncorrectable error).
+They differ only when the RAS registers are unmapped: the AER kfifo path
+reaches cxl_do_recovery() only after a CXL internal error is confirmed and
+so panics on an unmapped RAS block, while the .error_detected path has no
+such prior confirmation and instead skips the read without panicking.
+The CPER path differs: it is firmware-first and trace-only - it emits the
+CXL trace events but does not call cxl_do_recovery() and never panics (see
+the "CPER / firmware-first flow" and "Severity policy" sections below).
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
+error already cleared), it logs a debug diagnostic and returns without
+action, allowing the caller to proceed with normal AER recovery.
+
+The consumer reaches cxl_handle_proto_error() only after the topology
+lookups succeed: it returns early (dropping the event) if the parent port
+is not found, if the port host device is unbound, or if the dport is not
+found for a Root Port or Downstream Port. A UCE enqueued to the kfifo can
+therefore be discarded without a panic if the topology is torn down or not
+yet registered between enqueue and consumer execution.
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
+   |  if port->dev.driver == NULL:        |
+   |    return DISCONNECT [port unbound]  |
+   |                                      |
+   |  cxl_handle_ras(port, NULL,          |
+   |                 to_ras_base(...),    |
+   |                 pdev->dsn)           |
+   |    [EP RAS read, independent of      |
+   |     channel state (not skipped for   |
+   |     io_normal); dead link            |
+   |     readl()==0xFFFFFFFF sets all UE  |
+   |     bits -> panic]                   |
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
+**kfifo overflow** - if the AER-CXL kfifo is full when the producer
+(cxl_forward_error()) tries to enqueue, a correctable error is dropped with
+a ratelimited log message, but a non-correctable error triggers an
+immediate panic() from the AER handler itself. A dropped uncorrectable
+protocol error can no longer be confirmed or recovered via CXL RAS and may
+signal lost cache coherency over HDM memory in active use, so it is
+collapsed to the same conservative outcome as a confirmed UCE. This is the
+only case where an AER handler, rather than a RAS handler, makes the panic
+decision.
+
+**Fatal UCE on EP/USP** - A fatal event brings the link down, so the AER
+core reads no AER status and is_cxl_error() cannot enqueue the event to the
+kfifo. Endpoints and RCDs are instead handled through the
+pci_error_handlers .error_detected callback (cxl_pci_error_detected()),
+which reads the CXL RAS registers when they are mapped and panics on any UE
+bit. If the RAS registers are unmapped the read is skipped without a panic,
+because this path has no prior confirmation that the error is CXL internal.
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
+cxl_handle_rdport_errors() acquires the device lock on port->uport_dev (the
+CXL Host Bridge) internally. Callers must not hold it.
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
+   * - drivers/acpi/apei/ghes_helpers.c
+     - CPER record validation and work-data setup helpers
-- 
2.34.1

