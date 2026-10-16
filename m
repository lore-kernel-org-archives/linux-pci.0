Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013043.outbound.protection.outlook.com [40.107.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA445187EB;
	Fri, 16 Oct 2026 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167697; cv=fail; b=e8y+0QsZMC+1Umkq9PjD3Ty6nY8ZjOs/qk8wGsdTX+vMwv+055DXiJReixwMJ8PprPzdKEduvvMk0hhOGs14Kh8EHip08WmB9js/pyR3g32uiHUIR8e9Pz2Y/Eqpif0KeOQBW519nlRxzjRwpIq04rQ/JwldWk+03dySfQLbHCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167697; c=relaxed/simple;
	bh=dUAI6Hx91iCaupc6SRg+sISPLcscmo3w1+qtZTvb7Cw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yu2+OG5LDJMwOGKTHDChHXkQE14ahDOG0buyOShnurfHUVLr+eSoOyjMGhludbRcR45/Dhlu0Q2Ht1MFU4YXZf9Kbi66nH4MH5ibOqed50fDBhpnEfS0MDej/fz/kRH0hqwx9f/fp/Q6MEa+gtwgGuRlpX5Ek4NKjyHAOLIZFbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U8SvCzH7; arc=fail smtp.client-ip=40.107.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U8SvCzH7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2kbcc3VyLMAujJqNSRXfmt+nZX59Bh7mUybB1wXOZ6BAUcqEAqRqLgIqaPQ60T+qhXHR/v2cZyjRFSdWAXuWLB/h2AQ7qOz+qWMwD9tpGSW0W32qksgW+YLW0oxo46XFiNBFTOySsqo9A9k8nchZm7mfxcKCNUN7Gho0NJmzLgKRXBtnCVAZiFOEfhIAh5u8vZ2c/vQNyw5YyrUqY56aBTg5VxBg3gUnpfCyxTt5MBD3lX4y6pJqatM3kCL16RX+zSbSznqdiQkxZQMFOQ5H28C9b/+M7ZbFF2TN2UtleQbQ+5nD/FjCm6aOet5B4qQVpkZ4AQ7MrFF8MdOrkBmpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ0azavEvib4AMe9E9aXbgFhgwg+Mha5jOSEd9s+gx0=;
 b=Nw0d2Rpd/9/FZQdebm8LjCEGbLODoYIMzONtVLg9HeJHdaTUiHseLxoDqD4g+DhCccGoPz4IsSi6xLcWJ+G22wqX5YOuIkltX4zrCRD95yPiHIR77BS3OWNVn0ZW0FxQdBiMF95ez3WitCpe5u9A2qjMFQ2AqEVudrrF4mDSFRHwUCU3XSosFn8z964Kj4H3lffR9rsByjA2goO82hQPifAvAfQvqRk7UlIsD2g17pzK/UDYrESPJJfGzurLrIT//Z6UfFLklDsbXnmJ7LgcFPnPlFwAhNeOMGDT6F17ZSoA0CFe6hyj8bktN/mYRrJxogtt1mnM50S2zdj344yZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ0azavEvib4AMe9E9aXbgFhgwg+Mha5jOSEd9s+gx0=;
 b=U8SvCzH7Ufb5yBFrErQk+jz7S8NmuKcptZsf87BWm0MT+Cm1dN04l7xEp7bISQklKLRSQkb6O1AFkZiRrzHsh+XFG9RT8dzEzPZJaxXFIUCGQN1bQl88EIjJEuENPVZTQ+yWG2DNzGgFNfzaSP6OEh/MRvT0q80VEVHf73aU5qTu4PDZ59y9vkvvpiQsgbdfDw/dt9zk8VYetGmO3MsDht1pSx1faDzHfwLD/EY6SesxmO0UusMUDnKRC9VqWqowdZlefEV2YpMa+svDj9bUacCnnm05cPkiS4idxaNMk6NGEwT0MpymTzuAgHAlhPYu/KuB3O84p4Z7umFzxw2XPw==
Received: from DSZP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::13) by
 SA5PPFCB4F033D6.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:21:23 +0000
