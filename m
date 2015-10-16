Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:32979 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbbJPIsE (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 16 Oct 2015 04:48:04 -0400
MIME-Version: 1.0
In-Reply-To: <5938877.UG8VySdxoE@wuerfel>
References: <1444790492-4051-1-git-send-email-lftan@altera.com>
	<5210459.PtmhWaT6RM@wuerfel>
	<CAFiDJ59ZZ5TBZJ8wauEzP3Je=DeSaGG-PWvm87dkSLfjmyRwjQ@mail.gmail.com>
	<5938877.UG8VySdxoE@wuerfel>
Date: Fri, 16 Oct 2015 16:48:01 +0800
Message-ID: <CAFiDJ5-4D=OCKuy_=5s0uknzaQu9kUYbqy_nLBL4WOEZs0i3bA@mail.gmail.com>
Subject: Re: [PATCH v9 3/6] pci:host: Add Altera PCIe host controller driver
From: Ley Foon Tan <lftan@altera.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 14, 2015 at 9:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 14 October 2015 18:01:46 Ley Foon Tan wrote:
>> On Wed, Oct 14, 2015 at 5:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 14 October 2015 17:28:45 Ley Foon Tan wrote:
>> >> On Wed, Oct 14, 2015 at 5:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> > Could we perhaps have a helper function that lets us register
>> > fixups dynamically?
>> >
>> >> The linker script keeps all pci fixup callbacks in pci fixup regions
>> >> during kernel compile time. So, it needs to be builtin module. Do you
>> >> know any way we can update those fixup regions?
>> >
>> > The only method I'm aware of at the moment is move the fixups to
>> > drivers/pci/quirks.c and enclose them in an #ifdef if you want them
>> > to not appear in kernels that don't support your SoC.
>> By looking at the drivers/pci/quirks.c, it looks like it is mainly for
>> the pci endpoint devices.
>> Fixups for host controller are in the driver itself.
>>
>
> But if it's for the host itself, there are usually other ways to
> do this without needing a fixup: you already have the device structure
> present in the driver, so you should just be able to modify it there.
Thanks for your suggestion. You are right, I have tested this can work as well.
So, I can remove those 2 PCI_FIXUP* in the driver.
>
>
> I'm looking at the code in your fixups now:
>
> +static void altera_pcie_retrain(struct pci_dev *dev)
> +{
> +       u16 linkcap, linkstat;
> +
> +       /*
> +        * Set the retrain bit if the PCIe rootport support > 2.5GB/s, but
> +        * current speed is 2.5 GB/s.
> +        */
> +       pcie_capability_read_word(dev, PCI_EXP_LNKCAP, &linkcap);
> +
> +       if ((linkcap & PCI_EXP_LNKCAP_SLS) <= PCI_EXP_LNKCAP_SLS_2_5GB)
> +               return;
> +
> +       pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &linkstat);
> +       if ((linkstat & PCI_EXP_LNKSTA_CLS) == PCI_EXP_LNKSTA_CLS_2_5GB)
> +               pcie_capability_set_word(dev, PCI_EXP_LNKCTL,
> +                                        PCI_EXP_LNKCTL_RL);
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_ALTERA, PCI_ANY_ID, altera_pcie_retrain);
>
> This looks related to the code in pci_set_bus_speed(). What is
> missing from that code?
This fixup is different from pci_set_bus_speed(). This fixup is to set
the retrain bit in the LNKCTL register if the host can support higher
speed than current speed, this is required by our hardware. But,
pci_set_bus_speed() is just read the LNKCAP and LNKSTA registers and
store in data structure.

>
> +static void altera_pcie_fixup_res(struct pci_dev *dev)
> +{
> +       /*
> +        * Prevent enumeration of root port.
> +        */
> +       if (!dev->bus->parent && dev->devfn == 0) {
> +               int i;
> +
> +               for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +                       dev->resource[i].start = 0;
> +                       dev->resource[i].end   = 0;
> +                       dev->resource[i].flags   = 0;
> +               }
> +       }
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ALTERA, PCI_ANY_ID,
> +                        altera_pcie_fixup_res);
>
> This seems really odd, too. Why is this needed?
> I think I've seen similar code in other host drivers, so
> it might be time to teach the PCI core about this kind of
> device.
Yes, some host drivers have similar code as well. Some host controller
have the BAR configuration enabled, but it doesn't fit to kernel
resources. Example the BAR is 64-bit, but the processor is 32-bit. It
will fail at the host driver probing stage.

pci 0000:00:00.0: BAR 0: [mem 0x00000000-0xffffffff 64bit pref] has
bogus alignment

Regards
Ley Foon
