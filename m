Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35245 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbbJNKBt (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2015 06:01:49 -0400
MIME-Version: 1.0
In-Reply-To: <5210459.PtmhWaT6RM@wuerfel>
References: <1444790492-4051-1-git-send-email-lftan@altera.com>
	<5088538.zEUtS0EC0S@wuerfel>
	<CAFiDJ59AuXmM8vN9=ry8_UvS-paRN54CdCFw6EUMx9RV2TT3bQ@mail.gmail.com>
	<5210459.PtmhWaT6RM@wuerfel>
Date: Wed, 14 Oct 2015 18:01:46 +0800
Message-ID: <CAFiDJ59ZZ5TBZJ8wauEzP3Je=DeSaGG-PWvm87dkSLfjmyRwjQ@mail.gmail.com>
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

On Wed, Oct 14, 2015 at 5:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 14 October 2015 17:28:45 Ley Foon Tan wrote:
>> On Wed, Oct 14, 2015 at 5:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday 14 October 2015 16:32:25 Ley Foon Tan wrote:
>> >> On Wed, Oct 14, 2015 at 4:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >> > On Wednesday 14 October 2015 10:41:29 Ley Foon Tan wrote:
>> >> >> +static int altera_pcie_remove(struct platform_device *pdev)
>> >> >> +{
>> >> >> +     struct altera_pcie *pcie = platform_get_drvdata(pdev);
>> >> >> +
>> >> >> +     altera_pcie_free_irq_domain(pcie);
>> >> >> +     platform_set_drvdata(pdev, NULL);
>> >> >> +     return 0;
>> >> >> +}
>> >> >
>> >> > I just noticed this. Does it actually work to unload the module
>> >> > and tear down all the pci_dev structures in a safe way?
>> >> Good catch. It only can be compiled as builtin-moduley now, so we can
>> >> remove this _remove callback function.
>> >
>> > I think we should change both: make it possible to load the
>> > driver dynamically, and remove the altera_pcie_remove function.
>> This driver depends on the pci fixups to work correctly. But, fixups
>> callback functions in this driver are not being call if the driver is
>> loadable module.
>
> Ah, I see. We should find a better way to deal with this, as we
> are getting an increasing number of host driver specific fixups.
>
> Bjorn, do you have any idea here?
>
> Could we perhaps have a helper function that lets us register
> fixups dynamically?
>
>> The linker script keeps all pci fixup callbacks in pci fixup regions
>> during kernel compile time. So, it needs to be builtin module. Do you
>> know any way we can update those fixup regions?
>
> The only method I'm aware of at the moment is move the fixups to
> drivers/pci/quirks.c and enclose them in an #ifdef if you want them
> to not appear in kernels that don't support your SoC.
By looking at the drivers/pci/quirks.c, it looks like it is mainly for
the pci endpoint devices.
Fixups for host controller are in the driver itself.

>
>> > You can prevent the module from being unloaded if you also remove
>> > the module_platform_driver() directive and add a module_init()
>> > without a matching module_exit().
>> >
>> > Please also add a '.suppress_bind_attrs = true,' flag in the driver
>> > struct to prevent manual unbinding.
>> I think we don't need these if it only can work as builtin module.
>
> No, this is orthogonal, you need it either way, as built-in drivers
> can still be unbound by writing to sysfs. Try writing the device name
> to /sys/bus/platform/drivers/altera-pcie/unbind and watch it blow up ;-)
Oh I see. Will update with your suggestion.

Thanks.

Regards
Ley Foon
