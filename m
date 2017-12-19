Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:36203 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759542AbdLSBQX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Dec 2017 20:16:23 -0500
Received: by mail-io0-f196.google.com with SMTP id l10so11830050ioc.3
        for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2017 17:16:23 -0800 (PST)
From: Frederick Lawler <fred@fredlawl.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH 1/2] PCI: Create  minor pci_dev log wrapper functions
Date: Mon, 18 Dec 2017 19:16:13 -0600
Message-Id: <1513646174-2269-2-git-send-email-fred@fredlawl.com>
In-Reply-To: <1513646174-2269-1-git-send-email-fred@fredlawl.com>
References: <1513646174-2269-1-git-send-email-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Create minor pci_dev log wrapper functions

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 include/linux/pci.h | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0403894..3d0e939 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2278,4 +2278,95 @@ static inline bool pci_is_thunderbolt_attached(struct pci_dev *pdev)
 /* provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
+static inline void pci_printk(const char *level,
+			      const struct pci_dev *pdev,
+			      const char *fmt, ...)
+{
+	va_list argptr;
+
+	va_start(argptr, fmt);
+	dev_printk(level, &(pdev)->dev, fmt, argptr);
+	va_end(argptr);
+}
+
+static inline void pci_emerg(const struct pci_dev *pdev,
+			     const char *fmt, ...)
+{
+	va_list argptr;
+
+	va_start(argptr, fmt);
+	dev_emerg(&(pdev)->dev, fmt, argptr);
+	va_end(argptr);
+}
+
+static inline void pci_crit(const struct pci_dev *pdev,
+			    const char *fmt, ...)
+{
+	va_list argptr;
+
+	va_start(argptr, fmt);
+	dev_crit(&(pdev)->dev, fmt, argptr);
+	va_end(argptr);
+}
+
+static inline void pci_alert(const struct pci_dev *pdev,
+			     const char *fmt, ...)
+{
+	va_list argptr;
+
+	va_start(argptr, fmt);
+	dev_alert(&(pdev)->dev, fmt, argptr);
+	va_end(argptr);
+}
+
+static inline void pci_err(const struct pci_dev *pdev,
+			   const char *fmt, ...)
+{
+	va_list argptr;
+
+	va_start(argptr, fmt);
+	dev_err(&(pdev)->dev, fmt, argptr);
+	va_end(argptr);
+}
+
+static inline void pci_notice(const struct pci_dev *pdev,
+			      const char *fmt, ...)
+{
+	va_list argptr;
+
+	va_start(argptr, fmt);
+	dev_notice(&(pdev)->dev, fmt, argptr);
+	va_end(argptr);
+}
+
+static inline void pci_warn(const struct pci_dev *pdev,
+			    const char *fmt, ...)
+{
+	va_list argptr;
+
+	va_start(argptr, fmt);
+	dev_warn(&(pdev)->dev, fmt, argptr);
+	va_end(argptr);
+}
+
+static inline void pci_info(const struct pci_dev *pdev,
+			    const char *fmt, ...)
+{
+	va_list argptr;
+
+	va_start(argptr, fmt);
+	dev_info(&(pdev)->dev, fmt, argptr);
+	va_end(argptr);
+}
+
+static inline void pci_dbg(const struct pci_dev *pdev,
+			   const char *fmt, ...)
+{
+	va_list argptr;
+
+	va_start(argptr, fmt);
+	dev_dbg(&(pdev)->dev, fmt, argptr);
+	va_end(argptr);
+}
+
 #endif /* LINUX_PCI_H */
-- 
2.7.4
