Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28288 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756066AbaGVQRa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 22 Jul 2014 12:17:30 -0400
From: "Luck, Tony" <tony.luck@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Qiu <qiudayu@linux.vnet.ibm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
In-reply-to: <CAErSpo6zOkjU0ELH-NQQL-rvjnG2L7B6963eOFbpPpEOgNUV6Q@mail.gmail.com>
Subject: [PATCH] Fix build warnings in aer.h
Date: Tue, 22 Jul 2014 09:17:18 -0700
Message-Id: <53ce8e8e22217dde72@agluck-desk.sc.intel.com>
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

Linus: The breakage that this fixes is actually only in linux-next,
but the commits that found this gap are already in the tip tree, so
hard to rebase to get this fix ahead of them to avoid a bisection gap.
But since this is so obvious - perhaps it can go into 3.16? If you
don't want it, I'll ask hpa to add it to the right topic branch in
tip so it is at least close to the commit that reveals the gap.

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
