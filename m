Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>, <bcousson@baylibre.com>
Subject: [PATCH 6/7] ARM: omap2plus_defconfig: Enable CONFIG_PCI_DRA7XX (Host
 & Device modes)
Date: Tue, 19 Dec 2017 15:01:32 +0530
Message-ID: <20171219093133.16565-7-kishon@ti.com>
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
References: <20171219093133.16565-1-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 kishon@ti.com, linux-pci@vger.kernel.org, nsekhar@ti.com,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Enable CONFIG_PCI_DRA7XX in order to be able to configure PCIe
controller present in dra7 SoCs in both host mode and device mode.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 7b97200c1d64..a01871d5aa73 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -48,6 +48,13 @@ CONFIG_SOC_AM43XX=y
 CONFIG_SOC_DRA7XX=y
 CONFIG_ARM_THUMBEE=y
 CONFIG_ARM_ERRATA_411920=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCI_DRA7XX=y
+CONFIG_PCI_DRA7XX_EP=y
+CONFIG_PCI_ENDPOINT=y
+CONFIG_PCI_ENDPOINT_CONFIGFS=y
+CONFIG_PCI_EPF_TEST=m
 CONFIG_SMP=y
 CONFIG_NR_CPUS=2
 CONFIG_CMA=y
@@ -137,6 +144,7 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_TSL2550=m
 CONFIG_SRAM=y
+CONFIG_PCI_ENDPOINT_TEST=m
 CONFIG_EEPROM_AT24=m
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_SCAN_ASYNC=y
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
