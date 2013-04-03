Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Russell King <linux@arm.linux.org.uk>,
	Andrew Murray <andrew.murray@arm.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 09/12] ARM: tegra: tec: Add PCIe support
Date: Wed,  3 Apr 2013 16:45:15 +0200
Message-Id: <1365000318-28256-10-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
References: <1365000318-28256-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Enable the first PCIe root port which is connected to an FPGA on the
Tamonten Evaluation Carrier and add device nodes for each of the PCI
endpoints available in the standard configuration.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
Changes in v2:
- remove duplicate nodes and properties defined in tegra20-tamonten.dtsi

Changes in v3:
- remove PCIe endpoint device tree nodes, all devices can be discovered
  via standard PCI enumeration

 arch/arm/boot/dts/tegra20-tec.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-tec.dts b/arch/arm/boot/dts/tegra20-tec.dts
index 1ae37ba..e396cb2 100644
--- a/arch/arm/boot/dts/tegra20-tec.dts
+++ b/arch/arm/boot/dts/tegra20-tec.dts
@@ -64,6 +64,14 @@
 		};
 	};
 
+	pcie-controller {
+		status = "okay";
+
+		pci@1,0 {
+			status = "okay";
+		};
+	};
+
 	sound {
 		compatible = "ad,tegra-audio-wm8903-tec",
 			     "nvidia,tegra-audio-wm8903";
-- 
1.8.2

