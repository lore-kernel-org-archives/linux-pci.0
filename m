Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792C647D466;
	Fri, 11 Sep 2026 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131573; cv=none; b=lAK94cBrXNAIDYI/u+fFL4+9vqHvIFVPtOz7uDbUFTfnhENM9UWcIuFAv/N5anT0limGZSFnjP835YgWSOegt1fAJLM57i+GxqnD/8wn182M5P3EaimJEOqgbtNWDw5kdMwRbEjdynTYayju5UzuWR57JQ5jqaTiEIp+Fg5UuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131573; c=relaxed/simple;
	bh=CboY5wvVpRytI8cl2m3ayTAWBXACTQ8PugRCHjW4z7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5XyMrzRybtiVZIR8cImMuTWi/HhlUGurHFFhizxJcS1WA+auJS8xOCgqdPU23b99hZcqtv5g3YxwAsWHQoejek2MOp2IP/6AGrZnpbUa9z88dGCE83YmNPk1fJLowxFX2MJsp/2CT0bMa6mkhiRTXYqGPv9WokOQLTVdc0VH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=lzXKxTJc; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="lzXKxTJc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789131560; x=1820667560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0j7orxQTtOZt3x4KoixyDnG0kz3UItRqwWiC4q3s8g4=;
  b=lzXKxTJc8rG/iGZC858s+f40OBoa6WV2dGzaYi5b19KbJpzrkSV1LEmZ
   21vonmjM/aBtE57qC5ylt3Lu/v1FHan9IwKzG7cfZ03WoyLLAaCPltnBm
   j3Z/I0xH2ZXFBz2xBaBHouSEgowA+hzcrwyhFsvnzmqFLLLCdHkq4BDCt
   hHoffD7D6dYo2ghFVlQe6l41enOaWx3GkAS2sZqDVbZuvQ78bK7+6Buzd
   mhir3prI6lquUma3rJRA161yLVl8OEBkRf8Sanunu7FmhCF6lR9HMx4Po
   zwLuEifq0oPCecDRjwmNcyaU2HK+4R4XynYjDeNEbQ4D6nhbF+oGt2nbt
   w==;
X-CSE-ConnectionGUID: d22A1/TuR0S1FmMpnqCYMA==
X-CSE-MsgGUID: 5sbjRQTwQ5aZ3caN2MbuCw==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28213593"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:59:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:5640]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.198:2525] with esmtp (Farcaster)
 id 575257ac-a3ea-49b7-8157-9228a933ad10; Fri, 11 Sep 2026 12:59:11 +0000 (UTC)
X-Farcaster-Flow-ID: 575257ac-a3ea-49b7-8157-9228a933ad10
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:59:10 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:59:09 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 1/3] iommu: split sysfs link publication out of iommu_group_alloc_device()
Date: Fri, 11 Sep 2026 14:58:32 +0200
Message-ID: <20260911125907.67105-1-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de>
References: <20260911-vfopt-s2-v1-0-fff3db7e01c2@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

iommu_group_alloc_device() both allocates a group_device and publishes
it in sysfs (the "iommu_group" link and the group "devices/" member
link with its .%d rename loop), while the iommu instance links are
published separately in iommu_init_device() and removed in
iommu_deinit_device().

Gather all per-member publication into one helper,
iommu_group_link_device(), run under group->mutex, and record success
in a new group_device::linked flag. Teardown moves next to the member
link removal in __iommu_group_free_device(), which consults the flag so
an unpublished member skips sysfs.

