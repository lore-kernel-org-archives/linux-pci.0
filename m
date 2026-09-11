Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EEC476070;
	Fri, 11 Sep 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.246.1.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131634; cv=none; b=ss2m+0uEQYj695MlDOld9k0CerDGIw3Bvb45ugIfaWclL/7E7pmIdKOGLmoUKIBXTWjbHAtdi5VZhjaCg6sP0TmUNVM19OoIs1Q0FyrDaQDWEte7/VE+U29g95jpjR7FSgiTETGNEqAk5s+v8QQoEEWinr3F7Uca9C2CjNKsruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131634; c=relaxed/simple;
	bh=S6mB6tAfA18u0SeIBQ79vmZ4kKuamVt3f/eGRJ+jtnY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEPWOp9plsPoajhPllFj9Sv9L5CNksFMwvDwOS/Q0zC2r/qs/M3OpqcQ5A1BGER0lesoKzCAlC3+sBljh23aGwNyFRJeeuiyVWbPHCC/EEycYMzdDFNhdWYI7fulb4RhOC96CBA/UFe+d/WPBwnVp9HSbhg1jIIELZrnj6hp6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=pCBTaPZn; arc=none smtp.client-ip=44.246.1.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="pCBTaPZn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789131623; x=1820667623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0tN/bx7Tag7WLT7gLKiEvgdR33AXYplSodqqSmnbwXs=;
  b=pCBTaPZnbmEYO354f5lwWUp1+SVaYBudha2qfMhPV8a/8/qxpv6bNjPJ
   pwHZyanXxQZr9TGqXcNDzrYS//Ku7GdjF22gYhhpibLxRN5+mPwn2/a9u
   Pclp3VAAmM/RTuiD0R+doE7aVUOTfTqcSpvuDzDOkuaAGZixXFYoY61yG
   bKvrZIIYFBT8RX07cx/pXCC4STzRFVAeu32ih28uMlvkzrZObaXgA5U0B
   doXWJQI6Hy/7oOZQ4k/1UpGyQq5YCKglvbH3pSf2nRurO1Vjq9dqt9Tmf
   xNZHFLHwSLYhEv5LCQ4jl2MWRT9m/eql48hnqkBrlAbuqbfBCrmbjnChh
   Q==;
X-CSE-ConnectionGUID: f4KebPnHSOKcqD4LJ3FNJw==
X-CSE-MsgGUID: Pw6GVIvFSYiYEhG0pJ72mA==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28428211"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 13:00:17 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:16618]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.236:2525] with esmtp (Farcaster)
 id 9a453679-8488-4fa8-871e-1c9c62cab044; Fri, 11 Sep 2026 13:00:17 +0000 (UTC)
X-Farcaster-Flow-ID: 9a453679-8488-4fa8-871e-1c9c62cab044
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 13:00:17 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 13:00:15 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 3/3] iommu: set up the default domain outside iommu_probe_device_lock
Date: Fri, 11 Sep 2026 14:58:34 +0200
Message-ID: <20260911125907.67105-3-sakacpav@amazon.de>
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
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Default domain allocation, attach and direct-mapping setup for a group's
first device still run inline under iommu_probe_device_lock, though they
need only group->mutex: iommu_group_store_type() does this at runtime
under group->mutex alone, and bus_iommu_probe() already defers it via the
group_list. With publication moved out it is the largest term left under
the hold, and parallel VF initialisation convoys behind it.

Use the group_list deferral for the singleton probe path too:
iommu_probe_device() passes a list and runs the setup after the global
unlock, under group->mutex. The global lock's original purpose - commit
01657bc14a39 ("iommu: Avoid races around device probe") - kept two devices
of one group from double-initialising it; that invariant moves to
group->mutex, where the setup is rechecked: of two racing siblings the
first to find the group unset sets it up for every member, and the rest
skip.

A failed setup unwinds only the calling device, like a failed publication;
siblings wait in -EPROBE_DEFER until a later probe finalises the group, or
until a new member joins if the failing call had claimed a bus-scanned
group's queued entry - the same terminal shape a failed bus_iommu_probe()
drain leaves today. A domain the failed setup published stays attached
(the first attach is IOMMU_SET_DOMAIN_MUST_SUCCEED), so members left
behind get the DMA ops it owed them.

