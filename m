Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CC74E80CD;
	Wed, 16 Sep 2026 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583902; cv=fail; b=tEf9wxCflJop69AUEFZ1J9tqgcQHXB/EpTmN8zRJjXTRapdy7Dw1KZ47a7sRJ8ZgmpdANvWYnoGj8/gsCQSaIWTcX7z51tGw3iZch9kU2AV/XfjtckjarEaj1z42KtDe3lDLKT6sc5TbsxxXOWdTwHDbfQuusssCxYorezLEtew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583902; c=relaxed/simple;
	bh=xfnxcfbdqze5Qj+LItr2e+0NOBJkBb/KnBKVuSS0z4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUcDQgcauOvxjMu80/7C4HWwIcRKdNK8qGugrcZMBUVgYc08YIQHpFHpM6Ev06iTGY5jdkm/xZ3EPvZYr+6paAjKTgyjuR6QG9CGqnI4TYFWqQl2run6kS5SFtnF7QhNYkxak8hrrhR18yjHzSyRdGzB9T8SzY7TesHXQJs5pSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JJhDiKtl; arc=fail smtp.client-ip=52.101.62.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JJhDiKtl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbdgVFplkFTfdVVeV6mc57MEYNF1HiDJrFqFlshPuXTpHSjVj8GyhE7MhMdTxg77GwnxASvC7p8M/GUXUavUi94scoV1hqr03qbUzYcBUsXTGKAhVdpZVOPBiLyFF/gUJiekvca0fJOUCjyH9EWxojU1Ecdjvij2biSe9UMUhkOdOdZR4IKrADByrjoNEGg87Xjgj9LMlKB0X1h5G0tEx5d9pQOTQc5yV5y/URjwZPQXr7lH+POqWpD1Wd9B7xKSXvZZvzQBn7Mp+ZPXEp61vc96o6zWMmn2jbo32Nt5GTo60WYX480vzfQ7MQGUuj6B6WQkeqOJCBzDpM3HDzOu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IPAu+ltjRArBjHWylIhTJOkTrHP3SDaZq6BXEvSXuM=;
 b=XAAGHu4EVAfjPXmljepzcbi34CV0o3DGYAoHsCTqLayYpE2NF/w9CLGV6Dw/+uxLtR5eMXVBVqtpKVxqs95AMw2xX8m3H/ZxkonzVvoJdmqEL/NV0IUfBn3vG1RAQ7ds5cWH26U6Oqx4aSpLVJrlOIrBKG6r+ItijM73UpWpu5QKBeQ/jqXOJz2vmSN6ohjopgXGgUEXnrGCgc3hXxbjQ0v+dMQhbeiZQCuIgQ46fT2d0/qLAGRGKK0OCnA4fZ4d87xgpeLyDsvM374kTzH9Qb+m/JJgUb6FaUhP/5QWYhfd1YnYxMaw+RsgMFWs2qtxtIItTgAb7uLlxoh9BGPGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IPAu+ltjRArBjHWylIhTJOkTrHP3SDaZq6BXEvSXuM=;
 b=JJhDiKtlIMHBROyyYv5tzNNp4G+jTW96JfWpn5rEDAQvKaK3uQAC1otrvn9Erdml9oCQRCN8mHBcAhVQYrt/iypbkJyV701PEfPpnKjAGggOxrPPWeQuBpl6L4t+cBHqavFpRSDTl1xjj4FqnS+ckBpabjnT8pemadzPxXNhc9X2mo+IvYzW7iCvIfcgs3/TRDtYU4hAXOqPjbbpdu1B1ahAf8kHgr56oOXHp4opIeJRCf/ZsdclcOX5oFHTJKs/K/x2BNuLjiykeD2bPNIZr26LYCJS6I9ceS9u9MaMo1TykAEG9tVVxPAMAvTSmh66ov+q24Td5KvUjXChiMswkA==
