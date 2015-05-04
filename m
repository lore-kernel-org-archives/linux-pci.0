Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Stanimir Varbanov <svarbanov@mm-sol.com>
To: Rob Herring <robh+dt@kernel.org>,
	Kumar Gala <galak@codeaurora.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Grant Likely <grant.likely@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: [PATCH v2 1/5] DT: phy: qcom: Add PCIe PHY devicetree bindings
Date: Mon,  4 May 2015 15:42:14 +0300
Message-Id: <1430743338-10441-2-git-send-email-svarbanov@mm-sol.com>
In-Reply-To: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
References: <1430743338-10441-1-git-send-email-svarbanov@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Document Qualcomm PCIe PHY devicetree bindings.

Signed-off-by: Stanimir Varbanov <svarbanov@mm-sol.com>
---
 .../devicetree/bindings/phy/qcom-pcie-phy.txt      |   60 ++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/qcom-pcie-phy.txt b/Documentation/devicetree/bindings/phy/qcom-pcie-phy.txt
new file mode 100644
index 0000000..e4c7f9c
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom-pcie-phy.txt
@@ -0,0 +1,60 @@
+* Qualcomm PCIe PHY controller
+
+PCIe PHY nodes are defined to describe on-chip PCIe Physical layer controllers.
+Each PCIe PHY controller should have its own node.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Value should contain "qcom,pcie-phy"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: Offset and length of the PCIe PHY registers
+
+- #phy-cells:
+	Usage: required
+	Value type: <u32>
+	Definition: Must be zero
+
+- clocks:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: A list of phandles and clock specifier pair, one
+		    for each entry in clock-names property
+
+- clock-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Should contain "core" for PHY core clock
+
+- resets:
+	Usage: required
+	Value type: <phandle>
+	Definition: List of phandle and reset specifier pairs as listed
+		    in reset-names property
+
+- reset-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: Should contain "core" for PHY core reset
+
+- <name>-supply:
+	Usage: required
+	Value type: <phandle>
+	Definition: List of phandles to the power supply regulators
+		    - "vdda_pll" analog Vdd PLL power supply
+
+* Example
+
+	pciephy0: phy@fc526000 {
+		compatible = "qcom,pcie-phy";
+		reg = <0xfc526000 0x1000>;
+		clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
+		clock-names = "core";
+		resets = <&gcc GCC_PCIE_0_PHY_BCR>;
+		reset-names = "core";
+		vdda_pll-supply = <&pma8084_l12>;
+		#phy-cells = <0>;
+	};
-- 
1.7.0.4

