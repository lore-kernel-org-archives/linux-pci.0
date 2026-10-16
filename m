Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010002.outbound.protection.outlook.com [40.93.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794CD51AFD6;
	Fri, 16 Oct 2026 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167654; cv=fail; b=Qh+fxDjw9ETpXG+p0ig84CH2znYoxaKG1VdeoggnXdpBdfv2yIzU3SMBL8tfGpIN+S6my27mh8EjFpWhY82EF8EUSM82ofXTbWM6yx/CEETpJy08lFHOhHBF6bqJbN2V1j+aLkeWP1jecdw8LHPiCXxWr1uHJJjBYq4H603150o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167654; c=relaxed/simple;
	bh=hFMykWzszy3u7WcKWOys8rQ+HhTv8beh81bFYkNC8O4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HETTx/lFw6xgNIMVGAFIEM4GT4yrpiXPi3JqYYGMPCLStXWlywHe5hg8gaSq17RBWga/R61exvPnyLYWdJBEx60t2yLiSthBNGCrW303ap/u/6+9Eq0najkNUxpQu0VQzzBcW2XFl1aWslNey3VqnZgHHRdMx5Bck6PwrzvJ1jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E1Fwy2z2; arc=fail smtp.client-ip=40.93.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E1Fwy2z2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uW2dwslu4SOd2kkISZOA6HRXeXZQ77btGnq0JNzn6zqSrFKhr2Y91tN7+XnqdJwk/mB8tj9gR1ASAPV/vbigrUlu2nVHLtI93cqha7wcKZrGv1UA5oQPCmUrMQvbDURB9DqMJlXZh+WlWaBgZzCaS7c61zFms5LAo4o9ARUTv6dhR/M5MMTRw9PLxz0p1qi7PWyvDCgGykZVDxfEkTpd7MyLA9hgTlM/T1KxOqzOMsYpQV0IN9taK2FgXDXvTAwrMtzCvoFVdMgNkijNuHNqmUybrsmG6eCwer+KuE8l0MqUd1WYxSY6y+krbiboeOvs0MnVn+QvrBjXv+tqVGON3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVT9aWpk2LOeeY08VsQrXyDIIQ0NM3t3nw14oApz3ww=;
 b=HjsXUYagvNhJshFGNt6NvFr+wogD2W/O1tvsExIQgcEg679Sn+ZtSFX70xlAGdUyG78OP3M+zhZB+qaclsEvkGeSiYLzZGUF+ZnxF2aQz/Yisyp0BOPL+t2M99+UUyXE5H3KzlmqflJWKI9krsAmTDdhK5IUmRSY+R2S1HcVx3en0tuaJ1xcdlUV2fb8pvtfL5KyKPL8mPXaT8HDk+BiKmsnaCh4TryIug6BuHYYwp6Ygc7ARNn9ePUg4z18jwuwbvApDhvfAKioKx29ZzocKiMvdO7OCRNLjdQbRwRCZM3AGp89SBd1OFh9QJHTkLwUbiZ+nrNcQY1JZSh3kp4/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVT9aWpk2LOeeY08VsQrXyDIIQ0NM3t3nw14oApz3ww=;
 b=E1Fwy2z2odrBPiqrOKlmxUsaxiRVHS6D7IBSOyJOtMXaNM0C6legNKP+A23RDhxnCTv50Xi8+nOMCQxh3nZQ6wkUhU7h743dYjHAxfug5iEsHciapi5V9G+pG7rVyeGFk1OmuoMOob6HoEDPGb1unQeylRmqltL5N99iGB8XRuSyqqFtAyf0CG4sYeLm1F/QQtWVC++Lflc9w+/vHg+yE2ZTGehwwVe+w+jLo9I9vszekS1oyWnt3V4FWOShNjMGom5K8Idg8EH0J6/+j2QVnhaLxnti11jChnwV5fbYpiBMubxtmR9GofSjEiDZhHMs9p/zbDSFzivvdft2uynj1g==
Received: from CH0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:610:75::27)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::994) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:20:45 +0000
Received: from CH01EPF000BE94C.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::43) by CH0PR04CA0112.outlook.office365.com
 (2603:10b6:610:75::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:20:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH01EPF000BE94C.mail.protection.outlook.com (10.167.244.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:20:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 09:20:16 -0700
Received: from nvidia-4028GR-scsim.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 09:20:07 -0700
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
Subject: [PATCH v6 08/31] vfio/pci: Add a generic excluded-range list
Date: Fri, 16 Oct 2026 21:48:15 +0530
Message-ID: <20261016161839.2765592-9-mhonap@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH01EPF000BE94C:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f31a22d-6797-4518-9367-08df2ba16c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|7416014|22082099003|10067099003|18002099003|11063799006|261009223027099003|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	jX5tLRUQleXkLsZEEvvhLmETEqzgpHDUVw0aUMTc+6nTnJhFimLQ4Sqoj7rmdqonhoH4eN5Bs7J5PeQ3sE/PwBETj7GTpryb/EVtWTGKmNj5EhdGzydipw5sd/AvPSH1O3zLUmV5HZsBnCd71ih+9Y1qsM28kAjdEYZBcClnzcZlzQSzBQvynsNG3HlDFnjp3Mb6whBemYeNeGrilB0LLU2VvC6h+m76/7T2nIWELMLW8gxZgZinGVbYvPhiHfTG+czy+vxo4u/YTm5aowInAnDAv+GUOldc1A8xgneVRz0Og10q8S+jd+TkIpNQbmnv+etOWnohcqf32oLEUY61eSfuOJvcANKzV6vSGskZzrpILMeu7RzNfLbylDusGT3qCO3UCt1SLPMqEin2741oRbe/EYVjgynK5kJ3Ly5Halw23u/gm24MhNwcVDivQLHtrHWXBLiuROy5qsMOpOV8Y7wdbTaiiVxcwdGqwsHUNQAjLYcyfO2VhTt/7pErePYbSnW2oFO5iklqRRi77bYTN04BnKfgbYfiTydgU9TZMf3NhIVsDSoKLA541ZTXx1IkNbZ57h5S/4KxOlnS2H1UzWuMy47QJqeFstkjsb7u20H7+1IlsDTkWieURw+4ZFHqsp/77hLy7RVyv8JGDEGlX8wLMl84DmyispQFUrs8SN6dmPDGxgjLfIJj/vQ/Z5sAXKj5Z1lhr3Qqp2kQS5EElKuucmiyW7EPqaj+wr3XEoOy8gKg9iFRVyVKiO/6tXST
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(7416014)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZGWCV3/Fn1qO/HshpMpZ4+iM3TBeHvUZPSSBgFMhqzBs44y/xum2kWorNn+73SaQEbvqfrDutxct/bMNsuHKv1rQkhrAPUVsLcmSgzMnMWWRrbEVqFOZV7anYtC1LAz3f3rwxdA2LK1n9vm06NtiB7F9+XDzgVXhzhlXytr11f4UQxrzDWiY3F19Yque3NM2nc3TfMKaAQN8WamhVVxtobrfFTT2VfLMEY8YK6EAGhW34vyRuAGsW8wJDcWYkKVvDR+Xse+IrdvWMzNxjVB99TYdO9b9kckjaUSqan+i4MQNOwDVrqaSufbRoq7TjgG4V7MFiwoOYDz/C5xFmIDniMRyW6JzXHATdgrYG1gzsHPqAne9sF0kO4qajM2Xw3oWVMn8o0+mdVEnWsLFSBKbUAaskX6ZVWqp7enZvLnfunPSAr7EN+rqKlI8T589X2DD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:20:41.9382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f31a22d-6797-4518-9367-08df2ba16c8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH01EPF000BE94C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D

From: Manish Honap <mhonap@nvidia.com>

A provider such as vfio-cxl needs to keep sub-ranges of a BAR off the
direct guest path and serve them through its own trap. vfio-pci-core
already has one such window, the MSI-X table, open-coded in
vfio_pci_bar_rw().

Add vfio_pci_core_add_excluded_range(). Each BAR has its own list,
sorted by start, and an insert that overlaps a range on the same BAR or
ends past the BAR fails with -EINVAL. Ranges are added only while the
device is being opened and are freed in vfio_pci_core_disable(), so
readers on an open device take no lock.

The MSI-X table is virtualized in vfio_pci_bar_rw() by an open-coded
x_start/x_end window that fills reads with -1 and drops writes. Register
the MSI-X table as a read and write excluded range when the MSI-X
capability is parsed in vfio_pci_core_enable(), and walk the BAR's
ranges in order in vfio_pci_bar_rw(), so an access that spans several
ranges is handled in one pass. Only the part of the table inside its BAR
is registered, so a device whose MSI-X capability points outside the BAR
still opens, as before. The ROM BAR keeps its trailing -1 window,
outside the list.

No behavioral change for an MSI-X table in a standard BAR: an access to
it still reads -1 and drops writes.

Assisted-by: LLM
Signed-off-by: Manish Honap <mhonap@nvidia.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 97 ++++++++++++++++++++++++++++++++
 drivers/vfio/pci/vfio_pci_priv.h |  8 +++
 drivers/vfio/pci/vfio_pci_rdwr.c | 67 +++++++++++++++++++---
 include/linux/vfio_pci_core.h    | 20 +++++++
 4 files changed, 185 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index e50b36751d9a..bee3d1b4d8d2 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -588,6 +588,8 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
 			   NULL)
 };
 
