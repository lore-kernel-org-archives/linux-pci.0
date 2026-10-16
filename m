Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0009151DB17;
	Fri, 16 Oct 2026 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167669; cv=fail; b=Y91YI7ZS+QZCjUaj0MP01emB/OiyUU2EZlBFZ9J6vY9XoXKhwNXer4wVU+8BPcQrVfmJCSSq+oJ0j5pUwtn6kdTqwuTVq+clO7RFPMXyik8ez5frKlVkHwRgzhgFIyaIJLas7H3YuO/jaU7ciJYdIhS1Joc7ED/pdYxl+r7XJek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167669; c=relaxed/simple;
	bh=DtQIlg1tPihivo+c18jhfTX5FOvtdErGa/CIynfX2wA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQsX454qSktUnkYZm2yqj1IxwgdpEbQs4CSFwzyZxWtyzywTC6uc43UQWp9n/59jqkmqZLped9pjcoG8vOuPfyXddW+A78eWnaC1pqAT7xQ7BdklgqfxBUov9I2zjTIwBoNxlivdPyzt1hzwVZthV7RktQOJRnf/UYAI0WVe76E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3uACGlF; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3uACGlF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cunqn0TcBpE/TehZc00ogLHK3DESQeldPONgLACzhcWM3efeuczrBPxhYNFqC4mKhAlSY+3lYDKPq0XQ5gvUqPGaVIy/g1Pe1dYSNv8KHVwlAznj1TKIuM/GM28wRRmktKmuqHVK7lkzIUTB5apGIa6/Yl63Cw8o7XmohLWquOI1tE9WpjBhjQ8xDuIn8IUaeYnnD7mTutFRfbPdmRm7aP57MfZnYt9iprEK4T2+jN72OQFRnjKsJ5OY1TAuYpkmjdhgQjPXTJ6hQ1GPrqa1lFFG54GYBqJqJfdFxtmuZ8pbMuR0rxIq7hucXPIe6apGpg0ladUcVdH3iu9gZD1LGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pG27xWCxc1B1v6A+RIrhTRor3buf6Ft85T0xbFOLLE=;
 b=YIItpA+qOckmafBndP4Gh6/3u4mcTEWnmWn4YrwHq631BNeEJpqiZtmKMsZPCC3LDMEB9udGyDpytbzos0rHVSZiJt0+AmnSPHKgE5SKWAq+y/shPEJgSChb+trVaeXut7j0qGwUQY2FCArDPr8QFagQXvvbUoZMF7EYddQyKQeJGoFVJ2kihFvsbG27ednN/38kdNGXIWoG3jIbWs/R5CuvhF6+E3jwJZDvmI3xJQGtOqlKYz3XzoajTjMIpnl2WkdlYd6jtMHMiVYETY2EGNvxL3qVMUuxA6WTMiRZe9OjIxU7Y339S4Wt68GEMqYIXJRYhWdYWTfpCs2h623fAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pG27xWCxc1B1v6A+RIrhTRor3buf6Ft85T0xbFOLLE=;
 b=q3uACGlFq/jKvofRh46KQQBmdUHapcVL5E8z7r27o3om5HNjbkxMw/Z4oB4OjPQBarBRt9VvOxXfhnWwLTndwlX8MPyrGaiuCoL/Wn3JIeZI0WXXhvpu0nzkKe6oPCY9IPQApb0fsBT/4pZ7VLKRnJ3vK6yPbIVjgQnHMoQ4WjacnlyPYSSvnc4/RQJ+l8+sYHu+qrjPcpygSksFabRZ+85AYC/L2YYQMsDavo+7yK3lj/3o2UKmKBT80MX8DHhH1e8lLu9jvU9/0RqUlrIRJNskIdxyMBAmTgBUY1cVdZa1IZhtH9RHX6lYWF+zW6hhU6HRnPHd0vRvOUgxHDovug==
