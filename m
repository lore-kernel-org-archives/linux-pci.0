Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:33514 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbaHFOyh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 Aug 2014 10:54:37 -0400
From: Gerhard Sittig <gsi@denx.de>
To: linux-pci@vger.kernel.org, Jon Mason <jon.mason@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Detlev Zundel <dzu@denx.de>,
	Gerhard Sittig <gsi@denx.de>
Subject: [PATCH RFC v1 3/4] ntb: prepare to build the 'data transport' as a separate module
Date: Wed,  6 Aug 2014 16:53:54 +0200
Message-Id: <1407336835-30586-4-git-send-email-gsi@denx.de>
In-Reply-To: <1407336835-30586-1-git-send-email-gsi@denx.de>
References: <1407336835-30586-1-git-send-email-gsi@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Export those routines of the data transport which the PCI NTB hardware
drivers will reference, and provide module properties such that the data
transport over PCI NTB can build as a separate module.

This change does not alter the Makefile, the data transport still gets
statically linked against the driver for Intel hardware support.

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/ntb/ntb_transport.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 436326ad87bd..70f358c8cc09 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -61,7 +61,14 @@
 
 #include "ntb_hw.h"
 
+#define NTB_TRANSPORT_NAME	"Data transport over Non-Transparent Bridge"
 #define NTB_TRANSPORT_VERSION	3
+#define NTB_TRANSPORT_VERSTEXT	"3"
+
+MODULE_DESCRIPTION(NTB_TRANSPORT_NAME);
+MODULE_VERSION(NTB_TRANSPORT_VERSTEXT);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Intel Corporation");
 
 static unsigned int transport_mtu = 0x401E;
 module_param(transport_mtu, uint, 0644);
@@ -979,6 +986,7 @@ err:
 	kfree(nt);
 	return rc;
 }
+EXPORT_SYMBOL(ntb_transport_init);
 
 void ntb_transport_free(void *transport)
 {
@@ -1009,6 +1017,7 @@ void ntb_transport_free(void *transport)
 	ntb_unregister_transport(ndev);
 	kfree(nt);
 }
+EXPORT_SYMBOL(ntb_transport_free);
 
 static void ntb_rx_copy_callback(void *data)
 {
-- 
1.7.10.4

