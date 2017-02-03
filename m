Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sricharan R <sricharan@codeaurora.org>
To: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org,
 lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org,
 okaya@codeaurora.org
Subject: [PATCH V8 04/11] of: dma: Make of_dma_deconfigure() public
Date: Fri,  3 Feb 2017 21:18:46 +0530
Message-Id: <1486136933-20328-5-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
References: <1486136933-20328-1-git-send-email-sricharan@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: sricharan@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

As part of moving DMA initializing to probe time the
of_dma_deconfigure() function will need to be called from different
source files. Make it public and move it to drivers/of/device.c where
the of_dma_configure() function is.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/of/device.c       | 12 ++++++++++++
 drivers/of/platform.c     |  5 -----
 include/linux/of_device.h |  3 +++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 09dedd0..c17c19d 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -136,6 +136,18 @@ void of_dma_configure(struct device *dev, struct device_node *np)
 }
 EXPORT_SYMBOL_GPL(of_dma_configure);
 
+/**
+ * of_dma_deconfigure - Clean up DMA configuration
+ * @dev:	Device for which to clean up DMA configuration
+ *
+ * Clean up all configuration performed by of_dma_configure_ops() and free all
+ * resources that have been allocated.
+ */
+void of_dma_deconfigure(struct device *dev)
+{
+	arch_teardown_dma_ops(dev);
+}
+
 int of_device_register(struct platform_device *pdev)
 {
 	device_initialize(&pdev->dev);
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b8064bc..57418f7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -158,11 +158,6 @@ struct platform_device *of_device_alloc(struct device_node *np,
 }
 EXPORT_SYMBOL(of_device_alloc);
 
-static void of_dma_deconfigure(struct device *dev)
-{
-	arch_teardown_dma_ops(dev);
-}
-
 /**
  * of_platform_device_create_pdata - Alloc, initialize and register an of_device
  * @np: pointer to node to create device for
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index e9afbcc..3cb2288 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -57,6 +57,7 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 }
 
 void of_dma_configure(struct device *dev, struct device_node *np);
+void of_dma_deconfigure(struct device *dev);
 #else /* CONFIG_OF */
 
 static inline int of_driver_match_device(struct device *dev,
@@ -106,6 +107,8 @@ static inline struct device_node *of_cpu_device_node_get(int cpu)
 }
 static inline void of_dma_configure(struct device *dev, struct device_node *np)
 {}
+static inline void of_dma_deconfigure(struct device *dev)
+{}
 #endif /* CONFIG_OF */
 
 #endif /* _LINUX_OF_DEVICE_H */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
