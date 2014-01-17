Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33738 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752823AbaAQSWf (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jan 2014 13:22:35 -0500
Received: by mail-ie0-f177.google.com with SMTP id at1so2851037iec.36
        for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2014 10:22:34 -0800 (PST)
Date: Fri, 17 Jan 2014 11:22:31 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	USB list <linux-usb@vger.kernel.org>,
	"Chen, Jamie" <jamie.chen@intel.com>,
	"Tsai, Gaggery" <gaggery.tsai@intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: EHCI host broken -- interrupts disabled
Message-ID: <20140117182231.GA18421@google.com>
References: <CAErSpo6v-QLkthigN3HdLizCa_7QxOS+dZ61Fse2jz5KJRdh0Q@mail.gmail.com>
 <Pine.LNX.4.44L0.1401161435350.1109-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44L0.1401161435350.1109-100000@iolanthe.rowland.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 16, 2014 at 02:40:35PM -0500, Alan Stern wrote:
> On Thu, 16 Jan 2014, Bjorn Helgaas wrote:
> 
> > I think dev->irq is supposed to be valid after pci_enable_device(), so
> > it seems like it would make sense to clear PCI_COMMAND_INTX_DISABLE
> > there.
> 
> Okay.
> 
> > I don't know why a BIOS would leave PCI_COMMAND_INTX_DISABLE set for
> > the EHCI device.  Does it support MSI, and the BIOS assumes the OS
> > should use that?  I don't see any MSI support in the EHCI code.  In
> 
> As far as I know, there aren't any EHCI designs that use MSI.  And
> there is no particular reason why a BIOS would leave INTX_DISABLE set,
> although come to think of it, there doesn't seem to be any reason why a
> BIOS should leave that bit clear either.
> 
> > any case, this doesn't seem like something we need to depend on the
> > BIOS to do for us.
> 
> Could you post a patch for Gaggery or Jamie to try out?

Can you try the patch below?  This is against 6e2d98dc1af4, the tip of the
PCI "next" branch, but it should apply easily to any recent kernel.

Can you also collect the dmesg and "lspci -vv" output for reference, in
case we need to tweak or rework this in the future?  Please remove any
non-public details from that information before posting it.

Bjorn


PCI: Enable INTx if BIOS left it disabled

From: Bjorn Helgaas <bhelgaas@google.com>

Some firmware leaves the Interrupt Disable bit set even if the device uses
INTx interrupts.  Clear Interrupt Disable so we get those interrupts.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b6d4afa8ba40..0b6a1119b818 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1181,6 +1181,8 @@ EXPORT_SYMBOL_GPL(pci_load_and_free_saved_state);
 static int do_pci_enable_device(struct pci_dev *dev, int bars)
 {
 	int err;
+	u16 cmd;
+	u8 pin;
 
 	err = pci_set_power_state(dev, PCI_D0);
 	if (err < 0 && err != -EIO)
@@ -1190,6 +1192,14 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
 		return err;
 	pci_fixup_device(pci_fixup_enable, dev);
 
+	pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
+	if (pin) {
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
+		if (cmd & PCI_COMMAND_INTX_DISABLE)
+			pci_write_config_word(dev, PCI_COMMAND,
+					      cmd & ~PCI_COMMAND_INTX_DISABLE);
+	}
+
 	return 0;
 }
 
