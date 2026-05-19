Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AFF41A8F
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 00:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779149275; cv=none; b=icmmxQPny82ITg5FEbn972X+QIvjvFTF/RfVJWWpHYuhPrmIgP+nKCTDD10AMgMKqIke2IqGqFu03qyVIkL5fSiEHib6XowT2aVx68XwVgksmkauwcv1EmaePVdKZlSCy+5sCl8ZV9871XqW5AqH464W6Z02GmA8aK5Pw8naeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779149275; c=relaxed/simple;
	bh=Kc8+aK64Ly1xvXuCc8InpT0SC3CasoBFQHQnMVAiLqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFeYE4pllZuF0Rke50HVCe2muxaIKpFw6EK/rkSXOfYjN3WC7M0sZFnGyXtBt1RjQr9JT8+MV/VyqkXY9h0G02SXTlFVyoUFhYf/3oTj5jY7y2Tz9tGeHmTxak2CuhjElH1BeKbDppzvV2Nfm9BJH1cTexK+VoGqOFfBhuMC5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCdACxmj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCdACxmj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba17c8cfacso28159865ad.2
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 17:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779149273; x=1779754073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6tltDGo+5vtt2DKrFq/NSjTt1IvEImZu/p4oBxOfcM=;
        b=oCdACxmjZG+y3KojZnY+meoLmhW74BQYIn/99LBMNodfzeTs/K8xWoN0mN3Qspu+X7
         TdKRotk5X44rBNtEQ+wxIGSZqmB70c5K79OiVu0NZsfcxciQP8Z1jR8aQyB/TZAfoqLO
         fuCx3DN/LBwaSpKyCBio2S/cZii/yf6XnpDic2l6RK08UZN11rdVvgMNpuF+Gd5FDwU3
         3HEoGygPVBDKaFMNYLngHPYvSP++70aoDxMaPuT7IDVSqQFSnnnYEbDy59Wtyle7rQ6i
         XDAuT5OH8COP4YXeWm8L7NVjGkJzR0n3rYWUarCeUodp1xt649GdVOSjtqHDdvj0BjZJ
         nMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779149273; x=1779754073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M6tltDGo+5vtt2DKrFq/NSjTt1IvEImZu/p4oBxOfcM=;
        b=Y+mUC4iWAbgp6rxY3mp99asJXpo7QtIaAPvWFE8/qhdFE6XIYwpyPjFf6/27sVSg+w
         Co3sPIXtdr0r1L4Cn0T6rX7ixykIPDR5D/IYzXbsLwVcsqHmFCUiRRMV3ojCvE/i0k/u
         dHlBxSk/9135eZjwsn23kg6s0KxFCoNjVVeCGPFUGAXdRdW6tJas1eNwj8gxvWvBsugw
         foOBn4pFCMbDC/hJV15yGsdHayFFKEkHJ2gysWeN27kJyRPS5iKLQ5JZad+B1fiYUs0D
         Ys/KZMgPsBEJe/Qjz5ecVC55I2/gY77tLkiJ5z/k16GAQpDDf/pbniWO1q9Vnc6YqiXl
         7bnQ==
X-Forwarded-Encrypted: i=1; AFNElJ/vNtC0koAhvILkZR5pYtDZv7mHZzo3ezbFj/0NKGEvWmOv4UUM5kKmiQqCmX8435MR/HRn54LUd5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zn+iufRpnZwcIVhLLsIMopCAcb6rVeUAiM2Kjt/X5GV7O9mu
	Eo2YW8xvfo6kWJH//6/s5nrlTeCbH1CJZecPTN8fNnIGY0L22z5vJhFe
X-Gm-Gg: Acq92OGiPuYDn1bSs3sv7fw1N6U5c5ZhQL6kTJorLsTd8Rwu3pIb44YRy6E7vjqaaDK
	lkXsIKhjm3+YToGQek9jBiYOegYZPSl8LvUHmvJzmVlTMpuu1g7aSaMSrobk007K7KikzCjnDlT
	x6O5S0YVeuiie+EQWA99d6iDfrsL/B8SxfhTInMSEpZU4zvYrKE4wAnVRRTd9AGc9C9NMXa9F7D
	b9TvwY2ZF132StorRrM+I7+8r+g4CyHftO77xHp4UY4m2ensg6xwUnMpJMAXE7y3tFXjybq4AmF
	h89TdzkcYgw4MHq9iHho9BUn/ra1srHLzB/wz0rdje2TFhvIsbAn8SnMmYQmrfyOO8DoaNGFtmq
	Wbg28taQoCX659shbhRcUyvsbxnHtErA7wy3TElquXgAtuAdhhROGRnw2AZjGmXAhMc4rhTtbln
	C8WxpC5yEcOYJefK3BaUD6gA==
