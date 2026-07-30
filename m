Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2F37F011;
	Thu, 30 Jul 2026 03:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380670; cv=none; b=fnY6d1oUAga9V7YavqMKpK9h0ND03xDbVLeix5k95Za6eH8ZwxUzUDRoyn5E+N194sIRSIrZLPVoymn4RFVq0XjdEbFk79XW3HOtnoamLiFNUwTwCXwHjsgEwr3ztzAgB9rNiTKVn6kdIG6ogdf+sulbjc+uVoXCHxHEqLu9pW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380670; c=relaxed/simple;
	bh=RWQA/Z91GBMCxZhW7S5/DkNdyou25R2k2Az3Psh3fE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pt/38AJaOHRdqdX2rDtHDIUDfitcF+2cX4tC+Xr+xWClr+GzKz07jcqAGvZ99E2va5ksIe2N0T0NNjbGIlXfmBMQapR5mK1Fainrhd4YiyeHw08NHtM9UrOzX1CpRAv32nmuMSS+ukCAHy/CFOEpTc19fGGaTFfM2VZss2YgkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=vZ5hfkdA; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="vZ5hfkdA"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yNOVUmO9AXFSB7GXoDnrSYRvQ/LdCfQ3/PiKRyxRtwI=;
	b=vZ5hfkdANHc6zh4j1dpJ6U3yiZSL7+CWzl2FHAkUZlTASJBTBlkt30bs3rjiAt5z9ekrPSdhs
	Zf+Gohed7CqmaP/iOinf3elvCUyeuTb/ZT1OTG65l47G6yy6kvPEhhkZv8+Y+yJUG+cX9m4M5TP
	ANie5dCLeG3iFWEhyY/2Bv0=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4h9Yhd12HZzRhR0;
	Thu, 30 Jul 2026 10:54:57 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 60FAA40579;
	Thu, 30 Jul 2026 11:04:23 +0800 (CST)
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
Subject: [PATCH v2 6/6] PCI: Align proc_bus_pci_read() with pci_read_config()
Date: Thu, 30 Jul 2026 11:24:38 +0800
Message-ID: <20260730032438.1643450-7-duziming2@huawei.com>
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

proc_bus_pci_read() and pci_read_config() implement essentially the
same functionality. To improve consistency across the PCI subsystem,
align the implementation in procfs with the sysfs counterpart.

Specifically:
  - Rename the variable 'pos' to 'off' and replace 'cnt' with 'count'.
  - Remove the redundant bounds check `if (nbytes >= size)`.
  - Use the same transfer loop conditions as pci_read_config().

No functional change intended.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 58 +++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 71d1f34e13a7d..13ac92da4624b 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -30,8 +30,9 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 				 size_t nbytes, loff_t *ppos)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
-	loff_t pos = *ppos;
-	unsigned int cnt, size;
+	loff_t off = *ppos;
+	unsigned int count = nbytes;
+	unsigned int size;
 
 	/*
 	 * Normal users can read only the standardized portion of the
@@ -46,66 +47,65 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 	else
 		size = 64;
 
-	if (pos >= size)
+	if (off >= size)
 		return 0;
-	if (nbytes >= size)
-		nbytes = size;
-	if (pos + nbytes > size)
-		nbytes = size - pos;
-	cnt = nbytes;
+	if (off + count > size) {
+		count = size - off;
+		nbytes = count;
+	}
 
-	if (!access_ok(buf, cnt))
+	if (!access_ok(buf, count))
 		return -EINVAL;
 
 	pci_config_pm_runtime_get(dev);
 
-	if ((pos & 1) && cnt) {
+	if ((off & 1) && count) {
 		unsigned char val;
-		pci_user_read_config_byte(dev, pos, &val);
+		pci_user_read_config_byte(dev, off, &val);
 		__put_user(val, buf);
 		buf++;
-		pos++;
-		cnt--;
+		off++;
+		count--;
 	}
 
-	if ((pos & 3) && cnt > 2) {
+	if ((off & 3) && count > 2) {
 		unsigned short val;
-		pci_user_read_config_word(dev, pos, &val);
+		pci_user_read_config_word(dev, off, &val);
 		__put_user(cpu_to_le16(val), (__le16 __user *) buf);
 		buf += 2;
-		pos += 2;
-		cnt -= 2;
+		off += 2;
+		count -= 2;
 	}
 
-	while (cnt >= 4) {
+	while (count > 3) {
 		unsigned int val;
-		pci_user_read_config_dword(dev, pos, &val);
+		pci_user_read_config_dword(dev, off, &val);
 		__put_user(cpu_to_le32(val), (__le32 __user *) buf);
 		buf += 4;
-		pos += 4;
-		cnt -= 4;
+		off += 4;
+		count -= 4;
 		cond_resched();
 	}
 
-	if (cnt >= 2) {
+	if (count >= 2) {
 		unsigned short val;
-		pci_user_read_config_word(dev, pos, &val);
+		pci_user_read_config_word(dev, off, &val);
 		__put_user(cpu_to_le16(val), (__le16 __user *) buf);
 		buf += 2;
-		pos += 2;
-		cnt -= 2;
+		off += 2;
+		count -= 2;
 	}
 
-	if (cnt) {
+	if (count > 0) {
 		unsigned char val;
-		pci_user_read_config_byte(dev, pos, &val);
+		pci_user_read_config_byte(dev, off, &val);
 		__put_user(val, buf);
-		pos++;
+		off++;
 	}
 
 	pci_config_pm_runtime_put(dev);
 
-	*ppos = pos;
+	*ppos = off;
 	return nbytes;
 }
 
-- 
2.43.0

