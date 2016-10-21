Return-Path: <stern+581ae0c0@rowland.harvard.edu>
Return-Path: <stern+581ae0c0@rowland.harvard.edu>
Date: Fri, 21 Oct 2016 16:49:07 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Bjorn Helgaas <helgaas@kernel.org>, Greg KH <greg@kroah.com>
cc: Lukas Wunner <lukas@wunner.de>, Pierre de Villemereuil <flyos@mailoo.org>,
     <linux-pci@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>
Subject: [PATCH 2/2] USB: UHCI: report non-PME wakeup signalling for Intel
 hardware
Message-ID: <Pine.LNX.4.44L0.1610211642420.1898-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

The UHCI controllers in Intel chipsets rely on a platform-specific
non-PME mechanism for wakeup signalling.  They can generate wakeup
signals even though they don't support PME.

We need to let the USB core know this so that it will enable runtime
suspend for UHCI controllers.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org>

---

Greg:

This patch is somewhat independent of the 1/2 patch I sent to Bjorn.  
Still, it will help to keep them together.  Is it okay to have him
merge both of them through his tree?

Alan Stern


[as1815]


 drivers/usb/host/uhci-pci.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: usb-4.x/drivers/usb/host/uhci-pci.c
===================================================================
--- usb-4.x.orig/drivers/usb/host/uhci-pci.c
+++ usb-4.x/drivers/usb/host/uhci-pci.c
@@ -129,6 +129,10 @@ static int uhci_pci_init(struct usb_hcd
 	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_HP)
 		uhci->wait_for_hp = 1;
 
+	/* Intel controllers use non-PME wakeup signalling */
+	if (to_pci_dev(uhci_dev(uhci))->vendor == PCI_VENDOR_ID_INTEL)
+		device_set_run_wake(uhci_dev(uhci), 1);
+
 	/* Set up pointers to PCI-specific functions */
 	uhci->reset_hc = uhci_pci_reset_hc;
 	uhci->check_and_reset_hc = uhci_pci_check_and_reset_hc;