Received: from BN9PR03CA0268.namprd03.prod.outlook.com (2603:10b6:408:ff::33)
 by BY5PR12MB4210.namprd12.prod.outlook.com (2603:10b6:a03:203::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 18:38:08 +0000
Received: from BN6PEPF00000071.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::1b) by BN9PR03CA0268.outlook.office365.com
 (2603:10b6:408:ff::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 18:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF00000071.mail.protection.outlook.com (10.167.248.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:38:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:37:39 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:37:30 -0700
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
Subject: [PATCH v5 10/27] vfio/pci: Migrate MSI-X exclusion onto the generic excluded-range list
Date: Thu, 17 Sep 2026 00:05:23 +0530
Message-ID: <20260916183540.3813685-11-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000071:EE_|BY5PR12MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d893291-f616-4a63-c819-08df1421a5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|18002099003|10067099003|22082099003|56012099006|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	jlKqmukcRe/iD4IQC8T7NkRcv+pq2SPd1KkMqYVavdBQdBQpxYUTuoeELEC/ss3mi5pEhBoZWD47kIR/MDMqWO1cURS/KqJIpKkAugEPQXS7Qp7T1ahwQo+pgFXBAd1Gck5rIBFzQoookdZ3R6CLhzhavStcU4KEaFRooiD6NtOqxbYIUzIyMjiBmCXD8I9BiMBgu9tY2yYjAb+odt+6AyW+rpKd0liyILc1Z1L32mIoYdApvNh1F5PJRvvwIgragiiGOVUlDTVsiYH0MPnrjXby0RKdNMbqjG2h5z28iS9mABsHL3AEza2M7KyCiOgUbtCA+6Kxy8AYM/if66RDf33qOztE41JbJJhxdaNSHjp9oKuvUeKxdo0rJSJcUwZxGpXEGq6FnASxltVpx1ja/qouRg0YZig+8OHIV6FbOWyPcVSSxBFijB6MFlJkUKvvmexF4qwHPPE2pcZsfO4R2w4hBnOgzhJ7kMw4bKfLKzKH6FG2HA6EsHLWLQ+Ae1bG7eqkQe2h4tdY3USWZtnYb2XE+swQ0glKXLdY3xVFk8wWj8XqOXPOVcAdyzWTW9F9vzMHdm7cnzUkDYUbS+/4D3rFMoTJTXd5ydQt4fH4OWQp+iJjquoTZsQCTA++dgkfya+aBCDrOh2szz+7U/6McJw1urxn4PkG8+Xp2lDHHIp3FZfaVGSGsxOfaJdB4R0xf6E5C6Od8+pEp7qb1dRTEBtvLGT7j8P0XozM7ONtiIXnTv5lbfTwIOCLm5wtFWeN
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fl5EwMo03OauPCtwUyj/+2oCNUCWCdVguA4gRMRD8UdSjC0+W5vNLXdT42MNLiJDoqjdSLOqEv3kypzJkDfUglLx2zvCtKy9Y2IRFYFqi/o1Q6qtfh05PQNKjFZ9P7jur/kzhRRbWrvHyeCqHDd0PtgzGNXDoajErHcYqF5YoDOb5WlnCHWo4YzTo2WTIw+XHfozIf0iRVMsHGVr/Fss8d4rB0bGFH8ITfP3XPs5gLPwMvekdddhdCQ0y2o5n38G/IpeRg3XZUkaNpvCzZ7yCrf8BKz6Saf3BvSO85UFDsOmF7PPSgS7FduNjm2JDM4fD2kn8CmF7l7YrSival5N4bmfOJtpjYXu4t+H5J86QWZSbaXMH6Zmwj8jFQZGw6Q+ol3XE4XrPiOZApvxu6WT13ivSb/M+20fj6Iz4HCptTQmbTHVmkZ5O0TABshdOIVd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:38:05.8101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d893291-f616-4a63-c819-08df1421a5e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000071.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4210

From: Manish Honap <mhonap@nvidia.com>

The MSI-X table is virtualized in vfio_pci_bar_rw() by an open-coded
x_start/x_end window that fills reads with -1 and drops writes. Now that
a generic excluded-range list expresses the same fill/drop behavior,
register the MSI-X table as a read and write excluded range instead of
special-casing it in the read/write path.

Add the range when the MSI-X capability is parsed in
vfio_pci_core_enable() and clear the list in vfio_pci_core_disable()
alongside the config teardown. The read/write path now relies solely on
vfio_pci_bar_find_exclusion(), so MSI-X and a provider's (e.g. vfio-cxl)
trapped registers share one mechanism.

No behavioral change: an access to the MSI-X table still reads -1 and
drops writes.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 19 +++++++++++
 drivers/vfio/pci/vfio_pci_rdwr.c | 56 ++++++++++++++++++++++++--------
 2 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 9e4fa5d088a4..c5b7a59a4548 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -589,6 +589,8 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 			   NULL)
 };
 
