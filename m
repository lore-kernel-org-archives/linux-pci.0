Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Xiaowei Song <songxiaowei@hisilicon.com>
To: <bhelgaas@google.com>, <kishon@ti.com>, <jingoohan1@gmail.com>,
        <arnd@arndb.de>, <tn@semihalf.com>, <keith.busch@intel.com>,
        <niklas.cassel@axis.com>, <dhdang@apm.com>,
        <liudongdong3@huawei.com>, <gabriele.paoloni@huawei.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>
CC: <chenyao11@huawei.com>, <puck.chen@hisilicon.com>,
        <songxiaowei@hisilicon.com>, <guodong.xu@linaro.org>,
        <wangbinghui@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/4] arm64: dts: hisi: add kirin pcie node
Date: Wed, 24 May 2017 16:12:46 +0800
Message-ID: <20170524081248.67198-3-songxiaowei@hisilicon.com>
In-Reply-To: <20170524081248.67198-1-songxiaowei@hisilicon.com>
References: <20170524081248.67198-1-songxiaowei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add PCIe node for hi3660, and add binding documentation.

Cc: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Xiaowei Song <songxiaowei@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 3983086bd67b..f41276b52248 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -156,5 +156,36 @@
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
+
+		pcie@f4000000 {
+			compatible = "hisilicon,kirin-pcie";
+			reg =  <0x0 0xf4000000 0x0 0x1000>,
+				<0x0 0xff3fe000 0x0 0x1000>,
+				<0x0 0xf3f20000 0x0 0x40000>,
+				<0x0 0xF5000000 0x0 0x2000>;
+			reg-names = "dbi", "apb", "phy", "config";
+			bus-range = <0x0  0x1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x02000000 0x0 0x00000000 0x0
+				0xf6000000 0x0 0x2000000>;
+			num-lanes = <1>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0xf800 0 0 7>;
+			interrupt-map = <0x0 0 0 1 &gic 0 0 0 282 4>,
+				<0x0 0 0 2 &gic 0 0 0  283 4>,
+				<0x0 0 0 3 &gic 0 0 0  284 4>,
+				<0x0 0 0 4 &gic 0 0 0  285 4>;
+			clocks = <&crg_ctrl HI3660_PCIEPHY_REF>,
+				<&crg_ctrl HI3660_CLK_GATE_PCIEAUX>,
+				<&crg_ctrl HI3660_PCLK_GATE_PCIE_PHY>,
+				<&crg_ctrl HI3660_PCLK_GATE_PCIE_SYS>,
+				<&crg_ctrl HI3660_ACLK_GATE_PCIE>;
+			clock-names = "pcie_phy_ref", "pcie_aux",
+				"pcie_apb_phy", "pcie_apb_sys", "pcie_aclk";
+			reset-gpio = <&gpio11 1 0 >;
+			status = "ok";
+		};
 	};
 };
-- 
2.11.GIT
