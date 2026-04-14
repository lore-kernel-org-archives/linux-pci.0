Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08DC30C60E;
	Tue, 14 Apr 2026 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133351; cv=none; b=qyBNpTuHvaig3n9DcxdaqZkWGW/LXDpq8r6QJH5A+1su6bkne9WoYkFfxPdT+dz4sE6PWYnQHXKDEvpbkOHF+jt8wSDjzSZ+jtJmezEEmZRKJVi4s0IlLTXAZRdqgT5/z69b6LLP0VBCSKN77mtYUEodtOE+OVs9cmbXNw5JL4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133351; c=relaxed/simple;
	bh=/wtDT4MdnjgvJOOsjhVjUp0LNp1B6GMWXTJNUgL8GOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3rpOZBpmY7v8TPAMMeKLW8ko1m6fPW7Smfy1UGJbttbdGExE6W3DJ6nPYPZ+qU05pTjFwOWB8yCJl+MsJiiWVUQp+Cypg0jsWuchxBMvg+yOEO9cL+RWrj9L6IMUsbQJ+GUzR11jADP+DB30IGvvxF30nHMAwpoMnfQzCe7h9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DAOOkSiF; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DAOOkSiF"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=M3KMhP/WcVNEddR6J8mToVU8dtDZqfoBTUitiX8FtdU=;
	b=DAOOkSiFkUmnJ7sRuOGEgkbjWmpxWq/TnfRveW+z+qQYyHKOPFoc4tYdJrvXDGFFY6aMdbaDL
	RZ8npvW2H7xWTC1OPjrbiXiUh6pRPcjwp+kNf2+mBgsrqcNqbOzHu8wdEI7/mZrt3adD+WIshqL
	5KoW4xtV/baKj1D2M1wlm0k=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fvnv25jlxzcZyN;
	Tue, 14 Apr 2026 10:15:58 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 854C1203AD;
	Tue, 14 Apr 2026 10:22:26 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 10:22:26 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH 3/4] PCI: Prevent overflow in proc_bus_pci_write()
Date: Tue, 14 Apr 2026 10:45:43 +0800
Message-ID: <20260414024544.2975605-4-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414024544.2975605-1-duziming2@huawei.com>
References: <20260414024544.2975605-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)

When the value of *ppos over the INT_MAX, the variable off is over
set to a negative value which will be passed to get_user() or
pci_user_write_config_dword(). Unexpected behavior such as a soft lockup
will happen as follows:

 watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
 RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
 Call Trace:
  <TASK>
  pci_user_write_config_dword+0x126/0x1f0
  proc_bus_pci_write+0x273/0x470
  proc_reg_write+0x1b6/0x280
  do_iter_write+0x48e/0x790
  vfs_writev+0x125/0x4a0
  __x64_sys_pwritev+0x1e2/0x2a0
  do_syscall_64+0x59/0x110
  entry_SYSCALL_64_after_hwframe+0x78/0xe2

Fix this by changing the type of off to loff_t.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 6524280bc903..a5db7d23353a 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -113,7 +113,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 {
 	struct inode *ino = file_inode(file);
 	struct pci_dev *dev = pde_data(ino);
-	int off = *ppos;
+	loff_t off = *ppos;
 	unsigned int size = nbytes;
 	int ret;
 
-- 
2.43.0

