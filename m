Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33912 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeDRR2w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Apr 2018 13:28:52 -0400
Received: by mail-oi0-f67.google.com with SMTP id e23-v6so2326509oiy.1
        for <linux-pci@vger.kernel.org>; Wed, 18 Apr 2018 10:28:51 -0700 (PDT)
From: minyard@acm.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: openipmi-developer@lists.sourceforge.net,
        linux-pci@vger.kernel.org, Corey Minyard <cminyard@mvista.com>
Subject: [PATCH v2] pci:ipmi: Move IPMI PCI class id defines to pci_ids.h
Date: Wed, 18 Apr 2018 12:28:47 -0500
Message-Id: <1524072527-11690-1-git-send-email-minyard@acm.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 drivers/char/ipmi/ipmi_si_pci.c | 5 -----
 include/linux/pci_ids.h         | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

Changes from v1:
  * Leave PCI_DEVICE_ID_HP_MMC in the IPMI driver, per comments
    by Bjorn Helgaas.

There's no hurry on this, if it is suitable I can keep it in my
queue with your ack, or you can take it.

Thanks!

-corey

diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
index f54ca68..bdba128 100644
--- a/drivers/char/ipmi/ipmi_si_pci.c
+++ b/drivers/char/ipmi/ipmi_si_pci.c
@@ -18,11 +18,6 @@ module_param_named(trypci, si_trypci, bool, 0);
 MODULE_PARM_DESC(trypci, "Setting this to zero will disable the"
 		 " default scan of the interfaces identified via pci");
 
-#define PCI_CLASS_SERIAL_IPMI		0x0c07
-#define PCI_CLASS_SERIAL_IPMI_SMIC	0x0c0700
-#define PCI_CLASS_SERIAL_IPMI_KCS	0x0c0701
-#define PCI_CLASS_SERIAL_IPMI_BT	0x0c0702
-
 #define PCI_DEVICE_ID_HP_MMC 0x121A
 
 static void ipmi_pci_cleanup(struct si_sm_io *io)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index cc608fc5..ac79652 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -117,6 +117,10 @@
 #define PCI_CLASS_SERIAL_USB_DEVICE	0x0c03fe
 #define PCI_CLASS_SERIAL_FIBER		0x0c04
 #define PCI_CLASS_SERIAL_SMBUS		0x0c05
+#define PCI_CLASS_SERIAL_IPMI		0x0c07
+#define PCI_CLASS_SERIAL_IPMI_SMIC	0x0c0700
+#define PCI_CLASS_SERIAL_IPMI_KCS	0x0c0701
+#define PCI_CLASS_SERIAL_IPMI_BT	0x0c0702
 
 #define PCI_BASE_CLASS_WIRELESS			0x0d
 #define PCI_CLASS_WIRELESS_RF_CONTROLLER	0x0d10
-- 
2.7.4
