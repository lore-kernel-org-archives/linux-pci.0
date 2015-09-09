Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f68.google.com ([209.85.215.68]:33967 "EHLO
	mail-la0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbbIIGtJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2015 02:49:09 -0400
MIME-Version: 1.0
In-Reply-To: <20150908091944.GE29293@red-moon>
References: <1441103408-8433-1-git-send-email-lftan@altera.com>
	<1441103408-8433-4-git-send-email-lftan@altera.com>
	<20150901163304.GA9769@red-moon>
	<CAFiDJ58WCjTNkU5PWtbHxj+-0oWNg1T+psfE-OaJD+4k-DBb-A@mail.gmail.com>
	<20150908091944.GE29293@red-moon>
Date: Wed, 9 Sep 2015 14:49:06 +0800
Message-ID: <CAFiDJ58i0enTGbV=xf8q8rKGg6oREXkvwu0cT4Jfz01ozbKQ7g@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] pci:host: Add Altera PCIe host controller driver
From: Ley Foon Tan <lftan@altera.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 8, 2015 at 5:19 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Fri, Sep 04, 2015 at 09:29:14AM +0100, Ley Foon Tan wrote:
>> On Wed, Sep 2, 2015 at 12:33 AM, Lorenzo Pieralisi
>> <lorenzo.pieralisi@arm.com> wrote:
>
> [...]
>
>> > > +static bool altera_pcie_valid_config(struct altera_pcie *pcie,
>> > > +                                    struct pci_bus *bus, int dev)
>> > > +{
>> > > +       /* If there is no link, then there is no device */
>> > > +       if (bus->number != pcie->root_bus_nr) {
>> > > +               if (!altera_pcie_link_is_up(pcie))
>> > > +                       return false;
>> > > +       }
>> >
>> > Can you explain to pls me why you have to check this for every config
>> > transaction ? Isn't it something that can prevent probing the
>> > host controller altogether ?
>> In our PCIe hardware spec, it stated that software should check the
>> link status before issuing a configuration request to downstream
>> ports.
>> BTW, other pci controllers have similar implementation as well, eg: dw
>> pci, mvebu pci.
>
> Understood, thanks.
>
> [...]
>
>> > > +static int tlp_read_packet(struct altera_pcie *pcie, u32 *value)
>> > > +{
>> > > +       u8 loop;
>> > > +       struct tlp_rp_regpair_t tlp_rp_regdata;
>> > > +
>> > > +       for (loop = 0; loop < TLP_LOOP; loop++) {
>> > > +               tlp_read_rx(pcie, &tlp_rp_regdata);
>> > > +               if (tlp_rp_regdata.ctrl & RP_RXCPL_EOP) {
>> > > +                       if (value)
>> > > +                               *value = tlp_rp_regdata.reg0;
>> > > +                       return PCIBIOS_SUCCESSFUL;
>> > > +               }
>> > > +               udelay(5);
>> >
>> > Could you comment please on the chosen udelay/TLP_LOOP values (ie how
>> > did you come up with them) ?
>> For udelay value, we just want to have small delay between each read.
>
> I would explain how you chose the value, in particular if it can
> affect next generation hosts sharing the same driver.
Actually, we don't have any calculation to choose the value. Just want
to give small relaxation between each read.
It is request from Marc in previous review.
>
>> For TLP_LOOP value, minimum 2 loops to read tlp headers and 1 loop to
>> read data payload. So, we choose to poll 10 loops for maximum.
>
> Add it to a comment.
Okay.
>
[...]
>> >
>> > > +
>> > > +       /* clear all interrupts */
>> > > +       cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
>> > > +       /* enable all interrupts */
>> > > +       cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
>> > > +
>> > > +       bus = pci_scan_root_bus(&pdev->dev, pcie->root_bus_nr, &altera_pcie_ops,
>> > > +                               pcie, &pcie->resources);
>> > > +       if (!bus)
>> > > +               return -ENOMEM;
>> > > +
>> > > +       pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>> > > +       pci_assign_unassigned_bus_resources(bus);
>> >
>> > I think you are missing a call to pcie_bus_configure_settings(),
>> > see drivers/pci/host/pci-host-generic.c
>> Other pci controller drivers like xgene and iproc don't call to this
>> function, but it call in
>> arch/arm/kernel/bios32.c:pci_common_init_dev().
>> Do we really need this?
>
> It is there to provide a way to configure the system MPS, through
> command line parameters, it is always a good idea to have it and
> it should be part of your driver so that you can tune it in case
> the MPS is misconfigured or you want to apply a specific configuration
> for a given system.
>
> Have a look at pcie_bus_config and how it is used in
> pcie_bus_configure_settings(), that would clarify further.
Thanks for explanation. I will add it.

Thanks.

Regards
Ley Foon
