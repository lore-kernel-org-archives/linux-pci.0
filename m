Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6857C4F7CCC;
	Fri, 16 Oct 2026 16:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167752; cv=fail; b=R5XXb+210+CFBniZ9x4Zt5ehi4bYEDyijpEPaMq/MnLnohx/YopVGZWqw0z9c3GIVZZtnEOgotsDV8jSWVjXGj9uqC4rzjrHBahkRmM8zuLA6CxDlZoUo1JTJ25n7AZR1AUrFUHhqRrGsIIO0alHjZ8k8aksQ920OcGCpkc032k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167752; c=relaxed/simple;
	bh=cTf1jq8Y2a6DA4OUibAbAV7xBww6erm7clMfB1a+boI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fv/6fwmA27eUeksOLJ+pO/6R6yWzSTGsmNcjFssZd4yrAKxywHefk9mtQ1Ws08NDlY83J/67JrkkGGWcELVN8fAUFhRVtOGGIt29QnWl4dFi8IkcjZIven+W01b4jpJ+1MC4450cPagokQSCw6QwdVbUccBku0XQ1y5RsKvnaRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K1bf7MjT; arc=fail smtp.client-ip=52.101.56.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K1bf7MjT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wK7g59Ljeg5xXvDmTMMcdMlYODq9tpc3pXSVW/cJA3nAw1Nl6+xr6diG97eV3cTdqUwdB21KT+NPbcQw88mU4ugT1qL8aAzctUbdpoiwVZ1fYz3g+R2bnhXBfZsKRI2BfznP8+XhtatEC7pQpUa2X14dvafwgdCZVcQ6sKl4XX5f7rJCskLh6T95v8ov9h5sB7v9K5u79dAf50FqTgEQZ0MMAltaLzQgsqGZ2eh7V6RuU7cSUjtGyIk8hd/LW5LksxLcLjKrO3TMw0e2W3lGvceND5sW0m7MJLbMPl5jI+uciyXQPkxx/lk+ezNv0OMYpoeR3zazYlXgpUNNMTt58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9G/rLpxAP7pky3J9PKOI9tZt0KdIYRRaxBzd1SwIMGo=;
 b=ZUP3eA9ynWVV1AGz6R6kKbitaXi9/bE08fBdo6A9KpyP+VJxP0ZGRXg0L2nBdawk6lLfcDxEDg2XKEwI1qB4lk9RGgxQrk1p9uBKSPUX/RWd2w9keSYkJiNcVVDcvv9v9RQOiVj/Mgt3yUfvsa2A1IeDfKp+/gM0MFGPJSI67kSsrgMxkWO/gk9l6w3RwGgq9FCzSGpSna+AWacd448zpYZautziKmFB36Tv8ND8jnAtUPp0otLtLaiGAzSQYKdS3cD3CyZYHkaIo2mXZ0QLsEpaaQccoTZQ1PxoSTIGjTKrEqjdSyFjnX9SXWbnGtnLIT9eYPWToe48Nob2MrNLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9G/rLpxAP7pky3J9PKOI9tZt0KdIYRRaxBzd1SwIMGo=;
 b=K1bf7MjTpuSiYeNGWCRv92hSt9/LrFOzD8v097mieI451WOS2ZBgQoyQ2KEDFGg+AyfB+bbIHMfU/lyjIsX3Gr7OMrv6b1AKUodZOuaDjaPKQ2r/kGEAGph0MUb+Nuq4M1JEyMjlLQcTzEG6hLNdAyZx1RkrV7rBkNgMtbktfj/zNuH35fk6dBlh5VIcY7bII9ZOmAu3YUGwg3pMcJw9XLqHwDpFZCAVTv57nLEyC1aQxIrmSfxUNaa121AaPlYDB0hu2zj3WxsK6a0zHZbOPBsutymTZx6DOoN9Wrp/YIFpTrKmjXkRrjIj8K6zIaSWElmxbIQT7/U+UhgWrza46A==
