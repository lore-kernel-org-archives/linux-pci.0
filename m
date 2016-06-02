Return-Path: <arnd@arndb.de>
Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Tomasz Nowicki <tn@semihalf.com>
Cc: linux-arm-kernel@lists.infradead.org, rafael@kernel.org, linux-pci@vger.kernel.org, will.deacon@arm.com, okaya@codeaurora.org, wangyijing@huawei.com, andrea.gallo@linaro.org, Lorenzo.Pieralisi@arm.com, linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com, linux-acpi@vger.kernel.org, robert.richter@caviumnetworks.com, helgaas@kernel.org, liudongdong3@huawei.com, catalin.marinas@arm.com, Liviu.Dudau@arm.com, jcm@redhat.com, msalter@redhat.com, cov@codeaurora.org, mw@semihalf.com, jchandra@broadcom.com, dhdang@apm.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com, hanjun.guo@linaro.org, Suravee.Suthikulpanit@amd.com
Subject: Re: [RFC PATCH 1/3] pci, acpi: Match PCI config space accessors against platfrom specific ECAM quirks.
Date: Thu, 02 Jun 2016 17:19:13 +0200
Message-ID: <4608372.hbXNF1lbNO@wuerfel>
In-Reply-To: <57503626.9050208@semihalf.com>
References: <1464856864-18049-1-git-send-email-tn@semihalf.com> <9294389.sZPDtyjoUs@wuerfel> <57503626.9050208@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 2, 2016 3:35:34 PM CEST Tomasz Nowicki wrote:
> On 02.06.2016 14:32, Arnd Bergmann wrote:
> > On Thursday, June 2, 2016 2:07:43 PM CEST Tomasz Nowicki wrote:
> >> On 02.06.2016 13:42, Arnd Bergmann wrote:
> >>> On Thursday, June 2, 2016 10:41:01 AM CEST Tomasz Nowicki wrote:
> >>>> +struct pci_ecam_ops *pci_mcfg_get_ops(struct acpi_pci_root *root)
> >>>> +{
> >>>> +       int bus_num = root->secondary.start;
> >>>> +       int domain = root->segment;
> >>>> +       struct pci_cfg_fixup *f;
> >>>> +
> >>>> +       if (!mcfg_table)
> >>>> +               return &pci_generic_ecam_ops;
> >>>> +
> >>>> +       /*
> >>>> +        * Match against platform specific quirks and return corresponding
> >>>> +        * CAM ops.
> >>>> +        *
> >>>> +        * First match against PCI topology <domain:bus> then use OEM ID and
> >>>> +        * OEM revision from MCFG table standard header.
> >>>> +        */
> >>>> +       for (f = __start_acpi_mcfg_fixups; f < __end_acpi_mcfg_fixups; f++) {
> >>>> +               if ((f->domain == domain || f->domain == PCI_MCFG_DOMAIN_ANY) &&
> >>>> +                   (f->bus_num == bus_num || f->bus_num == PCI_MCFG_BUS_ANY) &&
> >>>> +                   (!strncmp(f->oem_id, mcfg_table->header.oem_id,
> >>>> +                             ACPI_OEM_ID_SIZE)) &&
> >>>> +                   (f->oem_revision == mcfg_table->header.oem_revision))
> >>>> +                       return f->ops;
> >>>> +       }
> >>>> +       /* No quirks, use ECAM */
> >>>> +       return &pci_generic_ecam_ops;
> >>>> +}
> >>>> +
> >>>>    int pci_mcfg_lookup(struct acpi_pci_root *root)
> >>>
> >>> Can you explain the use of pci_ecam_ops instead of pci_ops here?
> >>>
> >>
> >> I wanted to get associated bus_shift and use it to setup configuration
> >> region properly before calling pci_ecam_create. Please see next patch.
> >>
> >
> > I see. It feels really odd to do it this way though, since having a
> > nonstandard bus_shift essentially means not using anything resembling
> > ECAM to start with.
> >
> > I realize that a lot of the host bridges are not ECAM, but because
> > of this, it would be more logical to have their own pci_ops instead
> > of pci_ecam_ops.
> 
> Well, we have bus_shift there to express bus shift differentiation. So I 
> would say we should change just structure name to prevent misunderstanding.

I'm not really convinced here. We use the bus_shift for two
completely different things in the end: for sizing the MMIO window
that gets mapped by ACPI and for the pci_ecam_map_bus() function
that isn't actually used for the typical fixups that override the
pci_ops.

I see now that this sneaks in an .init callback for the quirk
through the backdoor, by adding it to the pci_ecam_ops. I think
that is not good: if the idea is to have the config space access
be adapted to various quirks that is one thing, but if we actually
need a function to be called for the quirk we should do just that
and have it be obvious. That function can then override the
pci_ops.

	Arnd
