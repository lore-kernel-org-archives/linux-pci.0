Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82554E1C8A;
	Wed, 16 Sep 2026 18:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584076; cv=fail; b=s+4OFwI/c0bKoLv5FejmrndVHL7mTzcQx+K3r1ROm+ukus5lllTRtydH5v2dwxkswKYJEk8TAlnGb6H37PfCInA40kurvsSbBbrM7gpa58YyWbbrgNNc+4gmTVmt9R+dN4vIAmuDekGr5jrfqK/w3fsjWuQiW0gUvhQzQqwX6jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584076; c=relaxed/simple;
	bh=uCH3of8H6Pmgt60E8EMsxYTAB38aoZhpV9xK8VrU5AI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQqXiOdAxklr/87HQSyyZBBNfYM0WpyXF+7CXW+6VZNdhT20gcI1pa8T54sj5XmVB0w5s0YmA6qNNy7ZD4GvYEM1Ih5g3qNxjV0E/6CFl5KRWQnVpl5kgcfqcHZ4Cm/feUe1RFoXWq64xkAHTmxzl2bwIpGQ+NTEW5IugrNN54c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p1Ja/Cjl; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p1Ja/Cjl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/ubPvxsLScf5lsKuRB3V/fCcAmPEZKL2J16R/C965FXSQPOgCuNnMX/N/M4dHPCQwwyEsQ/uHQlEUXvsuPyZ2uBzhYg8sJdSs1SWDQYkR4KSZ9/H6lB3Nt6NhKuw+sNSHO1agihcVwM4uYy7ZYhF9aej2LWwWJTGUceQYICn5pDEU57G2cfjXLp+PeWGni0Tm4rGWDmsBwKGPQ9BVEa613xMjI7PIrVBZUtnGEUawlTAHkDDayFbVsAuac+JH3BYF+zfOip4AkyvKwiolGVwbs5r2Xe1PcWwpqJnLlJxPIZ1LZ8mZ4irlJ49BCXSQfoth5tuWJp+QaNCbjAqZeFPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kajfhufj2/eSyaO/zSKH5NeY98FwM8ceIG3XqsGzjeE=;
 b=fl0g4q86tn3Pn5umiHZy5M1ZG8izxZPzM0EDQDlrIeJxJNuHDWfrcctE7q57sAHW9g5TKDXBCO5hU/z3inHcqUo0IU1382/5PxJof7Fiz24yvtpphp2T+v2TafYKZd/2ultSlxycTuo3Zd5xo5Hz8HdYz9OruOH++Ow8naU0Q/lZahYUrum2C9MJ+EkpXy4y0pSYObUf0JQ6RtxUgCMhcklLsS2hb2ygwYKI3SrEk86D1dE6mWRYG8l881v/nmxfZ/W65BZjLv1JOClWK8KEHhC1vo1E0L0p04AidU++EgwFn+TyaHQtfGO3FLhOAG4qnDR6Kxw7Ih/BnxxhCymumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kajfhufj2/eSyaO/zSKH5NeY98FwM8ceIG3XqsGzjeE=;
 b=p1Ja/CjlHDtuIuF3nYJaqEB/5+As47uBHrIoWj+nFAf5h5qMPLE/IDrLJmuIJaY0lF2zW8U0hZw3CkwyBS8EGC6LxXb2QaT8QVCHRcfpSKIHqC/bZT5LJm1Joa2XL7ajrUCMhWrQhYDS7+r6mc9OYHbl6WE6LXWFQvMkjru6txMhy7dil14ndJNUiYDYksBDErj11alLrFs7GSoaW1nrDma+8kUXRwi93LjwqdNQz++uYUw9q+fugRnbOgCEHUs/2YfjFbAdKYSJxy0aQubnIgYnoGb5+ptBybMKQEn6TI28/4BHfUdgjcQfLXLnbb02Y8FZo8job3jA9n37jNl7jg==
