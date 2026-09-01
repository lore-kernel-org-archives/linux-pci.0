Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5DB47A880;
	Tue,  1 Sep 2026 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255292; cv=fail; b=bmyZZyzqFgyCtuwAn/4rMdwb2GBHBBFpr+lMwfottdapVvv+ZMrNfuPce9/ASJtKmwFbxPPsX59mrwl8JWrNN8ZXy2uDZCe/56Y9urv0SMFwKpE8DibTRuIHHnposuGONM/zyv8SKH4zrm5NxTyFYw5zkC24LTZoJUIT1rgarzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255292; c=relaxed/simple;
	bh=6/0+rIF18R2hHwHIk3wR7v1uy6TyvcTkvPikNA/fLE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9+ZDdKDwcD3bqaHZ+nYdsjAGE3bVfRN7dSZ+oXqMPIkXNT8qGv8JI/DtpvywVkByj8Ez1y1b8N/zJvxa3YGWtcyYKL6e1TX4+zWO5E6GT6X6Q6DtmfJuzcjVvGeL79DA6170hqu+2ezBpLr3sMBv19gchMXRoqcBeudy7Mpp8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oEjQZGJ7; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oEjQZGJ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uijsJ0nYeNUEd424/lkq9Qon64pJate8LC3RhyVQaWEhxMJyOvF8Lvj5wEppNF+ZF8xIiWd+SjjHJzHUSi1qPCgWxQOn57BauHjnHKJkvO2wd699yNxW9g2/U8KFzJUtbHsneTtvyqWGaAvLwW6BbeHXsRsyxKOfP7BtTyHsQtmCP2XQo+4AWU5HTwdAHsm2FHzD07TeWsGMOOG1yArp3xROg+Fg4aofqDDHy4HsB1R/xlfHoECFfyB3ZOVaXW+g0oBCJ5MTWOOzdQFlrHRiqT1PlSJsM+QnJUoJ+Dmt+KmfzVMeJJO+OHarbhePMktGLy/nvdpvaKGDxbO5Z8gaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds/ULF2lyfwVZgxd1u+g9e/hq6Ves5ljXltO51Craio=;
 b=yO1V3lXbC+iKpVuB9M9DXxj8943kLIt3TpshnJvAvXmpaDihx4VzIamhiquR66pOK+AS47cYf0PMaHE3NdN3q4f2m2+inIK0DTfNSqItzYEO3biQCTo5HSXWkvTYjMF9Zd9HsDEDwjcunXZcnkyFBgzEafEDeA/ZgJqHY6VCg9frIrDRrsr9pkl6m1TkfZYaHG1wBoMmFjIoTz980WPURbyyNyLyGqoIbsF/g3wK/uux92OcLlxF2dxjUtOm7aG1mfM49ljHhlde+cVGfMwWJt98FNgNiUen2y0xNsWmTg9a2RlsFVT38YMVdkMrV1ujnc5bJ54hNWAdHbnaqCv+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds/ULF2lyfwVZgxd1u+g9e/hq6Ves5ljXltO51Craio=;
 b=oEjQZGJ7ywPTApJniEFr3ewmm6YUFS9nBhIIyBuT9xpcM8M6V3Mn3vNP6Homnt1+87NOC9544zsEu7sJ3pw8hWnNEKWfQe5/YUftpPXu+bgGr5GGKvoxPI6PkftJKPSvvNsKYlHdQo0bmDyBJ2Pmgv8YPxlF3BTXLDz+oYG1ZoW9KjaEAiZwU27C8t5pxpXzD2IOZoHqVIRRN4EwrxizrTTr38YzE3z2dGUrSckzdtcPTQtg1KK7Uf3GN5ZyC1VjZzhjvG+dDy3xu83rusLPXMWaPMXftzmpnS1g92NKOjnbzSnWL/UUG/6eCMB5zb809qnDCBk6H2kdLvLbqFz5hg==