+static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev);
+
 int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 {
 	struct pci_dev *pdev = vdev->pdev;
@@ -644,6 +646,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 
 	msix_pos = pdev->msix_cap;
 	if (msix_pos) {
+		u64 bar_len = 0;
 		u16 flags;
 		u32 table;
 
@@ -654,6 +657,30 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
 		vdev->msix_offset = table & PCI_MSIX_TABLE_OFFSET;
 		vdev->msix_size = ((flags & PCI_MSIX_FLAGS_QSIZE) + 1) * 16;
 		vdev->has_dyn_msix = pci_msix_can_alloc_dyn(pdev);
+
+		/*
+		 * Virtualize the MSI-X table through the excluded-range list:
+		 * reads fill -1 and writes are dropped so the guest never
+		 * reaches the hardware table directly. BAR access never goes
+		 * past the BAR, so only the part of the table inside the BAR
+		 * needs a range; a table placed outside its BAR needs none.
+		 */
+		if (vdev->msix_bar < PCI_STD_NUM_BARS)
+			bar_len = pci_resource_len(pdev, vdev->msix_bar);
+		if (vdev->msix_offset < bar_len) {
+			u64 len = min_t(u64, vdev->msix_size,
+					bar_len - vdev->msix_offset);
+
+			ret = vfio_pci_core_add_excluded_range(vdev, vdev->msix_bar,
+							       vdev->msix_offset, len,
+							       VFIO_PCI_EXCLUDE_READ |
+							       VFIO_PCI_EXCLUDE_WRITE);
+			if (ret) {
+				vfio_pci_free_excluded_ranges(vdev);
+				vfio_config_free(vdev);
+				goto out_free_zdev;
+			}
+		}
 	} else {
 		vdev->msix_bar = 0xFF;
 		vdev->has_dyn_msix = false;
@@ -740,6 +767,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
 	vdev->region = NULL; /* don't krealloc a freed pointer */
 
 	vfio_config_free(vdev);
+	vfio_pci_free_excluded_ranges(vdev);
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		bar = i + PCI_STD_RESOURCES;
@@ -1012,6 +1040,72 @@ static int msix_mmappable_cap(struct vfio_pci_core_device *vdev,
 	return vfio_info_add_capability(caps, &header, sizeof(header));
 }
 
+/**
+ * vfio_pci_core_add_excluded_range() - keep a BAR sub-range off direct access
+ * @vdev: vfio PCI device being opened
+ * @bar: BAR index, below PCI_STD_NUM_BARS
+ * @start: offset of the range in @bar
+ * @size: length of the range in bytes
+ * @flags: VFIO_PCI_EXCLUDE_* paths the range is excluded from
+ *
+ * Call only while the device is being opened, from vfio_pci_core_enable() or
+ * a provider's open hook; vfio_pci_core_disable() frees the ranges. Ranges on
+ * one BAR must not overlap and must lie inside the BAR.
+ *
+ * Return: 0 on success, -EINVAL for an invalid or overlapping range or one
+ * that ends past the BAR, or -ENOMEM.
+ */
+int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev, int bar,
+				     u64 start, u64 size, u32 flags)
+{
+	const u32 valid = VFIO_PCI_EXCLUDE_MMAP | VFIO_PCI_EXCLUDE_READ |
+			  VFIO_PCI_EXCLUDE_WRITE;
+	struct vfio_pci_excluded_range *range, *pos;
+	struct list_head *head;
+
+	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size ||
+	    start + size < start || !flags || (flags & ~valid))
+		return -EINVAL;
+	if (start + size > pci_resource_len(vdev->pdev, bar))
+		return -EINVAL;
+
+	/* Keep the list sorted by start; find the first range after @start. */
+	head = &vdev->excluded_ranges[bar];
+	list_for_each_entry(pos, head, entry) {
+		if (start < pos->start + pos->size && start + size > pos->start)
+			return -EINVAL;
+		if (pos->start > start)
+			break;
+	}
+
+	range = kmalloc_obj(*range);
+	if (!range)
+		return -ENOMEM;
+
+	*range = (struct vfio_pci_excluded_range) {
+		.start = start,
+		.size = size,
+		.flags = flags,
+	};
+	list_add_tail(&range->entry, &pos->entry);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_add_excluded_range);
+
+static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev)
+{
+	struct vfio_pci_excluded_range *range, *tmp;
+
+	for (int bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
+		list_for_each_entry_safe(range, tmp, &vdev->excluded_ranges[bar],
+					 entry) {
+			list_del(&range->entry);
+			kfree(range);
+		}
+	}
+}
+
 int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
 				      unsigned int type, unsigned int subtype,
 				      const struct vfio_pci_regops *ops,
