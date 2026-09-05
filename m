Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD14EE847
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788633573; cv=none; b=MHKBSOZTxQ2KaKkl/pyO5BZmwQXW+eeHZVxs8T4wcLQnbiIyo7Sq8B5bZZp3Erh4aYiAwxiHKatVG9GRsju9DGfdiP7flfaY93R1GO6a7l9xJl/KU9RC0ViUBdhbI6iWhK2HBPz2Ld04oRuKb5OalDGEZeV5MlRWUYLzVvJUnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788633573; c=relaxed/simple;
	bh=4p0t4kxqdtq0p2YlJ6VyfHFrgxr8bBrSXVIfvZ+IBtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HB24lAOHF8BOJifJ0oHKKzVyxRTse761GpDTwEcu2imQl70G4VrVxV9nTixO7zdi23vO9wjivDiFtZWW2aN2ldJmeRCU+E7JnrtH8S5Pn4Agh8THlOAEjd6zbAJqVfxCivkd8Uv1FKWqmYtROIY7bFqKmeMtRw2lJdoi2IZ9iHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxvoPhZw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxvoPhZw"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48441a2ba14so1874347f8f.1
        for <linux-pci@vger.kernel.org>; Sat, 05 Sep 2026 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788633569; x=1789238369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rlmalfwKU2dFS/LTehgVnk0Im0uZNUUABZEx/k40zk4=;
        b=jxvoPhZwtSGgT8QDyqU7Zj0JE2o5we5PiPxJrP3EO1ueGLZCgbbCxspTgr2aLqnToN
         NlvUsfMf4dzdZb115hfVLu+zSitgRcoKPyuEudcrbSVOL6A6AVR+tNn1bI8+vAW95Bsj
         vTr8yNxomkxngy46ykISeiNSnJ+3xWajc7kegT+7VJKUVHxTZSAXaF5QnSZbGGqM9yI2
         7Rxuq1KEBmYIuQHsD02gZ56o6i2Pzxx043UrMKOmM6wwMw7QMpHscAbgD2Jd+mj+0Ld/
         hrzzYOFuygiKaitTp1/gZhbtBPNpcDWQ7LyWjVG410gBH3ATsbCPukoxsoyhK/wY/Zfg
         vLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788633569; x=1789238369;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rlmalfwKU2dFS/LTehgVnk0Im0uZNUUABZEx/k40zk4=;
        b=KuVEBUblMG1JMejemKzQOjdxHPWBspt9UCsyz2y+NEK8tJMyR6U6X2jNsAjHJ7vAIZ
         r+l833PeEJZWzHlGp9JPS2Bb/8FN6Da1S+GdCAijx01iIXVEOGVr7Y9Gz95EPoKCDcpx
         doWtGxMOV51pBoIHZEUsi/Htr8cfoiSn4UWxahw+ddI2Qu5USlYxK0LrHeAUTjDbLrBg
         nhutfk/Jfmw4b6cyl4xo+djOkHj+i98gTwUaW6WkeQEBM1g+TXDwcv+Rynf8gwlCtljb
         NoGgmPXAPWtvjm6ye6WqtVYD3s72mqX97ZEzu6BiGyBk38YVaiziWxCBzzn2f+e8MZWv
         QCCQ==
X-Gm-Message-State: AFuF++lD3adWuabxIezF2FDEXLLPRR1ULIY5A96nDj15PzS6LBQG6A1p
	tXnRndhNfHPPdYn33yQ9bMPXEq7Ev5lTnhAv82MUNnYavzRBVE69HezR
