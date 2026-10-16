Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31B5226BF;
	Fri, 16 Oct 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167664; cv=fail; b=eySWJHIye19dAGg2e9w7glOdxDhPxFlMgsVpf74AsVISTsVrVBJUHAeeat4QmysQXu1fAGaPwOaGUojsB6FnIl8vOYB9ZTA2fgFkci/fSvrjO1QJmq1HaC7mFT/agS8vODMGX3e9j2+oVOh7k5mtb2+05naaty/J62g7fs3Rh68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167664; c=relaxed/simple;
	bh=AkL29L5i7Yau0MK43U91Zj16op1aV4ijmkHwN89pao0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcF/uC5GTgJU0LIz8EVsJEg4c5wLUe16JWWwI2lOFl3VtKFyXZ3o8aMISb/WPpYwyFaz5epq2lV95VmhpcJ4TXYEImr4v3mJnKoZh5nvBRwZ+MUB73ZrFfiEcS9K3ATjXweCSsEh9B+wRJ3pCK21E3wyv2QwONWMQJ1+zJwjV+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oc3tjs1f; arc=fail smtp.client-ip=52.101.52.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oc3tjs1f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnrR9W2RhcmOyQoBK7iudHqnzotw4Cl3x1HWslquD3zqtGfJBTuk6Qa9XnZyB5ztK7qUn7acLxnQIcC/myQhupsmLe7YKT0JGyt3OFI5AAKQa/htCE8b3Z9YyxkYHupnMH3aS/0WkN8D8vN9RxVdTuqqX3WGUCm3idWOrZ8wlfv4Ndw7vMnu2J0PFcxtglrYrw5NFdXMuVkUckORzbDGCxQj+AF56hLm7SpOFUW47AfUgU56cjRhghLcPJjGRr8kJS2aih+pqAw51hk+Q9DFgFHOJ21PIcLH/i8zd8sBXp/E8+Mlq02V2yPUhB3pYq57zMITSHn0+6VAvofiC10oNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9QNeAr9IqsSomsyHREyUJ8AIUUMVr43KzC4nfHPwJw=;
 b=U0Z5Kom7qpA8C+858/3QgMAGRi0rOl5RUYTz8OidaepfgKu4T7i6cFtKIz3BEv2Vb2ScBOJxyCxElWYJMMS1YXsdf1T54XGlvNTVXN8kAPrmj3hIgeAAaviprEtSnSsyCofrvBJMyuhr5XvvlQNN1jXUS6qEgyrXOMM5xIqGpDW4us94seriJfUaWbLog+aqiybzAA0Rx+nIvseU1YU+wzCvFdayRE8UBeZQs3svlo63SLWYVjjAjKPTXYsAeSqAsKj/WRzM35eIvYgtA74Vu07GZqh8h+I7IUw6prxdnsbN5R+k+nuPWlEj8EpDx4iCN13j9dy/PBYoCB210y1jRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9QNeAr9IqsSomsyHREyUJ8AIUUMVr43KzC4nfHPwJw=;
 b=Oc3tjs1f8ej9nF2XB3vu5dB1y4eEMLqq2Nx7+6u9ELDRx0ywLq1fV5w89P7mcGQf7DeNMax0qhITO5ywUw2n8u6BZ0JALI388fO926OsoAJ92XOCC+Z6vWACOi8Z+/PxrZEoK+2TZpiL+Wi2Me5zaKvfq923w3iOU9ddierS8PElFrrnFQLw5Zn2kVlAEcRXMok0DENHu0C68Oa1ZHB43+13gMiExkRC6ilbbe8+9fHasqeuWHcgs9pbA5j7G80R6B9TWmm48ih7Uel9MlTFAJp5j//B0vNW/7rhg1DETFxDUDv2jK3Nq7A6Wz1NQlWGTfIzhL/SpJ6T3H9S/thdZw==