@@ -2317,6 +2411,8 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 	INIT_LIST_HEAD(&vdev->dmabufs);
 	init_rwsem(&vdev->memory_lock);
 	xa_init(&vdev->ctx);
+	for (int bar = 0; bar < PCI_STD_NUM_BARS; bar++)
+		INIT_LIST_HEAD(&vdev->excluded_ranges[bar]);
 
 	ret = vfio_pci_core_cxl_init(vdev);
 	if (ret)
@@ -2332,6 +2428,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
 		container_of(core_vdev, struct vfio_pci_core_device, vdev);
 
 	vfio_pci_core_cxl_release(vdev);
+	vfio_pci_free_excluded_ranges(vdev);
 
 	mutex_destroy(&vdev->igate);
 	mutex_destroy(&vdev->ioeventfds_lock);
diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
index 4e7162234a2e..53544e0cbedf 100644
--- a/drivers/vfio/pci/vfio_pci_priv.h
+++ b/drivers/vfio/pci/vfio_pci_priv.h
@@ -44,6 +44,14 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
 
+/* A BAR sub-range kept off direct access; see vfio_pci_core_add_excluded_range() */
+struct vfio_pci_excluded_range {
+	struct list_head	entry;
+	u64			start;
+	u64			size;
+	u32			flags;
+};
+
 #ifdef CONFIG_VFIO_PCI_VGA
 ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite);
diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd46de17..93823c6391f6 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -198,6 +198,57 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
 
+/*
+ * Access @count bytes of @bar at @pos, walking the BAR's excluded ranges in
+ * order: a range excluded for this direction reads as -1 and drops writes,
+ * and the bytes around it reach the device. The MSI-X table is one such
+ * range, and a BAR can hold several, for example the MSI-X table and a CXL
+ * HDM decoder block.
+ */
+static ssize_t vfio_pci_bar_do_io_rw(struct vfio_pci_core_device *vdev,
+				     int bar, bool test_mem, void __iomem *io,
+				     char __user *buf, loff_t pos,
+				     size_t count, bool iswrite,
+				     enum vfio_pci_io_width max_width)
+{
+	u32 want = iswrite ? VFIO_PCI_EXCLUDE_WRITE : VFIO_PCI_EXCLUDE_READ;
+	struct vfio_pci_excluded_range *range;
+	ssize_t done = 0;
+	ssize_t ret;
+
+	list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
+		u64 end = range->start + range->size;
+		size_t chunk;
+
+		if (!(range->flags & want) || end <= pos)
+			continue;
+		if (range->start >= pos + count)
+			break;
+
+		/* Up to the end of this range; do_io_rw() fills it. */
+		chunk = min_t(u64, count, end - pos);
+		ret = vfio_pci_core_do_io_rw(vdev, test_mem, io, buf, pos, chunk,
+					     range->start, end, iswrite,
+					     max_width);
+		if (ret < 0)
+			return done ?: ret;
+
+		done += ret;
+		pos += ret;
+		buf += ret;
+		count -= ret;
+		if (!count)
+			return done;
+	}
+
+	ret = vfio_pci_core_do_io_rw(vdev, test_mem, io, buf, pos, count, 0, 0,
+				     iswrite, max_width);
+	if (ret < 0)
+		return done ?: ret;
+
+	return done + ret;
+}
+
 ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 			size_t count, loff_t *ppos, bool iswrite)
 {
@@ -256,13 +307,15 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
 		}
 	}
 
-	if (bar == vdev->msix_bar) {
-		x_start = vdev->msix_offset;
-		x_end = vdev->msix_offset + vdev->msix_size;
-	}
-
-	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
-				      count, x_start, x_end, iswrite, max_width);
+	if (bar == PCI_ROM_RESOURCE)
+		done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM,
+					      io, buf, pos, count, x_start,
+					      x_end, iswrite, max_width);
+	else
+		done = vfio_pci_bar_do_io_rw(vdev, bar,
+					     res->flags & IORESOURCE_MEM, io,
+					     buf, pos, count, iswrite,
+					     max_width);
 
 	if (done >= 0)
 		*ppos += done;
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 7f3a2bcb5830..70acb03d466e 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -162,6 +162,13 @@ struct vfio_pci_core_device {
 	struct notifier_block	nb;
 	struct rw_semaphore	memory_lock;
 	struct list_head	dmabufs;
+	/*
+	 * Excluded BAR sub-ranges, one list per BAR, sorted by start and not
+	 * overlapping. The lists are filled only while the device is being
+	 * opened and emptied in vfio_pci_core_disable(); every reader runs on
+	 * an open device in between, so readers take no lock.
+	 */
+	struct list_head	excluded_ranges[PCI_STD_NUM_BARS];
 };
 
 enum vfio_pci_io_width {
@@ -172,6 +179,19 @@ enum vfio_pci_io_width {
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
2.53.0

