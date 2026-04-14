Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7E730B521;
	Tue, 14 Apr 2026 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133352; cv=none; b=bqXz+8FQ9wM5fpFQmcDp8787L8LLYa0lHe2VgK8nIlC5Xc5OA7MIuyCoDZyi4uYc4PSW5YzWFr4739bb0P9y2EaYqu5V2/6aOU6AihBHemiM434lKObBlp6qy1gU7+FFJtcrGagJk3LorSI3NHyhoBmxKanOMCn4zdoUs+gSMfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133352; c=relaxed/simple;
	bh=OYkLhFwawqdifqFscbU3VrkupspsrT9kdrl8ENlfcaA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClifDsAAx3srE01Wr6DBASwg0hAlcEX2iwJ5YjqeU/2nRCnehOgTPQdBwgPSgBHnpVQbjc/wanYdMLF29QKZQDmE+VLPa0uizYx6p5G88GjS0T6xLohzfaAixDhPkRRdiqSmb4EdNgd2RuQT3IcC3GuD/GSUkV10/5Wc6gejX5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3oJ7rQSZ; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3oJ7rQSZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3CqcaT1vZ2gMe5Cbby6fLwgvxf74pWm2QxJf1ILn2LM=;
	b=3oJ7rQSZsri+ydi0m7rb2IRDNY3IYhS0SKZGz0K1SsEp4vKU8fQ+H6Umdcme34/L4QeHSOVM7
	0t7xwaBkU6jW6sK7bX2LWEqyHsiisuI+jnKwNdKDv/n4l+TuFFHatOWDdDE31/y/oAgy18ex0Vl
	Q45+0eHJH1WRTBUlPOoKABc=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fvnvF3PZrz1cyPZ;
	Tue, 14 Apr 2026 10:16:09 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B8B740539;
	Tue, 14 Apr 2026 10:22:26 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 10:22:25 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH 2/4] PCI: Align proc_bus_pci_read() with pci_read_config()
Date: Tue, 14 Apr 2026 10:45:42 +0800
Message-ID: <20260414024544.2975605-3-duziming2@huawei.com>
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

proc_bus_pci_read() and pci_read_config() implement essentially the
same functionality. To improve consistency across the PCI subsystem,
align the implementation in procfs with the sysfs counterpart.

Specifically:
  - Rename the variable 'pos' to 'off' and replace 'cnt' with 'count'.
  - Remove the redundant bounds check `if (nbytes >= size)`.

No functional change intended.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 58 +++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index ff5e4980c99c..6524280bc903 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -29,8 +29,9 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 				 size_t nbytes, loff_t *ppos)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
-	unsigned int pos = *ppos;
-	unsigned int cnt, size;
+	unsigned int off = *ppos;
+	unsigned int count = nbytes;
+	unsigned int size;
 
 	/*
 	 * Normal users can read only the standardized portion of the
@@ -45,66 +46,65 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
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
+	while (count >= 4) {
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
+	if (count) {
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

