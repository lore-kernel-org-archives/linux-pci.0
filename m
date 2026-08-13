Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4CB3EB0F0;
	Thu, 13 Aug 2026 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613949; cv=fail; b=uHWIcQa+j/Y5xHS2z1ZM9UD4uMvw5k3VBMZB03/TaTKSHxcnezeEXrbMiyqBso8qcNz40gmbEhgZ0euagUKR09n3TaE2nQAmcdjLeuYs7Ydfl8uQ3qYkOKD+7qwramM4tt66TbqwufW9UGRS8eTZZawjUB9lcMZBk63Km2+IEKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613949; c=relaxed/simple;
	bh=Uck+1CZLaR7bK/UwzFHJXh6w/VI69f6cSya3rw2NQBE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbVcgkIY55vOZ4aQ2GZIfRvJLSNSyv473BvV2UYoiRpyzFevDMnn2FF3jjjCXMDszEZzlZGGOs/wZIFmoDu5US2nVjLwNCyo0pbe7bw14cLA2FTbCXVE/Ng0rH3evAc06KrcTNj3GQkMcw0nsSVB7YyKLSCACWV5SUMhLpV9qFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Bxi9Ldg8; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Bxi9Ldg8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WmqwCRWswx/DnhQFTK7E5WG18S8hkRniHI+WWq5MySeOhUIzY2zeL8gHCdj9Ti8S7Tk5QVfSRbRnyxJ3bPUmLqLZRko+cQSQmS+OX9zjcj/JvTP3n9VmzMZ2Te85vyLE9YC8f3Kr9UmM4bOldQvdvtr0RISit6VLX/h2cBSqtXCGk73detzEOl4L2F4QTTAyWJljtUX0TXH5sR+t54LifzUtvSHCtyagsHeCX8kp10zBvp1Bq4tt+/3ATAfMvuovYzgNrdCc8A2lamV3oqKNxK2QmIxuUWmTj9vC5hEzRo0SEeSSimeW2/24oq1VO0vw9drENsUztKgLwpR//W39og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmh4TmOcU82GTHxvoB4iWFdYhIFbxByqlOk2sJWM5iU=;
 b=NY65fKfnw4s4ZqeeDdtZIWMX2Uwcds+ll/2hsk/40m+P19EKxKdk/BVSWWQLmOuMJ+rSpj8V+mv6mwSEmj0Z5/IJ60L7oO5fZnSZQDoFdKlpCMUc9M/xsNcNr6F7Ilx3AN/NdUGPXKoUQ3Vfc154mQrCL6kzvwjQsJC75gI2f+wb1bRNaphEx8ulQEoes4JUZD7CUCXEa6WmxgQKKEXHq4ZzBXrRUyeXKQapWhz7jtLQwR0uun/CJYTLLQw4shRVZDAzbguoqAyVCPTs1u0hm4EBFROwiQKJ/3cqqItFFGwLrM+u9r6wyeiAZj0/gH/ZqUXt35yT4PebQUP9JH5p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmh4TmOcU82GTHxvoB4iWFdYhIFbxByqlOk2sJWM5iU=;
 b=Bxi9Ldg8I2CxPGgUGpuos5Doo1vOPiZJUZ3Tm0JXcIe7U8/JsnnC1aIUgTsg4mBmWO8TbVr0oV9q65ByxFNZOtEGGm4N52CepLs8CXhz3KJ9BgLltfIW5/OxL5bE8a0XUyUBHJnWU2KIJPkGEzuHlPiL5w/5O0ut+j/CoM1Zq1xTi5Q6/VzyNihIBbMn3XSk9SBKCj7hHPAQXEX4X8PumU9dit3pauV+Uygbv3Y0mor6N0f6CN+GumvUJGv2kjWchDz48gEWiPTIz5UHIQFcjaHSoClEEUTe2P0RdDa+/Aj/acEAYD5bNxllSnjqKIBjXpxqQciHgHffGl1dEC+eFg==
