Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169ED78F3A
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789968433; cv=none; b=VDFql3jmShDn7+l4AzYR9KX2K/Y87HPMtjmx1xz50s3OJFuGAWttxbkLe/+UiKtqYpr0B8TuHTHYvpWtpyIslBZK1Z0ZQtEHyuyUe9Ocw6tKNJy4NbbMynhpCIrJAFmxCb7v+U4JJnbcZbt6z7nrnP5W4oRbTQAXJXWYvkbNN5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789968433; c=relaxed/simple;
	bh=EWu1pLVFRSaebwmi7fm/KMUICrHPC3ue7UZVQJg/fhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipwG7XT6Gx0InRC3WoSMA/0wWeKA/7ifb9FoqcnDgybmVpcIE77dOo7bJYz7kupGFKCDKVAvv92uSAmad0dFH8vR3IdqCqIoEc8XvLyaq8KH1S1ttUlfBPLrkJHCzm/YvLb9lQuVlvzmovguBUb4ZKxe2PpQXkgOQ9VD0fQkqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLlmAY8t; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLlmAY8t"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso1940723a91.0
        for <linux-pci@vger.kernel.org>; Sun, 20 Sep 2026 22:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789968425; x=1790573225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xz7oDjDIsYHvot04hwnpj8aBarD/yeH6H4D2rmaqZdc=;
        b=jLlmAY8toK3ay6YjxLCbenY4BHriYZL65+6EmqZQPoycLR0fNt9F5euKFcsfs5zKjl
         DEnpk4BpFQu7GCyRbLfRitlWQqwBl7dhptmF5YSsxIarnEucAg6eBL8ADanIfqC/S6+W
         66bj+oI+Ve9VCHx3q6TJGGPxloRvdziynTNv7OquM3iXaK3aVaGf/WuvC2obSgCTRDfB
         Y8yYK/4EqvwtpFBDIqC+1Fmq2xnDCtih0QjVtXldfpAGZOjYP/qwpUufoR7qR1MW4Qvb
         KZgKzfezrgsNwTkeCyAL5/Lw07oHVPV0Cz0Is5t74cVG/o3j8iQfgW86XOfzfF4gdnLw
         RiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789968425; x=1790573225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xz7oDjDIsYHvot04hwnpj8aBarD/yeH6H4D2rmaqZdc=;
        b=LhdDq/uyefYRyzMU9AZ8m2ActtzgBYiIJRalaxLoMb4lrtWkhNHjGIra++OL7swGCw
         cnv/SiarRpjKjoDok3nH30nj0NtB0H+Xes9sflnohd9O5GZfESx2dnyE/r5ZOpanz5Bj
         k2IjQrr5tP8uxU9L9hrTdAePn2lDNthTs0Vr9+/k/jNTWg8PQN4Bvfl/PJYaOV/5tP7X
         0REX4pPQZ3qy1TUrAVCb18nF+2CqBOaUnKJUc19z41zXfii+vAY+enmVRJ+nU4bn2KZP
         wrOHEmsxpiYfRiJdAnTxP+qqEWF4fbCtarxJloVX3LLWJ1igdByNdy54mGe57F1aom5b
         kdEA==
X-Forwarded-Encrypted: i=1; AKwUvBzzc5zHQv6Lfufb0ajBwAg9SoYiYWzaGDjaIorQt+ZufSr/gopNUP28RxAes/GuLaHXhS9BEgLtkmI=@vger.kernel.org
X-Gm-Message-State: AFuF++mnO36/tA0am6H79f1Lg/whEwMbCoVMdi7cR6Cg6hCV2FnuBayG
	HxwgiD72Wo2hbh6u6QbWoRKjOkcvFhfChlDxSVOXyC3Dj0lGWtP5NPqp
