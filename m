Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:52102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758239AbdEONEC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 May 2017 09:04:02 -0400
Date: Mon, 15 May 2017 14:05:00 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [RFC/RFT PATCH 1/3] PCI: Introduce pci_bus_find_numa_node()
Message-ID: <20170515130500.GA19201@red-moon>
References: <20170426100619.31758-1-lorenzo.pieralisi@arm.com>
 <1494593045-19911-1-git-send-email-Vadim.Lomovtsev@caviumnetworks.com>
 <20170512155040.GA11377@red-moon>
 <20170512171846.GA21391@localhost.localdomain>
 <20170515125711.GA9700@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170515125711.GA9700@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 15, 2017 at 05:57:11AM -0700, Vadim Lomovtsev wrote:
> On Fri, May 12, 2017 at 10:18:46AM -0700, Vadim Lomovtsev wrote:
> Hi Lorenzo,
> 
> > Hi Lorenzo
> > 
> > On Fri, May 12, 2017 at 04:50:40PM +0100, Lorenzo Pieralisi wrote:
> > > Hi Vadim,
> > > 
> > > On Fri, May 12, 2017 at 05:44:05AM -0700, Vadim Lomovtsev wrote:
> > > > Hi Lorenzo,
> > > > 
> > > > Are there any news related to these patches ?
> > > 
> > > Not really, I have not received any feedback but I was expecting some
> > > to make progress here. Have you tested it ?
> > >
> > > Please let me know, thanks !
> > 
> > Not yet. Plan to test them after weekend and will get back to you.
> >
> 
> Here is the results of testing you patches at dual-socketed board
> with Cavium ThunderX SoC.
> 
> Each boot kernel boot with acpi=force argument.
> 
> 1. The 4.12-rc1 couldn't find rootfs partition so can't be tested.
> 2.1  The 4.11 without your patch set 0 to numa node for pci device
>   cat /sys/bus/pci/devices/*/numa_node
>   got zeroes here for all devices
> 2.2 The 4.11 with your patches applied set -1 to numa_node for all pci devices
>   same command provides "-1"
> 
> So looking at your patches..
> 
> At the patch 1/3 you implemented pci_bus_find_numa_node function:
> 
> +int pci_bus_find_numa_node(struct pci_bus *bus)
> +{
> +	return NUMA_NO_NODE;
> +}
> 
> Then at the 2/3 patch it is called from pci_register_host_bridge:
> @@ -770,6 +770,7 @@ int pci_register_host_bridge(struct pci_host_bridge *bridge)
> [..]
> +	set_dev_node(&bus->dev, pci_bus_find_numa_node(bus));
> 
> I suppose that is why I'm seeing those -1 in the numa_node field.
> 
> And at the patch 3/3 you implemented acpi_pci_bus_find_numa_node function
>  +int acpi_pci_bus_find_numa_node(struct pci_bus *bus)
> which implements actual work of getting numa node value,
> but it seems that nodoby calls it, isn't it ?
> 
> Don't we need to update pci_bus_find_numa_node with proper calling
> of acpi_pci_bus_find_numa_node() ?

Yes:

https://lkml.org/lkml/2017/4/26/211

Apologies for wasting your time, v2 coming with the actual call,
please have a look.

Thanks,
Lorenzo
