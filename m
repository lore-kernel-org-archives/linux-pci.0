Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:34971 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674AbaAWRcy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2014 12:32:54 -0500
Received: by mail-oa0-f43.google.com with SMTP id h16so2492354oag.16
        for <linux-pci@vger.kernel.org>; Thu, 23 Jan 2014 09:32:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52e1335a.8917980a.31fa.ffffd7a8SMTPIN_ADDED_MISSING@mx.google.com>
References: <25.15.01844.D5C20E25@epmailin6.samsung.com>
	<000201cf17ff$47025bf0$d50713d0$%han@samsung.com>
	<20140123065104.GA26318@pratyush-vbox>
	<52e1335a.8917980a.31fa.ffffd7a8SMTPIN_ADDED_MISSING@mx.google.com>
Date: Thu, 23 Jan 2014 18:32:54 +0100
Message-ID: <CAB5oZtDohVmZjvtfVgVJPhAGbd=qcT=kw21n2ebQhKzhF70QXQ@mail.gmail.com>
Subject: Re: designware/imx6: question regarding MSI
From: Harro Haan <hrhaan@gmail.com>
To: =?UTF-8?Q?Bj=C3=B8rn_Erik_Nilsen?= <ben@datarespons.no>,
	Richard Zhu <richard.zhuhongxing@gmail.com>,
	Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: Pratyush Anand <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 23 January 2014 16:20, Bjørn Erik Nilsen <ben@datarespons.no> wrote:
> Hi Pratyush,
>
> On Thu, 2014-01-23 at 07:51 +0100, Pratyush Anand wrote:
>> On Thu, Jan 23, 2014 at 01:52:19PM +0800, Jingoo Han wrote:
>> > On Thursday, January 23, 2014 5:39 AM, Jingoo Han wrote:
>> > >
>> > > I’m currently playing with MSI support in pci-imx6.c using Harro Haan’s patch [*].

The above patch mentioned will not become part of mainline Linux, but
I expect/hope a reworked version of "[PATCH] pci: imx: enable pcie msi
support" from Richard Zhu will become part of mainline, because this
patch supports MSIX as well. Reference to the patch with review
remarks:
http://www.spinics.net/lists/linux-ide/msg47074.html

@Richard Zhu: Is this a correct assumption?

>> > >
>> > > Are there any technical reasons why dw_pcie_msi_init cannot be called from dw_msi_setup_irq? Or rather,
>> > > why it should not?
>> >
>> > No, there is no special reason.
>> > The patch (call dw_pcie_msi_init from dw_msi_setup_irq) would be
>> > good. Thank you for your effort.
>> >
>> > Mohit, Pratyush,
>> > If you have different opinions, please let us know. :-)
>>
>> dw_msi_setup_irq will be called for each function which needs msi
>> assignment. However, dw_pcie_msi_init should be called only once. So,
>> in my opinion calling dw_pcie_msi_init from dw_msi_setup_irq would not
>> be the best option.
>>
>> @Bjørn, can you help us with tracing calling sequence of
>> dw_pcie_setup & dw_pcie_scan_bus. I think when you do "reset bridge",
>> it will call dw_pcie_setup and when you do "rescan bus", it will call
>> dw_pcie_scan_bus. If yes, then you can move dw_pcie_msi_init to
>> dw_pcie_setup.
>
>
> It looks like dw_pcie_setup and dw_pcie_scan_bus is only called when
> booting. Resetting the bridge or scanning the bus will not trigger any
> of these functions, unfortunately.
>
> I have looked for other hooks too, without luck.

@Bjørn: have you applied the following patch?
"[PATCH] pci: designware: fix missing msi irqs"
Reference to the patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/218629.html

Best regards,

Harro

>
>>
>> Regards
>> Pratyush
>>
>> >
>> > Best regards,
>> > Jingoo Han
>> >
>> > >
>> > > I’m asking because I have a hotplug scenario where this little hack (call dw_pcie_msi_init from
>> > > dw_msi_setup_irq) fixes a problem with MSI. I therefore need to understand whether it is a sensible
>> > > hack or just crap, and more importantly; how it can be fixed properly.
>> > >
>> > > Scenario:
>> > >
>> > > (remove endpoints)
>> > > # echo 1 > /sys/bus/pci/devices/0000:01:00.0/remove
>> > > # echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove
>> > >
>> > > # take fpga in and out of reset (this will mess up the configuration space of the bridge)
>> > >
>> > > (reset bridge)
>> > > # echo 1 > /sys/bus/pci/devices/0000:00:00.0/reset
>> > >
>> > > (rescan bus)
>> > > # echo 1 > /sys/bus/pci/rescan
>> > >
>> > > At this point everything works fine except MSI. With above mention hack it works like a charm.
>> > >
>> > > I would be grateful if someone could shed light on this. I might have missed some important details.
>> > >
>> > >
>> > > Best regards,
>> > > Bjørn Erik Nilsen
>> > >
>> > > [*]
>> > >
>> > > From: Harro Haan <hrhaan@gmail.com>
>> > > Date: Thu, 5 Dec 2013 14:06:37 +0100
>> > > Subject: [PATCH 2/2] PCI: imx6: add support for MSI
>
