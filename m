Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51000 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbbJWDBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 Oct 2015 23:01:13 -0400
Date: Thu, 22 Oct 2015 22:01:03 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Casey Leedom <leedom@chelsio.com>
Cc: Hariprasad Shenai <hariprasad@chelsio.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, nirranjan@chelsio.com
Subject: Re: [PATCH] pci: Add pci quirk to turnoff Nosnoop and Relaxed
 Ordering
Message-ID: <20151023030103.GA20335@localhost>
References: <1445178304-14855-1-git-send-email-hariprasad@chelsio.com>
 <20151022221319.GI21237@localhost>
 <70CDF9AE-F98E-47F5-AB08-9A7A5D399351@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <70CDF9AE-F98E-47F5-AB08-9A7A5D399351@chelsio.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Oct 22, 2015 at 05:07:38PM -0700, Casey Leedom wrote:
>   Thanks Bjorn!  We really appreciate your help in getting this in.  We’ll check your version of the patch ASAP.

How embarrassing.  The patch below doesn't even compile because of a typo
and some const issues.  I updated it and repushed pci/misc.

> > On Oct 22, 2015, at 3:13 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > Hi Hariprasad & Casey,
> > 
> > On Sun, Oct 18, 2015 at 07:55:04PM +0530, Hariprasad Shenai wrote:
> >> Some devices violate the PCI Specification regarding echoing the Root
> >> Port Transaction Layer Packet Request (TLP) No Snoop and Relaxed
> >> Ordering Attributes into the TLP Response. The PCI Specification
> >> "encourages" compliant Root Port implementation to drop such
> >> malformed TLP Responses leading to device access timeouts. Many Root Port
> >> implementations accept such malformed TLP Responses and a few more
> >> strict implementations do drop them.
> >> 
> >> For devices which fail this part of the PCI Specification, we need to
> >> traverse up the PCI Chain to the Root Port and turn off the Enable No
> >> Snoop and Enable Relaxed Ordering bits in the Root Port's PCI-Express
> >> Device Control register. This does affect all other devices which
> >> are downstream of that Root Port.
> >> 
> >> Note that Configuration Space accesses are never supposed to have TLP
> >> Attributes, so we're safe waiting till after any Configuration Space
> >> accesses to do the Root Port "fixup".
> >> 
> >> Based on original work by Casey Leedom <leedom@chelsio.com>
> >> 
> >> Signed-off-by: Hariprasad Shenai <hariprasad@chelsio.com>
> > 
> > I reworked this and applied the patch below to pci/misc for v4.4.
> > 
> > Please try it out to make sure I didn't break something.  Here's what I
> > changed:
> > 
> >  - Changelog and comments to include specific spec references (they
> >    were in Casey's original posts but got lost).
> > 
> >  - Renamed to pci_find_pcie_root_port() to keep "root_port" together.
> > 
> >  - Reworked to use pci_upstream_bridge() to avoid issues if we're
> >    under a "virtual bus" used for SR-IOV (this isn't likely to be a
> >    problem, but it's hard to prove it's not).
> > 
> >  - Added a check for "Root Port" device type, with the intent to use
> >    this other places, e.g., to replace pcie_find_root_port().
> > 
> >  - Removed the "Can't find Root Port" message; if we use
> >    pci_find_pcie_root_port() generically, the caller should be
> >    responsible for deciding if a message is appropriate.
> > 
> >  - Reworded quirk "Can't find Root Port to disable No Snoop/Relaxed
> >    Ordering" message to make it clear that we're trying to work
> >    around a device erratum.  I don't think the original message had
> >    enough context to be useful.
> > 
> >  - Reworded "Disabling No Snoop/Relaxed Ordering on Root Port %s'
> >    message, again to make the reason clear (device erratum) and to
> >    use the root port as the affected device.
> > 
> > Bjorn
> > 
> > 
> > commit 4cdcda8244d4c7b8a0e37fe2ce8d11d4633c6687
> > Author: Hariprasad Shenai <hariprasad@chelsio.com>
> > Date:   Sun Oct 18 19:55:04 2015 +0530
> > 
> >    PCI: Turn off Request Attributes to avoid Chelsio T5 Completion erratum
> > 
> >    The Chelsio T5 has a PCIe compliance erratum that causes Malformed TLP or
> >    Unexpected Completion errors in some systems, which may cause device access
> >    timeouts.
> > 
> >    Per PCIe r3.0, sec 2.2.9, "Completion headers must supply the same values
> >    for the Attribute as were supplied in the header of the corresponding
> >    Request, except as explicitly allowed when IDO is used."
> > 
> >    Instead of copying the Attributes from the Request to the Completion, the
> >    T5 always generates Completions with zero Attributes.  The receiver of a
> >    Completion whose Attributes don't match the Request may accept it (which
> >    itself seems non-compliant based on sec 2.3.2), or it may handle it as a
> >    Malformed TLP or an Unexpected Completion, which will probably lead to a
> >    device access timeout.
> > 
> >    Work around this by disabling "Relaxed Ordering" and "No Snoop" in the Root
> >    Port so it always generate Requests with zero Attributes.
> > 
> >    This does affect all other devices which are downstream of that Root Port,
> >    but these are performance optimizations that should not make a functional
> >    difference.
> > 
> >    Note that Configuration Space accesses are never supposed to have TLP
> >    Attributes, so we're safe waiting till after any Configuration Space
> >    accesses to do the Root Port "fixup".
> > 
> >    Based on original work by Casey Leedom <leedom@chelsio.com>
> > 
> >    [bhelgaas: changelog, comments, rename to pci_find_pcie_root_port(), rework
> >    to use pci_upstream_bridge() and check for Root Port device type, edit
> >    diagnostics to clarify intent and devices affected]
> >    Signed-off-by: Hariprasad Shenai <hariprasad@chelsio.com>
> >    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 6a9a111..3dacbeb 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -458,6 +458,30 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
> > EXPORT_SYMBOL(pci_find_parent_resource);
> > 
> > /**
> > + * pci_find_pcie_root_port - return PCIe Root Port
> > + * @dev: PCI device to query
> > + *
> > + * Traverse up the parent chain and return the PCIe Root Port PCI Device
> > + * for a given PCI Device.
> > + */
> > +struct pci_dev *pci_find_pcie_root_port(const struct pci_dev *dev)
> > +{
> > +	struct pci_dev *bridge, *highest_pcie_bridge = NULL;
> > +
> > +	bridge = pci_upstream_bridge(dev);
> > +	while (bridge && pci_is_pcie(bridge)) {
> > +		highest_pcie_bridge = bridge;
> > +		bridge = pci_upstream_bridge(bridge);
> > +	}
> > +
> > +	if (pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
> > +		return NULL;
> > +
> > +	return highest_pcie_bridge;
> > +}
> > +EXPORT_SYMBOL(pci_find_pcie_root_port);
> > +
> > +/**
> >  * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
> >  * @dev: the PCI device to operate on
> >  * @pos: config space offset of status word
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index 6a30252..eb3c98e 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -3692,6 +3692,63 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(0x1797, 0x6869, PCI_CLASS_NOT_DEFINED, 8,
> > 			      quirk_tw686x_class);
> > 
> > /*
> > + * Per PCIe r3.0, sec 2.2.9, "Completion headers must supply the same
> > + * values for the Attribute as were supplied in the header of the
> > + * corresponding Request, except as explicitly allowed when IDO is used."
> > + *
> > + * If a non-compliant device generates a completion with a different
> > + * attribute than the request, the receiver may accept it (which itself
> > + * seems non-compliant based on sec 2.3.2), or it may handle it as a
> > + * Malformed TLP or an Unexpected Completion, which will probably lead to a
> > + * device access timeout.
> > + *
> > + * If the non-compliant device generates completions with zero attributes
> > + * (instead of copying the attributes from the request), we can work around
> > + * this by disabling the "Relaxed Ordering" and "No Snoop" attributes in
> > + * upstream devices so they always generate requests with zero attributes.
> > + *
> > + * This affects other devices under the same Root Port, but since these
> > + * attributes are performance hints, there should be no functional problem.
> > + *
> > + * Note that Configuration Space accesses are never supposed to have TLP
> > + * Attributes, so we're safe waiting till after any Configuration Space
> > + * accesses to do the Root Port fixup.
> > + */
> > +static void quirk_disable_root_port_attributes(struct pci_dev *pdev)
> > +{
> > +	struct pci_dev *root_port = pci_find_pcie_root_port(pdev);
> > +
> > +	if (!root_port) {
> > +		dev_warn(&pdev->dev, "PCIe Completion erratum may cause device errors\n");
> > +		return;
> > +	}
> > +
> > +	dev_info(&root_port->dev, "Disabling No Snoop/Relaxed Ordering Attributes to avoid PCIe Completion erratum in %s\n",
> > +		 dev_name(&pdev->dev));
> > +	pcie_capability_clear_and_set_word(root_port, PCI_EXP_DEVCTL,
> > +					   PCI_EXP_DEVCTL_RELAX_EN |
> > +					   PCI_EXP_DEVCTL_NOSNOOP_EN, 0);
> > +}
> > +
> > +/*
> > + * The Chelsio T5 chip fails to copy TLP Attributes from a Request to the
> > + * Completion it generates.
> > + */
> > +static void quirk_chelsio_T5_disable_root_port_attributes(struct pci_dev *pdev)
> > +{
> > +	/*
> > +	 * This mask/compare operation selects for Physical Function 4 on a
> > +	 * T5.  We only need to fix up the Root Port once for any of the
> > +	 * PFs.  PF[0..3] have PCI Device IDs of 0x50xx, but PF4 is uniquely
> > +	 * 0x54xx so we use that one,
> > +	 */
> > +	if ((pdev->device & 0xff00) == 0x5400)
> > +		quirk_disable_root_port_attributes(pdev);
> > +}
> > +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> > +			 quirk_chelsio_T5_disable_root_port_attributes);
> > +
> > +/*
> >  * AMD has indicated that the devices below do not support peer-to-peer
> >  * in any system where they are found in the southbridge with an AMD
> >  * IOMMU in the system.  Multifunction devices that do not support
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index b54fbf1..0f3696c 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -820,6 +820,7 @@ void pci_bus_add_device(struct pci_dev *dev);
> > void pci_read_bridge_bases(struct pci_bus *child);
> > struct resource *pci_find_parent_resource(const struct pci_dev *dev,
> > 					  struct resource *res);
> > +struct pci_dev *pci_find_root_pcie_port(const struct pci_dev *dev);
> > u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
> > int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
> > u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
