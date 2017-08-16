Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 00/10] ARM: dts: Add iodelay data for MMC
Date: Wed, 16 Aug 2017 19:14:58 +0530
Message-ID: <20170816134508.8887-1-kishon@ti.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This series only adds data and it won't be used until
the next series which adds UHS support to omap_hsmmc/sdhci driver.

Changes from v1:
*) Add missing Signed-off-by in a couple of patches
*) Fixed Author of "Move common MMC/SD properties to common file" patch.

Kishon Vijay Abraham I (7):
  ARM: dts: dra7-evm: Add pinmux configuration for MMC
  ARM: dts: am57xx-beagle-x15: Add pinmux configuration for MMC
  ARM: dts: am571x-idk: Add pinmux configuration for MMC
  ARM: dts: am572x-idk: Add pinmux configuration for MMC
  ARM: dts: dra72-evm: Add pinmux configuration for MMC
  ARM: dts: dra72-evm-revc: Add pinmux configuration for MMC
  ARM: dts: dra71-evm: Add pinmux configuration for MMC

Sekhar Nori (3):
  ARM: dts: dra72x: Create a common file with MMC/SD IOdelay data
  ARM: dts: dra74x: Create a common file with MMC/SD IOdelay data
  ARM: dts: am57xx-idk: Move common MMC/SD properties to common file

 arch/arm/boot/dts/am571x-idk.dts                |  26 +-
 arch/arm/boot/dts/am572x-idk.dts                |  27 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  29 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts   |  15 +
 arch/arm/boot/dts/am57xx-beagle-x15.dts         |  11 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |   8 +
 arch/arm/boot/dts/dra7-evm.dts                  |  22 +-
 arch/arm/boot/dts/dra71-evm.dts                 |  14 +
 arch/arm/boot/dts/dra72-evm-revc.dts            |  14 +
 arch/arm/boot/dts/dra72-evm.dts                 |  14 +
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi       | 350 +++++++++++++
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi       | 647 ++++++++++++++++++++++++
 12 files changed, 1130 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi

-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
