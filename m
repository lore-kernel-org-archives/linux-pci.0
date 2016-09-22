Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: rockchip: fix uninitialized variable use
Date: Thu, 22 Sep 2016 11:39:59 +0200
Message-Id: <20160922094018.2138640-1-arnd@arndb.de>
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

The newly added pcie-rockchip driver fails to initialize the
io_size variable if the DT doesn't provide ranges for the PCI
I/O space, as found by building it with -Wmaybe-uninitialized:

drivers/pci/host/pcie-rockchip.c: In function 'rockchip_pcie_probe':
drivers/pci/host/pcie-rockchip.c:1007:6: warning: 'io_size' may be used uninitialized in this function [-Wmaybe-uninitialized]

This adds an appropriate initialization immediately in front of
the loop, so the io_size is zero as expected afterwards for that
case.

Fixes: abe17181b16f ("PCI: rockchip: Add Rockchip PCIe controller support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pcie-rockchip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index c3593e633ccd..8bedc1e1ef80 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1078,6 +1078,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 		goto err_vpcie;
 
 	/* Get the I/O and memory ranges from DT */
+	io_size = 0;
 	resource_list_for_each_entry(win, &res) {
 		switch (resource_type(win->res)) {
 		case IORESOURCE_IO:
-- 
2.9.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