X-Gm-Gg: AYBFou1l1GnPPjh3Zf1nzEG4Z51OqoV0GWIbry35dWDBOhGzrBAFpRgUicbynos8SzA
	kWXNl+ZPNZwbG+3/zZoQ1ayMb5lhxsFoiHEV1m9H38qS2o54gU1vtNJzpV18T6kDFPy8s9/Ol6v
	cXfe41dk83LsYoGU6JzjSJTSz25bp0yvW9Tecv5ADrLdizcuE254fmLtFcMxhbyq4PQ/QyCJCpJ
	SOBCoOCIQRGZp7OgPE+0PLwz+f+HjcMhND4UdBTzhNWxqD00fEHt2Xk8DZV5VSM9Li5xW5hc41Q
	wHDsbQLwcrXTIAJwJmndnRdjaX4w1TvSKQF7UzkqgBbkTP0bmEFBNTY2kc/xjgGYfpNEMMFsPHS
	AH4SuPWxBxi4E64CmJjXd2wkCH1AU9qFyy3Vre3HuPh+A0hkf11stJbBo0kBms9MZGHUpufP16b
	C8BCbhcCcZAR0mNeyaWacQJ0wLEF2JXeed0kJehWkvZmSiubXMZN7kdXM/vVjVgQEUcl50Xuvig
	2sFmZkmgpK0+aoXvSKHd4F1ObjWdDZcslhwtt3IN+hESt6zpyx+Om+vOvGiAAYyzygpBlJNg/Lg
	ueDi/YlySQ==
X-Received: by 2002:a17:90b:554b:b0:39e:6c6a:6574 with SMTP id 98e67ed59e1d1-39e6c6a6819mr9043191a91.55.1789968425257;
        Sun, 20 Sep 2026 22:27:05 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e554e5529sm6677054a91.4.2026.09.20.22.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 22:27:04 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: bhelgaas@google.com,
	airlied@redhat.com
Cc: benh@kernel.crashing.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	benquike@gmail.com
Subject: [PATCH v2 2/2] PCI/VGA: invalidate open user references in vga_arbiter_del_pci_device()
Date: Mon, 21 Sep 2026 05:27:02 +0000
Message-ID: <20260921052702.1725696-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260921052702.1725696-1-benquike@gmail.com>
References: <20260919222629.3798073-1-benquike@gmail.com>
 <20260921052702.1725696-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PCI VGA device is removed while /dev/vga_arbiter is open,
vga_arbiter_del_pci_device() removes and frees the vgadev entry, but any
open struct vga_arb_private on vga_user_list retains dangling pointers to
the removed pdev in priv->target and priv->cards[i].pdev. Subsequent writes
to /dev/vga_arbiter or closing the file descriptor in vga_arb_release()
dereference the removed pdev.

Mark matching priv->target and priv->cards[i].pdev entries as
PCI_INVALID_CARD under vga_user_lock in vga_arbiter_del_pci_device(), and
treat PCI_INVALID_CARD like NULL in vga_arb_write() and vga_arb_release().

Tested in QEMU against Linux 7.3.0-rc3 by opening /dev/vga_arbiter,
selecting PCI:0000:00:02.0, hot-removing the PCI VGA device via
/sys/bus/pci/devices/0000:00:02.0/remove, and writing "unlock io+mem".
On the unfixed kernel, priv->target retains a dangling pointer to the
removed pci_dev so write("unlock io+mem") proceeds past the NULL check
and returns -EINVAL (-22); with this patch applied, priv->target is set
to PCI_INVALID_CARD on removal and write("unlock io+mem") immediately
returns -ENODEV (-19).

Fixes: deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out from the vga_tryget() return check fix into patch 2/2.
- Update Fixes: tag from the file-move commit 1d38fe6ee6a8 to
  deb2d2ecd43d ("PCI/GPU: implement VGA arbitration on Linux").

 drivers/pci/vgaarb.c | 71 +++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 350ab9624eb9..4f13e542505a 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -818,11 +818,33 @@ static bool vga_arbiter_add_pci_device(struct pci_dev *pdev)
 	return false;
 }
 
