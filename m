Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011065.outbound.protection.outlook.com [52.101.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E14D9F70;
	Wed, 16 Sep 2026 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583993; cv=fail; b=ZPlftHvD4J1WdoePmwRZYzmnRrOHA1IrWxVVdIWFg5LMhkTAM/+5OKm8Z5V6lPtexsAJTyr4MUYBnuacOz5qYpZwjj7RjGIXWj4d7N34PYOS9hDvTEq5PIxqne9IVjqr7RhdSxRLv1KvsidZOH0luVZb7xmgo07QGNI/13DxGtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583993; c=relaxed/simple;
	bh=cdFDkLCnerfauYCxO8qLzrbnTicxnXXAzcbiau6Xl7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CD+CNRRlQD8ESq0t/uFuBCLff78/UAKcHtEVhBeUrixxCPdVVEn9FMa3E3hZHUDamU4JkYE4L+OkBoWu3ekBTFz7gvylz68HGArXkJq3udUcp7Iq1UbCPbHDHCoiYm1Dm5jmJH+Khyg0UxM3d96XunmkXkbF0V4WtSCbbyZGNCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MwcpEUIY; arc=fail smtp.client-ip=52.101.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MwcpEUIY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEUVFUyZwa2WhFHr6aUUvuhsy33NR9rOTELd46S2D4RCa8r/duumY32Z7/KCNh6gp8B4LTKQX8w8FS65Xos7ecwwE7btglXvOwdwxNE9TTDdeaVwdV+ozOmOJiTf6YXMkIXV2IrOCjCDS9AMN05JLj31huttdc0iirlCNrPtPGIED5hO4qzFRbUEIZ/quKXXdFgKhXfIgWn2yc/pHd1ior70kYiDJPiKJ+sFL4H7K0cSdtyOCaMNDv27YZZeKJyfWy9NJPGhRbpX7qfhFwFB/eNmY9ZmvxP4S97G3L3wHA++MAvjMI2YTHCYpI40LnGD3RYigeQDvZOjKF556gdq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVrfUEzNBma90oBP7wSuMezE00a7EpeFy6+kNyo8iF8=;
 b=DTVlxTkbeySiqu/4uFHycf/vF4M4yOflSblhAz1wVGae8nfvKlnkRkxN0DdyUSOmm5FuKLM7pV1kpeIfgTPdISF50FWaeajGHNTMTztNyNms5X+cJ3D6JKidRgiEtRxOB0mPNWlIPeL/GdHSWg1LalkaSy9Cnzn39z5I5Jzj2uWzUTLmHi4oOKsAiCgO6t3qLokHHizRK8gY1IJ+sIJvuSCSCzQClhqXj80HgJobRfvAGhq55xyh4SlapOP8rdkqFBhOUOfA29R7qintQtrlKnX4p/+vAu8qMYfb/gVT3vgWOSxfUgDLpYoxw8qoNg/TghY9PrPKog01GkxCZnb+Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVrfUEzNBma90oBP7wSuMezE00a7EpeFy6+kNyo8iF8=;
 b=MwcpEUIYESDiR3qDuQLc3nRd3TUAX4pLEJPJ4DlhmnatXkPpWwfO0jOp5Qe7bLfWmUhU6os9n08Y2NwbYuOpZpxQ6LBOTnJBVl2cyG5MmB5Ie2ZV1zJc8vZZx0vxQ85Zq2e5tl3WyXsYRksrE3cwiGXxw3wOlSmAGYnVdLJ6twzdjMgLuheFH6jqW/JRBebJcIOzbo3zUlzH4ZM9j1vFhmc0HBOMjnwbHPNNgqLhzwPxl+lMBCHaRKubpMraHIrOUlkl120Xe1G/2INrSqOiSKTfvyXPFbLWfqWKz+w4lu2EmOnnChQ25rhyGOzVpgphXTjc0XI1uMqOJhI3SgrEKw==
Received: from SA1P222CA0099.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::13)
 by SJ1PR12MB6244.namprd12.prod.outlook.com (2603:10b6:a03:455::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:39:02 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::12) by SA1P222CA0099.outlook.office365.com
 (2603:10b6:806:35e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:39:02 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:38:35 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:38:26 -0700
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
Subject: [PATCH v5 16/27] vfio/cxl: Create the CXL memdev and set media ready at bind
Date: Thu, 17 Sep 2026 00:05:29 +0530
Message-ID: <20260916183540.3813685-17-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SJ1PR12MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bd8320-5db5-4428-3172-08df1421c78c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|1800799024|36860700016|921020|22082099003|18002099003|10067099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	6/Q9yQKgzvJbBBvxklPqU2Jd0pmDdHz2AOLVqjaWMyuIaX5lhPdkoIgUEvk3tQAvJxoOMSPpQFzGTZ6CaL4JD6J0BPdZXcs9IBjH+cUzOTAMn2gIhKfgEUJ/zSLKblit6m6AdzhwIW8Q3fTZzXnW2Wrc4hUPhiuVKzIcaUix/YRLZSCqOXXxwN5FtQ8+34V3sfGCMUCNnEEKLsFEzXcaSAysao4R45dtvClEWJ0/1YjoPOC7NdkgVSd2VWZHOFEvtmxbXd4RG+tb9ljQRMi1eACP3Me5l/tOz+TE1Jg2rMfiTGlgpnYjhcOOuG+e/iIa6z6GkOPgH/lx7Ai7MhiZcUvBTl7rzgb6DRBtaD0r23pS2+OJjdnaAdE4sT1IfVau/Dl/FpkbGk7d/LJGK4G3hi5DScrXfUYS6G4OkJoLEnGil4XbQNLDOF711fs0YEWfyYQerigLlhg7naXbffFRhSkVG/yoB9ge/A5+Nucph34paTAPih6WR81a1SxLZTgWEOwPbNfu5tnEpBykvwKmZkNkWc/JxCYhgiqKpB/IfkoVZQaladhhFXHKOEbW6vyhYEdB3l3qWz0jPiJrbTFqv+50UqgqxrgL/Nd/J/n1fJ0GepDfbl0RCB2+mvbHi/DCsDMr+STyTjOhcarBrJeKX09cPFXxD7ZxRYBToSr+WzSHk/LdJu6yoV/lmMDWGcraqUPjdpyznimhQDmDyqTkcXFX2E4ane1WqEal//kPpC05WLtH4/Qf3401f6l/ktv2
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(1800799024)(36860700016)(921020)(22082099003)(18002099003)(10067099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cIiryMMXDiUEMmKbgjOmQoIebWzvwCSo4WAjFReeebdhKsCmCE4ho93O4L9P9Kq9jkA6TjukxhQLeSl5vhJfFCcXOmWhPQ2tLSic0vBH1+tUviIPuEM+sx3q+tp2pINDYvr96ut/Cj5gOXiC3envHjgdp2FY/pg4UtJrxckVF+iLQPPWpFSGtIKL+EhTH/rPd1TiAruR5Jm2O65y6yTnzj6ILkZ1DZVJko88fb2xPtK1mwCTLGOte504leTNCoZmSnvNLWOE4kotZMbcHMCfwe0LXc4wB61+VYIlXNc9NXndp8oGNqq0iJ0wPkQTkHF1EUX9lxtHUsNx00sX96abFMuBNnLREqByds8AnA5uOXRVkrrLlJTOPmD5OcHQxBFS2iV/P6Zpi9OUV8UMh795hWOsrziOBUl0h0RVFAZnwOvHlIOwHWd3A1YIWHwMoc0Y
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:39:02.2807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bd8320-5db5-4428-3172-08df1421c78c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6244

From: Manish Honap <mhonap@nvidia.com>

At bind, build the CXL memory device for the passed-through Type-2
accelerator so it joins the CXL topology and its HDM region resolves to a
host physical range. A Type-2 device has no mailbox, so there is no
media-ready register to poll: set media ready directly once the component
registers validate (mirroring drivers/net/ethernet/sfc/efx_cxl.c)

As per current vfio-cxl support, reject a device with:
- more than one HDM decoder
- interleaving enabled
- whose reset the host cannot service

The CXL-core allocations are grouped with devres so a failed bind unwinds
them: init failure falls back to plain vfio-pci with the device still
bound, so devm would otherwise hold them until unbind.

A low-power transition would reset the CXL Type-2 function and lose
its CXL.mem contents, so keep it in D0 while it is assigned.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 118 +++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     |  16 ++++
 2 files changed, 134 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index cd5d41856404..0d92e6a409c1 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -6,15 +6,132 @@
  */
 
 #include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/range.h>
 #include <linux/vfio_pci_core.h>
+#include <cxl/cxl.h>
+#include <cxl/pci.h>
+
+/**
+ * struct vfio_cxl_state - per-device state for a vfio-cxl device
+ * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
+ * @cxlmd: memory device joined to the CXL topology at bind
+ * @hpa_range: host physical range of the HDM region
+ */
+struct vfio_cxl_state {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+	struct range hpa_range;
+};
 
 static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
+	struct vfio_cxl_state *cxl;
+	struct cxl_memdev *cxlmd;
+	u64 hdm_size, serial;
+	u16 dvsec;
+	int ret;
+
+	/*
+	 * pdev->hdm is cached at PCI enumeration, before any driver binds, so a
+	 * device without it has no usable HDM decoder. Fall back to plain
+	 * vfio-pci rather than deferring the bind forever.
+	 */
+	if (!pdev->hdm)
+		return -ENODEV;
+
+	/* The guest drives one virtual decoder; multiple are unsupported. */
+	if (pdev->hdm->decoder_count != 1)
+		return -EOPNOTSUPP;
+
+	/* An interleaved decoder cannot be mapped 1:1 to the guest. */
+	if (pdev->hdm->settings[0].interleave_ways != 1)
+		return -EOPNOTSUPP;
+
+	/*
+	 * The guest drives resets through the CXL Device DVSEC and polls the
+	 * shadow for completion. If the host cannot service a function-scoped
+	 * CXL reset, that request could never complete, so refuse the device
+	 * rather than advertise a reset the guest would poll on forever.
+	 */
+	if (!cxl_reset_capable(pdev))
+		return -EOPNOTSUPP;
+
+	hdm_size = range_len(&pdev->hdm->settings[0].hpa_range);
+	if (!hdm_size)
+		return -ENXIO;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	serial = pci_get_dsn(pdev);
+
+	/*
+	 * Group the CXL-core allocations so a later failure unwinds them here.
+	 * A failed init falls back to plain vfio-pci with the device still
+	 * bound, so devm would otherwise hold them until unbind.
+	 */
+	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
+	cxl = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM, serial,
+					dvsec, struct vfio_cxl_state, cxlds,
+					false);
+	if (!cxl) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	ret = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				 &cxl->cxlds.reg_map);
+	if (ret) {
+		pci_err(pdev, "vfio-cxl: no component registers\n");
+		goto err;
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
+		pci_err(pdev, "vfio-cxl: HDM decoder registers not found\n");
+		ret = -ENODEV;
+		goto err;
+	}
+
+	/*
+	 * A Type-2 accelerator has no mailbox and no media-ready register, so
+	 * set media ready directly.
+	 */
+	cxl->cxlds.media_ready = true;
+
+	ret = cxl_set_capacity(&cxl->cxlds, hdm_size);
+	if (ret)
+		goto err;
+
+	cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl->hpa_range);
+	if (IS_ERR(cxlmd)) {
+		ret = PTR_ERR(cxlmd);
+		goto err;
+	}
+
+	cxl->cxlmd = cxlmd;
+	devres_close_group(&pdev->dev, NULL);
+
+	/*
+	 * Powering a CXL Type-2 function down and back up reinitializes its
+	 * device state and discards the contents of its coherent memory. Pin
+	 * it in D0 for as long as it is assigned so CXL.mem stays intact.
+	 */
+	vdev->disable_idle_d3 = true;
+	vdev->cxl = cxl;
+
 	return 0;
