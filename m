Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012070.outbound.protection.outlook.com [40.107.209.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9554E06E6;
	Wed, 16 Sep 2026 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584038; cv=fail; b=NUsmYD3SH+DMV70yZ0x7EAszXjiYmkvCGc7vOelos/44nKvfg65kr5lBMdiD76lnnW0bkwuKPnMimDSRutvOKVWKETzwMclLN3wW6WIQlHXC6bzdz9yj5w0IoMhvk4CEnqL9BTGdjz8R3zjZpudMtNk2lBOu4kY/ODvHtKS39vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584038; c=relaxed/simple;
	bh=cjAXGDC0Jc/O3eoHfRHeItEyABS8stcdqeisvzw7XGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsBwGe8cuhrhRXFhMdZ+6P8IygwI3mbnak95jghUshzzVcnFoFJ19mSKmQls+azclFGNOtEGPWHzIBXRw0Q90CMcEu9mDXXKsEOFo5UsSnoLItHifgJ0+TTIs/M2S94pBePO+BKQ3IVkCij4g8S85BM8QZsWPBVhIRkdPtcXBS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bahCUtVm; arc=fail smtp.client-ip=40.107.209.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bahCUtVm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kNsxlrY+TL2hcFU7UyXrLCIvs2vbaCmRfgBc8eqYiugJW8XgUYDqTvcSl8hYikSi+k8/uWUl2unYxr2IaiqIWch4bWA1mzvrwUtbtIvY/55od0wAYfL22rHeuENhwvbHR9U7Yx7NDqJKCfBhhudStB+nqoaIC45JrJUT/o+QKGYPbm9YZLd15UZI5aT1rNFXvoVc1EmMiWzL1aCqqQKFffL6dgzQ+sVpOmjmZXCgRLEc9wCMO1Voo/n2J4pHG63A0DjYQjAMmoymOxHjDt6/zG2RLj+azaFQlUN9xDRSyHKxy8J8g8p+kfYQDnxRpKHoo4Kk22rUzQtGUk9FhdtGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFnmRrZKfx4O4CsKKA6h4gSRy5nAylN+Z8udNxHFY+s=;
 b=Cb0B7ZzXieS4MvdgJLHITWGDnleOE+0WTx3EkwUjivEB0Jiflq4b7dSEt8ys4V8A/xhBCZuaQpPKmFyjq3JYs6hTI4EoL3DcFHMnfwk9FFuIUV4uKAtoirYnoH8NcUWawCNQ4LrhLoRC9ndgIup9ojgZwu+DijWv+b37ZY0qtN9qvbuxm9IdPSo47IiaAi8SAz4VXJHn/Evvymep6kv0GGu3BiCx+I/7B7xMMnRfANrfkCiHvUf0dtyDzr+zfmiTYCGUuRcU2eaousy4sKf/4Qs2/zJjhO3xYOn31V5A6XS6oa98QiZoGObuF1UsndEW5s3t6Pdk9NjY/2zGIw52og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFnmRrZKfx4O4CsKKA6h4gSRy5nAylN+Z8udNxHFY+s=;
 b=bahCUtVm76ZrhMZhe7i8cfLiP5/AQq8LReHMYV2WSDniSamAm8q08XDTlRVnXyqiSQAuKdsADlsTdK3O5efquwLFWyH8NU2cedTVAduW4XWn6jK7rNdW/srhJ7DCWccwkI4SBraFeArOK7AiTQa4wpehjBnFUq0DtM704isTQa3zNk3dNg4HMolM/aiUoXi7s4GVBqY3fX4lG6tZZfjp+IixdHT52vzPAo+FuTUI28B6j30WL+S04tyO8NnuvswC+5KE8Qey582znaXp4ff9S1L6JtKPAR1EG5m2w4M58JGwVM/Gj0w+kc5yUc0B59sIex5rsb5cvHXk0MNpwhqdSg==
Received: from SJ0PR03CA0290.namprd03.prod.outlook.com (2603:10b6:a03:39e::25)
 by DS6PR12MB649431.namprd12.prod.outlook.com (2603:10b6:8:416::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 18:40:14 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:a03:39e::4) by SJ0PR03CA0290.outlook.office365.com
 (2603:10b6:a03:39e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:40:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:40:13 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:39:40 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:39:30 -0700
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
Subject: [PATCH v5 23/27] vfio/cxl: Describe the CXL device and decoder geometry to userspace
Date: Thu, 17 Sep 2026 00:05:36 +0530
Message-ID: <20260916183540.3813685-24-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|DS6PR12MB649431:EE_
X-MS-Office365-Filtering-Correlation-Id: 32834c44-659d-4a74-ecfe-08df1421f1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|82310400026|36860700016|921020|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q6xw3rPycZkLytz09ow6r5TdNmuvUOUJnG1TrAcOjmPNc6j3tHoMZ44e3jGAGIFl3A9FmUYLtjP1fKlol/RNtlD1Ey/LsgrP8+2gU3WWVIryn/7juG//MjSmK8hn/6WfemMJFoHahmtuCg4YFJb43+n2OEpkr61E4FGvqz1P5/AT8fi8Nzn57F0gLkEo6rxOQ1uk1dc2/XO5Bc2sVza+o5Dgh4fm5oqswbl8pcEdbdIgloX/LTTrcfPX1t7CW7SSEqlehcEbMu3MsojYllUaIxScUAbSOoCuStvekFWH+CRH5Zf42+iJKv8RJrqVclVhJoemPtpGt0Bdaacqw7AdF+JaOU1/3ycPpoMV26scm/UOHLX5ng1EkVq1vvmWBLVmo7GYlIRTDoBg2OX+m03pOnU35nMTLsuCUX6w+24dzwjaLodkaT4+25uP7zV8eVSvIbpitgXzXPHk0QWsyQ0o8XZUcsgYZMr65OHC341xFNnP2fka5Q8mv/iwu+i2Nh8tITU6Pf4FdzW3S7LTVaL4IF2goC+rcRj8boohwXLQ/0H+XukiZChkt/wwUx/eVCHiORX4CnNNOXTfvz1v0pNzQqUb0sQpCeGn+Zj9sSr1CKCx080vXRw8GbpIQBYpbOidwWjso0n86UnuJSG4h7ufs/6auvXrmoLt+Msb4Gw5ozYN47YNZNkwmtn1gXruaHKKo9z8ZRHBeR9/+Qvue+D2LVyflI7POxJ8U4Wp5iV8NDwYqf/T3putpze3MEryDe+R
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	E/w5OmipmKuZ+SejvHizpGc+KZz7diJDPAUTVDkoLD5KpgR/QMcDa+awuz2e6KeAMsOjv3cP70zbhrKJ4M6psJkZeMZEOIKwfHRPMlAG1Nhxl2EDjRuKZDSnnBkktWYZeBr5nUN5+JBGWlcKTJtVP1hmKhCHNyOj2P5vf/G/fcE7Yl2yqSRhMR98Cf35vm0YQ6Sou2XIYhLdAIOtxDGzKMS/f2YmCLQddU8ggDQnKoy7/33x8cigLmQxMTdFp1oz80o3WAVmv9eqppLXfrVqZnn1enSZLRe0SLhRnr3ua0cy+6tEqHZzsKXrGA14ucTYb8S9Rc5qycYVe/RHVEgWtHdErEjoZlKeKh/wH91Fles3RGwHB3/XKebS/2PhHO5ofohKrwEvYDlXckR6UGiy7H+OalLcnMU/1GWsFirGRhTjkpYTfXozojjdL9bWwvkQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:40:13.1912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32834c44-659d-4a74-ecfe-08df1421f1d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB649431

From: Manish Honap <mhonap@nvidia.com>

Advertise the assignment with a device-info flag so a VMM can tell a CXL
Type-2 device apart from a plain vfio-pci one. On the trapped decoder
register region, add a capability carrying the BAR and offset of the HDM
decoder block so the VMM can place the trapped window where the guest
expects to find it and size the guest's fixed memory window.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 16 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     |  3 +++
 include/uapi/linux/vfio.h            | 18 ++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index 395b4a5b0956..5fe8e35c63c4 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -261,9 +261,25 @@ static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
 	return count;
 }
 
+static int vfio_cxl_comp_add_capability(struct vfio_pci_core_device *vdev,
+					struct vfio_pci_region *region,
+					struct vfio_info_cap *caps)
+{
+	struct cxl_hdm_info *hdm = vdev->pdev->hdm;
+	struct vfio_region_info_cap_cxl_comp_regs cap = {
+		.header.id = VFIO_REGION_INFO_CAP_CXL_COMP_REGS,
+		.header.version = 1,
+		.bar = hdm->hdm_bar,
+		.offset = hdm->hdm_offset,
+	};
+
+	return vfio_info_add_capability(caps, &cap.header, sizeof(cap));
+}
+
 static const struct vfio_pci_regops vfio_cxl_comp_regops = {
 	.rw = vfio_cxl_comp_rw,
 	.release = vfio_cxl_region_release,
+	.add_capability = vfio_cxl_comp_add_capability,
 };
 
 static void vfio_cxl_release_hpa(void *data)
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 8913a9e24302..f02a5240aa71 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1364,6 +1364,9 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 	if (vdev->reset_works)
 		info.flags |= VFIO_DEVICE_FLAGS_RESET;
 
+	if (vdev->cxl_ops)
+		info.flags |= VFIO_DEVICE_FLAGS_CXL;
+
 	info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
 	info.num_irqs = VFIO_PCI_NUM_IRQS;
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8927a7a4e8e4..8f9518f09bd0 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -215,6 +215,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)	/* vfio-fsl-mc device */
 #define VFIO_DEVICE_FLAGS_CAPS	(1 << 7)	/* Info supports caps */
 #define VFIO_DEVICE_FLAGS_CDX	(1 << 8)	/* vfio-cdx device */
+#define VFIO_DEVICE_FLAGS_CXL	(1 << 9)	/* vfio-cxl device */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 	__u32   cap_offset;	/* Offset within info struct of first cap */
@@ -503,6 +504,23 @@ struct vfio_region_info_cap_nvlink2_lnkspd {
 	__u32 __pad;
 };
 
+/*
+ * Geometry of a CXL Type-2 device's HDM decoder registers, so a VMM can place
+ * the trapped component register window where the guest expects it. The trapped
+ * region spans the whole HDM decoder block (every decoder), not just decoder 0:
+ * a VMM reads the decoder count and each decoder's committed base from the block
+ * itself. Additional trapped component capabilities, such as CXL RAS, are
+ * exposed as their own region subtypes rather than by extending this cap.
+ */
+#define VFIO_REGION_INFO_CAP_CXL_COMP_REGS	6
+
+struct vfio_region_info_cap_cxl_comp_regs {
+	struct vfio_info_cap_header header;
+	__u32 bar;
+	__u32 __resv;
+	__aligned_u64 offset;
+};
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
-- 
2.25.1

