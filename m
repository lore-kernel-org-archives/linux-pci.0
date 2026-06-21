Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E3C4964F
	for <linux-pci@vger.kernel.org>; Sun, 21 Jun 2026 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021033; cv=none; b=t8qekif2xkgB2y5D4W5FBLHdAKlCeCYrNYwwcoZo6PFPswOzzsSSaLhjUDGlL6SkdD8VPCrVoVHMDaBg6PSbQts2Z9vPo6lDisAA/MyTnVkXpfMeIvoc+OIghGStaXkOvjqqtJiux1WW7JC0lFDcRJS1Gs6XlozYik9l+IevGmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021033; c=relaxed/simple;
	bh=Fovflc0B6PKhfGgMlDjeF2zarUq2bNe618l4HX19CiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CqOFVP7eh52nKRhJ+v/7NlBImmA84q4+K7ll59trCcvdgt2FVw0c+XOJYFt9qi9r1Vwp/bhIV+ibJjgy5MmnQjJmG6e+1omyaDNO+Opm2Qgw4cT5xsoCpXjSoc4jj/sg7cr3F/Gut1F0JeyVcF+PHrc5CruGQqr2lgiFhbmV/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzxeNF5B; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzxeNF5B"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-519fa6d7a78so20543221cf.1
        for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 22:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021030; x=1782625830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiwKCU4SFJw5tmeTpkfyFxHEO3HBV3wZDQlSc0QsaLE=;
        b=KzxeNF5BNH7RD1ib7FEWM9BiQr25Yd8bvvt8OmKKmkpoBx7sw1uT1bmh8IwIb7xc+W
         vbSiDkYpdoG/OcMMLc09FMaJ2ShxwrFScRQdHsrr2ymNVUm6fJOFLTSFnxfudWIurPEI
         tAKlQwWy3fimDImNEF9jXnyDJomxGikc7lrsSjUmQ2wTxgssGc8MudX4flJze0vB+F6t
         DWBSsyzM/go270dbjGDVOUtrr1rz8bBgMUv+fbPw0tit1T/NJyTnU1FKB7vbbdYX+6+b
         jH1iYG5jL+GOg3sTehIZFiV/vOtI0hqvTCrVoecqPb1YmA2BcJ6w5yXTV0Soa54ANUX6
         MnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021030; x=1782625830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiwKCU4SFJw5tmeTpkfyFxHEO3HBV3wZDQlSc0QsaLE=;
        b=UPs5r/BvLzpNRPoPoBgkgoVarqvVIvafPP7hZsJCVpU1H85S2YnTBTovoBKCsiqvr1
         kNNvH/DSTh+GQN8Nwb16r0aqEhJffir9WxIOSRN1hVpsqzAGnKOLKf0H2klNRuMQE9CC
         8CABa3RsqDykHo8W/twK5Dvap1b8r/ZGhvdYdKorwnsNbPj4jQnByJtK+oBBgaQmkBVy
         Z7BCpSO6RL+deG33EmAZF2jqNxpR9FkkXfR/QO3A6Z8OBQyWAJSlR57kBwdkTYpyRBcF
         SS4CwtMX0LWLfA3fsw05viirdzJuHY8iyXmWXQH1Rykht+PmempAWf6GQkPW3PJ6PSoe
         rGQg==
X-Forwarded-Encrypted: i=1; AFNElJ81Lgt5VqOKf7/k9uRHpZp7ozGpYx1CrgamKEmFQIBNN9yV6CR7ajXvsUiNECuBt+wTvWmHELCI9Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjBT3F3ZDaY/Vuboh2isL2w0fqnidpaJtAhcU5Gx1cgsAffHJy
	TIWHK0q+tdzMlheUrR0Oc8nU0PJIhxjgqg0x1r3kyFxIcibEUErQiRi8
X-Gm-Gg: AfdE7cmtrl8B9mTTQBH2We8VL2OEdfVCWgFPa3k16dTSaGLr/cXgEDCUUdER41s2gql
	1Pcufm4LNr33iSQN3R+QfuJ0iFdKacu4ngbxOOUxX5+om4YBZeMmauMdVMU6GP1drE3Y1OpNei8
	r2m1wme6jupf7RAmuKj4yh3SLKb5RZopg4oYF7hvazdhRc8+d11Ufmk5HYJObmqj5UZEgJoyJ9u
	zVrLIkrvVLrzc+GXArYqKBdLHBEYA6b87+1BsZGVif65DBrv0qE21uaF3gWwZ2xftNxjz6TmY4a
	Vjo1QHExS9n5HPZkd0hgqYWe9XAcW0tYonpnBuPKkosi6UccnxMRUWOZsfSVmRG3L5Vq+kUePmL
	rS988qmPTPWyKApMpcmz6nTSTThSC1f+KSTOPDjIYmhJyQrvnkrmrX6aI7lzmzpz2DwI2mpwElS
	XSmcNbX0g23k9eEyP5gFm0MoyWG9wjrXhPwETCJgdklg==
X-Received: by 2002:a05:622a:2c9:b0:517:8da1:4d4 with SMTP id d75a77b69052e-519f04dab2amr125142381cf.46.1782021030158;
        Sat, 20 Jun 2026 22:50:30 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a0c7ef4f3sm31795531cf.18.2026.06.20.22.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:50:29 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: mani@kernel.org,
	kwilczynski@kernel.org
Cc: kishon@kernel.org,
	Frank.Li@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] misc: pci_endpoint_test: fix use-after-free after device unbind
