Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:48089 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759611AbbA3DGL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jan 2015 22:06:11 -0500
Date: Fri, 30 Jan 2015 03:06:10 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Rob Herring <robherring2@gmail.com>
cc: Mark Rutland <mark.rutland@arm.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 02/24] Documentation: DT bindings: add more chip compatible
 strings for Tegra PCIe
In-Reply-To: <alpine.DEB.2.02.1501291846340.16475@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1501300304040.6569@utopia.booyaka.com>
References: <20150128234935.20644.89300.stgit@dusk.lan> <20150128234937.20644.9400.stgit@dusk.lan> <CAL_JsqKMm=r+57ShskgbtNqnCGF1yKYDSJJFQ7o05keNzh5z+g@mail.gmail.com> <alpine.DEB.2.02.1501291543030.16475@utopia.booyaka.com>
 <CAL_JsqLE+W+T5YqzdB+DkdBE+HsgySX0yJHzn1y43QDfw4GA9A@mail.gmail.com> <alpine.DEB.2.02.1501291707350.16475@utopia.booyaka.com> <CAL_JsqKaDi1cZN8Ndb0FPhvgRVFyxc1NRhV2cx-XJ323wTKiEQ@mail.gmail.com> <alpine.DEB.2.02.1501291846340.16475@utopia.booyaka.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="843723315-1869901017-1422587170=:6569"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--843723315-1869901017-1422587170=:6569
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Rob,

I've implemented the changes that you requested.  Could you give this a=20
quick look and see if it's sufficiently close to what you wanted?  Will=20
plan to repost the entire (much smaller) series tomorrow.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Thu, 29 Jan 2015 18:41:18 -0700
Subject: [PATCH] Documentation: DT bindings: add more Tegra chip
 compatible strings

Align compatible strings for several IP blocks present on Tegra chips
with the latest doctrine from the DT maintainers:

http://marc.info/?l=3Ddevicetree&m=3D142255654213019&w=3D2

The primary objective here is to avoid checkpatch warnings, per:

http://marc.info/?l=3Dlinux-tegra&m=3D142201349727836&w=3D2

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
Cc: "Terje Bergstr=F6m" <tbergstrom@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: linux-pwm@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
---
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt       |  5 ++++-
 .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt       |  6 +++++-
 Documentation/devicetree/bindings/ata/tegra-sata.txt           |  4 +++-
 Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt | 10 +++++-=
----
 .../devicetree/bindings/gpu/nvidia,tegra20-host1x.txt          |  8 ++++++=
--
 Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt   | 10 +++++-=
----
 .../devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt        |  9 ++++--=
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt |  6 +++++-
 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt  |  8 ++++--=
--
 .../devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt     |  3 ++-
 .../bindings/pinctrl/nvidia,tegra124-xusb-padctl.txt           |  4 +++-
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt   |  7 ++++--=
-
 Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt   |  4 +++-
 Documentation/devicetree/bindings/serial/of-serial.txt         |  5 ++++-
 .../devicetree/bindings/sound/nvidia,tegra30-ahub.txt          |  5 ++++-
 Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt |  4 +++-
 Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt |  5 ++++-
 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt  |  4 +++-
 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt   |  4 +++-
 .../devicetree/bindings/timer/nvidia,tegra30-timer.txt         |  4 +++-
 Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt  |  5 ++++-
 .../devicetree/bindings/usb/nvidia,tegra20-usb-phy.txt         |  5 ++++-
 22 files changed, 85 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb=
=2Etxt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
index 234406d41c12..067c9790062f 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-ahb.txt
@@ -1,7 +1,10 @@
 NVIDIA Tegra AHB
=20
 Required properties:
-- compatible : "nvidia,tegra20-ahb" or "nvidia,tegra30-ahb"
+- compatible : For Tegra20, must contain "nvidia,tegra20-ahb".  For
+  Tegra30, must contain "nvidia,tegra30-ahb".  Otherwise, must contain
+  '"nvidia,<chip>-ahb", "nvidia,tegra30-ahb"' where <chip> is tegra124,
+  tegra132, or tegra210.
 - reg : Should contain 1 register ranges(address and length)
=20
 Example:
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc=
=2Etxt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
index 68ac65f82a1c..dd75b972ee37 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
@@ -6,7 +6,11 @@ modes. It provides power-gating controllers for SoC and CP=
U power-islands.
=20
 Required properties:
 - name : Should be pmc
