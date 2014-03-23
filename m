Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:42232 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbaCWKIk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 23 Mar 2014 06:08:40 -0400
MIME-Version: 1.0
In-Reply-To: <4337701.rbRMDOA6lL@wuerfel>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
	<27671657.LuGQtNBfqX@wuerfel>
	<OF038A7DC3.59E6288A-ON80257CA2.004AF404-80257CA2.004CDD76@eu.necel.com>
	<4337701.rbRMDOA6lL@wuerfel>
Date: Sun, 23 Mar 2014 11:05:20 +0100
Message-ID: <CAMuHMdWWujnkYvMp3f30oBGD6XyDrNj0kNwmjmVr+ko-9ktXuQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] PCI: host: rcar: Add Renesas R-Car PCIe driver
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Phil Edworthy <Phil.Edworthy@renesas.com>,
	Simon Horman <horms@verge.net.au>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 21, 2014 at 4:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 21 March 2014 13:59:35 Phil.Edworthy@renesas.com wrote:
>> > From: Arnd Bergmann <arnd@arndb.de>
>> > static const struct of_device_id rcar_pcie_of_match[] = {
>> >    { .compatible = "renesas,r8a7779-pcie", .data =
>> rcar_pcie_phy_init_rcar_h1},
>> >    { .compatible = "renesas,r8a7790-pcie", .data =  rcar_pcie_hw_init},
>> >    { .compatible = "renesas,r8a7791-pcie", .data =  rcar_pcie_hw_init},
>> >    {},
>> > };
>> >
>> > If you need other differences in the future, you can extend this
>> > to use a pointer to a struct containing the init function pointer.
>>
>> Ok, I understand what you mean, though the rcar_pcie_phy_init_rcar_h1
>> function is an extra call for r8a7779 devices to setup the PHY, not an
>> alternative to rcar_pcie_hw_init.
>
> I assumed that would be trivial to change, by calling rcar_pcie_hw_init
> at the end of rcar_pcie_phy_init_rcar_h1 rather than the other way round.

And this would allow to propagate the error code from
rcar_pcie_phy_init_rcar_h1(), as currently rcar_pcie_hw_init() ignores it,
and returns void.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
