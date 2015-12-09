Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 9 Dec 2015 15:55:11 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: "Jayachandran C." <jchandra@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Tomasz Nowicki <tn@semihalf.com>, bhelgaas@google.com,
	arnd@arndb.de, rjw@rjwysocki.net, hanjun.guo@linaro.org,
	jiang.liu@linux.intel.com, ddaney@caviumnetworks.com,
	Liviu.Dudau@arm.com, tglx@linutronix.de, wangyijing@huawei.com,
	Suravee.Suthikulpanit@amd.com, msalter@redhat.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-acpi@lists.linaro.org
Subject: Re: [PATCH V1 00/11] MMCONFIG refactoring and ARM64 PCI hostbridge
 init based on ACPI
Message-ID: <20151209155511.GB21048@red-moon>
References: <1445963922-22711-1-git-send-email-tn@semihalf.com>
 <20151207203117.GB14429@localhost>
 <20151209100125.GA12632@jayachandranc.netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151209100125.GA12632@jayachandranc.netlogicmicro.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 09, 2015 at 03:31:41PM +0530, Jayachandran C. wrote:
> [trimmed the cc list a bit]
> On Mon, Dec 07, 2015 at 02:31:17PM -0600, Bjorn Helgaas wrote:
> > On Tue, Oct 27, 2015 at 05:38:31PM +0100, Tomasz Nowicki wrote:
> [...]
> > > 
> > > Tomasz Nowicki (10):
> > >   x86, pci: Reorder logic of pci_mmconfig_insert() function
> > >   x86, pci, acpi: Move arch-agnostic MMCONFIG (aka ECAM) and ACPI code
> > >     out of arch/x86/ directory
> > >   pci, acpi, mcfg: Provide generic implementation of MCFG code
> > >     initialization.
> > >   x86, pci: mmconfig_{32,64}.c code refactoring - remove code
> > >     duplication.
> > >   x86, pci, ecam: mmconfig_64.c becomes default implementation for ECAM
> > >     driver.
> > >   pci, acpi, mcfg: Provide default RAW ACPI PCI config space accessors.
> > >   pci, acpi, ecam: Add flag to indicate whether ECAM region was hot
> > >     added or not.
> > >   x86, pci: Use previously added ECAM hot_added flag to remove ECAM
> > >     regions.
> [...]
> > 
> > Waiting for an updated version after all the discussion.
> 
> Hi Bjorn,
> 
> After looking thru the code, I don't think moving the mmconfig code out
> of x86 and using it in ARM64 is a good idea.
> 
> The code maintains a list of mapping of ECAM regions which can modified
> at run time, and ends doing this sequence for doing a config access:
> 
>         rcu_read_lock();
>         addr = pci_dev_base(seg, bus, devfn);
> 	        list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
> 			...find mapping...
> 	do pci operation
> 	rcu_read_unlock();
> 
> A lot of the complexity in mmconfig_*.c is to maintain and validate
> the pci_mmcfg_list which seems to be unecessary.

That list is there to manage hotplug bridges, what makes you think
it is not necessary ? Jiang (in CC) can certainly comment on that and
how that list handling can be updated/simplified, if possible.

> The better way would be to keep the mapping of ECAM region in the PCI
> host bridge sysdata like pci-host-generic and directly access using
> map_bus/read/write.
> 
> I see that early raw_pci_read/raw_pci_write may need to be supported.
> I am not sure if this is needed in ARM64 - and if it is, we can handle
> this by taking an early mapping for ECAM regions until the PCI host
> bridges are setup, and dropping the mapping at that point.

I do not think it is needed (and if it is it can be added later, it
should not block this series), this was already debated in previous
threads (and in the ASWG, where basically nobody could provide a reason
why those raw accessors in ACPICA are meant to exist, they are there for
AML to access config space, why that has to be happen before PCI busses
are enumerated is still a mystery to me).

Lorenzo