Received: from DM6PR08CA0066.namprd08.prod.outlook.com (2603:10b6:5:1e0::40)
 by DS6PR12MB745092.namprd12.prod.outlook.com (2603:10b6:8:52c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 16:20:58 +0000
Received: from CH01EPF000BE949.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::27) by DM6PR08CA0066.outlook.office365.com
 (2603:10b6:5:1e0::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:20:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE949.mail.protection.outlook.com (10.167.244.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:20:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:20:34 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:20:24 -0700
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
Subject: [PATCH v6 10/31] vfio/pci: Refuse ioeventfds and dma-buf exports over excluded ranges
Date: Fri, 16 Oct 2026 21:48:17 +0530
Message-ID: <20261016161839.2765592-11-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE949:EE_|DS6PR12MB745092:EE_
X-MS-Office365-Filtering-Correlation-Id: eed5c335-6a7a-4f67-a2d1-08df2ba1761a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|36860700016|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gBPD2/jdzRzAJ7mUU4fcpENMMNYv4/bKOYGaZuVuLN3QLHiw6kAI7oURuPMUCCkgro1Y7dCdsxANZFO3nFlKzFHhsJxlIOZRJw5BF//NmTh0yrs87fUV0hdKTYyO64jE7augmK6coBbb86AYkaiqNwoaYYJdTY4+y85Yx83aGJDkZx4ueWvY7tXuBpZNlKc+i/4PYk+fGdokzi34l7phYgGgY53MNPY7icqU4ykf8f8C7JB0Ezgh3e5pqd+BbK1Cx4BGI5jk55ocgLzX5y9oczhE10RFHml7fqmgO1ozQukY9jasB+y8h/K8bYuPfWr7uQEDWgCBG2xkzSseWm/+wDPzKGtgnmCme6qZh5mesw6SVnm0efd3shAra4slJW1JKrS8VKemTGFzJzgSO77GTVk2WqAamVIUlJH2G+w8IFwINlut+ygizbbX8Vxjc0pBqt37pfu7DWWhI94ejhOnm4G2aipNDGHqWrVGs5lOhWZhdogdknhl4RKyhU+DYEbUf3pr+p26PuH/C0JimebeWnrGnE0FRk8Pd6ICHEMKSY0acvmZzjbvUlV9F9TZNEC6PuxAR8RPEchqItG5+JunNjv32sdy3+QZuNLLp8+vvsOi5rqnvC0ql7LM+faKOvETHwb18QmVvMH6wddgNUgBxm6PyjLgAlsqtCdZWnnRd2POAgXV5RdESNKbUQSALnG77gjUGKHglB2G7fyv/Okr9xRcnFKv2CGGDaY4IaQ66qt2fr9FAdCK4HsLfluBv2pt
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NUcb3XIpEJ+hjcievAg4yWTVpWgvUATL6ZHZEbhf5izbQ1f4H6Frn1H9lLnGHrIuWznnAI+kg7nYVTlHzMcoKi/lDajvkq9ELmG+RxYqmftxnski2bfqk6+Mgni6/c+q4uaWa1srKPxJd5CMRtkw80vpUEQsslyw/23fSHY/U/n6c94ILvAi4I+VeXetW4RqqZ1fZahBOC3DcPRMq6oYi+CI8Uf2cVpy8X24fHMuzRTWOhWfvFfK9zjCu1joWdBVi+kXlWk7Ukej+NIoeig8StLH2lxl1SRz1EATYfssCUDkBbmwAKUZf2COHR+/5d2t51EV0L5JT5DRQt6uphf2nE1xSMnG5Enee85TAow+ykiFwyURKvaBpAH5vtSTG+9JvcCag0/ndtUo2RK9UCO4GWtOWveLlMri5j0zIGLZ05xwjkC4rSYNcNkDKLlqthFf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:20:57.9508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed5c335-6a7a-4f67-a2d1-08df2ba1761a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE949.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB745092

From: Manish Honap <mhonap@nvidia.com>

vfio_pci_bar_rw() keeps the excluded ranges of a BAR off the device, but
two other paths reach BAR MMIO without it.

An ioeventfd writes the BAR directly when it fires, through
vfio_pci_core_iowriteN(). Refuse an ioeventfd whose range overlaps a
write-excluded range, as one over the MSI-X table is already refused.

A dma-buf export of a BAR range lets an importer map it for DMA, which
reaches a range that the BAR keeps off mmap. Refuse an export whose
ranges overlap an mmap-excluded range, so the dma-buf follows the same
rule as mmap.

Suggested-by: Alex Williamson <alex@shazbot.org>
Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c   |  4 ++--
 drivers/vfio/pci/vfio_pci_dmabuf.c | 14 ++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h   |  3 +++
 drivers/vfio/pci/vfio_pci_rdwr.c   |  9 +++++++++
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f099a294af34..211fff6045e2 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -1107,8 +1107,8 @@ static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev)
 }
 
 /* True when [start, start + len) on @bar overlaps a range with any of @flags. */
-static bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev,
-					int bar, u64 start, u64 len, u32 flags)
+bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev, int bar,
+				 u64 start, u64 len, u32 flags)
 {
 	struct vfio_pci_excluded_range *range;
 
diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index c16f460c01d6..8606c15ab2fe 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -260,6 +260,20 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
 	if (ret)
 		goto err_free_ranges;
 
+	/*
+	 * A DMA mapping built from the dma-buf would reach a range that the
+	 * BAR keeps off mmap, so refuse such a range here as mmap does.
+	 */
+	for (u32 i = 0; i < get_dma_buf.nr_ranges; i++) {
+		if (vfio_pci_bar_range_excluded(vdev, get_dma_buf.region_index,
+						dma_ranges[i].offset,
+						dma_ranges[i].length,
+						VFIO_PCI_EXCLUDE_MMAP)) {
+			ret = -EINVAL;
+			goto err_free_ranges;
+		}
+	}
+
 	priv = kzalloc_obj(*priv);
 	if (!priv) {
 		ret = -ENOMEM;
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 53544e0cbedf..09a68c99b43c 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -52,6 +52,9 @@ struct vfio_pci_excluded_range {
 	u32			flags;
 };
 
+bool vfio_pci_bar_range_excluded(struct vfio_pci_core_device *vdev, int bar,
+				 u64 start, u64 len, u32 flags);
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 93823c6391f6..ef098f0b1401 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -476,6 +476,15 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	      pos >= vdev->msix_offset + vdev->msix_size))
 		return -EINVAL;
 
+	/*
+	 * The ioeventfd fire path writes the BAR directly, without the
+	 * excluded-range filter of vfio_pci_bar_rw(), so refuse a write-excluded
+	 * range here.
+	 */
+	if (vfio_pci_bar_range_excluded(vdev, bar, pos, count,
+					VFIO_PCI_EXCLUDE_WRITE))
+		return -EINVAL;
+
 	if (count == 8)
 		return -EINVAL;
 
-- 
2.53.0

