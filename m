Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:44161 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344AbaBYV2T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2014 16:28:19 -0500
Received: by mail-oa0-f41.google.com with SMTP id o6so1142218oag.28
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2014 13:28:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAA93t1osfYie-CWSTsqdeyzFOwCfsBPaGJ2rtyEkiY0e4kHUMw@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
	<CAA93t1osfYie-CWSTsqdeyzFOwCfsBPaGJ2rtyEkiY0e4kHUMw@mail.gmail.com>
Date: Tue, 25 Feb 2014 13:28:18 -0800
Message-ID: <CAE9FiQX9-eSe06STMjhFhwk6RoupOd5v6Jsi3yBwJsCna1uk=A@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Rajat Jain <rajatxjain@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 25, 2014 at 11:27 AM, Rajat Jain <rajatxjain@gmail.com> wrote:
> On Mon, Feb 24, 2014 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> [+cc Rajat]
>>
>> On Mon, Feb 24, 2014 at 4:59 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>> On system with 16 PCI express hotplug slots, customer complain every slot
>>> will report "Command not completed in 1000 msec" during initialization.
>>>
>>> Intel says that we should only wait command complete only for
>>>            Electromechanical Interlock Control
>>>            Power Controller Control
>>>            Power Indicator Control
>>>            Attention Indicator Control
>
>
> Hello,
>
> I have a HW that generates Command Completion notifications, even
> though it does not implement any of the EMI, Power Controller, Power
> Indicator, Attention indicator. Although I'm not sure whether or not
> this behavior is compliant to PCIe spec, just wanted to pitch in to
> convey that there are HW which have this behavior:
>
> PCI bridge: Integrated Device Technology, Inc. Device 807a (rev 02)
> (prog-if 00 [Normal decode])
>         SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise-
>                 Slot #13, PowerLimit 0.000W; Interlock- NoCompl-
>         SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
>                 Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>         SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
>                 Changed: MRL- PresDet- LinkState-

Looks like different vendors have different understanding of that part.

so may need to add vendor quirk checking for waiting..., aka only wait for IDT
for all bits, and other vendor will only wait for 4 bits.

Thanks

Yinghai
