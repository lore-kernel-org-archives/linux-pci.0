Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.ctxuk.citrix.com ([62.200.22.115]:34032 "EHLO
	SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756056Ab2EDNaI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 May 2012 09:30:08 -0400
From: David Vrabel <david.vrabel@citrix.com>
To: <xen-devel@lists.xensource.com>
CC: David Vrabel <david.vrabel@citrix.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	<x86@kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH v2] x86,xen,pci: don't use PCI BIOS service for configuration space accesses
Date: Fri, 4 May 2012 14:29:46 +0100
Message-ID: <1336138186-11423-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: David Vrabel <david.vrabel@citrix.com>

The accessing PCI configuration space with the PCI BIOS32 service does
not work in PV guests.

On systems without MMCONFIG or where the BIOS hasn't marked the
MMCONFIG region as reserved in the e820 map, the BIOS service is
probed (even though direct access is preferred) and this hangs.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
Changes in v2:
- improve commit message

---
 arch/x86/xen/enlighten.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index a8f8844..7ce2c78 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -63,6 +63,7 @@
 #include <asm/stackprotector.h>
 #include <asm/hypervisor.h>
 #include <asm/mwait.h>
+#include <asm/pci_x86.h>
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
@@ -1365,7 +1366,9 @@ asmlinkage void __init xen_start_kernel(void)
 		/* Make sure ACS will be enabled */
 		pci_request_acs();
 	}
-		
+
+	/* PCI BIOS service won't work from a PV guest. */
+	pci_probe &= ~PCI_PROBE_BIOS;
 
 	xen_raw_console_write("about to get started...\n");
 
-- 
1.7.2.5