Received: from CH0P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::29)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 09:34:22 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::21) by CH0P220CA0014.outlook.office365.com
 (2603:10b6:610:ef::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 09:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 09:34:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:34:01 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 02:33:59 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<kbusch@meta.com>, <michal.winiarski@intel.com>,
	<satyanarayana.k.v.p@intel.com>, <sonangp@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>
Subject: [RFC PATCH 13/19] vfio/pci: Serialize DMA-BUF export with recovery
Date: Tue, 1 Sep 2026 10:32:11 +0100
Message-ID: <20260901093217.8539-14-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901093217.8539-1-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 72599f74-b2ee-4487-9afd-08df080c34ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I5qF/7eM1O9LeEWeATwNXYEhl7jqWBKsI9irXjybUogA91EtPtzkP130UbqhQiikPKBefM99ZXCrFCX/6QciNO3CdiSRygdjNIucbbi897Px6QjCGXR0kMdYtny+scvZrMaEv5DINz1+Z9qTUSA0NbxCOf/l5lmrhniZgxZWjh5yq9ONBt5gB2TBAKihoLMBAlaND6JrJ/N4Z39S87qEwVBEjLyUFjGvLXAmImnj7khPhR6Q+SdLHJaigs+BBzPzKfrq345dhf5X1tumBHqsu/FV9bkYBjOIg+GGa4ibzl6ZonwGzVQJcBF+zCwgoEPwsJ7EN1S2Vz/vJI12Yha/H4HOWS9r9CVj/eW4z6Wc6Qv90AUHpnrZE7sVAYN+wsYOhnpEIGf536klHU3BJWewIaJnozg8ChGsUPZHeqbMTbPzP70iLkx4aM8e50vnrtUtlGIj70ijoQeH15o430irdXR7ZIG8/uEWQLZZYduzxN/o3A0S1xqA7OQsM56NhBZ1KemPSAZ0f62HC4eB9pklZagcvheDlKv4tRXuQlTXd/Mw2FzmK2+K5ffFDZ0NXgQ2Lovlj/FS+sYjOBOm7ijpBJQ3eS0PuOaM3g8EidigA7KfPF5GCJbyTCp2WEHDOvLVihU2dn9HK6zPyWGt24eAiPfWhDZ7OzxEQdPxqhiSji17RVDHwLmTcInemuEqX+FwrG1/yaIaW4K4I+eXzMDqSQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	eTEKkIHSZPN9R2kAKD94WYsoQln6zlnTaPXD1sEgOyUM1vmj7fUP9YlU4hcTFQxbIY1uhi7tBnDRmG0C5KXNLQ+zMXOIcxL++yuK7Pc2N4WUUMmyNkk39tq6ixCmQGE3+WQ5vcd18sD1cgTpxWqxQacRURox7yYi32eKO2FyeN2DFoYGWxCFNS8qm6cY3L1nLldZrmRZH6PWYvj2Z5CR5E+ocB8dmOtUWEIMac4Ye73ALm78JeLG6tpDzhh3WeRgXqRxt88rY8xROilS1yHjeBcC64hVLrVJpNjbJaHFKqBr/yk0qMLSK23E6BVYc3BIM7K3I/4p1AZgHzbqaZaPpkMcpm4If806Ox1BPLvM/n3Y84GnTpsj8/acYvwm0kreL5G9gLDdnzf/yjiyzxFZrWmvzN2cVVI6q9m2C5bXESUpoINFAV++jJecEVQUL3a9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 09:34:22.4653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72599f74-b2ee-4487-9afd-08df080c34ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129

Move the BAR iomap check under recovery_lock and hold the lock for
reading from there until the export is on vdev->dmabufs, so recovery
cannot invalidate the mapping in between. An export attempted while
access is blocked is refused by vfio_pci_core_access_begin() like any
other device access.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_dmabuf.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..a54d199a72c9 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -243,12 +243,8 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	if (!get_dma_buf.nr_ranges || get_dma_buf.flags)
 		return -EINVAL;
 
-	/*
-	 * For PCI the region_index is the BAR number like everything
-	 * else.  Check that PCI resources have been claimed for it.
-	 */
-	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX ||
-	    IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
+	/* For PCI the region_index is the BAR number like everything else. */
+	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX)
 		return -ENODEV;
 
 	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
@@ -274,19 +270,30 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	priv->vdev = vdev;
 	priv->nr_ranges = get_dma_buf.nr_ranges;
 	priv->size = length;
+
+	ret = vfio_pci_core_access_begin(vdev);
+	if (ret)
+		goto err_free_phys;
+
+	/* Check that PCI resources have been claimed for the BAR. */
+	if (IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index))) {
+		ret = -ENODEV;
+		goto err_access;
+	}
+
 	ret = vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
 					     get_dma_buf.region_index,
 					     priv->phys_vec, dma_ranges,
 					     priv->nr_ranges);
 	if (ret)
-		goto err_free_phys;
+		goto err_access;
 
 	kfree(dma_ranges);
 	dma_ranges = NULL;
 
 	if (!vfio_device_try_get_registration(&vdev->vdev)) {
 		ret = -ENODEV;
-		goto err_free_phys;
+		goto err_access;
 	}
 
 	exp_info.ops = &vfio_pci_dmabuf_ops;
@@ -311,6 +318,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
 	dma_resv_unlock(priv->dmabuf->resv);
 	up_write(&vdev->memory_lock);
+	vfio_pci_core_access_end(vdev);
 
 	/*
 	 * dma_buf_fd() consumes the reference, when the file closes the dmabuf
@@ -324,6 +332,8 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 
 err_dev_put:
 	vfio_device_put_registration(&vdev->vdev);
+err_access:
+	vfio_pci_core_access_end(vdev);
 err_free_phys:
 	kfree(priv->phys_vec);
 err_free_priv:
-- 
2.43.0