bus_iommu_probe() rechecks group->default_domain, as a hotplug probe can
finalise a queued group before the drain takes the mutex.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/iommu/iommu.c | 48 ++++++++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index a5e3327aeaca..48fe22bbd1bc 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -657,10 +657,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 		goto err_put_group;
 	}
 
-	/*
-	 * The gdev must be in the list before calling
-	 * iommu_setup_default_domain()
-	 */
+	/* List the gdev first: the finaliser covers every listed member. */
 	list_add_tail(&gdev->list, &group->devices);
 	WARN_ON(group->default_domain && !group->domain);
 	if (group->domain || group->default_domain) {
@@ -676,15 +673,10 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 						0);
 		if (ret)
 			goto err_remove_gdev;
-	} else if (!group->default_domain && !group_list) {
-		ret = iommu_setup_default_domain(group, 0);
-		if (ret)
-			goto err_remove_gdev;
 	} else if (!group->default_domain) {
 		/*
-		 * With a group_list argument we defer the default_domain setup
-		 * to the caller by providing a de-duplicated list of groups
-		 * that need further setup.
+		 * Defer setup to the caller draining group_list; both in-tree
+		 * callers pass one.
 		 */
 		if (list_empty(&group->entry))
 			list_add_tail(&group->entry, group_list);
@@ -713,6 +705,7 @@ int iommu_probe_device(struct device *dev)
 	const struct iommu_ops *ops;
 	struct group_device *gdev, *own;
 	struct iommu_group *group;
+	LIST_HEAD(group_list);
 	int ret;
 
 	mutex_lock(&iommu_probe_device_lock);
@@ -721,7 +714,7 @@ int iommu_probe_device(struct device *dev)
 		mutex_unlock(&iommu_probe_device_lock);
 		goto probe_finalize;
 	}
-	ret = __iommu_probe_device(dev, NULL);
+	ret = __iommu_probe_device(dev, &group_list);
 	if (!ret) {
 		/*
 		 * Not every caller pins the device, so pin the group across
@@ -735,6 +728,9 @@ int iommu_probe_device(struct device *dev)
 		return ret;
 
 	mutex_lock(&group->mutex);
+	/* Only the caller that queued the entry may unlink it. */
+	if (!list_empty(&group_list))
+		list_del_init(&group->entry);
 	/* iommu_group_link_device() is all-or-nothing. */
 	for_each_group_device(group, gdev) {
 		if (gdev->linked)
@@ -743,6 +739,20 @@ int iommu_probe_device(struct device *dev)
 		if (ret)
 			goto err_remove_device;
 	}
+	/*
+	 * First thread to find the group unset sets it up for every member;
+	 * binding needs a default domain, so no DMA races the window.
+	 */
+	if (!list_empty(&group->devices) &&
+	    !group->domain && !group->default_domain) {
+		ret = iommu_setup_default_domain(group, 0);
+		if (ret)
+			goto err_remove_device;
+		for_each_group_device(group, gdev)
+			if (dev_has_iommu(gdev->dev))
+				iommu_setup_dma_ops(gdev->dev,
+						    group->default_domain);
+	}
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
 
@@ -765,8 +775,15 @@ int iommu_probe_device(struct device *dev)
 	if (own) {
 		list_del(&own->list);
 		__iommu_group_free_device(group, own);
-		iommu_deinit_device(dev);
 	}
+	/* Members left behind stay attached; give them the DMA ops owed. */
+	if (group->default_domain)
+		for_each_group_device(group, gdev)
+			if (dev_has_iommu(gdev->dev))
+				iommu_setup_dma_ops(gdev->dev,
+						    group->default_domain);
+	if (own)
+		iommu_deinit_device(dev);
 	mutex_unlock(&group->mutex);
 	if (own)
 		iommu_group_put(group);	/* iommu_init_device()'s reference */
@@ -2077,7 +2094,10 @@ static int bus_iommu_probe(const struct bus_type *bus)
 		 * that the cross-group default domain type and the setup of the
 		 * IOMMU_RESV_DIRECT will work correctly in non-hotpug scenarios.
 		 */
-		ret = iommu_setup_default_domain(group, 0);
+		ret = 0;
+		/* A hotplug probe may have finalised this group meanwhile. */
+		if (!group->default_domain)
+			ret = iommu_setup_default_domain(group, 0);
 		if (ret) {
 			mutex_unlock(&group->mutex);
 			return ret;
-- 
2.47.3

