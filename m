Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB63A3909B8;
	Thu, 13 Aug 2026 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786614143; cv=fail; b=GNp9Yd6ZErWdIQMw131DZvKL9GHwGqOHXqE6MDZyhFuBOOCzelK7AML5V1fl70yank5trEzEIJ8raxwUHYW8dvjZCaANLUddjCmjyH/OxBwSRXvzSE6Nvuop8QDc8ML8kYvnNWBlXMi0ShKSl88Erh2V7r7ucEeSz6/KNdClWeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786614143; c=relaxed/simple;
	bh=y25IVD47qzk1Q7r+gU24x9WO89IZWdXPmHpd0stnTS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uMq/ke9n1TmEeWQmdWlejJWGHL27TExJplJ1eHAfUaWY3xjt3X5BUErwPFZZzUUHQwYMHFexPU+/+2+SDe4ztFFwZ2iNEZzlfwUan/9XaqYbR9kNhXRFx7GYaEHGDjQQeM+52IJwp40vs366pn7q/B9ef3vE9DbXom2pvvVhmvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SqvhHAjz; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SqvhHAjz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtoz9lo0E0bMPfaaQAhSzFDQwFJj3ZS89f6hExBNFzLtKUmXmM2P3Mq4paHaAe9IYDs3aGPAWd48lj+bqTNKz3SWkEp+XOJ943syB6fCbLnv7els7AZ1CosVjIvpCFzzokLbT4Q/P6bGQIjbE1R1lNGH5yBjZCWc+gK669UTj5Jb30RHPmULgEQai+iPm6ae+rIvmKDA8TJ2gdoxOFz5GpiHlp4V+2AQ110iTZXPRWDEDhKmhJxA44y1KxQLnqrxEvb9sQoeWeb1V77nYID05wiIku+FxWuwv1LzchXfmgBuakofA17Bfh5NwKs6o02X9rf8EXtSIJ6ZxkFtohPh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq+m0PWDfvVC0TQBd4rkZ1QYOWM/lYTtaIlTTyCE/iQ=;
 b=UoD9NOkDSe4HoyTvzq8Q6zmYeSEJa2LCoNnFxjhJoO/AarwPDcAs+GRX1pUOEetkO4aZ104V/nUNMRKJrsmQJTY9EZG4jnLC6HQw3eyHLo8kvcQxkwEuxQaNUclUzEiTNj6MI1Lu4nYLRJlCuHKsBZeXQgJjM+ja3hvIHJ2zyjRJJsGAyxi7OTLaYbqccft+/YzNHRlMuHtVNDoKR65ROCDacXPpaenQM4EGvo03qhHwwoECwUUR2YZOl7LLlu0QH+res6pmsU3gDoT9Heh7EKpWmJMLbMGtJJwZd6TMGKq4S1j5qoa/Bo4vlEgl3fuD5tzz4v9P7zlplEWaCC8UTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iq+m0PWDfvVC0TQBd4rkZ1QYOWM/lYTtaIlTTyCE/iQ=;
 b=SqvhHAjz5OCD4FOgWNaFo/9rfS5sisOkshJdx0k75wKPc8HEB4L7HFzU6QEC1OJaaXQh+S3F8cixKt6A6fnrcDpEbZYi1zgQM5IzN+OI1JCCD4/gWFZL7WgGh0n/oVP3BULfPg30uw3KCOyz/DR9+f9rfjIg0uvrqA0Tx8l7zTnNOLL9x/RQl4gAu8FmwNhthUaXc4vX2/xhZ4o9lD7Ou/eQsmhnh3NYjZOr6moZG4O3JWFEf0bGDWxTKFgT8z7IDXCu6xytJjI9PkXd4hSTGRUqeq2id0qwYnYkvVtdJBc4SSq0PDWd4NyPjHB+hWquVSZNqr31zQcKmBStAEjXuA==
