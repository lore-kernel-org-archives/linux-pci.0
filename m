Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF9033E358
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782837083; cv=none; b=PCttzikmnHPkD4u0FjEd+F4ILUMraQcpruBmz85VIW4iFCp9YP9q8EYV1lu/tHoNKiVRNDUA0E3NDs9iZTADIJmefKbDXAFrHMQCY6CHQekfAKwxdBRtu/3DKX+eNm6wuA6QM1dNBbYaB0vvCEM3yxrop4DyB6bAZEC6EJD0hfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782837083; c=relaxed/simple;
	bh=+MLbGBg6dx6C5b9laNIHY4NwBZHulwkmjhIhZZ7+D5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naOb5db20dts0CLuvkx+TTixt3Y/+a7xKHo2YKTiPJ00JHHZR6FJnL5EI3rc8CQPgWgABc8al15IGOvtcipgOPE6DoptMruEShensbNmC4qMWJpH/YQknhjrVFd2JDHEw82ZJyOZlhgIMh0Nx9YtdtcOldg+l3TjG+pDIQmHgf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPTEVPh9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPTEVPh9"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9204711e831so564449885a.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782837080; x=1783441880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV5G6UftBdSN1vSCJ84j0V7cpo0+P26JfYBBOnu2ARo=;
        b=mPTEVPh9yukKljhTe5oVBjlt0DfnKmda85oB3etp8wiCiN0ozyOyYfbcxH9KvNQI4s
         3Kj2LmvSIApHu9+O5lSypbIMH31oUXb5CYyJ9G2m9copwsNt7R/1VkE2LfDr1K80Aslm
         CmaV/ncIfx7X7z2ADNFVW0x9+/OG44sYDaN/KLaT83O7uKEho/76QHhY6QYNoaZbyBWQ
         QGQtT5Ikc4tv35p//i3+NTP9SuCE11DLFkvkE2FRPhYZdDWeuGibNkUBKvLClZMeAE3W
         Am4izEIZz/m3AWS/xX4Dw/n28Hg5SVZpU1P/brf/134YGPqqATbjcbqj5A7XF2A8BIeY
         aMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782837080; x=1783441880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MV5G6UftBdSN1vSCJ84j0V7cpo0+P26JfYBBOnu2ARo=;
        b=cROVd/5TIolxVuvJ4Y62gj9iWYH6DdHEBCVxOuDfNaBSfZi+1PPwY0cRa1vxQyLIAc
         6irUnKB68U6o1ozt/1uG2Yhb0iR4JYnrD8+s6eSqF9UlxMWsAzxyL4haAPkj9GqGd7MB
         xEJnjiyouZeJHqAE3jaBgN1gbpjzX5lXrctXgQ8AJYaTx+g+yM+Jl52oj5GfIOrJcvUy
         fMKPhVT3zG5IbxWStlInG8iZ8uLJRj1HBpX/qnjgCNG+Bc1IbYrLUKwdHus1SPR+K91S
         6OU52IvWD5n8ALLJ7RfPGsrkNhSpTgII+Xk0RxLmWIseFWQPZN8IEy56iPGTlfqjCHx6
         C+vQ==
X-Gm-Message-State: AOJu0Yy/Zrk32lGfCYaa1mlJE4x1CLk8dBa14eRYBpSuo3Nuz/aGPAW4
	76oLww7ku3jygC8jfTzLaFXjj7iDfrDVIdWdLXA7DIhOCXpfLEabuGZdivHWBQ==
X-Gm-Gg: AfdE7clM5LQRUmJL0eMlxBpvPq0jJmIOKoW4SbQEO+dEW2vOG6O77bJAFvD6GCa17kh
	RMd+WfoekSaRr/txM+vxpXCsyHzB4aZIzkglE7DVMhTOgZ7pcAdYKDT9yxi/d9nOJ2KT5NZ3Gye
	TpuL8YfrJFc0moj/6oBipOXUQJGw+Hlt43BNMgsk85+EGbyKbMR4gcubQ+TjrHJ2dUm3kunnVsA
	Y2REfN4UB6Ehe6HCYedHmg4H4AjEbifi63pQpNoM+xvhu7wFcAcCQc8s2J23bz1af17PfNIgyjo
	vdCNiAkMyTu3nd0UZMlxNSg5z16xGmhH+h583OsRWsPayQg5AsPXXvjeYoGhO2sKW0PNsLC3dNH
	AOcruzYumqmv6MZJdGjeX4t2/D+olL+UAMW3/Rqlj9A/s6GAFiOqlMWDiRRrE16Zs18W7zfNnW8
	NOeyHtTOdAiaeFYuC/5dXPeEttZBv3Ut9rvHFLL5+W02ybzUJm8gga
