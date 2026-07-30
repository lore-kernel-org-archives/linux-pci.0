Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DAB366074;
	Thu, 30 Jul 2026 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380674; cv=none; b=Qu4CxC3dYdyxRNKIL3FPKsgz0UV1wSCZm0mSMFueq/48UweO+QSRCRPrTnKY0gQ0H4PvdUCnth/NlyEqr1p3iXIg0//2OVSglxG/evPefvEUlN2YkdW9enuiut3E/kRFWW+Chfxc/IZ88Fp9iDekOTsA+5vdAA8MRlj3lCKoYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380674; c=relaxed/simple;
	bh=F8kh6kpVwAVqg89SjvWWsfi9GYhXR6t+CjjF12uEVic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPWKvfdtyzMz8bsBEWUMax4XG3pwf6D7BUyDKleeeY8OtRZZImy84f0H+xBVmCQE/hY6CG1fQFz3aXGjp3i09erAwTcD01mHqc14ZQUiv76PnIczftXBTBZIL5lY9nIDaJQ++mBcQjRfTi8Dk45trQDe6MjPrMmH0pV+cpRYS0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Po56goIf; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Po56goIf"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=La5UbuNQUrKd7MkjJiDTMsdeEMYLab6hnnFghv4tP34=;
	b=Po56goIfHMCfWV6EhJHgLtgf+12aIVaB7VBfyYU2kZVtVCjhCfCdHtzcuuRE6SJJ1+zXxfL3D
	d29By6G9hJ/DHWH+JBYwxlqTFkWgP2AkFxk9qFfeJsVi2RvarUQe5bq1MxIf/WsYqqfCB1asUia
	Va0hSaSu6EEcsIir0QhODxw=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h9Yhb0v2lznTVn;
	Thu, 30 Jul 2026 10:54:55 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 0337A4055B;
	Thu, 30 Jul 2026 11:04:22 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 11:04:21 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <kwilczynski@kernel.org>
CC: <rientjes@google.com>, <gregkh@suse.de>, <iweiny@kernel.org>,
	<djbw@kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v2 3/6] PCI/proc: Warn on writes to driver-exclusive config regions
Date: Thu, 30 Jul 2026 11:24:35 +0800
Message-ID: <20260730032438.1643450-4-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730032438.1643450-1-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500012.china.huawei.com (7.202.195.23)

The sysfs configuration-space write path warns and taints the kernel
when userspace writes a region claimed exclusively by a driver. The
procfs path can access the same configuration space but does not perform
this check.

Add the same resource_is_exclusive() warning and taint to
proc_bus_pci_write() so the two userspace interfaces treat driver-owned
ranges consistently.

Fixes: 278294798ac9 ("PCI: Allow drivers to request exclusive config regions")
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index ec2338c1e667e..3f041765da978 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -122,6 +122,13 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	if (ret)
 		return ret;
 
+	if (resource_is_exclusive(&dev->driver_exclusive_resource, pos,
+				  nbytes)) {
+		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config offset %llx",
+			      current->comm, pos);
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+	}
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
-- 
2.43.0

