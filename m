Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354A59E35D;
	Wed, 16 Sep 2026 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583893; cv=fail; b=QxDWeVjG5h7fUMzXi7beWJ0z4MphlRzFAOj0rgtyXZjIYyTAyyZ8Re1HkONkGon9wUfqWcBkxpHfHM0m8ze6BuGkaDiHo1OU4mIxxILy/cqklDXoygRYDo1RreURbQC6BuFTMIEcuFOFNb/4doX0hqO0NZzVd+n8RT296Zezu0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583893; c=relaxed/simple;
	bh=MVrbbMrxgRax/jsHVKL8xlnVjXpN29sZRitzVEJ0ciQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJhVW4tg04AKSXvpAXKBqns9zQawlyEdt6PKF8NHZ1Gmcy/HbKt7SSep/5WU5lZDqJFOoOlNVuP8xznTrVGY5K/c7wQ7jnAWBV6V9eJ0RvhMFvcIHMl8WuuMKj6xPeHYDV35nyoQKiwJuP5qW2YexRp+kci+jeOB9jb7JFClBXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BJfsfWtO; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BJfsfWtO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3CK6VR9tIYYjtgEazb28zZOkS8BZQPL0HgVnbWiRw0VhsMWh9xqmccykCtuS41va1QVvh5EuEGfRcH0W288Vzx8np0cxuHic+vVgZ6zq1a/xGbXL0IiWDNmcLwtbUvk2oFz6rD6MnzY09/4FxHp/wUgYnOzad+qM9vVNWXiunSGDc8/6MAEzMMuqdRRTHxePtV6Hbfut0Hiyi4FuLCVyxSIL0mt0qHwgcpe2QF5KbeYak29xvF9mZci34oBJMHc5BH3xYdvqZlxkvhdL7uBuChEsimW+1niPgmV8cGAryRiX8/uRHuO4WjkBqKcpniltimIKZxzP9pba1aeAbHg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntQlDhbglJ5x6xgyiQ9N+A3BcmIys3LyF3tj+WYjf9M=;
 b=eLARJxoaOJsaARDoQPhxpKY79hcjpaCYtzQ5okWcx2CR/Rgcwb6cxX3NX+YFYaJBRpvODvk9eyfyCEihP6pXkhytxUaVuFfrnxRDbZSWYv0CWqfh7/vX6X6Z9ickWcxNS4zrbX6ET1jgz3DSoU0UdzmnCgNmDtjztHJQpR0yjOMyqa5EdQRRrAj6rL7MKYuprt/KIO0ImURmiSi7Oi1IPosXNXig4xsek8dvHEyNd6l/1Dq/9T4R8uFdxtkie8pI+1hsXkmw7FQP/XI5U5T4TBeddJrn5TwWrrFAz8P1ExYImHZLkd6/Uz+nmlUlh15n3z8vQAk38Y3IFLuY3q8myQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntQlDhbglJ5x6xgyiQ9N+A3BcmIys3LyF3tj+WYjf9M=;
 b=BJfsfWtONVqkisEiQAidr4dKVxsuDLryef2b9FX4d05WxiOJZX5RmiZO6ZsJMKjZERaZNZ3a24pGioqmHtWwpTGVZnxMSAGDmpPFJ6tAnoH33s4xwnN5QmqNmZg4G+vGKRYfjVPIoZAzJqC/T9tZyqGJoQfx9A7KotH+nl9g+6yTwNY3HAHSyx8n7n08No6MNFOMYK256XIjUs+eGiskH9PrBbAJ8vB++pjGXA1SOZGE5gEvkj1kjX1mcmsDEIT8cXb+xoGjyi+Ednm3BX9K/qqvcVzJf4i9TA0r3Bc/0fbP+Jxyka6VZCBrAs6zv7cSNkJgCjyIK+Ko3UpV8edYeQ==