X-Received: by 2002:a05:620a:17ab:b0:92b:81fb:87b7 with SMTP id af79cd13be357-92e6d787a14mr207839685a.13.1782837080130;
        Tue, 30 Jun 2026 09:31:20 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e622e84e5sm290050785a.24.2026.06.30.09.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 09:31:19 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] PCI/VGA: vgaarb: Hold pci_dev references for per-file cards
Date: Tue, 30 Jun 2026 12:30:58 -0400
Message-ID: <86061f17ea5f1fb76791ca5cc787ce84b6752f46.1782788237.git.shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <330FD8DD-ECBF-4531-900E-5B976FA9DF90@gmail.com>
References: <330FD8DD-ECBF-4531-900E-5B976FA9DF90@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VGA arbiter stores pci_dev pointers in each /dev/vga_arbiter file's
private state to track the target device and per-card lock counts.  These
pointers may outlive PCI hot-remove, but the private state did not hold
pci_dev references for them.

After a userspace client opens /dev/vga_arbiter, selects and locks a PCI
VGA device, removes that device via sysfs, and closes the old fd,
vga_arb_release() can still dereference uc->pdev for dev_dbg() and
vga_put().  If the PCI device has already been freed, dynamic debug may
read the freed struct device in dev_driver_string(), triggering a KASAN
use-after-free.

Make each non-NULL priv->cards[] entry own one pci_dev reference.
priv->target is kept only as an alias of a tracked cards[] entry and does
not own an extra reference.  When selecting a target, consume the lookup
reference by either storing it in a new cards[] entry or dropping it if
the device is already tracked.  On release, use the still-referenced
pdevs to clean up lock accounting, then drop the pci_dev references after
leaving the spinlock.

Take vga_lock while converting vga_default_device() into a referenced
pci_dev and while looking up vgadev entries, so the reference acquisition
and vga_list traversal are serialized with VGA device removal.

Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
Closes: https://lore.kernel.org/r/330FD8DD-ECBF-4531-900E-5B976FA9DF90@gmail.com/
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/pci/vgaarb.c | 87 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 70 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index c360eee11dd9..244671d14e08 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1044,6 +1044,58 @@ struct vga_arb_private {
 	spinlock_t lock;
 };
 
