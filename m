Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB172441618;
	Thu, 13 Aug 2026 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613916; cv=fail; b=MfczqPCc0/VjgBOWDT43Lk4qW492RVbJ19yDcWxQa0Ds+oPeylZUh5GGK9/RAQunyIRgFuS6ShwPUHincOMRAsb0clo3nxNUaI9KWavlwKG6zbm/6YqFNFZOymdsJmHihk+QkwB+3bogrGbh/gA+Sq6RdHZ+v6YTxEeS6HX4HHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613916; c=relaxed/simple;
	bh=AAh24ekMw4lumVWErPuVAry3beofQXTTvNFXLFYTZ0U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0gaspMuw1RNBGfOEyF5X8l87aPv58WuDdFxE2AM/IabQvpmKUComeyqtciSCQPnQaaZV/Ly3lROUcztIX/HeWw+LoIU7sO4lhEaYpWwq0LzQJxFuZ87xU9C1AbUrEHyEe35RwsmNhsC+Dd/hostvkn7vk03uGA8lfpX9TT8pZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XNVYYQLf; arc=fail smtp.client-ip=40.93.201.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XNVYYQLf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tehZfFsYFfBLX+fLJc4B5kmG8WbT/WbfPWAssWQI3o5bWFUVxPbW3ZsKlkYoZE7nD81EFHr3kUtBQW1WRtSIU3ZuCP5M7TNwZMKsA5qtO0GOZtbax/mQEBnpuJ1Dx2YM+HyuJqVOxsBaYCJUgCevzjWA2STtOilVKxs26k5vAzwdz2f/SnJEkB8XsXgwyKf2Wy9Odn1pyJbHAWuHvWEfAXgpTHuhr6K4APg0aaMAwF2qVBMgkMYo7qJQzkYSD8opbUB+8Lsoj2A0CiT/+wPDap+3AijbdelpxAHIOxmDRuIjNLU4CkESpg8iNWvgOdr153J4WRbfkC1qkHNOGccEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dn9NTcpCvb4TTh1gUDOctdZOPQrJJbhmZox88/h6+7Q=;
 b=ncq5H0NfskTgsmRJBUSdvuaiAojP+CCGltXZ01d33UradxE93en/gvWANBJKU4TRJ7ISMXcPVLUAgtxQHnDLxPjuKZrN/coAlFnzUNUV90NS9mXlXfaSwPq/tfHOJrAXppVVsyw++ua76rYeC3uHqweRaSwBpBgb/My1+CF6EvlPRGG9W486zhlE/Fq/Vt20I7w8Bpgg3Cw9gjN2cjOm8+9G5ZmYluXyvaFRPfwow/txff9d0y6Ycb+AVwobrjAvP1NXxUqM63FccEV5AetTCq3gfh7sgYM2TgLhGbolh3/NBxvVOhamT0Mu9BAfL4zOoxhaPUN3pC6kAUPoedmrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn9NTcpCvb4TTh1gUDOctdZOPQrJJbhmZox88/h6+7Q=;
 b=XNVYYQLfyLBgTXuhQWPOEhvufTf45SrGUQB0YZbbQYDPvTlOiDui8geajc+SeUGMUxvFsO6AyDDfKVlGlgqEJz/RPrdoeug/9z+tSv/w1izgRo6FSnlPxHB33liivl5KWnWGKKz/8AMmPUGbP0rUJqlX8pLD4CpS/bF1YuCr9NGgq34U5SrjZSje6b7IwFr6hPuZ38RrzH21P560K9HUsQWB8cTrVEBkO91Eikw9K/RAMoJGvQI9zPsFKnSIFztwWIGMeWgsf5ieC97aKEjxNsk3yZldYanDQJJuB+jgh/2sUApcAoGxubXcYzI17xCSOH1pz1zYDIZEtMCd25veIA==