Received: from MW4PR03CA0296.namprd03.prod.outlook.com (2603:10b6:303:b5::31)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 09:40:52 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:b5:cafe::24) by MW4PR03CA0296.outlook.office365.com
 (2603:10b6:303:b5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 09:40:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 09:40:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 13 Aug
 2026 02:40:31 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 13 Aug 2026 02:40:22 -0700
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
Subject: [PATCH v4 21/27] vfio/cxl: Describe the CXL device and decoder geometry to userspace
Date: Thu, 13 Aug 2026 15:06:25 +0530
Message-ID: <20260813093631.2288172-22-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 288d6048-6571-4997-ada4-08def91ef6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|56012099006|10067099003|6133799003|18002099003|22082099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	MRxJjrNi7QP/4w4X4Ktvyq3XnnZ8PhSNLXMBSVPB0UDq9zgKUfPLK6HcVw3JCeHssvnLL6edsn78z2jw9pzUbGkeSEiiJtdXFUQMEysUCimyMjlW8Z2ValtkVdmNFwoumnMhRdpv81pPacJ7pXDWIp4rSD7Og5lmI1fYohdgy8SBvkeq2Jzv2vRp8aD7Y//1xHJRLB/7eRIMgFmsj0ovC/6KCS/8DPuVxJ6m7ls7W6/EGP0sfJtDxrdMOuw7WM+nWs7GhN94dQQj/GlWf5Bx5wK2upQFiJt76EW6SnVGwFr3tSD4Lzrv0RK4AJp1M9VFR9DYWbnS9247T4L0DmwU/UP+GNHQ/PPw5zvlcU2lBLfkQeNfCAXXdlq51cZzLilWe2Ex/nl4cU7pjGbWbeTYcG6hSRf/ns5+atrfgL13mW5UnLWL8UmsWTyiuMT7jHaFUNTMXs2qJ/frnKpxt95qE29FAgrURmhsmrqn3TDplSkyYGujWxQR2QGEWsh51HWX0skXYtwbihHenkdSNUVU+C31tqNd3+qs8ktar2m6gfKJsxwCdWz6SQBqQdJ/oeIfAogmvePbgxZZHfrybcK71ec8SF4/yLc96OBQh1T92n20YqNSk1uW9G3v2a2hmCAI4Ez8/cyJD/9uTrwyPXAa57RccM7JgOJTVGZkZRKLm/cUBVqQYl4ZiMyrytpzMbVy9TNzs28ltSa/g3NQkJ2YdCeeXDZ9j12DgsMWME899bVfMpU7pJEpE+qYsg4Gh590
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iPu3nM4VuvfKCwdv9Q77a20fCThL1Xgqqyr1Zg0YjP/VTVhxwh3oQSfUK8N93XzkyTUSVKt5WX1OplvEk5dFqFjXOElFvxmEskrmKQJHKbGFjd9QcG+0wMiM6TOXnzZIWrYrzFzbwqG9//0gIyZ430c5xKTwTjna63aXQHxaOTqmdR9P4tecmf97kfjrqLDpwNU1YNako8DXvWMaa3LHe+bd7BcOCmvZMsj8u1O7urBhJlhUjouMk2r/kIdFzOMp5KlDAb4suWcEtJd1uIsLQPNSDZMmzKCx7EMTguBq22u7wsMFel2TwdwDN/N/VO309Wi7Sl0EdxNSA8v/w7gneG1AotxOpx1cpi3JvZs3A9B01em8KWgyhLRf1XIdpqfHESyRD860LKB4H6GQYPIBHoFSRVDvNc+u5coA+8kvLbyQG2TuremZbjO2ZWNK8Ny4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 09:40:51.4093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 288d6048-6571-4997-ada4-08def91ef6a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565

From: Manish Honap <mhonap@nvidia.com>

Advertise the assignment with a device-info flag so a VMM can tell a
CXL Type-2 device apart from a plain vfio-pci one. On the trapped
component region, add a capability carrying the BAR and offset of the
HDM decoder registers so the VMM can place the window where the guest
expects to find it.

Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/cxl/vfio_cxl_core.c | 16 ++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c     |  3 +++
 include/uapi/linux/vfio.h            | 18 ++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c b/drivers/vfio/pci/cxl/vfio_cxl_core.c
index ec938813bd91..0fb5ed5d86b7 100644
--- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
+++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
@@ -381,9 +381,25 @@ static ssize_t vfio_cxl_comp_rw(struct vfio_pci_core_device *vdev,
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
index 6f6ebcce86a1..77f8f39dd670 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1192,6 +1192,9 @@ static int vfio_pci_ioctl_get_info(struct vfio_pci_core_device *vdev,
 	if (vdev->reset_works)
 		info.flags |= VFIO_DEVICE_FLAGS_RESET;
 
+	if (vdev->cxl_ops)
+		info.flags |= VFIO_DEVICE_FLAGS_CXL;
+
 	info.num_regions = VFIO_PCI_NUM_REGIONS + vdev->num_regions;
 	info.num_irqs = VFIO_PCI_NUM_IRQS;
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index d5b8106625bf..df88535ede5f 100644
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
@@ -505,6 +506,23 @@ struct vfio_region_info_cap_nvlink2_lnkspd {
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
+	__u32 __resv;	/* reserved, must be zero; versioning anchor for flags */
+	__aligned_u64 offset;
+};
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
-- 
2.25.1

