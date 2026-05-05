Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185C838E5F9;
	Tue,  5 May 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002388; cv=fail; b=TYwind9COIQqia4uojFaQT4MJ7t7Ks32NnGdttZPNtZspkJfjqdRjUE5T9BlmFYt3L0g5OMViC5uh6gtS8l6cH8zCRFpsKcfqE5hEyYaHNKpVysGSmLnrH9tnkHV+jJsw9WqxnEXztGVjGEiB6J8Nv8E8dicJCRB8e3Cmx7QiCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002388; c=relaxed/simple;
	bh=kKUGFKbhKHjNOknXaHeutQh+mJSrXYf2VvDkSAcS2MA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXhPoscKZonnPgJGaQXsZFd3mvlByUK8UAffEMzfDNc9qgdtH0H9nZJ8U0fZBDExfNfN4qjEUj5pueRftoZKkOYDMAImidB+Aqx0WqcFKh8HLloAk3y6XQvLcDz1gL9QyiuSsQXOFcThWkp1Kpv8bhYmovfdTv82PuERqCz1K/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NhoD/pRt; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NhoD/pRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkGm0h7fXhDN1R+EcXbhB1DFSYWwCFleGLf3NCR/r49yrdgvxRgiyDJ8M9on9ZrlBPp3uuDS5a258jXuzRJbzxeBjWD85jD9TRSA/W1m1iteXk0PBRMlRiaM63RVY8POPwJo/f0GhtSR4mBOpg+lBlnYl3huNsOPtKDfGQ5gFo54ClOcKsKqOxvSnfK3EU3f3pf9hsTPnJtojzljQ1tvQUJ+drgxoNi7bExaeIYzNMvRKtMBFa6lWpLVihQwr70DLFnYzWlp+FNTjJs1qbUCMocyA84PhgdUwcK1LMzOFdCR7J+SUkk11ieQ0K/zOvhG4dfec9UmOciJMKOvrEO/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87h5VvFDLPcUf0akGajedE6q2tJmRieN7ll/0XADI78=;
 b=DHFPvxW20Ct+wZts3zA/R1TO5SVKJy/cjrOpEH7yZYuF9RPtoSXHruRbBJbTl12+VOZsk4zaCgvGKHK4UPinIujHmvC50Jp630XbEhZjsaJREKS4BNi78Q1Xh7ED5oKtNwgIpKcwo65fMLtzo4oU75Nyt7ru9racmWFrvDWhl5ItO+BdJAk1N7eXhTdKSE3FknXQaOKXVYozTH6U7mhd2ihtRtcZSDRwNSJzGOsJWyzEetPQtPyNxpLvvH4tUj9/EJC/02JTr2Hf8R2a1L2kv1UxE4rdrcEYixKdQdmw+FydBoscwQWJLgEGSOGVbfrElP51GphxfdZyhO14AR5BWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87h5VvFDLPcUf0akGajedE6q2tJmRieN7ll/0XADI78=;
 b=NhoD/pRtoswUEySheIqU3xics7mdY//YNzCdnyBZkGTqV7kOldeVdGIvtW4fZJj9D3aYfj89sxkiMdbDm7P+pI2uoapA1Q/fx50JAAlfInI2iXp1gkAci27stdqw4QhSKWhMc6OIjwdv85hLEXXFoOgh3reE3W8uVaC7bQqiF8o=
