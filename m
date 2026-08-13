Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6583FCB0C
	for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786660194; cv=none; b=GmaPcVroE6wWpa39uh8gtV3bZcbWIJgKhsCJQhYBG8a55rT527DhXyUZ4yVxH8FBHZsU0IxmIuoTjIj2JZTwGqX/YsbxWGSjqpyuRI/aKfCVy4m3lWLODifbY1jINTaqJ7AhMFC3yQvgyh4yVhF9jH/irhiCBchtiLKaTno9fkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786660194; c=relaxed/simple;
	bh=nSLOh0R2kDve7q5wgtB1h8VLnLESxogNNkvg+i0t6Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hn/Hz1Jhi55Q+gimf1Zo6XnxARE6X4MZ4GPFcJW3yDrXVQO8g9cGrmmOI6iG6QxC5PBlAy/RKm09yMtUGRw45XiRnMAXihiUl2suawLIB2pHCTXtxSeyMPJFzddYr6PyvlbD8BkA+R4jv0Ymg/uypoi/Lnr69T0s6w7Iydiq1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=0zTrz3Jj; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="0zTrz3Jj"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8efec2c28f8so2383036d6.2
        for <linux-pci@vger.kernel.org>; Thu, 13 Aug 2026 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1786660191; x=1787264991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M3rOgdkqoqF1YP7KocOmlm1bhe3NA1tNbYdJmmyzt1o=;
        b=0zTrz3JjD+kahoThxOY1i6QW4Tfjj7UXXRPcq26xqakvqIM02VP5IcuReHJRPRmruN
         lK97DRgyUeP34tYMx6C98qf8hPdtV5RoD/1WfNwoYl1NoYKWQrSb/TV0/efnj4jjX3kF
         WnldauPtshngH2kK5594EPOkkvSIDswOM2Q9XZBSHoNkEXGFPqqS2JjVgSTAlVojX/Vo
         XMDuZEI+DLYaCF+1Fzkk53gM3F4HUyN+eOcdk89ZmrZxDqYqmlbpl3VpLdlKDpInp3jY
         R79XPTs3Rj6nmYOq0c/Spwj2P7Fkp+I6bkPwXMg1Dwc+I3JYE4TPKLPzzreq0zz6LPu1
         lc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786660191; x=1787264991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M3rOgdkqoqF1YP7KocOmlm1bhe3NA1tNbYdJmmyzt1o=;
        b=JMYogGC/KAEEQmwGgJsiyWsgI2vcoI5tokkK2ikVS95fkSbZQh69W2fy+bYNsKDf6/
         lYxSXcp/M5x7x8rva+E3IogcicRCmKAIKhy/2RsEml4F2of8hKlKLSZA3scBRG+1KjFh
         ShFaZ5Zcu6zOXJeAOYSk3+vFyonP3N/qIiYO06uTBH7a9o6oseEwPRwUimH+GlV1pplA
         NVK9rtFYVM2fYLavA+EpESH1AgitUkLWNuYcIewqcTrwLRVCJPZ4gx7mhowL1JmgVt05
         mC81i4nb5tz8m9+jTCovy9CPD9A6hK1Nr0ISALxiate/Vbo45fkXcvjuW7xglKjv0Hfd
         TKWg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Mfb/S9nIqCk3z1pXp64qjxelqPGdHb3b3Iugak3+nv5yK/OfCdmoEXLYIzxHqAr2vuDIioE2Q9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sk0uQ0/0CQAQc9PTsglNQZy7EmRkSVUksLJDDFi8RfzKP7Ua
	Ffcnpgz78MtNTGRJNJcsjjD1IgDsx6HBEridY9HtUhEghudZzXfTeqgbRBXxByrJ3kQ=
X-Gm-Gg: AR+sD10zOoMmXBWZvYJeDB0+zbkkVhu26UfUSgsE0ZPTNO8w7qC3hqo026BRrwkN19w
	XrxP1Z8aKAMK/eMIcs+LSMgPRmMriAE6TlFQlSX1jXufq2rotqf7+7Mj+8XphXr4R9XqbywuKXb
	3awYYJ8Q75N5/dSrn9MoDBaFuk67H/pGrT4nECo4VogUns3GIVtuO9jYSLdN7kWto+I2ykejL2Z
	NR3VAeV99N1P70RVTXHLmsK3u3CwSngF4MTB/kSFoq3xnf1pN7RbrESajYoMAil1Qp5X+RApOUR
	LuZ96572RcC/0vkHeNFjc/JV5V7KlBYdKKSKLxgThmaNg62BKtWRIW8sVIMQlXRLUU1DJ/4OrhG
	Dkh751FO/KszORzZhQQ0gvBVPZaxo+MuGCCMcIMajh1+3a0qBLXwDwLEoMUDg0qp+ekfsiugFyC
	SMSctwIunXkWJQIhbPu4q8cARbFGTzdKsaR0LrsM/kAcXo2LfC36UETMziuhXXPy9B
X-Received: by 2002:a05:6214:1316:b0:8f2:3472:5b33 with SMTP id 6a1803df08f44-90a91da5cd9mr13296916d6.23.1786660190035;
        Thu, 13 Aug 2026 15:29:50 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a921ea2dbsm2367506d6.7.2026.08.13.15.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 15:29:49 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	bhelgaas@google.com
Cc: daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] misc: tc9564: introduce base PCI driver
Date: Thu, 13 Aug 2026 17:29:42 -0500
Message-ID: <20260813222943.1655453-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813222943.1655453-1-elder@riscstar.com>
References: <20260813222943.1655453-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Toshiba TC9564 is small and highly-specialized SoC that implements
a PCIe switch as well as an Ethernet AVB/TSN bridge.  In addition to
these, the SoC implements other functions, including a reset and clock
controller, an address translation unit, and a few other devices.  PCIe
BARs provide access to registers that manage these IP blocks, and the
SoC is modeled using a PCI endpoint bus in devicetree.  This allows the
IP blocks to be bound to platform drivers using MMIO through the PCI BARs.