Received: from MW4P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::18)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Thu, 13 Aug
 2026 09:38:32 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::8c) by MW4P220CA0013.outlook.office365.com
 (2603:10b6:303:115::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Thu,
 13 Aug 2026 09:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:38:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:38:18 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:38:09 -0700
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
Subject: [PATCH v4 07/27] vfio/pci: Detect CXL devices and load vfio-cxl on demand
Date: Thu, 13 Aug 2026 15:06:11 +0530
Message-ID: <20260813093631.2288172-8-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: fa07844c-0e73-4e0b-2727-08def91ea3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700016|376014|23010399003|82310400026|921020|10067099003|11063799006|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yX/c2AIT3TPKKRJer/ksPF+upZcEQxU/DgN+k4LgdXKCbeEjYarV/7QzfVMU/4OW8g4aT2+bXoTBfOVE0L48X7fEtOVENHs3ZuirAOA3zlupHR7egNbuT6MlcLx/FqbGyS7WeB9WVpD6zixBEm0NNz/hCLy0qW/JPuMf+fzY8O2aRrdo7TdFOXYedPhVfqkjwpDjnSGEgQxY30Y44P40yUrbOtOCnZzRbXIuMtc6Yrc3Nqz8l6D1nszZbuLfokDOA4Z0NhK3gqpHrOWc0beCEkqzEvk8nFFbFQBg36QKL0DrjWKZu3wLAvfvcoGguvo79nurXUo2TPjkir2ne0pHAFoy8E2vco21jhJE7jMurIig5KhnwcIvkW2kkJojQors3D7fDBXMW4tMJXKHzihgdTnOAXpE7xCWUlZRi8GARQQ0HnSQdShe8oJUyaGRjOuIrgp9QhU+8YYHoRxW7qhB/8rwY4/eolWhK9OubdXMlywGj0yRIMN0HAF1/XbuWV1zhaQlOhstcWlZuG1ZOSxk4xCk/LVSwcrc5r6HPhpIMhhTsrd2xVu671OyWOFdigMzkH+6DgpagRsLro+Y3ThyNKTLLlzJ1nqA2gHz+NUZmiUPJ5ZFLhhxiJPJ4QP8VkL3K4e7fLFjAV9YVBg6L3i6V1JEw5PMKAzUtiVckiKHsqDgyf86eOKJ5QW1zr0Gtv9KW2D4wmRDpwLO7BIS0nTrIT6EJRFpJy4NYty4VDkHOZKOUjlgw2g6irD9w5DhVSQZ
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700016)(376014)(23010399003)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QrwnOhNimEUFUwuWcxKC2k3xAcVZ08/n8jXTt+av3I5bRRZ700+DhoCFJ9i8MLJ9EieQYH+i/f3XfOfD0k2RiPwon4jZhyPfjfPSzF7Oz9aLqKDe0Ed014Z8gw0w30IRU7g6fdtr/6uzqIlZVFgXfZAwgP79LeTdFDl4sOHOUlJd1MY9PEmZkMpH5+6bj4Jp+GRwD83TlJbSQtvdmHv6Z2wnzveiwvOKFGWZQ2yqKB/v570i2ORcpyeiiMjaoqbjutzJQVEaQX5eGvCgDaak2S0r320o5GE62fTWGlifNElUtWMhjtQmeRvu6K7db3XRubHFz2NkPkqJCbK62U8qIodpcUb9/twdF/+NZUbrs10gvFwFG9m1O9sS4eo0zPa3tdLoOQhJGWrY+Ek6tfgJo+GPo3WZvko6HyUnxwb3vw14/jKDUOqo8LK1XGH2l1Mk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:38:32.6004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa07844c-0e73-4e0b-2727-08def91ea3eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213

From: Manish Honap <mhonap@nvidia.com>

A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and the
CXL core in unconditionally would bloat every vfio-pci setup. At bind,
detect a CXL device with pcie_is_cxl() and request_module("vfio-cxl")
only then, and hand the device to the registered ops.