Received: from BN9PR03CA0249.namprd03.prod.outlook.com (2603:10b6:408:ff::14)
 by SJ0PR12MB6757.namprd12.prod.outlook.com (2603:10b6:a03:449::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 18:37:58 +0000
Received: from BN6PEPF00000071.namprd03.prod.outlook.com
 (2603:10b6:408:ff:cafe::79) by BN9PR03CA0249.outlook.office365.com
 (2603:10b6:408:ff::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Wed,
 16 Sep 2026 18:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN6PEPF00000071.mail.protection.outlook.com (10.167.248.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 18:37:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 11:37:30 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail202.nvidia.com (10.129.68.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 11:37:21 -0700
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
Subject: [PATCH v5 09/27] vfio/pci: Add a generic excluded-range list
Date: Thu, 17 Sep 2026 00:05:22 +0530
Message-ID: <20260916183540.3813685-10-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000071:EE_|SJ0PR12MB6757:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f15f1f9-1a5b-4a8a-7846-08df1421a122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|1800799024|23010399003|82310400026|921020|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4+hImKiuuvwl+vpS4eY4gd70IsoCMe8omjQkqrv6KnrMhoc+dp4JgAfLamgRB+Y5xIbato0qSLuB4z6ZnUTwOeqnPpXwmyDWr2pkSUmfeWHnYXTjq32WJ3alGh7Rvi+R/3IJgEcP7ZxjyvPUIvJ5kFzCKryklHLFBYsk5OVYjAw2ahbC+7awB+koJv2JUdu/16mjk+uUcdSoiWTgB7HfEHVgkia+lgFjRa2bqQo/HaR2yZ2AHvXAwPK/f53UnPGPsq92RytouSEUyfvQ5sBwwz2PL5GweMDUAgp9BTn2pZZBVS4vcElsJpHARY2Sk+VIL228GNT6eeJgQT1r2GMnbVy4vSzGXzwYuOiWzNtKwXjFYFjclUtDbFAIFZg9gfYDGXrrY7P/NZwT6aTj78F95wysHiLnxMyYsBrKxhiPEDIkUHd3YEa9YFkvYckGosnnRPI7u5jhSlqm77HHMK49+H5D+oudz6SmvE4KhROw7SZU0+gpV1lCVbD56/3mZK2AL5+ZGfeWScoITvfgzKNOZE5D+wrrgR2A+i+acRCE3pBClyDWUtVMzin9DGs+HuDdfTr75RoE0dSC9OcUVkjYofM9/STGwbXoj7jTwxYhCuit4UbtLe3a3qOfemzMB/vCOq4FRnfPwZUmXVNsvJFTSNIDvuRhg/886xmlYAVj4qa5Ek+aEk8azex+PzXxBnvkm+RNPvHV61sOyrR2TENcdqg4l5ErOo2TnTd58rMnolBdVT/+9wXm90LfUaUP5j65
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(921020)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NRs5rEbn3elOaPVpB8a+aasrIUw+r9TOtATXHb3eu8xnpWJ8jhjOdWMPA1cqgY9t7MtXxbN7QLwG8CXoPkiXZlypZdJcYVdQPWY2Fu6jClzhZOOi1A0ck5+mFfWbfsEdtUvaI+HiYKeCoGd1rQ1wKtqsz1SdJua0p2MUwqduljdq4ZhLbJ27+P8KsosVtHJoYr3iagqVoTHNlblVaO/5gYaPNjpP8YrrJ9px6W2V90z8AfQgXrZSPFU+EitHMQOfF3rhTm7qQ1GUyY10bzq9bcZbSxJgtC7FbKXLvIlwoI8FgJjN+atG1zFzCqPtpMoWgwtcqXvKSnHCqsTZvbrW3vgH7cou9hOBbG/9EAwQklVrSACQx5ZUSgvQPb3j9PyB7d0lhwVc2LT4GMyWhhxs8PhNW5IyC4Pmogam2daIps908qAa0nFkkZIsjue1pWE6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 18:37:57.7859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f15f1f9-1a5b-4a8a-7846-08df1421a122
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000071.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6757

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

No functional change.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 209 +++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h |   9 ++
 drivers/vfio/pci/vfio_pci_rdwr.c |   8 ++
 include/linux/vfio_pci_core.h    |  14 +++
 4 files changed, 240 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 9a75c30b67e2..9e4fa5d088a4 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/sort.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/vgaarb.h>
@@ -1012,6 +1013,204 @@ static int msix_mmappable_cap(struct vfio_pci_core_device *vdev,
 	return vfio_info_add_capability(caps, &header, sizeof(header));
 }
 
+struct vfio_pci_excluded_range {
+	struct list_head	entry;
+	int			bar;
+	u64			start;
+	u64			size;
+	u32			flags;
+};
+
+int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev, int bar,
+				     u64 start, u64 size, u32 flags)
+{
+	struct vfio_pci_excluded_range *range;
+
+	range = kzalloc_obj(*range);
+	if (!range)
+		return -ENOMEM;
+
+	range->bar = bar;
+	range->start = start;
+	range->size = size;
+	range->flags = flags;
+	list_add_tail(&range->entry, &vdev->excluded_ranges);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_add_excluded_range);
+
+static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_excluded_range *range, *tmp;
+
+	list_for_each_entry_safe(range, tmp, &vdev->excluded_ranges, entry) {
+		list_del(&range->entry);
+		kfree(range);
+	}
+}
+
+bool vfio_pci_bar_find_exclusion(struct vfio_pci_core_device *vdev, int bar,
+				 loff_t pos, size_t count, bool iswrite,
+				 size_t *x_start, size_t *x_end)
+{
+	u32 want = iswrite ? VFIO_PCI_EXCLUDE_WRITE : VFIO_PCI_EXCLUDE_READ;
+	struct vfio_pci_excluded_range *range;
+	bool found = false;
+
+	list_for_each_entry(range, &vdev->excluded_ranges, entry) {
+		if (range->bar != bar || !(range->flags & want))
+			continue;
+		if (pos < range->start + range->size &&
+		    pos + count > range->start) {
+			/*
+			 * A BAR can carry more than one excluded window (e.g.
+			 * the MSI-X table and a CXL HDM decoder block). Return
+			 * the overlapping window with the lowest start so the
+			 * caller can walk them in order.
+			 */
+			if (!found || range->start < *x_start) {
+				*x_start = range->start;
+				*x_end = range->start + range->size;
+				found = true;
+			}
+		}
+	}
+
+	return found;
+}
+
+/* True when [start, start + len) on @bar overlaps an mmap-excluded range. */
+static bool vfio_pci_bar_mmap_excluded(struct vfio_pci_core_device *vdev,
+				       int bar, u64 start, u64 len)
+{
+	struct vfio_pci_excluded_range *range;
+
+	list_for_each_entry(range, &vdev->excluded_ranges, entry) {
+		if (range->bar != bar ||
+		    !(range->flags & VFIO_PCI_EXCLUDE_MMAP))
+			continue;
+		if (start < range->start + range->size &&
+		    start + len > range->start)
+			return true;
+	}
+
+	return false;
+}
+
+/* A page-aligned mmap hole, derived from an mmap-excluded range. */
+struct vfio_pci_mmap_hole {
+	u64 start;
+	u64 end;
+};
+
+static int vfio_pci_mmap_hole_cmp(const void *a, const void *b)
+{
+	const struct vfio_pci_mmap_hole *x = a, *y = b;
+
+	if (x->start < y->start)
+		return -1;
+	return x->start > y->start;
+}
+
+/*
+ * Advertise the BAR as mmappable minus every page-aligned mmap-excluded hole.
+ * A BAR can carry several holes at unrelated offsets (for example an MSI-X
+ * table and one or more trapped CXL component sub-blocks, which the CXL spec
+ * locates by pointer, not at fixed offsets).
+ * Collect the holes, page-align and sort them, coalesce any that overlap or
+ * touch, and advertise the gaps.
+ */
+static int vfio_pci_excluded_sparse_cap(struct vfio_pci_core_device *vdev,
+					int index, struct vfio_info_cap *caps)
+{
+	u64 bar_len = pci_resource_len(vdev->pdev, index);
+	struct vfio_region_info_cap_sparse_mmap *sparse;
+	struct vfio_pci_excluded_range *range;
+	struct vfio_pci_mmap_hole *holes;
+	int nr_holes = 0, nr_areas = 0, i, j;
+	size_t size;
+	u64 pos;
+	int ret;
+
+	list_for_each_entry(range, &vdev->excluded_ranges, entry)
+		if (range->bar == index &&
+		    (range->flags & VFIO_PCI_EXCLUDE_MMAP))
+			nr_holes++;
+
+	if (!nr_holes)
+		return 0;
+
+	holes = kmalloc_array(nr_holes, sizeof(*holes), GFP_KERNEL);
+	if (!holes)
+		return -ENOMEM;
+
+	/*
+	 * mmap is page granular, so each hole rounds out to the page boundaries
+	 * enclosing its excluded sub-range. The byte-granular exclusion still
+	 * governs the fault and read/write paths; only the advertised mmap areas
+	 * round to whole pages.
+	 */
+	i = 0;
+	list_for_each_entry(range, &vdev->excluded_ranges, entry) {
+		if (range->bar != index ||
+		    !(range->flags & VFIO_PCI_EXCLUDE_MMAP))
+			continue;
+		holes[i].start = ALIGN_DOWN(range->start, PAGE_SIZE);
+		holes[i].end = ALIGN(range->start + range->size, PAGE_SIZE);
+		i++;
+	}
+
+	sort(holes, nr_holes, sizeof(*holes), vfio_pci_mmap_hole_cmp, NULL);
+
+	/* Coalesce holes that overlap or touch after page alignment. */
+	for (i = 0, j = 0; i < nr_holes; i++) {
+		if (j && holes[i].start <= holes[j - 1].end)
+			holes[j - 1].end = max(holes[j - 1].end, holes[i].end);
+		else
+			holes[j++] = holes[i];
+	}
+	nr_holes = j;
+
+	/* One mmappable area per gap: before, between, and after the holes. */
+	for (i = 0, pos = 0; i < nr_holes; i++) {
+		if (holes[i].start > pos)
+			nr_areas++;
+		pos = holes[i].end;
+	}
+	if (pos < bar_len)
+		nr_areas++;
+
+	size = struct_size(sparse, areas, nr_areas);
+	sparse = kzalloc(size, GFP_KERNEL);
+	if (!sparse) {
+		kfree(holes);
+		return -ENOMEM;
+	}
+
+	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
+	sparse->header.version = 1;
+	sparse->nr_areas = nr_areas;
+
+	for (i = 0, j = 0, pos = 0; i < nr_holes; i++) {
+		if (holes[i].start > pos) {
+			sparse->areas[j].offset = pos;
+			sparse->areas[j].size = holes[i].start - pos;
+			j++;
+		}
+		pos = holes[i].end;
+	}
+	if (pos < bar_len) {
+		sparse->areas[j].offset = pos;
+		sparse->areas[j].size = bar_len - pos;
+	}
+
+	kfree(holes);
+	ret = vfio_info_add_capability(caps, &sparse->header, size);
+	kfree(sparse);
+	return ret;
+}
+
 int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
@@ -1160,6 +1359,10 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
 				if (ret)
 					return ret;
 			}
+			ret = vfio_pci_excluded_sparse_cap(vdev, info->index,
+							   caps);
+			if (ret)
+				return ret;
 		}
 
 		break;
