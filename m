Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35025 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734AbbI3VaZ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2015 17:30:25 -0400
Received: by ykdz138 with SMTP id z138so59306476ykd.2
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2015 14:30:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADaLNDndQ6qZ2yuGuff6=cTm565in5e75AjkcX8MJmH2BCwyEw@mail.gmail.com>
References: <20150928220854.GA16110@localhost> <CAL_JsqL_O2qqESs69spQCPuDfKG5g8_GZkhiYFo-+U8ttxnJng@mail.gmail.com>
 <20150928230532.GG21513@n2100.arm.linux.org.uk> <CAL_JsqLVxtcgcTK55cY32=s24Nuv378X2aKZhYKHFEKO9wh3mw@mail.gmail.com>
 <CADaLNDndQ6qZ2yuGuff6=cTm565in5e75AjkcX8MJmH2BCwyEw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Sep 2015 16:30:05 -0500
Message-ID: <CAL_JsqJni3nB3OTevG8VSZoJ7ndnxSYHV6Yfpn6TwvghCxhHxg@mail.gmail.com>
Subject: Re: pci_generic_config_write32() access size problem
To: Duc Dang <dhdang@apm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Ray Jui <rjui@broadcom.com>, Tanmay Inamdar <tinamdar@apm.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Scott Branden <sbranden@broadcom.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 30, 2015 at 4:17 PM, Duc Dang <dhdang@apm.com> wrote:
> On Tue, Sep 29, 2015 at 9:47 AM, Rob Herring <robh@kernel.org> wrote:
>> + several affected driver maintainers
>>
>> On Mon, Sep 28, 2015 at 6:05 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> On Mon, Sep 28, 2015 at 05:42:20PM -0500, Rob Herring wrote:
>>>> On Mon, Sep 28, 2015 at 5:08 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>>>> > Hi Rob,
>>>> >
>>>> > Russell pointed out a problem with 1f94a94f67e1 ("PCI: Add generic config
>>>> > accessors").  pci_generic_config_write32() does a read/modify/write if the
>>>> > size is less than 32 bits, so I think we have problem if this is used with
>>>> > 8- or 16-bit registers that contain RW1C bits.  Any thoughts on how we can
>>>> > fix this?
>>>>
>>>> My series didn't change access sizes unless I made a made a mistake
>>>> somewhere, so the problem should have existed before.
>>>>
>>>> Is it known addresses we need to deal with? We could do special case
>>>> handling of certain addresses to mask out RW1C bits. This could be in
>>>> the generic functions or in wrappers around the generic functions.
>>>> There's already some similar examples of special address handling
>>>> IIRC.
>>>
>>> I think this originally came into being because Intel decided that their
>>> IOP platforms wouldn't support anything except 32-bit accesses, and
>>> cargo cult programming took over.  I complained about it on the Intel IOP
>>> platforms, but obviously if the hardware doesn't support anything else
>>> then your stuck with it.
>>
>> What about SA1100 nanoengine?
>>
>> Others are Tegra, XGene, iproc, and maybe rcar. These are all
>> relatively active platforms, so hopefully some testing can be done.
>
> On X-Gene, so far I don't see anything strange after switching to use
> pci_generic_config_write32 with all the cards that I can test.

You mean switching to use pci_generic_config_write, right?

>
> But looks like it's still safer to use pci_generic_config_write
> instead as this will make sure no unexpected read-modify-write will
> happen?

Yes. You can also change xgene_pcie_config_read32 to use
pci_generic_config_read instead to simplify the function some.

Rob