Received: from MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::19)
 by PH7PR12MB9176.namprd12.prod.outlook.com (2603:10b6:510:2e9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:38:28 +0000
Received: from MWH0EPF000C6186.namprd02.prod.outlook.com
 (2603:10b6:303:115:cafe::e) by MW4P220CA0014.outlook.office365.com
 (2603:10b6:303:115::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Thu,
 13 Aug 2026 09:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6186.mail.protection.outlook.com (10.167.249.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:38:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:38:08 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:37:59 -0700
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
Subject: [PATCH v4 06/27] vfio/pci: Add CXL ops registration interface
Date: Thu, 13 Aug 2026 15:06:10 +0530
Message-ID: <20260813093631.2288172-7-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6186:EE_|PH7PR12MB9176:EE_
X-MS-Office365-Filtering-Correlation-Id: 007b4d0b-7938-49ab-5e3f-08def91ea0c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|23010399003|376014|22082099003|18002099003|11063799006|56012099006|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	mTFbT14OHvV3puwWowH2E3hIybYzcVjUxGCTOJxIrqZ91W1AjD836kGAKAihURpeyWzCoknmkni6jCj2FJZYXs/HMdF/jX74sOWpw9QARGItOCI9rqZczCe8lJktG5Mazf0ZWogGlOACH+GJC0Z4xD72RHa4+L3JCiqr3O1BY/EGevUPeDegsZgx4oV7LyvHPdNrWceac58rdHPr/Ztmpzg79V7z9I0YKSCVqOYSDXAyaLvEBOWjNORGNI1Cl3xnsA92TNQGM7FNIL7bgB58aG+JMggqNsN4BlcIk6eALlpozuJr2Z+uO7c6ISPysn72xcfcKwaOrqwnZT2tuGo4Y0RwrskKxgRsL6b2xiI8llrwSYh8q0zi0gfV+4g1ZjVZf6lUHUND4P/BktzcbnRGJk4J7G7aeCNqdHGsBHVFXuYa1qAzvJtxOTUD7S4b959b5+l2H1W26V9I/NGnSeZC7qcZSUqiM/MfdHUGQQ2CnzPth4buGpbGwoLtkgbfEeXLZfk9jnVSc9CkaIusbOloMJFpTcsa5N3cWCwcTriCyinH8by2qf0NCuvbPNhUyca5MYSp9GigUAEZhg0pVAMOu/0msvHxtAPo1B9Iv5Xrz4ECSTE0yRf3xT/60BvZPdQ+GZ4u6MxGc8qz7XOBJRl6BYYq62G4Rveu9UNG4E7vzQ/QCz/z8r6qrzqcAW4a/CAgLx1O2y9ufdzuYr0amVsagL4Eegy2pP+huKz0fS09TYU10ZFaJYfOlynaaYdoc1fq
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7vMcmSeEzWqaXbbPQeqMfx1U4J7URZWHdtombNUGD6MChs8YFNjaIXGzvC36sJQa8n/2DuXZBewYjRPU3GbHfe+AztdotlUs5XyP7HS1Y0lb7ILmoBgH3lOqVWcTL1CpkBOnj/plkcgy1r7Ir1umtr5xSeSwR6h5y5aZtltia5+RZf7IkOUoRe/eMVNvjoKqw2MHfUGVK8u74AdZlnF9VP+Isil4eqY64Gs+8B+io8lj2TOWZrC0z4SI0SE0I3HLSwyBda4yaSMTuCFXQC1Yb/01/B+QU2pxEIDkIgiNVKTRW8AbQXpDrw9S9FP+fL6cL5X4pzmZY8e4cjHlzmoY3hNKyB468gMVl+YL+hM5TKsI1k4c2IvBMt8COLeeXgmHV/rzdep0fAj/K2nWWg7kBn7faAkm3zGhxBZb+Z+mtkxGki1yvXa5Hx8w7LNnVdwV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:38:27.3481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007b4d0b-7938-49ab-5e3f-08def91ea0c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6186.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9176

From: Manish Honap <mhonap@nvidia.com>

vfio-pci-core must stay free of any CXL header dependency, so CXL
Type-2 handling lives in a separate vfio-cxl module that plugs in a set
of callbacks. Add the registration interface: vfio-cxl registers a
single struct vfio_cxl_ops at module_init, and vfio-pci-core stores it
under a mutex.

The owner field lets a later patch pin vfio-cxl for the lifetime of each
bound CXL device. No caller yet; the detection path is added next.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 27 +++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    | 10 ++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 3f11a9624b9c..88e68d43af9a 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2670,6 +2670,33 @@ static void vfio_pci_dev_set_try_reset(struct vfio_device_set *dev_set)
 	}
 }
 
+static const struct vfio_cxl_ops *vfio_pci_cxl_ops;
+static DEFINE_MUTEX(vfio_pci_cxl_ops_lock);
+
+int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops)
+{
+	int ret = 0;
+
+	mutex_lock(&vfio_pci_cxl_ops_lock);
+	if (vfio_pci_cxl_ops)
+		ret = -EBUSY;
+	else
+		vfio_pci_cxl_ops = ops;
+	mutex_unlock(&vfio_pci_cxl_ops_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_register_cxl_ops);
+
+void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
+{
+	mutex_lock(&vfio_pci_cxl_ops_lock);
+	if (vfio_pci_cxl_ops == ops)
+		vfio_pci_cxl_ops = NULL;
+	mutex_unlock(&vfio_pci_cxl_ops_lock);
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
+
 static void vfio_pci_core_cleanup(void)
 {
 	vfio_pci_uninit_perm_bits();
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9a1674c152aa..14753972e714 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -66,6 +66,16 @@ struct vfio_pci_device_ops {
 			       size_t nr_ranges);
 };
 
+struct vfio_cxl_ops {
+	int	(*init_device)(struct vfio_pci_core_device *vdev);
+	void	(*release_device)(struct vfio_pci_core_device *vdev);
+	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
+	struct module *owner;
+};
+
+int vfio_pci_core_register_cxl_ops(const struct vfio_cxl_ops *ops);
+void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops);
+
 #if IS_ENABLED(CONFIG_VFIO_PCI_DMABUF)
 int vfio_pci_core_fill_phys_vec(struct phys_vec *phys_vec,
 				struct vfio_region_dma_range *dma_ranges,
-- 
2.25.1

