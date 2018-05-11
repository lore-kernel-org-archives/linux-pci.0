Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Yao Chen <chenyao11@huawei.com>
To: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <xuwei5@hisilicon.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC: <dimitrysh@google.com>, <guodong.xu@linaro.org>,
        <chenyao11@huawei.com>, <suzhuangluan@hisilicon.com>,
        <kongfei@hisilicon.com>
Subject: [PATCH v3 2/2] arm64: dts: hi3660: Add pcie msi interrupt attribute
Date: Fri, 11 May 2018 17:15:49 +0800
Message-ID: <1526030149-23985-3-git-send-email-chenyao11@huawei.com>
In-Reply-To: <1526030149-23985-1-git-send-email-chenyao11@huawei.com>
References: <1526030149-23985-1-git-send-email-chenyao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Add pcie msi interrupt attribute for hi3660 SOC.

Signed-off-by: Yao Chen <chenyao11@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index ec3eb8e..2cef8f4 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -872,6 +872,8 @@
 				  0x0 0x02000000>;
 			num-lanes = <1>;
 			#interrupt-cells = <1>;
+			interrupts = <0 283 4>;
+			interrupt-names = "msi";
 			interrupt-map-mask = <0xf800 0 0 7>;
 			interrupt-map = <0x0 0 0 1
 					 &gic GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.9.1