X-Received: by 2002:a17:902:f647:b0:2b2:4cd2:e162 with SMTP id d9443c01a7336-2bd7e93872bmr191189345ad.34.1779149272692;
        Mon, 18 May 2026 17:07:52 -0700 (PDT)
Received: from mincom1 ([119.214.48.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bdc58575dfsm79021755ad.20.2026.05.18.17.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 17:07:52 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Michal Pecio <michal.pecio@gmail.com>,
	Mario Limonciello <superm1@kernel.org>,
	Yaroslav Isakov <yaroslav.isakov@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH v7 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Date: Tue, 19 May 2026 09:07:31 +0900
Message-ID: <20260519000732.2334711-2-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519000732.2334711-1-hurryman2212@gmail.com>
References: <20260519000732.2334711-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD Promontory 21 (PROM21) xHCI PCI functions use the common xhci-pci
core for USB operation, but also expose controller-specific sensor data.
Add a small PROM21 PCI glue driver for AMD 1022:43fc and 1022:43fd
controllers.

The glue delegates USB host operation to the common xhci-pci core and
publishes a "hwmon" auxiliary device with parent-provided MMIO data.
Auxiliary device creation failure is logged but does not fail the xHCI
probe.

Make the PROM21 glue a hidden Kconfig tristate driven by the user-visible
SENSORS_PROM21_XHCI option. If sensor support is disabled, generic
xhci-pci binds PROM21 controllers normally. If sensor support is enabled,
the glue follows USB_XHCI_PCI.

This keeps the auxiliary device available for a modular sensor driver while
avoiding a built-in xhci-pci core handing PROM21 controllers to a glue
driver that is only available as a module during initramfs.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
---
 drivers/usb/host/Kconfig                      |   6 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-pci-prom21.c            | 137 ++++++++++++++++++
 drivers/usb/host/xhci-pci.c                   |  11 ++
 drivers/usb/host/xhci-pci.h                   |   3 +
 include/linux/platform_data/usb-xhci-prom21.h |  22 +++
 6 files changed, 180 insertions(+)
 create mode 100644 drivers/usb/host/xhci-pci-prom21.c
 create mode 100644 include/linux/platform_data/usb-xhci-prom21.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0a277a07cf70..43f30cd867e4 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -42,6 +42,12 @@ config USB_XHCI_PCI
 	depends on USB_PCI
 	default y
 
+config USB_XHCI_PCI_PROM21
+	tristate
+	depends on USB_XHCI_PCI
+	default USB_XHCI_PCI if SENSORS_PROM21_XHCI != n
+	select AUXILIARY_BUS
+
 config USB_XHCI_PCI_RENESAS
 	tristate "Support for additional Renesas xHCI controller with firmware"
 	depends on USB_XHCI_PCI
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index a07e7ba9cd53..174580c1281a 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
 obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
 obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
 obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
+obj-$(CONFIG_USB_XHCI_PCI_PROM21)	+= xhci-pci-prom21.o
 obj-$(CONFIG_USB_XHCI_PCI_RENESAS)	+= xhci-pci-renesas.o
 obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
 obj-$(CONFIG_USB_XHCI_HISTB)	+= xhci-histb.o
diff --git a/drivers/usb/host/xhci-pci-prom21.c b/drivers/usb/host/xhci-pci-prom21.c
new file mode 100644
index 000000000000..6486f4a09345
--- /dev/null
+++ b/drivers/usb/host/xhci-pci-prom21.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Promontory 21 xHCI host controller PCI Bus Glue.
+ *
+ * This does not add any PROM21-specific USB or xHCI operation. It exists only
+ * to publish an auxiliary device for integrated temperature sensor support.
+ *
+ * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/device/devres.h>
+#include <linux/errno.h>
+#include <linux/idr.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_data/usb-xhci-prom21.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#include "xhci-pci.h"
+
+struct prom21_xhci_auxdev {
+	struct auxiliary_device *auxdev;
+	struct prom21_xhci_pdata pdata;
+	int id;
+};
+
+static DEFINE_IDA(prom21_xhci_auxdev_ida);
+
+static void prom21_xhci_auxdev_release(struct device *dev, void *res)
+{
+	struct prom21_xhci_auxdev *prom21_auxdev = res;
+
+	auxiliary_device_destroy(prom21_auxdev->auxdev);
+	ida_free(&prom21_xhci_auxdev_ida, prom21_auxdev->id);
+}
+
+static int prom21_xhci_create_auxdev(struct pci_dev *pdev)
+{
+	struct prom21_xhci_auxdev *prom21_auxdev;
+	struct usb_hcd *hcd = pci_get_drvdata(pdev);
+	int ret;
+
+	prom21_auxdev = devres_alloc(prom21_xhci_auxdev_release,
+				     sizeof(*prom21_auxdev), GFP_KERNEL);
+	if (!prom21_auxdev)
+		return -ENOMEM;
+
+	prom21_auxdev->pdata.pdev = pdev;
+	prom21_auxdev->pdata.regs = hcd->regs;
+	prom21_auxdev->pdata.rsrc_len = hcd->rsrc_len;
+
+	prom21_auxdev->id = ida_alloc(&prom21_xhci_auxdev_ida, GFP_KERNEL);
+	if (prom21_auxdev->id < 0) {
+		ret = prom21_auxdev->id;
+		goto err_free_devres;
+	}
+
+	prom21_auxdev->auxdev = auxiliary_device_create(&pdev->dev,
+							KBUILD_MODNAME, "hwmon",
+							&prom21_auxdev->pdata,
+							prom21_auxdev->id);
+	if (!prom21_auxdev->auxdev) {
+		ret = -ENOMEM;
+		goto err_free_ida;
+	}
+
+	devres_add(&pdev->dev, prom21_auxdev);
+	return 0;
+
+err_free_ida:
+	ida_free(&prom21_xhci_auxdev_ida, prom21_auxdev->id);
+err_free_devres:
+	devres_free(prom21_auxdev);
+	return ret;
+}
+
+static void prom21_xhci_destroy_auxdev(struct pci_dev *pdev)
+{
+	devres_release(&pdev->dev, prom21_xhci_auxdev_release, NULL, NULL);
+}
+
+static int prom21_xhci_probe(struct pci_dev *dev,
+			     const struct pci_device_id *id)
+{
+	int retval;
+
+	retval = xhci_pci_common_probe(dev, id);
+	if (retval)
+		return retval;
+
+	retval = prom21_xhci_create_auxdev(dev);
+	if (retval) {
+		/*
+		 * The auxiliary device only provides optional temperature sensor
+		 * support. Keep the xHCI controller usable if it fails.
+		 */
+		dev_err(&dev->dev,
+			"failed to create PROM21 hwmon auxiliary device: %d\n",
+			retval);
+	}
+
+	return 0;
+}
+
+static void prom21_xhci_remove(struct pci_dev *dev)
+{
+	prom21_xhci_destroy_auxdev(dev);
+	xhci_pci_remove(dev);
+}
+
+static const struct pci_device_id pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
+	{ /* end: all zeroes */ }
+};
+MODULE_DEVICE_TABLE(pci, pci_ids);
+
+static struct pci_driver prom21_xhci_driver = {
+	.name = "xhci-pci-prom21",
+	.id_table = pci_ids,
+
+	.probe = prom21_xhci_probe,
+	.remove = prom21_xhci_remove,
+
+	.shutdown = usb_hcd_pci_shutdown,
+	.driver = {
+		.pm = pm_ptr(&usb_hcd_pci_pm_ops),
+	},
+};
+module_pci_driver(prom21_xhci_driver);
+
+MODULE_AUTHOR("Jihong Min <hurryman2212@gmail.com>");
+MODULE_DESCRIPTION("AMD Promontory 21 xHCI PCI Host Controller Driver");
+MODULE_IMPORT_NS("xhci");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 585b2f3117b0..039c26b241d0 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -696,12 +696,23 @@ static const struct pci_device_id pci_ids_renesas[] = {
 	{ /* end: all zeroes */ }
 };
 
+/* handled by xhci-pci-prom21 if enabled */
+static const struct pci_device_id pci_ids_prom21[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
+	{ /* end: all zeroes */ }
+};
+
 static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS) &&
 			pci_match_id(pci_ids_renesas, dev))
 		return -ENODEV;
 
