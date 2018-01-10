Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 9 Jan 2018 19:11:36 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH v2 1/7] PCI: aardvark: fix logic in PCI configuration
 read/write functions
Message-ID: <20180110011136.GB157182@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-2-thomas.petazzoni@free-electrons.com>
 <20171005172330.GP25517@bhelgaas-glaptop.roam.corp.google.com>
 <20180109174918.5c4b9ee6@windsurf.lan>
MIME-Version: 1.0
In-Reply-To: <20180109174918.5c4b9ee6@windsurf.lan>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Andrew Lunn <andrew@lunn.ch>, Yehuda Yitschak <yehuday@marvell.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Jason Cooper <jason@lakedaemon.net>, linux-pci@vger.kernel.org,
 Hanna Hawa <hannah@marvell.com>, stable@vger.kernel.org,
 Nadav Haklai <nadavh@marvell.com>,
 Gregory Clement <gregory.clement@free-electrons.com>,
 Victor Gu <xigu@marvell.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Antoine Tenart <antoine.tenart@free-electrons.com>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Lorenzo, since he takes care of this now]

On Tue, Jan 09, 2018 at 05:49:18PM +0100, Thomas Petazzoni wrote:
> Hello Bjorn,
> 
> Again, reviving this very old thread :-)
> 
> On Thu, 5 Oct 2017 12:23:30 -0500, Bjorn Helgaas wrote:
> 
> > > -	if (PCI_SLOT(devfn) != 0) {
> > > +	if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0)) {  
> > 
> > I'm fine with this, but please take a look at these:
> > 
> >   8e7ca8ca5fd8 PCI: xilinx: Relax device number checking to allow SR-IOV
> >   e18934b5e9c7 PCI: designware: Relax device number checking to allow SR-IOV
> >   d99e30b7936a PCI: altera: Relax device number checking to allow SR-IOV
> > 
> > and make sure that reasoning doesn't apply here, too.
> > 
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=8e7ca8ca5fd8
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=e18934b5e9c7
> > http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d99e30b7936a
> 
> The original code for xilinx/designware/altera was doing:
> 
>  	if (bus->number == port->root_busno && devfn > 0)
>  		return false;
>  
> 	if (bus->primary == port->root_busno && devfn > 0)
> 		return false;
> 
> I.e, it was checking both if bus->number *and* bus->primary were equal
> to port->root_busno.
> 
> The commit you points removed the check on bus->primary, keeping the
> check on bus->number.
> 
> Your patch for the Aadvark driver only adds a check on bus->number, i.e
> exactly what the xilinx/designware/altera code is still doing today:

This is a long time ago and I could have forgotten, but I don't think
this is *my* patch, is it?  

> Altera:
> 
>         /* access only one slot on each root port */
>         if (bus->number == pcie->root_bus_nr && dev > 0)
>                 return false;
> 
> Designware:
> 
>         /* access only one slot on each root port */
>         if (bus->number == pp->root_bus_nr && dev > 0)
>                 return 0;
> 
> Xilinx:
> 
>         /* Only one device down on each root port */
>         if (bus->number == port->root_busno && devfn > 0)
>                 return false;
> 
> Aardvark (with our patch):
> 
>         if ((bus->number == pcie->root_bus_nr) && (PCI_SLOT(devfn) != 0)) {
>                 *val = 0xffffffff;
>                 return PCIBIOS_DEVICE_NOT_FOUND;
>         }
> 
> So we're doing exactly the same thing.
> 
> Do you agree ?

I do agree.  I can't remember what I was thinking when I first
responded.

I *would* suggest making an advk_pcie_valid_device() so your structure
matches the other drivers.  I know it seems trivial when you're mostly
looking at one driver, but it really helps those who pay attention to
all of them.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
