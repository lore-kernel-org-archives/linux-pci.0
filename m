Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36996 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbaHFOyc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 10:54:32 -0400
From: Gerhard Sittig <gsi@denx.de>
To: linux-pci@vger.kernel.org, Jon Mason <jon.mason@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Detlev Zundel <dzu@denx.de>,
	Gerhard Sittig <gsi@denx.de>
Subject: [PATCH RFC v1 2/4] ntb: header file nits (multiple inclusion, explicit entries)
Date: Wed,  6 Aug 2014 16:53:53 +0200
Message-Id: <1407336835-30586-3-git-send-email-gsi@denx.de>
In-Reply-To: <1407336835-30586-1-git-send-email-gsi@denx.de>
References: <1407336835-30586-1-git-send-email-gsi@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Protect NTB related header files against multiple inclusion, because
in addition to function signatures they declare data structures, too.

Add more explicit include items such that header files can be used
independently from each other, i.e. calling code does not depend on
the order of include specs to have all data types declared correctly.

Minor whitespace adjustment, to separate license texts from system
includes from local includes for easier navigation.

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/ntb/ntb_hw.h        |    8 +++++++-
 drivers/ntb/ntb_hw_intel.c  |    1 +
 drivers/ntb/ntb_transport.c |    3 +++
 include/linux/ntb.h         |    7 +++++++
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_hw.h b/drivers/ntb/ntb_hw.h
index 9cb288c045db..fe4c6306f11c 100644
--- a/drivers/ntb/ntb_hw.h
+++ b/drivers/ntb/ntb_hw.h
@@ -45,8 +45,12 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
-#include <linux/ntb.h>
+#ifndef NTB_HW_H
+#define NTB_HW_H
 
+#include <linux/interrupt.h>
+#include <linux/ntb.h>
+#include <linux/types.h>
 
 #ifndef readq
 static inline u64 readq(void __iomem *addr)
@@ -224,3 +228,5 @@ void *ntb_find_transport(struct pci_dev *pdev);
 
 int ntb_transport_init(struct pci_dev *pdev);
 void ntb_transport_free(void *transport);
+
+#endif /* NTB_HW_H */
diff --git a/drivers/ntb/ntb_hw_intel.c b/drivers/ntb/ntb_hw_intel.c
index 699f05132a61..a81a06c50148 100644
--- a/drivers/ntb/ntb_hw_intel.c
+++ b/drivers/ntb/ntb_hw_intel.c
@@ -53,6 +53,7 @@
 #include <linux/pci.h>
 #include <linux/random.h>
 #include <linux/slab.h>
+
 #include "ntb_hw.h"
 #include "ntb_hw_intel.h"
 #include "ntb_regs_intel.h"
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9dd63b822025..436326ad87bd 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -45,6 +45,7 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
+
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -53,9 +54,11 @@
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
+#include <linux/ntb.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+
 #include "ntb_hw.h"
 
 #define NTB_TRANSPORT_VERSION	3
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 9ac1a62fc6f5..5b69d09db84f 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -45,6 +45,11 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
+#ifndef LINUX_NTB_H
+#define LINUX_NTB_H
+
+#include <linux/pci.h>
+#include <linux/types.h>
 
 struct ntb_transport_qp;
 
@@ -86,3 +91,5 @@ void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len);
 void ntb_transport_link_up(struct ntb_transport_qp *qp);
 void ntb_transport_link_down(struct ntb_transport_qp *qp);
 bool ntb_transport_link_query(struct ntb_transport_qp *qp);
+
+#endif /* LINUX_NTB_H */
-- 
1.7.10.4

