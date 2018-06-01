Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 1 Jun 2018 08:42:27 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: honghui.zhang@mediatek.com
Subject: [RFC PATCH] PCI: mediatek: mtk_pcie_pm_ops can be static
Message-ID: <20180601004227.GA98217@lkp-sb05>
References: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
In-Reply-To: <1527647736-19986-1-git-send-email-honghui.zhang@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 hongkun.cao@mediatek.com, lorenzo.pieralisi@arm.com, yt.shen@mediatek.com,
 marc.zyngier@arm.com, linux-pci@vger.kernel.org, sean.wang@mediatek.com,
 xinping.qian@mediatek.com, linux-kernel@vger.kernel.org, yong.wu@mediatek.com,
 matthias.bgg@gmail.com, ryder.lee@mediatek.com,
 linux-mediatek@lists.infradead.org, kbuild-all@01.org,
 honghui.zhang@mediatek.com, bhelgaas@google.com, yingjoe.chen@mediatek.com,
 eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>


Fixes: 24dc21cd1e9d ("PCI: mediatek: Add system pm support for MT2712")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 pcie-mediatek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index e3b16b0..e01cc66 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -1256,7 +1256,7 @@ static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops mtk_pcie_pm_ops = {
+static const struct dev_pm_ops mtk_pcie_pm_ops = {
 	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
 				      mtk_pcie_resume_noirq)
 };

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
