Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B1D3D649C
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564554; cv=none; b=EOyAyQ9EIKAELSGEY3F5PSm0KRChLVS7aqLCX/zOCnVjmPSGVWN6+Y7paEDbzkM/h2uB3qvvxcJcMy7qopdtyHRiCA73y3+jk2iXxNbf6SCkByiHzPo+PnZYoowm97NqJ7f/XNVq+dwYFKM0k0EK9/FE2/0cXz4pg1NPTKHbArM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564554; c=relaxed/simple;
	bh=R/T3CJOHkumBOTdsCFY3y9gD6Z83uD/9OOYzP94H4X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QtRv3FK5GXLuyCC279H0ZyNVUp8sZZjgNy0do6Jm6z/ZlCqEMefwV7z21ZXiizZxOthlGUSx4yzI3KbxhiRut2XarlMA2i+PVX7naw9ibCaYyIM8gLdChQUDaGoEcuKSXyBwifn4ZBhCKuaq+mTj9jzTxS/8WReIobNc1tdpoXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5Hk7Hgi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Hk7Hgi"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d9b60c652aso19696995ad.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Sep 2026 16:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788564552; x=1789169352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T9SR8MFL6ur8khWC4xwaiSikwHQug9DE/oL2HooqNwI=;
        b=P5Hk7HgiwmB3gPbvUEbYR6UfwPTobxJ3yFXnJM7qJiFRmgsq5Uc/pRjgE2OYSL6rbB
         RMbjj4qkDiBmlBnD6gbYTxnugHsQ5VAF4xYy4dZaLWfa0DLmben4qtgW2/kRnDYTdzkU
         pumSYdD6au022MPigkfgb5+yfFLWVjsbh6ucIBGbuZIWsAZJTEZb/7F3L/yn5uwDuWyA
         zGb/phJqSSd3qhYhPnfVokWq0PK9O52HD0W7FgPFVzlJO4cVAcnitWtdx4d8uvHTgm7R
         VcSSN7kb0SpX6lN8duBvFabht86AFOWyioUPZlzhLBBC8KziPFGk6wxVbHfLXGirEbMc
         BlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788564552; x=1789169352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T9SR8MFL6ur8khWC4xwaiSikwHQug9DE/oL2HooqNwI=;
        b=HcSLnGZGY78pFQ/hS0UThSoU2KmGHvfzblRC/hrZ/LYiNZFWR9YNlg8eD1RiFSNe0p
         m0XL0TExae1Peab04jouhUtSG0LHN376zCtrovZEuqr4v6xGy8KDSzyvuRmTcdSDsNMF
         KFQTekGmdE83titLW1dc9kYLbuIiEp7Q8xy88EFfbtAkaNNukrTokQJXR3Dxmg1Iw27l
         oOfOTuNzKupNixFNIQPQliu9z0INJl3E2Biv26TSNPFOHPICsJXDOnEVBDYLI2YyWA/r
         cHnPBAzY/IOAYv9caU2sce5bDEDzY1SOSoGqL3LiX5DKZDjrs/8KNZid+BkUK2wz2Naw
         /ykQ==
X-Forwarded-Encrypted: i=1; AKwUvBwDbFyeBwmkcI9BGgaP3H0cnA2N65vpkSHWsAKWxvEmE6pTzqqj6XRf9NHLO9s1V84rwWHc0K0tFZI=@vger.kernel.org
X-Gm-Message-State: AFuF++m+ymEDsnkHTrNf79lvyOLXECuyApWhFDFBZsiayc60ewHK7GmC
	GMJ75xAYm2KraPDf0zy1aWPBTCNVmD7S9HZltoAl/PNafzWg0a7FwOBT
