Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:45575 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753495Ab3E1TGo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 May 2013 15:06:44 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so2075836obq.7
        for <linux-pci@vger.kernel.org>; Tue, 28 May 2013 12:06:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQV_A4HoecfffV9Dur4g_3HNMUcgmOpLs-oy8dhz4TjKxw@mail.gmail.com>
References: <CAH9N0t_dNJ+u+9BLFTsqRNnbRO4xMaGYqE6_du_u+joZfzBYyA@mail.gmail.com>
 <CAErSpo7TXMOake9=oXwa-JA9qd9FmwNtHqM6RSt12QO=WORshA@mail.gmail.com>
 <CAH9N0t8-6CgmhQhiu7zy1r4UnYyjJqkmAnrDRhjt3t71F7SxNA@mail.gmail.com>
 <CAE9FiQV4Okzz2jomvwzg7_jS5sKS9Br7LtjbMDy5=BHebTvyDA@mail.gmail.com>
 <CAH9N0t-cMzioGkLBLXSzcGzZwC0cMm-486_h52PFx286p9sWGg@mail.gmail.com>
 <CAErSpo7zKC4eSBDnefraov8Aj211k8uEqcgQVLG8tgYeCdocww@mail.gmail.com> <CAE9FiQV_A4HoecfffV9Dur4g_3HNMUcgmOpLs-oy8dhz4TjKxw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 28 May 2013 13:06:23 -0600
Message-ID: <CAErSpo5xXzE5rY64y30uHLgG_yp1A+rQ1pW3Hkfgaf0LWpi3oQ@mail.gmail.com>
Subject: Re: Pcie Linux HotPlug Driver
To: Yinghai Lu <yinghai@kernel.org>
Cc: Paulo Ricardo Carvalho <pricardofc@ipfn.ist.utl.pt>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 28, 2013 at 12:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Tue, May 28, 2013 at 10:01 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Tue, May 28, 2013 at 6:05 AM, Paulo Fortuna Carvalho
>> <pricardofc@ipfn.ist.utl.pt> wrote:
>>> Hello Yinghai,
>>> Here goes, in attached .zip file the commands output that you suggested.
>>
>> It looks like the part you're interested in is this:
>>
>>     00:03.0 bridge to [bus 03-1a] (Intel root port)
>>     03:00.0 bridge to [bus 04-1a] (PLX 8733 upstream port)
>>     04:08.0 bridge to [bus 05-1a] (PLX 8733 downstream port)
>>     05:00.0 bridge to [bus 06-1a] (PLX 8696 upstream port)
>>     06:07.0 bridge to [bus 0a] (PLX 8696 downstream port)
>>     0a:00.0 endpoint (PLD Applications 6114)
>>     06:0e.0 bridge to [bus 11] (PLX 8696 downstream port)
>>     11:00.0 endpoint (PLD Applications 6014)
>>
>> I assume everything except the root port is on your ATCA card, and you
>> want to hotplug the card as a whole.
>>
>> This would be handled by the hotplug controller in the 00:03.0 root
>> port, using pciehp.
>
> that should not work. as pciehp will not be loaded for 00:03.0 with
> following slot cap
>         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surpise-
>             Slot #  2, PowerLimit 25.000000; Interlock- NoCompl-

Yep, true.

> but 04:08.0, 06:04.0, 06:0c.0, 06:08.0 and 06:10.0 do have
>         SltCap:    AttnBtn+ PwrCtrl+ MRL+ AttnInd+ PwrInd+ HotPlug+ Surpise-
>             Slot #  4, PowerLimit 25.000000; Interlock- NoCompl-
>
> problem is
> 1. pciehp is not loaded for them.
> 2. fpga are on 06:07.0 and 06:0e.0.
>
> If 04:08.0 pciehp could be loaded, the could use that hotplug to make
> fpga working

Oh, maybe the devices on the ATCA card start at 05:00.0, not at
03:00.0?  If that's the case, then yes, getting pciehp to claim the
hotplug service on 04:08.0 would be the right thing.  Maybe you just
don't have pciehp enabled, Paulo?