@@ -1853,6 +2056,10 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
 	if (req_start + req_len > phys_len)
 		return -EINVAL;
 
+	/* An excluded sub-range is reachable only through its trap, not mmap. */
+	if (vfio_pci_bar_mmap_excluded(vdev, index, req_start, req_len))
+		return -EINVAL;
+
 	/*
 	 * Ensure the BAR resource region is reserved for use.
 	 */
@@ -2317,6 +2524,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	INIT_LIST_HEAD(&vdev->dmabufs);
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
+	INIT_LIST_HEAD(&vdev->excluded_ranges);
 
 	ret = vfio_pci_core_cxl_init(vdev);
 	if (ret)
@@ -2332,6 +2540,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 
 	vfio_pci_core_cxl_release(vdev);
+	vfio_pci_free_excluded_ranges(vdev);
 
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..c268c99aea82 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -44,6 +44,15 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
+/*
+ * If a read (or write) to [pos, pos + count) on @bar overlaps an excluded
+ * range, report the byte window do_io_rw() should fill with -1 (or drop) and
+ * return true. A single access spans at most one such window.
+ */
+bool vfio_pci_bar_find_exclusion(struct vfio_pci_core_device *vdev, int bar,
+				 loff_t pos, size_t count, bool iswrite,
+				 size_t *x_start, size_t *x_end);
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd46de17..48da1cb08296 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -261,6 +261,14 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		x_end = vdev->msix_offset + vdev->msix_size;
 	}
 
