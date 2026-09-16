Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9690E598C15;
	Wed, 16 Sep 2026 18:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583956; cv=fail; b=cVl1YVLHEsW0MHmeUG4CeAsYXSVKj33dX8zHuYtpOLvbu+uDi264AcRPNM8wi+3/7frnEUrF4GE+1e6JpomY8+11ceZNSK1J5mHi2XVh6JSxLbqQPipCJFAo8qlUNW6OjEgzCB1opJBFGaob2jqBIkNlEvfhhcCh+vImKaaegVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583956; c=relaxed/simple;
	bh=an0sfv4W8fK3xFk6yrwn/hD4jKCgIaOPOtN4Yhh7feQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b72ABM+FCcFd9VkxrfaMuLQ42JhX24deP/GJAvIVCEc9FYPn/df5Ot4WOh23fPrQH9xme44utv9T8CKgLi5BHJWtQtACIhklaC/xQbHZ7+6pltVzZ4rnfTumQAQCRP2OYbRSDOdQbQQpwlvwFFbS9QkmfarFHMok424aCOMI34E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=deWN35fa; arc=fail smtp.client-ip=52.101.43.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="deWN35fa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTXk0BtlE46pQqO4t7xekwl7K6GldosENl8lkC6PMDaf7IQJWFrl9ij0ArJsX0uI6AdVXOSSQt5eGr3J71w7j9aLAioL5iAuwWclcBilipjdOAOSyYUttRJxfgy0p4td1NOukZcHh/sdkXr2ANsa1iu67Cb/nr+0lKFpdqz0eABa2RIb6/7V7FEg9WD0ZIByS4VL4z/CPt/VI0fal9ey/l6KD7+CSXDPX7yY2tgUkDv8VPjy1g1GBhIJj9WzIexfcL1PngAViJM6X0kEFf60WlIoTCKpQ4fYJJ8YNuUTusibqozsU7F+CKeRgCoK+2TAQjhlOSahjx1XVBkyjrbLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJUxl+hG89S+bi90vMOSmd9zrrvRAKLAhC1/sZQy5cU=;
 b=uPLR75BZq8SD7gBfqlND2Ym5iV5CH+OH+4I5h7m4h8xzTUYIIkC/F0yLo923dyzt6SRJxLHG5p/BCYEAJE18A0Q6qxlIXla6yKFNqlM9n5O8INwkSY51c1YhiEEZ/Wudf6cXN8GUA9iR3LwEqYcug+DDjKdj0JMiVFUqpBspRzcbdJHfYhEBpKMG1pTdPrT8m9f1kUb9wGV45nARAVMCy68/e6PR0iLIsrhUzezPqG3+arWyi2VpjyTl1VsJAlid5OcCL/xHhezVVxLUlSFsycydi/pWBX6DVrh0LA5O1mxnvSaanoo5Sbs9wDFHZi6otJkAAPPhLc2K0UQAvi76cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJUxl+hG89S+bi90vMOSmd9zrrvRAKLAhC1/sZQy5cU=;
 b=deWN35fah8ItaKsqGCY/jZ+/Lm3mSyC7k4H4q8o5ULdgkJuoYxY2jNwxJJIXVJkIjHMUoFS/jsx3v9Rjk32FXFbVcRtFEz/kvU+XtnGPip/UnbpfU2gpKcCorj6Ee+7I9xpZSYlLkTyhnNQROurrVO5Z9KpSq7BmeB3Ic1NkECy4Qs99rKNWIFz8Sx8IW1287ctrgc5NtmnTCzMZGf5ByR05bc+kl0qEhNwKwMtGywnaiokwei9qrJrlltUwB68hdyjxt+33RHTrVsrKAryRt8OVbl9VLn25+rzqze3FujysenCpkwCJmr88diLtbA3RE9cFB5pJ/yEAi0QNWU68Xw==
