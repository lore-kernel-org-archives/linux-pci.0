Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013020.outbound.protection.outlook.com [40.107.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43E03EB0F0;
	Thu, 13 Aug 2026 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613944; cv=fail; b=RIyrG4/5WurjJDUgyXqnm3XAqYH6S50OtA50xgMpEe+vtk9bt6Iuil6HklVX/gvxrLYhTyy7/tVz4j38aLxAouXc+PqX3y0xSNaHMOtZv90Xdxv0xz0SKCW2G9Bm88bSv9OSfe/cnc8mNKDF26neuJ7lUVjRwm/ZSr8Wvk5nnfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613944; c=relaxed/simple;
	bh=T6y+jk+AyHV0sCAnAnpps9Vhkb38+dgEGss3ew8GktI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tB2H8VfPhuEtQAf7zRi5M5944q1+ApItPzW95EwQbiVi3MY4bYgjQaDCTHEIy0/pQ2zA2LPkQpHIgw/VhjZmxkBVfWdzBhxr5iNrQLoXeauvUlHGHh1/e/hv4WrtmX5STy03PBALCHB+mPJGm2bwlscCQMH5d2V83d0hHoNwC/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f+GVPPXT; arc=fail smtp.client-ip=40.107.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f+GVPPXT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jxIzkrwKTXJaVP96vGMLT8sy4LLvdgj0Et8TP9gZihwvqwpuQq4L/mRxZcvj3m2NQO6RoMpEDyOworCl5oc5ZkOlyHSAQSBUnwCtK8fQ1ZV3LZ/X1tunLBd7BGMNIv3zvNW92dnt2zlQyNi99ZpWEAmp1fBf2+sN7W3QD/77ANDIUL57HW9rVZYbmKWWFwTvreSmfyBCBilv+rs6YqaKrZ+7Sof5kGAOwOfg1a34w+HiJ+bmGnil3U1kVjXVWbQmu3Hj5vBgc8POHwITPw2tHGYk6iQzvd0EQY4jUQI6eUucXqSq77fSwSLty//2WG3IJYSs/TB+ZHYELmID9Y/aDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpijeAIkCZwlYrau0uNABqdATRgVbCFG6S7HktVuRTc=;
 b=vfan8YDxF4TySTmp0DopAKKlnuZjnZ+ti1M0ZON745wlkQ+tQZdLyO0EI/iVqy3kDDuhCHehwKf43ekcm3732jj8/K0FVwMj00eyNMi1vUSQT1U1PGXJJJltMIKLS90kuJUVxBayhOHjasG3N8SAhStn9CJYTRA3yM1O/ERPih9rbvRBCrJEpM2/LjibggpZN3rho5Tn+u/gTR5dg1YKHf5D2p5RRcQg10yECRuQpy699+DCCV3ZkYbAwpmPVcqBmXexETUJbo5YoFfZNcvtLDTiOW3hW87CgK1ILIGNZWPMhOdWcEw82J4P86jlHxt773WEuuOJXdqCRilxi22kdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpijeAIkCZwlYrau0uNABqdATRgVbCFG6S7HktVuRTc=;
 b=f+GVPPXTAvD0BGIiqIhXqWbNcIvZxs1vRbbsET6T7vdwtQC3blctwjs6URGi6Qp+twUqIaFR/t7V/juBFnNcPTv0UydmVRC71RSxBZzMNfdtEfIM8dVa8fsDdOLf6USqfaI3suHb1MZMf9rsxLfNCeosBmr27F0QFicVnM5xfd5J7CEXz3djNIu8F6uPYN0if+FqGKsbdJK83e6pLIekH2NxZOuQieGB7jU0dol1/fNxecdnIJLD2smh7Kh+vnv+oYaIjSveOEgyY79icQUSiFhm4RPt2NbHXtdr8HkhNkIYSUgNJusI39IX6Ge/1NqDcG0frK1EBQAeFsKfdTovzA==
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 09:38:56 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::61) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:38:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:38:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:38:37 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:38:28 -0700
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
Subject: [PATCH v4 09/27] vfio/cxl: Create the CXL memory device at bind
Date: Thu, 13 Aug 2026 15:06:13 +0530
Message-ID: <20260813093631.2288172-10-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 224942fc-2884-4678-d597-08def91eb177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	RyVWNzdcCOfgaklgms4F+iBPaNcseiR/9/Y70zKtGDWWHCzngFEs7hxa8wv5KoILLbqTzWqdyKgDt6eBDUi09VgTx1Im4hPBKMkfUV42nbKK+dbutguUH7xELzv3mdq/+90bVncvv4UfKzLSj3tM9BXZgNJLAMZrLRdSdS4BUexXmPXc9JDRJgs/1Za6aRGyBChjHMFKByvTrbVHoZt8GgXRAZixvCDiE6yg7NYaH2xGHqqctof7+FFJJckuJb4UPGshFpFIV6PeJsZLC3yjJTJa6TZz25MC3mxVvXU6VTfW7pvTJcTlcfVX9EKpS0tERsIm4/w/TxtwjXZO76yXe1sFcGZk81wlORgnMFHQSYWcAs51s9GDqpgH8Srq0lvT6juk8u7FAVYxcEdCLAhiAzUjyXhOBMwjOsj7SWm8zcMApp6sru4rSgZChcPIT2grZZegehlglxqW/zpeycw/zwHTfO84Gx07O+cG+HdwGTrwjQ48W+ezvcCzAMqT8/q/45cuC/OKOTyOWn7DnFtCt7eQnl57TDOEpeTsxg6D2lLtXDY3XuvqQrnpqFKk26RC0JmKz0G2lR0sgygMbJOR+LunJRPaNvMNZNDCAq/U2vZDZLaZPFNkcVRcdPqRttv0urMRBkcf8uz+gTalrvLfOk+7vpBoSin367iXEXDdSDRefeUyhPqq7GsSo5UM5GB1O7oyQ94mTLVP4duduixDK0DS4zM42EbrfMChmLRWDQk3YdqbBTJ0/F8xnRZwH+WV
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vOF3kkPgrRwrpfdcY9W055iBXiXI9qjo1a6+bKMzgwxA8LTUFMn+0rxsSEHj+imXC6CHAMtNmE3EqoUzSb542tUz/52hbSavT5Ou4wLk/hSckFX3I4hA9jpDlqg285oxDTnlg0EQPwxMup/H2e7WtCASckTfnw10g3PSGMPhM9Vm7FpLTewCOhlat3GYEzOTYYd1VxIhsQxOJKSICsFM6/r/bdRiJkXauZwa+PfeiQVZFFfYSXk5yN4hOhrttrTZwTOxlBfF611RO8TMGrGJHMUtCcKE/gr2VRdURK1OQ8cZqDEJhCyI6tXxDh4ijNthlWAnziuy19xszXb13TcCxWqTzs9N+pc0P9dgoNYHdksb7Hq5eEMV22crj7Jv6lpJ7crkxYNOL7ybLTOGja+wz+F+Fo/GLwFrNkqJSbwS3raWix8AVeuuJgm7ZfDK9cme
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:38:55.3397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 224942fc-2884-4678-d597-08def91eb177
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