+	/*
+	 * A provider-excluded sub-range is filled with -1 on read and dropped on
+	 * write for the same reason: the guest reaches it only through the trap.
+	 * An access spans at most one exclusion window.
+	 */
+	vfio_pci_bar_find_exclusion(vdev, bar, pos, count, iswrite,
+				    &x_start, &x_end);
+
 	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
 				      count, x_start, x_end, iswrite, max_width);
 
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 7f3a2bcb5830..92e3db116068 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -162,6 +162,7 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	struct list_head	excluded_ranges;
 };
 
 enum vfio_pci_io_width {
@@ -172,6 +173,19 @@ enum vfio_pci_io_width {
 };
 
 /* Will be exported for vfio pci drivers usage */
+/*
+ * A provider can keep a BAR sub-range off the direct guest path, reached only
+ * through its own trap. The flags select which paths are excluded: mmap, and
+ * region read and write (an excluded read fills -1, an excluded write is
+ * dropped).
+ */
+#define VFIO_PCI_EXCLUDE_MMAP	BIT(0)
+#define VFIO_PCI_EXCLUDE_READ	BIT(1)
+#define VFIO_PCI_EXCLUDE_WRITE	BIT(2)
+
+int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev, int bar,
+				     u64 start, u64 size, u32 flags);
+
 int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
-- 
2.25.1