+/*
+ * Each non-NULL priv->cards[i].pdev owns one pci_dev reference.
+ * priv->target is only an alias of one of priv->cards[] and does not
+ * own an extra reference.
+ *
+ * On success, this consumes the caller's @pdev reference.  If the device
+ * is already tracked, the temporary reference is dropped; otherwise it is
+ * stored in a new cards[] entry.  On failure, the caller still owns @pdev.
+ */
+static int vga_arb_set_target(struct vga_arb_private *priv,
+			      struct pci_dev *pdev)
+{
+	unsigned long flags;
+	int i, ret = -ENOMEM;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	for (i = 0; i < MAX_USER_CARDS; i++) {
+		if (priv->cards[i].pdev == pdev) {
+			priv->target = priv->cards[i].pdev;
+			ret = 0;
+			break;
+		}
+		if (!priv->cards[i].pdev) {
+			priv->cards[i].pdev = pdev;
+			priv->cards[i].io_cnt = 0;
+			priv->cards[i].mem_cnt = 0;
+			priv->target = priv->cards[i].pdev;
+			pdev = NULL;
+			ret = 0;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	if (!ret)
+		pci_dev_put(pdev);
+
+	return ret;
+}
+
+static struct pci_dev *vga_arb_get_default_pdev(void)
+{
+	struct pci_dev *pdev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&vga_lock, flags);
+	pdev = pci_dev_get(vga_default_device());
+	spin_unlock_irqrestore(&vga_lock, flags);
+
+	return pdev;
+}
+
 static LIST_HEAD(vga_user_list);
 static DEFINE_SPINLOCK(vga_user_lock);
 
@@ -1294,13 +1346,14 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 	} else if (strncmp(curr_pos, "target ", 7) == 0) {
 		unsigned int domain, bus, devfn;
 		struct vga_device *vgadev;
+		unsigned long flags;
 
 		curr_pos += 7;
 		remaining -= 7;
 		pr_debug("client 0x%p called 'target'\n", priv);
 		/* If target is default */
 		if (!strncmp(curr_pos, "default", 7))
-			pdev = pci_dev_get(vga_default_device());
+			pdev = vga_arb_get_default_pdev();
 		else {
 			if (!vga_pci_str_to_vars(curr_pos, remaining,
 						 &domain, &bus, &devfn)) {
@@ -1321,7 +1374,9 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 				pdev);
 		}
 
+		spin_lock_irqsave(&vga_lock, flags);
 		vgadev = vgadev_find(pdev);
+		spin_unlock_irqrestore(&vga_lock, flags);
 		pr_debug("vgadev %p\n", vgadev);
 		if (vgadev == NULL) {
 			if (pdev) {
@@ -1333,18 +1388,8 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 			goto done;
 		}
 
-		priv->target = pdev;
-		for (i = 0; i < MAX_USER_CARDS; i++) {
-			if (priv->cards[i].pdev == pdev)
-				break;
-			if (priv->cards[i].pdev == NULL) {
-				priv->cards[i].pdev = pdev;
-				priv->cards[i].io_cnt = 0;
-				priv->cards[i].mem_cnt = 0;
-				break;
-			}
-		}
-		if (i == MAX_USER_CARDS) {
+		ret_val = vga_arb_set_target(priv, pdev);
+		if (ret_val) {
 			vgaarb_dbg(&pdev->dev, "maximum user cards (%d) number reached, ignoring this one!\n",
 				MAX_USER_CARDS);
 			pci_dev_put(pdev);
@@ -1354,7 +1399,6 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		}
 
 		ret_val = count;
-		pci_dev_put(pdev);
 		goto done;
 
 
@@ -1394,6 +1438,7 @@ static __poll_t vga_arb_fpoll(struct file *file, poll_table *wait)
 
 static int vga_arb_open(struct inode *inode, struct file *file)
 {
+	struct pci_dev *pdev;
 	struct vga_arb_private *priv;
 	unsigned long flags;
 
@@ -1410,8 +1455,9 @@ static int vga_arb_open(struct inode *inode, struct file *file)
 	spin_unlock_irqrestore(&vga_user_lock, flags);
 
 	/* Set the client's lists of locks */
-	priv->target = vga_default_device(); /* Maybe this is still null! */
-	priv->cards[0].pdev = priv->target;
+	pdev = vga_arb_get_default_pdev(); /* Maybe this is still null! */
+	priv->cards[0].pdev = pdev;
+	priv->target = pdev;
 	priv->cards[0].io_cnt = 0;
 	priv->cards[0].mem_cnt = 0;
 
@@ -1422,8 +1468,9 @@ static int vga_arb_release(struct inode *inode, struct file *file)
 {
 	struct vga_arb_private *priv = file->private_data;
 	struct vga_arb_user_card *uc;
+	struct pci_dev *pdevs[MAX_USER_CARDS];
 	unsigned long flags;
-	int i;
+	int i, nr_pdevs = 0;
 
 	pr_debug("%s\n", __func__);
 
@@ -1439,9 +1486,15 @@ static int vga_arb_release(struct inode *inode, struct file *file)
 			vga_put(uc->pdev, VGA_RSRC_LEGACY_IO);
 		while (uc->mem_cnt--)
 			vga_put(uc->pdev, VGA_RSRC_LEGACY_MEM);
+		pdevs[nr_pdevs++] = uc->pdev;
+		uc->pdev = NULL;
 	}
+	priv->target = NULL;
 	spin_unlock_irqrestore(&vga_user_lock, flags);
 
+	for (i = 0; i < nr_pdevs; i++)
+		pci_dev_put(pdevs[i]);
+
 	kfree(priv);
 
 	return 0;
-- 
2.43.0

