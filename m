Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:56984 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763211AbbA3WMA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jan 2015 17:12:00 -0500
Subject: [PATCH v2 2/3] Documentation: DT bindings: add more Tegra chip
 compatible strings
To: devicetree@vger.kernel.org
From: Paul Walmsley <paul@pwsan.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Wolfram Sang <wsa@the-dreams.de>, Takashi Iwai <tiwai@suse.de>,
	linux-pci@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-i2c@vger.kernel.org, Paul Walmsley <pwalmsley@nvidia.com>,
	linux-pm@vger.kernel.org, Alexandre Courbot <gnurou@gmail.com>,
	Terje =?utf-8?q?Bergstr=C3=B6m?= <tbergstrom@nvidia.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Dylan Reid <dgreid@chromium.org>, linux-pwm@vger.kernel.org,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Jingchang Lu <jingchang.lu@freescale.com>,
	Eduardo Valentin <edubezval@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sean Paul <seanpaul@chromium.org>, linux-tegra@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	John Crispin <blogic@openwrt.org>,
	Peter Hurley <peter@hurleysoftware.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Tuomas Tynkkynen <ttynkkynen@nvidia.com>,
	Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>
Date: Fri, 30 Jan 2015 15:11:04 -0700
Message-ID: <20150130221104.4761.4534.stgit@dusk.lan>
In-Reply-To: <20150130221104.4761.50643.stgit@dusk.lan>
References: <20150130221104.4761.50643.stgit@dusk.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Align compatible strings for several IP blocks present on Tegra chips
with the latest doctrine from the DT maintainers:

http://marc.info/?l=devicetree&m=142255654213019&w=2

The primary objective here is to avoid checkpatch warnings, per:

http://marc.info/?l=linux-tegra&m=142201349727836&w=2

DT binding text files have been updated for the following IP blocks:

- PCIe
- SOR
- SoC timers
- AHB "gizmo"
- APB_MISC
- pinmux control
- UART
- PWM
- I2C
- SPI
- RTC
- PMC
- eFuse
- AHCI
- HDA
- XUSB_PADCTRL
- SDHCI
- SOC_THERM
- AHUB
- I2S
- EHCI
- USB PHY

N.B. The nvidia,tegra20-timer compatible string is removed from the
nvidia,tegra30-timer.txt documentation file because it's already
mentioned in the nvidia,tegra20-timer.txt documentation file.

This second version takes into account the following requests from
Rob Herring <robherring2@gmail.com>:

- Per-IP block patches have been combined into a single patch

- Explicit documentation about which compatible strings are actually
  matched by the driver has been removed.  In its place is implicit
  documentation that loosely follows Rob's prescribed format:

  "Must contain '"nvidia,<chip>-pcie", "nvidia,tegra20-pcie"' where
   <chip> is tegra30, tegra132, ..." [...]  "You should attempt to
   document known values of <chip> if you use it"


Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Dylan Reid <dgreid@chromium.org>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Jingchang Lu <jingchang.lu@freescale.com>
Cc: John Crispin <blogic@openwrt.org>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: "Terje Bergström" <tbergstrom@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
---
 .../bindings/arm/tegra/nvidia,tegra20-ahb.txt      |    5 ++++-
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |    6 +++++-
 .../devicetree/bindings/ata/tegra-sata.txt         |    4 +++-
 .../bindings/fuse/nvidia,tegra20-fuse.txt          |   10 +++++-----
 .../bindings/gpu/nvidia,tegra20-host1x.txt         |    8 ++++++--
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |   10 +++++-----
 .../bindings/misc/nvidia,tegra20-apbmisc.txt       |    9 ++++-----
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          |    6 +++++-
 .../bindings/pci/nvidia,tegra20-pcie.txt           |    8 ++++----
 .../bindings/pinctrl/nvidia,tegra124-pinmux.txt    |    3 ++-
 .../pinctrl/nvidia,tegra124-xusb-padctl.txt        |    4 +++-
 .../devicetree/bindings/pwm/nvidia,tegra20-pwm.txt |    7 ++++---
 .../devicetree/bindings/rtc/nvidia,tegra20-rtc.txt |    4 +++-
 .../devicetree/bindings/serial/of-serial.txt       |    5 ++++-
 .../bindings/sound/nvidia,tegra30-ahub.txt         |    5 ++++-
 .../bindings/sound/nvidia,tegra30-hda.txt          |    4 +++-
 .../bindings/sound/nvidia,tegra30-i2s.txt          |    5 ++++-
 .../bindings/spi/nvidia,tegra114-spi.txt           |    4 +++-
 .../devicetree/bindings/thermal/tegra-soctherm.txt |    4 +++-
 .../bindings/timer/nvidia,tegra30-timer.txt        |    4 +++-
 .../bindings/usb/nvidia,tegra20-ehci.txt           |    5 ++++-
 .../bindings/usb/nvidia,tegra20-usb-phy.txt        |    5 ++++-
 22 files changed, 85 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