X-Gm-Gg: AYBFou1NRPydGFIpw7m7t6+KAxsL14RyFcfY1Ents/FKV9SwRswXEgDhmGt21RKSA6V
	vB4tu9u8xZCi1l6FXHl0PnR4OnW4Amrc/7atCXe3oixvAN495ZQpNzzQ0TPMluGxtYhdIgUiFpO
	/vZ+3q7U9ZeNDQzK5xvG/uHRg9O9dNg9hohx1v9ZRP5c3ncXYNV0KQAhB4JM9FO7zapKwzpwI2j
	FD0jO0CA+zSyyu7Ze2/qYH0IWrvRvdfq01TdyY0gEB1AlSMwtWPlt9O6uslHlO+Am0e3VTepGLd
	jdDju+oMkSG+JlmPSNfV68PlLPBAFeN5qaH8vhsnODcsKdkYx4WZi3KWKplp/Ab8gJgbWuFGo/+
	+YDeBCpAZamr/j0nQPyRzqvSg3AjTx6lBshC/CXc+OxWHrzxtE5310eYnRDtsxyps/vvLmx7FEU
	tkz6sj30iDtN6b+UR5hGEmzNgx8uUyGbW6Nl+AHN80vu7+hlbYGPYWsgMbqozXDR/IAZY0oshYi
	SA5uJ22aPOCo3FiUC9R4mtvwcuOHXF7
X-Received: by 2002:a17:903:144e:b0:2db:1020:c94e with SMTP id d9443c01a7336-2db128b7e4bmr159981595ad.22.1788564551486;
        Fri, 04 Sep 2026 16:29:11 -0700 (PDT)
Received: from Biostar-A520MT.. ([187.94.13.245])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-333959d5f69sm9053071eec.0.2026.09.04.16.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 16:29:10 -0700 (PDT)
From: Breno Rodrigues Alves <breno3011alves@gmail.com>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	linux-clk@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-fbdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Breno Rodrigues Alves <breno3011alves@gmail.com>
Subject: [PATCH v2] Kconfig: purge twenty-eight legacy ghost options (v2)
Date: Fri,  4 Sep 2026 20:29:04 -0300
Message-ID: <20260904232904.87530-1-breno3011alves@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Based on automated feedback from Sashiko AI, USB_CONFIGFS_F_TCM has
been retained. While it lacks explicit C code references, its menu
prompt acts as the critical visible anchor allowing users to compile
the underlying invisible USB_F_TCM core driver for ConfigFS use.

The other 28 ghost options remain fully verified dead weight.

Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>
---
 drivers/auxdisplay/Kconfig            |  8 -----
 drivers/clk/mediatek/Kconfig          | 42 ------------------------
 drivers/clk/sunxi/Kconfig             |  7 ----
 drivers/hid/Kconfig                   |  9 ------
 drivers/interconnect/mediatek/Kconfig |  6 ----
 drivers/media/dvb-core/Kconfig        | 11 -------
 drivers/media/platform/Kconfig        |  6 ----
 drivers/misc/Kconfig                  |  4 ---
 drivers/pci/controller/dwc/Kconfig    | 14 --------
 drivers/pci/pwrctrl/Kconfig           |  9 ------
 drivers/regulator/Kconfig             | 12 -------
 drivers/staging/media/Kconfig         | 13 --------
 drivers/usb/host/Kconfig              | 46 ---------------------------
 drivers/video/fbdev/core/Kconfig      |  6 ----
 security/apparmor/Kconfig             |  9 ------
 sound/soc/tegra/Kconfig               | 36 ---------------------
 16 files changed, 238 deletions(-)

diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 1ea7c0391..24acd0d39 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -541,11 +541,3 @@ config ARM_CHARLCD
 
 endif # AUXDISPLAY
 
-#
-# Deprecated options
-#
-config PANEL
-	tristate "Parallel port LCD/Keypad Panel support (OLD OPTION)"
-	depends on PARPORT
-	select AUXDISPLAY
-	select PARPORT_PANEL
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index b059d4457..94a8a0a6f 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -181,12 +181,6 @@ config COMMON_CLK_MT6765_CAMSYS
        help
          This driver supports MediaTek MT6765 camsys clocks.
 
-config COMMON_CLK_MT6765_GCESYS
-       tristate "Clock driver for MediaTek MT6765 gcesys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 gcesys clocks.
-
 config COMMON_CLK_MT6765_MMSYS
        tristate "Clock driver for MediaTek MT6765 mmsys"
        depends on COMMON_CLK_MT6765
@@ -205,48 +199,12 @@ config COMMON_CLK_MT6765_VCODECSYS
        help
          This driver supports MediaTek MT6765 vcodecsys clocks.
 
