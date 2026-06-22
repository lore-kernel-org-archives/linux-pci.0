Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46831326A
	for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 16:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147241; cv=none; b=Q59GMPZByE/tWxiaGC5pVmPNk0LZoHaN8tqtN7fyJGKAJqFEJyA7JqCam2EFCcODC70Oxub1sRdo/l6iEpcuR2LorJjMBRNDry4htc7/XqxWRvtICDjiBuvyO33jFTO4A+rfqFIS0aLOP+7UBq3WuMdtdyKNitT8xnZ7xdcIh/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147241; c=relaxed/simple;
	bh=EECPPBmKzX4/GJTRWhYwUfypjfofSmAiVIv3UE5/xwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KY4r5vCUujnHycGnc6iXYsNUBs02xyd91Rl/iYz5MgAqzuWXZrw+xldfE3vm878QGAkZc6h/FccmZBacODMM9byeqxvf2PUKPflMtzHSabjjfSOoMiHX+SDXv31VNDdLjGTr0HeUOb6urn7gcZ+PyJNR8QqytgV8kjmCNJ+LENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHvnc24e; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHvnc24e"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-922e181f199so154783785a.3
        for <linux-pci@vger.kernel.org>; Mon, 22 Jun 2026 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782147239; x=1782752039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPNUZEr1ZzUszqFMAk/YzXMko2PAyEaHktUdl1yZTKw=;
        b=QHvnc24eBJqc/oh6TVxoOZA+QG24RaUdyDbfLm1iTKHgbA6ew/B5PUDN5i6Z2rKGTa
         N5ALlbkiSFQOpzoVQ+PpjGJ+ymMzPW8V/A76gKbdR5POLwL9oV2t1JJMPDF+i6Ymh3NP
         PcCmXL64SMlE8Nup4HzBrKOXs9hCLLCUF4dXZoFj2vesXhIi8J0kXur35qeRd5oTAtbO
         BrQalxQNv2Jn+cmAw5AVEUs0cwaKKleQqpfGMt3YYBSx4L6dyR+9hIJfUbZ6oYVu/B0R
         I+pSaBv6oc2vnCZ2MRMHGxtvB85VPg+TsmJjOpOSHocSjsjKJ9p3SE3i+emkqVR/mZUX
         pRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782147239; x=1782752039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OPNUZEr1ZzUszqFMAk/YzXMko2PAyEaHktUdl1yZTKw=;
        b=BNrd8HhntAeWK4X/Un3E8Piiu8e6EQfLI0NDjQbHN68fnOFcBOyKoSUGot0XsQUKzz
         6m62dFMzl+CCpyWy+0iO7K+O0dNLtYvw5N25CcvaKvd+z9WsdrDt8V85nvCl4fKc0lRh
         63edAxOxhxYCmmc/wfyRN+rgH/RPkGepQ3rZjDZ12qwj5WdFnoZXjb9tn8WQaPnzCn5t
         ZSoPf0kcmhE8XVtgzipLRQu2LWgsEG6LVoKgUwFRwTnCP1E8huj92EWKweChA0nkfhdg
         XvK1nEEPy6rIMfPm4dtuBlAz+ZzI8erW1urKkOvpiLHoFzCeVyPHEE4VQyC3h8MyojMZ
         sCBw==
X-Forwarded-Encrypted: i=1; AFNElJ/tLszNb+bQu38xD7ElTB7L2ZoWZ2cWzKMjKBsV0Bsy/L8ogJvg1iluuEFapLvSPDCzufVEOcZ6pe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+n9r6xyzRx8SJTVgFX0rzq+JzdWmdtNRSX04uIiAqA2e4OKLD
	BEAPwjAgZ1TB6EOYBHxNvB8/LtjbM9lqzWwopUc4YyH5u7ZqHt1N1UUB
X-Gm-Gg: AfdE7ckzs3DG3xytvm3aXVOtrHCavGPTdftuDYGd5CeY0Ugo8BaBN7XWf87TXVaTu4O
	VDzvZED8Lx8DfSd9179BRk9ucyKx9wuiI2WCqRX2Zy31/UNAb3OFGtU2o4FgisSFJMf8pt1Bi7G
	AlHDpBlLDdtgPa9eR3SVWTr4B8IUL5dzOSxMmh3YcxJ2bjw1FnmEu+9tV64k+sk4yXxDwEoclxJ
	u0/MjsP0pdzyP9IcAYaWDM2Bmd4sWZNjBzOyd8lHCkhUCMTaof1o1yIzano20K1bD1FCRnYLmdc
	aE9luVlxJ8tlSEYKWNPwMAYPqKFuYGBymhodxu2mJNNM3PK81HNnUML6GOxVcl+vX2jZVlaL6ck
	24k46ppzplBjSn8dJ4tRADuCoBZqgVvUMHQljQaWfIGGh08bN4aIP9ecdQMs8LmCrTnhSqS96ME
	uBdb894zjSJSgEjgBPWoN4n625RxJJTRhm7QfaiKc5qw==
