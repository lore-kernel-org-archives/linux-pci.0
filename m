Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 7/7] arm64: defconfig: update config for Rockchip PCIe
Date: Fri, 27 Apr 2018 10:40:01 +0800
Message-Id: <1524796801-161426-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1524796697-160764-1-git-send-email-shawn.lin@rock-chips.com>
References: <1524796697-160764-1-git-send-email-shawn.lin@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
 linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
 linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Now Rockchip PCIe drivers could support both of host mode
and endponint mode, so we rename the config name. This patch
updates defconfig to refect the fact that we want to build
Rockchip PCIe controller driver into a module as before.

Cc: linux-arm-kernel@lists.infradead.org
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v6: None
Changes in v5: None
Changes in v4: None

 arch/arm64/configs/defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0d8ae1d..5cf70af 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -79,7 +79,8 @@ CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCI_AARDVARK=y
 CONFIG_PCI_TEGRA=y
 CONFIG_PCIE_RCAR=y
-CONFIG_PCIE_ROCKCHIP=m
+CONFIG_PCIE_ROCKCHIP=y
+CONFIG_PCIE_ROCKCHIP_HOST=m
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCI_XGENE=y
 CONFIG_PCI_HOST_THUNDER_PEM=y
-- 
1.9.1



_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