-config COMMON_CLK_MT6765_MFGSYS
-       tristate "Clock driver for MediaTek MT6765 mfgsys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mfgsys clocks.
-
 config COMMON_CLK_MT6765_MIPI0ASYS
        tristate "Clock driver for MediaTek MT6765 mipi0asys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi0asys clocks.
 
-config COMMON_CLK_MT6765_MIPI0BSYS
-       tristate "Clock driver for MediaTek MT6765 mipi0bsys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mipi0bsys clocks.
-
-config COMMON_CLK_MT6765_MIPI1ASYS
-       tristate "Clock driver for MediaTek MT6765 mipi1asys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mipi1asys clocks.
-
-config COMMON_CLK_MT6765_MIPI1BSYS
-       tristate "Clock driver for MediaTek MT6765 mipi1bsys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mipi1bsys clocks.
-
-config COMMON_CLK_MT6765_MIPI2ASYS
-       tristate "Clock driver for MediaTek MT6765 mipi2asys"
-       depends on COMMON_CLK_MT6765
-      help
-         This driver supports MediaTek MT6765 mipi2asys clocks.
-
-config COMMON_CLK_MT6765_MIPI2BSYS
-       tristate "Clock driver for MediaTek MT6765 mipi2bsys"
-       depends on COMMON_CLK_MT6765
-       help
-         This driver supports MediaTek MT6765 mipi2bsys clocks.
-
 config COMMON_CLK_MT6779
 	tristate "Clock driver for MediaTek MT6779"
 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
diff --git a/drivers/clk/sunxi/Kconfig b/drivers/clk/sunxi/Kconfig
index 5e2f92bfe..3ba500b9d 100644
--- a/drivers/clk/sunxi/Kconfig
+++ b/drivers/clk/sunxi/Kconfig
@@ -32,11 +32,4 @@ config CLK_SUNXI_PRCM_SUN8I
 	  Those are usually needed for the PMIC communication,
 	  mostly.
 
-config CLK_SUNXI_PRCM_SUN9I
-	bool "Legacy A80 PRCM driver"
-	default ARCH_SUNXI
-	help
-	  Legacy clock driver for the A80 PRCM clocks. Those are
-	  usually needed for the PMIC communication, mostly.
-
 endif
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index a81bf51cb..082dc3f5c 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1296,15 +1296,6 @@ config HID_TOPRE
 	  Say Y for N-key rollover support on Topre REALFORCE R2 108/87 key and
           Topre REALFORCE R3S 87 key keyboards.
 
-config HID_THINGM
-	tristate "ThingM blink(1) USB RGB LED"
-	depends on LEDS_CLASS
-	select HID_LED
-	help
-	Support for the ThingM blink(1) USB RGB LED. This driver has been
-	merged into the generic hid led driver. Config symbol HID_THINGM
-	just selects HID_LED and will be removed soon.
-
 config HID_THRUSTMASTER
 	tristate "ThrustMaster devices support"
 	depends on USB_HID
diff --git a/drivers/interconnect/mediatek/Kconfig b/drivers/interconnect/mediatek/Kconfig
index 9fd3f2170..a7aebfa1a 100644
--- a/drivers/interconnect/mediatek/Kconfig
+++ b/drivers/interconnect/mediatek/Kconfig
@@ -28,9 +28,3 @@ config INTERCONNECT_MTK_MT8195
 	  This is a driver for the MediaTek bus interconnect on MT8195-based
 	  platforms.
 
-config INTERCONNECT_MTK_MT8196
-	tristate "MediaTek MT8196 interconnect driver"
-	depends on INTERCONNECT_MTK_DVFSRC_EMI
-	help
-	  This is a driver for the MediaTek bus interconnect on MT8196-based
-	  platforms.
diff --git a/drivers/media/dvb-core/Kconfig b/drivers/media/dvb-core/Kconfig
index 8b3f2d53c..c6a97add8 100644
--- a/drivers/media/dvb-core/Kconfig
+++ b/drivers/media/dvb-core/Kconfig
@@ -67,14 +67,3 @@ config DVB_DEMUX_SECTION_LOSS_LOG
 
 	  If you are unsure about this, say N here.
 