Received: from CH01EPF000BE94E.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::49) by DSZP220CA0003.outlook.office365.com
 (2603:10b6:5:280::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:21:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94E.mail.protection.outlook.com (10.167.244.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:21:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:20:59 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:20:51 -0700
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
Subject: [PATCH v6 13/31] vfio/pci: Bracket PCI resets with the CXL reset hooks
Date: Fri, 16 Oct 2026 21:48:20 +0530
Message-ID: <20261016161839.2765592-14-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94E:EE_|SA5PPFCB4F033D6:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a76bc67-83d3-4ff5-c345-08df2ba1849d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|7416014|22082099003|18002099003|10067099003|921020|261009223027099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	SQ6nAq3Kyhz/OJrVCnXC4dwgt9X0OIx8EqDHb6L3m6NpE0jCOy85Ke1Fao/LiUjSuD5CdRgpE+CTDy4eltsX9Gnxk/A6VvKKkWikyy3x+I7uGn6bFbY/z6tn7aKwkrq8cLZixip5B9JU4/5czSNohwLEWGFDiOhIzkjYuJ46KteV4ZiCqvQDNpafGGzmA6lZwAJlcX/Hb27qpSRCxdKkRmUvWeNKU9GMqg1wS9OG4/6yjl/1EkIpNuDXnSVAYboicBKOB7HNUN/nTaSQWWFL3FM7CViwr7z1wL7j0qzDYJCu1cJDb/7qCsgBh1Hxm66n/ZRkEs/nFSAAAo0qXQE4DAaF2I7feL8QWHeMlTRzFf+QfRo5Owe/JYM50oLlyk3kQDM+7CB3E2zs3umH6Hl4dK36Hz4ZEQrdXRRHY8IzjuaU+wyPQJpfB4xzLZd+KAYX91h2QCs3jtjvjKxZLxWA9CsXwKMmXOl42VyFvinQ8yR+HqA3So/LdNhxcnxDDGKNHUxgSCqoQL4g3k5EMr/UFLWAfsVIqa+psTnDCCPWAdE+MfBhzsf9hbzj2+xMvj0ZCFgxEW2iL3HlazVEoXu5wJbk001AJZTuynGhukBbuRVTyeyRwY203ENF75H9MpX0InFoczYVmhLwUTtlX+x+Tz+Pc2yzxVNUA5NP3ssPhg7Hw77YoY/znY0uM0JgwtPUTyhVlA8ZhDUY9nTKB1muSDxuEYbG0eL2K8CZqL7rfmtcBPJiSJy4V0lHZSvWS4OE
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(7416014)(22082099003)(18002099003)(10067099003)(921020)(261009223027099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s5+0mt15CPTUFml3ILsP4DV7ubSUoirraF2LKDj61j+PQ9sO1ds70wu/Vjp2ZyJ6tmDpF0m5nnvn9vhVJusnMC3mZUxQkbTpKzCS6mFaF9oeQiCzH0tiCVrb9y1x13PD2wdfMUBmDwkeqJiL10VNpALw14lJFOuNURA6K6LLPULXZAnbmJLWz8m0Ugt8Eu47tjXm5RqSGgDzyMtsSfN90WF624EpcYJogsf4hsf3j4VtqhaqKKW9SxUQ6Aeto8AbVRoQKl6LVZzByOa0BjEWX1T5JtUuhzMu8w+TmEEI8OAK3PXl6ftWsfgRVkziWNKmyx3KTyU4xeHZQDPaMsk11rBrMVgibjIVKuJQ1DB+EW2dgqFV9/dacsoiyFurE3F7/2RQKaOyc+YrrA15ygH1rBPu17aKeUKT1a63yUq6JWY6FTk+JLUXaUFNp0vQ5Yrx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:21:22.2895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a76bc67-83d3-4ff5-c345-08df2ba1849d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFCB4F033D6

From: Manish Honap <mhonap@nvidia.com>

A CXL Type-2 device must quiesce its coherent link before any reset and
restore its HDM decoder state afterward, or a reset can leave the device
mastering the bus over decoders that are no longer valid. This has to
happen around every reset the PCI core drives for the device, not only
the ones VFIO issues directly, and around AER and DPC recovery, which
can reset the link without the reset callbacks.

Add:
- reset_prepare
- reset_done
- an optional error_resume to the CXL ops

Export:
- vfio_pci_core_reset_prepare()
- vfio_pci_core_reset_done()
- vfio_pci_core_error_detected()
- vfio_pci_core_error_resume()
which take the vfio device.

vfio-pci calls them from its own pci_error_handlers, which resolve the
driver data it owns. A variant driver that binds CXL devices calls them
from its own handlers the same way; a driver without reset_prepare,
reset_done, error_detected and resume callbacks gets no CXL support.

The provider hooks run with memory_lock held for write: vfio-pci-core
already holds it across its own hot reset, and
vfio_pci_core_reset_prepare() takes it for a reset started anywhere else
until vfio_pci_core_reset_done(). The hot reset records its task, so a
reset that another task starts meanwhile waits for memory_lock instead
of skipping it. pci_dev_lock() blocks user config access, which a
PCI_COMMAND write can be waiting for while it holds memory_lock, so
reset_prepare lets config access through while it waits. reset_done
returns an error when the provider could not restore its device, and
VFIO_DEVICE_PCI_HOT_RESET returns that error; for any other reset the
provider logs it.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci.c      |  39 +++++++-
 drivers/vfio/pci/vfio_pci_core.c | 154 +++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |  22 +++++
 3 files changed, 214 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index 830369ff878d..286244059569 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -223,13 +223,50 @@ static const struct pci_device_id vfio_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, vfio_pci_table);
 
+static void vfio_pci_reset_prepare(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	vfio_pci_core_reset_prepare(vdev);
+}
+
+static void vfio_pci_reset_done(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	vfio_pci_core_reset_done(vdev);
+}
+
+static pci_ers_result_t vfio_pci_error_detected(struct pci_dev *pdev,
+						pci_channel_state_t state)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	vfio_pci_core_error_detected(vdev);
+	return vfio_pci_core_aer_err_detected(pdev, state);
+}
+
+static void vfio_pci_error_resume(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	vfio_pci_core_error_resume(vdev);
+}
+
+static const struct pci_error_handlers vfio_pci_err_handlers = {
+	.error_detected = vfio_pci_error_detected,
+	.reset_prepare = vfio_pci_reset_prepare,
+	.reset_done = vfio_pci_reset_done,
+	.resume = vfio_pci_error_resume,
+};
+
 static struct pci_driver vfio_pci_driver = {
 	.name			= "vfio-pci",
 	.id_table		= vfio_pci_table,
 	.probe			= vfio_pci_probe,
 	.remove			= vfio_pci_remove,
 	.sriov_configure	= vfio_pci_sriov_configure,
-	.err_handler		= &vfio_pci_core_err_handlers,
+	.err_handler		= &vfio_pci_err_handlers,
 	.driver_managed_dma	= true,
 };
 
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3d4e01eea7b1..f1e1ec36eec7 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2462,6 +2462,7 @@ static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev)
  */
 static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
 {
+	const struct pci_error_handlers *err_handler;
 	const struct vfio_cxl_ops *ops;
 	int ret;
 
@@ -2473,6 +2474,23 @@ static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
 	if (!ops)
 		return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
 
+	/*
+	 * The provider must see every PCI core reset of the device and every
+	 * AER or DPC recovery. A driver without reset_prepare, reset_done,
+	 * error_detected and resume callbacks gets no CXL support; the driver's
+	 * callbacks must call vfio_pci_core_reset_prepare(), _reset_done(),
+	 * _error_detected() and _error_resume().
+	 */
+	err_handler = vdev->pdev->driver ? vdev->pdev->driver->err_handler : NULL;
+	if (!err_handler || !err_handler->reset_prepare ||
+	    !err_handler->reset_done || !err_handler->error_detected ||
+	    !err_handler->resume) {
+		pci_info(vdev->pdev,
+			 "driver lacks PCI reset or error recovery hooks, continuing without CXL support\n");
+		vfio_pci_put_cxl_ops(ops);
+		return 0;
+	}
+
 	ret = ops->init(vdev);
 	/*
 	 * A provider that is not ready yet (for example its CXL port has not
@@ -2759,6 +2777,128 @@ int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
+/*
+ * Take memory_lock for a reset that the PCI core runs on a locked device.
+ * pci_dev_lock() also blocks user config access, and vfio_basic_config_write()
+ * holds memory_lock while its pci_user_*_config() calls wait for that block
+ * to clear. Waiting for memory_lock with config access blocked would hang
+ * both tasks, so let user config access through while waiting: the PCI core
+ * calls reset_prepare before it saves or touches the device. The caller holds
+ * the device lock, so a block found set is the caller's own.
+ */
+static void vfio_pci_reset_lock_memory(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+
+	if (down_write_trylock(&vdev->memory_lock))
+		return;
+
+	/* The caller did not block config access: nothing to release. */
+	if (pci_cfg_access_trylock(pdev)) {
+		pci_cfg_access_unlock(pdev);
+		down_write(&vdev->memory_lock);
+		return;
+	}
+
+	pci_cfg_access_unlock(pdev);
+	down_write(&vdev->memory_lock);
+	pci_cfg_access_lock(pdev);
+}
+
+/**
+ * vfio_pci_core_reset_prepare() - prepare a device for a PCI core reset
+ * @vdev: vfio PCI device about to be reset
+ *
+ * Call from the driver's pci_error_handlers.reset_prepare callback.
+ */
+void vfio_pci_core_reset_prepare(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->cxl_ops)
+		return;
+
+	/*
+	 * vfio-pci-core holds memory_lock across its own hot reset. Hold it
+	 * across a reset started anywhere else too, until reset_done. Test
+	 * the owner, not just a flag: another task can reset the device while
+	 * a hot reset holds memory_lock and has not yet locked the device.
+	 */
+	if (READ_ONCE(vdev->hot_reset_task) != current)
+		vfio_pci_reset_lock_memory(vdev);
+
+	vdev->cxl_ops->reset_prepare(vdev);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_reset_prepare);
+
+/**
+ * vfio_pci_core_reset_done() - restore a device after a PCI core reset
+ * @vdev: vfio PCI device that was reset
+ *
+ * Call from the driver's pci_error_handlers.reset_done callback.
+ */
+void vfio_pci_core_reset_done(struct vfio_pci_core_device *vdev)
+{
+	int ret;
+
+	if (!vdev->cxl_ops)
+		return;
+
+	ret = vdev->cxl_ops->reset_done(vdev);
+
+	/*
+	 * hot_reset_task cannot change since reset_prepare: setting it needs
+	 * memory_lock, which this task or the hot reset task holds.
+	 */
+	if (READ_ONCE(vdev->hot_reset_task) == current) {
+		/* VFIO_DEVICE_PCI_HOT_RESET returns the error. */
+		vdev->reset_done_err = ret;
+		return;
+	}
+
+	/*
+	 * Nobody waits for the result of a reset started elsewhere. A provider
+	 * that failed has logged it and keeps its device memory out of use
+	 * until a later reset restores the device.
+	 */
+	up_write(&vdev->memory_lock);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_reset_done);
+
+/**
+ * vfio_pci_core_error_detected() - prepare a device for AER or DPC recovery
+ * @vdev: vfio PCI device the recovery reports an error on
+ *
+ * Call from the driver's pci_error_handlers.error_detected callback. The
+ * recovery may reset the device without reset_prepare and reset_done, so a
+ * provider takes its device memory out of use here.
+ */
+void vfio_pci_core_error_detected(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->cxl_ops)
+		return;
+
+	guard(rwsem_write)(&vdev->memory_lock);
+	vdev->cxl_ops->reset_prepare(vdev);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_error_detected);
+
+/**
+ * vfio_pci_core_error_resume() - resume a device after AER or DPC recovery
+ * @vdev: vfio PCI device the recovery resumes
+ *
+ * Call from the driver's pci_error_handlers.resume callback. A provider puts
+ * its device memory back if the device still decodes it; otherwise the memory
+ * stays out of use until the user resets the device.
+ */
+void vfio_pci_core_error_resume(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->cxl_ops || !vdev->cxl_ops->error_resume)
+		return;
+
+	guard(rwsem_write)(&vdev->memory_lock);
+	vdev->cxl_ops->error_resume(vdev);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_error_resume);
+
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
 };
