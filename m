Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from messagesink.samelson.uni-hildesheim.de ([147.172.172.66]:3658
        "EHLO messagesink.samelson.uni-hildesheim.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751198AbdIOLed (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2017 07:34:33 -0400
From: Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Klaus Schmid <schmid@sse.uni-hildesheim.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Date: Fri, 15 Sep 2017 13:33:51 +0200
Subject: AW: [PATCH] PCI SUBSYSTEM allows inconsistent configuration,
 current Kernel version
Message-ID: <f02a2ddd-8469-4a17-99fe-620c690be7c2@messagesink.samelson.uni-hildesheim.de>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Bjorn,

Thank you for your help. Blow you'll find the inline patch to ensure the correct Kconfig configuration when PCI_REALLOC_ENABLE_AUTO is selected.

Best regards,
Sascha El-Sharkawy

Signed-off-by:  Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig index c32a77fc8b03..675d79c52709 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -42,13 +42,12 @@ config PCI_DEBUG
 config PCI_REALLOC_ENABLE_AUTO
 	bool "Enable PCI resource re-allocation detection"
 	depends on PCI
+	select PCI_IOV
 	help
 	  Say Y here if you want the PCI core to detect if PCI resource
 	  re-allocation needs to be enabled. You can always use pci=realloc=on
-          or pci=realloc=off to override it.  Note this feature is a no-op
-          unless PCI_IOV support is also enabled; in that case it will
-          automatically re-allocate PCI resources if SR-IOV BARs have not
-          been allocated by the BIOS.
+	  or pci=realloc=off to override it.  It will automatically re-allocate
+	  PCI resources if SR-IOV BARs have not been allocated by the BIOS.
 
 	  When in doubt, say N.
-- -----------------------------------------------------------------------
Sascha El-Sharkawy, MSc
University of Hildesheim                    Tel.: +49 (0) 5121 / 883-40336 Institute of Computer Science               Fax:  +49 (0) 5121 / 883-40337
Universitätsplatz 1                           elscha@sse.uni-hildesheim.de
D-31141 Hildesheim, Germany               http://www.sse.uni-hildesheim.de


> On Thu, 14 Sep 2017 10:01:17 +0200, Bjorn Helgaas wrote:
> 
> Hi Sascha,
> 
> On Wed, Aug 23, 2017 at 08:22:38AM +0200, Sascha El-Sharkawy wrote:
> > We detected that the selection of "PCI resource re-allocation detection"
> > (CONFIG_PCI_REALLOC_ENABLE_AUTO) is ignored in some situations. This 
> > can happen as the related functionality (drivers/pci/setup-bus.c, 
> > lines 1702
> > - 1738) depends on CONFIG_PCI_REALLOC_ENABLE_AUTO and
> CONFIG_PCI_IOV,
> > while in Kconfig (drivers/pci/Kconfig, lines 42 - 53) this 
> > functionality is only controlled by CONFIG_PCI_REALLOC_ENABLE_AUTO.
> >
> > The dependency on CONFIG_PCI_IOV is only mentioned in the comment
> of
> > CONFIG_PCI_REALLOC_ENABLE_AUTO, but not checked by Kconfig. As 
> > CONFIG_PCI_IOV is selected by many other configuration options, we 
> > expect the failure to happen in very few configurations only, which 
> > makes it even harder to detect and fix. However, there exist 
> > configurations that will still be faulty.  The suggested fix ensures 
> > that the re-allocation is always working as specified through an 
> > automated selection of CONFIG_PCI_IOV if
> CONFIG_PCI_REALLOC_ENABLE_AUTO is selected.
> 
> I'm sorry that I missed this patch.  I normally work from patchwork 
> (https://patchwork.ozlabs.org/project/linux-pci/list/), and it 
> apparently doesn't pick up patches that are attached (or maybe it just 
> misses gzipped ones).
> 
> Can you please repost this as plain-text email with the patch included 
> inline, with a changelog and Signed-off-by?  Then patchwork should 
> pick it up and I won't forget about it.
> 
> For details about Signed-off-by, etc, see 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre
> e/Docu mentation/process/submitting-patches.rst
> 
> Bjorn
