Return-Path: <SRS0=kwQm=EE=free-electrons.com=thomas.petazzoni@kernel.org>
Return-Path: <SRS0=kwQm=EE=free-electrons.com=thomas.petazzoni@kernel.org>
Date: Tue, 9 Jan 2018 17:49:18 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Andrew
 Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper
 <jason@lakedaemon.net>, Hanna Hawa <hannah@marvell.com>,
 stable@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu
 <xigu@marvell.com>, =?UTF-8?B?TWlxdcOobA==?= Raynal
 <miquel.raynal@free-electrons.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, Antoine Tenart
 <antoine.tenart@free-electrons.com>, linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 1/7] PCI: aardvark: fix logic in PCI configuration
 read/write functions
Message-ID: <20180109174918.5c4b9ee6@windsurf.lan>
In-Reply-To: <20171005172330.GP25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
	<20170928125838.11887-2-thomas.petazzoni@free-electrons.com>
	<20171005172330.GP25517@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

Again, reviving this very old thread :-)

On Thu, 5 Oct 2017 12:23:30 -0500, Bjorn Helgaas wrote:

> > -	if (PCI_SLOT(devfn) != 0) {
> > +	if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0)) {  
> 
> I'm fine with this, but please take a look at these:
> 
>   8e7ca8ca5fd8 PCI: xilinx: Relax device number checking to allow SR-IOV
>   e18934b5e9c7 PCI: designware: Relax device number checking to allow SR-IOV
>   d99e30b7936a PCI: altera: Relax device number checking to allow SR-IOV
> 
> and make sure that reasoning doesn't apply here, too.
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8e7ca8ca5fd8
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e18934b5e9c7
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d99e30b7936a

The original code for xilinx/designware/altera was doing:

 	if (bus->number == port->root_busno && devfn > 0)
 		return false;
 
	if (bus->primary == port->root_busno && devfn > 0)
		return false;

I.e, it was checking both if bus->number *and* bus->primary were equal
to port->root_busno.

The commit you points removed the check on bus->primary, keeping the
check on bus->number.

Your patch for the Aadvark driver only adds a check on bus->number, i.e
exactly what the xilinx/designware/altera code is still doing today:

Altera:

        /* access only one slot on each root port */
        if (bus->number == pcie->root_bus_nr && dev > 0)
                return false;

Designware:

        /* access only one slot on each root port */
        if (bus->number == pp->root_bus_nr && dev > 0)
                return 0;

Xilinx:

        /* Only one device down on each root port */
        if (bus->number == port->root_busno && devfn > 0)
                return false;

Aardvark (with our patch):

        if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0)) {
                *val = 0xffffffff;
                return PCIBIOS_DEVICE_NOT_FOUND;
        }

So we're doing exactly the same thing.

Do you agree ?

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
