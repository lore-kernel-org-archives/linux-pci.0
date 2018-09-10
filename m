Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bmailout1.hostsharing.net ([83.223.95.100]:47743 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeIJVEP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Sep 2018 17:04:15 -0400
Date: Mon, 10 Sep 2018 18:09:26 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv2 16/20] PCI/pciehp: Implement error handling callbacks
Message-ID: <20180910160926.7grtfdyw3iv2xg4x@wunner.de>
References: <20180905203546.21921-1-keith.busch@intel.com>
 <20180905203546.21921-17-keith.busch@intel.com>
 <20180910132033.ei5nk4iibt7pesd5@wunner.de>
 <20180910145641.GA7466@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180910145641.GA7466@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 10, 2018 at 08:56:42AM -0600, Keith Busch wrote:
> On Mon, Sep 10, 2018 at 06:20:33AM -0700, Lukas Wunner wrote:
> > On Wed, Sep 05, 2018 at 02:35:42PM -0600, Keith Busch wrote:
> > > +static void pciehp_error_detected(struct pcie_device *dev)
> > > +{
> > > +	struct controller *ctrl = get_service_data(dev);
> > > +
> > > +	/*
> > > +	 * Shutdown notification to ignore hotplug events during error
> > > +	 * handling. We'll recheck the status when error handling completes.
> > > +	 *
> > > +	 * It is possible link event related to this error handling may have
> > > +	 * triggered a the hotplug interrupt ahead of this notification, but we
> > > +	 * can't do anything about that race.
> > > +	 */
> > > +	pcie_shutdown_notification(ctrl);
> > 
> > Unfortunately this patch does not take into account my comment on
> > patch [13/16] in v1 of this series that pcie_shutdown_notification()
> > can't be used here because the sysfs user interface to enable/disable
> > the slot is still present but no longer functions once the IRQ is
> > released:
> > https://patchwork.ozlabs.org/patch/964715/
> > 
> > My suggestion was:
> > 
> >    "I think what you want to do instead is "down_write(&ctrl->reset_lock)",
> >     see commit 5b3f7b7d062b ("PCI: pciehp: Avoid slot access during reset").
> >     And possibly mask PDCE/DLLSCE like pciehp_reset_slot() does."
> 
> The sysfs entries still function. Their actions are only temporarily
> stalled during error handling. Once the slot reset is called, the
> ctrl->pending_events is queried to take requested actions.

Okay I see.  Still, releasing the IRQ and requesting it again seems fairly
heavy-wheight.  Why not just acquire ctrl->reset_lock?


> > > +static void pciehp_slot_reset(struct pcie_device *dev)
> > > +{
> > > +	struct controller *ctrl = get_service_data(dev);
> > > +	u8 changed;
> > > +
> > > +	/*
> > > +	 * Cache presence detect change, but ignore other hotplug events that
> > > +	 * may occur during error handling. Ports that implement only in-band
> > > +	 * presence detection may inadvertently believe the device has changed,
> > > +	 * so those devices will have to be re-enumerated.
> > > +	 */
> > > +	pciehp_get_adapter_changed(ctrl->slot, &changed);
> > > +	pcie_clear_hotplug_events(ctrl);
> > > +	pcie_init_notification(ctrl);
> > > +
> > > +	if (changed) {
> > > +		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
> > > +		__pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> > 
> > The __pci_walk_bus() seems superfluous because the devices are also
> > marked disconnected when bringing down the slot as a result of the
> > synthesized PCI_EXP_SLTSTA_PDC event.
> 
> Right, but we can't do that inline with the slot reset because of the
> circular locks that creates with the pci_bus_sem. We still want to
> fence off drivers for downstream devices from mucking with config space
> in a topology that is reported to be different than the one we're
> recoverying from. You can get undefined results that way.

I don't quite follow.  I meant that __pci_walk_bus() is unnecessary
because the pciehp_request() call indirectly triggers it.  So the
devices are marked disconnected twice.

Thanks,

Lukas
