Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: rockchip: mark PM functions as __maybe_unused
Date: Fri, 20 Jan 2017 17:24:30 +0100
Message-Id: <20170120162450.3690225-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Wenrui Li <wenrui.li@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 Shawn Lin <shawn.lin@rock-chips.com>, Brian Norris <briannorris@chromium.org>,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

When CONFIG_PM_SLEEP is disabled, we get harmless build warnings:

host/pcie-rockchip.c:1267:12: error: 'rockchip_pcie_resume_noirq' defined but not used [-Werror=unused-function]
host/pcie-rockchip.c:1240:12: error: 'rockchip_pcie_suspend_noirq' defined but not used [-Werror=unused-function]

Marking both functions as __maybe_unused avoids the warning without
the need for #ifdef around them.

Fixes: 013dd3d5e183 ("PCI: rockchip: Add system PM support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pcie-rockchip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index 0d6e8ee5b017..b975116d2b03 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1237,7 +1237,7 @@ static int rockchip_pcie_wait_l2(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
-static int rockchip_pcie_suspend_noirq(struct device *dev)
+static int __maybe_unused rockchip_pcie_suspend_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int ret;
@@ -1264,7 +1264,7 @@ static int rockchip_pcie_suspend_noirq(struct device *dev)
 	return ret;
 }
 
-static int rockchip_pcie_resume_noirq(struct device *dev)
+static int __maybe_unused rockchip_pcie_resume_noirq(struct device *dev)
 {
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	int err;
-- 
2.9.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
