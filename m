Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:41387 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755689Ab2GDSrI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jul 2012 14:47:08 -0400
Date: Wed, 4 Jul 2012 14:47:08 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: AceLan Kao <acelan.kao@canonical.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	=?Big5?B?rHgoQWxleCmtWq/R?= <alex.hung@canonical.com>
Subject: Re: [PATCH] PCI: Quirk for ASUS S3 issue
In-Reply-To: <CAMz9Wg9fBxcHCmcOocfyMXZ+xj6rhkPOJ++gKPER9e14Z5J66w@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1207041442430.15857-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 4 Jul 2012, AceLan Kao wrote:

> We contacted the ASUS' BIOS engineer and try to verify this issue, for
> it happened
> on many ASUS' machines. Then they found that the system hangs in their
> BIOS code.
> The code will try to disable the USB if they found the PCI COMMAND
> register is not zero.
> 
> That's not a correct behavior that BIOS should do, the PCI COMMAND
> register is not
> represent if the USB is disabled or not, It's a workaround they tried to fix
> another issue in windows long time ago, but ASUS' BIOS engineer refuse to remove
> that part of code. But windows will clear the PCI COMMAND register if
> windows is already
> disabled the USB.
> So, I try to write this quirk.

> > Is there any reason not to clear the PCI COMMAND register of every PCI
> > USB host controller when entering S3?
> Quote from ASUS, they only mentioned EHCI
> ---------
> BIOS will check EHCI command register PCI regiter offset 04h to see if
> USB is disabled or not.
> Because regiter offset 04h is not cleared, BIOS think USB is not disabled.
> Then BIOS will try to disabled USB, but the USB is disabled by Ubuntu
> already. This conflict will cause system hang.
> ASUS think since Ubuntu will disable USB, it also need to clear the
> register too.
> ---------

How about this patch instead?  (I haven't tested it yet...)

Rafael, does this seem okay with no special quirk flag?  Or should the 
command register be cleared as part of the USB code?

Alan Stern



Index: usb-3.5/drivers/pci/pci-driver.c
===================================================================
--- usb-3.5.orig/drivers/pci/pci-driver.c
+++ usb-3.5/drivers/pci/pci-driver.c
@@ -748,6 +748,18 @@ static int pci_pm_suspend_noirq(struct d
 
 	pci_pm_set_unknown_state(pci_dev);
 
+	/*
+	 * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
+	 * PCI COMMAND register isn't 0, the BIOS assumes that the controller
+	 * hasn't been quiesced and tries to turn it off.  If the controller
+	 * is already in D3, this can hang or cause memory corruption.
+	 *
+	 * Since the value of the COMMAND register doesn't matter once the
+	 * device has been suspended, we can safely set it to 0 here.
+	 */
+	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
+		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
+
 	return 0;
 }
 

