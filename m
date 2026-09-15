Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DC2401494
	for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2026 03:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789441849; cv=none; b=Ye+CiNjhoxD1CnGYBSKQ7ZbozhQhIsGJEwWJ3etVcp1MuD6QenciGJvQcviz97Wjb+ePWVFYmA1s1coK6YaBoJk2tbSmkoOdauxLUvToCvBWlNQyQYX3aUxMw6/66u2w9923pD5ufG52WYv0L+KP4QjqpEoklLGaaqth9Z5op6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789441849; c=relaxed/simple;
	bh=fAaGvrwfjJOfTADcdh1TN24hqhxhJgV/1ppZMZA426k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NsLjY8EWQMcdsK+s5G/9rrevp7hOhH9emE6h/+b5xx7o16eC0BZOIBj6ySfiQHobJYPdMAzBiXGRIzLY2ipdJDZtZtbo6dybTFmXW+5HKmy8FJbLglkVzwS8mSSCJAsSdAp91N16Dn0/jwgGChPCRYbkT0SE+sQXsMEIPqV91vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=vvUd1hUU; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="vvUd1hUU"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76bcb1eso32221361cf.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Sep 2026 20:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1789441845; x=1790046645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/mETzuOCK8KbWleOPa3fHaf0TQUEDfgoZP7yhv9sCcg=;
        b=vvUd1hUUMGOwKERu00ICo3XqMqMOFcKru5VjCE4foMkgbJRf0UoftI/CTmjLnOrfQs
         f3TuqW8P0GpMn+iW+6RR5DxnextiO0Q5IDRpqsUOpYwKiHr9Pv0QJ+ZdmkRZ0l1UlsIV
         QMNtd0vToIqCU2yy0KR7r1bm4Zey08IcdBx17TYVsovjdBKQxi97xBWTCfxdbuK1QXzf
         2rzSVzEXUjfX+8J7BuCq0vFFFLE53tJYeoUtNZAjP4ol3GdfDrixwfDbBSEwR42Upvq+
         IiPwRVEGSxytq3z9AOV8QL/P/u0m0s5e1FwXDOwMlMt2cR+UlezWws90u+pXWwP2qbqL
         9Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789441845; x=1790046645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/mETzuOCK8KbWleOPa3fHaf0TQUEDfgoZP7yhv9sCcg=;
        b=LX1u8eI3kKlVsqXpKV70TK3GlFkZETu0XDzeDAGjPZxNoxDl0e/mwrU36tSDxOTYs/
         /shnbIvz8g/q6v4hoPbNCRtv+FRQkEKIp+YndNlEvClRDUndk8Tgbtv5sMI9XgONioE4
         N5okIQNwEXm71ilM/TbiLyYzeTdX2rfJJVbhobdEYGrVn1XqhrBkf3EKQ04/M+sDx99P
         rQj7ulSTr3iov3ORJqw9l+OwaGy8IywQCoFLy53SmvI8rMnAzcQCp24Y16tcGz3mN+Kv
         k+3drLuNaxmDpZwjzMN0P/5YMLm3rU9erIuvn/o7/x4LaXABOa4JkpE5tW3Pm1Cutr0h
         H7pA==
X-Forwarded-Encrypted: i=1; AKwUvBwQOorD2nM3Zc/6iPiqJEu0744T7cfiyeB8SotAwFjKJF9bk3BbVBUDZNSSFJ3GJtEIm1rvdVTa+0U=@vger.kernel.org
X-Gm-Message-State: AFuF++lsLu6x983lwPJXeR3ddUR6PgRIUj2jJvLjWMTV98JXd+PYUOM4
	PH7N99eTgCaTyIkkxIZnbo+zD2A3mAWsF+01pV7aj9BSvkD0GrexUSE7zSYlMbSmV8U=
X-Gm-Gg: AYBFou0D+/qelBELSWYpbkjRLwPwJNI+1hPZk2VW8VnaiDBiUFwLzAYWQDQIElKWkVe
	TBcNpHqjNRscunbbOj3vg7desH1YLD/SALdTpYHulz4weTlpYazmxFFUhFaD7XnQzucn/7rDXdt
	atyzxjN4rpCree3K9I/ed/Lik6Kh25xQq0e5ioLbXRBiFzfV4mVvxjDb4OGFCPWxDGKDrsVkrpm
	219aYCHQLVYFW2msyunIw5RXBIaEns52wdT92N5GbTNgdtQeMnMr8AXwoSaiDUdW4t8KYM/2mLc
	78hosW7Lpor/SUiBlwSchs/I7zEUJBQ/EPwQdPZiDuuWTFMpy7/p84Tv2wG19hRnZohypKOq6dJ
	qGZxe9jXo18B0ZWLsks7I64i2fSXYjryLZv24NV1XOmheIC5hgaUIfKBijVkm0QgoSBWe216TCO
	7wAial/yWlsMrSDJ1e3BcJ7l+jVFb5v03yuO/M/4LxQoKEQhUMRVsoei6cRsZjllPJxQ0UcaVIK
	nev
X-Received: by 2002:ac8:5a51:0:b0:530:318f:3086 with SMTP id d75a77b69052e-5310cf3c86dmr83737401cf.17.1789441844845;
        Mon, 14 Sep 2026 20:10:44 -0700 (PDT)
Received: from zippy.localdomain ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ce4ec298sm118563841cf.16.2026.09.14.20.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 20:10:44 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	bhelgaas@google.com,
	andersson@kernel.org,
	konradybcio@kernel.org,
	abelvesa@kernel.org
Cc: daniel@riscstar.com,
	mohdayaa@qti.qualcomm.com,
	lbiancon@qti.qualcomm.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] misc: tc9564: introduce base PCI driver
Date: Mon, 14 Sep 2026 22:10:36 -0500
Message-ID: <20260915031038.1087264-3-elder@riscstar.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915031038.1087264-1-elder@riscstar.com>
References: <20260915031038.1087264-1-elder@riscstar.com>
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

Co-developed-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Daniel Thompson <daniel@riscstar.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Use KBUILD_MODNAME for the driver name
    - Eliminate initializion pci_driver->driver

 MAINTAINERS               |  1 +
 drivers/misc/Kconfig      | 10 +++++
 drivers/misc/Makefile     |  1 +
 drivers/misc/tc9564-pci.c | 83 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/quirks.c      |  1 +
 5 files changed, 96 insertions(+)
 create mode 100644 drivers/misc/tc9564-pci.c

diff --git a/MAINTAINERS b/MAINTAINERS
index aa6b805e1ab2b..cf846853fdc79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27675,6 +27675,7 @@ M:	Alex Elder <elder@kernel.org>
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
index 0000000000000..d7ebbd90d1584
--- /dev/null
+++ b/drivers/misc/tc9564-pci.c
@@ -0,0 +1,83 @@
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
+	.name		= KBUILD_MODNAME,
+	.id_table	= tc9564_function_id_table,
+	.probe		= tc9564_function_probe,
+	.remove		= tc9564_function_remove,
+};
+module_pci_driver(tc9564_function_driver);
+
+MODULE_DESCRIPTION("Toshiba TC9564 PCIe Embedded Function Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index de9bbccda21fd..54e310c4153df 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6391,6 +6391,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TOSHIBA, 0x0220, of_pci_make_dev_node);
 
 /*
  * Devices known to require a longer delay before first config space access
-- 
2.53.0