Received: from DS7PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:3b7::14)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 17:32:56 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::db) by DS7PR03CA0099.outlook.office365.com
 (2603:10b6:5:3b7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Tue,
 5 May 2026 17:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 17:32:55 +0000
Received: from ethanolx7ea3host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 12:32:54 -0500
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
Subject: [PATCH v17 11/11] Documentation: cxl: Document CXL protocol error handling
Date: Tue, 5 May 2026 12:30:29 -0500
Message-ID: <20260505173029.2718246-12-terry.bowman@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d82984-1d3b-414f-8ecf-08deaacc5803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|36860700016|1800799024|921020|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OvWS6REqSZC9SwIJlNEaxlRHQosTOd/USdpr+XT7PeeMyT64InyRJi+ulxU7XXO2W6+wVF5lGhVB5vEvhKd+yJoWIrB+OCqDwq/mtihDIBudFTttYIcbDs5GpdlhXFmz3YBmw1a8d3wQRWS46tHKMhqVijbFL+yJjuP+fp+syj1xEla5uEwKHOppFXNvfe/ccP1zqP++qtAwAh26oJY0yHlsaVNLzaClSWY/D3SwNC8en2UhhZeuSvEKWBE0kYkvKKAiSxZg7SjVp7O72YgkGZYbuSH5VEfcA0JhEknxBuFU+dbCkiUECpXewaKLnB8IAgW1w7qesNoU//soB4d5pOoCnaMgVcK1QrI9SHhmuzLtlw/scluFRKB1hJk6w1H3IBBsKr2hgzigy6ElUuHXSb8ivapy1I8Pa72bsFBHEoAAh8VOAmq0GWwyGQLXMxUVxg/dQcy6xiGlfUAnDu6OQ7YIqfXs9oLEXaAnwjD8jGrFH6qTQwBR/0+2J2xjAr/oyEoakiIXc3wNGlrtZtbZsv//p2rEClQ7u+MSVyfZIk6naMc227CW+0fwBrUC+Y/RUMcUJlTyGttpbT629ApImQjrZ+vBosYvFM2jmR3ZRK4wucmlvJdk4slaMsT2Ri+ostNsm1BszspqIsHC0sP0fuRHkq3iIKFKFCOoTf8pBiWiNTsuBm7i5G7hyF6Rgg4ECcSMZ74V49xBQO5qFCcugKy/j5yKbRBhvyUWuzG4fGwVlbS6YMbXdaOD3+uiR3vIs2LGNSYGpHc3DAIuOmMyig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(36860700016)(1800799024)(921020)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jC1kONZPDnXQrh4e8gSJbIrC/OP4Jp9yby901hqj79y7ATlfCb68iSUf1cRS6pzVI0NXfyYGyL9ngkqAPg+y426x4nPB/UtwEl24sstVf/xR7nMwx+/Zn/EjniW6NstKMVGBBqcCMIY5InE9bJ+f2RWxMe5+X9vQdMjgxo+TaVcUQM2L0Hez0/vTX7aHiU1SQLmWVKZyiyTd193NOLVsHMNArrwFxYHbkpZJ4RpSEyLeiYwzyzmgsm2EcZwhD6+AKMDgmZwQldseN2Uvode2gsAihsrUUa47lNwVt0fMMtq9Gv3DB+3v5VGeCNfYt44Sapkz1LZySuuVU8xazHzGYw3yoy/lZ4jMV0PrL4cmFOhrNVH4GZt4eUzsc9MgbtkVy8M8+f2an14Guv9P2FJSxCtns97RhvmLMliatbn8LX378CBug5bMFtWc0ZA+utyy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 17:32:55.9082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d82984-1d3b-414f-8ecf-08deaacc5803
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120

Add Documentation/driver-api/cxl/linux/protocol-error-handling.rst
describing the end-to-end CXL protocol error path: AER ingress, the
AER-CXL kfifo handoff, the cxl_core consumer worker, RCD/RCH special
cases, severity policy, trace events, and a source code map.

This documents the architecture introduced by the preceding patches in
this series.

This was generated by claude-opus-4.7.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 Documentation/driver-api/cxl/index.rst        |   1 +
 .../cxl/linux/protocol-error-handling.rst     | 440 ++++++++++++++++++
 2 files changed, 441 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/linux/protocol-error-handling.rst

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 3dfae1d310ca..6861b2e5726a 100644
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
index 000000000000..4d6f33f0ed31
--- /dev/null
+++ b/Documentation/driver-api/cxl/linux/protocol-error-handling.rst
@@ -0,0 +1,440 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+CXL Protocol Error Handling
+==============================
+
+This document describes how the kernel detects, classifies, dispatches,
+logs, and recovers from CXL protocol errors signaled through the PCIe
+Advanced Error Reporting (AER) interface. It covers both Virtual
+Hierarchy (VH) topologies (Root Ports, Upstream/Downstream Switch
+Ports, and Endpoints) and Restricted CXL Host (RCH) topologies
+(Root Complex Event Collectors driving Restricted CXL Devices).
+
+It is intended for kernel developers maintaining or extending
+``drivers/pci/pcie/aer*.c``, ``drivers/cxl/core/ras.c``, and the
+related plumbing in ``include/linux/aer.h``.
+
+
+Background
+==========
+
+A CXL device reports protocol-layer failures (CXL.cachemem RAS) as
+PCIe AER **Internal Errors**: ``PCI_ERR_COR_INTERNAL`` for correctable
+events and ``PCI_ERR_UNC_INTN`` for uncorrectable events. From the AER
+core's point of view these look like ordinary PCIe AER messages, but
+their semantics are CXL-specific: the actual fault information lives
+in CXL RAS capability registers, not in the PCIe AER status registers.
+
+Historically, native CXL.cachemem RAS handling was implemented only
+for CXL Endpoints and for RCH Downstream Ports. CXL Root Ports,
+Upstream Switch Ports, and Downstream Switch Ports were not covered.
+This left the kernel unable to log or react to protocol errors
+signaled by switch components.
+
+The unified CXL protocol error path closes that gap by routing every
+CXL Internal Error through a single producer/consumer pipeline shared
+by all CXL device types.
+
+
+Architecture overview
+=====================
+
+CXL protocol error handling is implemented as a distinct error plane
+layered on top of the existing PCIe AER infrastructure. The two planes
+are kept separate:
+
+* The **PCIe AER plane** continues to handle native PCIe errors
+  (Receiver overflows, malformed TLPs, completion timeouts, and so
+  on). This is unchanged.
+
+* The **CXL protocol error plane** owns CXL Internal Errors. The AER
+  core forwards them to ``cxl_core`` via a dedicated kfifo; ``cxl_core``
+  then dispatches to CE/UE handlers and drives the recovery and
+  panic policy.
+
+The boundary between the two planes is ``is_cxl_error()`` in
+``drivers/pci/pcie/aer_cxl_vh.c``, which inspects ``info->is_cxl``
+(set from ``pcie_is_cxl()``) together with the PCIe device type and
+the AER status word. When ``is_cxl_error()`` returns true the event
+is enqueued into the AER-CXL kfifo; otherwise the event flows through
+``pci_aer_handle_error()`` as before.
+
+The pipeline has three layers:
+
+1. **Producer** (``aer_cxl_vh.c``, ``aer_cxl_rch.c``) - runs in AER
+   IRQ/threaded context, classifies, clears the AER CE status, and
+   enqueues ``struct cxl_proto_err_work_data``.
+2. **Queue** - the AER-CXL kfifo plus a backing ``struct work_struct``.
+3. **Consumer** (``cxl_core/ras.c``) - workqueue-context worker that
+   resolves the CXL Port topology and dispatches to CE/UE handlers.
+
+
+Topologies
+==========
+
+Two topologies are supported, and both feed the same kfifo.
+
+Virtual Hierarchy (VH)
+----------------------
+
+A standard CXL VH consists of a CXL Root Port (RP), an optional CXL
+Upstream Switch Port (USP), one or more CXL Downstream Switch Ports
+(DSPs), and CXL Endpoints (EPs) attached to the DSPs. Each component
+is a regular PCIe device with a CXL DVSEC and a CXL RAS capability,
+and it raises Internal Errors directly to the AER subsystem via the
+RP's MSI/MSI-X interrupt.
+
+The VH producer is ``cxl_forward_error()`` in
+``drivers/pci/pcie/aer_cxl_vh.c``.
+
+Restricted CXL Host (RCH)
+-------------------------
+
+In the RCH topology, a Root Complex Event Collector (RCEC) aggregates
+errors from one or more Restricted CXL Devices (RCDs) attached as
+Root Complex Integrated Endpoints. The RCEC delivers the AER
+interrupt; the AER driver iterates the RCDs beneath it.
+
+The RCH producer is ``cxl_rch_handle_error_iter()`` in
+``drivers/pci/pcie/aer_cxl_rch.c``. For each RCD it finds, it calls
+``cxl_forward_error()`` (the same producer helper used by the VH
+path), so RCH events end up in the same AER-CXL kfifo as VH events.
+
+
+End-to-end flow
+===============
+
+The diagram below shows the full path from an AER interrupt through
+producer classification, kfifo handoff, and consumer dispatch.
+
+.. code-block:: text
+
+   +-------------------------------------------------------------------------+
+   |                  CXL Internal Error Packet Flow                         |
+   |    From PCIe AER Interrupt to CXL Protocol Error Handling and Logging   |
+   +-------------------------------------------------------------------------+
+
+      CXL device (RP / USP / DSP / EP / RCD) raises AER Internal Error
+      (correctable PCI_ERR_COR_INTERNAL or uncorrectable PCI_ERR_UNC_INTN)
+                      |
+                      v
+      +-------------------------------------------------------------+
+      |    PCIe Root Port AER MSI/MSI-X interrupt fires             |
+      +-------------------------------------------------------------+
+                      |
+      ============= drivers/pci/pcie/aer.c (AER core) =============
+                      |
+                      v
+           +---------------------------------+
+           |  aer_irq()  /  aer_isr()        |  (top + threaded handler)
+           +---------------------------------+
+                      |
+                      v
+           +---------------------------------+
+           |  aer_isr_one_error()            |
+           |  aer_isr_one_error_type()       |
+           +---------------------------------+
+                      |
+                      v
+          +------------------------------------------+
+          |  aer_get_device_error_info()             |
+          |  - reads PCI_ERR_COR_STATUS              |
+          |  - reads PCI_ERR_UNCOR_STATUS  (*if RP/  |
+          |    RCEC/DSP, or non-fatal severity)      |
+          |  - sets info->is_cxl = pcie_is_cxl(dev)  |
+          +------------------------------------------+
+                      |
+                      v
+           +---------------------------------+
+           |  handle_error_source(dev, info) |
+           +---------------------------------+
+              |                          |
+              |  is_cxl_error()          +--->  pci_aer_handle_error()
+              |  (CXL device + Internal)        (native PCIe AER path,
+              v                                  not covered here)
+      +-------------------------------------------------------------+
+      | Topology dispatch within AER core:                          |
+      |                                                             |
+      |   - VH topology  (RP / USP / DSP / EP)                      |
+      |     -> drivers/pci/pcie/aer_cxl_vh.c                        |
+      |                                                             |
+      |   - RCH topology (RCEC iterates RCDs under it)              |
+      |     -> drivers/pci/pcie/aer_cxl_rch.c                       |
+      +-------------------------------------------------------------+
+           |                                            |
+           | VH path                            RCH path (RCEC AER)
+           v                                            v
+      ============= aer_cxl_vh.c (VH      ============= aer_cxl_rch.c (RCH
+                    producer) =============              producer) ==========
+           |                                            |
+           v                                            v
+      +-----------------------------+         +-------------------------------+
+      | cxl_forward_error(pdev,info)|         | cxl_rch_handle_error_iter()   |
+      |  - if AER_CORRECTABLE:      |         |  - iterate each RCD pdev      |
+      |     clear PCI_ERR_COR_STATUS|         |    beneath the RCEC           |
+      |  - pci_dev_get(pdev)        |         |  - call cxl_forward_error()   |
+      |  - build cxl_proto_err_     |         |    for each RCD               |
+      |    work_data                |         |    (same producer helper as   |
+      |    { pdev, severity }       |         |     the VH path uses)         |
+      |  - kfifo_in_spinlocked(...) |         +-------------------------------+
+      |  - schedule_work(...)       |                       |
+      +-----------------------------+                       |
+              |                                             |
+              +-----------------+---------------------------+
+                                |
+                                v
+                    +--------------------------+
+                    |     AER-CXL kfifo        |
+                    |     (work_struct)        |
+                    +--------------------------+
+                                |
+                                v
+      ============= drivers/cxl/core/ras.c (consumer worker) =======
+                                |
+                                v
+      +-------------------------------------------------------------+
+      | cxl_proto_err_work_fn() (workqueue handler)                 |
+      |   for_each_cxl_proto_err(&wd, __cxl_proto_err_work_fn)      |
+      +-------------------------------------------------------------+
+                      |
+                      v
+      +-------------------------------------------------------------+
+      | __cxl_proto_err_work_fn(wd)                                 |
+      |   port = find_cxl_port_by_dev(&pdev->dev, &dport)           |
+      |   cxl_handle_proto_error(pdev, port, dport, severity)       |
+      |   pci_dev_put(pdev)                                         |
+      +-------------------------------------------------------------+
+                      |
+                      v
+      +-------------------------------------------------------------+
+      | cxl_handle_proto_error()                                    |
+      +-------------------------------------------------------------+
+           |                                            |
+      pci_pcie_type ==                          pci_pcie_type !=
+      PCI_EXP_TYPE_RC_END                       PCI_EXP_TYPE_RC_END
+      (RCD Endpoint)                            (VH: RP/USP/DSP/EP)
+           |                                            |
+           v                                            |
+      +-------------------------------------+           |
+      | cxl_handle_rdport_errors(pdev)      |           |
+      |   - process RCH Downstream Port's   |           |
+      |     RAS register block first        |           |
+      |   - cxl_handle_cor_ras() for CE     |           |
+      |   - cxl_handle_ras() for UE         |           |
+      |     (log only; does NOT panic)      |           |
+      +-------------------------------------+           |
+           |                                            |
+           +--------------------+-----------------------+
+                                |
+                                v
+                   +-----------------------------+
+                   | severity == AER_CORRECTABLE |
+                   +-----------------------------+
+                         |                  |
+                         yes                no
+                         v                  v
+            +----------------------+   +-------------------------+
+            | cxl_handle_cor_ras() |   | cxl_do_recovery()       |
+            |  - emit cxl_aer_     |   | (described below)       |
+            |    correctable_      |   +-------------------------+
+            |    error trace       |
+            | pcie_clear_device_   |
+            |   status()           |
+            +----------------------+
+
+                    +-------------------------------+
+                    | cxl_do_recovery()             |
+                    |  if pci_dev_is_disconnected:  |
+                    |    panic("CXL cachemem err.") |
+                    |                               |
+                    |  ue = cxl_handle_ras()        |
+                    |    -> emit                    |
+                    |       cxl_aer_uncorrectable_  |
+                    |       error trace event       |
+                    |                               |
+                    |  if (ue):                     |
+                    |    panic("CXL cachemem err.") |
+                    |                               |
+                    |  pcie_clear_device_status()   |
+                    |  pci_aer_clear_nonfatal_status|
+                    |  pci_aer_clear_fatal_status   |
+                    +-------------------------------+
+
+
+Severity policy
+===============
+
+The kernel's response to a CXL protocol error depends on the AER
+severity reported by the device and on the result of inspecting the
+CXL RAS registers.
+
+Correctable Error (CE)
+----------------------
+
+* The AER driver clears ``PCI_ERR_COR_STATUS`` in the producer
+  (``cxl_forward_error()``) before enqueue, so the device is
+  acknowledged even if the consumer drops the event.
+* The consumer's ``cxl_handle_cor_ras()`` reads and clears the CXL
+  RAS correctable status and emits a ``cxl_aer_correctable_error``
+  trace event.
+* No recovery action is taken.
+
+Uncorrectable Error (UE), non-fatal
+-----------------------------------
+
+* The producer enqueues the event without clearing the AER UCE
+  status.
+* The consumer enters ``cxl_do_recovery()``.
+* ``cxl_handle_ras()`` reads the CXL RAS uncorrectable status and
+  emits a ``cxl_aer_uncorrectable_error`` trace event.
+* If ``cxl_handle_ras()`` returns true (a CXL RAS UE bit was set),
+  the kernel panics with ``"CXL cachemem error."``. CXL.cachemem
+  traffic cannot be safely recovered in software once corruption is
+  observed; continuing risks silent data loss across all devices in
+  an interleaved HDM region.
+* If ``cxl_handle_ras()`` returns false (no CXL RAS bit set, i.e.
+  the AER UCE was a PCIe-side issue rather than a CXL.cachemem
+  issue), the AER UCE status is cleared and execution continues.
+
+Uncorrectable Error (UE), fatal
+-------------------------------
+
+Fatal severity follows the same recovery path as non-fatal in
+``cxl_do_recovery()``, with one important caveat: the AER core only
+reads ``PCI_ERR_UNCOR_STATUS`` for Root Ports, RCECs, Downstream
+Ports, or non-fatal severities (see ``aer_get_device_error_info()``
+in ``drivers/pci/pcie/aer.c``). For a fatal UE signaled by an
+upstream component, PCI config reads to the source device are
+expected to fail, so ``UNCOR_STATUS`` is never retrieved and
+``info->status`` stays zero.
+
+The practical consequence: a fatal UE on an Upstream Switch Port or
+Endpoint is **not** classified as a CXL error by ``is_cxl_error()``.
+It falls through to ``pci_aer_handle_error()`` and is processed by
+the standard AER recovery flow. Only the CXL trace events emitted by
+the AER core (``aer_event``) appear; the CXL-specific
+``cxl_aer_uncorrectable_error`` event is not emitted on this path.
+
+Disconnect during recovery
+--------------------------
+
+``cxl_do_recovery()`` checks ``pci_dev_is_disconnected(pdev)`` before
+touching the RAS registers. A device disconnecting during an
+uncorrectable error event is itself unrecoverable, particularly when
+the device backs an interleaved HDM region; in that case the kernel
+panics directly rather than returning ``~0u`` from the readl() and
+masking the cause.
+
+
+RCD/RCH special cases
+=====================
+
+RCD Endpoint flow
+-----------------
+
+When ``cxl_handle_proto_error()`` sees ``pci_pcie_type(pdev) ==
+PCI_EXP_TYPE_RC_END`` (i.e. an RCD Endpoint), it calls
+``cxl_handle_rdport_errors()`` first. This processes the RAS state
+of the RCH Downstream Port that hosts the RCD before falling through
+to the common CE/UE dispatch on the RCD Endpoint itself.
+
+The RCH Downstream Port's RAS UE is **logged only**: it emits the
+trace event but does not panic. The panic decision is taken on the
+RCD Endpoint's own RAS in ``cxl_do_recovery()``.
+
+This split mirrors the structure of an RCH topology: the RCH dport
+is functionally a CXL infrastructure component (similar to a switch
+port), while the RCD itself is the actual CXL.cachemem source whose
+corruption drives the recovery decision.
+
+RCH ingress aggregation
+-----------------------
+
+RCH errors do not arrive on a per-RCD interrupt. The RCEC is the AER
+source, and the AER driver drives ``cxl_rch_handle_error_iter()`` to
+walk each RCD beneath it and forward an event per RCD through the
+shared kfifo. From the consumer's point of view, RCH-originated
+events are indistinguishable from VH events.
+
+
+Trace events
+============
+
+Two unified trace events are emitted from ``cxl_handle_cor_ras()``
+and ``cxl_handle_ras()`` and are used by every CXL device type and
+both topologies:
+
+* ``cxl_aer_correctable_error`` - emitted when a CXL RAS CE bit is
+  set; carries the human-readable status string.
+* ``cxl_aer_uncorrectable_error`` - emitted when a CXL RAS UE bit is
+  set; carries both the current status and the first-error pointer.
+
+Common fields:
+
+* ``device=<PCI BDF>`` - the source device (always a PCI BDF, even
+  for RCH paths where the trace was historically a memdev name).
+* ``host=<bridge>`` - the parent host bridge or PCI host BDF.
+* ``serial=<u64>`` - the device serial from ``pci_get_dsn()``.
+
+The ``device`` field replaces the older ``memdev`` field that earlier
+revisions emitted on Endpoint events. Userspace consumers
+(rasdaemon's ``ras-cxl-handler.c``) need a corresponding update to
+read the new field name.
+
+
+Source code map
+===============
+
+============================================  ==============================
+File                                          Role
+============================================  ==============================
+``drivers/pci/pcie/aer.c``                    AER core; receives the IRQ,
+                                              builds ``aer_err_info``,
+                                              dispatches to either the CXL
+                                              path (``is_cxl_error()``) or
+                                              ``pci_aer_handle_error()``.
+``drivers/pci/pcie/aer_cxl_vh.c``             VH producer; provides
+                                              ``is_cxl_error()``,
+                                              ``cxl_forward_error()``, the
+                                              AER-CXL kfifo, and the
+                                              consumer registration
+                                              helpers.
+``drivers/pci/pcie/aer_cxl_rch.c``            RCH producer; iterates RCDs
+                                              under an RCEC and forwards
+                                              each via
+                                              ``cxl_forward_error()``.
+``drivers/cxl/core/ras.c``                    Consumer; defines
+                                              ``cxl_proto_err_work_fn()``,
+                                              ``cxl_handle_proto_error()``,
+                                              ``cxl_handle_rdport_errors()``,
+                                              ``cxl_do_recovery()``,
+                                              ``cxl_handle_cor_ras()`` and
+                                              ``cxl_handle_ras()``.
+``include/linux/aer.h``                       Public declarations:
+                                              ``struct cxl_proto_err_work_data``,
+                                              ``cxl_proto_err_fn_t``,
+                                              ``cxl_register_proto_err_work()``
+                                              and ``for_each_cxl_proto_err()``.
+============================================  ==============================
+
+
+Limitations and future work
+===========================
+
+* **USP/EP fatal UCE is not classified as CXL.** As described under
+  `Severity policy`_, the AER core never retrieves
+  ``PCI_ERR_UNCOR_STATUS`` in this scenario, so ``is_cxl_error()``
+  cannot tag the event as CXL. The event is handled by the AER path
+  only. Resolving this requires either an AER-core change to attempt
+  a config read with link-validity gating, or a separate CXL-side
+  notification mechanism for upstream-signaled fatal events.
+* **User-defined status masks** are not yet supported. All CE and UE
+  status bits are reported as they appear in the RAS register.
+* **Port traversing in cxl_do_recovery()** is not yet implemented; a
+  CXL UE today is reported and acted on at the source device only,
+  not propagated to ancestor ports.
+* The RCH producer (``aer_cxl_rch.c``) currently lives under
+  ``drivers/pci/pcie/`` for historical reasons. Moving it to
+  ``drivers/cxl/core/ras_rch.c`` is on the roadmap.
+
-- 
2.34.1

