Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751421AbdLFLc1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Dec 2017 06:32:27 -0500
Date: Wed, 6 Dec 2017 11:32:17 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kishon@ti.com,
        linux-pci <linux-pci@vger.kernel.org>, adouglas@cadence.com,
        Scott Telford <stelford@cadence.com>, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        sureshp@cadence.com, nsekhar@ti.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe
 controller
Message-ID: <20171206113214.GA27582@red-moon>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171129173426.GB31205@red-moon>
 <f870ad14-0bd5-9d7b-78f2-1e7f663d1127@free-electrons.com>
 <20171204182013.GA7343@red-moon>
 <CAKv+Gu_1XZmsKJ_7ay7D74xSAhDW0y++7-CC3YfG7LOUcNZSqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKv+Gu_1XZmsKJ_7ay7D74xSAhDW0y++7-CC3YfG7LOUcNZSqA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 04, 2017 at 06:49:12PM +0000, Ard Biesheuvel wrote:

[...]

> >> >> +static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
> >> >> +{
> >> >> +     const struct cdns_pcie_rc_data *data = rc->data;
> >> >> +     struct cdns_pcie *pcie = &rc->pcie;
> >> >> +     u8 pbn, sbn, subn;
> >> >> +     u32 value, ctrl;
> >> >> +
> >> >> +     /*
> >> >> +      * Set the root complex BAR configuration register:
> >> >> +      * - disable both BAR0 and BAR1.
> >> >> +      * - enable Prefetchable Memory Base and Limit registers in type 1
> >> >> +      *   config space (64 bits).
> >> >> +      * - enable IO Base and Limit registers in type 1 config
> >> >> +      *   space (32 bits).
> >> >> +      */
> >> >> +     ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
> >> >> +     value = CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
> >> >> +             CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
> >> >> +             CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
> >> >> +             CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
> >> >> +             CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE |
> >> >> +             CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS;
> >> >> +     cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
> >> >> +
> >> >> +     /* Set root port configuration space */
> >> >> +     if (data->vendor_id != 0xffff)
> >> >> +             cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, data->vendor_id);
> >> >> +     if (data->device_id != 0xffff)
> >> >> +             cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, data->device_id);
> >> >> +
> >> >> +     cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
> >> >> +     cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
> >> >> +     cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
> >> >> +
> >> >> +     pbn = rc->bus_range->start;
> >> >> +     sbn = pbn + 1; /* Single root port. */
> >> >> +     subn = rc->bus_range->end;
> >> >> +     cdns_pcie_rp_writeb(pcie, PCI_PRIMARY_BUS, pbn);
> >> >> +     cdns_pcie_rp_writeb(pcie, PCI_SECONDARY_BUS, sbn);
> >> >> +     cdns_pcie_rp_writeb(pcie, PCI_SUBORDINATE_BUS, subn);
> >> >
> >> > Again - I do not have the datasheet for this device therefore I would
> >> > kindly ask you how this works; it seems to me that what you are doing
> >> > here is done through normal configuration cycles in an ECAM compliant
> >> > system to program the RP PRIMARY/SECONDARY/SUBORDINATE bus - I would
> >> > like to understand why this code is needed.
> >> >
> >>
> >> I will test without those lines to test whether I can remove them.
> >>
> >> At first, the PCIe controller was tested by Cadence team: there was code
> >> in their bootloader to initialize the hardware (building the AXI <-> PCIe
> >> mappings, ...): the bootloader used to set the primary, secondary and
> >> subordinate bus numbers in the root port PCI config space.
> >>
> >> Also there was a hardware trick to redirect accesses of the lowest
> >> addresses in the AXI bus to the APB bus so the PCI configuration space of
> >> the root port could have been accessed from the AXI bus too.
> >>
> >> The AXI <-> PCIe mapping being done by the bootloader and the root port
> >> config space being accessible from the AXI bus, it was possible to use
> >> the pci-host-generic driver.
> >
> > That's what I was getting at. Ard (CC'ed) implemented a firmware set-up
> > (even though it was for a different IP but maybe it applies here) that
> > allows the kernel to use the pci-host-generic driver to initialize the
> > PCI controller:
> >
> > https://marc.info/?l=linux-pci&m=150360022626351&w=2
> >
> > I want to understand if there is an IP initialization sequence whereby
> > this IP can be made to work in an ECAM compliant way and therefore
> > reuse (most of) the pci-host-generic driver code.
> >
> 
> I think the Synopsys case is probably very similar. There are some
> registers that look like the config space of a root port, but in
> reality, every memory access that hits a live host bridge window is
> forwarded onto the link, regardless of the values of the bridge BARs.
> That is why in the quoted case, we can get away with ignoring the root
> port altogether, rather than jumping through hoops to make the IP
> block's PCI config space registers appear at B/D/F 0/0/0, while still
> having to filter type 0 config TLPs going onto the link (which is
> arguably the job of the root port to begin with)
> 
> So if this IP does implement a proper root port (i.e., one where the
> bridge BARs are actually taken into account, and where type 0 config
> TLPs are in fact filtered), I strongly recommend mapping its config
> space registers in an ECAM compliant matter, which implies no
> accessors in the OS.
> 
> However, given the observation above, this IP does not appear to
> filter type 0 config TLPs to devfn > 0 downstream of the root port
> either.

Unfortunately that matches my understanding too, let's wait for
Cyrille's reply on my query.

> >> However, the hardware trick won't be included in the final design since
> >> Cadence now wants to perform all PCI configuration space accesses through
> >> a small 4KB window at a fixed address on the AXI bus.
> >
> > I would like to understand what the HW "trick" (if you can disclose it)
> > was, because if there is a chance to reuse the pci-host-generic driver
> > for this IP I want to take it (yes it may entail some firmware set-up in
> > the bootloader) - was it a HW trick or a specific IP SW configuration ?
> >
> >> Also, we now want all initialisations to be done by the linux driver
> >> instead of the bootloader.
> >
> > That's a choice, I do not necessarily agree with it and I think we
> > should aim for more standardization on the PCI host bridge set-up
> > at firmware->kernel handover on DT platforms.
> >
> 
> Well, for one, it means this IP will never be supported by ACPI, which
> seems like a huge downside to me.

Yes it is - that's exactly where my comments were heading.

Thanks,
Lorenzo
