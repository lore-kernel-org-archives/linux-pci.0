Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35242 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935222AbbI2QsR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Sep 2015 12:48:17 -0400
Received: by ykdz138 with SMTP id z138so12838431ykd.2
        for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2015 09:48:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150928230532.GG21513@n2100.arm.linux.org.uk>
References: <20150928220854.GA16110@localhost> <CAL_JsqL_O2qqESs69spQCPuDfKG5g8_GZkhiYFo-+U8ttxnJng@mail.gmail.com>
 <20150928230532.GG21513@n2100.arm.linux.org.uk>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Sep 2015 11:47:57 -0500
Message-ID: <CAL_JsqLVxtcgcTK55cY32=s24Nuv378X2aKZhYKHFEKO9wh3mw@mail.gmail.com>
Subject: Re: pci_generic_config_write32() access size problem
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Ray Jui <rjui@broadcom.com>, Tanmay Inamdar <tinamdar@apm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+ several affected driver maintainers

On Mon, Sep 28, 2015 at 6:05 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 28, 2015 at 05:42:20PM -0500, Rob Herring wrote:
>> On Mon, Sep 28, 2015 at 5:08 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> > Hi Rob,
>> >
>> > Russell pointed out a problem with 1f94a94f67e1 ("PCI: Add generic config
>> > accessors").  pci_generic_config_write32() does a read/modify/write if the
>> > size is less than 32 bits, so I think we have problem if this is used with
>> > 8- or 16-bit registers that contain RW1C bits.  Any thoughts on how we can
>> > fix this?
>>
>> My series didn't change access sizes unless I made a made a mistake
>> somewhere, so the problem should have existed before.
>>
>> Is it known addresses we need to deal with? We could do special case
>> handling of certain addresses to mask out RW1C bits. This could be in
>> the generic functions or in wrappers around the generic functions.
>> There's already some similar examples of special address handling
>> IIRC.
>
> I think this originally came into being because Intel decided that their
> IOP platforms wouldn't support anything except 32-bit accesses, and
> cargo cult programming took over.  I complained about it on the Intel IOP
> platforms, but obviously if the hardware doesn't support anything else
> then your stuck with it.

What about SA1100 nanoengine?

Others are Tegra, XGene, iproc, and maybe rcar. These are all
relatively active platforms, so hopefully some testing can be done.

Rob

> However, what's utterly wrong is that the generic PCI layer should give
> credence to this crap - it should _not_ provide a generic helper for
> performing only 32-bit accesses which is non-conformant to the PCI specs,
> at least without a big fat warning about it.
>
> The problem is not limited to what the PCI specs say - remember, vendors
> are free to add their own PCI configuration registers: you don't know
> where these registers are in the PCI config address space.  What's even
> worse is that you don't know what use vendors have put the neighbouring
> bytes of PCI config space to in the case of an 8-bit or 16-bit vendor
> register.
>
> For the standard PCI config registers, some addresses are well known.
> For example, the PCI status register is at fixed address 6, sharing the
> PCI command register at address 4.
>
> Others depend on the function, and whether there's capabilities present.
> For example, the PCIe device status register shares the same double-word
> as the PCI device control register, and the status register contains RW1C
> bits.
>
> The same is true for the PCIe AER capability.
>
> --
> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
> according to speedtest.net.