+#define MAX_USER_CARDS         CONFIG_VGA_ARB_MAX_GPUS
+#define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
+
+/* Each user has an array of these, tracking which cards have locks */
+struct vga_arb_user_card {
+	struct pci_dev *pdev;
+	unsigned int mem_cnt;
+	unsigned int io_cnt;
+};
+
+struct vga_arb_private {
+	struct list_head list;
+	struct pci_dev *target;
+	struct vga_arb_user_card cards[MAX_USER_CARDS];
+	spinlock_t lock;
+};
+
+static LIST_HEAD(vga_user_list);
+static DEFINE_SPINLOCK(vga_user_lock);
+
 static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 {
 	struct vga_device *vgadev;
+	struct vga_arb_private *priv;
 	unsigned long flags;
 	bool ret = true;
+	int i;
 
 	spin_lock_irqsave(&vga_lock, flags);
 	vgadev = vgadev_find(pdev);
@@ -845,6 +867,21 @@ static bool vga_arbiter_del_pci_device(struct pci_dev *pdev)
 	wake_up_all(&vga_wait_queue);
 bail:
 	spin_unlock_irqrestore(&vga_lock, flags);
+	if (ret) {
+		spin_lock_irqsave(&vga_user_lock, flags);
+		list_for_each_entry(priv, &vga_user_list, list) {
+			if (priv->target == pdev)
+				priv->target = PCI_INVALID_CARD;
+			for (i = 0; i < MAX_USER_CARDS; i++) {
+				if (priv->cards[i].pdev == pdev) {
+					priv->cards[i].pdev = PCI_INVALID_CARD;
+					priv->cards[i].io_cnt = 0;
+					priv->cards[i].mem_cnt = 0;
+				}
+			}
+		}
+		spin_unlock_irqrestore(&vga_user_lock, flags);
+	}
 	kfree(vgadev);
 	return ret;
 }
@@ -1025,27 +1062,6 @@ EXPORT_SYMBOL(vga_client_register);
  * the arbiter.
  */
 
-#define MAX_USER_CARDS         CONFIG_VGA_ARB_MAX_GPUS
-#define PCI_INVALID_CARD       ((struct pci_dev *)-1UL)
-
-/* Each user has an array of these, tracking which cards have locks */
-struct vga_arb_user_card {
-	struct pci_dev *pdev;
-	unsigned int mem_cnt;
-	unsigned int io_cnt;
-};
-
-struct vga_arb_private {
-	struct list_head list;
-	struct pci_dev *target;
-	struct vga_arb_user_card cards[MAX_USER_CARDS];
-	spinlock_t lock;
-};
-
-static LIST_HEAD(vga_user_list);
-static DEFINE_SPINLOCK(vga_user_lock);
-
-
 /*
  * Take a string in the format: "PCI:domain:bus:dev.fn" and return the
  * respective values. If the string is not in this format, return 0.
@@ -1168,7 +1184,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		}
 
 		pdev = priv->target;
-		if (priv->target == NULL) {
+		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
 			ret_val = -ENODEV;
 			goto done;
 		}
@@ -1215,7 +1231,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		}
 
 		pdev = priv->target;
-		if (priv->target == NULL) {
+		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
 			ret_val = -ENODEV;
 			goto done;
 		}
@@ -1266,7 +1282,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		 */
 
 		pdev = priv->target;
-		if (priv->target == NULL) {
+		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
 			ret_val = -ENODEV;
 			goto done;
 		}
@@ -1335,7 +1351,8 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		for (i = 0; i < MAX_USER_CARDS; i++) {
 			if (priv->cards[i].pdev == pdev)
 				break;
-			if (priv->cards[i].pdev == NULL) {
+			if (priv->cards[i].pdev == NULL ||
+			    priv->cards[i].pdev == PCI_INVALID_CARD) {
 				priv->cards[i].pdev = pdev;
 				priv->cards[i].io_cnt = 0;
 				priv->cards[i].mem_cnt = 0;
@@ -1366,7 +1383,7 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 			goto done;
 		}
 		pdev = priv->target;
-		if (priv->target == NULL) {
+		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
 			ret_val = -ENODEV;
 			goto done;
 		}
@@ -1429,7 +1446,7 @@ static int vga_arb_release(struct inode *inode, struct file *file)
 	list_del(&priv->list);
 	for (i = 0; i < MAX_USER_CARDS; i++) {
 		uc = &priv->cards[i];
-		if (uc->pdev == NULL)
+		if (uc->pdev == NULL || uc->pdev == PCI_INVALID_CARD)
 			continue;
 		vgaarb_dbg(&uc->pdev->dev, "uc->io_cnt == %d, uc->mem_cnt == %d\n",
 			uc->io_cnt, uc->mem_cnt);
-- 
2.49.0
