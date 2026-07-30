Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664737FF42;
	Thu, 30 Jul 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380669; cv=none; b=jMg4uA8xnh1VWgp05Xe2nQ3c3v97SH+rp7odPMkrkyVTgn0cvocXeA3LaL0DcBs+JeUkLkS4EJtgRYkWxqfG19V/SqQmXMMjfFYzqgURQJfu/2Pkh2HOH96tzoXvSQ5iUO7UOFZ5rvqFRnA7C9muDTuIAdrO5fxc7SM3AOoOwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380669; c=relaxed/simple;
	bh=qT95Yn+oSmZPZX4e1YLkRrBVBOCLf6822FETl2e65CI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSj5L1lJMdz2tETu3XFuINQ6mWxF2+6EvvUTCH5fnEF45DfjR5SEHxD/RC1bg/TBzb8lwBLi3IFHfX+3r0dqmDJ1f2A7IorB7kgKO1nJR5OoV8ly/M3vFu3pDG41Wkcos79FrVBDWbujeJDJ0vXn4ruwW4/uhKXX2xq2YfR/sUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Rz6G6jk2; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Rz6G6jk2"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Q9dgmwwoCsPuqo+K6+VV3WRtVJFUiwB1urZ7jCNU9D8=;
	b=Rz6G6jk2dx+q+i14JiSteyhSWkRITc3vlj/3MU5howGIvxBMyKbiy9i5UJuIx3gPlDZI6JiTh
	nAvjERPowdx6Fn5n3jRNI5iQm7MH2/0tykb34dWIZ8K8LolI5hZXRuurU5zN7G94DTV2yKYBWi5
	8by8dTWc5Lti2ZWc/O8jsDU=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h9Yhb3XRQzLlXB;
	Thu, 30 Jul 2026 10:54:55 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id ECBB54055B;
	Thu, 30 Jul 2026 11:04:22 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 11:04:22 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <kwilczynski@kernel.org>
CC: <rientjes@google.com>, <gregkh@suse.de>, <iweiny@kernel.org>,
	<djbw@kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v2 5/6] PCI: Align proc_bus_pci_write() with pci_write_config()
Date: Thu, 30 Jul 2026 11:24:37 +0800
Message-ID: <20260730032438.1643450-6-duziming2@huawei.com>
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

proc_bus_pci_write() and pci_write_config() implement essentially the
same functionality. To improve consistency across the PCI subsystem,
align the implementation in procfs with the sysfs counterpart.

Specifically:
  - Use dev->cfg_size directly instead of assigning it to 'size'.
  - Rename the variable 'pos' to 'off' and replace 'cnt' with 'size'.
  - Remove the redundant bounds check `if (nbytes >= size)`.
  - Use the same transfer loop conditions as pci_write_config().

No functional change intended.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 61 +++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 3f041765da978..71d1f34e13a7d 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -114,80 +114,79 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 {
 	struct inode *ino = file_inode(file);
 	struct pci_dev *dev = pde_data(ino);
-	loff_t pos = *ppos;
-	int size = dev->cfg_size;
-	int cnt, ret;
+	loff_t off = *ppos;
+	unsigned int size = nbytes;
+	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
 
-	if (resource_is_exclusive(&dev->driver_exclusive_resource, pos,
+	if (resource_is_exclusive(&dev->driver_exclusive_resource, off,
 				  nbytes)) {
 		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config offset %llx",
-			      current->comm, pos);
+			      current->comm, off);
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
 
-	if (pos >= size)
+	if (off >= dev->cfg_size)
 		return 0;
-	if (nbytes >= size)
+	if (off + size > dev->cfg_size) {
+		size = dev->cfg_size - off;
 		nbytes = size;
-	if (pos + nbytes > size)
-		nbytes = size - pos;
-	cnt = nbytes;
+	}
 
-	if (!access_ok(buf, cnt))
+	if (!access_ok(buf, size))
 		return -EINVAL;
 
 	pci_config_pm_runtime_get(dev);
 
-	if ((pos & 1) && cnt) {
+	if ((off & 1) && size) {
 		unsigned char val;
 		__get_user(val, buf);
-		pci_user_write_config_byte(dev, pos, val);
+		pci_user_write_config_byte(dev, off, val);
 		buf++;
-		pos++;
-		cnt--;
+		off++;
+		size--;
 	}
 
-	if ((pos & 3) && cnt > 2) {
+	if ((off & 3) && size > 2) {
 		__le16 val;
 		__get_user(val, (__le16 __user *) buf);
-		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, off, le16_to_cpu(val));
 		buf += 2;
-		pos += 2;
-		cnt -= 2;
+		off += 2;
+		size -= 2;
 	}
 
-	while (cnt >= 4) {
+	while (size > 3) {
 		__le32 val;
 		__get_user(val, (__le32 __user *) buf);
-		pci_user_write_config_dword(dev, pos, le32_to_cpu(val));
+		pci_user_write_config_dword(dev, off, le32_to_cpu(val));
 		buf += 4;
-		pos += 4;
-		cnt -= 4;
+		off += 4;
+		size -= 4;
 	}
 
-	if (cnt >= 2) {
+	if (size >= 2) {
 		__le16 val;
 		__get_user(val, (__le16 __user *) buf);
-		pci_user_write_config_word(dev, pos, le16_to_cpu(val));
+		pci_user_write_config_word(dev, off, le16_to_cpu(val));
 		buf += 2;
-		pos += 2;
-		cnt -= 2;
+		off += 2;
+		size -= 2;
 	}
 
-	if (cnt) {
+	if (size) {
 		unsigned char val;
 		__get_user(val, buf);
-		pci_user_write_config_byte(dev, pos, val);
-		pos++;
+		pci_user_write_config_byte(dev, off, val);
+		off++;
 	}
 
 	pci_config_pm_runtime_put(dev);
 
-	*ppos = pos;
+	*ppos = off;
 	inode_lock(ino);
 	i_size_write(ino, dev->cfg_size);
 	inode_unlock(ino);
-- 
2.43.0

