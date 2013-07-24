Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46641 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751619Ab3GXVsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 24 Jul 2013 17:48:09 -0400
Message-ID: <1374702465.6142.3.camel@pasglop>
Subject: Re: [PATCH 04/11] PCI/hotplug: Needn't remove EEH cache again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 25 Jul 2013 07:47:45 +1000
In-Reply-To: <CAErSpo7rXF9vf=BMT1LoLeHPRiyJxT2XWbroRjdt+DH8+4QOnA@mail.gmail.com>
References: <1374632701-20972-1-git-send-email-shangw@linux.vnet.ibm.com>
	 <1374632701-20972-5-git-send-email-shangw@linux.vnet.ibm.com>
	 <CAErSpo7rXF9vf=BMT1LoLeHPRiyJxT2XWbroRjdt+DH8+4QOnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2013-07-24 at 12:02 -0600, Bjorn Helgaas wrote:
> [+cc linux-pci]
> 
> On Tue, Jul 23, 2013 at 8:24 PM, Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> > Since pcibios_release_device() called by pci_stop_and_remove_bus_device()
> > has removed the EEH cache, we needn't do that again.
> >
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> 
> I'll be happy to merge this if you want, or since you have my Ack
> already, you can merge it with the rest of the series.  I didn't get
> the rest of the series, so I don't know if it depends on this.
> 
> Just let me know what you want me to do.

Already merged :-)

Thanks !

Cheers,
Ben.

> > ---
> >  drivers/pci/hotplug/rpadlpar_core.c |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
> > index b29e20b..bb7af78 100644
> > --- a/drivers/pci/hotplug/rpadlpar_core.c
> > +++ b/drivers/pci/hotplug/rpadlpar_core.c
> > @@ -388,7 +388,6 @@ int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
> >         /* Remove the EADS bridge device itself */
> >         BUG_ON(!bus->self);
> >         pr_debug("PCI: Now removing bridge device %s\n", pci_name(bus->self));
> > -       eeh_remove_bus_device(bus->self, true);
> >         pci_stop_and_remove_bus_device(bus->self);
> >
> >         return 0;
> > --
> > 1.7.5.4
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