@@ -2915,6 +3055,8 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 			ret = -EBUSY;
 			break;
 		}
+		WRITE_ONCE(vdev->hot_reset_task, current);
+		vdev->reset_done_err = 0;
 
 		vfio_pci_dma_buf_move(vdev, true);
 		vfio_pci_zap_bars(vdev);
@@ -2940,6 +3082,17 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 
 	ret = pci_reset_bus(pdev);
 
+	/* A provider that could not restore its device fails the hot reset. */
+	if (!ret) {
+		list_for_each_entry(vdev, &dev_set->device_list,
+				    vdev.dev_set_list) {
+			if (vdev->reset_done_err) {
+				ret = vdev->reset_done_err;
+				break;
+			}
+		}
+	}
+
 	vdev = list_last_entry(&dev_set->device_list,
 			       struct vfio_pci_core_device, vdev.dev_set_list);
 
@@ -2948,6 +3101,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
 					 vdev.dev_set_list) {
 		if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
 			vfio_pci_dma_buf_move(vdev, false);
+		WRITE_ONCE(vdev->hot_reset_task, NULL);
 		up_write(&vdev->memory_lock);
 	}
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 6520a2dcfd4a..881e51c42414 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -72,6 +72,21 @@ struct vfio_cxl_ops {
 	void	(*release)(struct vfio_pci_core_device *vdev);
 	int	(*open_device)(struct vfio_pci_core_device *vdev);
 	void	(*close_device)(struct vfio_pci_core_device *vdev);
+	/*
+	 * Optional. Called with memory_lock held for write when AER or DPC
+	 * recovery resumes the device, after reset_prepare was called for the
+	 * error. Config space is as the recovery left it.
+	 */
+	void	(*error_resume)(struct vfio_pci_core_device *vdev);
+	/*
+	 * Called around a PCI core reset of the device with memory_lock held
+	 * for write; reset_prepare also when AER or DPC recovery reports an
+	 * error. reset_done returns an error if the provider could not
+	 * restore the device; VFIO_DEVICE_PCI_HOT_RESET returns it, and for
+	 * any other reset the provider logs it.
+	 */
+	void	(*reset_prepare)(struct vfio_pci_core_device *vdev);
+	int	(*reset_done)(struct vfio_pci_core_device *vdev);
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
 };
@@ -166,6 +181,9 @@ struct vfio_pci_core_device {
 	struct vfio_pci_core_device	*sriov_pf_core_dev;
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
+	/* Task running VFIO_DEVICE_PCI_HOT_RESET while it holds memory_lock */
+	struct task_struct	*hot_reset_task;
+	int			reset_done_err;
 	struct list_head	dmabufs;
 	/*
 	 * Excluded BAR sub-ranges, one list per BAR, sorted by start and not
@@ -207,6 +225,10 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev);
 int vfio_pci_core_register_device(struct vfio_pci_core_device *vdev);
 void vfio_pci_core_unregister_device(struct vfio_pci_core_device *vdev);
 extern const struct pci_error_handlers vfio_pci_core_err_handlers;
+void vfio_pci_core_reset_prepare(struct vfio_pci_core_device *vdev);
+void vfio_pci_core_reset_done(struct vfio_pci_core_device *vdev);
+void vfio_pci_core_error_detected(struct vfio_pci_core_device *vdev);
+void vfio_pci_core_error_resume(struct vfio_pci_core_device *vdev);
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn);
 long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
-- 
2.53.0

