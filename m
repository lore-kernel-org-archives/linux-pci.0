Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38953 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731368AbeISULv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Sep 2018 16:11:51 -0400
From: Jim Quinlan <jim2101024@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jim Quinlan <jim2101024@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Jinbum Park <jinb.park7@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Stefan Agner <stefan@agner.ch>, Eric Anholt <eric@anholt.net>,
        Tony Lindgren <tony@atomide.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Olof Johansson <olof@lixom.net>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "Dirk Hohndel (VMware)" <dirk@hohndel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 12/12] ARM: add dma remap for BrcmSTB PCIe
Date: Wed, 19 Sep 2018 10:32:07 -0400
Message-Id: <1537367527-20773-13-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The BrcmSTB PCIe controller needs to remap DMA accesses to it because
of the requirements of its interface with the SOC memory controllers.
In the ARM64 and MIPs architectures, this is accomplished by
CONFIG_ARCH_HAS_PHYS_TO_DMA=y and then defining the functions
__dma_to_phys() and __phys_to_dma() accordingly.

Doing so for the ARM architecture is not as easy as ARM64 and MIPS;
the two functions are already defined as static inline functions.
Howevery, the behavior of these functions may be changed by redefining
the sub-functions that these two functions invoke.

Specifically, this commit defines

	__arch_pfn_to_dma()
	__arch_dma_to_pfn()
	__arch_dma_to_virt()
	__arch_virt_to_dma()

as these are the functions invoked by __dma_to_phys() and
__phys_to_dma().  Unfortunately, the only apparent approach to do this
is to declare and define the four sub-functions in
arch/arm/mach-bcm/include/mach/memory.h, and in doing so we must move
out of ARCH_MULTIPLATFORM and create brcmstb_defconfig, as we were
previously using multi_v7_defconfig.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/arm/Kconfig                            |  33 +++++
 arch/arm/configs/brcmstb_defconfig          | 204 ++++++++++++++++++++++++++++
 arch/arm/configs/multi_v7_defconfig         |   3 -
 arch/arm/mach-bcm/Kconfig                   |  21 +--
 arch/arm/mach-bcm/Makefile.boot             |   0
 arch/arm/mach-bcm/include/mach/irqs.h       |   3 +
 arch/arm/mach-bcm/include/mach/memory.h     |  47 +++++++
 arch/arm/mach-bcm/include/mach/uncompress.h |   8 ++
 8 files changed, 296 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/configs/brcmstb_defconfig
 create mode 100644 arch/arm/mach-bcm/Makefile.boot
 create mode 100644 arch/arm/mach-bcm/include/mach/irqs.h
 create mode 100644 arch/arm/mach-bcm/include/mach/memory.h
 create mode 100644 arch/arm/mach-bcm/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e8cd55a..913765b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -637,6 +637,39 @@ config ARCH_OMAP1
 	help
 	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
 
+config ARCH_BRCMSTB
+	bool "Broadcom BCM7XXX based boards"
+	select ARM_HAS_SG_CHAIN
+	select ARM_PATCH_PHYS_VIRT
+	select TIMER_OF
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
+	select USE_OF
+
+	select CPU_V7
+	select ARCH_BCM
+	select HAVE_SMP
+	select AUTO_ZRELADDR
+	select ARM_GIC
+	select ARM_GIC_V3
+	select HAVE_ARM_ARCH_TIMER
+	select SPARSE_IRQ
+	select BRCMSTB_L2_IRQ
+	select BCM7120_L2_IRQ
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
+	select ZONE_DMA if ARM_LPAE
+	select NEED_MACH_MEMORY_H
+	help
+	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
+	  chipset.
+
+	  This enables support for Broadcom ARM-based set-top box chipsets,
+	  including the 7445 family of chips.
+
 endchoice
 
 menu "Multiple platform selection"
