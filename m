Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Guodong Xu <guodong.xu@linaro.org>
To: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com,
 catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com,
 xuejiancheng@hisilicon.com, peter.griffin@linaro.org,
 puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org,
 bhelgaas@google.com, arnd@arndb.de
Subject: [PATCH v3 02/21] arm64: dts: hisilicon: update compatible string for
 hikey960
Date: Wed, 14 Jun 2017 16:23:19 +0800
Message-Id: <20170614082338.15673-3-guodong.xu@linaro.org>
In-Reply-To: <20170614082338.15673-1-guodong.xu@linaro.org>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Guodong Xu <guodong.xu@linaro.org>,
 linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, zhangfei.gao@linaro.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Update compatible string for hikey960. HiKey960 is a develpment board built
with SoC Hi3660.

Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 186251f..64875a5 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -12,7 +12,7 @@
 
 / {
 	model = "HiKey960";
-	compatible = "hisilicon,hi3660";
+	compatible = "hisilicon,hi3660-hikey960", "hisilicon,hi3660";
 
 	aliases {
 		serial5 = &uart5;       /* console UART */
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