Received: from BN0PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:e7::7)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:40:39 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::4a) by BN0PR03CA0032.outlook.office365.com
 (2603:10b6:408:e7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 18:40:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:40:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:40:07 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:39:58 -0700
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
Subject: [PATCH v5 26/27] Documentation: vfio-pci: Document CXL Type-2 device passthrough
Date: Thu, 17 Sep 2026 00:05:39 +0530
Message-ID: <20260916183540.3813685-27-mhonap@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260916183540.3813685-1-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: c5f4e355-98cf-4032-8ced-08df14220174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|56012099006|11063799006|921020|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	r/2OXxzZA0xdtiQ7GA56NDq7ymnQX/hnz/5kFJqThzI2mBxlUj4RBgV3GiFxUHIJ026m0Mr+5L70vk8ubsxUrQuWyy7y8FwgdoC4ko3C2kno8BIKoz9XKPcWQ3lfcTjS9aVZD8V5BRVkcLg38gZjfwAFH5FG3TQJbzOB+2+lCHa0mZta10RGEhZahkcVrrMZQ1xuIlJNc66ihaAhMor5ZM2/e3ybh4fBpXvK7eb09yUjXFkmZULx5B+kxfoHJFpl3t95znqh4wiDWzynC9wXLUpwcJ9qPIrrVND+JhYyoIyWW+Jf4mdps1dPYaqqdpYe0M5BdI59JxjyjhmXkT4QhDv3mE0+IoqPiFEbK7LVu6OaGFiRv8j1hK4fHXaLQuxNDlJA9TSa2ttO2Y60VzqIP7ufDEqp+CjXWmNAVOFzjgJ07+zh6xq3AKhOoFq7B913kJtmFzXkRlZLPKaXb5TrVrYbn/RJ+oP/KXqO/63LF4bv1dwSUaJ6Wx9ot1WuogU5DNwFemyRYoiOQTjvMgjZCptfGAlEcrjNEtpuF/8yhj40me/AZKye5r7DjQ4x0H7sCVsmfJD59mRp+uhzJ/GhdtUY6f/oG3s9z1h2bABAiUgzwGLQNXTN7spdvi4nYhNOClIssbxGvEQn/zr749fcFA/GBSQwRuFoo08544ZysZkxh/TE9Cu0HIBvAYVmhi8VLQYv3Evr6SID7xXo5f5qnA++ojsoXypHOQy6UBNyywtxSfmpLWggxL4TE1Ybsw+v
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(56012099006)(11063799006)(921020)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PhkJykhBgm/928r8z9zimJZRweYaAWnYM4XbfiLueexQMkueJZ8t+yALU9dN61C6bYUIVOnfx7m2wtL9rgX473aaaqGoMj5CG9BcYxY0bwEGZ2enyBLEQ4g8GZeED4wLSfL+6L+0fbzVoPKY+rW2f6W+2mTsQb5rNtFyL8FKGBLn09op0zo36BnAaMv0BAzds+l6hyMAFs+q7WVhqO06JoI56zAibOa3qKG1xPzxkBnbr/maAIQSxzdFL10N1l6GmECo0sF/2ZM0RQ0/Vos3MH7JY9UrvV8h+0pCZDUF4FazGmPWpW/TAjxtH9gstshQULLtDKaJFbha4+lCOo5J49Sq/fqwsfmEOsR+LMirAsMZfomXkKOmss+G0EpJdXZvCwvAL47ObPlE5VC+rSgR84rEZTe1mNxqEB2DymrxA9+Rpzt+AsxLwrU23VgrpWol
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:40:39.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f4e355-98cf-4032-8ced-08df14220174
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299

From: Manish Honap <mhonap@nvidia.com>

Describe the vfio-cxl provider module:
- Address model,
- Two regions,
- Live decoder region and the guest commit,
- DVSEC virtualization,
- The dma-buf export for iommufd stage-2 mapping,
- The reset contract

so the supported topology and the kernel/VMM split are on record.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 Documentation/driver-api/index.rst        |   1 +
 Documentation/driver-api/vfio-pci-cxl.rst | 188 ++++++++++++++++++++++
 MAINTAINERS                               |   1 +
 3 files changed, 190 insertions(+)
 create mode 100644 Documentation/driver-api/vfio-pci-cxl.rst

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6601a258690f..733ea1b64c72 100644
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
index 000000000000..d33163df33b4
--- /dev/null
+++ b/Documentation/driver-api/vfio-pci-cxl.rst
@@ -0,0 +1,188 @@
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
+not expose the HDM decoder registers or the CXL Device DVSEC, and it does
+not place the device memory at a guest-chosen address.
+
+The optional ``vfio-cxl`` module provides that. It is a provider for
+vfio-pci-core, not a separate PCI driver. vfio-pci-core stays free of CXL
+knowledge and loads ``vfio-cxl`` when it binds a CXL device.
+
+Address model
+=============
+
+The HDM memory is a coherent host physical range (HPA). The host kernel
+resolves that range before the guest sees the device, and owns it for the
+bind lifetime. The guest only chooses where the memory appears in its own
+physical address space (GPA), by programming a virtual endpoint HDM
+decoder. The guest never reprograms the physical decoder.
+
+The kernel holds the HPA and does not see the GPA. The guest programs a
+GPA and does not see the HPA. The VMM holds the device fd, reads the
+committed base from the decoder-register region described below, and maps
+the HPA-backed HDM region at the GPA the guest committed. The base the
+guest reads back is the GPA, not the HPA.
+
+Driver model
+============
+
+There is no separate PCI driver. vfio-pci binds the device. During bind,
+vfio-pci-core detects a CXL device (``pcie_is_cxl()``), loads ``vfio-cxl``
+with ``request_module()``, and calls the registered ``struct
+vfio_cxl_ops``. The module reference is pinned for the bind lifetime so
+``vfio-cxl`` cannot unload while a device is bound.
+
+At bind the provider creates the CXL memory device, takes ownership of the
+whole component-register BAR, and (a Type-2 function has no mailbox) marks
+the media ready directly. A non-CXL device, or a CXL device whose CXL
+setup fails, falls back to the ordinary vfio-pci paths; the failure is not
+fatal to the bind.
+
+Regions
+=======
+
+``vfio-cxl`` adds two regions under the PCI vendor-type region
+``VFIO_REGION_TYPE_PCI_VENDOR_TYPE`` for the CXL vendor (0x1e98):
+
+``VFIO_REGION_SUBTYPE_CXL_MEM``
+    The HDM memory region, backed by the fixed host physical range. It can
+    be mapped with mmap. The fault handler inserts the host PFNs, including
+    2 MB PMDs when the mapping is aligned, but only while the device is in
+    a state where a host CPU access to the range is safe (Memory Space
+    enabled, media ready, and the decoder not mid-reset); otherwise the
+    fault takes ``SIGBUS``. The struct-page-less range is registered with
+    the memory-failure machinery so a memory error can be contained. The
+    VMM maps this region into guest memory at the committed GPA, and can
+    also export it as a dma-buf (see below).
+
+``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``
+    The HDM decoder registers. Access is read/write only (no mmap) and
+    must be dword aligned; a misaligned or out-of-range access returns
+    ``-EINVAL``. Reads are served live from the committed decoder. Guest
+    writes are absorbed: the host already programmed and locked the
+    physical decoder, so the register block is read-only to the guest and
+    a write is dropped rather than forwarded. The region carries a
+    ``VFIO_REGION_INFO_CAP_CXL_COMP_REGS`` capability that reports the
+    component BAR and the offset of the decoder block within it, so the
+    VMM can place the trapped window where the guest expects it.
+
+The decoder register range is also excluded from the direct component-BAR
+mmap and from host-side reads and writes: a kernel read of that range
+through a mapping could abort on the fabric as a host SError, so reads
+return ones and writes are dropped. The rest of the component BAR is a
+normal vfio-pci BAR.
+
+Guest decoder and commit
+========================
+
+The guest programs its virtual endpoint decoder through the trapped
+region: it writes a base (a GPA), a size, and then the COMMIT bit. The
+host already resolved and committed the physical placement before the
+guest ran, so a live read of the decoder always shows COMMITTED and the
+guest's commit poll completes. The physical decoder is never rewritten;
+the guest's writes are absorbed.
+
+The VMM observes the commit, reads the committed base, and maps the HDM
+region at that GPA.
+
+CXL Device DVSEC
+================
+
+The kernel virtualizes the CXL Device DVSEC body through the config-space
+permission hooks. Reads and writes inside the DVSEC body use a per-open
+shadow; a guest write stays in the shadow and does not reach hardware.
+Accesses outside the DVSEC body go to the device as usual.
+
+The self-clearing Control2 doorbells (Initiate CXL Reset and Initiate
+Cache Write-Back and Invalidate) are never forwarded to hardware. The
+kernel synthesizes their completion in the shadow so the guest poll
+finishes, and runs the real operation at the vfio reset points (see
+below).
+
+DMA and iommufd
+===============
+
+A Type-2 accelerator issues ATS-translated DMA to addresses inside its own
+HDM window, so that range must be present in the guest IOAS that backs the
+nested stage-2 translation. The HDM range is struct-page-less coherent
+memory, which a userspace-VA ``IOMMU_IOAS_MAP`` cannot pin.
+
+The HDM memory region is therefore exportable as a dma-buf:
+``VFIO_DEVICE_FEATURE_DMA_BUF`` on that region returns an fd that iommufd
+maps with ``IOMMU_IOAS_MAP_FILE``, mapping the physical range without a VA
+or a page pin. The dma-buf is revoked whenever the mapping is torn down
+(reset, power transition, teardown), so a stale stage-2 mapping cannot
+outlive the HDM window.
+
+Reset
+=====
+
+A CXL Type-2 function must not take a Function Level Reset: an FLR resets
+the coherent CXL.mem state and the HDM decoder. The PCI core reflects this
+by preferring the CXL reset over FLR, so a function reset of a CXL device
+runs the CXL DVSEC reset sequence, which resets the function and then
+restores the HDM decoder and the PCI config state.
+
+A guest requests a reset by writing Initiate CXL Reset in the DVSEC. That
+write only stamps completion in the shadow. The real reset runs at the vfio
+reset points (the reset ioctl and a virtualized FLR through config space):
+the kernel zaps the HDM mapping and revokes the dma-buf, then runs the CXL
+reset, which always clears the device memory, and restores and re-samples
+the decoder afterwards. A CXL port masks Secondary Bus Reset by default, so a
+``VFIO_DEVICE_PCI_HOT_RESET`` does not reach the endpoint and the HDM
+state is untouched. If the port has SBR unmasked the reset can decommit
+the decoder without restoring it, so the reset_done handler gates HDM
+access; a ``VFIO_DEVICE_RESET`` then runs the CXL reset sequence and
+restores it.
+
+The decoder register region is served by live reads of the hardware
+decoder with guest writes absorbed: the decoder is committed and locked by
+the host, so a guest can neither decommit nor reprogram it, and the kernel
+keeps no shadow of the decoder state. After a reset the kernel restores and
+re-samples the firmware-committed decoder, so the geometry the guest reads
+back is unchanged. A VMM that dropped its HDM mapping, for example across a
+reset or a D3hot->D0 transition, must rescan the decoder and rebuild its
+stage-2 mapping before it resumes HDM access.
+
+UAPI
+====
+
+``VFIO_DEVICE_FLAGS_CXL``
+    Set in ``VFIO_DEVICE_GET_INFO`` flags for a CXL Type-2 device.
+
+``VFIO_REGION_TYPE_PCI_VENDOR_TYPE | 0x1e98`` with
+``VFIO_REGION_SUBTYPE_CXL_MEM`` / ``VFIO_REGION_SUBTYPE_CXL_COMP_REGS``
+    Reported through the region-info ``VFIO_REGION_INFO_CAP_TYPE``
+    capability. Userspace finds each region by scanning for the type and
+    subtype.
+
+``VFIO_REGION_INFO_CAP_CXL_COMP_REGS``
+    On the component-register region, reports the component BAR index and
+    the decoder-block offset within it.
+
+``VFIO_DEVICE_FEATURE_DMA_BUF``
+    On the HDM memory region, returns a dma-buf fd for
+    ``IOMMU_IOAS_MAP_FILE``.
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
index 75d472d7ca07..ab099b523054 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28644,6 +28644,7 @@ M:	Manish Honap <mhonap@nvidia.com>
 L:	kvm@vger.kernel.org
 L:	linux-cxl@vger.kernel.org
 S:	Supported
+F:	Documentation/driver-api/vfio-pci-cxl.rst
 F:	drivers/vfio/pci/cxl/
 
 VFIO DRIVER
-- 
2.25.1

