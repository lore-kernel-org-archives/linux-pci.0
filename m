Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F8837D104
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779023087; cv=none; b=uVQvQElM5/TFWopZVlUIhZwlEJKdhPzeRkUio46ZAvlOZzY2etYAQWji+J24ixWPUqa+Bf56DhZDEPugCfpYaF5+IZ7jbESOJw8pc5niygPuXy4s281/B2JNDk+Q1JyWV0Cf9HHAq3TSzADgWhBrwfFTWYZcTeLMIdC3uJANKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779023087; c=relaxed/simple;
	bh=KshHTQQR+6mvIAComUFUue7CrlaSwdDDnxEiUrLUvHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDyKUmpzaumOE1fFGs025Hhu04/V7Jj+Ky+hV7abniCLNJ3xushsIggWTonTUSxI4GB0LAfazRtsV7YKRWXtSSFJG1gk/3mFBzjP8vh7eWgV+7f5zAGq3QMGxQmZPW/W9PmOC3cgZaFVCE9zeRnRYHUENE2jK98hpJ9cTjqbyYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBFKjqP3; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBFKjqP3"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-835386ff122so1428181b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 06:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779023066; x=1779627866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbYK6zyjwjcKr/UaCrMnTnE/VprY/vEckd2yJv9TdQ8=;
        b=cBFKjqP3uvCQp4D4whhPenh+JHSL8UIvtISkpXMfb9SVrW9cCbKojzC5I7cwfTM71E
         z8h8b2BsXaMeu8jilWX+shwia2uG5epq2xoep/eof+O9XSCbN9QA231oqoc07c8eUadz
         crZy/cXQkvq2VmEqGdHKDzzrDa6m3GtGgPez0C9xu4PSVzemUjfD2cGncMExnEy/WJdF
         Lcneg0mulmPj5lKQOPFKTnIgd2pWRNEk+auJAt3IYoqEjIcPaMmQ4QZlPH6MD6NPv37G
         4w6aqaxKkwrhL2iJoLTtmmUJgIjzaL30Gfv9RHq9MqeqBkcCWZ9CrkccgLiIDCL59DXL
         4Bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779023066; x=1779627866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbYK6zyjwjcKr/UaCrMnTnE/VprY/vEckd2yJv9TdQ8=;
        b=TYw3vFw8rsamfWMe0gCxS05yNPt4ALv09PzQIxH5EU4wXksDG2XXfUIovdJOJXEvwE
         jD7YF59ijqhd0/tQRuRAHfNvMt0SIpJoTxiLPUn2K1BSxKXg4ObTOaTgftMe8z8i6N5l
         V2uqWLDChaT1082GIMLL++Jz+6UTw9QoiMBq+ElfTyKyidQ6fMO5V73d3pIMVqHEC6eK
         za6UJYfBA7FQFteGIrEowZXkjv39Patt4V+/g7oQxpk8Hqs9IwtkzcEFUBTem4nt3GQF
         AR7qBJXdQOOOi/n94eQZhoxGNAEn/dq+bmMuY8kA2d7iTitqvOspWs62jhmRGXt9iDVz
         0wEA==
X-Forwarded-Encrypted: i=1; AFNElJ/eMXi8hXNtQqlIaJriXBzJWysGzRAnB7L+r5yvboKle+USQQLBFbluvhg+XvcewobUjB3KGG6sNRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRE5GneuSa2E0rday5t4shN5C8tmV0XsErvBzdwExeAde31+O2
	o+ExLAf4miI41/soK0WaI6XjrhCUzuIECPvOJtD2GMMKNKBh4SPF4AKW