-config DVB_ULE_DEBUG
-	bool "Enable DVB net ULE packet debug messages"
-	depends on DVB_CORE
-	help
-	  Enable extra log messages meant to detect problems while
-	  handling DVB network ULE packet loss inside the Kernel.
-
-	  Should not be enabled on normal cases, as logs can
-	  be very verbose.
-
-	  If you are unsure about this, say N here.
diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index 2c7699b66..dbef2275f 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -22,12 +22,6 @@ config SDR_PLATFORM_DRIVERS
 	help
 	  Say Y here to enable support for platform-specific SDR Drivers.
 
-config DVB_PLATFORM_DRIVERS
-	bool "DVB platform devices"
-	depends on MEDIA_DIGITAL_TV_SUPPORT
-	help
-	  Say Y here to enable support for platform-specific Digital TV drivers.
-
 config V4L_MEM2MEM_DRIVERS
 	bool "Memory-to-memory multimedia devices"
 	depends on VIDEO_DEV
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7364931da..2e37b3e08 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -434,10 +434,6 @@ config XILINX_SDFEC
 
 	  If unsure, say N.
 
-config MISC_RTSX
-	tristate
-	default MISC_RTSX_PCI || MISC_RTSX_USB
-
 config OPEN_DICE
 	tristate "Open Profile for DICE driver"
 	depends on OF_RESERVED_MEM
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index dcfbe7e22..c43b3bde5 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -121,20 +121,6 @@ config PCI_IMX6_HOST
 	  on DesignWare hardware and therefore the driver re-uses the
 	  DesignWare core functions to implement the driver.
 
-config PCI_IMX6_EP
-	bool "Freescale i.MX6/7/8 PCIe controller (endpoint mode)"
-	depends on ARCH_MXC || COMPILE_TEST
-	depends on PCI_ENDPOINT
-	select PCIE_DW_EP
-	select PCI_HOST_COMMON
-	select PCI_IMX6
-	select PCI_PWRCTRL_GENERIC
-	help
-	  Enables support for the PCIe controller in the i.MX SoCs to
-	  work in endpoint mode. The PCI controller on i.MX is based
-	  on DesignWare hardware and therefore the driver re-uses the
-	  DesignWare core functions to implement the driver.
-
 config PCI_LAYERSCAPE
 	tristate "Freescale Layerscape PCIe controller (host mode)"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
index 9eec767cd..853dd16b0 100644
--- a/drivers/pci/pwrctrl/Kconfig
+++ b/drivers/pci/pwrctrl/Kconfig
@@ -39,12 +39,3 @@ config PCI_PWRCTRL_TC9563
 	  MAC is connected as endpoint device. Other two downstream ports are
 	  supposed to connect to external device.
 
-# deprecated
-config HAVE_PWRCTL
-	bool
-	select HAVE_PWRCTRL
-
-# deprecated
-config PCI_PWRCTL_PWRSEQ
-	tristate
-	select PCI_PWRCTRL_PWRSEQ
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 89789ac7a..2c4d5b53e 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -22,7 +22,6 @@ menuconfig REGULATOR
 
 	  If unsure, say no.
 
-
 if REGULATOR
 
 config REGULATOR_DEBUG
@@ -900,16 +899,6 @@ config REGULATOR_MT6315
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
-config REGULATOR_MT6316
-	tristate "MT6316 SPMI PMIC regulator driver"
-	depends on SPMI
-	select REGMAP_SPMI
-	help
-	  Say Y here to enable support for 2+2, 3+1 and 4 phase regulators
-	  found in the MediaTek MT6316 BP, CP, DP, HP, VP and TP SPMI PMICs.
-	  This driver supports the control of different power rails of device
-	  through regulator interface.
-
 config REGULATOR_MT6323
 	tristate "MediaTek MT6323 PMIC"
 	depends on MFD_MT6397
@@ -1726,7 +1715,6 @@ config REGULATOR_TPS65185
 	  so it is found in E-Book readers.
 	  If HWWON is enabled, it also provides temperature measurement.
 
-
 config REGULATOR_TPS65217
 	tristate "TI TPS65217 Power regulators"
 	depends on MFD_TPS65217
