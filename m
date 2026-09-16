Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9B54DAFA1;
	Wed, 16 Sep 2026 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583840; cv=fail; b=rGLbQuUUNwy21+yO0uFRvzXmbE70h1u4y0rmkYKKz8PqH9Ot7xMaQBkbBgN3OcfYRUaHhfmV+KTKde2FySSDgZOj/y1HYbc3l3weXzJSwn2pghVEltQBrI52nuRLUFcT+qD6lYuKXjKQhOH3WXmK+tR5jJKJ7j3/+io21264jf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583840; c=relaxed/simple;
	bh=cVUOci3ClUU4Uj+KY/p9ppHB1jgTfk1fniroIGEei54=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=poNIqwS41DZ/69Busd65QbbkZTxRZ6xiDlsom4/1cIL8GIISHjFpNnJEyzFh0OWOhUU4My7sxjL+/C+6mytfNB4Rte2agG9Kg/OB7FTu4iFFb1HWI/SsLeInxEIDaiaCjTNcf+qTPkphlG/RufEHthlfnYvDuMfaB53A/d+FS1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GcTEfP5K; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GcTEfP5K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1C51Ou72uLLqXsCQcOuua3++VppKWVN/BeT3p4PYHy1qpS80AQI6u9qaocS6PCyL+seTjQpC/lBD36UQzheRuUuSvAJpPYeLVNkS8WfyTjY8rP6cuPr/MUV4SwsyqVF3Q6Qrd8Gtn8QddDXNbLbX+3I9Dzfe04m7aqJe4rJZY6EUCv4Atb+1v3deGLxB8n52UABcvr2ebzRIZWfzGEPPYw/xjJo1Cy5HD5MI0uZIYNL/m4X5ta6SveiqjQHW0KOrAyiNgEWUcfJReyOHTgwMW5vtXxQpvYkIiFAjRpp+fXtbVP9iKl/mmcLm/VdtZX615azaunM/LuuTVPiZs8Kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXoDt7NsnvWvVR0JJvcUP4Bmt8uyBOnvMH7WsfcgriY=;
 b=x6NqGtYQRrMNtCgssknUKSHwbW6ZahvrCbbrbgOz3cemvUAn0wROZYlt+nrRyVdlkZk6zzQ4Wy2OgAdeZrZPynSXy7vB/GgP8iS4sf8y2lUdoCpr/qPVKdrbYPz5JdLEDqp6TUUtG6INUrpL1bYsv3TC+0w1NATbdoAP3Z7pnHt2qowruIulzmTSLwS2xvxl4blQYtqL0ayaDjLZihpg441StojI67ZwdgtoonUpBr43hNwSomgDY4uIcBg3Lrpc/DdQS87njUTHFgu/LynLmefD+RAyYFZxDM22BUSCi8RziNq8snYCFgVv94d2CwrZ7j1M5G4X2ZOxF++ZMmMLEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXoDt7NsnvWvVR0JJvcUP4Bmt8uyBOnvMH7WsfcgriY=;
 b=GcTEfP5KJqYj4RPKtBOoOhJpNOm8YlDpmA0ZfQYtfuKTQpCQWQeBuTPrfetW+vAzqb31THBJjWBJiZ6o88B1m0lNX65ctDxwrXFPPyXjuEIWAkZfoltiJ7NvujuBwQcRrGshpBaVz1p7oacNxiRMyeaHwvCB5GqZp4xXxw23/EvafrQgFUvAczY3PvUQphBST+t0pNI/R45MwDwmPmbeHAEo4TKMwzFej1af/9YXSKq0PiytMAz3HOaK+qXmILHk2UAYVQsMWAC6Y29SGEVPzaaWEU0uTdMMOs3JlnVOfVYgq1hsRuREKsNkUu6sng1/yGCAiJLo+iOi8+xhRjEb1Q==