+	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_PROM21) &&
+	    pci_match_id(pci_ids_prom21, dev))
+		return -ENODEV;
+
 	return xhci_pci_common_probe(dev, id);
 }
 
diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
index e87c7d9d76b8..11f435f94322 100644
--- a/drivers/usb/host/xhci-pci.h
+++ b/drivers/usb/host/xhci-pci.h
@@ -4,6 +4,9 @@
 #ifndef XHCI_PCI_H
 #define XHCI_PCI_H
 
+#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC	0x43fc
+#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD	0x43fd
+
 int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id);
 void xhci_pci_remove(struct pci_dev *dev);
 
diff --git a/include/linux/platform_data/usb-xhci-prom21.h b/include/linux/platform_data/usb-xhci-prom21.h
new file mode 100644
index 000000000000..ee672ad452a8
--- /dev/null
+++ b/include/linux/platform_data/usb-xhci-prom21.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Promontory 21 xHCI auxiliary device platform data.
+ *
+ * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
+ */
+
+#ifndef _LINUX_PLATFORM_DATA_USB_XHCI_PROM21_H
+#define _LINUX_PLATFORM_DATA_USB_XHCI_PROM21_H
+
+#include <linux/compiler_types.h>
+#include <linux/types.h>
+
+struct pci_dev;
+
+struct prom21_xhci_pdata {
+	struct pci_dev *pdev;
+	void __iomem *regs;
+	resource_size_t rsrc_len;
+};
+
+#endif
-- 
2.53.0