-- compatible : Should contain "nvidia,tegra<chip>-pmc".
+- compatible : For Tegra20, must contain "nvidia,tegra20-pmc".  For Tegra3=
0,
+  must contain "nvidia,tegra30-pmc".  For Tegra114, must contain
+  "nvidia,tegra114-pmc".  For Tegra124, must contain "nvidia,tegra124-pmc"=
=2E
+  Otherwise, must contain "nvidia,<chip>-pmc", plus at least one of the
+  above, where <chip> is tegra132.
 - reg : Offset and length of the register set for the device
 - clocks : Must contain an entry for each entry in clock-names.
   See ../clocks/clock-bindings.txt for details.
diff --git a/Documentation/devicetree/bindings/ata/tegra-sata.txt b/Documen=
tation/devicetree/bindings/ata/tegra-sata.txt
index 946f2072570b..66c83c3e8915 100644
--- a/Documentation/devicetree/bindings/ata/tegra-sata.txt
+++ b/Documentation/devicetree/bindings/ata/tegra-sata.txt
@@ -1,7 +1,9 @@
 Tegra124 SoC SATA AHCI controller
=20
 Required properties :
-- compatible : "nvidia,tegra124-ahci".
+- compatible : For Tegra124, must contain "nvidia,tegra124-ahci".  Otherwi=
se,
+  must contain '"nvidia,<chip>-ahci", "nvidia,tegra124-ahci"', where <chip=
>
+  is tegra132.
 - reg : Should contain 2 entries:
   - AHCI register set (SATA BAR5)
   - SATA register set
diff --git a/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt=
 b/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
index d8c98c7614d0..23e1d3194174 100644
--- a/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
+++ b/Documentation/devicetree/bindings/fuse/nvidia,tegra20-fuse.txt
@@ -1,11 +1,11 @@
 NVIDIA Tegra20/Tegra30/Tegr114/Tegra124 fuse block.
=20
 Required properties:
-- compatible : should be:
-=09"nvidia,tegra20-efuse"
-=09"nvidia,tegra30-efuse"
-=09"nvidia,tegra114-efuse"
-=09"nvidia,tegra124-efuse"
+- compatible : For Tegra20, must contain "nvidia,tegra20-efuse".  For Tegr=
a30,
+  must contain "nvidia,tegra30-efuse".  For Tegra114, must contain
+  "nvidia,tegra114-efuse".  For Tegra124, must contain "nvidia,tegra124-ef=
use".
+  Otherwise, must contain "nvidia,<chip>-efuse", plus one of the above, wh=
ere
+  <chip> is tegra132.
   Details:
   nvidia,tegra20-efuse: Tegra20 requires using APB DMA to read the fuse da=
ta
 =09due to a hardware bug. Tegra20 also lacks certain information which is
diff --git a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.tx=
t b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
index 4c32ef0b7db8..009f4bfa1590 100644
--- a/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
@@ -197,7 +197,9 @@ of the following host1x client modules:
 - sor: serial output resource
=20
   Required properties:
-  - compatible: "nvidia,tegra124-sor"
+  - compatible: For Tegra124, must contain "nvidia,tegra124-sor".  Otherwi=
se,
+    must contain '"nvidia,<chip>-sor", "nvidia,tegra124-sor"', where <chip=
>
+    is tegra132.
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
   - clocks: Must contain an entry for each entry in clock-names.
@@ -222,7 +224,9 @@ of the following host1x client modules:
   - nvidia,dpaux: phandle to a DispayPort AUX interface
=20
 - dpaux: DisplayPort AUX interface
-  - compatible: "nvidia,tegra124-dpaux"
+  - compatible: For Tegra124, must contain "nvidia,tegra124-dpaux".  Other=
wise,
+    must contain '"nvidia,<chip>-dpaux", "nvidia,tegra124-dpaux"', where
+    <chip> is tegra132.
   - reg: Physical base address and length of the controller's registers.
   - interrupts: The interrupt outputs from the controller.
   - clocks: Must contain an entry for each entry in clock-names.
diff --git a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt b=
/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
index 87507e9ce6db..656716b72cc4 100644
--- a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.txt
@@ -1,11 +1,11 @@
 NVIDIA Tegra20/Tegra30/Tegra114 I2C controller driver.
=20
 Required properties:
-- compatible : should be:
-=09"nvidia,tegra114-i2c"
-=09"nvidia,tegra30-i2c"
-=09"nvidia,tegra20-i2c"
-=09"nvidia,tegra20-i2c-dvc"
+- compatible : For Tegra20, must be one of "nvidia,tegra20-i2c-dvc" or
+  "nvidia,tegra20-i2c".  For Tegra30, must be "nvidia,tegra30-i2c".
+  For Tegra114, must be "nvidia,tegra114-i2c".  Otherwise, must be
+  "nvidia,<chip>-i2c", plus at least one of the above, where <chip> is
+  tegra124, tegra132, or tegra210.
   Details of compatible are as follows:
   nvidia,tegra20-i2c-dvc: Tegra20 has specific I2C controller called as DV=
C I2C
 =09controller. This only support master mode of I2C communication. Registe=
r
diff --git a/Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.=
txt b/Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
index b97b8bef1fe5..47b205cc9cc7 100644
--- a/Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
+++ b/Documentation/devicetree/bindings/misc/nvidia,tegra20-apbmisc.txt
@@ -1,11 +1,10 @@
 NVIDIA Tegra20/Tegra30/Tegr114/Tegra124 apbmisc block
=20
 Required properties:
-- compatible : should be:
-       "nvidia,tegra20-apbmisc"
-       "nvidia,tegra30-apbmisc"
-       "nvidia,tegra114-apbmisc"
-       "nvidia,tegra124-apbmisc"
+- compatible : For Tegra20, must be "nvidia,tegra20-apbmisc".  For Tegra30=
,
+  must be "nvidia,tegra30-apbmisc".  Otherwise, must contain
+  "nvidia,<chip>-apbmisc", plus one of the above, where <chip> is tegra114=
,
+  tegra124, tegra132.
 - reg: Should contain 2 entries: the first entry gives the physical addres=
s
        and length of the registers which contain revision and debug featur=
es.
        The second entry gives the physical address and length of the
diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt=
 b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index f357c16ea815..15b8368ee1f2 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -7,7 +7,11 @@ This file documents differences between the core propertie=
s described
 by mmc.txt and the properties used by the sdhci-tegra driver.
=20
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
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt =
b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
index d763e047c6ae..75321ae23c08 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
@@ -1,10 +1,10 @@
 NVIDIA Tegra PCIe controller
=20
 Required properties:
-- compatible: Must be one of:
-  - "nvidia,tegra20-pcie"
-  - "nvidia,tegra30-pcie"
-  - "nvidia,tegra124-pcie"
+- compatible: For Tegra20, must contain "nvidia,tegra20-pcie".  For Tegra3=
0,
+  "nvidia,tegra30-pcie".  For Tegra124, must contain "nvidia,tegra124-pcie=
".
+  Otherwise, must contain "nvidia,<chip>-pcie", plus one of the above, whe=
re
+  <chip> is tegra132 or tegra210.
 - device_type: Must be "pci"
 - reg: A list of physical base address and length for each set of controll=
er
   registers. Must contain an entry for each entry in the reg-names propert=
y.
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinm=
ux.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.t=
xt
index 189814e7cdc7..ecb5c0d25218 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-pinmux.txt
@@ -6,7 +6,8 @@ nvidia,tegra30-pinmux.txt. In fact, this document assumes t=
hat binding as
 a baseline, and only documents the differences between the two bindings.
=20
 Required properties:
-- compatible: "nvidia,tegra124-pinmux"
+- compatible: For Tegra124, must contain "nvidia,tegra124-pinmux".  For
+  Tegra132, must contain '"nvidia,tegra132-pinmux", "nvidia-tegra124-pinmu=
x"'.
 - reg: Should contain a list of base address and size pairs for:
     -- first entry - the drive strength and pad control registers.
     -- second entry - the pinmux registers
diff --git a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb=
-padctl.txt b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xus=
b-padctl.txt
index 2f9c0bd66457..30676ded85bb 100644
--- a/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl=
=2Etxt
+++ b/Documentation/devicetree/bindings/pinctrl/nvidia,tegra124-xusb-padctl=
=2Etxt
@@ -13,7 +13,9 @@ how to describe and reference PHYs in device trees.
=20
 Required properties:
 --------------------
