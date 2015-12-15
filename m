Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-omap@vger.kernel.org>, <tony@atomide.com>
CC: <bcousson@baylibre.com>, <kishon@ti.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linux@arm.linux.org.uk>, <rogerq@ti.com>, <nsekhar@ti.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<t-kristo@ti.com>
Subject: [PATCH v3 0/4] ARM: dts: use syscon property instead of ctrl-module
Date: Tue, 15 Dec 2015 15:09:02 +0530
Message-ID: <1450172346-11890-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This series is basically to deprecate using ctrl-module property and use
corresponding syscon properties to program the control module registers.

Changes from v2:
No changes.

Changes from v1:
*) Squashed the patches that replaces "ctrl-module" with
   "syscon-phy-power"
*) Added "syscon-phy-power" for SATA dt node in OMAP5 which was missed
   earlier
*) removed _ARM: dts: omap4: Use "syscon-otghs" instead of "ctrl-module"
   in USB node_. It will be done later.

Changes from [1] in PHY patches include
*) cleanup ti_pipe3_probe
*) have mask, power_on and power_off values in usb_phy_data for
   omap-usb2 phy

This series should be merged only after [2]

[2] -> http://www.spinics.net/lists/kernel/msg2144510.html

Logs with SYSCON DT

DRA72 EVM : http://pastebin.ubuntu.com/14025205/
DRA7 EVM  : http://pastebin.ubuntu.com/14025212/
AM43XX EVM: http://pastebin.ubuntu.com/14025222/
OMAP5 UEVM: http://pastebin.ubuntu.com/14025228/

Logs without SYSCON DT

DRA72 EVM : http://pastebin.ubuntu.com/14025233/
DRA7 EVM  : http://pastebin.ubuntu.com/14025238/
AM43XX EVM: http://pastebin.ubuntu.com/14025329/
OMAP5 UEVM: http://pastebin.ubuntu.com/14025248/

The config I used: http://pastebin.ubuntu.com/14025336/

Kishon Vijay Abraham I (4):
  ARM: dts: dra7: Add dt node for the sycon pcie
  ARM: dts: dra7: Use "syscon-phy-power" and "syscon-pcs" in PCIe PHY
    node
  ARM: dts: dra7: Use "ti,dra7x-usb2-phy2" compatible string for USB2
    PHY2
  ARM: dts: <am4372/dra7/omap5>: Use "syscon-phy-power" instead of
    "ctrl-module"

 arch/arm/boot/dts/am4372.dtsi |   16 ++-------
 arch/arm/boot/dts/dra7.dtsi   |   75 ++++++++++++-----------------------------
 arch/arm/boot/dts/omap5.dtsi  |   26 ++------------
 3 files changed, 26 insertions(+), 91 deletions(-)

-- 
1.7.9.5