index 234406d41c12..067c9790062f 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
@@ -1,7 +1,10 @@
 NVIDIA Tegra AHB
 
 Required properties:
-- compatible : "nvidia,tegra20-ahb" or "nvidia,tegra30-ahb"
+- compatible : For Tegra20, must contain "nvidia,tegra20-ahb".  For
+  Tegra30, must contain "nvidia,tegra30-ahb".  Otherwise, must contain
+  '"nvidia,<chip>-ahb", "nvidia,tegra30-ahb"' where <chip> is tegra124,
+  tegra132, or tegra210.
 - reg : Should contain 1 register ranges(address and length)
 
 Example:
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 68ac65f82a1c..dd75b972ee37 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -6,7 +6,11 @@ modes. It provides power-gating controllers for SoC and CPU power-islands.
 
 Required properties:
 - name : Should be pmc
-- compatible : Should contain "nvidia,tegra<chip>-pmc".
+- compatible : For Tegra20, must contain "nvidia,tegra20-pmc".  For Tegra30,
+  must contain "nvidia,tegra30-pmc".  For Tegra114, must contain
+  "nvidia,tegra114-pmc".  For Tegra124, must contain "nvidia,tegra124-pmc".
+  Otherwise, must contain "nvidia,<chip>-pmc", plus at least one of the
+  above, where <chip> is tegra132.
 - reg : Offset and length of the register set for the device
 - clocks : Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
diff --git a/Documentation/devicetree/bindings/ata/tegra-sata.txt b/Documentation/devicetree/bindings/ata/tegra-sata.txt
index 946f2072570b..66c83c3e8915 100644
--- a/Documentation/devicetree/bindings/ata/tegra-sata.txt
+++ b/Documentation/devicetree/bindings/ata/tegra-sata.txt
@@ -1,7 +1,9 @@
 Tegra124 SoC SATA AHCI controller
 
 Required properties :
-- compatible : "nvidia,tegra124-ahci".
+- compatible : For Tegra124, must contain "nvidia,tegra124-ahci".  Otherwise,
+  must contain '"nvidia,<chip>-ahci", "nvidia,tegra124-ahci"', where <chip>
+  is tegra132.
 - reg : Should contain 2 entries:
   - AHCI register set (SATA BAR5)
   - SATA register set
diff --git a/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt b/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
index d8c98c7614d0..23e1d3194174 100644
--- a/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
+++ b/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
@@ -1,11 +1,11 @@
 NVIDIA Tegra20/Tegra30/Tegr114/Tegra124 fuse block.
 
 Required properties:
-- compatible : should be:
-	"nvidia,tegra20-efuse"
-	"nvidia,tegra30-efuse"
-	"nvidia,tegra114-efuse"
-	"nvidia,tegra124-efuse"
+- compatible : For Tegra20, must contain "nvidia,tegra20-efuse".  For Tegra30,
+  must contain "nvidia,tegra30-efuse".  For Tegra114, must contain
+  "nvidia,tegra114-efuse".  For Tegra124, must contain "nvidia,tegra124-efuse".
+  Otherwise, must contain "nvidia,<chip>-efuse", plus one of the above, where
+  <chip> is tegra132.
   Details:
   nvidia,tegra20-efuse: Tegra20 requires using APB DMA to read the fuse data
 	due to a hardware bug. Tegra20 also lacks certain information which is
diff --git a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
index 4c32ef0b7db8..009f4bfa1590 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
@@ -197,7 +197,9 @@ of the following host1x client modules:
 - sor: serial output resource
 
   Required properties:
-  - compatible: "nvidia,tegra124-sor"
+  - compatible: For Tegra124, must contain "nvidia,tegra124-sor".  Otherwise,
+    must contain '"nvidia,<chip>-sor", "nvidia,tegra124-sor"', where <chip>
+    is tegra132.
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
   - clocks: Must contain an entry for each entry in clock-names.
