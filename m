Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36345 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbbJBH4S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2015 03:56:18 -0400
MIME-Version: 1.0
In-Reply-To: <1803658.W77SUJGE4K@wuerfel>
References: <1442801587-3812-1-git-send-email-lftan@altera.com>
	<CAFiDJ59PuhRj3F288A_451pLiKnqPUKin9C2t5uuH2iNPnJfAg@mail.gmail.com>
	<CAL_JsqL9eoTRa2-eeNJgVoO=0LyuaaJ87E4_BS0KocRKBXGdGA@mail.gmail.com>
	<1803658.W77SUJGE4K@wuerfel>
Date: Fri, 2 Oct 2015 15:56:16 +0800
Message-ID: <CAFiDJ5-yMBw6Ff1++F5DTg6u_rAgoivGJeNj1tr9fwo-hdKDkg@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] Documentation: dt-bindings: pci: altera pcie
 device tree binding
From: Ley Foon Tan <lftan@altera.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 29, 2015 at 3:38 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 28 September 2015 12:31:36 Rob Herring wrote:
>> >> > +
>> >> > +Required properties:
>> >> > +- compatible :       should contain "altr,pcie-root-port-1.0"
>> >> > +- reg:               a list of physical base address and length for TXS and CRA.
>> >> > +- reg-names: must include the following entries:
>> >> > +             "Txs" or "txs": TX slave port region
>> >> > +             "Cra" or "cra": Control register access region
>> >>
>> >> Why both cases? Can we please just have one (or none is better IMO).
>> > The PCIe IP on different device families use different register names.
>> > And our device tree generator will auto generate the register names
>> > based on the hardware description name. Too bad we can't change the
>> > hardware description names now.
>>
>> Okay, your problem to maintain. Hopefully the driver just goes by index then.
>>
>> Strictly speaking, if you have undocumented bindings downstream that
>> is your problem and we don't have to accept them as-is upstream. I'm
>> not going to worry about that here.
>
> Are they always in the same order? If you don't mandate any names for the
> registers in the binding but just use them by index, we can keep that
> bit of ugliness out of the binding and the driver and still be compatible
> with all the devices.
Too bad the order might change in future devices. We will fix the
tool, so only have one reg-name case.

Regards
Ley Foon
