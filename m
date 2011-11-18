Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48930 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752743Ab1KRSOa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2011 13:14:30 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 68CEC20A8B
	for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2011 13:14:30 -0500 (EST)
Date: Fri, 18 Nov 2011 10:14:24 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Felipe Balbi <balbi@ti.com>
Subject: [PATCH] DWC3: use module_pci_driver
Message-ID: <20111118181424.GB29495@kroah.com>
References: <20111118181249.GA29495@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111118181249.GA29495@kroah.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Greg Kroah-Hartman <gregkh@suse.de>

This cuts down on the boilerplate code.


Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Felipe Balbi <balbi@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

Here's an example of how this works, it ends up deleting a ton of
duplicated code all over the kernel, and it also has the very nice side
affect of deleting a bunch of "this module is now loading" printks that
are just cluttering up our kernel logs, making the overall kernel size
smaller, which is good thing.


 drivers/usb/dwc3/dwc3-pci.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -206,14 +206,4 @@ MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("DesignWare USB3 PCI Glue Layer");
 
-static int __devinit dwc3_pci_init(void)
-{
-	return pci_register_driver(&dwc3_pci_driver);
-}
-module_init(dwc3_pci_init);
-
-static void __exit dwc3_pci_exit(void)
-{
-	pci_unregister_driver(&dwc3_pci_driver);
-}
-module_exit(dwc3_pci_exit);
+module_pci_driver(dwc3_pci_driver);
