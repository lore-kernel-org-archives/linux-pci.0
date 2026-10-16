Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819553C3B5;
	Fri, 16 Oct 2026 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167763; cv=fail; b=B9I4wUKHKNTxVUnpZIS6DYyAjmeKXTRImdL1qYXVFFAm+9EDHUVV8yzsZ6srFxVTID1rHnJHlANLeROmqYprj17HYk5TX1SxDymVzhpg+3/kbjSL4CzCdgKxJblpg7EzUeCP3eovkSI/3GcvZc+ASRzREtApRuTqwXCYcRbPW+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167763; c=relaxed/simple;
	bh=rOvLa/5dw8LFCMM+PTgUmR4KEp/LacXbv1EJQaKFXS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfhA3kAvR5Ez9jLa1VHuRFoPfUhxOPMrE7aCY+xP+lOUXe7FoluJv/Y/KfY/B4+SatqBsNR7Z5XG7nymh1AcVKCna3yeGyoT1sgQxyWIOzDW3uCsk9P+M8WQKeOxeC0k0QHB5pvLFhppRyycCBIIxTLXbf/O68rVMfmOVwvFZ38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mp/GIM12; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mp/GIM12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QeY/1UAx6C3B95/qdudWtu7XE0IZMQ5caKcue6M64Ei+5EbZEoR7rkio4sDKXIuKJCosIMRIXdglN1MDCnJCHFTfeP6f8I5uceqsWt/zeg4c53Ll14lzPE8ikrdYK+nZyn5HU0dOnTXkofWO9VtMNdXQKrmsnSnrrySyZ47Vk9H1kNWpbRRVw8Zg1tHpkSjVrXSGgkrJpYfVb1atswK0tjeYZeSiDrnUkskN9+VP/Vg0/pAYgndGeM+cgl92xZcb9B+rzPOfJdjBKw8srRNKkINAOTalfopObLL/RlTsa/NSxZ4sbjsu8ocBcE4BwUXCBGLdfC7jMOFyF4GfUYAzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez/v1qZxas5AMnjHQUcf+fYaIJ+VsKUPAaula2kIKPA=;
 b=S3yCd33/B0Hri8J46b07Zm8zq9ohAZmMvPX3hXXXgYt5mnoeOSFOtlLYwv65RuqfpmrfQBs0A/igGB+iZ1iYUY1FsGgZaSbromG7aIFZ4G7jG0APOcH9gnH6G//Xa058pCJ/q1/59WCLgB/y1c1nCWoVTwAL7sZEoxNrff84ZPZ7zc5pfCxbm7j8fA73yL76liJZXO1o//L3HYH+JRpC3lIb3TyHzs6st2poIR4p6am53wcypm8eWHjaqFxgkxhPZdrYLWZSUxJPIkeLw9fslFcEnxsQvtm13aHEN3lXlEKyCTrnCK1pJgZpl7WSaXzHLoYdABwJ0gmJMpHtkYtsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez/v1qZxas5AMnjHQUcf+fYaIJ+VsKUPAaula2kIKPA=;
 b=mp/GIM122VKEA4HUpiITm0kHrRkD6V7tIM364GfJE5Q3PCaMaP+lRbRAqyzA2H3zn6cyv2cXZX2JIm5lyq/YYqk0nmVubVGuwB2CWZ++nwx41eFaFHeHbIqW5hKTTw7l5+MEGoZveAB71tgfhW9ou1oNIqL7HJi/gdOVTOtYLrS/CMFjTt+NNQHtmWuYJijljUnbuoO6H3QxYLLWMKFR92wtvt8C9rENI1N/EJr64p/DveYxqvLz/rQVzS1ffx5IoX8tKOAxhGBwTw3fwe5k2/MMhfzCq/ZncSDcPCoKX9tKQ9tBzDMDIjLm6eTOg56/7CjZ8v6A/aL31Arbxpf4Nw==
