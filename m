Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52904 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176Ab3BDU2M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 4 Feb 2013 15:28:12 -0500
Message-ID: <1360009684.11144.539.camel@bling.home>
Subject: Re: PCI warning on boot 3.8.0-rc1
From: Alex Williamson <alex.williamson@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org
Date: Mon, 04 Feb 2013 13:28:04 -0700
In-Reply-To: <20130204103645.38ae2d5e@nehalam.linuxnetplumber.net>
References: <20130116143853.339dd89b@nehalam.linuxnetplumber.net>
	 <CAErSpo5eOE_=Ob2jN7ACy0eJBOa8k36XqCbHnGTCs-wfiy8tiw@mail.gmail.com>
	 <20130204103645.38ae2d5e@nehalam.linuxnetplumber.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 2013-02-04 at 10:36 -0800, Stephen Hemminger wrote:
> > I think drivers/pci/search.c is identical between 3.7 and 3.8-rc1.  Is
> > this the first time you've turned on the IOMMU on that box?
> 
> It exists in 3.7 and earlier kernels, just haven't turned on same config.
> 
> > It's the same warning as in this bugzilla:
> > https://bugzilla.kernel.org/show_bug.cgi?id=44881, and there's a patch
> > there at https://bugzilla.kernel.org/show_bug.cgi?id=44881#c11, but
> > it's just a quirk that turns off VT-d if we find certain broken
> > bridges.  It doesn't look like you have any of those (although I don't
> > know what you have at 05:00.0).
> > 
> > Bjorn
> 
> This is a standard ASUS motherboard, and don't want to disable VT-d.

Stephen,

Can you give the lspci -vvv of device 5:00.0 to see if it's one we've
seen before?  Does the patch below help?

Bjorn, I think we need to quirk it somehow.  So far they've all been
PCI-to-PCI bridges attached to root ports where we expect it's actually
a PCIe-to-PCI bridge.  Seems like maybe we could have the same attached
to a downstream port.  The patch below avoids the WARN and gives us a
device, but of course pci_is_pcie reports wrong for this device and may
cause some trickle down breakage.  A more complete option might be to
add a is_pcie flag to the device that can be set independent of
pcie_cap.  We'd need to check all the callers for assumptions, but then
we could put the quirk in one place and hopefully fix everything.
Thoughts?  Thanks,

Alex


diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bf969ba..65ae270 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -42,6 +42,15 @@ pci_find_upstream_pcie_bridge(struct pci_dev *pdev)
 		}
 		/* PCI device should connect to a PCIe bridge */
 		if (pci_pcie_type(pdev) != PCI_EXP_TYPE_PCI_BRIDGE) {
+			/*
+			 * Not all PCIe-to-PCI bridges expose a PCIe
+			 * capability.  If we make it to a PCIe root port
+			 * and the previous device was a PCI-to-PCI bridge,
+			 * assume it was really a PCIe-to-PCI bridge.
+			 */
+			if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT &&
+			    tmp && tmp->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+				return tmp;
 			/* Busted hardware? */
 			WARN_ON_ONCE(1);
 			return NULL;