Date: Sun, 21 Jun 2026 01:46:09 -0400
Message-Id: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <178144969601.60470.7358419009914000395@gmail.com>
References: <178144969601.60470.7358419009914000395@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An open miscdevice file descriptor can outlive the PCI driver binding.
misc_deregister() removes the device node and prevents new opens, but it
does not revoke file descriptors that are already open.

Before this change, pci_endpoint_test stored the miscdevice inside struct
pci_endpoint_test, and ioctl() recovered the test object from
file->private_data with container_of(). Since the test object was allocated
with devm_kzalloc(), it was freed when the PCI device was unbound. A
process could therefore open /dev/pci-endpoint-test.N, unbind the PCI
device through sysfs, and then issue an ioctl on the stale file descriptor,
causing a use-after-free of struct pci_endpoint_test.

Manage the test object lifetime explicitly. Allocate it with kzalloc_obj(),
add a kref, take a reference from .open(), and drop it from .release().
The remove path deregisters the miscdevice to stop new opens, serializes
with ioctl using the existing mutex, releases the PCI resources, clears
test->pdev, and drops the initial reference. Already-open file descriptors
then keep the test object alive; subsequent ioctls fail with -ENODEV
instead of touching released device resources.

Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/all/178144969601.60470.7358419009914000395@gmail.com/
Suggested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/misc/pci_endpoint_test.c | 61 ++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index dbd017cabbb9..981a834ce41b 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/kref.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -136,6 +137,7 @@ enum pci_barno {
 };
 
 struct pci_endpoint_test {
+	struct kref	kref;
 	struct pci_dev	*pdev;
 	void __iomem	*base;
 	void __iomem	*bar[PCI_STD_NUM_BARS];
@@ -143,7 +145,7 @@ struct pci_endpoint_test {
 	int		last_irq;
 	int		num_irqs;
 	int		irq_type;
-	/* mutex to protect the ioctls */
+	/* mutex to serialize ioctls and removal */
 	struct mutex	mutex;
 	struct miscdevice miscdev;
 	enum pci_barno test_reg_bar;
@@ -157,6 +159,15 @@ struct pci_endpoint_test_data {
 	size_t alignment;
 };
 
+static void pci_endpoint_test_free(struct kref *kref)
+{
+	struct pci_endpoint_test *test = container_of(kref,
+						     struct pci_endpoint_test,
+						     kref);
+
+	kfree(test);
+}
+
 static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
 					  u32 offset)
 {
@@ -1141,10 +1152,15 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 {
 	int ret = -EINVAL;
 	enum pci_barno bar;
-	struct pci_endpoint_test *test = to_endpoint_test(file->private_data);
-	struct pci_dev *pdev = test->pdev;
+	struct pci_endpoint_test *test = file->private_data;
+	struct pci_dev *pdev;
 
 	mutex_lock(&test->mutex);
+	pdev = test->pdev;
+	if (!pdev) {
+		ret = -ENODEV;
+		goto ret;
+	}
 
 	reinit_completion(&test->irq_raised);
 	test->last_irq = -ENODATA;
@@ -1206,9 +1222,30 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
+static int pci_endpoint_test_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *miscdev = file->private_data;
+	struct pci_endpoint_test *test = to_endpoint_test(miscdev);
+
+	kref_get(&test->kref);
+	file->private_data = test;
+
+	return 0;
+}
+
+static int pci_endpoint_test_release(struct inode *inode, struct file *file)
+{
+	struct pci_endpoint_test *test = file->private_data;
+
+	kref_put(&test->kref, pci_endpoint_test_free);
+	return 0;
+}
+
 static const struct file_operations pci_endpoint_test_fops = {
 	.owner = THIS_MODULE,
+	.open = pci_endpoint_test_open,
 	.unlocked_ioctl = pci_endpoint_test_ioctl,
+	.release = pci_endpoint_test_release,
 };
 
 static void pci_endpoint_test_get_capabilities(struct pci_endpoint_test *test)
@@ -1241,10 +1278,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	if (pci_is_bridge(pdev))
 		return -ENODEV;
 
-	test = devm_kzalloc(dev, sizeof(*test), GFP_KERNEL);
+	test = kzalloc_obj(*test);
 	if (!test)
 		return -ENOMEM;
 
+	kref_init(&test->kref);
 	test->pdev = pdev;
 	test->irq_type = PCITEST_IRQ_TYPE_UNDEFINED;
 
@@ -1263,7 +1301,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	ret = pci_enable_device(pdev);
 	if (ret) {
 		dev_err(dev, "Cannot enable PCI device\n");
-		return ret;
+		goto err_kfree_test;
 	}
 
 	ret = pci_request_regions(pdev, DRV_MODULE_NAME);
@@ -1349,6 +1387,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 err_disable_pdev:
 	pci_disable_device(pdev);
 
+err_kfree_test:
+	kfree(test);
+
 	return ret;
 }
 
@@ -1364,10 +1405,13 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	if (id < 0)
 		return;
 
+	misc_deregister(&test->miscdev);
+
+	mutex_lock(&test->mutex);
+
 	pci_endpoint_test_release_irq(test);
 	pci_endpoint_test_free_irq_vectors(test);
 
-	misc_deregister(&test->miscdev);
 	kfree(misc_device->name);
 	kfree(test->name);
 	ida_free(&pci_endpoint_test_ida, id);
@@ -1378,6 +1422,11 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	test->pdev = NULL;
+	mutex_unlock(&test->mutex);
+
+	kref_put(&test->kref, pci_endpoint_test_free);
 }
 
 static const struct pci_endpoint_test_data default_data = {
-- 
2.34.1