-- compatible: should be "nvidia,tegra124-xusb-padctl"
+- compatible: For Tegra124, must contain "nvidia,tegra124-xusb-padctl".
+  Otherwise, must contain '"nvidia,<chip>-xusb-padctl",
+  "nvidia-tegra124-xusb-padctl"', where <chip> is tegra132 or tegra210.
 - reg: Physical base address and length of the controller's registers.
 - resets: Must contain an entry for each entry in reset-names.
   See ../reset/reset.txt for details.
diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b=
/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index c7ea9d4a988b..c52f03b5032f 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -1,9 +1,10 @@
 Tegra SoC PWFM controller
=20
 Required properties:
-- compatible: should be one of:
-  - "nvidia,tegra20-pwm"
-  - "nvidia,tegra30-pwm"
+- compatible: For Tegra20, must contain "nvidia,tegra20-pwm".  For Tegra30=
,
+  must contain "nvidia,tegra30-pwm".  Otherwise, must contain
+  "nvidia,<chip>-pwm", plus one of the above, where <chip> is tegra114,
+  tegra124, tegra132, or tegra210.
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2. See pwm.txt in this directory for a description=
 of
   the cells format.
diff --git a/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt b=
/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
index 652d1ff2e8be..b7d98ed3e098 100644
--- a/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/nvidia,tegra20-rtc.txt
@@ -6,7 +6,9 @@ state.
=20
 Required properties:
=20
-- compatible : should be "nvidia,tegra20-rtc".
+- compatible : For Tegra20, must contain "nvidia,tegra20-rtc".  Otherwise,
+  must contain '"nvidia,<chip>-rtc", "nvidia,tegra20-rtc"', where <chip>
+  can be tegra30, tegra114, tegra124, or tegra132.
 - reg : Specifies base physical address and size of the registers.
 - interrupts : A single interrupt specifier.
 - clocks : Must contain one entry, for the module clock.
diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Docum=
entation/devicetree/bindings/serial/of-serial.txt
index b52b98234b9b..bea60ef6cdc5 100644
--- a/Documentation/devicetree/bindings/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/serial/of-serial.txt
@@ -8,7 +8,10 @@ Required properties:
 =09- "ns16550"
 =09- "ns16750"
 =09- "ns16850"
-=09- "nvidia,tegra20-uart"
+=09- For Tegra20, must contain "nvidia,tegra20-uart"
+=09- For other Tegra, must contain '"nvidia,<chip>-uart",
+=09  "nvidia,tegra20-uart"' where <chip> is tegra30, tegra114, tegra124,
+=09  tegra132, or tegra210.
 =09- "nxp,lpc3220-uart"
 =09- "ralink,rt2880-uart"
 =09- "ibm,qpace-nwp-serial"
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.tx=
t b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
index 946e2ac46091..0e9a1895d7fb 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-ahub.txt
@@ -1,7 +1,10 @@
 NVIDIA Tegra30 AHUB (Audio Hub)
=20
 Required properties:
-- compatible : "nvidia,tegra30-ahub", "nvidia,tegra114-ahub", etc.
+- compatible : For Tegra30, must contain "nvidia,tegra30-ahub".  For Tegra=
114,
+  must contain "nvidia,tegra114-ahub".  For Tegra124, must contain
+  "nvidia,tegra124-ahub".  Otherwise, must contain "nvidia,<chip>-ahub",
+  plus at least one of the above, where <chip> is tegra132.
 - reg : Should contain the register physical address and length for each o=
f
   the AHUB's register blocks.
   - Tegra30 requires 2 entries, for the APBIF and AHUB/AUDIO register bloc=
ks.
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt=
 b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
index b4730c2822bc..13e2ef496724 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.txt
@@ -1,7 +1,9 @@
 NVIDIA Tegra30 HDA controller
=20
 Required properties:
-- compatible : "nvidia,tegra30-hda"
+- compatible : For Tegra30, must contain "nvidia,tegra30-hda".  Otherwise,
+  must contain '"nvidia,<chip>-hda", "nvidia,tegra30-hda"', where <chip> i=
s
+  tegra114, tegra124, or tegra132.
 - reg : Should contain the HDA registers location and length.
 - interrupts : The interrupt from the HDA controller.
 - clocks : Must contain an entry for each required entry in clock-names.
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt=
 b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
index 0c113ffe3814..38caa936f6f8 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-i2s.txt
@@ -1,7 +1,10 @@
 NVIDIA Tegra30 I2S controller
=20
 Required properties:
-- compatible : "nvidia,tegra30-i2s"
+- compatible : For Tegra30, must contain "nvidia,tegra30-i2s".  For Tegra1=
24,
+  must contain "nvidia,tegra124-i2s".  Otherwise, must contain
+  "nvidia,<chip>-i2s" plus at least one of the above, where <chip> is
+  tegra114 or tegra132.
 - reg : Should contain I2S registers location and length
 - clocks : Must contain one entry, for the module clock.
   See ../clocks/clock-bindings.txt for details.
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt =
b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index 7ea701e07dc2..b785976fe98a 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -1,7 +1,9 @@
 NVIDIA Tegra114 SPI controller.
=20
 Required properties:
-- compatible : should be "nvidia,tegra114-spi".
+- compatible : For Tegra114, must contain "nvidia,tegra114-spi".
+  Otherwise, must contain '"nvidia,<chip>-spi", "nvidia,tegra114-spi"' whe=
re
+  <chip> is tegra124, tegra132, or tegra210.
 - reg: Should contain SPI registers location and length.
 - interrupts: Should contain SPI interrupts.
 - clock-names : Must include the following entries:
diff --git a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt b=
/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
index ecf3ed76cd46..6b68cd150405 100644
--- a/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
+++ b/Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
@@ -7,7 +7,9 @@ notifications. It is also used to manage emergency shutdown=
 in an
 overheating situation.
=20
 Required properties :
-- compatible : "nvidia,tegra124-soctherm".
+- compatible : For Tegra124, must contain "nvidia,tegra124-soctherm".
+  For Tegra132, must contain "nvidia,tegra132-soctherm".
+  For Tegra210, must contain "nvidia,tegra210-soctherm".
 - reg : Should contain 1 entry:
   - SOCTHERM register set
 - interrupts : Defines the interrupt used by SOCTHERM
diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.t=
xt b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
index b5082a1cf461..1761f53ee36f 100644
--- a/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt
@@ -6,7 +6,9 @@ trigger a legacy watchdog reset.
=20
 Required properties:
=20
-- compatible : should be "nvidia,tegra30-timer", "nvidia,tegra20-timer".
+- compatible : For Tegra30, must contain "nvidia,tegra30-timer".  Otherwis=
e,
+  must contain '"nvidia,<chip>-timer", "nvidia,tegra30-timer"' where
+  <chip> is tegra124 or tegra132.
 - reg : Specifies base physical address and size of the registers.
 - interrupts : A list of 6 interrupts; one per each of timer channels 1
     through 5, and one for the shared interrupt for the remaining channels=
=2E
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt =
b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
index 3dc9140e3dfb..f60785f73d3d 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt
@@ -6,7 +6,10 @@ Practice : Universal Serial Bus" with the following modifi=
cations
 and additions :
=20
 Required properties :
- - compatible : Should be "nvidia,tegra20-ehci".
+ - compatible : For Tegra20, must contain "nvidia,tegra20-ehci".
+   For Tegra30, must contain "nvidia,tegra30-ehci".  Otherwise, must conta=
in
+   "nvidia,<chip>-ehci" plus at least one of the above, where <chip> is
+   tegra114, tegra124, tegra132, or tegra210.
  - nvidia,phy : phandle of the PHY that the controller is connected to.
  - clocks : Must contain one entry, for the module clock.
    See ../clocks/clock-bindings.txt for details.
diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra20-usb-phy.t=
xt b/Documentation/devicetree/bindings/usb/nvidia,tegra20-usb-phy.txt
index c9205fbf26e2..a9aa79fb90ed 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra20-usb-phy.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra20-usb-phy.txt
@@ -3,7 +3,10 @@ Tegra SOC USB PHY
 The device node for Tegra SOC USB PHY:
=20
 Required properties :
- - compatible : Should be "nvidia,tegra<chip>-usb-phy".
+ - compatible : For Tegra20, must contain "nvidia,tegra20-usb-phy".
+   For Tegra30, must contain "nvidia,tegra30-usb-phy".  Otherwise, must co=
ntain
+   "nvidia,<chip>-usb-phy" plus at least one of the above, where <chip> is
+   tegra114, tegra124, tegra132, or tegra210.
  - reg : Defines the following set of registers, in the order listed:
    - The PHY's own register set.
      Always present.
--=20
2.1.4

--843723315-1869901017-1422587170=:6569--