@@ -222,7 +224,9 @@ of the following host1x client modules:
   - nvidia,dpaux: phandle to a DispayPort AUX interface
 
 - dpaux: DisplayPort AUX interface
-  - compatible: "nvidia,tegra124-dpaux"
+  - compatible: For Tegra124, must contain "nvidia,tegra124-dpaux".  Otherwise,
+    must contain '"nvidia,<chip>-dpaux", "nvidia,tegra124-dpaux"', where
+    <chip> is tegra132.
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
   - clocks: Must contain an entry for each entry in clock-names.
diff --git a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
index 87507e9ce6db..656716b72cc4 100644
--- a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
@@ -1,11 +1,11 @@
 NVIDIA Tegra20/Tegra30/Tegra114 I2C controller driver.
 
 Required properties:
-- compatible : should be:
-	"nvidia,tegra114-i2c"
-	"nvidia,tegra30-i2c"
-	"nvidia,tegra20-i2c"
-	"nvidia,tegra20-i2c-dvc"
+- compatible : For Tegra20, must be one of "nvidia,tegra20-i2c-dvc" or
+  "nvidia,tegra20-i2c".  For Tegra30, must be "nvidia,tegra30-i2c".
+  For Tegra114, must be "nvidia,tegra114-i2c".  Otherwise, must be
+  "nvidia,<chip>-i2c", plus at least one of the above, where <chip> is
+  tegra124, tegra132, or tegra210.
   Details of compatible are as follows:
   nvidia,tegra20-i2c-dvc: Tegra20 has specific I2C controller called as DVC I2C
 	controller. This only support master mode of I2C communication. Register
diff --git a/Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt b/Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
index b97b8bef1fe5..47b205cc9cc7 100644
--- a/Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
+++ b/Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
@@ -1,11 +1,10 @@
 NVIDIA Tegra20/Tegra30/Tegr114/Tegra124 apbmisc block
 
 Required properties:
-- compatible : should be:
-       "nvidia,tegra20-apbmisc"
-       "nvidia,tegra30-apbmisc"
-       "nvidia,tegra114-apbmisc"
-       "nvidia,tegra124-apbmisc"
+- compatible : For Tegra20, must be "nvidia,tegra20-apbmisc".  For Tegra30,
+  must be "nvidia,tegra30-apbmisc".  Otherwise, must contain
+  "nvidia,<chip>-apbmisc", plus one of the above, where <chip> is tegra114,
+  tegra124, tegra132.
 - reg: Should contain 2 entries: the first entry gives the physical address
        and length of the registers which contain revision and debug features.
        The second entry gives the physical address and length of the
diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index f357c16ea815..15b8368ee1f2 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -7,7 +7,11 @@ This file documents differences between the core properties described
 by mmc.txt and the properties used by the sdhci-tegra driver.
 
 Required properties:
-- compatible : Should be "nvidia,<chip>-sdhci"
+- compatible : For Tegra20, must contain "nvidia,tegra20-sdhci".
+  For Tegra30, must contain "nvidia,tegra30-sdhci".  For Tegra114,
+  must contain "nvidia,tegra114-sdhci".  For Tegra124, must contain
+  "nvidia,tegra124-sdhci".  Otherwise, must contain "nvidia,<chip>-sdhci",
+  plus one of the above, where <chip> is tegra132 or tegra210.
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
 - resets : Must contain an entry for each entry in reset-names.
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index d763e047c6ae..75321ae23c08 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -1,10 +1,10 @@
 NVIDIA Tegra PCIe controller
 
 Required properties:
-- compatible: Must be one of:
-  - "nvidia,tegra20-pcie"
-  - "nvidia,tegra30-pcie"
-  - "nvidia,tegra124-pcie"
+- compatible: For Tegra20, must contain "nvidia,tegra20-pcie".  For Tegra30,
+  "nvidia,tegra30-pcie".  For Tegra124, must contain "nvidia,tegra124-pcie".
+  Otherwise, must contain "nvidia,<chip>-pcie", plus one of the above, where
+  <chip> is tegra132 or tegra210.
 - device_type: Must be "pci"
 - reg: A list of physical base address and length for each set of controller
   registers. Must contain an entry for each entry in the reg-names property.
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
index 189814e7cdc7..ecb5c0d25218 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
@@ -6,7 +6,8 @@ nvidia,tegra30-pinmux.txt. In fact, this document assumes that binding as
 a baseline, and only documents the differences between the two bindings.
 
 Required properties:
-- compatible: "nvidia,tegra124-pinmux"
+- compatible: For Tegra124, must contain "nvidia,tegra124-pinmux".  For
+  Tegra132, must contain '"nvidia,tegra132-pinmux", "nvidia-tegra124-pinmux"'.
 - reg: Should contain a list of base address and size pairs for:
     -- first entry - the drive strength and pad control registers.
     -- second entry - the pinmux registers
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
index 2f9c0bd66457..30676ded85bb 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt
@@ -13,7 +13,9 @@ how to describe and reference PHYs in device trees.
 
 Required properties:
 --------------------
-- compatible: should be "nvidia,tegra124-xusb-padctl"
+- compatible: For Tegra124, must contain "nvidia,tegra124-xusb-padctl".
+  Otherwise, must contain '"nvidia,<chip>-xusb-padctl",
+  "nvidia-tegra124-xusb-padctl"', where <chip> is tegra132 or tegra210.
 - reg: Physical base address and length of the controller's registers.
 - resets: Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index c7ea9d4a988b..c52f03b5032f 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -1,9 +1,10 @@
 Tegra SoC PWFM controller
 
 Required properties:
-- compatible: should be one of:
-  - "nvidia,tegra20-pwm"
-  - "nvidia,tegra30-pwm"
+- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".  For Tegra30,
+  must contain "nvidia,tegra30-pwm".  Otherwise, must contain
+  "nvidia,<chip>-pwm", plus one of the above, where <chip> is tegra114,
+  tegra124, tegra132, or tegra210.
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2. See pwm.txt in this directory for a description of
   the cells format.
diff --git a/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt b/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
index 652d1ff2e8be..b7d98ed3e098 100644
--- a/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
@@ -6,7 +6,9 @@ state.
 
 Required properties:
 
-- compatible : should be "nvidia,tegra20-rtc".
+- compatible : For Tegra20, must contain "nvidia,tegra20-rtc".  Otherwise,
+  must contain '"nvidia,<chip>-rtc", "nvidia,tegra20-rtc"', where <chip>
+  can be tegra30, tegra114, tegra124, or tegra132.
 - reg : Specifies base physical address and size of the registers.
 - interrupts : A single interrupt specifier.
 - clocks : Must contain one entry, for the module clock.
diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/of-serial.txt
index b52b98234b9b..bea60ef6cdc5 100644
--- a/Documentation/devicetree/bindings/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/serial/of-serial.txt
@@ -8,7 +8,10 @@ Required properties:
 	- "ns16550"
 	- "ns16750"
 	- "ns16850"
-	- "nvidia,tegra20-uart"
+	- For Tegra20, must contain "nvidia,tegra20-uart"
+	- For other Tegra, must contain '"nvidia,<chip>-uart",
+	  "nvidia,tegra20-uart"' where <chip> is tegra30, tegra114, tegra124,
+	  tegra132, or tegra210.
 	- "nxp,lpc3220-uart"
 	- "ralink,rt2880-uart"
 	- "ibm,qpace-nwp-serial"
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
index 946e2ac46091..0e9a1895d7fb 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
@@ -1,7 +1,10 @@
 NVIDIA Tegra30 AHUB (Audio Hub)
 
 Required properties:
-- compatible : "nvidia,tegra30-ahub", "nvidia,tegra114-ahub", etc.
+- compatible : For Tegra30, must contain "nvidia,tegra30-ahub".  For Tegra114,
+  must contain "nvidia,tegra114-ahub".  For Tegra124, must contain
+  "nvidia,tegra124-ahub".  Otherwise, must contain "nvidia,<chip>-ahub",
+  plus at least one of the above, where <chip> is tegra132.
 - reg : Should contain the register physical address and length for each of
   the AHUB's register blocks.
   - Tegra30 requires 2 entries, for the APBIF and AHUB/AUDIO register blocks.
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
index b4730c2822bc..13e2ef496724 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
@@ -1,7 +1,9 @@
 NVIDIA Tegra30 HDA controller
 
 Required properties:
-- compatible : "nvidia,tegra30-hda"
+- compatible : For Tegra30, must contain "nvidia,tegra30-hda".  Otherwise,
+  must contain '"nvidia,<chip>-hda", "nvidia,tegra30-hda"', where <chip> is
+  tegra114, tegra124, or tegra132.
 - reg : Should contain the HDA registers location and length.
 - interrupts : The interrupt from the HDA controller.
 - clocks : Must contain an entry for each required entry in clock-names.
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
index 0c113ffe3814..38caa936f6f8 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
@@ -1,7 +1,10 @@
 NVIDIA Tegra30 I2S controller
 
 Required properties:
-- compatible : "nvidia,tegra30-i2s"
+- compatible : For Tegra30, must contain "nvidia,tegra30-i2s".  For Tegra124,
+  must contain "nvidia,tegra124-i2s".  Otherwise, must contain
+  "nvidia,<chip>-i2s" plus at least one of the above, where <chip> is
+  tegra114 or tegra132.
 - reg : Should contain I2S registers location and length
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index 7ea701e07dc2..b785976fe98a 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -1,7 +1,9 @@
 NVIDIA Tegra114 SPI controller.
 
 Required properties:
-- compatible : should be "nvidia,tegra114-spi".
+- compatible : For Tegra114, must contain "nvidia,tegra114-spi".
+  Otherwise, must contain '"nvidia,<chip>-spi", "nvidia,tegra114-spi"' where
+  <chip> is tegra124, tegra132, or tegra210.
 - reg: Should contain SPI registers location and length.
 - interrupts: Should contain SPI interrupts.
 - clock-names : Must include the following entries:
diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
index ecf3ed76cd46..6b68cd150405 100644
--- a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
@@ -7,7 +7,9 @@ notifications. It is also used to manage emergency shutdown in an
 overheating situation.
 
 Required properties :
-- compatible : "nvidia,tegra124-soctherm".
+- compatible : For Tegra124, must contain "nvidia,tegra124-soctherm".
+  For Tegra132, must contain "nvidia,tegra132-soctherm".
+  For Tegra210, must contain "nvidia,tegra210-soctherm".
 - reg : Should contain 1 entry:
   - SOCTHERM register set
 - interrupts : Defines the interrupt used by SOCTHERM
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
index b5082a1cf461..1761f53ee36f 100644
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
@@ -6,7 +6,9 @@ trigger a legacy watchdog reset.
 
 Required properties:
 
-- compatible : should be "nvidia,tegra30-timer", "nvidia,tegra20-timer".
+- compatible : For Tegra30, must contain "nvidia,tegra30-timer".  Otherwise,
+  must contain '"nvidia,<chip>-timer", "nvidia,tegra30-timer"' where
+  <chip> is tegra124 or tegra132.
 - reg : Specifies base physical address and size of the registers.
 - interrupts : A list of 6 interrupts; one per each of timer channels 1
     through 5, and one for the shared interrupt for the remaining channels.
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
index 3dc9140e3dfb..f60785f73d3d 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
@@ -6,7 +6,10 @@ Practice : Universal Serial Bus" with the following modifications
 and additions :
 
 Required properties :
- - compatible : Should be "nvidia,tegra20-ehci".
+ - compatible : For Tegra20, must contain "nvidia,tegra20-ehci".
+   For Tegra30, must contain "nvidia,tegra30-ehci".  Otherwise, must contain
+   "nvidia,<chip>-ehci" plus at least one of the above, where <chip> is
+   tegra114, tegra124, tegra132, or tegra210.
  - nvidia,phy : phandle of the PHY that the controller is connected to.
  - clocks : Must contain one entry, for the module clock.
    See ../clocks/clock-bindings.txt for details.
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra20-usb-phy.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra20-usb-phy.txt
index c9205fbf26e2..a9aa79fb90ed 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra20-usb-phy.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra20-usb-phy.txt
@@ -3,7 +3,10 @@ Tegra SOC USB PHY
 The device node for Tegra SOC USB PHY:
 
 Required properties :
- - compatible : Should be "nvidia,tegra<chip>-usb-phy".
+ - compatible : For Tegra20, must contain "nvidia,tegra20-usb-phy".
+   For Tegra30, must contain "nvidia,tegra30-usb-phy".  Otherwise, must contain
+   "nvidia,<chip>-usb-phy" plus at least one of the above, where <chip> is
+   tegra114, tegra124, tegra132, or tegra210.
  - reg : Defines the following set of registers, in the order listed:
    - The PHY's own register set.
      Always present.