Each bound CXL device pins vfio-cxl through try_module_get() and drops
the reference at release, so vfio-cxl can unload once no CXL device is
bound. If vfio-cxl is absent the device is driven as plain vfio-pci.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 81 ++++++++++++++++++++++++++++++--
 include/linux/vfio_pci_core.h    |  3 ++
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 88e68d43af9a..0f9b5dfeea66 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2176,6 +2176,44 @@ static void vfio_pci_vga_uninit(struct vfio_pci_core_device *vdev)
 					      VGA_RSRC_LEGACY_MEM);
 }
 
+static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
+static DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
+
+static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void)
+{
+	const struct vfio_cxl_ops *ops;
+
+	mutex_lock(&vfio_pci_cxl_ops_lock);
+	ops = vfio_pci_cxl_ops;
+	if (ops && !try_module_get(ops->owner))
+		ops = NULL;
+	mutex_unlock(&vfio_pci_cxl_ops_lock);
+
+	return ops;
+}
+
+/*
+ * A CXL Type-2 device advertises both CXL.cache and CXL.mem in its CXL DVSEC.
+ * pcie_is_cxl() is also true for Type-1 (cache only) and Type-3 (mem only)
+ * devices, which the vfio-cxl provider does not handle, so confirm the Type-2
+ * identity before engaging it.
+ */
+static bool vfio_pci_is_cxl_type2(struct pci_dev *pdev)
+{
+	u16 dvsec, cap;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	if (!dvsec)
+		return false;
+
+	if (pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap))
+		return false;
+
+	return (cap & PCI_DVSEC_CXL_CACHE_CAPABLE) &&
+	       (cap & PCI_DVSEC_CXL_MEM_CAPABLE);
+}
+
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 {
 	struct vfio_pci_core_device *vdev =
@@ -2197,6 +2235,41 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
 
+	/*
+	 * Load vfio-cxl on demand for a CXL device. If it is absent, drive the
+	 * device as plain vfio-pci rather than failing the bind.
+	 */
+	if (pcie_is_cxl(vdev->pdev) && vfio_pci_is_cxl_type2(vdev->pdev)) {
+		const struct vfio_cxl_ops *ops;
+
+		request_module("vfio-cxl");
+		ops = vfio_pci_get_cxl_ops();
+		if (ops) {
+			ret = ops->init_device(vdev);
+			if (ret) {
+				module_put(ops->owner);
+				return ret;
+			}
+			vdev->cxl_ops = ops;
+			/*
+			 * Pin the device in D0 while bound rather than let
+			 * the host power it down between opens.
+			 */
+			vdev->disable_idle_d3 = true;
+		} else if (IS_BUILTIN(CONFIG_VFIO_CXL)) {
+			/*
+			 * Only DEFER for a built-in provider so the bind
+			 * retries once vfio-cxl registers its ops.
+			 * A modular provider was already loaded synchronously
+			 * by request_module() above, so if it is still absent
+			 * it is missing, blocked, or failed to init; drive the
+			 * device as plain vfio-pci then rather than defer the
+			 * bind forever.
+			 */
+			return -EPROBE_DEFER;
+		}
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
@@ -2206,6 +2279,11 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 
+	if (vdev->cxl_ops) {
+		vdev->cxl_ops->release_device(vdev);
+		module_put(vdev->cxl_ops->owner);
+	}
+
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
 	kfree(vdev->region);
@@ -2670,9 +2748,6 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	}
 }
 
-static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
-static DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
-
 int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)
 {
 	int ret = 0;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 14753972e714..117cd67995d8 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -29,6 +29,7 @@ struct vfio_pci_core_device;
 struct vfio_pci_region;
 struct p2pdma_provider;
 struct dma_buf_attachment;
+struct vfio_cxl_state;
 
 struct vfio_pci_eventfd {
 	struct eventfd_ctx	*ctx;
@@ -109,6 +110,8 @@ struct vfio_pci_core_device {
 	struct vfio_device	vdev;
 	struct pci_dev		*pdev;
 	const struct vfio_pci_device_ops *pci_ops;
+	const struct vfio_cxl_ops *cxl_ops;
+	struct vfio_cxl_state	*cxl;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
 	/* Flags modified at runtime - dedicated storage unit */
-- 
2.25.1

