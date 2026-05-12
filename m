Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160E38759C
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622028; cv=none; b=e7/gQcJMckV2RB00yXAO2lqF1k0CFqJ3awQanOX7+SCeUoj4GP1/+CSn5SjhqUR3JGUgWdnwyZfmUIK4kFaoCLC84bdjU7RrtBwiVhJ1kgb8oCTQvsoXnFqfKSTX6gDhBbRMnBin/IGHVRt2T7+BUehXoptqY9RYfIym1JSSypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622028; c=relaxed/simple;
	bh=xERI0xkqRqL10jfHqloYlD5ENbHUKigjipBxZ5/JJnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzEM7sJLzUq5miwTBDh/Wx6PICovCn9IC8Om2MFINrMCzBB5L65xUm0Y1w0xDQEAwMr0OZbHxoIiItHMyMpRXhP/JTyblfiICHi3zzKdv4bP4JIEHaMOGGjkzgkG99wCkYhHeXOGNd3dbcAfO0D8LPjdvUSZQxBpLySDK/Ka1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAAteYaf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAAteYaf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2baef9f5ecdso36279875ad.1
        for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 14:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778622025; x=1779226825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCsEI4CB6Uv8KDEyDMcVA0XDEMcgTkf23uqjxST/Hh8=;
        b=kAAteYaf9zlyCZMQDONm2muhPYNIT0tHB7srgSmgbJQbwB4jyRsCqJxRHNP199AsTU
         BHndRY5JyRvFkkmfSYxfLp2lwFZGoL0cB9XYLc1frAbXhQdOOEsg73FpgkY1e56qNZyz
         RhBBUo0nUXHWdqiGys7jTy/KlrReOXdeiEqsfi3cl41awG9s5QrFofGNIDpPHThwS/OV
         gl4ZCd/qABTk6/8QffEahcZ/EAC4tHqqVuBmkeMdNcKP1P5mlQR0zNAUz/6V8R7dhSmQ
         5NvoslTINCEFIcZ7W1yUTXlKG9dYw7cUjUFoER0gawMbn9Mi7Abq20te44NMB10CleP/
         +4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622025; x=1779226825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qCsEI4CB6Uv8KDEyDMcVA0XDEMcgTkf23uqjxST/Hh8=;
        b=cvg4z/767ZYzJtflxZbg2oqM1KKK2imQ/JwAxxKgEwphQNijcyKuiNYbb2bkVbe90m
         tcmqEExJIOD5Z2hzGfsxM8WLJGYzLwPhMR5OGc7O6m2pmlY45k0gLVEWMUyTmeXGFJ3j
         D3jCzGpvIUqAdI/wcP+/sFbZvy8AId/Ln55l8iiH6btCyzKUDev8//4FGPBdjNGFvoRF
         MTkg3EU6llFY0Olatj7ng8xJc2gXprBfMKpoxOnJ1beA3rKLCT1MPMrzWuWLxAxKcrhn
         xj2wMdio+hD/iFRIK64UImiPJeR2OZGWDa87qgJyPcUdLu6rAjJbyQdLgIi4rnca4s3N
         3wrg==
X-Forwarded-Encrypted: i=1; AFNElJ/B2v7RVfWHM6SJciEgg0xmgpjNnBNssgMk1Cya4v7amV4Lj3bTsEEH0nL5O8Mj3kfaXGAt2F620yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDQpSRKbbuJ5FO96PMXxrRk5axYtLjT+d4DIBJT65ObEU1WPq4
	z3t9gEzyLdCmXc7QFbnzCDRDbliF4YgcQdOr+20y3NFre0KEa9IuZDrD
X-Gm-Gg: Acq92OF6EDvQUzHOnxkkrAqacyWvXdSkTel+IvYpZ2LVQT3Stnt5iIeep2jrbQg78Bq
	1c3I/vLOS5UaRI4eHaKinMgLnFtQ03kdJxxhumEI9aLEvVQccmcqt0Hue/gpp0ChXDfau0D+aC9
	Gr9faj7YVk11bxHnOv4JEOlNe9q7oFeHSXr+8BAdmyx5GSNFeqsMgShDO5UjnWcpFynjdkYfrAH
	aCvgXoRlZ3C9Lb0HYXWO2muEQ9U/xNwo/3NiE9uqo6cG3IfVwlX0LdHtXdcEDc+/JljEW1VoCY0
	wk2hLNCkHrl4KG7aQWFNVrkgGlfyn/2T8s/u2FnsCB0VZMpmLSA+wodpJ99SEo6BtSctopPfYDV
	eokI7BLjV9zrRf+fSIpzvf+/QopKhaBSr+LXWtMqglXoc76IWe0s0xdKJZ3uCrR+v8X20hMptbz
	TFs2fwRlyrgp0FAB9pepeLbCT94pTlR0g=
