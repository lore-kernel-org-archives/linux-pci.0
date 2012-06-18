Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46668 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab2FRVHD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 Jun 2012 17:07:03 -0400
Received: by lbbgm6 with SMTP id gm6so4833093lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 18 Jun 2012 14:07:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
References: <20120523222635.24276.80023.stgit@bhelgaas.mtv.corp.google.com> <20120523223700.24276.76804.stgit@bhelgaas.mtv.corp.google.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 18 Jun 2012 15:06:41 -0600
Message-ID: <CAErSpo6mbzqMuewBySk5kA8E9RwOVZqOEcnM4Hy541B3pta9SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] powerpc/PCI: move DMA & IRQ init to device_add()
 notification path
To: Hiroo Matsumoto <matsumoto.hiroo@jp.fujitsu.com>
Cc: Michal Simek <monstr@monstr.eu>, benh@kernel.crashing.org,
	microblaze-uclinux@itee.uq.edu.au, linux-pci@vger.kernel.org,
	Jesse Larrew <jlarrew@linux.vnet.ibm.com>,
	jbarnes@virtuousgeek.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm trying to make some progress on these patches, but I'm concerned
about this bit:

> diff --git a/drivers/pcmcia/cardbus.c b/drivers/pcmcia/cardbus.c
> index 24caeaf..a980691 100644
> --- a/drivers/pcmcia/cardbus.c
> +++ b/drivers/pcmcia/cardbus.c
> @@ -85,7 +84,6 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>         */
>        pci_bus_size_bridges(bus);
>        pci_bus_assign_resources(bus);
> -       cardbus_config_irq_and_cls(bus, s->pci_irq);
>
>        /* socket specific tune function */
>        if (s->tune_bridge)
> @@ -93,6 +91,7 @@ int __ref cb_alloc(struct pcmcia_socket *s)
>
>        pci_enable_bridges(bus);
>        pci_bus_add_devices(bus);
> +       cardbus_config_irq_and_cls(bus, s->pci_irq);
>
>        return 0;
>  }

We're moving the CardBus IRQ config from before pci_bus_add_devices()
to after.  I see why you did that: we're proposing to do the powerpc
DMA & IRQ setup in pci_bus_add_devices(), so we don't want to have the
powerpc IRQ init clobber the CardBus IRQ config.

But a driver can claim the device as soon as we call
pci_bus_add_devices(), so we're potentially changing dev->irq after a
driver has already looked at it, which sounds like a bug.

There are only five possibilities for powerpc pci_irq_fixup:

      ppc47x_pci_irq_fixup
      mpc85xx_cds_pci_irq_fixup
      maple_pci_irq_fixup
      pmac_pci_irq_fixup
      rtas_msi_pci_irq_fixup

If these were normal PCI header quirks instead, they could run
earlier, and we wouldn't need to move this
cardbus_config_irq_and_cls() call.  Is it possible to make these
quirks, Ben?

Bjorn