X-Gm-Gg: AYBFou080sNjNtQz/LWt8zc1ZVfQ/2N7dzxUYgW7maQ9+G7G3f9dY+xgAE5XpzoBAo4
	2rZd//EdGwfBPFzSHhWMcZMfgivKsKBn8AIidvP3OYfJYK2jiptvFzG400eJvvEGGrG6nbhL/4L
	tcZlEa5xkkgTX1XukGicBDLBqU2kF+BjzwgMlbRWw6wfacDp8dXKynYYh0Q6hBKR7PwE8d+89oa
	To5et9pebrgr6rf3UdpK6MAowKcK8Uz708r/OK2nlxgUMGzTnVJPunz7Z98Fylqi6/wMS9zwQVy
	4BWA2trnItTZ89+j/yQm3uDO0Wez4grTo/JNB00fF8k8JqtwCCmHaeL6aQLGoaZX8LomFhnbt9N
	xtw7I8R+rhz1PAqizQm5SzhW+4svcTYthEjEdABOz/YpLXngIJPbenYkPEWYBaEo4OvK/M+clFJ
	G1pryB/6OcBF0hRneKGCd1HYYxKx1PrEFjuErB7AyCvVbGXkO1qwhGo8V9J+BPaTpatbaB2DkXn
	A==
X-Received: by 2002:a5d:64e1:0:b0:485:8f42:e8cd with SMTP id ffacd0b85a97d-4858f42ec28mr6981886f8f.3.1788633569252;
        Sat, 05 Sep 2026 11:39:29 -0700 (PDT)
Received: from 1c44f78ca37e.fritz.box ([2.210.128.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885bfdf6sm16333603f8f.34.2026.09.05.11.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 11:39:28 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: bhelgaas@google.com,
	lukas@wunner.de,
	mst@redhat.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	kees@kernel.org,
	xueshuai@linux.alibaba.com,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC 3/3] misc: Add edu_srpoc surprise removal POC driver
Date: Sat,  5 Sep 2026 18:39:00 +0000
Message-ID: <20260905183905.997833-4-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260905183905.997833-1-abhinjoses@gmail.com>
References: <20260905183905.997833-1-abhinjoses@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A test driver for the QEMU edu device that reproduces the surprise
removal hang described in MST's RFC v5 thread.

- hacked in a reg to the edu device on qemu to raise a delayed irq
- This driver writes to that reg in remove and waits for the irq to be
  handled. This simulates del_gendisk() blocked in
  blk_mq_freeze_queue_wait()

Assisted-by: LLM
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/misc/Makefile    |   1 +
 drivers/misc/edu_srpoc.c | 169 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)
 create mode 100644 drivers/misc/edu_srpoc.c

diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e8d8d5d88c0d..1479bf19c646 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_AD525X_DPOT_I2C)	+= ad525x_dpot-i2c.o
 obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
+obj-y				+= edu_srpoc.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm/
 obj-$(CONFIG_TI_FPC202)		+= ti_fpc202.o
