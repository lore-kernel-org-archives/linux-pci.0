Return-Path: <lorenzo.pieralisi@arm.com>
Return-Path: <lorenzo.pieralisi@arm.com>
Date: Tue, 3 May 2016 09:46:28 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jayachandran C <jchandra@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Tomasz Nowicki <tn@semihalf.com>,
	Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, rafael@kernel.org,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Sinan Kaya <okaya@codeaurora.org>, jiang.liu@linux.intel.com,
	robert.richter@caviumnetworks.com, Marcin Wojtas <mw@semihalf.com>,
	Liviu.Dudau@arm.com, David Daney <ddaney@caviumnetworks.com>,
	Wangyijing <wangyijing@huawei.com>, Suravee.Suthikulpanit@amd.com,
	msalter@redhat.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org,
	Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH V6 09/13] pci, acpi: Support for ACPI based generic PCI
 host controller
Message-ID: <20160503084628.GA31158@red-moon>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-10-git-send-email-tn@semihalf.com>
 <20160428214800.GG25125@localhost>
 <20160429083709.GA3249@red-moon>
 <CAKc_7PUcjKkCrCTj9q26P8a+Tb3N_MffynnTXnJRacm6VNmFRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKc_7PUcjKkCrCTj9q26P8a+Tb3N_MffynnTXnJRacm6VNmFRw@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 29, 2016 at 11:05:34PM +0530, Jayachandran C wrote:
> On Fri, Apr 29, 2016 at 2:07 PM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > On Thu, Apr 28, 2016 at 04:48:00PM -0500, Bjorn Helgaas wrote:
> >
> > [...]
> >
> >> > +static int pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root,
> >> > +                                  struct acpi_pci_generic_root_info *ri)
> >> > +{
> >> > +   u16 seg = root->segment;
> >> > +   u8 bus_start = root->secondary.start;
> >> > +   u8 bus_end = root->secondary.end;
> >> > +   struct pci_config_window *cfg;
> >> > +   struct mcfg_entry *e;
> >> > +   phys_addr_t addr;
> >> > +   int err = 0;
> >> > +
> >> > +   mutex_lock(&pci_mcfg_lock);
> >>
> >> What does this lock protect?  The pci_mcfg_list should already be
> >> initialized by the time we get there, and it should be immutable for
> >> the life of the system.  In fact, I would prefer if we could just
> >> search the static table itself whenever we need it rather than caching
> >> it in our own list.  But I don't think we can easily do that because
> >> acpi_table_parse() is __init.
> >>
> >> > +   e = pci_mcfg_lookup(seg, bus_start);
> >>
> >> I would argue that we should check for _CBA first, and fall back to
> >> MCFG if _CBA doesn't exist.
> >>
> >> > +   if (!e) {
> >> > +           addr = acpi_pci_root_get_mcfg_addr(root->device->handle);
> >>
> >> IMO, acpi_pci_root_get_mcfg_addr() is misnamed.  It should be
> >> acpi_pci_config_base_addr() or similar.  It definitely is not related
> >> to MCFG.  Not your fault, obviously.
> >>
> >> > +           if (addr == 0) {
> >> > +                   pr_err(PREFIX"%04x:%02x-%02x bus range error\n",
> >> > +                          seg, bus_start, bus_end);
> >> > +                   err = -ENOENT;
> >> > +                   goto err_out;
> >> > +           }
> >> > +   } else {
> >> > +           if (bus_start != e->bus_start) {
> >> > +                   pr_err("%04x:%02x-%02x bus range mismatch %02x\n",
> >> > +                          seg, bus_start, bus_end, e->bus_start);
> >> > +                   err = -EINVAL;
> >> > +                   goto err_out;
> >> > +           } else if (bus_end != e->bus_end) {
> >> > +                   pr_warn("%04x:%02x-%02x bus end mismatch %02x\n",
> >> > +                           seg, bus_start, bus_end, e->bus_end);
> >> > +                   bus_end = min(bus_end, e->bus_end);
> >> > +           }
> >> > +           addr = e->addr;
> >> > +   }
> >>
> >> I really don't think you need a lock around this, so you can factor
> >> out the address lookup into something like:
> >>
> >>   addr = acpi_pci_config_base_addr(...);
> >>   if (addr)
> >>     return addr;
> >>
> >>   return acpi_pci_mcfg_lookup(seg, busn_res);
> >>
> >> You can check inside acpi_pci_mcfg_lookup() to make sure the entry you
> >> find covers the entire [busn_res.start-busn_res.end] range and return
> >> failure if it doesn't.  At this point, I'm not sure it's worth it to
> >> truncate the host bridge bus range to match something we find in MCFG.
> >>
> >> If the MCFG entry covers *more* than the host bridge range from _CRS,
> >> that's fine.  In any case, we have to be careful with the start address,
> >> because the MCFG start address is always based on bus 0, but I think
> >> pci_generic_ecam_create() expects the start address based on the
> >> bus_start you pass to it.
> >
> > Yes, I spotted this too, it is unfortunate but DT and MCFG handle
> > the ECAM regions differently. In DT the reg property is relative
> > to bus_start - ie reg MMIO region maps config space starting at
> > the first bus in bus-range:
> >
> > Documentation/devicetree/bindings/pci/host-generic-pci.txt
> >
> > in ACPI(MCFG) as you said it is always relative to bus 0, it is
> > unfortunate but the address to be mapped should be computed
> > differently in the ECAM layer.
> 
> Can't this be handled by fixing up the address before passing to
> pci_generic_ecam_create?

Yes it can, you just need to apply the bus shift, given that we know
it is ECAM anyway you can even add a macro in the ecam generic header to
compute it, anyway that's a minor detail, we just should not forget to
fix it.

Lorenzo