X-Received: by 2002:a05:620a:4481:b0:915:9051:ba2 with SMTP id af79cd13be357-92092450e6cmr2354950385a.49.1782147238630;
        Mon, 22 Jun 2026 09:53:58 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-925fda626adsm22609185a.12.2026.06.22.09.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 09:53:58 -0700 (PDT)
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
Subject: [PATCH v2] misc: pci_endpoint_test: fix use-after-free after device unbind
Date: Mon, 22 Jun 2026 12:52:49 -0400
Message-Id: <20260622165249.374155-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
References: <20260621054609.186877-1-shuangpeng.kernel@gmail.com>
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
test->pdev, and drops the probe reference.

Use the same 1s timeout already used by the other endpoint interrupt tests
for the READ, WRITE and COPY completion waits. This prevents device unbind
from blocking indefinitely behind an ioctl waiting for a missing endpoint
interrupt. Already-open file descriptors then keep the test object alive;
subsequent ioctls fail with -ENODEV instead of touching released device
resources.

Fixes: 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/all/178144969601.60470.7358419009914000395@gmail.com/
Suggested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
Changes in v2:
- Bound READ, WRITE and COPY completion waits with the same 1s timeout used
  by the other endpoint interrupt tests so device unbind cannot block
  indefinitely behind an ioctl waiting for a missing endpoint interrupt.

Please let me know if there are any concerns with this approach or if there
is a simpler preferred way to handle this lifetime.

---
 drivers/misc/pci_endpoint_test.c | 86 ++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index dbd017cabbb9..65d768dab450 100644
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
@@ -804,10 +815,17 @@ static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_COPY);
 
-	wait_for_completion(&test->irq_raised);
+	if (!wait_for_completion_timeout(&test->irq_raised,
+					 msecs_to_jiffies(1000))) {
+		ret = -ETIMEDOUT;
+		goto err_dst_unmap;
+	}
 
+err_dst_unmap:
 	dma_unmap_single(dev, orig_dst_phys_addr, size + alignment,
 			 DMA_FROM_DEVICE);
+	if (ret)
+		goto err_dst_phys_addr;
 
 	dst_crc32 = crc32_le(~0, dst_addr, size);
 	if (dst_crc32 != src_crc32)
@@ -909,12 +927,17 @@ static int pci_endpoint_test_write(struct pci_endpoint_test *test,
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_READ);
 
-	wait_for_completion(&test->irq_raised);
+	if (!wait_for_completion_timeout(&test->irq_raised,
+					 msecs_to_jiffies(1000))) {
+		ret = -ETIMEDOUT;
+		goto err_unmap_addr;
+	}
 
 	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
 	if (!(reg & STATUS_READ_SUCCESS))
 		ret = -EIO;
 
+err_unmap_addr:
 	dma_unmap_single(dev, orig_phys_addr, size + alignment,
 			 DMA_TO_DEVICE);
 
@@ -1000,10 +1023,17 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
 				 COMMAND_WRITE);
 
-	wait_for_completion(&test->irq_raised);
+	if (!wait_for_completion_timeout(&test->irq_raised,
+					 msecs_to_jiffies(1000))) {
+		ret = -ETIMEDOUT;
+		goto err_unmap_addr;
+	}
 
+err_unmap_addr:
 	dma_unmap_single(dev, orig_phys_addr, size + alignment,
 			 DMA_FROM_DEVICE);
+	if (ret)
+		goto err_phys_addr;
 
 	crc32 = crc32_le(~0, addr, size);
 	if (crc32 != pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
@@ -1141,10 +1171,15 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
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
@@ -1206,9 +1241,30 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
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
@@ -1241,10 +1297,11 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	if (pci_is_bridge(pdev))
 		return -ENODEV;
 
-	test = devm_kzalloc(dev, sizeof(*test), GFP_KERNEL);
+	test = kzalloc_obj(*test);
 	if (!test)
 		return -ENOMEM;
 
+	kref_init(&test->kref);
 	test->pdev = pdev;
 	test->irq_type = PCITEST_IRQ_TYPE_UNDEFINED;
 
@@ -1263,7 +1320,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	ret = pci_enable_device(pdev);
 	if (ret) {
 		dev_err(dev, "Cannot enable PCI device\n");
-		return ret;
+		goto err_kfree_test;
 	}
 
 	ret = pci_request_regions(pdev, DRV_MODULE_NAME);
@@ -1349,6 +1406,9 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 err_disable_pdev:
 	pci_disable_device(pdev);
 
+err_kfree_test:
+	kfree(test);
+
 	return ret;
 }
 
@@ -1364,10 +1424,13 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
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
@@ -1378,6 +1441,11 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 
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