diff --git a/arch/arm/configs/brcmstb_defconfig b/arch/arm/configs/brcmstb_defconfig
new file mode 100644
index 0000000..572fcf32
--- /dev/null
+++ b/arch/arm/configs/brcmstb_defconfig
@@ -0,0 +1,204 @@
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IRQ_TIME_ACCOUNTING=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_CGROUPS=y
+CONFIG_RELAY=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE="romfs"
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODVERSIONS=y
+CONFIG_PARTITION_ADVANCED=y
+CONFIG_ARCH_BRCMSTB=y
+CONFIG_ARM_LPAE=y
+CONFIG_ARM_THUMBEE=y
+CONFIG_ARM_ERRATA_430973=y
+CONFIG_ARM_ERRATA_720789=y
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_ARM_ERRATA_754327=y
+CONFIG_ARM_ERRATA_764369=y
+CONFIG_ARM_ERRATA_775420=y
+CONFIG_ARM_ERRATA_798181=y
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_MSI=y
+CONFIG_SMP=y
+CONFIG_MCPM=y
+CONFIG_NR_CPUS=16
+CONFIG_ARM_PSCI=y
+CONFIG_HZ_1000=y
+CONFIG_HIGHMEM=y
+CONFIG_CMA=y
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_EFI=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
+CONFIG_CPU_IDLE=y
+CONFIG_VFP=y
+CONFIG_PM_DEBUG=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_IP_MROUTE=y
+CONFIG_IP_PIMSM_V1=y
+CONFIG_IP_PIMSM_V2=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_UDP_DIAG=y
+CONFIG_TCP_CONG_ADVANCED=y
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_TCP_CONG_WESTWOOD is not set
+# CONFIG_TCP_CONG_HTCP is not set
+# CONFIG_IPV6 is not set
+CONFIG_BRIDGE=y
+CONFIG_NET_DSA=y
+CONFIG_CFG80211=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_ALIGNMENT=9
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_ROM=y
+CONFIG_MTD_ABSENT=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_BRCMNAND=y
+CONFIG_MTD_SPI_NOR=y
+# CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
+CONFIG_MTD_UBI=y
+CONFIG_MTD_UBI_GLUEBI=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_EEPROM_93CX6=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_BLK_DEV_SR=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_AHCI_BRCM=y
+CONFIG_NETDEVICES=y
+CONFIG_NET_DSA_BCM_SF2=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+CONFIG_BCMGENET=y
+CONFIG_SYSTEMPORT=y
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MELLANOX is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_USB_PEGASUS=y
+CONFIG_USB_USBNET=y
+# CONFIG_USB_NET_NET1080 is not set
+# CONFIG_USB_NET_CDC_SUBSET is not set
+# CONFIG_USB_NET_ZAURUS is not set
+CONFIG_INPUT_EVDEV=y
+CONFIG_MOUSE_PS2_ELANTECH=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_UINPUT=y
+# CONFIG_SERIO_SERPORT is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_HW_RANDOM=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_SPI=y
+CONFIG_SPI_BITBANG=y
+CONFIG_GPIOLIB=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_POWER_RESET=y
+# CONFIG_HWMON is not set
+CONFIG_MFD_SYSCON=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_USB_SUPPORT=y
+CONFIG_USB_GSPCA=y
+CONFIG_DRM=y
+CONFIG_SOUND=m
+CONFIG_SND=m
+CONFIG_SND_SOC=m
+CONFIG_USB=y
+CONFIG_USB_MON=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_MASS_STORAGE=y
+CONFIG_MMC=y
+CONFIG_MMC_BLOCK_MINORS=16
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_RTC_CLASS=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IIO=y
+CONFIG_INA2XX_ADC=y
+CONFIG_RESET_CONTROLLER=y
+CONFIG_PHY_BRCM_SATA=y
+CONFIG_EXT4_FS=y
+CONFIG_JBD2_DEBUG=y
+CONFIG_FUSE_FS=y
+CONFIG_CUSE=y
+CONFIG_ISO9660_FS=y
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+CONFIG_UBIFS_FS=y
+CONFIG_CRAMFS=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_LZO=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_NFS_V4_2=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_REDUCED=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_CRYPTO_HW is not set
+CONFIG_CRC_CCITT=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fc33444..33c91f8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -17,7 +17,6 @@ CONFIG_ARCH_AT91=y
 CONFIG_SOC_SAMA5D2=y
 CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
-CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM_CYGNUS=y
 CONFIG_ARCH_BCM_HR2=y
 CONFIG_ARCH_BCM_NSP=y
@@ -26,7 +25,6 @@ CONFIG_ARCH_BCM_281XX=y
 CONFIG_ARCH_BCM_21664=y
 CONFIG_ARCH_BCM2835=y
 CONFIG_ARCH_BCM_63XX=y
-CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_MACH_BERLIN_BG2=y
 CONFIG_MACH_BERLIN_BG2CD=y
@@ -229,7 +227,6 @@ CONFIG_B53_MMAP_DRIVER=m
 CONFIG_B53_SRAB_DRIVER=m
 CONFIG_NET_DSA_BCM_SF2=m
 CONFIG_SUN4I_EMAC=y
