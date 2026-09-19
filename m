Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB239F162
	for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856793; cv=none; b=RtyZ1agX54XQS6sC7DheouaFWThL4lrL1p5+eCeeAgGxzbVidboQokt3kfCWZBGF0/+JqWmWY3QQwoInGpJmPoOwZuFHgyFEdIlUsMima/WgMFMrpEv2lMgNZTsyLvkd4C5mDuL31oZvwJLhZfdzxIS4Z+P8loUbPnXSdbd5AMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856793; c=relaxed/simple;
	bh=H4IosnsmrbIdD2WnNrn/Jl69BS84apXNa6SmRDl/rRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RB1FR8iO6uuStuzePCI28ZmVBcDbX8cnJjvtbib7sAKW8pFB+haqAnRO7Hm1wPWrGc/IMBirOEo6t4ejkxIz5fTVZMtWhjNvKC3V9CHj+qsxhVHXmTA2ROkQ/hqUVIHxLc4zVA7TWU3KIqAzC2wBasaP4FeP6n1FTstZUEcsPJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhIR2u4c; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhIR2u4c"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba91so1278928a91.1
        for <linux-pci@vger.kernel.org>; Sat, 19 Sep 2026 15:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856790; x=1790461590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6R3voHmBzh4lvqv8peZSsVk4sFxcqioiBA0aCjPm9Mc=;
        b=KhIR2u4cBTBfmxauLrScUr14LarTQtuOGJt1vo8tu940A2qyyHcTt/YqkJsVP0BkkM
         UVMYB+eJ3M/Q2bN11fkdqoEZmJsFVwbZFX2jtvgSWqPzgf6bcBILmLsKhrIlF5jUglis
         DF/pmg4CsK4YgHJC9i5rItGiUbFHzOnV/ux1aiPFxnfk6gVzHJTBazNMkm0IKpvKibhd
         1xkb4yfZtZM3t48tG1paNBUjTkKtb/nY7gSE10fRAeOL+6xHenOx2ph7DhUCM9TlJsgC
         tMHrWGI2llZFv27rQjhK0eMGNydH27S14PT43R6pQAbwdt9Cbb5toU3rCS8gPd/U8BeU
         l6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856790; x=1790461590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6R3voHmBzh4lvqv8peZSsVk4sFxcqioiBA0aCjPm9Mc=;
        b=F/KakOKqGDStcSltCAIMfaiZIXxyLpwb8KOAbjhtJNsPCaZHTXrv45u0AbJdXSRklm
         9g3wNdELSvVQXAe2DMTQmRHZcaOC8OtC/Ik4syWnqk7/4tp1vK0B4QDGAcURlfRoUe/3
         GUpvSb63PBoYTM1cJe6Z8xFteNIk5ERagER8HALaHzXZ0bmiRhSwQVRa+wOba4WexjKA
         rKmCRGmeppA8CpPykjAF8BjeGPxu4C/NaMdgoEEHy420Kp7uB7275fxhGRmpuXKwIQVj
         nTbvGyF+TYrjHaePWVyrkY8tJZblf7yjPVqSpgfvUUxRsSDS+DubjL4ehSuVV+sM1gvc
         VO/Q==
X-Gm-Message-State: AFuF++mRBZT4McOPzAVW97BM/I4FSaDIBiBFuo4S3c5NCMhIOr/GKB3u
	QvOfzwNLFjyNHraaLBTrrh8paCPYJRSTN/51lOnpx+pbjb06QpMWg56U
X-Gm-Gg: AYBFou2Q745qn9qjptQ59e8ieraYDWf3Qw/ioYnziYIe16fdHD5K8BP6tto+3ONE7ij
	PIbAAXQ/gZxDc3ltdR5BQjQPMm40izKBGsbEsJ5htUP6cqH4GP5rZcIVVnPCKa5KoPLvfa3bv6x
	Qv+M//bywrgrE2XAjrcM/T/KQ1iyLQZLDYNrkew+Yu654Rz2VSUntak8kUg4Qqe/cUmb2rUOPMm
	LNAjKaRWl/HTmjF7qqeTGbmR8rY4xf8zbv17U8Mh8lN4u7EMeh0tAANlISrlmyXaMxHVVeumwIL
	KXpzMtf2drcCLryCkVFhbfbTOuVcAqd3vv1cFvEd0erqNFTRKvS3zkKUqdAhbwn/4TB5AEdZQWA
	t/UErwes2lrOHsCitD/SfwdfnXW4mhPumgMrshXtljhw1JV4bdITlDPl/70UMOaRnNSJleqQL95
	Nlzlik44t6a8J5w0ueDJzJKM2ckD/L7YQtbkitYcI2l0nUGSQfkF+x/Y1r+rrMady+FpJBT3lv2
	SD4EYHHwwRg90PaPhxWpFxVFoXslIYFedytf1jXOKCw3rvovTSEvb9Mjyw474UtDCQSfCEFjSTC
	tH0xvjpHIQ==
X-Received: by 2002:a17:90a:cf0c:b0:39e:6c6a:20a1 with SMTP id 98e67ed59e1d1-39e6c6a22aamr3921834a91.66.1789856790138;
        Sat, 19 Sep 2026 15:26:30 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca4ef3esm6351460a91.1.2026.09.19.15.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:29 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: bhelgaas@google.com,
	airlied@redhat.com
Cc: linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/VGA: fix inverted vga_tryget() return check and clear removed pci_dev
Date: Sat, 19 Sep 2026 22:26:29 +0000
Message-ID: <20260919222629.3798073-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two issues in drivers/pci/vgaarb.c:

1. In vga_arb_device_init() / vga_arbiter_From_pci_dev(), vga_tryget()
   returns 0 on success and a negative errno on failure, so checking if
   (!vga_tryget(...)) is inverted and skips unlocking on success.
2. In vga_arbiter_del_pci_device(), clear any open vga_arb_user_init
   priv->target references pointing to the removed pci_dev so subsequent
   writes or close() on /dev/vga_arbiter do not dereference a freed
   pci_dev.

Fixes: 1d38fe6ee6a8 ("PCI/VGA: Move vgaarb to drivers/pci")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3de05aee7859..4f13e542505a 100644
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
@@ -1266,12 +1282,12 @@ static ssize_t vga_arb_write(struct file *file, const char __user *buf,
 		 */
 
 		pdev = priv->target;
-		if (priv->target == NULL) {
+		if (priv->target == NULL || priv->target == PCI_INVALID_CARD) {
 			ret_val = -ENODEV;
 			goto done;
 		}
 
-		if (vga_tryget(pdev, io_state)) {
+		if (vga_tryget(pdev, io_state) == 0) {
 			/* Update the client's locks lists... */
 			for (i = 0; i < MAX_USER_CARDS; i++) {
 				if (priv->cards[i].pdev == pdev) {
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