+
+err:
+	devres_release_group(&pdev->dev, NULL);
+	return ret;
 }
 
 static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
 {
+	vdev->cxl = NULL;
 }
 
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
@@ -59,3 +176,4 @@ module_exit(vfio_cxl_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index a91e07181847..ddd6807893fd 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -325,6 +325,14 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 	bool needs_restore = false, needs_save = false;
 	int ret;
 
+	/*
+	 * A low-power transition would reset the CXL Type-2 function and lose
+	 * its CXL.mem contents, so keep it in D0 regardless of the guest or
+	 * VMM request.
+	 */
+	if (vdev->cxl_ops && state > PCI_D0)
+		state = PCI_D0;
+
 	/* Prevent changing power state for PFs with VFs enabled */
 	if (state > PCI_D0) {
 		lockdep_assert_held_write(&vdev->memory_lock);
@@ -373,6 +381,14 @@ int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
 static int vfio_pci_runtime_pm_entry(struct vfio_pci_core_device *vdev,
 				     struct eventfd_ctx *efdctx)
 {
+	/*
+	 * Low power entry lets the PCI core autosuspend the device to D3hot,
+	 * which would soft-reset a CXL Type-2 device and lose its coherent HDM
+	 * memory. Refuse it for CXL; the device stays in D0.
+	 */
+	if (vdev->cxl_ops)
+		return -EINVAL;
+
 	/*
 	 * The vdev power related flags are protected with 'memory_lock'
 	 * semaphore.
-- 
2.25.1