diff --git a/drivers/staging/media/Kconfig b/drivers/staging/media/Kconfig
index 06cbc5c54..2d3e70b49 100644
--- a/drivers/staging/media/Kconfig
+++ b/drivers/staging/media/Kconfig
@@ -16,7 +16,6 @@ menuconfig STAGING_MEDIA
 
 	  If in doubt, say N here.
 
-
 if STAGING_MEDIA && MEDIA_SUPPORT
 
 # Please keep them in alphabetic order
@@ -38,16 +37,4 @@ source "drivers/staging/media/sunxi/Kconfig"
 
 source "drivers/staging/media/tegra-video/Kconfig"
 
-menuconfig STAGING_MEDIA_DEPRECATED
-	bool "Media staging drivers (DEPRECATED)"
-	default n
-	help
-	  This option enables deprecated media drivers that are
-	  scheduled for future removal from the kernel.
-
-	  If you wish to work on these drivers to prevent their removal,
-	  then contact the linux-media@vger.kernel.org mailing list.
-
-	  If in doubt, say N here.
-
 endif
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 10cff12a3..06999ba3d 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -281,20 +281,6 @@ config USB_EHCI_HCD_AT91
 	  Enables support for the on-chip EHCI controller on
 	  Atmel chips.
 
-config USB_EHCI_TEGRA
-	tristate "NVIDIA Tegra HCD support"
-	depends on ARCH_TEGRA
-	select USB_CHIPIDEA
-	select USB_CHIPIDEA_HOST
-	select USB_CHIPIDEA_TEGRA
-	select USB_GADGET
-	help
-	  This option is deprecated now and the driver was removed, use
-	  USB_CHIPIDEA_TEGRA instead.
-
-	  Enable support for the internal USB Host Controllers
-	  found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.
-
 config USB_EHCI_HCD_PPC_OF
 	bool "EHCI support for PPC USB controller on OF platform bus"
 	depends on PPC
@@ -530,23 +516,6 @@ config USB_OHCI_HCD_PCI
 	  Enables support for PCI-bus plug-in USB controller cards.
 	  If unsure, say Y.
 
-config USB_OHCI_HCD_SSB
-	bool "OHCI support for Broadcom SSB OHCI core (DEPRECATED)"
-	depends on (SSB = y || SSB = USB_OHCI_HCD)
-	select USB_HCD_SSB
-	select USB_OHCI_HCD_PLATFORM
-	help
-	  This option is deprecated now and the driver was removed, use
-	  USB_HCD_SSB and USB_OHCI_HCD_PLATFORM instead.
-
-	  Support for the Sonics Silicon Backplane (SSB) attached
-	  Broadcom USB OHCI core.
-
-	  This device is present in some embedded devices with
-	  Broadcom based SSB bus.
-
-	  If unsure, say N.
-
 config USB_OHCI_EXYNOS
 	tristate "OHCI support for Samsung S5P/Exynos SoC Series"
 	depends on ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
@@ -562,21 +531,6 @@ config USB_OHCI_HCD_PLATFORM
 
 	  If unsure, say N.
 
-config USB_OCTEON_OHCI
-	bool "Octeon on-chip OHCI support (DEPRECATED)"
-	depends on CAVIUM_OCTEON_SOC
-	default USB_OCTEON_EHCI
-	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
-	select USB_OHCI_LITTLE_ENDIAN
-	select USB_OHCI_HCD_PLATFORM
-	help
-	  This option is deprecated now and the driver was removed, use
-	  USB_OHCI_HCD_PLATFORM instead.
-
-	  Enable support for the Octeon II SOC's on-chip OHCI
-	  controller.  It is needed for low-speed USB 1.0 device
-	  support.  All CN6XXX based chips with USB are supported.
-
 endif # USB_OHCI_HCD
 
 config USB_UHCI_HCD
diff --git a/drivers/video/fbdev/core/Kconfig b/drivers/video/fbdev/core/Kconfig
index 8d1993e0b..14860a1ae 100644
--- a/drivers/video/fbdev/core/Kconfig
+++ b/drivers/video/fbdev/core/Kconfig
@@ -155,12 +155,6 @@ config FB_IOMEM_HELPERS
 	select FB_CFB_IMAGEBLIT
 	select FB_IOMEM_FOPS
 
