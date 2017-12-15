Return-Path: <SRS0=t6io=DL=gmail.com=jim2101024@kernel.org>
Return-Path: <SRS0=t6io=DL=gmail.com=jim2101024@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171214225133.GM30595@bhelgaas-glaptop.roam.corp.google.com>
References: <1510697532-32828-1-git-send-email-jim2101024@gmail.com>
 <1510697532-32828-4-git-send-email-jim2101024@gmail.com> <20171212221642.GB95453@bhelgaas-glaptop.roam.corp.google.com>
 <CANCKTBvtqNWZYXpLdUnEWwA2=14XhJ6adR5muOAYubY_1SxZWw@mail.gmail.com> <20171214225133.GM30595@bhelgaas-glaptop.roam.corp.google.com>
From: Jim Quinlan <jim2101024@gmail.com>
Date: Fri, 15 Dec 2017 14:53:57 -0500
Message-ID: <CANCKTBvFhHb57JdG01aiSypBAcUeLzY3Dhuh5xP-_F5k_NcAhA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] PCI: brcmstb: Add Broadcom STB PCIe host
 controller driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Rob Herring <robh+dt@kernel.org>, Brian Norris <computersforpeace@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>, Robin Murphy <robin.murphy@arm.com>,
	Christoph Hellwig <hch@lst.de>, Florian Fainelli <f.fainelli@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	Linux-MIPS <linux-mips@linux-mips.org>, linux-pci <linux-pci@vger.kernel.org>,
	Kevin Cernekee <cernekee@gmail.com>, Ralf Baechle <ralf@linux-mips.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	Gregory Fong <gregory.0xf0@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 14, 2017 at 5:51 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Dec 13, 2017 at 06:53:53PM -0500, Jim Quinlan wrote:
>> On Tue, Dec 12, 2017 at 5:16 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > On Tue, Nov 14, 2017 at 05:12:07PM -0500, Jim Quinlan wrote:
>> >> This commit adds the basic Broadcom STB PCIe controller.  Missing is
>> >> the ability to process MSI and also handle dma-ranges for inbound
>> >> memory accesses.  These two functionalities are added in subsequent
>> >> commits.
>> >>
>> >> The PCIe block contains an MDIO interface.  This is a local interface
>> >> only accessible by the PCIe controller.  It cannot be used or shared
>> >> by any other HW.  As such, the small amount of code for this
>> >> controller is included in this driver as there is little upside to put
>> >> it elsewhere.
>> ...
>
>> >> +static bool brcm_pcie_valid_device(struct brcm_pcie *pcie, struct pci_bus *bus,
>> >> +                                int dev)
>> >> +{
>> >> +     if (pci_is_root_bus(bus)) {
>> >> +             if (dev > 0)
>> >> +                     return false;
>> >> +     } else {
>> >> +             /* If there is no link, then there is no device */
>> >> +             if (!brcm_pcie_link_up(pcie))
>> >> +                     return false;
>> >
>> > This is racy, since the link can go down after you check but before
>> > you do the config access.  I assume your hardware can deal with a
>> > config access that targets a link that is down?
>>
>> Yes, that can happen but there is really nothing that can be done if
>> the link goes down in that vulnerability window.  What do you suggest
>> doing?
>
> Most hardware drops writes and returns ~0 on reads if the link is
> down.  I assume your hardware does something similar, and that should
> be enough.  You shouldn't have to check whether the link is up.
Unfortunately our HW is quite unforgiving and effects a synchronous or
asynchronous abort when doing a config access when the link or power
has gone down on the EP.  I will open a discussion with the PCIe HW
folks regarding why our controller does not behave like "most
hardware".  Thanks, Jim
>
> The hardware might report errors, e.g., via AER, if the link is down.
> And we might not not handle those nicely.  If we have issues there, we
> should find out and fix them.
>
> I see that dwc, altera, rockchip, and xilinx all do check for link up
> there, too.  I can't remember if they had a legitimate reason, or if I
> just missed it.
>
>> >> +static void brcm_pcie_remove_controller(struct brcm_pcie *pcie)
>> >> +{
>> >> +     struct list_head *pos, *q;
>> >> +     struct brcm_pcie *tmp;
>> >> +
>> >> +     mutex_lock(&brcm_pcie_lock);
>> >> +     list_for_each_safe(pos, q, &brcm_pcie) {
>> >> +             tmp = list_entry(pos, struct brcm_pcie, list);
>> >> +             if (tmp == pcie) {
>> >> +                     list_del(pos);
>> >> +                     if (list_empty(&brcm_pcie))
>> >> +                             num_memc = 0;
>> >> +                     break;
>> >> +             }
>> >> +     }
>> >> +     mutex_unlock(&brcm_pcie_lock);
>> >
>> > I'm missing something.  I don't see that num_memc is ever set to
>> > anything *other* than zero.
>> The num_memc is set and used in the dma commit.  I will remove its
>> declaration from this commit.
>
> Thanks, that will make the patches much easier to read.
>
>> >> +     pcie->id = of_get_pci_domain_nr(dn);
>> >
>> > Why do you call of_get_pci_domain_nr() directly?  No other driver
>> > does.
>>
>> We use the domain as the controller number (id).  We use the id to
>> identify and fix a HW bug that only affects the 2nd controller; see
>> the clause
>> " } else if (of_machine_is_compatible("brcm,bcm7278a0")) {".
>
> pci_register_host_bridge() already sets bus->domain_nr for every host
> bridge.  That path calls of_get_pci_domain_nr() eventually.   But I
> guess that's too late for your use case, because you have this:
>
>   brcm_pcie_probe
>     brcm_pcie_setup
>       brcm_pcie_bridge_sw_init_set
>         if (of_machine_is_compatible("brcm,bcm7278a0")) {
>           offset = pcie->id ? ...                    <--- use
>     pci_scan_root_bus_bridge
>       pci_register_host_bridge
>         bus->domain_nr = pci_bus_find_domain_nr      <--- available
>
> I guess you haven't added a binding for brcm,bcm7278a0 yet?
>
> I'm not really sure that using the linux,pci-domain DT property is the
> best way to distinguish the two controllers.  Maybe Rob has an
> opinion?
>
>> >> +     if (pcie->id < 0)
>> >> +             return pcie->id;
>
> Bjorn