Received: from DS7P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::12) by
 DM4PR12MB7719.namprd12.prod.outlook.com (2603:10b6:8:101::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Fri, 16 Oct 2026 16:20:34 +0000
Received: from CH01EPF000BE94A.namprd02.prod.outlook.com
 (2603:10b6:8:1ca:cafe::5a) by DS7P220CA0002.outlook.office365.com
 (2603:10b6:8:1ca::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:20:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94A.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:20:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:20:07 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:19:58 -0700
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
Subject: [PATCH v6 07/31] vfio/pci: Detect CXL devices and load the CXL provider on demand
Date: Fri, 16 Oct 2026 21:48:14 +0530
Message-ID: <20261016161839.2765592-8-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94A:EE_|DM4PR12MB7719:EE_
X-MS-Office365-Filtering-Correlation-Id: edb61497-657a-42f2-5617-08df2ba1669f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|7416014|1800799024|23010399003|18002099003|22082099003|10067099003|5023799004|921020|3023799007|56012099006|11063799006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	rnwk7ad/cidPJDS8xOwaI0p31rEcslOP5v3RAMpLyMfNNzu6mHqXcFLgTcPBYNxdZ6HcNHLkEcSVagP0WAPuGiLLYj+qaQ0Dwyu4z+88RBezO7J5lGMRavl+Aua8SXtVHfrd9tJK0Z08VOrkLH0gVgPadHS+GHyXCou3055KKoa15iu39+/som7d61hKpt88dNpUNw2BuivQQF3Lx0lZhuggHhltRDFnRXqbH4h0wiNlhP5lJnGevc5b6xkx1XQyGGyRG6/Qx7kyszfqowj38X3VbXD+ostDDAsQBvB2Q2mF+aQpiFNlk0T5nbhXm+FzImnjdmMDL1JjJwl8PGQs+nBdspXvh2ACthqobSG6jvuo7rWTsz/sLw2Xmk0wpFdV4RhwcGGbi3XGvIRKvuPTmcMs+jww2B5bkwNvfYMw8rth93dnnGa2y0W/vJa48ll98mqWCp9vEZeNDK/58/9jzZPv93LeTQQ6C5AG8sTTXHjQQj1PGwmp61GvIdr0IeHM2TOwSvBhO3rczSe5TYe0HFu8hkCbd6X7UltCp+6U6DbhMJtOXc4Fq7FVn6L0SHJO1NN1sYeUVT1TDs7fwCf0WNdUT+hIWn5xJmRvtBRX2ZDHA14XR4rUHJpAKfzMjF3eyRokv3nYJ5oQ4fHUALnpvMrkmh6T4fz2MmKXAIHIPa27xNduFZv6l3blDZK1I3MGEORdVprV6++vBWwvw8UMqBmIml/BKyuQDuSknS+gHwXMzfCkLflJ/d2Cq2+pXKK8
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(7416014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(5023799004)(921020)(3023799007)(56012099006)(11063799006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Lt4ZMeI2KYtSquXS8Hh9eXmEOxXx5eEYVCnuSnXBQTqvXy3LHnVYgbARicKIHYf7RguSZPYw/bRsFdH7Sgny8Pt8grsQIJoR0I03Qq1VgP8s5jp2mDe2Hmz3XkMZU6jULP+ifzG13draaVrGjUbbwEyo3686pMqUIp5oyjLgA5BTLc2856WcqnSmJPAnjwAUFJC0QTm5lrAymVw9rVj/+EQhZ15PXToE3eXQlHqn0/TrDXuSWHWX5u2LjPUQhIyMBQvtkP0uW/+8OJF/frjzT4u3ZHXPCr6l/afbXDnRfJ9bx8JFlNXB9u+irTivwimZNx+1hTJ5G6jLzwYK/en7b4WlT94WACHMJnNJCb0KFLZN6+ZBcpq84sEicECaA7+uzO+GDdX3t4GVDqAemY1X8K00aAS1zwqvXGpoMNc0SRUZqC5+YqSrJ9kTnRk4P7mN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:20:31.9828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb61497-657a-42f2-5617-08df2ba1669f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7719

From: Manish Honap <mhonap@nvidia.com>

A CXL device needs the vfio-cxl callbacks, but pulling vfio-cxl and the
CXL core in unconditionally would bloat every vfio-pci setup. Detect a
CXL Type-2 device at bind and request_module("vfio-cxl") only then, then
hand the device to the registered ops.

Each bound CXL device pins the provider through
vfio_pci_get_cxl_ops() (try_module_get) and drops it with
vfio_pci_put_cxl_ops() at release, so vfio-cxl can unload once no CXL
device is bound.

If the provider is absent the device is bound without the CXL
extensions. A built-in provider whose initcall has not run yet is waited
for with -EPROBE_DEFER; the deferred-probe machinery will retry the bind
once the provider registers.

The provider .init() can return -EPROBE_DEFER when the device is not
ready yet, for example when its CXL port has not enumerated. Propagate
it so the bind is retried later. Any other init failure is non-fatal: a
CXL Type-2 device is also a valid vfio-pci device, so log the error, drop
the provider reference, leave cxl_ops NULL and continue without CXL
support.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 101 +++++++++++++++++++++++++++++++
 include/linux/vfio_pci_core.h    |   3 +
 2 files changed, 104 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 2cc5dd20396c..e50b36751d9a 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2202,6 +2202,101 @@ void vfio_pci_core_unregister_cxl_ops(const struct vfio_cxl_ops *ops)
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_unregister_cxl_ops);
 
+static const struct vfio_cxl_ops *vfio_pci_get_cxl_ops(void)
+{
+	guard(rwsem_read)(&vfio_pci_cxl_ops_rwsem);
+
+	if (vfio_pci_cxl_ops && try_module_get(vfio_pci_cxl_ops->owner))
+		return vfio_pci_cxl_ops;
+
+	return NULL;
+}
+
+static void vfio_pci_put_cxl_ops(const struct vfio_cxl_ops *ops)
+{
+	module_put(ops->owner);
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
+	if (!pcie_is_cxl(pdev))
+		return false;
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
+		(cap & PCI_DVSEC_CXL_MEM_CAPABLE);
+}
+
+/*
+ * Load vfio-cxl on demand for a CXL Type-2 device and hand the device to its
+ * ops. If the provider is absent the device is bound without the CXL
+ * extensions; a built-in provider whose initcall has not run yet is waited for with
+ * -EPROBE_DEFER.
+ */
+static int vfio_pci_core_cxl_init(struct vfio_pci_core_device *vdev)
+{
+	const struct vfio_cxl_ops *ops;
+	int ret;
+
+	if (!vfio_pci_is_cxl_type2(vdev->pdev))
+		return 0;
+
+	request_module("vfio-cxl");
+	ops = vfio_pci_get_cxl_ops();
+	if (!ops)
+		return IS_BUILTIN(CONFIG_VFIO_CXL) ? -EPROBE_DEFER : 0;
+
+	ret = ops->init(vdev);
+	/*
+	 * A provider that is not ready yet (for example its CXL port has not
+	 * enumerated) returns -EPROBE_DEFER. Propagate it so the bind retries
+	 * rather than continuing without CXL support.
+	 */
+	if (ret == -EPROBE_DEFER) {
+		vfio_pci_put_cxl_ops(ops);
+		return ret;
+	}
+	/*
+	 * Any other failure is non-fatal: a CXL device that cannot be brought
+	 * up as Type-2 still works without the CXL extensions, so log and
+	 * continue rather than failing the bind.
+	 */
+	if (ret) {
+		pci_warn(vdev->pdev,
+			 "CXL init failed (%d), continuing without CXL support\n",
+			 ret);
+		vfio_pci_put_cxl_ops(ops);
+		return 0;
+	}
+
+	vdev->cxl_ops = ops;
+	return 0;
+}
+
+static void vfio_pci_core_cxl_release(struct vfio_pci_core_device *vdev)
+{
+	if (!vdev->cxl_ops)
+		return;
+
+	vdev->cxl_ops->release(vdev);
+	vfio_pci_put_cxl_ops(vdev->cxl_ops);
+}
+
 int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 {
 	struct vfio_pci_core_device *vdev =
@@ -2223,6 +2318,10 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
 
+	ret = vfio_pci_core_cxl_init(vdev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_init_dev);
@@ -2232,6 +2331,8 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 	struct vfio_pci_core_device *vdev =
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 
+	vfio_pci_core_cxl_release(vdev);
+
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
 	kfree(vdev->region);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 9fe0d1a3a370..7f3a2bcb5830 100644
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
+	struct vfio_cxl_state   *cxl;
 	void __iomem		*barmap[PCI_STD_NUM_BARS];
 	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
 	/* Flags modified at runtime - dedicated storage unit */
-- 
2.53.0