Received: from SA9PR03CA0007.namprd03.prod.outlook.com (2603:10b6:806:20::12)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 18:38:31 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::ab) by SA9PR03CA0007.outlook.office365.com
 (2603:10b6:806:20::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:38:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:37:58 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:37:49 -0700
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
Subject: [PATCH v5 12/27] vfio/pci: Call the CXL open and close hooks around device use
Date: Thu, 17 Sep 2026 00:05:25 +0530
Message-ID: <20260916183540.3813685-13-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 53664b9e-b8d6-4335-9fd8-08df1421b4af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|921020|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RcNCMR3o0kBDD2NYSJTOFAYkLYe1GUIu4pw14f1XPcgdXteUR0ykQR2B7R/3nvfP9emaRBGb0B3ljkRmoHZtP80O74Sj1W77sv9frxDLMocu3sXqOqTOcVEGpeBshDSvGf2/C72uPY4So4UJpsBEn/dTSHbVSaY+/tHuAZp6H/tofvdWq55ZiqcP0AD+BnHUIz43ds7W/Mz/rhwHtQbJS9nK84FJIpgD6mm60ou2+SSjiDY5cXcOdOhendMjcn/NyfUJWvTgvHIjdniDu4x3vFL52WTnf2KUb3SKGirjECeE8EiW4Ck3mNXOoZ5O2cVAIop8A6gnfNYskoMb11tvS2gc8w0+a222Iuzo4+ORXILobDkez9v/lJOIxaMO+2Cha4La4y7HQZbWB58BKQ7eZvFWn3QbKICjV0gO5IF3uy0w2UnKPcji0rvXSta/Cr5pCSG59ldYUkMQjfWycuTbokmkGTrGVimSGqp2gfawj9SIhk7uryhCFDsjgJ9dBzHXsAIfY7lBQFcrZo2XX1zT2hRnCOEDxHhcQoO8LsEP08Rijva1uuiRTk2u2kN5hI1vrbmMtlxyeuJDunRkfuQJO9o40ULoQP0Sef0XozMlPwBNFWv3wSMxdj58mvFCo+h5fhnwqUA9CrxC+aE93BjHrVFRd81sG+gVTUXf7BAxyIcdVPQTHiJbYuyGlXpH89wPoU+i7et6736olZ1YfeN+4aM8vEs9hhuy+whYafqQRWc6DiXg05rTDikFtQZtdeKy
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(921020)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iHiThTU1ZNpswY/UAkQRAinVwzPo2rq3jqhd3HaXltTDe+eQBpgaBz/cObqWGMxfezOMlhfrQcepT4TvwPVUkYOfmJJQ8J6cjODczfGhxEcK2hpliB7pagrsoFMz5HU4Gai+/OobZlzuTRYLksfQONl5pPddGdEdyOfzsMkLACt2QfCn7ecCjrUc7trmprgsTarZfXqkLqT5qag7CJ6ekaw6uEn2J5/wbB+9lQqY44GHtTbkKnfFOIcSiiCJymk/NwK6mmH7SMcZu4z4Y/XcbV5ojknHFR7Ut3KtDr+5juSuxQvHuueXz6SIenUO1OAmEHPfCT522/P9TEPo/PcDKZs+2q+uP54+pSmnmh4Aix6N0Vpde90KRSwSSftM2keZz/laMBUBhs3HU8hawpAA5UeZ+FlDG8vzE4jqhfSV8vHIYFx8iHb6zOkWu+QNcjsb
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:38:30.6299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53664b9e-b8d6-4335-9fd8-08df1421b4af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181

From: Manish Honap <mhonap@nvidia.com>

Volatile CXL register state must be sampled from live hardware when the
guest opens the device, not at bind, because a low-power transition
between bind and open can leave the bind-time values stale.

Add open and close to the CXL ops and call them from the common enable
and close paths. A failed open unwinds the enable in reverse order:
unmap the BARs, drop the excluded ranges, then free the virtual config.

Factor the BAR unmap out of vfio_pci_core_disable() into a helper so the
enable failure path and the disable path share it.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 40 +++++++++++++++++++++++++-------
 include/linux/vfio_pci_core.h    |  2 ++
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index c5b7a59a4548..2f593b2721a1 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -591,6 +591,21 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 
 static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev);
 
+static void vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
+{
+	struct pci_dev *pdev = vdev->pdev;
+	int i, bar;
+
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
+		bar = i + PCI_STD_RESOURCES;
+		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
+			continue;
+		pci_iounmap(pdev, vdev->barmap[bar]);
+		pci_release_selected_regions(pdev, 1 << bar);
+		vdev->barmap[bar] = NULL;
+	}
+}
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -683,8 +698,19 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	vfio_pci_core_map_bars(vdev);
 
+	if (vdev->cxl_ops) {
+		ret = vdev->cxl_ops->open_device(vdev);
+		if (ret)
+			goto out_free_config;
+	}
+
 	return 0;
 
+out_free_config:
+	/* A failed first open never reaches vfio_pci_core_disable(). */
+	vfio_pci_core_unmap_bars(vdev);
+	vfio_pci_free_excluded_ranges(vdev);
+	vfio_config_free(vdev);
 out_free_zdev:
 	vfio_pci_zdev_close_device(vdev);
 out_free_state:
@@ -705,7 +731,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	struct pci_dev *pdev = vdev->pdev;
 	struct vfio_pci_dummy_resource *dummy_res, *tmp;
 	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
-	int i, bar;
+	int i;
 
 	/* For needs_reset */
 	lockdep_assert_held(&vdev->vdev.dev_set->lock);
@@ -761,14 +787,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	vfio_config_free(vdev);
 	vfio_pci_free_excluded_ranges(vdev);
 
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		bar = i + PCI_STD_RESOURCES;
-		if (IS_ERR_OR_NULL(vdev->barmap[bar]))
-			continue;
-		pci_iounmap(pdev, vdev->barmap[bar]);
-		pci_release_selected_regions(pdev, 1 << bar);
-		vdev->barmap[bar] = NULL;
-	}
+	vfio_pci_core_unmap_bars(vdev);
 
 	list_for_each_entry_safe(dummy_res, tmp,
 				 &vdev->dummy_resources_list, res_next) {
@@ -851,6 +870,9 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 #endif
 	vfio_pci_dma_buf_cleanup(vdev);
 
+	if (vdev->cxl_ops)
+		vdev->cxl_ops->close_device(vdev);
+
 	vfio_pci_core_disable(vdev);
 
 	mutex_lock(&vdev->igate);
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index e8a1fc398571..643f32c2141f 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -70,6 +70,8 @@ struct vfio_pci_device_ops {
 struct vfio_cxl_ops {
 	int	(*init)(struct vfio_pci_core_device *vdev);
 	void	(*release)(struct vfio_pci_core_device *vdev);
+	int	(*open_device)(struct vfio_pci_core_device *vdev);
+	void	(*close_device)(struct vfio_pci_core_device *vdev);
 	/* Pinned per bound CXL device so vfio-cxl cannot unload under usage */
 	struct module *owner;
 };
-- 
2.25.1