-CONFIG_BCMGENET=m
 CONFIG_BGMAC_BCMA=y
 CONFIG_SYSTEMPORT=m
 CONFIG_MACB=y
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 25aac6e..2c3ad42 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig ARCH_BCM
 	bool "Broadcom SoC Support"
-	depends on ARCH_MULTI_V6_V7
+	depends on ARCH_BRCMSTB
 	help
 	  This enables support for Broadcom ARM based SoC chips
 
@@ -203,23 +203,4 @@ config ARCH_BCM_63XX
 	  It currently supports the 'BCM63XX' ARM-based family, which includes
 	  the BCM63138 variant.
 
-config ARCH_BRCMSTB
-	bool "Broadcom BCM7XXX based boards"
-	depends on ARCH_MULTI_V7
-	select ARM_GIC
-	select ARM_ERRATA_798181 if SMP
-	select HAVE_ARM_ARCH_TIMER
-	select BRCMSTB_L2_IRQ
-	select BCM7120_L2_IRQ
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ZONE_DMA if ARM_LPAE
-	select SOC_BRCMSTB
-	select SOC_BUS
-	help
-	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
-	  chipset.
-
-	  This enables support for Broadcom ARM-based set-top box chipsets,
-	  including the 7445 family of chips.
-
 endif
diff --git a/arch/arm/mach-bcm/Makefile.boot b/arch/arm/mach-bcm/Makefile.boot
new file mode 100644
index 0000000..e69de29
diff --git a/arch/arm/mach-bcm/include/mach/irqs.h b/arch/arm/mach-bcm/include/mach/irqs.h
new file mode 100644
index 0000000..f1f3f22
--- /dev/null
+++ b/arch/arm/mach-bcm/include/mach/irqs.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define NR_IRQS NR_IRQS_LEGACY
diff --git a/arch/arm/mach-bcm/include/mach/memory.h b/arch/arm/mach-bcm/include/mach/memory.h
new file mode 100644
index 0000000..a90a216
--- /dev/null
+++ b/arch/arm/mach-bcm/include/mach/memory.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_ARCH_MEMORY_H__
+#define __ASM_ARCH_MEMORY_H__
+#ifndef __ASSEMBLY__
+
+struct device;
+
+#include <soc/brcmstb/common.h>
+
+#ifdef CONFIG_PCIE_BRCMSTB
+#define __arch_pfn_to_dma(dev, pfn)					\
+	({								\
+		if (dev)						\
+			pfn -= dev->dma_pfn_offset;			\
+		(dma_addr_t)brcm_phys_to_dma(dev, __pfn_to_phys(pfn));	\
+	})
+
+#define  __arch_dma_to_pfn(dev, addr)					\
+	({								\
+		unsigned long pfn = __phys_to_pfn(brcm_dma_to_phys(dev, addr));\
+		if (dev)						\
+			pfn += dev->dma_pfn_offset;			\
+		pfn;							\
+	})
+
+#define __arch_dma_to_virt(dev, addr)					\
+	({								\
+		void *v;						\
+		if (dev) {						\
+			unsigned long pfn = dma_to_pfn(dev, addr);	\
+			v = phys_to_virt(__pfn_to_phys(pfn));		\
+		} else {						\
+			v = (void *)__bus_to_virt((unsigned long)addr);	\
+		}							\
+		v;							\
+	})
+
+#define __arch_virt_to_dma(dev, addr)					\
+	({								\
+		(dev) ? pfn_to_dma(dev, virt_to_pfn(addr))		\
+		      : (dma_addr_t)__virt_to_bus((unsigned long)(addr));\
+	})
+
+#endif /* CONFIG_PCIE_BRCMSTB */
+#endif /* __ASSEMBLY__ */
+#endif /* __ASM_ARCH_MEMORY_H__ */
diff --git a/arch/arm/mach-bcm/include/mach/uncompress.h b/arch/arm/mach-bcm/include/mach/uncompress.h
new file mode 100644
index 0000000..b297333
--- /dev/null
+++ b/arch/arm/mach-bcm/include/mach/uncompress.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef CONFIG_DEBUG_UNCOMPRESS
+void putc(int c);
+#else
+static inline void putc(int c) {}
+#endif
+static inline void flush(void) {}
+static inline void arch_decomp_setup(void) {}
-- 
1.9.0.138.g2de3478