X-Gm-Gg: Acq92OECF8YCgPI1N5+Ub4Kgq20MHT+cJWelQTwt5CBsQk40TfsPvW2J88FzMx2JO+b
	w6kqO8qu+aF0aB6L4LsXtc5a/c21S3H3hQ06fDT6tSs7BtV/ga5Z/mvWSwPR1R1DGXAcJvFqUR6
	vJZju48rXsiI0tnkxZ2BXbJAq1MZQpq/vqjLT6G7fMB1gZjtD4Qok9dj0DqtLsBGAJlytpfqe7a
	NgpcEZ1TOn4p5aoopxJOc4iVDp1pLauG1iTuZASd0F0H+GgXKVmEgllVVflsCuOwVCO5YQzcWhm
	jUvxsZcrkEuxZPi7Zh53UzXLIZcYUVANGygnOtwxjIAZZGpn39pk0T2RMPssjCNR+W6jvuBWbDN
	/A4E/lPpYExGjDOWnaxjWnau5cTYjv6BuonNziFWo9oJ6QT+ncuPIaJpC/g9TEWXE1+q0O374Fk
	tzivwT9UOZfXz+PVW5phlHWg==
X-Received: by 2002:a05:6a00:440e:b0:82f:3ecc:c42f with SMTP id d2e1a72fcca58-83f33c9d17amr11704313b3a.40.1779023066365;
        Sun, 17 May 2026 06:04:26 -0700 (PDT)
Received: from mincom1 ([119.214.48.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c77822sm11712607b3a.41.2026.05.17.06.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 06:04:24 -0700 (PDT)
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
	Jihong Min <hurryman2212@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Yaroslav Isakov <yaroslav.isakov@gmail.com>
Subject: [PATCH v6 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Date: Sun, 17 May 2026 22:04:06 +0900
Message-ID: <20260517130407.795157-2-hurryman2212@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517130407.795157-1-hurryman2212@gmail.com>
References: <20260517130407.795157-1-hurryman2212@gmail.com>
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

Make the PROM21 PCI glue a hidden Kconfig tristate that follows
USB_XHCI_PCI. This keeps the glue built in with a built-in xhci-pci core
and builds it as a module with a modular xhci-pci core. A built-in
xhci-pci core must not hand PROM21 controllers to a PROM21 glue driver
that is only available as a module, otherwise USB behind those controllers
can be unavailable during initramfs and PROM21 temperature sensor support
may not appear until the controller is rebound after the module loads.

Assisted-by: Codex:gpt-5.5
Signed-off-by: Jihong Min <hurryman2212@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
---
 drivers/usb/host/Kconfig                      |   7 +
 drivers/usb/host/Makefile                     |   1 +
 drivers/usb/host/xhci-pci-prom21.c            | 136 ++++++++++++++++++
 drivers/usb/host/xhci-pci.c                   |  11 ++
 drivers/usb/host/xhci-pci.h                   |   3 +
 include/linux/platform_data/usb-xhci-prom21.h |  22 +++
 6 files changed, 180 insertions(+)
 create mode 100644 drivers/usb/host/xhci-pci-prom21.c
 create mode 100644 include/linux/platform_data/usb-xhci-prom21.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 0a277a07cf70..89bf262235e1 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -42,6 +42,13 @@ config USB_XHCI_PCI
 	depends on USB_PCI
 	default y
 
+config USB_XHCI_PCI_PROM21
+	tristate
+	depends on X86
+	depends on USB_XHCI_PCI
+	default USB_XHCI_PCI
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
index 000000000000..be0933ca5c62
--- /dev/null
+++ b/drivers/usb/host/xhci-pci-prom21.c
@@ -0,0 +1,136 @@
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
+	prom21_auxdev->id = ida_alloc(&prom21_xhci_auxdev_ida, GFP_KERNEL);
+	if (prom21_auxdev->id < 0) {
+		int ret = prom21_auxdev->id;
+
+		devres_free(prom21_auxdev);
+		return ret;
+	}
+
+	prom21_auxdev->auxdev = auxiliary_device_create(&pdev->dev,
+							KBUILD_MODNAME, "hwmon",
+							&prom21_auxdev->pdata,
+							prom21_auxdev->id);
+	if (!prom21_auxdev->auxdev) {
+		ida_free(&prom21_xhci_auxdev_ida, prom21_auxdev->id);
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

