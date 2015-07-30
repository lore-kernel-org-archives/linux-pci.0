Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33040 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950AbbG3UmK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 16:42:10 -0400
MIME-Version: 1.0
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E01D6FC15@lhreml503-mbs>
References: <1438010223-124422-1-git-send-email-gabriele.paoloni@huawei.com>
 <20150729172053.GE31170@google.com> <EE11001F9E5DDD47B7634E2F8A612F2E01D6F350@lhreml503-mbs>
 <CAL_JsqKs11-sXQTdBD+ZjbVYFWUHBARTW9q5MF1hCXUhZ+nWLQ@mail.gmail.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D6F94A@lhreml503-mbs> <20150730161447.GG9640@google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D6FB3B@lhreml503-mbs> <20150730171445.GI9640@google.com>
 <EE11001F9E5DDD47B7634E2F8A612F2E01D6FC15@lhreml503-mbs>
From: Rob Herring <robherring2@gmail.com>
Date: Thu, 30 Jul 2015 15:41:50 -0500
Message-ID: <CAL_Jsq+aQVakaZf4xo7sxnVyTmPR+HJ-9ByyS6OYJ0PHDYOwmg@mail.gmail.com>
Subject: Re: [PATCH v6] PCI: Store PCIe bus address in struct of_pci_range
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
	"Wangzhou (B)" <wangzhou1@hisilicon.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"Liviu.Dudau@arm.com" <Liviu.Dudau@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Yuanzhichang <yuanzhichang@hisilicon.com>,
	Zhudacai <zhudacai@hisilicon.com>,
	zhangjukuo <zhangjukuo@huawei.com>,
	qiuzhenfa <qiuzhenfa@hisilicon.com>,
	"Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 30, 2015 at 12:34 PM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
>> -----Original Message-----
>> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> Sent: 30 July 2015 18:15
>> On Thu, Jul 30, 2015 at 04:50:55PM +0000, Gabriele Paoloni wrote:
>> > > -----Original Message-----
>> > > From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>> > > owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
>> > > Sent: Thursday, July 30, 2015 5:15 PM
>> > > On Thu, Jul 30, 2015 at 01:52:13PM +0000, Gabriele Paoloni wrote:

[...]

>> > > > I don’t think we should rely on [CPU] addresses...what if the
>> > > intermediate
>> > > > translation layer changes the lower significant bits of the "bus
>> > > address"
>> > > > to translate into a cpu address?
>> > >
>> > > Is it really a possiblity that the lower bits could be changed?
>> >
>> > I've checked all the current deignware users DTs except "pci-
>> layerscape"
>> > that I could not find:
>> > spear1310.dtsi
>> > spear1340.dtsi
>> > dra7.dtsi
>> > imx6qdl.dtsi
>> > imx6sx.dtsi
>> > keystone.dtsi
>> > exynos5440.dtsi
>> >
>> > None of them modifies the lower bits. To be more precise the only guy
>> > that provides another translation layer is "dra7.dtsi":
>> > axi0
>> > http://lxr.free-electrons.com/source/arch/arm/boot/dts/dra7.dtsi#L207
>> >
>> > axi1
>> > http://lxr.free-electrons.com/source/arch/arm/boot/dts/dra7.dtsi#L241
>> >
>> > For this case masking the top 4bits (bits28 to 31) should make the job.

IMO, we should just fix this case. After further study, I don't think
this is a DW issue, but rather an SOC integration issue.

I believe you can just fixup the address in the pp->ops->host_init hook.

In looking at this, I'm curious why only 2 ATU viewports are used by
default as this causes switching on config accesses. Probably some
configuration only has 2 viewports. This would not even work on SMP
systems! Memory and i/o accesses do not have any lock. A config access
on one core will temporarily disable the i/o or memory viewport which
will cause an abort, dropped, or garbage data on an i/o or memory
access from another core. You would have to be accessing cfg space on
a bus other than the root bus, so maybe no one is doing that.

>> >
>> > Speaking in general terms so far I've always seen linear mappings
>> > that differ by bitmask offset, however linear does not mean that you
>> > cannot affect the lower bits: e.g. <0x0> to <0x0 + size> can map to
>> > <0x0000cafe to 0x0000cafe + size>, but I guess that for HW design
>> reasons
>> > it is much easier to remap directly using a bitmask...but I was not
>> sure
>> > and I didn't think about the problems that can arise with ACPI.

For higher speed buses, the h/w designs are not going to be doing
complicated translations in order to meet timing requirements. At the
top level only the highest order bits are going to be looked at. For
downstream segments, the high order bits may get dropped to simplify
routing. If an IP block has full address bits in this case, they could
either be tied to 0 or tied off to the correct address. Either is
reasonable, so I'm sure there is h/w doing both. That doesn't mean h/w
designers haven't done something crazy, too.

>> As I said, it wouldn't make sense for the bits that comprise the
>> offset into the window to change, so the mapping only has to be linear
>> inside the window.
>>
>> For the bits outside the window offset, I don't know enough to say
>> whether masking is sufficient or safe.
>>
>> > If you think the bitmask is Ok then I can directly define it in
>> > designware and we can drop this patch.
>>
>> It's OK by me, but I know nothing about the actual hardware involved.
>> For the DesignWare question, I think you would just have to convince
>> Jingoo and Pratyush (cc'd).
>
> Yes actually looking at
> http://lxr.free-electrons.com/source/arch/arm/boot/dts/spear1310.dtsi#L99
> I can see that pci_addr=0 is mapped to bus_addr 0x80020000, so clearing
> the top 4 bits would alter the behaviour of the current designware
> SW framework...now I don't know if DW needs only the low 28b of that
> value or not....

Given that most cases have same cpu and bus address, masking is not
the right solution in general.

There is also a bug here BTW. pcie0 and pcie2 have the same CPU
address for the memory range.

Rob
