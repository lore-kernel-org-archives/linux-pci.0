Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2740D2FFDE1;
	Wed,  8 Apr 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775640736; cv=none; b=uEXClOqjJ1aTTp1sjRJfdZ7mSpMrVzuZMRIYQvz2dEEBWIMiqltd85X7sGvhI86CyZXI1JV0NK5Dy3Zp7l9PCiyohQ6DDmw9zr4UxuSXPp89GHjBSRaJ8PGsq+x8E05rlt7R8sA9X763S0nLvHCDIK/9YV6Px9b8yvrjo4zMdkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775640736; c=relaxed/simple;
	bh=2nF30+Sr3gc17R7R4zX7PkcCmxzC+b9YkjESN2fu6mQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fZwFmLtpuS6cdVsPU3O9h5nn5fs/4h/oRpiMCI/edgNbXw4SBTuuFjwKC+UJLnKADpvch3z1zzWjGN7sXk/g/LgPIuuQGxGB6pXqY2Coq0ejGRVJHcGmA1xYWyKNFMXAbV3B1rAE7moLxFf/Zo5seeVKNg0OFaqdHesbQ0dm0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=tYbjbNxj; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="tYbjbNxj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JQQfIfC7w0YWwjay2aujRldQK2hCuwY0NqD1RjMSkqg=;
	b=tYbjbNxjlgoUHOT93VZlsY54KMDC6ph80JpYYp8BRUnfvCbSwMwdRiryJyfZu7IGFXR+lVuPC
	XFJ0QP5upJGrrxVfFnorfr172V0TYgN7NChYGI3PxkL9GSMzgsR3/ZNnnBvsWqC7A4+7Ctn8INr
	8xzICbxOyt6xuxbuRebhyes=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4frHjl0x8Qzcb0q;
	Wed,  8 Apr 2026 17:25:47 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 7634940569;
	Wed,  8 Apr 2026 17:32:04 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Apr 2026 17:32:03 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <alex@shazbot.org>, <chrisw@redhat.com>, <jbarnes@virtuousgeek.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH] PCI/sysfs: Prohibit unaligned access to I/O port
Date: Wed, 8 Apr 2026 17:55:32 +0800
Message-ID: <20260408095532.1192625-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)

Unaligned access is harmful for non-x86 archs such as arm64. When we
use pwrite or pread to access the I/O port resources with unaligned
offset, system will crash as follows:

Unable to handle kernel paging request at virtual address fffffbfffe8010c1
Internal error: Oops: 0000000096000061 [#1] SMP
Call trace:
 _outw include/asm-generic/io.h:594 [inline]
 logic_outw+0x54/0x218 lib/logic_pio.c:305
 pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
 pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
 pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
 sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
 kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
 vfs_write+0x7bc/0xac8 fs/read_write.c:586
 ksys_write+0x12c/0x270 fs/read_write.c:639
 __arm64_sys_write+0x78/0xb8 fs/read_write.c:648

Although x86 might handle unaligned I/O accesses by splitting cycles,
this approach is still limited because PCI device registers typically
expect natural alignment. A global prohibition of unaligned accesses
ensures consistent behavior across all architectures and prevents
unexpected hardware side effects.

Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port resources")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
Link: https://lore.kernel.org/all/20260116081723.1603603-1-duziming2@huawei.com/
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 16eaaf749ba97..c88910bcad262 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -31,6 +31,7 @@
 #include <linux/of.h>
 #include <linux/aperture.h>
 #include <linux/unaligned.h>
+#include <linux/align.h>
 #include "pci.h"
 
 #ifndef ARCH_PCI_DEV_GROUPS
@@ -1157,6 +1158,9 @@ static ssize_t pci_resource_io(struct file *filp, struct kobject *kobj,
 	if (port + count - 1 > pci_resource_end(pdev, bar))
 		return -EINVAL;
 
+	if (!IS_ALIGNED(port, count))
+		return -EINVAL;
+
 	switch (count) {
 	case 1:
 		if (write)
-- 
2.43.0