Received: from DS1P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:44b::15) by
 LY0PR12MB461782.namprd12.prod.outlook.com (2603:10b6:404:233::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 16:22:26 +0000
Received: from CH01EPF000BE94D.namprd02.prod.outlook.com
 (2603:10b6:8:44b:cafe::37) by DS1P222CA0023.outlook.office365.com
 (2603:10b6:8:44b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:22:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94D.mail.protection.outlook.com (10.167.244.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:22:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:22:02 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:21:53 -0700
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
Subject: [PATCH v6 20/31] vfio/cxl: Own the whole component register BAR
Date: Fri, 16 Oct 2026 21:48:27 +0530
Message-ID: <20261016161839.2765592-21-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94D:EE_|LY0PR12MB461782:EE_
X-MS-Office365-Filtering-Correlation-Id: 63375de8-24f3-48f5-586b-08df2ba1aa88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|56012099006|11063799006|261009223027099003|921020|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zafxXAmlRJ5qbwenuVpxfxH6kREVFt4EoeLTXVazJF29SHyPQ/TMrnrp/MXlc2uNYdM65rNfcjmrkdAgGM051f1mwuqF7LWVj869F21ZwLfzKGFVVHMc4dsjS+B1UYoLGajN9vDI8MOOh62Y7ac1LbdzceonhXu2UqBAbJrBYkfZHtSjSFTmrGDxIN0hRndE1WYl+n9xZBPSoObRXSNt0uwPZtKogUOjSM83keY+vAI3YQoNuTRsUDH3R7YHwWI9dl32mDECLpPDhXhaE2T6Cf3+jhF3Qw586pY9rswwdS7TmXy3VbZQQW445H2HH2GXN+lDK3jBsd12KE21UM6jsuKsHDW3As3xC0TA4DpdwhgVN0tSrEwbRMuj3efrFK9KCBqGp8mO8mVny5SjMNt0cC4AHx0LWzirtBMgdJUSl7ERcoKpX86w+tWPISJqYPSuj6vNJGSLdvkPgiqPIBA+erW6v/bNRGfdoC3OSeUoLyXZ9CbcyDw5gTmh4q5cawLEivQ0cIWZFWeIJz5xtoC8/Y3jWzm3l7bNzUyB+rBofDyv6lprAtdK0yGSQfF62IDGLNEDvcLSgVQnMt0FCEtzgXu74s/B+rmEAGb6QHBKHrPWHjghs9WSD5YAjJZT8SWGahZqfwsk/YgxKrPm+lUd62Gy63Y5A8NHlgdPFIe9PruOt01tLM6ea/dQJC8wxGb/XEuKbHZSVkvQPGFeySe8O/FcAvZ2hNsg5q5KIyHSew54mqjQoYMIkrEeYWiBkbAX
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(921020)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uxTzKrkKexqTjcpluaS4O1EqO+zO9Hj20q2d1L+/3V76zdcL3nHiSpPyhE/oHYCmyGNc0B0kuSRbyo29V9PAGgOxYZXJi6873Hw/bKoMdq5EZW1dNBsHpA0lHz9TYD8/qITBzT/HTpF3RgnhyJBjNT+5Vm6c8ZXjnYrRgmIPqHiOl6jTsyBy8VSnWJBYkpxZlUkJE4MSAVQAnlc633n9phuOPtFg7zJbT3J3IuWwOKNbhU36yQkVyi8Evd5sNjyTqqLu3AmuZXPXzBQHy4Sa2VueNxuOhi7qHJjHU8uOP/ADEHRlAq5ONSP7uhvxyAIMImQUWs/wWatadgHQE4dMlV2ZBmfxpS6vesSzwejNxjQnzjr9kOIJz1Vg5GsUwL+QWKTgDBfPwmvDNVxpB9XQAtVffClDwEv55DwuA+XVYhuLvPADMG5/5YoBjcfNkZzX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:22:25.9054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63375de8-24f3-48f5-586b-08df2ba1aa88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB461782

From: Manish Honap <mhonap@nvidia.com>

devm_cxl_probe_mem() maps the component registers through the CXL core,
which by default claims each HDM and RAS sub-block. That collides with
the full-BAR request vfio-pci-core makes when the guest opens the device.

After the component registers are discovered, declare the containing BAR
owned with cxl_reg_map_set_owned_resource(). The core then ioremaps the
sub-blocks without requesting them, so vfio-pci-core owns the whole BAR
and the requests do not collide.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index ef1fc715020e..052be27bc46f 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -33,8 +33,9 @@ struct vfio_cxl_state {
  * Create the CXL device state and join the device to the CXL topology. The
  * caller groups these devres allocations, so return on the first error.
  */
-static struct vfio_cxl_state *vfio_cxl_create_memdev(struct pci_dev *pdev,
-						     u64 hdm_size)
+static struct vfio_cxl_state *
+vfio_cxl_create_memdev(struct pci_dev *pdev, const struct cxl_hdm_info *hdm,
+		       u64 hdm_size)
 {
 	struct vfio_cxl_state *cxl;
 	struct cxl_memdev *cxlmd;
@@ -59,6 +60,17 @@ static struct vfio_cxl_state *vfio_cxl_create_memdev(struct pci_dev *pdev,
 		return ERR_PTR(ret);
 	}
 
+	/*
+	 * vfio-pci-core requests the whole component-register BAR when the
+	 * guest opens the device. Declare that BAR owned so the CXL core
+	 * ioremaps the HDM and RAS sub-blocks without claiming them, and the
+	 * full-BAR request does not collide.
+	 */
+	ret = cxl_reg_map_set_owned_resource(&cxl->cxlds.reg_map,
+					     pci_resource_n(pdev, hdm->hdm_bar));
+	if (ret)
+		return ERR_PTR(ret);
+
 	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
 		pci_err(pdev, "vfio-cxl: HDM decoder registers not found\n");
 		return ERR_PTR(-ENODEV);
@@ -133,7 +145,7 @@ static int vfio_cxl_init_device(struct vfio_pci_core_device *vdev)
 	if (!devres_open_group(&pdev->dev, NULL, GFP_KERNEL))
 		return -ENOMEM;
 
-	cxl = vfio_cxl_create_memdev(pdev, hdm_size);
+	cxl = vfio_cxl_create_memdev(pdev, hdm, hdm_size);
 	if (IS_ERR(cxl)) {
 		devres_release_group(&pdev->dev, NULL);
 		return PTR_ERR(cxl);
-- 
2.53.0

