Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903C427FA9;
	Thu, 13 Aug 2026 09:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614103; cv=fail; b=prNYU+Dq5EIUIMog94IHnRU+YsOg+UzKlY5R26tbPX/bryGOm+GVZ91X8ZPRhEKJjSn+/B1fG3Ia7A4nSJQ/g3D2lypXLNkzhdOgG1/yLO1p8erIS4UnYeuK5g7hg20pMwJczfG9yxe+7yn8Rq4b2O7fRSLP0+rLJKFRPShLaPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614103; c=relaxed/simple;
	bh=D3u9BpPfudZPTahFA/1yzsE114rDN97BnA1m1PF50jw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ua7ZQsUtDWsaY4tc1IqThnkc4tQcy55pjmc52KDvuWEX50SsgHnRRnBGS8zYHbbqkThPpDa7+0wpcd7/PZSNgk1yRH/jvsGjcDyU01Dbf57+fp2INZJf+FtXzjA1pFkUmZFR+QhIR8QUIyGF94Lq1fbQzvhJdmfkram+4izIyQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=arr0Z+l1; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="arr0Z+l1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH6N0wNfU0memPvia8whGb5Bvnwp9vTQ9GT0TYbbC/c5O0IuNpbQJBOWVfYLXb6tfiJySveP4Wa0l5gMfmJwA2EAswKaBRepsZft6tlSHtcu4UjZDFaGN1hrybG13om9rnNhPKXjZ39rUOhU/rxushXlEgENeOEEI+U1MYPA+TNIW78y7QXdrBi08dnKlDiSK7gCQa+tmuVUOhT06MBoBLflTAKVcPzpR1YOLtgt75ikBMO6+ozBq7QWHCE+GCFHfijiYZUB7rNEg75tH4JSUFvf+2OgpUp0q30awT7BugEyAF2HjsXZ1mzFeHPr8wj/JT8ABzmgfiIrpHVebgBZmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjQXvEjqC+JVw6el6XhMyU2dzf7My7v469lDGQa759o=;
 b=Yka5PqowiEy2osq3Kmq1uyyvLhL9GJvW+fp2cTDYQwyXEolCyiL5E3g46WeJpx7efh1TrI/yELp00hynVNC53Qc+WO8m4/vvq0KdXReXj+Ug2GPI/NHhF06+1oq6j+N/HojwhG2qd5X9WPRHvctLkDx30PJP0BaRBTkIM06wrV6ixKm7SzKcqBRSd4cgMSz542Z+C4kfPNUOBzhezRpd3Z1UiyogekBereqT9QcM6KqoCUi5oEYHAwWpn0XMsz/kNnvc2qa/HutwIkkxFsQ6mbWfwSFPFzWHuVN0WbustBuPZOHDq4wbZmjVTzp+v4/sP0IgiEgWCUm3EB1G5uWI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjQXvEjqC+JVw6el6XhMyU2dzf7My7v469lDGQa759o=;
 b=arr0Z+l1GxbWz3jNnDmlyTgia1KFhd/WogZ5hz0TZhrph3If9pZZ8N6UEN5DDMSu5AgGlH64npX3/5p8M1U5dv/SlpBm9GLkt4w2XtqVOPyq/UAcmHWp8tgxZR3yqts6zalOtsNK8kBX5vSRqq0g8hK673p7de4q2abLeesarfrp/098DwycDFZPTSWCK0EN5xICPUeMiPHfEZYcIlYTqz2ekMezUfux544DATihc2jA9cZcI02Kz5DpuoBNHawWpI5mEdsXx4TcUmo8+DyZM99clsXyBCl5w1nZZlogUPvKj8B3sVpF8EMVZAlQIQyVC8SxCW13U8F/h+TRL2movQ==
