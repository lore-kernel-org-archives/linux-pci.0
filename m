Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38727 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbaEII4B (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 May 2014 04:56:01 -0400
MIME-Version: 1.0
In-Reply-To: <4975430.zMeeu7d2Xc@wuerfel>
References: <4527717.yJh2gX3xCP@wuerfel>
	<1399624119.4833.3.camel@weser.hi.pengutronix.de>
	<4975430.zMeeu7d2Xc@wuerfel>
Date: Fri, 9 May 2014 10:56:01 +0200
Message-ID: <CAMuHMdU_H3_vzP84UwfSUShJ3_x+t3Q6enn=YNdC2tEDzgOOmg@mail.gmail.com>
Subject: Re: [PATCH] of/irq: provide int of_irq_parse_and_map_pci wrapper
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Magnus Damm <damm@opensource.se>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

On Fri, May 9, 2014 at 10:45 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 09 May 2014 10:28:39 Lucas Stach wrote:
>> Am Freitag, den 09.05.2014, 08:58 +0200 schrieb Arnd Bergmann:
>> > The pci-rcar driver is enabled for compile tests, and this has
>> > now shown that the driver cannot build without CONFIG_OF,
>> > following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
>> > interrupt mapping when possible":
>> >
>> > drivers/built-in.o: In function `rcar_pci_map_irq':
>> > :(.text+0x1cc7c): undefined reference to `of_irq_parse_and_map_pci'
>> >
>> > As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
>> > supposed to build fine, which we can achieve if we make the
>> > declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
>> > and provide an empty inline function otherwise, as we do for
>> > a lot of other of interfaces.
>> >
>> > This lets us build the rcar_pci driver again without CONFIG_OF,
>> > which won't work but give us compile time coverage.
>> >
>> This part of the commit message is confusing. The driver is explicitly
>> written to fall back to a platform irq when OF interrupt mapping doesn't
>> work (return 0 or error), to keep non DT enabled boards working.
>>
>> I hadn't thought of the compile time dependency, so thanks for fixing
>> this up.
>
> I thought it was meant to keep old DTBs working. AFAIK, there is no
> legacy board file support for rcar-gen2, so we don't actually have to
> worry about that.

arch/arm/mach-shmobile/board-lager.c does intantiate platform devices
for it, and I guess they're still to be added to .../board-koelsch.c.

However, all legacy board configs in arch/arm/mach-shmobile/Kconfig
do "select USE_OF", so the file will always be build with OF=y.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
