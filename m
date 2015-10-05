Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:36220 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbbJEDOI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 4 Oct 2015 23:14:08 -0400
MIME-Version: 1.0
In-Reply-To: <6497772.rqSurELzER@wuerfel>
References: <1442801587-3812-1-git-send-email-lftan@altera.com>
	<CAL_JsqL9eoTRa2-eeNJgVoO=0LyuaaJ87E4_BS0KocRKBXGdGA@mail.gmail.com>
	<CAFiDJ5_MYC=V_L1LyRNq00z=DerzKAF=RF5av9vHnUPP+9a1nw@mail.gmail.com>
	<6497772.rqSurELzER@wuerfel>
Date: Mon, 5 Oct 2015 11:14:05 +0800
Message-ID: <CAFiDJ590c0zG=bBBdERz9sh0Yvrrrv306Pd0simDmMWKw81z9w@mail.gmail.com>
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

On Sat, Oct 3, 2015 at 5:56 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 02 October 2015 15:53:44 Ley Foon Tan wrote:
>> > Strictly speaking, if you have undocumented bindings downstream that
>> > is your problem and we don't have to accept them as-is upstream. I'm
>> > not going to worry about that here.
>> >
>> >>> txs contains the config space?
>> >> It is not the config space, but a memory slave port.
>> >
>> > Then where is the config space? It should not be part of "ranges" is
>> > all I care about.
>> The config space is not part of "ranges". Our IP uses TLP packet to
>> access config space.
>>
>
> It took me a bit to figure out what you mean here. To save others
> from reading the source, here is what I found:
>
> * The config space is accessed indirectly through registers from the
>   "cra" register range, which is the right approach according to the
>   point that Rob made.
You are right.

> * hardware-wise this basically looks like bit-banged PCIe, which is
>   both awesome and scary ;-)