Received: from CY5PR19CA0017.namprd19.prod.outlook.com (2603:10b6:930:15::10)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:36:41 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:930:15:cafe::3d) by CY5PR19CA0017.outlook.office365.com
 (2603:10b6:930:15::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:36:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:36:07 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:35:58 -0700
From: <mhonap@nvidia.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
	<jic23@kernel.org>, <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
	<smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
	<dave@stgolabs.net>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
	<yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
	<bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
	<gustavoars@kernel.org>
CC: <cjia@nvidia.com>, <kjaju@nvidia.com>, <vsethi@nvidia.com>,
	<zhiw@nvidia.com>, <mhonap@nvidia.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: [PATCH v5 00/27] vfio/pci: Add CXL Type-2 device passthrough support
Date: Thu, 17 Sep 2026 00:05:13 +0530
Message-ID: <20260916183540.3813685-1-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb1d32f-2c1b-4a8e-dc86-08df1421725d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|11063799006|921020|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Ab76PEMdZrh0Vm+TAVZAhIw3sTk939uWde9QDU0poC4PMBoAdeAIiAGyiJ9HQjbt94v0DfJ28xQO7O1Bl1c4+2RcAj19h+ilpLp8AZaKDt0RSfvwEOVLf1qMYuCrCy/PFidP8xW65zRvrbah684lGqgDbu9JIWUEUvIpSZoBJDhAJVd71McJWvDYquuGOjUXKcCMx/1lCTxelU89xul5gqJ6KSQzPtfz5kSCFMXVUKLo9pNk3coCuu5JsH8xQTEeei7PBXK9vOAgdG+83uGnwV/eVQjOID0Fq0lmHGprsyBP+HSJhs0fldqVABhwvhEDxv2pEVAoqiZg4IKZR6m9soNBqu3ciOGFNMRCcfoycOOe1zQ1Bc/vlhazEXoVbZtznFSFCqclCBBq9ZvoN7vfLnNcRQd6OvB7WBBNkhUC3ZgVN+hmcVj5/TMxhCV+0e62ivBnqY0kh9/0H/24iNvI9OHu82IP9KHOCjB0vd4abO0zok0nHWZ3SWgnsAROL3KTlSKRGBSt6RX9tskWdulmnr5wlVmD4sWUqlYM2v3Eie2gubMyvg9RLDVB1pEcYQnkUjcD9sZ9AtmxRM7tZos2IqPKTfVNZ5kNnGCECLg4QJSmPV6K8+L283mfW3tNhjXMz9G7u6MVIX5LFhwZrEH9xsaZ6cMpQHgxZC9VSbBCOTLOx5yoj0AIh7n/rK4hEKB+8LdRY9uvDkpt3HpD/GsR5YqnjYJ0JIwBN2CIp50kAuStP2p4bGUIatA9bvppKJh/
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(921020)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PhkJCpLaU6EL9mSpUKqMgkko1+bGSRVUHKDOqtKJQJSnk95cwd55NFxWGbij9vPC8TRIR7WUe0NNXj2pqF85Uq0pJfcPxWVnTXTvsuqTfLGmwm8qlWE6tPYsnyqseyD/5PnQJoisOmhR8kGchK4B8ibDREop/9b0S0V2CQcAqhjZKlP8VWkZe8yiQSMq6rSnWwMBrVhA+Wei+WgzaWMNZjRu7Ukb/oEzgBdcDKjVK9wRrV25cMKrTutZEKbhuPhZIpKxAAq/rcydY1N4u/St6bK/mZfnTSMaxqogCQzHct1ydQTdezSz5B0LHe5KgAn999NU3ChN47i1KXDSmEZu9e6Udwb2vh+YmD/1ZVFGbNYAXIBFcGFvTCJHpxZ0lcLWKWvIog8dRDO1qJRI4nuSTDKSmgJwpv5SQ/NV88y3b7wdn4uI7dItplE1jjhCUc3S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:36:39.3339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb1d32f-2c1b-4a8e-dc86-08df1421725d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214

From: Manish Honap <mhonap@nvidia.com>

This series adds VFIO passthrough for CXL Type-2 accelerators. The guest
drives its own virtual HDM decoder and can reset the device. The host
owns the physical decoder and the host physical address the memory lands
at. The guest only picks a guest physical address. This series targets a
single, non-interleaved, firmware-committed endpoint decoder.


Base and dependencies
---------------------

  Base: Linux 7.3-rc1 (cee9395acd80), plus the cxl-reset dependency:
  - CXL reset core from Srirangan's cxl_reset series (v12) [1], which
    caches the endpoint decoder settings in pdev->hdm and keeps the HDM
    decoder and reset helpers in drivers/cxl/core.
  - This series adds a function-scoped reset entry
    (cxl_reset_dvsec_sequence) on top and drives it at the vfio reset
    points.
  - Prerequisite commits from Alejandro's type-2 device support and
    Dan's devm_cxl_probe_mem are already upstreamed in this kernel
    release and those series are not listed as dependencies now.


Changes since v4
----------------

v4 [2] introduced the vfio-cxl provider: the register emulation lives in
a separate module that vfio-pci-core loads on demand, and cxl-core keeps
only the reset entry and a few enabling helpers. v5 keeps that model and
folds the v4 review, reshaping the region and reset handling. The patch
count is unchanged at 27; several patches were split, a few were dropped,
and the composition changed.

Structural
  - The v4 "expose the HDM memory and trap the decoder registers" patch is
    split into three: the mmap-able HDM memory region, memory-failure
    containment for that struct-page-less range, and the read-only
    decoder-register region.
  - "Guard HDM access on device state" is split into two: excluding the
    decoder block from the direct BAR, and clearing the HDM access gate
    after a secondary bus reset.
  - The decoder register block is read live; the static decoder snapshot
    and its refresh-after-reset patch are gone.
  - The CXL DVSEC is virtualized through the config-space permission hooks
    in vfio_pci_config.c; the separate DVSEC-shadow patch is gone.
  - The cxl-core media-readiness patch is dropped; a mailbox-less Type-2
    memdev sets media ready in the provider at bind (mirrors efx_cxl).
  - The cxl-core register-map rework is split into request/ioremap helpers
    plus an owned-resource record, replacing the v4 bar_owned flag.
  - The v4 resource.c include/export patch is dropped; the include ships in
    the cxl_reset base and the disputed re-export no longer exists.

Behavioral
  - The HDM decoder registers are served by live reads with guest writes
    absorbed; the host committed and locked the physical decoder, so the
    guest never drives it.
  - fd read/write of the HDM memory region is serviced by a device-state
    guarded write-back copy (Memory-Space enabled, decoder known-good, and
    media ready) and refused only while that gate is closed, rather than
    unconditionally.
  - The coherent CXL.mem range is exported as a dma-buf and mapped into the
    guest IOAS with IOMMU_IOAS_MAP_FILE, replacing the out-of-tree PFNMAP
    workaround v4 needed for device-side ATS.
  - Reset is wired through the pci_error_handlers .reset_prepare and
    .reset_done callbacks and the CXL reset method rather than open-coded;
    a bus hot reset no longer rejects sibling functions.
  - The excluded-range facility is generic (a list of bar/start/size/flags)
    and the existing MSI-X exclusion is migrated onto it.


Reviewer feedback addressed
---------------------------

The v4 [2] thread has the full discussion; this is where each objection
landed.

Alex Williamson
  - A generic excluded-range list replaces the CXL one-off; MSI-X is
    migrated onto it; an intersecting host read fills -1 and a write is
    dropped rather than erroring.
  - The component-register block is exposed as a live read-only view, not a
    static shadow; the refresh-after-reset patch is eliminated.
  - The HDM memory fd read/write is device-state guarded rather than a bare
    -EIO.
  - Error containment and the decoder-register region are their own patches.
  - Reset uses .reset_prepare/.reset_done; the multifunction/sibling
    hot-reset rejection is dropped; the VM-centric framing is removed.
  - CXL init failure is non-fatal and falls back to plain vfio-pci;
    disable_cxl is a convenience opt-out, not the failure path.
  - The DVSEC virtualization lives in vfio_pci_config.c as an ecap perm map;
    the config path takes no CXL module dependency.
  - Both regions use VFIO_REGION_TYPE_PCI_VENDOR_TYPE with the CXL vendor id.
  - Kconfig/Makefile ordering fixed; the .open_device/.close_device hook
    names are kept to mirror vfio_device_ops; the bind-time rejects log
    consistently.

Dave Jiang
  - Component-register ownership uses the owned-resource API, not a
    bar_owned flag.
  - Media readiness is set in the provider at bind (efx_cxl precedent); the
    cxl-core media-readiness change is dropped.
  - The component register defines live in uapi/cxl/cxl_regs.h and the
    message names the selftest as the consumer.
  - The cheap topology rejects are grouped before the range computation.

Jonathan Cameron
  - The v4 resource.c include/export patch is gone: the include arrives with
    the cxl_reset base and the re-export it objected to no longer exists.

Shuai Xue
  - The selftest maps the HDM range through the dma-buf + IOMMU_IOAS_MAP_FILE
    path instead of failing a VA-based IOAS map.
  - The guest cache write-back-invalidate doorbell completes in the shadow;
    the host runs the real WBI inside the reset sequence.


Patch order
-----------

The patches are ordered so the tree builds at every commit and each change
sits next to the code it depends on. Five groups:

  Part 1  CXL core (patches 1-4)
    - Split the BAR block request and ioremap helpers, and let a BAR-owning
      driver own the component register block, so the HDM/RAS sub-blocks are
      left unclaimed for vfio-cxl.
    - Move the component register defines to include/uapi/cxl/cxl_regs.h so a
      VMM (and the selftest) can consume them.
    - Add the function-scoped cxl_reset_dvsec_sequence() for vfio-pci.

  Part 2  vfio-pci-core enabling (patches 5-14)
    - The CXL provider ops registration interface, on-demand provider load,
      -EPROBE_DEFER handling for the built-in case, and the non-fatal
      fallback to plain vfio-pci when CXL init fails.
    - A generic excluded-range list and the MSI-X migration onto it.
    - The CXL DVSEC virtualization in config space, the open/close hooks, the
      reset brackets, and the disable_cxl opt-out.

  Part 3  vfio-cxl provider and HDM regions (patches 15-24)
    - The vfio-cxl module, the CXL memdev created at bind, and ownership of
      the whole component BAR.
    - The mmap-able HDM memory region, memory-failure containment for it, and
      the read-only decoder-register region.
    - Excluding the decoder block from the direct BAR, the hot-reset access
      gate, the device/decoder geometry cap, and the dma-buf export.

  Part 4  vfio-cxl reset (patch 25)
    - Run the CXL DVSEC reset at every vfio reset point.

  Part 5  Documentation and selftests (patches 26-27)


Subsystem boundary
------------------

vfio-pci-core does not implement CXL registers. vfio-cxl is a separate
module that registers a struct vfio_cxl_ops at init. vfio-pci-core loads it
on demand for a CXL device (request_module plus pcie_is_cxl) and pins it
per bound device. If a modular provider is missing or fails to load, the
device is driven as plain vfio-pci. The bind only defers for the built-in
initcall-order case, where request_module cannot help.

The core exposes only the primitives that have to live in core (memory_lock,
mapping revoke, dma-buf quiesce, and the BAR sub-range exclusion). The
CXL-specific work stays behind the ops.


Memory ownership
----------------

The host resolves the host physical address once, at bind, through
devm_cxl_probe_mem(). The memdev is owned for the bind lifetime and torn
down at unbind. The HPA range is claimed IORESOURCE_EXCLUSIVE so no
mismatched cacheable alias can form, including one mapped through /dev/mem.

The guest programs a guest physical address into a trapped virtual decoder
and polls a shadow for commit. It never reaches the physical decoder
registers: those are served only through the live-read trap and are
excluded from the direct BAR mapping, so the guest cannot move the host
physical window.


HDM region access
-----------------

The HDM region carries the coherent device memory. A VMM mmaps it and maps
it into the guest through stage-2; that is the primary access path. The
region advertises READ and WRITE so a VMM can derive an accessible (non
PROT_NONE) mmap protection. fd read/write is serviced by a write-back copy
gated on the same device state as the fault path, and refused while that
gate is closed.

The fault path inserts the pfn only while the decoder is in a known-good
restored state, the device has PCI Memory-Space enabled, and the media is
ready, so a host access cannot reach a revoked or disabled decoder. The
fault inserts the HPA pfn at the largest aligned order, including 2 MB PMDs.
The struct-page-less range is registered with the memory-failure machinery
so a memory error is contained to unmapping the range and a SIGBUS rather
than a host SError.


DMA and iommufd
---------------

A Type-2 accelerator issues ATS-translated DMA to addresses inside its own
HDM window, so that range must be present in the guest IOAS. The HDM range
is struct-page-less coherent memory that a userspace-VA IOMMU_IOAS_MAP
cannot pin, so the HDM memory region is exportable as a dma-buf:
VFIO_DEVICE_FEATURE_DMA_BUF returns an fd that iommufd maps with
IOMMU_IOAS_MAP_FILE, without a VA or a page pin. The dma-buf is revoked
whenever the mapping is torn down, so a stale stage-2 mapping cannot outlive
the HDM window.


Reset
-----

A CXL Type-2 device is reset through its DVSEC sequence at every path that
can reset it, not through an FLR (an FLR would corrupt CXL.mem). The reset
runs at every vfio reset point through one shared helper: VM enable and
close, the VFIO_DEVICE_RESET ioctl, a config-space FLR, and a guest write of
Initiate_CXL_Reset in the CXL DVSEC. Under memory_lock, with the HDM mapping
and the dma-buf revoked, the host runs cxl_reset_dvsec_sequence(), which
always clears device memory on the v12 base and restores and re-samples the
firmware-committed decoder. The guest's cache write-back-invalidate doorbell
completes in the shadow and the real invalidate runs inside that sequence;
the reset outcome comes back through DVSEC STATUS2 for the guest to poll.

A CXL port masks Secondary Bus Reset by default, so a
VFIO_DEVICE_PCI_HOT_RESET does not reach the endpoint and the HDM state is
untouched; a hot reset no longer rejects sibling functions. If the port has
SBR unmasked the reset can decommit the decoder without restoring it, so the
reset_done handler gates HDM access; a later VFIO_DEVICE_RESET runs the CXL
reset sequence and restores it.

A bound CXL Type-2 device is kept out of idle D3. Powering a Type-2 function
down and back up reinitializes it and discards its coherent memory, which
only the accelerator's own driver re-initializes, so vfio-cxl sets
disable_idle_d3 to keep the device in D0 while it is bound.


Validation
----------

  - Each patch builds (drivers/cxl and drivers/vfio) and passes
    scripts/checkpatch.pl --codespell --strict with no errors, warnings, or
    checks.
  - The series applies in sequence on the stated base and dependencies.
  - The coherent CXL.mem range is mapped into the guest IOAS through the
    in-series dma-buf export (IOMMU_IOAS_MAP_FILE); the out-of-tree PFNMAP
    workaround v4 required for device-side ATS is no longer needed.
  - A selftest, tools/testing/selftests/vfio/vfio_cxl_type2_test.c,
    exercises region discovery, the sparse mmap, the huge-page fault, the
    dma-buf IOAS map, the live decoder reads, aligned/range access rejects,
    the commit/lock FSM, the DVSEC virtualization, and a real device reset.
  - Built and functionally tested against a CXL Type-2 device: guest boot,
    decoder commit and mapping, and guest-triggered CXL reset.


Follow-on UAPI
--------------

- The trapped component-register region spans the whole HDM decoder block,
  so a multi-decoder device needs no new region or cap: a VMM reads the
  decoder count and each committed base from every decoder in the block.
- The COMP_REGS geometry cap keeps a reserved field as a versioning anchor.
- Further trapped surfaces such as CXL RAS are planned as new CXL region
  subtypes rather than by extending this cap.
- The single committed, non-interleaved decoder is a bind-time policy in one
  place, not an ABI assumption, so multi-decoder and switched topologies
  relax only there.


Deferred
--------

  - Topology reach. Switched, multi-decoder, and interleaved decoders stay
    rejected at bind.
  - Non firmware-committed decoder support.


AI assistance disclosure
------------------------

This series was developed with substantial AI assistance (Anthropic Claude,
via the Claude Code CLI), used for design exploration and trade-off
analysis, multi-agent regression and adversarial review against the v4
feedback, and drafting the selftests and the documentation. Following
Documentation/process/coding-assistants.rst, each patch carries an
Assisted-by: LLM tag. Build, checkpatch, and on-hardware functional
testing were done by me, not the assistant. I have reviewed every change
and take full DCO responsibility for the series.


References
----------

[1] [PATCH v12 00/12] PCI/CXL: Add CXL reset support for Type 2 devices
https://lore.kernel.org/linux-cxl/20260910070808.1444264-1-smadhavan@nvidia.com/

[2] [PATCH v4 00/27] vfio/pci: Add CXL Type-2 device passthrough support
https://lore.kernel.org/linux-cxl/20260813093631.2288172-1-mhonap@nvidia.com


Manish Honap (27):
  cxl/regs: Split the BAR block request and ioremap helpers
  cxl/regs: Let a BAR-owning driver own the component register block
  cxl: Move component register defines to uapi/cxl/cxl_regs.h
  cxl: Add cxl_reset_dvsec_sequence() for vfio-pci
  vfio/pci: Add the CXL provider ops registration interface
  vfio/pci: Detect CXL devices and load the CXL provider on demand
  vfio/pci: Honor -EPROBE_DEFER from CXL provider probe
  vfio/pci: Fall back to plain vfio-pci when CXL init fails
  vfio/pci: Add a generic excluded-range list
  vfio/pci: Migrate MSI-X exclusion onto the generic excluded-range list
  vfio/pci: Virtualize the CXL DVSEC in vfio_pci_config.c
  vfio/pci: Call the CXL open and close hooks around device use
  vfio/pci: Bracket PCI resets with the CXL reset hooks
  vfio/pci: Provide an opt-out for the CXL Type-2 extensions
  vfio/cxl: Add the vfio-cxl provider module skeleton
  vfio/cxl: Create the CXL memdev and set media ready at bind
  vfio/cxl: Own the whole component register BAR
  vfio/cxl: Expose the HDM memory region to the guest
  vfio/cxl: Contain HDM memory errors with memory_failure()
  vfio/cxl: Expose the HDM decoder registers read-only to the guest
  vfio/cxl: Exclude the HDM decoder registers from direct BAR access
  vfio/cxl: Clear the HDM access gate after a hot reset
  vfio/cxl: Describe the CXL device and decoder geometry to userspace
  vfio/cxl: Export the HDM memory region as a dma-buf
  vfio/cxl: Run the CXL reset at the vfio reset points
  Documentation: vfio-pci: Document CXL Type-2 device passthrough
  selftests/vfio: Add CXL Type-2 passthrough tests

 Documentation/driver-api/index.rst            |   1 +
 Documentation/driver-api/vfio-pci-cxl.rst     | 188 +++++
 MAINTAINERS                                   |  10 +
 drivers/cxl/core/regs.c                       |  35 +-
 drivers/cxl/core/resource.c                   |  53 ++
 drivers/cxl/cxl.h                             |  47 +-
 drivers/vfio/pci/Kconfig                      |   2 +
 drivers/vfio/pci/Makefile                     |   2 +
 drivers/vfio/pci/cxl/Kconfig                  |  11 +
 drivers/vfio/pci/cxl/Makefile                 |   3 +
 drivers/vfio/pci/cxl/vfio_cxl_core.c          | 704 ++++++++++++++++
 drivers/vfio/pci/vfio_pci.c                   |  13 +
 drivers/vfio/pci/vfio_pci_config.c            | 177 +++-
 drivers/vfio/pci/vfio_pci_core.c              | 544 +++++++++++-
 drivers/vfio/pci/vfio_pci_dmabuf.c            |  27 +-
 drivers/vfio/pci/vfio_pci_priv.h              |  10 +
 drivers/vfio/pci/vfio_pci_rdwr.c              |  50 +-
 include/cxl/cxl.h                             |  14 +
 include/cxl/pci.h                             |   3 +
 include/linux/vfio_pci_core.h                 |  40 +
 include/uapi/cxl/cxl_regs.h                   |  53 ++
 include/uapi/linux/vfio.h                     |  24 +
 tools/testing/selftests/vfio/Makefile         |   1 +
 .../vfio/lib/include/libvfio/iommu.h          |   3 +
 tools/testing/selftests/vfio/lib/iommu.c      |  29 +
 .../selftests/vfio/lib/vfio_pci_device.c      |  57 +-
 .../selftests/vfio/vfio_cxl_type2_test.c      | 780 ++++++++++++++++++
 27 files changed, 2789 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst
 create mode 100644 drivers/vfio/pci/cxl/Kconfig
 create mode 100644 drivers/vfio/pci/cxl/Makefile
 create mode 100644 drivers/vfio/pci/cxl/vfio_cxl_core.c
 create mode 100644 include/uapi/cxl/cxl_regs.h
 create mode 100644 tools/testing/selftests/vfio/vfio_cxl_type2_test.c

-- 
2.25.1

