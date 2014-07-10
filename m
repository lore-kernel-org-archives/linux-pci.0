Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:55025 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561AbaGJH2B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jul 2014 03:28:01 -0400
Received: by mail-pd0-f181.google.com with SMTP id v10so10382125pde.12
        for <linux-pci@vger.kernel.org>; Thu, 10 Jul 2014 00:28:00 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: arnd@linaro.org, olof@lixom.net
Cc: linux-arm-kernel@lists.infradead.org, spear-devel@list.st.com,
	b.zolnierkie@samsung.com, bhelgaas@google.com, mark@nicholnet.com,
	linux-pci@vger.kernel.org, Mohit Kumar <mohit.kumar@st.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V9 7/7] ARM: SPEAr13xx: Update defconfigs
Date: Thu, 10 Jul 2014 12:56:38 +0530
Message-Id: <94293b09b77d64a9bfbfd71e1906abfbb49280ca.1404976059.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404976058.git.viresh.kumar@linaro.org>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mohit Kumar <mohit.kumar@st.com>

Enable PCIe, EABI, VFP and NFS configs in default configuration file for
SPEAr13xx.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
[viresh: fixed logs/cclist]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/configs/spear13xx_defconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index 82eaa55..d271b26 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -11,13 +11,24 @@ CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
 CONFIG_MACH_SPEAR1340=y
 # CONFIG_SWP_EMULATE is not set
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_SPEAR13XX=y
 CONFIG_SMP=y
 # CONFIG_SMP_ON_UP is not set
 # CONFIG_ARM_CPU_TOPOLOGY is not set
+CONFIG_AEABI=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_VFP=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_NET_IPIP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
 CONFIG_MTD_OF_PARTS=y
@@ -27,6 +38,7 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSMC=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 # CONFIG_SATA_PMP is not set
 CONFIG_SATA_AHCI_PLATFORM=y
@@ -66,6 +78,7 @@ CONFIG_USB=y
 # CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SPEAR=y
@@ -79,11 +92,14 @@ CONFIG_EXT2_FS_SECURITY=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_SECURITY=y
 CONFIG_AUTOFS4_FS=m
+CONFIG_FUSE_FS=y
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=m
-- 
2.0.0.rc2

