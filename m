Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3795 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751066AbaG2Rt1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 29 Jul 2014 13:49:27 -0400
From: "Luck, Tony" <tony.luck@intel.com>
To: "H. Peter Anvin" <hpa@linux.jf.intel.com>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH] Fix build warnings in aer.h
Date: Tue, 29 Jul 2014 10:49:25 -0700
Message-Id: <53d7dea511471321bb@agluck-desk.sc.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Mike Qiu <qiudayu@linux.vnet.ibm.com>

build log:

In file included from include/ras/ras_event.h:11:0,
                 from drivers/ras/ras.c:13:
include/linux/aer.h:42:129: warning: ‘struct pci_dev’
declared inside parameter list [enabled by default]

include/linux/aer.h:42:129: warning: its scope is only
this definition or declaration, which is probably not
what you want [enabled by default]

include/linux/aer.h:46:130: warning: ‘struct pci_dev’
declared inside parameter list [enabled by default]

include/linux/aer.h:50:136: warning: ‘struct pci_dev’
declared inside parameter list [enabled by default]

include/linux/aer.h:57:14: warning: ‘struct pci_dev’
declared inside parameter list [enabled by default]

Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/aer.h | 2 ++
 1 file changed, 2 insertions(+)

Peter: Can you add this to the x86/ras branch in the tip tree.
There's a change in there that is breaking randconfig
builds in linux-next because something includes aer.h
without including pci.h ... which ought to be legal as
aer.h needs to take responsibility for making sure that
it resolves dependencies itself.

diff --git a/include/linux/aer.h b/include/linux/aer.h
index 4dbaa70..c826d1c 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -11,6 +11,8 @@
 #define AER_FATAL			1
 #define AER_CORRECTABLE			2
 
+struct pci_dev;
+
 struct aer_header_log_regs {
 	unsigned int dw0;
 	unsigned int dw1;
-- 
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-pci" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
