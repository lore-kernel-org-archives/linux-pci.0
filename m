Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 Sep 2017 09:49:04 +0200
From: Jan Glauber <jan.glauber@caviumnetworks.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.daney@cavium.com,
        Jon Masters <jcm@redhat.com>,
        Robert Richter <robert.richter@cavium.com>,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: Avoid slot reset for Cavium cn8xxx root ports
Message-ID: <20170907074904.GB13490@hc>
References: <20170830142454.10971-1-jglauber@cavium.com>
 <20170830142454.10971-4-jglauber@cavium.com>
 <20170830084012.19d91759@w520.home>
 <20170831094052.GA15906@hc>
 <20170831100130.5c8a922e@w520.home>
 <20170907074011.GA13490@hc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170907074011.GA13490@hc>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 07, 2017 at 09:40:11AM +0200, Jan Glauber wrote:
> So what if we add an additional check like:
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index fdf65a6..389db4b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4389,6 +4389,9 @@ static bool pci_slot_resetable(struct pci_slot *slot)
>  {
>         struct pci_dev *dev;
>  
> +       if (slot->bus->self & PCI_DEV_FLAGS_NO_BUS_RESET)
> +               return false;
> +
>         list_for_each_entry(dev, &slot->bus->devices, bus_list) {
>                 if (!dev->slot || dev->slot != slot)
>                         continue;

Obviously I meant:
if (slot->bus->self->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)

--Jan