From: Manish Honap <mhonap@nvidia.com>

Read the HDM region size from decoder 0, cached in pdev->hdm at
enumeration, and use it to size the accelerator device state. A Type-2
accelerator has no mailbox, so cxl_set_capacity() establishes the
capacity that devm_cxl_probe_mem() then uses to join the device to the
CXL topology and resolve the host physical range.

Everything here is devm-scoped to the PCI device, so it is unwound when
vfio-pci unbinds. If pdev->hdm is not populated yet, defer the bind.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 53 ++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index cbec7319452c..125e11354a46 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -6,15 +6,67 @@
  */
 
 #include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/range.h>
 #include <linux/vfio_pci_core.h>
+#include <cxl/cxl.h>
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
+	/* pdev->hdm is populated at PCI enumeration; defer until it is. */
+	if (!pdev->hdm)
+		return -EPROBE_DEFER;
+
+	hdm_size = range_len(&pdev->hdm->settings[0].hpa_range);
+	if (!hdm_size)
+		return -ENXIO;
+
+	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
+					  PCI_DVSEC_CXL_DEVICE);
+	serial = pci_get_dsn(pdev);
+
+	cxl = devm_cxl_dev_state_create(&pdev->dev, CXL_DEVTYPE_DEVMEM, serial,
+					dvsec, struct vfio_cxl_state, cxlds,
+					false);
+	if (!cxl)
+		return -ENOMEM;
+
+	ret = cxl_set_capacity(&cxl->cxlds, hdm_size);
+	if (ret)
+		return ret;
+
+	cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl->hpa_range);
+	if (IS_ERR(cxlmd))
+		return PTR_ERR(cxlmd);
+
+	cxl->cxlmd = cxlmd;
+	vdev->cxl = cxl;
+
 	return 0;
 }
 
 static void vfio_cxl_release_device(struct vfio_pci_core_device *vdev)
 {
+	vdev->cxl = NULL;
 }
 
 static const struct vfio_cxl_ops vfio_cxl_ops = {
@@ -39,3 +91,4 @@ module_exit(vfio_cxl_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("VFIO support for CXL Type-2 devices");
 MODULE_ALIAS("vfio-cxl");
+MODULE_IMPORT_NS("CXL");
-- 
2.25.1

