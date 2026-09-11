Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A781D47D93F;
	Fri, 11 Sep 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131617; cv=none; b=p1jScqBCjFTNg9PlMPvHlFHMIv1dfK956rw7fgbrr9sBrjYWKh74m4sI/9yxtgiM48tm1oXOv2KHktNFvmaN9JxxF2dU2bcsP8z0GY1rLTkZDl/o1bN5cl5cdkdBvcGze/Qya4uc5lCv7k0Cqimhpt2cL5wJEnLyBjY66i4QDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131617; c=relaxed/simple;
	bh=8T5MONSZ8Js55NmVWx8mM2Wfxi/Kbz4ZEP3YDs8/jR8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tb4HsN4AMGMtRPXIbYBLJH5A0OEz0us2oVZ7M0HnyQWHKykkWBb8lHvJvgVNhmhXznEte4j1DZrWohav+ZoS2WTRsSTrWYN5FvzYzVE4yRTVHbl4FF/ewiWoQ8gHFlX5kpNzLO9F2AFxc94NcmFNg41acGwRxYh+2eOJNcBA/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=c8o5l+sK; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="c8o5l+sK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789131591; x=1820667591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2L9S+3Dh+JSZV/kkL2FGWTo1pnT3Slzf5NoDHwIP3q8=;
  b=c8o5l+sKsdG5ylzjkFEfzl/U1Nikjsz2KSB8zZgvsomCwuAeAjraUDom
   Xdh73i7gnKJ8w1MPtg09xRtbZKh0U6Gtz3K4Ui+8BVof222Wb7QiW0tNJ
   i8Haoc6W+jO+hD1rn7jwnsqRtPuLTXNW8MFx0uVTlMQW04P7BRcgqaWz9
   W0MOSLRmz4u30xAn1MtH7cOezv9zh+bkbzMC8g2rlhBpthUvRzFFqfY8i
   1NWuZq9TDT6x6flLARBipMJ4gCo1jiNMDR4HtUvRJhFML7uYBON7UPL57
   nO6RI+98PoWykRGl+eGJWxc7NLMTe4pwpzOh2YrjcmtbaSTNT5nh2MjgJ
   Q==;
X-CSE-ConnectionGUID: j7VRNDKfTU+1yq2BGLqxdQ==
X-CSE-MsgGUID: KeS1QwBPSayXD+ZMCPjPtA==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28217848"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 12:59:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:30085]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.54:2525] with esmtp (Farcaster)
 id af5fa79d-4d72-4a3b-97c5-76066859d93e; Fri, 11 Sep 2026 12:59:44 +0000 (UTC)
X-Farcaster-Flow-ID: af5fa79d-4d72-4a3b-97c5-76066859d93e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 12:59:43 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 12:59:42 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 2/3] iommu: create device sysfs links outside iommu_probe_device_lock
Date: Fri, 11 Sep 2026 14:58:33 +0200
Message-ID: <20260911125907.67105-2-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Parallel device probes convoy on iommu_probe_device_lock, and parallel VF
initialisation shows it as a top contention source, with per-member sysfs
publication the dominant term under the hold. Publication needs no global
ordering: removal already does the reverse under group->mutex alone in
__iommu_group_free_device().

Pin the group under the global lock, drop it, and publish every member
still lacking links under group->mutex. A device joining a group that
already has a domain is published under the global lock instead, because
no later pass is guaranteed to visit it; members created by
probe_iommu_group() are published by bus_iommu_probe()'s existing drain.

The group reference is needed because not every caller pins the device:
iommu_add_device() on powerpc, the __init sweep in
probe_acpi_namespace_devices() and the of_dma_configure() replay run
neither inside device_add() nor under device_lock().

A sibling whose publication failed stays unpublished, retried by any later
finalisation or drain; in the worst case it waits until a new member joins,
the same terminal shape a failed bus_iommu_probe() drain leaves today. On
the hotplug path the links exist before device_add() emits KOBJ_ADD, so
udev cannot tell the difference.

A failed call also removes the probing device itself from the group:
iommu_probe_device() early-exits on membership, so a member left behind
would turn a retried probe into a no-op success while the group's members
remain unpublished.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/iommu/iommu.c | 70 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 5f92981d9f34..a5e3327aeaca 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -663,11 +663,12 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 */
 	list_add_tail(&gdev->list, &group->devices);
 	WARN_ON(group->default_domain && !group->domain);
-
-	ret = iommu_group_link_device(group, gdev);
-	if (ret)
-		goto err_remove_gdev;
-
+	if (group->domain || group->default_domain) {
+		/* No later pass is guaranteed to publish this member. */
+		ret = iommu_group_link_device(group, gdev);
+		if (ret)
+			goto err_remove_gdev;
+	}
 	if (group->default_domain)
 		iommu_create_device_direct_mappings(group->default_domain, dev);
 	if (group->domain) {
@@ -710,19 +711,68 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 int iommu_probe_device(struct device *dev)
 {
 	const struct iommu_ops *ops;
+	struct group_device *gdev, *own;
+	struct iommu_group *group;
 	int ret;
 
 	mutex_lock(&iommu_probe_device_lock);
+	/* Already probed; publication belongs to the creating call. */
+	if (dev->iommu_group) {
+		mutex_unlock(&iommu_probe_device_lock);
+		goto probe_finalize;
+	}
 	ret = __iommu_probe_device(dev, NULL);
+	if (!ret) {
+		/*
+		 * Not every caller pins the device, so pin the group across
+		 * the unlock.
+		 */
+		group = dev->iommu_group;
+		iommu_group_ref_get(group);
+	}
 	mutex_unlock(&iommu_probe_device_lock);
 	if (ret)
 		return ret;
 
+	mutex_lock(&group->mutex);
+	/* iommu_group_link_device() is all-or-nothing. */
+	for_each_group_device(group, gdev) {
+		if (gdev->linked)
+			continue;
+		ret = iommu_group_link_device(group, gdev);
+		if (ret)
+			goto err_remove_device;
+	}
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+probe_finalize:
 	ops = dev_iommu_ops(dev);
 	if (ops->probe_finalize)
 		ops->probe_finalize(dev);
 
 	return 0;
+
+err_remove_device:
+	/* Retried probes early-exit on membership; failure must undo it. */
+	own = NULL;
+	for_each_group_device(group, gdev) {
+		if (gdev->dev == dev) {
+			own = gdev;
+			break;
+		}
+	}
+	if (own) {
+		list_del(&own->list);
+		__iommu_group_free_device(group, own);
+		iommu_deinit_device(dev);
+	}
+	mutex_unlock(&group->mutex);
+	if (own)
+		iommu_group_put(group);	/* iommu_init_device()'s reference */
+	iommu_group_put(group);		/* the reference taken above */
+
+	return ret;
 }
 
 static void __iommu_group_free_device(struct iommu_group *group,
@@ -2012,6 +2062,16 @@ static int bus_iommu_probe(const struct bus_type *bus)
 		/* Remove item from the list */
 		list_del_init(&group->entry);
 
+		for_each_group_device(group, gdev) {
+			if (gdev->linked)
+				continue;
+			ret = iommu_group_link_device(group, gdev);
+			if (ret) {
+				mutex_unlock(&group->mutex);
+				return ret;
+			}
+		}
+
 		/*
 		 * We go to the trouble of deferred default domain creation so
 		 * that the cross-group default domain type and the setup of the
-- 
2.47.3

