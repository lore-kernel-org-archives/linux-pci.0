Return-Path: <SRS0=A+B5=EI=fredlawl.com=fred@kernel.org>
Return-Path: <SRS0=A+B5=EI=fredlawl.com=fred@kernel.org>
From: Frederick Lawler <fred@fredlawl.com>
To: linux-pci@vger.kernel.org
Cc: Frederick Lawler <fred@fredlawl.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 1/2] PCI: Create  minor pci_dev log wrapper functions
Date: Fri, 12 Jan 2018 19:28:49 -0600
Message-Id: <1515806930-2935-2-git-send-email-fred@fredlawl.com>
In-Reply-To: <1515806930-2935-1-git-send-email-fred@fredlawl.com>
References: <1515806930-2935-1-git-send-email-fred@fredlawl.com>
List-ID: <linux-pci.vger.kernel.org>

Add PCI-specific dev_printk() wrappers so we can do:

  pci_info(dev, "message\n");

instead of

  dev_info(&dev->dev, "message\n");

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
Signed-off-by: Bjorn Helgaas <helgaas@kernel.org>
---
V2:
* Replace static inline varadic functions with macros instead

 include/linux/pci.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index c170c92..7a5012b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2281,4 +2281,31 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 /* provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
+#define pci_printk(level, pdev, fmt, arg...)		\
+	dev_printk(level, &(pdev)->dev, fmt, ##arg)
+
+#define pci_emerg(pdev, fmt, arg...)			\
+	dev_emerg(&(pdev)->dev, fmt, ##arg)
+
+#define pci_crit(pdev, fmt, arg...)			\
+	dev_crit(&(pdev)->dev, fmt, ##arg)
+
+#define pci_alert(pdev, fmt, arg...)			\
+	dev_alert(&(pdev)->dev, fmt, ##arg)
+
+#define pci_err(pdev, fmt, arg...)			\
+	dev_err(&(pdev)->dev, fmt, ##arg)
+
+#define pci_notice(pdev, fmt, arg...)			\
+	dev_notice(&(pdev)->dev, fmt, ##arg)
+
+#define pci_warn(pdev, fmt, arg...)			\
+	dev_warn(&(pdev)->dev, fmt, ##arg)
+
+#define pci_info(pdev, fmt, arg...)			\
+	 dev_info(&(pdev)->dev, fmt, ##arg)
+
+#define pci_dbg(pdev, fmt, arg...)			\
+	dev_dbg(&(pdev)->dev, fmt, ##arg)
+
 #endif /* LINUX_PCI_H */
-- 
2.7.4