Received: from BN9PR03CA0350.namprd03.prod.outlook.com (2603:10b6:408:f6::25)
 by MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 09:41:35 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::27) by BN9PR03CA0350.outlook.office365.com
 (2603:10b6:408:f6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.13 via Frontend Transport; Thu,
 13 Aug 2026 09:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:41:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:41:19 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:41:10 -0700
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
Subject: [PATCH v4 26/27] Documentation: vfio-pci: Document CXL Type-2 device passthrough
Date: Thu, 13 Aug 2026 15:06:30 +0530
Message-ID: <20260813093631.2288172-27-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813093631.2288172-1-mhonap@nvidia.com>
References: <20260813093631.2288172-1-mhonap@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MN0PR12MB6199:EE_
X-MS-Office365-Filtering-Correlation-Id: 521db455-40f8-4336-149c-08def91f1084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|7416014|376014|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	yDXW+pOrHDOWWstrz1Rhjkl8teT0Os7ke/VEUMYWCy+paF9TSiesc745W0FLcrz9xWTzlXeVZnC6bybqir56TluGjfwqE+Krd5U460FQ5dPpAR1o44SDcEoIxc3qTtcjfErAKLGbBBa6flBYpBqcj84jzj3aRGmfn48WQJAp/GYn0Whr/XNPTKllqV46BBIg6U07lgyAiIIewlaQGSZZtkQFeOtT4bScGOxyWZVRw7T2NwubBXV3VTu+KsqRqPmGpZAuu3kkHBXOtGY58babtTJ6CYv8lC5nDWjbIwROqetY3ZEeX7XaJ111COY0D5DdDr+JZ10PNOMTIoV/I+mwrFylMYiRofcf3+HKlrmfDTFl/rtBznlOtNbOntkQWihYvtqXwvQx6Tn3A7cDWGTgpmA1yxjw1ydDSe1ivlSfcyXeA0UKfpLr94stpiEtBbnNj5swR7+NGk6Ves2jJY9gwWYigs0LVrHDzzBbWxGKv32qMVzRIYzLIJ7UaZhKfqdXYu33ageeYjr+wtE9Xv0GEQGhlOHBbpP7lc+1dxVDpp1NJ/PUWtpAXDpNyvwhkVaTSZexK0YWvWtRf4oPYf3Mu7LgXH153KG7fomWgTn2ZpADQkkdgREWhL7baDm4YEqJI/GYORzylIj/U7ZNVIk10xjdD2hz1rdW0eXYR/9DynF4lZrjdQXSZ1rUB1vZhrUo3i7xZMD+zqBI/T+AwKjpqiqFQbRMlocQ+bJMZPB7ydDhzxHU1n7z2Fnz3mWc+GXf
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(7416014)(376014)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xyNxU2+P1cnFymFVgLi8HkTyYYu7PCJmpC9jGaaWbFsRMupSuH1nj5uFvplWXzOcbtolcSjydhXguE4COdas2KK8Hz9Ncb8C8OAET5D5ckd0ePskmbq/w1/C40X0bN4hct8hbrB+p0r7YUZpwv4bQmuQD3W/vqlOHTn5ykuShZa+i1maJzwc/PKq0s0oTaP5EwSnmYDgzBCFQPkzjlM/NUrDCcLp8+m7JbrK8jl5P0kOuJxRiwfRRWjBw7XVBPA+8Qln+3l+9P+vb+f8XdzN4W1OptAXPqw/zW2lOGTeBB3qpBQkTrZOGTpq60z18AlNDQW7NzFTHrXFOeS4cVpWmsB3l2vm5d0ORxQhYGLvAzT2PhiRGq2/zuYsNbKz8FFFIKgnEUj1Mp78UEnedB9rj/cRKkFQYYIxF00Dn179Eax2jsWe6iFlftz07x2Nbvmw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:41:34.7769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521db455-40f8-4336-149c-08def91f1084
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199

From: Manish Honap <mhonap@nvidia.com>

Describe the vfio-cxl provider module: the address model, the two regions,
the guest decoder commit handshake, DVSEC virtualization, and the reset
contract, so the supported topology and the kernel/VMM split are on record.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 Documentation/driver-api/index.rst        |   1 +
 Documentation/driver-api/vfio-pci-cxl.rst | 141 ++++++++++++++++++++++
 MAINTAINERS                               |   1 +
 3 files changed, 143 insertions(+)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index eaf7161ff957..7578f5528c28 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -46,6 +46,7 @@ of interest to most developers working on device drivers.
    uio-howto
    vfio-mediated-device
    vfio
+   vfio-pci-cxl
    vfio-pci-device-specific-driver-acceptance
 
 Bus-level documentation
diff --git a/Documentation/driver-api/vfio-pci-cxl.rst b/Documentation/driver-api/vfio-pci-cxl.rst
new file mode 100644
index 000000000000..84b41a8761a0
--- /dev/null
+++ b/Documentation/driver-api/vfio-pci-cxl.rst
@@ -0,0 +1,141 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================================
+VFIO-PCI: CXL Type-2 device passthrough
+=======================================
+
+Overview
+========
+
+A CXL Type-2 device is an accelerator (for example a GPU) that exposes
+host-managed device memory through an HDM decoder. vfio-pci alone does
+not expose the HDM decoder registers or the CXL Device DVSEC, and it
+does not place device memory at a guest-chosen address.
+
+The optional ``vfio-cxl`` module provides that. It is a provider for
+vfio-pci-core. vfio-pci-core does not implement CXL registers; it loads
+``vfio-cxl`` when it binds a CXL device.
+
+Address model
+=============
+
+Device memory uses three address spaces: DPA (device), HPA (host
+physical), and GPA (guest physical). The host kernel assigns the device
+memory a host physical range before the guest sees the device. The guest
+only chooses where that memory appears in its own physical address
+space, by programming a virtual endpoint HDM decoder. The guest does not
+reprogram the physical decoder.
+
+The kernel holds the HPA and does not see the GPA. The guest programs a
+GPA and does not see the HPA. The VMM holds the device fd, reads the
+committed base from the decoder-register shadow (the trapped component
+region described below), and maps the HPA-backed region at the GPA the
+guest committed. The base the guest reads back is the GPA, not the HPA.
+
+Driver model
+============
+
+There is no separate PCI driver. vfio-pci binds the device. During bind,
+vfio-pci-core detects a CXL device (``pcie_is_cxl()``), loads
+``vfio-cxl`` with ``request_module()``, and calls the registered
+``struct vfio_cxl_ops``. The module reference is pinned for the bind
+lifetime so ``vfio-cxl`` cannot unload while a device is bound.
+
+A non-CXL device, or a CXL device whose CXL setup fails, uses the
+ordinary vfio-pci paths.
+
+Regions
+=======
+
+``vfio-cxl`` adds two regions under ``VFIO_REGION_TYPE_CXL``:
+
+``VFIO_REGION_SUBTYPE_CXL_MEM``
+    The HDM region, backed by the fixed host physical range. It can be
+    mapped with mmap. The fault handler inserts the host PFNs, including
+    2 MB PMDs when the mapping is aligned. The VMM maps this region into
+    guest memory at the committed GPA.
+
+``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``
+    The trapped HDM decoder registers. Access is read/write only (no
+    mmap) and must be dword aligned. A misaligned or out-of-range access
+    returns ``-EINVAL``. The kernel serves the registers from a per-open
+    shadow and runs the decoder state machine on writes. The region
+    includes a ``VFIO_REGION_INFO_CAP_CXL_COMP_REGS`` capability that
+    reports the component BAR and the offset of the decoder block within
+    it, so the VMM can place the trapped window at the address the guest
+    expects.
+
+The rest of the component BAR is a normal vfio-pci BAR.
+
+Guest decoder and commit
+========================
+
+The guest programs its endpoint decoder through the trapped region: it
+writes a base (a GPA), a size, and then the COMMIT bit. The host has
+already resolved the host physical placement, so a commit always reaches
+COMMITTED in the shadow. The physical decoder is not written. A decoder
+committed with LOCK_ON_COMMIT stays frozen until the device is reset.
+The shadow is sampled from hardware at each open, so a reset clears the
+frozen state on the next open.
+
+The VMM observes the commit, reads the committed base, and maps the HDM
+region at that GPA.
+
+CXL Device DVSEC
+================
+
+The kernel virtualizes the CXL Device DVSEC body through the config-space
+permission hooks. Reads and writes inside the DVSEC body use a per-open
+shadow. A guest write stays in the shadow and does not reach hardware.
+Accesses outside the DVSEC body go to the device as usual.
+
+Reset
+=====
+
+A guest triggers a CXL reset by writing Initiate_CXL_Reset in the CXL
+Device DVSEC. The kernel revokes the HDM mapping, saves and restores
+config around the reset, runs the CXL reset, and writes the result into
+DVSEC STATUS2 for the polling guest.
+
+Host-side resets (the reset ioctl, an FLR through config space, and a
+bus hot reset) revoke the mapping the same way and restore and re-sample
+the decoder shadow afterward. Because the kernel re-samples the
+firmware-committed decoder, the shadow returns to the committed state
+without a new guest commit.
+
+A guest that had decommitted an unlocked decoder therefore issues no new
+commit. If the VMM dropped its mapping, it must rescan the decoder after
+the DVSEC reset, the D3hot->D0 transition, and an FLR. No new commit
+will arrive. A committed, locked decoder cannot be decommitted, so this
+only applies to the unlocked case.
+
+UAPI
+====
+
+``VFIO_DEVICE_FLAGS_CXL``
+    Set in ``VFIO_DEVICE_GET_INFO`` flags for a CXL Type-2 device.
+
+``VFIO_REGION_TYPE_CXL`` with ``VFIO_REGION_SUBTYPE_CXL_MEM`` /
+``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``
+    Reported through the region-info ``VFIO_REGION_INFO_CAP_TYPE``
+    capability. Userspace finds each region by scanning for the type and
+    subtype.
+
+``VFIO_REGION_INFO_CAP_CXL_COMP_REGS``
+    On the component-register region, reports the component BAR index
+    and the decoder-block offset within it.
+
+The HDM decoder register layout is available to a VMM without a private
+kernel header via ``uapi/cxl/cxl_regs.h``.
+
+Scope
+=====
+
+This support covers a single, non-interleaved endpoint decoder on a
+directly attached device. Multi-decoder devices, interleave, and
+switch-attached topologies are not supported. The interfaces are
+structured so those cases can be added later without changing the UAPI
+described here.
+
+A selftest, ``tools/testing/selftests/vfio/vfio_cxl_type2_test.c``,
+exercises the interfaces above on a bound device.
diff --git a/MAINTAINERS b/MAINTAINERS
index aa8cecbc4cf2..b9361a8d618e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28317,6 +28317,7 @@ M:	Manish Honap <mhonap@nvidia.com>
 L:	kvm@vger.kernel.org
 L:	linux-cxl@vger.kernel.org
 S:	Supported
+F:	Documentation/driver-api/vfio-pci-cxl.rst
 F:	drivers/vfio/pci/cxl/
 
 VFIO DRIVER
-- 
2.25.1

