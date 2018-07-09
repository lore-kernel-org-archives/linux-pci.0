Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com, will.deacon@arm.com, robh+dt@kernel.org,
 robh@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
 gregkh@linuxfoundation.org, laurentiu.tudor@nxp.com, bhelgaas@google.com,
 hch@lst.de
Subject: [PATCH 5/7 v6] bus/fsl-mc: support dma configure for devices on
 fsl-mc bus
Date: Mon,  9 Jul 2018 16:48:21 +0530
Message-Id: <1531135103-10699-6-git-send-email-nipun.gupta@nxp.com>
In-Reply-To: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
References: <1531135103-10699-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, stuyoder@gmail.com, bharat.bhushan@nxp.com,
 shawnguo@kernel.org, joro@8bytes.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 iommu@lists.linux-foundation.org, Nipun Gupta <nipun.gupta@nxp.com>,
 linux-pci@vger.kernel.org, frowand.list@gmail.com,
 linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

This patch adds support of dma configuration for devices on fsl-mc
bus using 'dma_configure' callback for busses. Also, directly calling
arch_setup_dma_ops is removed from the fsl-mc bus.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 5d8266c..fa43c7d 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -127,6 +127,16 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static int fsl_mc_dma_configure(struct device *dev)
+{
+	struct device *dma_dev = dev;
+
+	while (dev_is_fsl_mc(dma_dev))
+		dma_dev = dma_dev->parent;
+
+	return of_dma_configure(dev, dma_dev->of_node, 0);
+}
+
 static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -148,6 +158,7 @@ struct bus_type fsl_mc_bus_type = {
 	.name = "fsl-mc",
 	.match = fsl_mc_bus_match,
 	.uevent = fsl_mc_bus_uevent,
+	.dma_configure  = fsl_mc_dma_configure,
 	.dev_groups = fsl_mc_dev_groups,
 };
 EXPORT_SYMBOL_GPL(fsl_mc_bus_type);
@@ -633,10 +644,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 			goto error_cleanup_dev;
 	}
 
-	/* Objects are coherent, unless 'no shareability' flag set. */
-	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
-		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
-
 	/*
 	 * The device-specific probe callback will get invoked by device_add()
 	 */
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
