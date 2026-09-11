Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267334A5C23;
	Fri, 11 Sep 2026 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789148902; cv=none; b=SHxKQGyC4Z6eKH7JIvuZYhXYq1XmMCgkqg/X2zUxrtIy9HmWnXmJj5suqrkVH79rZm61YxAAcySCC2h1wJB4fRG/mUQCLCXiVo/OC1XziNeDUloQVIjDPY050PLIDD0GAG+OV+glqZAh1EwMuZ0TnodS3PICOglowAaUfYaPnAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789148902; c=relaxed/simple;
	bh=9leqayE49Oyz1EhyEm9zFmsiRGQbZooy9v4epT1KDJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l6czlpXHATVZIsnEpKmUzXH5kl5ptvNChdtBjCYIlkeu8OZeY+EdZF4E8g29q7X4QHAZubYZ7QXpMiqN8XOWaWB09vXnNzA5KMfrEh63Cd8SBFzaOjb6AwepjqcE3uzRBE8gKUToZTd8ucEXpMR8i7o7ppqB0DMkDPI90Ml7t3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=oUOqp/Dy; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="oUOqp/Dy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1789148900; x=1820684900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uOLhShYEEjRLR1coK3ZfM4Sg+hn51n7UIhIFHEx/jJ8=;
  b=oUOqp/Dy/g5rn9UlTq7Fn730aetogXEKZNYRhrGKtegphfwcfv8s59aW
   fTnoW79e5r0idQYIURSQLBW7mNlAoJUYO13aczzm3QPuooCu2wdrThvYp
   a+UHoF/9xJJtPHXYsXN+PZ6FGIHctkBsWvn2IVUv1VaGh8zS3P3RbBwcU
   O8+B1R+InJnwTL2D5BTiDfcDQZCrMSk7df2axqSHqjEWznXQziPceE8ik
   gCwEgKZG95HLDT5XWg4y1EJ48BLWzTEI/lqntczSka3+yOiUOo/gf3mqh
   /i3fRPcSswW9+fWelBj8QzvXlqYrAqsOuJ1yCIOzbyBqi4sNGlijLnwJU
   A==;
X-CSE-ConnectionGUID: I2whZOZ8TV29O6pMEDxgVw==
X-CSE-MsgGUID: S2z4XCtESgiShsGwJQ/O4Q==
X-IronPort-AV: E=Sophos;i="6.27,97,1787011200"; 
   d="scan'208";a="28227456"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 17:48:16 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:27899]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.27:2525] with esmtp (Farcaster)
 id 39b22f75-224a-4113-9cc0-1bfc055575e6; Fri, 11 Sep 2026 17:48:16 +0000 (UTC)
X-Farcaster-Flow-ID: 39b22f75-224a-4113-9cc0-1bfc055575e6
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 11 Sep 2026 17:48:15 +0000
Received: from dev-dsk-sakacpav-1a-480d1124.eu-west-1.amazon.com
 (172.19.96.155) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Fri, 11 Sep 2026
 17:48:13 +0000
From: Pavol Sakac <sakacpav@amazon.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo
	<tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>
CC: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, Alex Williamson
	<alex@shazbot.org>, <kvm@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: [RFC PATCH 8/8] vfio: Opt the group and vfio-dev class devices into staged sysfs
Date: Fri, 11 Sep 2026 19:43:40 +0200
Message-ID: <20260911174414.97060-8-sakacpav@amazon.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
References: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The vfio group chardev and the vfio-dev class device are created once per
VF during a registration storm and satisfy the staged-sysfs opt-in
conditions trivially: class devices never match drivers, no
class_interface consumers exist for either class, and the KOBJ_ADD uevent
fires after publication, so no consumer can observe a partially built
directory. Without this, the concurrent registrations that creating the
group chardev outside vfio.group_lock unleashes convoy on the eager
kernfs_rwsem path instead.

Both devices live in class glue directories, which staged registration
covers.

Assisted-by: LLM
Signed-off-by: Pavol Sakac <sakacpav@amazon.de>
---
 drivers/vfio/group.c     | 7 +++++++
 drivers/vfio/vfio_main.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index 692381151303..ee41e1253f3d 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -659,6 +659,13 @@ vfio_group_find_or_create(struct device *dev, struct iommu_group *iommu_group,
 	list_add(&new->vfio_next, &vfio.group_list);
 	mutex_unlock(&vfio.group_lock);
 
+	/*
+	 * Class devices never match drivers and vfio has no class_interface
+	 * consumers, so nothing can observe the group chardev's directory
+	 * before device_add() publishes it in one step.
+	 */
+	dev_set_sysfs_staged(&new->dev);
+
 	/*
 	 * Hold back device_add()'s KOBJ_ADD until publication; on failure,
 	 * suppression also keeps the device_add() unwind from emitting an
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 423ead48aafe..7abdfbd54b9d 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -383,6 +383,9 @@ static int __vfio_register_dev(struct vfio_device *device,
 		goto err_out;
 	}
 
+	/* Staged opt-in: same conditions as vfio_group_find_or_create(). */
+	dev_set_sysfs_staged(&device->device);
+
 	ret = vfio_device_add(device);
 	if (ret)
 		goto err_out;
-- 
2.47.3

