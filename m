Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Oza Pawandeep <oza.oza@broadcom.com>
To: Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [RFC PATCH 3/3] of: fix node traversing in of_dma_get_range
Date: Sat, 25 Mar 2017 11:01:33 +0530
Message-Id: <1490419893-5073-3-git-send-email-oza.oza@broadcom.com>
In-Reply-To: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
References: <1490419893-5073-1-git-send-email-oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 bcm-kernel-feedback-list@broadcom.com, Oza Pawandeep <oza.oza@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

it jumps to the parent node without examining the child node.
also with that, it throws "no dma-ranges found for node"
for pci dma-ranges.

this patch fixes device node traversing for dma-ranges.

Reviewed-by: Anup Patel <anup.patel@broadcom.com>
Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 02b2903..3293d55 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -836,9 +836,6 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 	while (1) {
 		naddr = of_n_addr_cells(node);
 		nsize = of_n_size_cells(node);
-		node = of_get_next_parent(node);
-		if (!node)
-			break;
 
 		ranges = of_get_property(node, "dma-ranges", &len);
 
@@ -852,6 +849,10 @@ int of_dma_get_range(struct device_node *np, u64 *dma_addr, u64 *paddr, u64 *siz
 		 */
 		if (!ranges)
 			break;
+
+		node = of_get_next_parent(node);
+		if (!node)
+			break;
 	}
 
 	if (!ranges) {
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