+static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev);
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -655,6 +657,22 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		vdev->msix_offset = table & PCI_MSIX_TABLE_OFFSET;
 		vdev->msix_size = ((flags & PCI_MSIX_FLAGS_QSIZE) + 1) * 16;
 		vdev->has_dyn_msix = pci_msix_can_alloc_dyn(pdev);
+
+		/*
+		 * Virtualize the MSI-X table through the excluded-range list:
+		 * reads fill -1 and writes are dropped so the guest never
+		 * reaches the hardware table directly.
+		 */
+		ret = vfio_pci_core_add_excluded_range(vdev, vdev->msix_bar,
+						       vdev->msix_offset,
+						       vdev->msix_size,
+						       VFIO_PCI_EXCLUDE_READ |
+						       VFIO_PCI_EXCLUDE_WRITE);
+		if (ret) {
+			vfio_pci_free_excluded_ranges(vdev);
+			vfio_config_free(vdev);
+			goto out_free_zdev;
+		}
 	} else {
 		vdev->msix_bar = 0xFF;
 		vdev->has_dyn_msix = false;
@@ -741,6 +759,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	vdev->region = NULL; /* don't krealloc a freed pointer */
 
 	vfio_config_free(vdev);
+	vfio_pci_free_excluded_ranges(vdev);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		bar = i + PCI_STD_RESOURCES;
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 48da1cb08296..f8e5f94a2e8a 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -256,21 +256,51 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		}
 	}
 
-	if (bar == vdev->msix_bar) {
-		x_start = vdev->msix_offset;
-		x_end = vdev->msix_offset + vdev->msix_size;
-	}
-
 	/*
-	 * A provider-excluded sub-range is filled with -1 on read and dropped on
-	 * write for the same reason: the guest reaches it only through the trap.
-	 * An access spans at most one exclusion window.
+	 * The MSI-X table and any provider-excluded sub-ranges (such as a CXL
+	 * HDM decoder block) are filled with -1 on read and dropped on write:
+	 * the guest reaches them only through the virtualized path, never the
+	 * hardware directly. A BAR can hold several such windows and a single
+	 * access may span more than one, so walk the access one window at a
+	 * time. The ROM BAR uses the single trailing window set above.
 	 */
-	vfio_pci_bar_find_exclusion(vdev, bar, pos, count, iswrite,
-				    &x_start, &x_end);
-
-	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
-				      count, x_start, x_end, iswrite, max_width);
+	if (bar == PCI_ROM_RESOURCE) {
+		done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM,
+					      io, buf, pos, count, x_start, x_end,
+					      iswrite, max_width);
+	} else {
+		done = 0;
+		while (count) {
+			size_t chunk;
+			ssize_t ret;
+
+			x_start = 0;
+			x_end = 0;
+			if (vfio_pci_bar_find_exclusion(vdev, bar, pos, count,
+							iswrite, &x_start,
+							&x_end))
+				chunk = min(count, (size_t)(x_end - pos));
+			else
+				chunk = count;
+
+			ret = vfio_pci_core_do_io_rw(vdev,
+						     res->flags & IORESOURCE_MEM,
+						     io, buf, pos, chunk,
+						     x_start, x_end, iswrite,
+						     max_width);
+			if (ret < 0) {
+				if (!done)
+					done = ret;
+				break;
+			}
+			done += ret;
+			pos += ret;
+			buf += ret;
+			count -= ret;
+			if ((size_t)ret < chunk)
+				break;
+		}
+	}
 
 	if (done >= 0)
 		*ppos += done;
-- 
2.25.1

