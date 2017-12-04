Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171204182013.GA7343@red-moon>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <2670f7ddf59e708beb9d32bef1353e15bd4e1ecf.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171129173426.GB31205@red-moon> <f870ad14-0bd5-9d7b-78f2-1e7f663d1127@free-electrons.com>
 <20171204182013.GA7343@red-moon>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 4 Dec 2017 18:49:12 +0000
Message-ID: <CAKv+Gu_1XZmsKJ_7ay7D74xSAhDW0y++7-CC3YfG7LOUcNZSqA@mail.gmail.com>
Subject: Re: [PATCH 3/5] PCI: cadence: Add host driver for Cadence PCIe controller
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 4 December 2017 at 18:20, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> [+Ard]
>
> Hi Cyrille,
>
> On Sun, Dec 03, 2017 at 09:44:46PM +0100, Cyrille Pitchen wrote:
>
> [...]
>
>> >> +cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn, int where)
>> >> +{
>> >> +     struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>> >> +     struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
>> >> +     struct cdns_pcie *pcie = &rc->pcie;
>> >> +     unsigned int busn = bus->number;
>> >> +     u32 addr0, desc0;
>> >> +
>> >> +     if (busn < rc->bus_range->start || busn > rc->bus_range->end)
>> >> +             return NULL;
>> >
>> > It does not hurt but I wonder whether you really need this check.
>> >
>>
>> I can remove it.
>>
>> >> +     if (busn == rc->bus_range->start) {
>> >> +             if (devfn)
>> >
>> > I suspect I know why you need this check but I ask you to explain it
>> > anyway if you do not mind please.
>> >
>>
>> If I have understood correctly, Cadence team told me that only the root
>> port is available on the first bus through device 0, function 0.
>> No other device/function should connected on this bus, all other devices
>> are behind at least one PCI bridge.
>>
>> I can add a comment here to explain that.
>
> That's understood, the question is what happens if you do scan devfn != 0.
>

OK, this is similar to the Synopsys IP. Type 0 config TLPs are not
filtered by the hardware, and so if you don't filter them in software,
the device downstream of the rootport will appear 32 times.

>> >> +                     return NULL;
>> >> +
>> >> +             return pcie->reg_base + (where & 0xfff);
>> >> +     }
>> >> +
>> >> +     /* Update Output registers for AXI region 0. */
>> >> +     addr0 = CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_NBITS(12) |
>> >
>> > Ok, so for every config access you reprogram addr0 to reflect the
>> > correct bus|devfn ID in the PCI bus TLP corresponding to an ECAM address
>> > in CPU physical address space, is my understanding correct ?
>> >
>>
>> The idea is to able to use only a 4KB memory area at a fixed address in the
>> space allocated for the PCIe controller in the AXI bus. I guess the plan is
>> to leave more space on the AXI bus to map all other PCIe devices.
>>
>> This is just my guess. Anyway one purpose of this driver was actually to
>> perform all PCI configuration space accesses through this single 4KB memory
>> area in the AXI bus, changing the mapping dynamically to reach the relevant
>> PCI device.
>
> Thank you for explaining - that matches my understanding.
>
>> >> +             CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_DEVFN(devfn) |
>> >> +             CDNS_PCIE_AT_OB_REGION_PCI_ADDR0_BUS(busn);
>> >> +     cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR0(0), addr0);
>> >> +
>> >> +     /* Configuration Type 0 or Type 1 access. */
>> >> +     desc0 = CDNS_PCIE_AT_OB_REGION_DESC0_HARDCODED_RID |
>> >> +             CDNS_PCIE_AT_OB_REGION_DESC0_DEVFN(0);
>> >> +     /*
>> >> +      * The bus number was already set once for all in desc1 by
>> >> +      * cdns_pcie_host_init_address_translation().
>> >> +      */
>> >> +     if (busn == rc->bus_range->start + 1)
>> >> +             desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE0;
>> >> +     else
>> >> +             desc0 |= CDNS_PCIE_AT_OB_REGION_DESC0_TYPE_CONF_TYPE1;
>> >
>> > I would like to ask you why you have to do it here and the root port
>> > does not figure it out by itself, I do not have the datasheet so I am
>> > just asking for my own information.
>>
>> PCI configuration space registers of the root port can only be read through
>> the APB bus at offset 0:
>> ->reg_base + (where & 0xfff)
>>
>> They are internal registers of the PCIe controller so no TLP on the PCIe bus.
>>
>> However to access the PCI configuration space registers of any other device,
>> the PCIe controller builds then sends a TLP on the PCIe bus using the offset
>> in the 4KB AXI area as the offset of the register in the PCI configuration
>> space:
>> ->cfg_base + (where & 0xfff)
>>
>> >
>> >> +     cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC0(0), desc0);
>> >> +
>> >> +     return rc->cfg_base + (where & 0xfff);
>> >> +}
>> >> +
>> >> +static struct pci_ops cdns_pcie_host_ops = {
>> >> +     .map_bus        = cdns_pci_map_bus,
>> >> +     .read           = pci_generic_config_read,
>> >> +     .write          = pci_generic_config_write,
>> >> +};
>> >> +
>> >> +static const struct cdns_pcie_rc_data cdns_pcie_rc_data = {
>> >> +     .max_regions    = 32,
>> >> +     .vendor_id      = PCI_VENDOR_ID_CDNS,
>> >> +     .device_id      = 0x0200,
>> >> +     .no_bar_nbits   = 32,
>> >> +};
>> >
>> > Should (some of) these parameters be retrieved through a DT binding ?
>> >
>>
>> Indeed, maybe we get max_regions and no_bar_nbits from the DT.
>>
>> About the vendor and device IDs, I don't know which would be the best
>> choice between some dedicated DT properties or associating a custom
>> structure as above to the 'compatible' string.
>>
>> Honestly, I don't have any strong preference, please just tell me what
>> you would prefer :)
>
> I think it is best to ask DT maintainers (in CC) POV on this, they
> certainly have a more comprehensive view than mine on the subject - I
> have just noticed that _some_ data can be retrieved through DT therefore
> I raised the point - either through different compatible strings or
> some IP specific properties.
>
>> >> +static const struct of_device_id cdns_pcie_host_of_match[] = {
>> >> +     { .compatible = "cdns,cdns-pcie-host",
>> >> +       .data = &cdns_pcie_rc_data },
>> >> +
>> >> +     { },
>> >> +};
>> >> +
>> >> +static int cdns_pcie_parse_request_of_pci_ranges(struct device *dev,
>> >> +                                              struct list_head *resources,
>> >> +                                              struct resource **bus_range)
>> >> +{
>> >> +     int err, res_valid = 0;
>> >> +     struct device_node *np = dev->of_node;
>> >> +     resource_size_t iobase;
>> >> +     struct resource_entry *win, *tmp;
>> >> +
>> >> +     err = of_pci_get_host_bridge_resources(np, 0, 0xff, resources, &iobase);
>> >> +     if (err)
>> >> +             return err;
>> >> +
>> >> +     err = devm_request_pci_bus_resources(dev, resources);
>> >> +     if (err)
>> >> +             return err;
>> >> +
>> >> +     resource_list_for_each_entry_safe(win, tmp, resources) {
>> >> +             struct resource *res = win->res;
>> >> +
>> >> +             switch (resource_type(res)) {
>> >> +             case IORESOURCE_IO:
>> >> +                     err = pci_remap_iospace(res, iobase);
>> >> +                     if (err) {
>> >> +                             dev_warn(dev, "error %d: failed to map resource %pR\n",
>> >> +                                      err, res);
>> >> +                             resource_list_destroy_entry(win);
>> >> +                     }
>> >> +                     break;
>> >> +             case IORESOURCE_MEM:
>> >> +                     res_valid |= !(res->flags & IORESOURCE_PREFETCH);
>> >> +                     break;
>> >> +             case IORESOURCE_BUS:
>> >> +                     *bus_range = res;
>> >> +                     break;
>> >> +             }
>> >> +     }
>> >> +
>> >> +     if (res_valid)
>> >> +             return 0;
>> >> +
>> >> +     dev_err(dev, "non-prefetchable memory resource required\n");
>> >> +     return -EINVAL;
>> >
>> > Nit, I prefer you swap these two as it is done in pci-aardvark.c:
>> >
>> >         if (!res_valid) {
>> >                 dev_err(dev, "non-prefetchable memory resource required\n");
>> >                 return -EINVAL;
>> >         }
>> >
>> >         return 0;
>> >
>> > but as per previous replies this function can be factorized in
>> > core PCI code - I would not bother unless you are willing to write
>> > the patch series that does the refactoring yourself :)
>> >
>> >> +}
>> >> +
>> >> +static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>> >> +{
>> >> +     const struct cdns_pcie_rc_data *data = rc->data;
>> >> +     struct cdns_pcie *pcie = &rc->pcie;
>> >> +     u8 pbn, sbn, subn;
>> >> +     u32 value, ctrl;
>> >> +
>> >> +     /*
>> >> +      * Set the root complex BAR configuration register:
>> >> +      * - disable both BAR0 and BAR1.
>> >> +      * - enable Prefetchable Memory Base and Limit registers in type 1
>> >> +      *   config space (64 bits).
>> >> +      * - enable IO Base and Limit registers in type 1 config
>> >> +      *   space (32 bits).
>> >> +      */
>> >> +     ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_DISABLED;
>> >> +     value = CDNS_PCIE_LM_RC_BAR_CFG_BAR0_CTRL(ctrl) |
>> >> +             CDNS_PCIE_LM_RC_BAR_CFG_BAR1_CTRL(ctrl) |
>> >> +             CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_ENABLE |
>> >> +             CDNS_PCIE_LM_RC_BAR_CFG_PREFETCH_MEM_64BITS |
>> >> +             CDNS_PCIE_LM_RC_BAR_CFG_IO_ENABLE |
>> >> +             CDNS_PCIE_LM_RC_BAR_CFG_IO_32BITS;
>> >> +     cdns_pcie_writel(pcie, CDNS_PCIE_LM_RC_BAR_CFG, value);
>> >> +
>> >> +     /* Set root port configuration space */
>> >> +     if (data->vendor_id != 0xffff)
>> >> +             cdns_pcie_rp_writew(pcie, PCI_VENDOR_ID, data->vendor_id);
>> >> +     if (data->device_id != 0xffff)
>> >> +             cdns_pcie_rp_writew(pcie, PCI_DEVICE_ID, data->device_id);
>> >> +
>> >> +     cdns_pcie_rp_writeb(pcie, PCI_CLASS_REVISION, 0);
>> >> +     cdns_pcie_rp_writeb(pcie, PCI_CLASS_PROG, 0);
>> >> +     cdns_pcie_rp_writew(pcie, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
>> >> +
>> >> +     pbn = rc->bus_range->start;
>> >> +     sbn = pbn + 1; /* Single root port. */
>> >> +     subn = rc->bus_range->end;
>> >> +     cdns_pcie_rp_writeb(pcie, PCI_PRIMARY_BUS, pbn);
>> >> +     cdns_pcie_rp_writeb(pcie, PCI_SECONDARY_BUS, sbn);
>> >> +     cdns_pcie_rp_writeb(pcie, PCI_SUBORDINATE_BUS, subn);
>> >
>> > Again - I do not have the datasheet for this device therefore I would
>> > kindly ask you how this works; it seems to me that what you are doing
>> > here is done through normal configuration cycles in an ECAM compliant
>> > system to program the RP PRIMARY/SECONDARY/SUBORDINATE bus - I would
>> > like to understand why this code is needed.
>> >
>>
>> I will test without those lines to test whether I can remove them.
>>
>> At first, the PCIe controller was tested by Cadence team: there was code
>> in their bootloader to initialize the hardware (building the AXI <-> PCIe
>> mappings, ...): the bootloader used to set the primary, secondary and
>> subordinate bus numbers in the root port PCI config space.
>>
>> Also there was a hardware trick to redirect accesses of the lowest
>> addresses in the AXI bus to the APB bus so the PCI configuration space of
>> the root port could have been accessed from the AXI bus too.
>>
>> The AXI <-> PCIe mapping being done by the bootloader and the root port
>> config space being accessible from the AXI bus, it was possible to use
>> the pci-host-generic driver.
>
> That's what I was getting at. Ard (CC'ed) implemented a firmware set-up
> (even though it was for a different IP but maybe it applies here) that
> allows the kernel to use the pci-host-generic driver to initialize the
> PCI controller:
>
> https://marc.info/?l=linux-pci&m=150360022626351&w=2
>
> I want to understand if there is an IP initialization sequence whereby
> this IP can be made to work in an ECAM compliant way and therefore
> reuse (most of) the pci-host-generic driver code.
>

I think the Synopsys case is probably very similar. There are some
registers that look like the config space of a root port, but in
reality, every memory access that hits a live host bridge window is
forwarded onto the link, regardless of the values of the bridge BARs.
That is why in the quoted case, we can get away with ignoring the root
port altogether, rather than jumping through hoops to make the IP
block's PCI config space registers appear at B/D/F 0/0/0, while still
having to filter type 0 config TLPs going onto the link (which is
arguably the job of the root port to begin with)

So if this IP does implement a proper root port (i.e., one where the
bridge BARs are actually taken into account, and where type 0 config
TLPs are in fact filtered), I strongly recommend mapping its config
space registers in an ECAM compliant matter, which implies no
accessors in the OS.

However, given the observation above, this IP does not appear to
filter type 0 config TLPs to devfn > 0 downstream of the root port
either.

>> However, the hardware trick won't be included in the final design since
>> Cadence now wants to perform all PCI configuration space accesses through
>> a small 4KB window at a fixed address on the AXI bus.
>
> I would like to understand what the HW "trick" (if you can disclose it)
> was, because if there is a chance to reuse the pci-host-generic driver
> for this IP I want to take it (yes it may entail some firmware set-up in
> the bootloader) - was it a HW trick or a specific IP SW configuration ?
>
>> Also, we now want all initialisations to be done by the linux driver
>> instead of the bootloader.
>
> That's a choice, I do not necessarily agree with it and I think we
> should aim for more standardization on the PCI host bridge set-up
> at firmware->kernel handover on DT platforms.
>

Well, for one, it means this IP will never be supported by ACPI, which
seems like a huge downside to me.

>> I simply moved all those initialisations from the bootloader to the linux
>> driver but actually there is a chance that I can remove the 3 writes to
>> the PCI_*_BUS registers.
>
> I asked because I do not have this IP documentation so I rely on you to
> provide the correct initialization sequence and an explanation for it,
> I think I understand now the initialization sequence a bit more but it
> would be good to get to the bottom of it.
>
