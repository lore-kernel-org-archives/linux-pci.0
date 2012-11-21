Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:46281 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756365Ab2KUUfC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 21 Nov 2012 15:35:02 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: linux-pci@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-sh@vger.kernel.org
Subject: [PATCH 4/9] sh/PCI: Remove CONFIG_HOTPLUG ifdefs
Date: Wed, 21 Nov 2012 15:34:55 -0500
Message-Id: <1353530100-728-5-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
References: <1353530100-728-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/drivers/pci/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index a7e078f..81e5daf 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -319,7 +319,5 @@ EXPORT_SYMBOL(pci_iounmap);
 
 #endif /* CONFIG_GENERIC_IOMAP */
 
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
-#endif
-- 
1.8.0