-config FB_IOMEM_HELPERS_DEFERRED
-	bool
-	depends on FB_CORE
-	select FB_DEFERRED_IO
-	select FB_IOMEM_HELPERS
-
 config FB_SYSMEM_HELPERS
 	bool
 	depends on FB_CORE
diff --git a/security/apparmor/Kconfig b/security/apparmor/Kconfig
index a1f3749bd..508fd7f02 100644
--- a/security/apparmor/Kconfig
+++ b/security/apparmor/Kconfig
@@ -35,15 +35,6 @@ config SECURITY_APPARMOR_DEBUG_ASSERTS
 	  points. If the assert is triggered it will trigger a WARN
 	  message.
 
-config SECURITY_APPARMOR_DEBUG_MESSAGES
-	bool "Debug messages enabled by default"
-	depends on SECURITY_APPARMOR_DEBUG
-	default n
-	help
-	  Set the default value of the apparmor.debug kernel parameter.
-	  When enabled, various debug messages will be logged to
-	  the kernel message buffer.
-
 config SECURITY_APPARMOR_INTROSPECT_POLICY
 	bool "Allow loaded policy to be introspected"
 	depends on SECURITY_APPARMOR
diff --git a/sound/soc/tegra/Kconfig b/sound/soc/tegra/Kconfig
index fdc954028..e52f7cb9e 100644
--- a/sound/soc/tegra/Kconfig
+++ b/sound/soc/tegra/Kconfig
@@ -192,15 +192,6 @@ config SND_SOC_TEGRA_AUDIO_GRAPH_CARD
 config SND_SOC_TEGRA_MACHINE_DRV
 	tristate
 
-config SND_SOC_TEGRA_RT5631
-	tristate "SoC Audio support for Tegra boards using an RT5631 codec"
-	depends on SND_SOC_TEGRA && I2C && GPIOLIB
-	select SND_SOC_TEGRA_MACHINE_DRV
-	select SND_SOC_RT5631
-	help
-	  Say Y or M here if you want to add support for SoC audio on Tegra
-	  boards using the RT5631 codec, such as Transformer.
-
 config SND_SOC_TEGRA_RT5640
 	tristate "SoC Audio support for Tegra boards using an RT5640 codec"
 	depends on I2C && GPIOLIB
@@ -276,24 +267,6 @@ config SND_SOC_TEGRA_MAX98090
 	  Say Y or M here if you want to add support for SoC audio on Tegra
 	  boards using the MAX98090 codec, such as Venice2.
 
-config SND_SOC_TEGRA_MAX98088
-	tristate "SoC Audio support for Tegra boards using a MAX9808x codec"
-	depends on I2C && GPIOLIB
-	select SND_SOC_TEGRA_MACHINE_DRV
-	select SND_SOC_MAX98088
-	help
-	  Say Y or M here if you want to add support for SoC audio on Tegra
-	  boards using the MAX98088 codec, such as LG X3.
-
-config SND_SOC_TEGRA_RT5677
-	tristate "SoC Audio support for Tegra boards using a RT5677 codec"
-	depends on I2C && GPIOLIB
-	select SND_SOC_TEGRA_MACHINE_DRV
-	select SND_SOC_RT5677
-	help
-	  Say Y or M here if you want to add support for SoC audio on Tegra
-	  boards using the RT5677 codec, such as Ryu.
-
 config SND_SOC_TEGRA_SGTL5000
 	tristate "SoC Audio support for Tegra boards using a SGTL5000 codec"
 	depends on I2C && GPIOLIB
@@ -304,15 +277,6 @@ config SND_SOC_TEGRA_SGTL5000
 	  boards using the SGTL5000 codec, such as Apalis T30, Apalis TK1 or
 	  Colibri T30.
 
-config SND_SOC_TEGRA_CPCAP
-	tristate "SoC Audio support for Tegra boards using a CPCAP codec"
-	depends on I2C && GPIOLIB && MFD_CPCAP
-	select SND_SOC_TEGRA_MACHINE_DRV
-	select SND_SOC_CPCAP
-	help
-	  Say Y or M here if you want to add support for SoC audio on Tegra
-	  boards using the CPCAP codec, such as Motorola Atrix 4G or Droid X2.
-
 endif
 
 endmenu
-- 
2.43.0

