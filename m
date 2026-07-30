Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F3A37206F;
	Thu, 30 Jul 2026 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380670; cv=none; b=BjI9m2c4BGtPXrdRcw8AXk1q1TEEMj8PAsjC1HnwQG87c2XswRQIxEI3kjXQ1iE3FPDIPS5XyDMYPspqWoz1JHxvCYzvXdKwJ5U2KASK8NUERSnQTqc2Sx03bht3EY1ylHEqXzpbRo64jSHaIjWQMUQadLzCl3UZvA8ZhMrDrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380670; c=relaxed/simple;
	bh=LClc1Ry7UL89Zs7FWjwfrJzgaMl4viydYEd0rV3Epw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izOVbXfsYLOqcbTOEiDenjSpD94OJy54auyZSmP1S7H0i/k0iaZDW2W5L01faOgL8e4pQY45RBDFhBnY02DLlkBnNZyta5vzIIl4dU7A1M88wrbwLyiEnIheniP85h2RRLojFJOKLGOSoPjneAcnqdmelRAShg+YGKgl3X49+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ka71NM43; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ka71NM43"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7arLefF2+BZK20o4V4PwNrnOO7Btl90UVdh7uSd5MW8=;
	b=Ka71NM436QiM8tpeqA/paobS/QeTWMSCH6yBGdM+VG1I0XjHY6lCUMHaNEDQ95UbYFD5Pfzt5
	XxzMqTFMiECvOCTD+60kUZ9Ja5zOdMG9VYqykgnxLBv6F7hI77FLCmgMoLz+aNrz9Ub2ad9ia8K
	ZcsA2ZleYWR0GoaJMg/3qgg=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h9Yhk3q7XzpSvD;
	Thu, 30 Jul 2026 10:55:02 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 275314056D;
	Thu, 30 Jul 2026 11:04:21 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 11:04:20 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <kwilczynski@kernel.org>
CC: <rientjes@google.com>, <gregkh@suse.de>, <iweiny@kernel.org>,
	<djbw@kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v2 1/6] PCI: Prevent overflow in proc_bus_pci_{read,write}()
Date: Thu, 30 Jul 2026 11:24:33 +0800
Message-ID: <20260730032438.1643450-2-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730032438.1643450-1-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500012.china.huawei.com (7.202.195.23)

proc_bus_pci_read() and proc_bus_pci_write() receive the file position
as a 64-bit loff_t, but store it in 32-bit variables before validating
the configuration-space bounds.

In proc_bus_pci_read(), pos is an unsigned int, so an offset such as
0x100000000 is truncated to zero. The truncated value passes the bounds
check and causes the function to read from the beginning of PCI
configuration space instead of returning EOF.

In proc_bus_pci_write(), pos is an int, so an offset greater than
INT_MAX may become negative. The negative value bypasses the
pos >= size check and is then mixed with the unsigned nbytes value.
The bounds adjustment may consequently expand a small request into a
very large transfer, causing the write loop to use invalid negative
configuration offsets and run for an excessive amount of time.

Fix this by changing the type of pos to loff_t.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 71ad289fcb8e3..cad749924dd89 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -30,7 +30,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 				 size_t nbytes, loff_t *ppos)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
-	unsigned int pos = *ppos;
+	loff_t pos = *ppos;
 	unsigned int cnt, size;
 
 	/*
@@ -114,7 +114,7 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 {
 	struct inode *ino = file_inode(file);
 	struct pci_dev *dev = pde_data(ino);
-	int pos = *ppos;
+	loff_t pos = *ppos;
 	int size = dev->cfg_size;
 	int cnt, ret;
 
-- 
2.43.0