Received: from CH0PR03CA0419.namprd03.prod.outlook.com (2603:10b6:610:11b::8)
 by MW4PR12MB6755.namprd12.prod.outlook.com (2603:10b6:303:1ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 16:22:16 +0000
Received: from CH01EPF000BE94F.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::4f) by CH0PR03CA0419.outlook.office365.com
 (2603:10b6:610:11b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:22:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94F.mail.protection.outlook.com (10.167.244.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:22:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:21:53 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:21:44 -0700
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
Subject: [PATCH v6 19/31] vfio/cxl: Create the CXL memdev and set media ready at bind
Date: Fri, 16 Oct 2026 21:48:26 +0530
Message-ID: <20261016161839.2765592-20-mhonap@nvidia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016161839.2765592-1-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94F:EE_|MW4PR12MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a38c725-d4eb-4536-cd2d-08df2ba1a4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|36860700016|82310400026|921020|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	sIkOd/DGJ2KERdLH94GhoMSzUQDrR8VSN8uOxUYPREz7QcJEdYyzdMhXoeKLQYo9voNBQCqWFdaYDN3TFJBZzVvDsgtRIntYB1hpIdfO6rVboRv9E7ICS3CmbkSrwj8cRheuzoEcE1z5NzWgffi90NjQ+9w67vBKCtZDiY540+Ma20J91uES44a8KOQu1NKehW3AsfNGvhv9yaDQ7xkUCC4KZRBqD0vV1T+TWNYWky1O8I+trwvseK+tpfys1399kAMIZ+TutYFDYoXhH0Nz1pKeuQwS2Ly74Zd+1k41cQ6reeG3llLPxmNRtcynwh0oBzacY0ETNzeS7F5dPWy6XSwBlciow8vo6QEte/1/RFjo6pZSgHWbFlJEe+uACIKk8b8IsDn2XKAF9XPJ0zQQ0+kKEklR4D2FeLsde4QIVdsFJxW/BVeCoOsDs+0jHJ4/zANJiwakRlQolMhuSppgf/uGL4lYWbgh9TK4YbwME3dL9ZVLWmO2brqqwXLbA1vpOaHjW0ieyJH9zkSdXkPz6Nqc/duFcruJ71xRO5yaN5jdcxj+C4lr2jdMYwNgaK80zcZNEbwk25TOQgub4vjwIvTEZXtMTr/al3NW5E8cg03JoCqSxkC3GFaNGdJGclm7+fqBd6S4CK1/DxWzGdNksU7OxKyfdkuQDSrCqyZdPgCMCqIX2s9O8uniQhz4JbHlQag3g7oyeqFkZUXI58ci7xmGtxrA4IHiG+4M92iYHxDEtdUH0tTfuNlIymyuTxhP
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1Hs6Y8bog7CS8Hwi9weTyfKtEywr7eV/3pApYuI5/EUVCRln07jrxUUTI+VjcXIfrbr5BWqd70s17CLfJwcW3Zc5yVGm8JJ0ER6JnHWSYsXwwWsMhF5bLXhUr4wARwkEcIk6+jPNXwBzr/qzJ4EB2c6fixUwm+WVz6BPi+roPyXrYZKtk/aloa8/RY/PFmqlKOialwJvhG3KOMJyCR0gZpKuIpHwDUfxBI7TpX7Q5FTwZTRAHbMIwMQ0xWBYb90WbPvowgyhEXtV14La6xKqAEzTblvkHmKivqd7w2g0/CEaVh7ESlx/R8SBfpm4oR52dOzx7bT+yDBVefh/Ce4Jp055IAt48oTg7qX4R/BSm/+2x2oZQs0tUjmXdpYyQJJ0HSdF1uEfvGVd4C1aUQDoY6ZQMclu80SIWSgethU4S+Cs02eCV6ZxOquJdOa5J7D4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:22:16.2239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a38c725-d4eb-4536-cd2d-08df2ba1a4c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6755

From: Manish Honap <mhonap@nvidia.com>

At bind, build the CXL memory device for the passed-through Type-2
accelerator so it joins the CXL topology and its HDM region resolves to a
host physical range. A Type-2 device has no mailbox, so there is no
media-ready register to poll: set media ready directly once the component
registers validate (mirroring drivers/net/ethernet/sfc/efx_cxl.c)

As per current vfio-cxl support, reject a device with:
- more than one HDM decoder
- interleaving enabled
- whose reset the host cannot service, including the CPU cache
  invalidation that the reset needs

The CXL-core allocations are grouped with devres, in a helper that
returns on the first error, so a failed bind unwinds them: a failed init
leaves the device bound without CXL support, so devm would otherwise hold
them until unbind.

The device is not kept in D0. Low power loses the committed HDM
decoder, and the host restores the decoder configuration when the device
returns to D0. The contents of device memory across low power are the
user's to keep.

Take the bind-time copy of the cached HDM state with
pci_cxl_hdm_snapshot(), which needs no device lock: probe may run in
a worker on the device's NUMA node that does not own the lock.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 135 +++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index ee49d68d689c..ef1fc715020e 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -5,17 +5,151 @@
  * Copyright (c) 2026 NVIDIA Corporation & Affiliates
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/range.h>
+#include <linux/slab.h>
 #include <linux/vfio_pci_core.h>
+#include <cxl/cxl.h>
+#include <cxl/hdm.h>
+#include <cxl/pci.h>
+
+/**
+ * struct vfio_cxl_state - per-device state for a vfio-cxl device
+ * @cxlds: CXL device state; kept first for devm_cxl_dev_state_create()
+ * @cxlmd: memory device joined to the CXL topology at bind
+ * @hpa_range: host physical range of the HDM region
+ * @hdm: copy of the HDM state cached at PCI enumeration, taken at bind
+ */
+struct vfio_cxl_state {
+	struct cxl_dev_state cxlds;
+	struct cxl_memdev *cxlmd;
+	struct range hpa_range;
+	struct cxl_hdm_info *hdm;
+};
+
+/*
+ * Create the CXL device state and join the device to the CXL topology. The
+ * caller groups these devres allocations, so return on the first error.
+ */
+static struct vfio_cxl_state *vfio_cxl_create_memdev(struct pci_dev *pdev,
+						     u64 hdm_size)
+{
+	struct vfio_cxl_state *cxl;
+	struct cxl_memdev *cxlmd;
+	u64 serial;
+	u16 dvsec;
+	int ret;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	serial = pci_get_dsn(pdev);
+
+	cxl = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM, serial,
+					dvsec, struct vfio_cxl_state, cxlds,
+					false);
+	if (!cxl)
+		return ERR_PTR(-ENOMEM);
+
+	ret = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_COMPONENT,
+				 &cxl->cxlds.reg_map);
+	if (ret) {
+		pci_err(pdev, "vfio-cxl: no component registers\n");
+		return ERR_PTR(ret);
+	}
+
+	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
+		pci_err(pdev, "vfio-cxl: HDM decoder registers not found\n");
+		return ERR_PTR(-ENODEV);
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
+		return ERR_PTR(ret);
+
+	cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl->hpa_range);
+	if (IS_ERR(cxlmd))
+		return ERR_CAST(cxlmd);
+
+	cxl->cxlmd = cxlmd;
+	return cxl;
+}
 
 static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 {
+	struct pci_dev *pdev = vdev->pdev;
+	struct cxl_hdm_info *hdm __free(kfree) = NULL;
+	struct vfio_cxl_state *cxl;
+	u64 hdm_size;
+
+	/*
+	 * pdev->hdm is cached at PCI enumeration, before any driver binds, so a
+	 * device without it has no usable HDM decoder. Continue without CXL
+	 * support rather than defer the bind forever. The cache belongs to the
+	 * CXL core, so work from a copy. Probe may run in a worker on the
+	 * device's NUMA node that does not own the device lock, so take the
+	 * copy that needs none.
+	 */
+	hdm = pci_cxl_hdm_snapshot(pdev);
+	if (IS_ERR(hdm))
+		return PTR_ERR(hdm);
+	if (!hdm)
+		return -ENODEV;
+
+	/* The guest drives one virtual decoder; multiple are unsupported. */
+	if (hdm->decoder_count != 1)
+		return -EOPNOTSUPP;
+
+	/* An interleaved decoder cannot be mapped 1:1 to the guest. */
+	if (hdm->settings[0].config.interleave_ways != 1)
+		return -EOPNOTSUPP;
+
+	/*
+	 * The guest drives resets through the CXL Device DVSEC and polls the
+	 * shadow for completion. If the host cannot service a function-scoped
+	 * CXL reset, that request could never complete, so refuse the device
+	 * rather than advertise a reset the guest would poll on forever. The
+	 * check includes the CPU cache invalidation that the reset needs.
+	 */
+	if (!pci_cxl_reset_capable(pdev))
+		return -EOPNOTSUPP;
+
+	hdm_size = range_len(&hdm->settings[0].config.hpa_range);
+	if (!hdm_size)
+		return -ENXIO;
+
+	/*
+	 * Group the CXL-core allocations so a failure unwinds them here. A
+	 * failed init leaves the device bound without CXL support, so devm
+	 * would otherwise hold them until unbind.
+	 */
+	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
+		return -ENOMEM;
+
+	cxl = vfio_cxl_create_memdev(pdev, hdm_size);
+	if (IS_ERR(cxl)) {
+		devres_release_group(&pdev->dev, NULL);
+		return PTR_ERR(cxl);
+	}
+	devres_close_group(&pdev->dev, NULL);
+
+	cxl->hdm = no_free_ptr(hdm);
+	vdev->cxl = cxl;
+
 	return 0;
 }
 
 static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
 {
+	kfree(vdev->cxl->hdm);
+	vdev->cxl = NULL;
 }
 
 static int vfio_cxl_open_device(struct vfio_pci_core_device *vdev)
@@ -80,3 +214,4 @@ module_exit(vfio_cxl_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
+MODULE_IMPORT_NS("CXL");
-- 
2.53.0

