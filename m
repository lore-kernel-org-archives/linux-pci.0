Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37630ACF1;
	Tue, 14 Apr 2026 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133352; cv=none; b=dnWyOfK9RupoznC9XgWbVv2CM+ntkAxqW2066ujxJI+We+jNb/eZKzxTpYL5spl5jcjB9+O7FndlYw5zTor9B2jYz9msPsBBEFUHBkA9PNH/DKHXVO8UB+mG29X4Wq9L53wAVpjhvbNS8qGY7SjkC5zGt9qQhXibzOhOXvwhdLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133352; c=relaxed/simple;
	bh=gLbu8vV6zSfCb2K3PXxLXG24R45tEvAkDPA1Z9QOjU4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQIPQji23CzHabkYvVlcUFPoz1tTCZs2AKUsrKdD6Ahbn/WRVGdTQhra2xpu5neyMxAWzLEPCpQKm6EL3nygp3HH62Ma94lsqYCmYpLSnLEEDORJf5cP2LQ9Z7TGiZCCwKy/LnS1NJqTzB62BnbDPUQWYH+KvdV1NWSs3spodeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g7CCuyJR; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="g7CCuyJR"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TcGN3KT4A6NaI0fC1ZrfIs//CROmnI9Y++uz8C6hcO0=;
	b=g7CCuyJRfXZEPycaDlHO/eDtVqTu6bJ7MdFAUwDzIlVDFyAsWMYCZ0f07yr+ZXXcGW1BVSWxs
	MuLpUT1Wp9K8goDnUy/4k0lh3kHnOARQENoMNTr4CLykLRcZep5VRpEPPIBv4jZcmDhi6NFOCeS
	562i9/cH8ayip95FFyHzwiM=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fvnvC1MnSznTXb;
	Tue, 14 Apr 2026 10:16:07 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id DEC5940565;
	Tue, 14 Apr 2026 10:22:25 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 10:22:25 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH 1/4] PCI: Align proc_bus_pci_write() with pci_write_config()
Date: Tue, 14 Apr 2026 10:45:41 +0800
Message-ID: <20260414024544.2975605-2-duziming2@huawei.com>
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

proc_bus_pci_write() and pci_write_config() implement essentially the
same functionality. To improve consistency across the PCI subsystem,
align the implementation in procfs with the sysfs counterpart.

Specifically:
  - Use dev->cfg_size directly insted of assigning it to 'size'.
  - Rename the variable 'pos' to 'off' and replace 'cnt' with 'size'.
  - Remove the redundant bounds check `if (nbytes >= size)`.

No functional change intended.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 57 +++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index ce36e35681e8..ff5e4980c99c 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -113,73 +113,72 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 {
 	struct inode *ino = file_inode(file);
 	struct pci_dev *dev = pde_data(ino);
-	int pos = *ppos;
-	int size = dev->cfg_size;
-	int cnt, ret;
+	int off = *ppos;
+	unsigned int size = nbytes;
+	int ret;
 
 	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
 	if (ret)
 		return ret;
 
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
+	while (size >= 4) {
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
 	i_size_write(ino, dev->cfg_size);
 	return nbytes;
 }
-- 
2.43.0