diff --git a/drivers/misc/edu_srpoc.c b/drivers/misc/edu_srpoc.c
new file mode 100644
index 000000000000..f536bc4aa253
--- /dev/null
+++ b/drivers/misc/edu_srpoc.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * edu_srpoc.c Surprise Removal POC driver for the QEMU edu device
+ *
+ * In remove(), schedules a delayed interrupt on the edu device and
+ * blocks waiting for it to complete. This simulates del_gendisk()
+ * blocked in blk_mq_freeze_queue_wait() on slow in-flight I/O.
+ *
+ * Surprise-remove the device during this window to reproduce the hang.
+ *
+ * edu BAR 0 registers used:
+ *   0x08  Factorial: write N to compute N! asynchronously
+ *   0x20  Status: write EDU_STATUS_IRQFACT to enable IRQ on completion
+ *   0x24  IRQ status: bit 0 = FACT_IRQ, bit 9 = DELAY_IRQ
+ *   0x30  Delayed IRQ: write N (ms). Hacked in this functionality(not upstream).
+ *   0x64  IRQ lower: write bitmask to ack
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+
+#define PCI_VENDOR_ID_EDU	0x1234
+#define PCI_DEVICE_ID_EDU	0x11e8
+
+#define EDU_REG_FACT		0x08
+#define EDU_REG_STATUS		0x20
+#define EDU_REG_DELAYED_IRQ	0x30
+#define EDU_REG_IRQ_STATUS	0x24
+#define EDU_REG_IRQ_LOWER	0x64
+
+#define EDU_STATUS_IRQFACT	0x80
+#define EDU_FACT_IRQ		BIT(0)
+#define EDU_DELAY_IRQ		BIT(9)
+
+struct edu_dev {
+	struct pci_dev		*pdev;
+	void __iomem		*regs;
+	struct completion	irq_done;
+};
+
+static irqreturn_t edu_irq_handler(int irq, void *data)
+{
+	struct edu_dev *edu = data;
+	u32 status;
+
+	status = ioread32(edu->regs + EDU_REG_IRQ_STATUS);
+	if (!status)
+		return IRQ_NONE;
+
+	iowrite32(status, edu->regs + EDU_REG_IRQ_LOWER);
+
+	if (status & (EDU_FACT_IRQ | EDU_DELAY_IRQ)) {
+		complete(&edu->irq_done);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void edu_disconnect(struct work_struct *work)
+{
+	struct pci_dev *pdev = container_of(work, struct pci_dev,
+					    disconnect_work);
+	struct edu_dev *edu = pci_get_drvdata(pdev);
+
+	if (!pci_test_and_clear_disconnect_enable(pdev))
+		return;
+
+	if (!edu)
+		return;
+
+	dev_info(&pdev->dev, "disconnect_work fired — unblocking remove()\n");
+	complete(&edu->irq_done);
+}
+
+static int edu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct edu_dev *edu;
+	int err;
+
+	edu = devm_kzalloc(&pdev->dev, sizeof(*edu), GFP_KERNEL);
+	if (!edu)
+		return -ENOMEM;
+
+	edu->pdev = pdev;
+	init_completion(&edu->irq_done);
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+
+	err = pci_request_regions(pdev, "edu_srpoc");
+	if (err)
+		goto err_disable;
+
+	edu->regs = pci_iomap(pdev, 0, 0);
+	if (!edu->regs) {
+		err = -ENOMEM;
+		goto err_release;
+	}
+
+	pci_set_master(pdev);
+
+	err = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
+	if (err < 0)
+		goto err_iounmap;
+
+	err = request_irq(pci_irq_vector(pdev, 0), edu_irq_handler,
+			  IRQF_SHARED, "edu_srpoc", edu);
+	if (err)
+		goto err_free_vectors;
+
+	pci_set_drvdata(pdev, edu);
+
+	INIT_WORK(&pdev->disconnect_work, edu_disconnect);
+	pci_set_disconnect_work(pdev);
+
+	dev_info(&pdev->dev, "edu_srpoc probed\n");
+	return 0;
+
+err_free_vectors:
+	pci_free_irq_vectors(pdev);
+err_iounmap:
+	pci_iounmap(pdev, edu->regs);
+err_release:
+	pci_release_regions(pdev);
+err_disable:
+	pci_disable_device(pdev);
+	return err;
+}
+
+static void edu_remove(struct pci_dev *pdev)
+{
+	struct edu_dev *edu = pci_get_drvdata(pdev);
+
+	iowrite32(EDU_STATUS_IRQFACT, edu->regs + EDU_REG_STATUS);
+	iowrite32(600000, edu->regs + EDU_REG_DELAYED_IRQ);
+
+	dev_info(&pdev->dev, "Waiting for IRQ in remove()\n");
+	wait_for_completion(&edu->irq_done);
+	dev_info(&pdev->dev, "Unblocked, cleaning up\n");
+
+	pci_clear_disconnect_work(pdev);
+	free_irq(pci_irq_vector(pdev, 0), edu);
+	pci_free_irq_vectors(pdev);
+	pci_iounmap(pdev, edu->regs);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id edu_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_EDU, PCI_DEVICE_ID_EDU) },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, edu_ids);
+
+static struct pci_driver edu_driver = {
+	.name		= "edu_srpoc",
+	.id_table	= edu_ids,
+	.probe		= edu_probe,
+	.remove		= edu_remove,
+};
+
+module_pci_driver(edu_driver);
+MODULE_AUTHOR("Abhin Parekadan Jose");
+MODULE_DESCRIPTION("edu surprise removal POC driver");
+MODULE_LICENSE("GPL");
-- 
2.51.1