Create a new PCI driver under drivers/misc that binds with the embedded
PCI endpoint functions within the TC9564 SoC.  Because these functions
will use devicetree pci-ep-bus to provide access to other IP blocks
within the TC9564 chip, the main purpose of this driver is to do basic
PCI initialization, then call of_platform_default_populate() to scan for
the any endpoint bus children, and probe all devices defined therein.

Because we're using pci-ep-bus, we need to use the PCI quirks mechanism
to have of_pci_make_dev_node() be called for each endpoint device in
pci_bus_add_device() (via pci_fixup_device(pci_fixup_final, dev)).

Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 MAINTAINERS               |  1 +
 drivers/misc/Kconfig      | 10 +++++
 drivers/misc/Makefile     |  1 +
 drivers/misc/tc9564-pci.c | 89 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c      |  1 +
 5 files changed, 102 insertions(+)
 create mode 100644 drivers/misc/tc9564-pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b7966ad3dea5..125fa60122c4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27620,6 +27620,7 @@ M:	Alex Elder <elder@kernel.org>
 M:	Daniel Thompson <danielt@kernel.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/misc/pci1179,0220.yaml
+F:	drivers/misc/tc9564-pci.c
 
 TOSHIBA WMI HOTKEYS DRIVER
 M:	Azael Avalos <coproscefalo@gmail.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7364931dad3a1..91950d2928f07 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -568,6 +568,16 @@ config MCHP_LAN966X_PCI
 	    - lan966x-miim (MDIO_MSCC_MIIM)
 	    - lan966x-switch (LAN966X_SWITCH)
 
+config TC9564_PCI
+	tristate "Toshiba TC9564 PCI function support"
+	depends on PCI
+	select REGMAP_MMIO
+	help
+	  This enables support for the two PCI functions implemented by
+	  the embedded PCIe endpoint in the Toshiba TC9564 SoC.  This
+	  driver uses a pci-ep-bus node in devicetree to provide MMIO
+	  access to other SoC devices through PCI function BARs.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e8d8d5d88c0df..7cc3d615d37a4 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -71,3 +71,4 @@ obj-y				+= keba/
 obj-y				+= amd-sbi/
 obj-$(CONFIG_MISC_RP1)		+= rp1/
 obj-$(CONFIG_INTEL_SSEI)	+= issei/
+obj-$(CONFIG_TC9564_PCI)	+= tc9564-pci.o
diff --git a/drivers/misc/tc9564-pci.c b/drivers/misc/tc9564-pci.c
new file mode 100644
index 0000000000000..d3ffcac1c522f
--- /dev/null
+++ b/drivers/misc/tc9564-pci.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2026 by RISCstar Solutions Corporation.  All rights reserved.
+ */
+
+/*
+ * The Toshiba TC9564 implements a PCIe Gen 3 switch that connects an
+ * upstream x4 port to three downstream PCIe ports.  Two of the downstream
+ * ports are external, and the third is internal, implementing a PCIe
+ * endpoint with implements two PCIe functions.  Each PCIe function drives
+ * a Synopsys XGMAC Ethernet interface capable of 10 Gbps operation.
+ *
+ * The TC9564 implements other functionality, including an embedded MCU,
+ * a UART, a GPIO controller, a reset controller, a clock controller, and
+ * interrupt handling.  These features are separate from (and in some
+ * cases used by) both Ethernet XGMACs.  Each Ethernet MAC must be
+ * attached to a working PHY for it to be functional, and for this
+ * reason either of them (or both!) might not be usable/used.
+ *
+ * This PCI driver binds to the Toshiba TC9564 (physical) PCI function
+ * (VID 0x1179, DID 0x0220).
+ */
+
+#include <linux/device.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/pci.h>
+
+#define DRIVER_NAME "tc9564-pci"
+
+static int
+tc9564_function_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np;
+	int ret;
+
+	/* Despite being a PCI device, we require devicetree */
+	np = dev_of_node(dev);
+	if (!np)
+		return dev_err_probe(dev, -EINVAL, "no devicetree node\n");
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	/* Scan for pci-ep-bus nodes and probe their sub-devices */
+	ret = of_platform_default_populate(np, NULL, dev);
+	if (ret)
+		goto err_clear_master;
+
+	return 0;
+
+err_clear_master:
+	pci_clear_master(pdev);
+
+	return dev_err_probe(dev, ret, "failed to populate platform bus\n");
+}
+
+static void tc9564_function_remove(struct pci_dev *pdev)
+{
+	of_platform_depopulate(&pdev->dev);
+	pci_clear_master(pdev);
+}
+
+static const struct pci_device_id tc9564_function_id_table[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_TOSHIBA, 0x0220), },
+	{ },
+};
+MODULE_DEVICE_TABLE(pci, tc9564_function_id_table);
+
+static struct pci_driver tc9564_function_driver = {
+	.name		= DRIVER_NAME,
+	.id_table	= tc9564_function_id_table,
+	.probe		= tc9564_function_probe,
+	.remove		= tc9564_function_remove,
+	.driver		= {
+		.name		= DRIVER_NAME,
+		.owner		= THIS_MODULE,
+	},
+};
+module_pci_driver(tc9564_function_driver);
+
+MODULE_DESCRIPTION("Toshiba TC9564 PCIe Embedded Function Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 6501c949c5b76..b484f1b1d0e71 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6388,6 +6388,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
 
 /*
  * Devices known to require a longer delay before first config space access
-- 
2.53.0

