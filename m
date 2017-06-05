Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Ryder Lee <ryder.lee@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: mediatek: fix error handling in
 mtk_pcie_parse_and_add_res()
Date: Mon, 5 Jun 2017 14:27:58 +0800
Message-ID: <1496644078-27122-1-git-send-email-ryder.lee@mediatek.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

The 'linkup' variable would always increment by one whether the link
status is true or not. Therefore, this patch fixes the return value in
mtk_pcie_parse_and_add_res() and removes unnecessary 'linkup' variable.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pci/host/pcie-mediatek.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pcie-mediatek.c b/drivers/pci/host/pcie-mediatek.c
index 8ec8fa8..3baafa8 100644
--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -373,7 +373,7 @@ static int mtk_pcie_parse_and_add_res(struct mtk_pcie *pcie)
 	struct of_pci_range_parser parser;
 	struct of_pci_range range;
 	struct resource res;
-	int err, linkup = 0;
+	int err;
 
 	/* parse shared resources */
 	err = mtk_pcie_handle_shared_resource(pcie);
@@ -444,11 +444,11 @@ static int mtk_pcie_parse_and_add_res(struct mtk_pcie *pcie)
 
 		/* enable each port, and then check link status */
 		err = mtk_pcie_enable_ports(port);
-		if (!err)
-			linkup++;
+		if (err)
+			return err;
 	}
 
-	return !linkup;
+	return 0;
 }
 
 static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