No functional change intended; this gives publication a single seam so
a later commit can move it out of iommu_probe_device_lock.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/iommu/iommu.c | 91 +++++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..5f92981d9f34 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -77,6 +77,8 @@ struct group_device {
 	struct list_head list;
 	struct device *dev;
 	char *name;
+	/* Membership published in sysfs; set under group->mutex */
+	bool linked;
 	/*
 	 * Device is blocked for a pending recovery while its group->domain is
 	 * retained. This can happen when:
@@ -166,6 +168,8 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
 static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev);
+static int iommu_group_link_device(struct iommu_group *group,
+				   struct group_device *device);
 static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev);
 static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
@@ -515,16 +519,12 @@ static int iommu_init_device(struct device *dev)
 	}
 	dev->iommu->iommu_dev = iommu_dev;
 
-	ret = iommu_device_link(iommu_dev, dev);
-	if (ret)
-		goto err_release;
-
 	group = ops->device_group(dev);
 	if (WARN_ON_ONCE(group == NULL))
 		group = ERR_PTR(-EINVAL);
 	if (IS_ERR(group)) {
 		ret = PTR_ERR(group);
-		goto err_unlink;
+		goto err_release;
 	}
 	dev->iommu_group = group;
 
@@ -533,8 +533,6 @@ static int iommu_init_device(struct device *dev)
 		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
 	return 0;
 
-err_unlink:
-	iommu_device_unlink(iommu_dev, dev);
 err_release:
 	if (ops->release_device)
 		ops->release_device(dev);
@@ -553,8 +551,6 @@ static void iommu_deinit_device(struct device *dev)
 
 	lockdep_assert_held(&group->mutex);
 
-	iommu_device_unlink(dev->iommu->iommu_dev, dev);
-
 	/*
 	 * release_device() must stop using any attached domain on the device.
 	 * If there are still other devices in the group, they are not affected
@@ -667,6 +663,11 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 */
 	list_add_tail(&gdev->list, &group->devices);
 	WARN_ON(group->default_domain && !group->domain);
+
+	ret = iommu_group_link_device(group, gdev);
+	if (ret)
+		goto err_remove_gdev;
+
 	if (group->default_domain)
 		iommu_create_device_direct_mappings(group->default_domain, dev);
 	if (group->domain) {
@@ -729,10 +730,14 @@ static void __iommu_group_free_device(struct iommu_group *group,
 {
 	struct device *dev = grp_dev->dev;
 
-	sysfs_remove_link(group->devices_kobj, grp_dev->name);
-	sysfs_remove_link(&dev->kobj, "iommu_group");
+	if (grp_dev->linked) {
+		if (dev_has_iommu(dev))
+			iommu_device_unlink(dev->iommu->iommu_dev, dev);
+		sysfs_remove_link(group->devices_kobj, grp_dev->name);
+		sysfs_remove_link(&dev->kobj, "iommu_group");
 
-	trace_remove_device_from_group(group->id, dev);
+		trace_remove_device_from_group(group->id, dev);
+	}
 
 	/*
 	 * If the group has become empty then ownership must have been
@@ -1266,7 +1271,6 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev)
 {
-	int ret, i = 0;
 	struct group_device *device;
 
 	device = kzalloc_obj(*device);
@@ -1275,11 +1279,40 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 
 	device->dev = dev;
 
+	device->name = kasprintf(GFP_KERNEL, "%s", kobject_name(&dev->kobj));
+	if (!device->name) {
+		kfree(device);
+		dev_err(dev, "Failed to add to iommu group %d: %d\n",
+			group->id, -ENOMEM);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return device;
+}
+
+/*
+ * Publish a member's sysfs links under group->mutex.  All-or-nothing:
+ * on failure nothing is left behind and gdev->linked stays false, so
+ * __iommu_group_free_device() removes only what was published.
+ */
+static int iommu_group_link_device(struct iommu_group *group,
+				   struct group_device *device)
+{
+	struct device *dev = device->dev;
+	int ret, i = 0;
+
+	lockdep_assert_held(&group->mutex);
+
+	if (dev_has_iommu(dev)) {
+		ret = iommu_device_link(dev->iommu->iommu_dev, dev);
+		if (ret)
+			goto err_out;
+	}
+
 	ret = sysfs_create_link(&dev->kobj, &group->kobj, "iommu_group");
 	if (ret)
-		goto err_free_device;
+		goto err_unlink_iommu;
 
-	device->name = kasprintf(GFP_KERNEL, "%s", kobject_name(&dev->kobj));
 rename:
 	if (!device->name) {
 		ret = -ENOMEM;
@@ -1299,23 +1332,25 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						 kobject_name(&dev->kobj), i++);
 			goto rename;
 		}
-		goto err_free_name;
+		goto err_remove_link;
 	}
 
+	device->linked = true;
+
 	trace_add_device_to_group(group->id, dev);
 
 	dev_info(dev, "Adding to iommu group %d\n", group->id);
 
-	return device;
+	return 0;
 
-err_free_name:
-	kfree(device->name);
 err_remove_link:
 	sysfs_remove_link(&dev->kobj, "iommu_group");
-err_free_device:
-	kfree(device);
+err_unlink_iommu:
+	if (dev_has_iommu(dev))
+		iommu_device_unlink(dev->iommu->iommu_dev, dev);
+err_out:
 	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
-	return ERR_PTR(ret);
+	return ret;
 }
 
 /**
@@ -1329,15 +1364,23 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 {
 	struct group_device *gdev;
+	int ret;
 
 	gdev = iommu_group_alloc_device(group, dev);
 	if (IS_ERR(gdev))
 		return PTR_ERR(gdev);
 
+	mutex_lock(&group->mutex);
+	ret = iommu_group_link_device(group, gdev);
+	if (ret) {
+		mutex_unlock(&group->mutex);
+		kfree(gdev->name);
+		kfree(gdev);
+		return ret;
+	}
+
 	iommu_group_ref_get(group);
 	dev->iommu_group = group;
-
-	mutex_lock(&group->mutex);
 	list_add_tail(&gdev->list, &group->devices);
 	mutex_unlock(&group->mutex);
 	return 0;
-- 
2.47.3