X-Received: by 2002:a17:902:9a0c:b0:2bc:810b:5c0c with SMTP id d9443c01a7336-2bd2770eddfmr5688795ad.34.1778622025465;
        Tue, 12 May 2026 14:40:25 -0700 (PDT)
Received: from mincom1 ([27.232.220.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d409eesm143949895ad.32.2026.05.12.14.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:40:24 -0700 (PDT)
From: Jihong Min <hurryman2212@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-usb@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jihong Min <hurryman2212@gmail.com>
Subject: [PATCH v5 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Date: Wed, 13 May 2026 06:39:09 +0900
Message-ID: <20260512213910.871859-2-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512213910.871859-1-hurryman2212@gmail.com>
References: <20260512213910.871859-1-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD Promontory 21 (PROM21) xHCI controllers use generic xHCI
operation, but the PCI function also exposes optional
controller-specific sensor functionality. Add a small PROM21 PCI glue
driver for AMD 1022:43fc and 1022:43fd controllers.

The driver delegates USB host operation to the common xhci-pci core,
collects the parent-provided MMIO resource data, and creates a "hwmon"
auxiliary device for optional child drivers. Failure to create the
auxiliary device is logged but does not fail the xHCI probe, since the
auxiliary device is only needed for sensor support.

Keep the PROM21 PCI glue built-in only when enabled because it owns the
PCI binding for PROM21 xHCI controllers and must be available whenever
the common built-in xhci-pci driver hands those controllers off. This
avoids an early boot case where generic xhci-pci rejects a PROM21
controller but a modular xhci-pci-prom21 driver is not available in the
initramfs, leaving USB devices behind that controller unavailable.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
---
 drivers/usb/host/Kconfig                      |  20 +++
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-pci-prom21.c            | 123 ++++++++++++++++++
 drivers/usb/host/xhci-pci.c                   |  11 ++
 drivers/usb/host/xhci-pci.h                   |   3 +
 include/linux/platform_data/usb-xhci-prom21.h |  22 ++++
 6 files changed, 180 insertions(+)
 create mode 100644 drivers/usb/host/xhci-pci-prom21.c
 create mode 100644 include/linux/platform_data/usb-xhci-prom21.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0a277a07cf70..8b2ad1c27084 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -42,6 +42,26 @@ config USB_XHCI_PCI
 	depends on USB_PCI
 	default y
 
+config USB_XHCI_PCI_PROM21
+	bool "AMD Promontory 21 xHCI PCI support"
+	depends on X86
+	depends on USB_XHCI_PCI=y
+	default USB_XHCI_PCI
+	select AUXILIARY_BUS
+	help
+	  Say 'Y' to enable support for the AMD Promontory 21 xHCI PCI
+	  controller with optional sensor support. This driver does not add
+	  PROM21-specific USB or xHCI operation. It binds PROM21 xHCI PCI
+	  functions, delegates USB host operation to the common xHCI PCI core,
+	  and creates auxiliary devices for optional sensor drivers.
+
+	  This driver is built-in only because it owns the PCI binding for
+	  PROM21 xHCI controllers when enabled and must be available whenever
+	  the common xHCI PCI driver is available. The optional sensor driver
+	  can still be built as a module.
+
+	  If unsure, say 'N'.
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
index 000000000000..70847a2381b7
--- /dev/null
+++ b/drivers/usb/host/xhci-pci-prom21.c
@@ -0,0 +1,123 @@
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
+};
+
+static void prom21_xhci_auxdev_release(struct device *dev, void *res)
+{
+	struct prom21_xhci_auxdev *prom21_auxdev = res;
+
+	auxiliary_device_destroy(prom21_auxdev->auxdev);
+}
+
+static int prom21_xhci_create_auxdev(struct pci_dev *pdev)
+{
+	struct prom21_xhci_auxdev *prom21_auxdev;
+	struct usb_hcd *hcd = pci_get_drvdata(pdev);
+
+	if (!hcd)
+		return -ENODEV;
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
+	prom21_auxdev->auxdev =
+		auxiliary_device_create(&pdev->dev, KBUILD_MODNAME, "hwmon",
+					&prom21_auxdev->pdata,
+					(pci_domain_nr(pdev->bus) << 16) |
+						pci_dev_id(pdev));
+	if (!prom21_auxdev->auxdev) {
+		devres_free(prom21_auxdev);
+		return -ENOMEM;
+	}
+
+	devres_add(&pdev->dev, prom21_auxdev);
+	return 0;
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

