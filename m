Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64630 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbaKDKUJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Nov 2014 05:20:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: PCIe host controller without IO port access.
Date: Tue, 04 Nov 2014 11:19:52 +0100
Message-ID: <11259965.1OyxqdcJ18@wuerfel>
In-Reply-To: <54580B03.1090700@hauke-m.de>
References: <5456C024.4060103@hauke-m.de> <CAL_JsqK0737hND4C0pkNXYwyuecm8K2k=LUMNDZvqdkg=H52NA@mail.gmail.com> <54580B03.1090700@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 04 November 2014 00:08:51 Hauke Mehrtens wrote:
> On 11/03/2014 11:00 PM, Rob Herring wrote:
> > On Mon, Nov 3, 2014 at 11:41 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> >> [+cc Rob (author of 3c5d1699887b), Arnd]
> >>
> >> On Sun, Nov 2, 2014 at 4:37 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> >>> Hi,
> >>>
> >>> I am currently writing a driver for a PCIe host controller which does
> >>> not support IO port access.
> >>>
> >>> My plan was to only provide IORESOURCE_MEM to pci_sys_data->resources,
> >>> but then it allocates some generic IORESOURCE_IO memory in
> >>> arch/arm/kernel/bios32.c:pcibios_init_resources(). This will work for
> >>> the fist PCIe controller, but when the second controller gets registered
> >>> I am getting this: "unable to allocate I/O port region (-16)".
> >>>
> >>> Is there an example for an arm driver for a PCIe controller which does
> >>> not support IO port access?
> >>>
> >>> Should I change arch/arm/kernel/bios32.c in a way so that it would
> >>> ignore the io port mem?
> >>
> >> I think this is a case of "all current platforms support an I/O space,
> >> so we'll set it up in the ARM PCI core."  But I/O space is not (as far
> >> as I know) a required feature of PCI host bridges on ARM, so I suspect
> >> you should change arch/arm/kernel/bios32.c in some way to accomodate
> >> controllers with no I/O port space at all.
> > 
> > I guess we could ignore the error on request_resource or define a way
> > to flag no i/o space. However, any new driver should be using all the
> > new generic infrastructure. I think this code path should not even be
> > called in that case.

For all I can tell this is a bug that was introduced by your 3c5d1699887
("ARM: move PCI i/o resource setup into common code") (yes, I reviewed
and merged it), which will work fine in one any of these cases

- the PCI host driver adds an IORESOURCE_IO entry to its resources for
  each host it registers

- there is only one PCI domain, so "busnr" is a unique value.

> Is there an example on how to use the new generic infrastructure? I used
> drivers/pci/host/pci-host-generic.c as a reference for my driver and
> thought it is using the recent infrastructure.

We're not there yet unfortunately, but it's getting close and with Lorenzo's
latest patches we might be able to do it in 3.19. Using the common code
for this will also make it much easier to have a shared implementation
that works on both arm32 and mips, as well as arm64 if you ever need that.

> I am working on a BCM5310X SoC and it has a PCIe controller without I/O
> port. As far as I know it is only intended to connect some Broadcom Wifi
> cards to the SoC. There are also some MIPS based router SoCs without I/O
> port support from other vendors.

It's definitely supposed to work without I/O space. I think you could
work around this issue if you just add an empty I/O window for the host
in sys->resources. I'm currently unsure what the correct fix would be
for the ARM code, but as it's not currently causing problems for others,
we might just keep it the way it is for now and migrate all controllers
for DT based systems over to the generic implementation first.

	Arnd
