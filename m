Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from dub004-omc4s11.hotmail.com ([157.55.2.86]:58143 "EHLO
	DUB004-OMC4S11.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752215AbaINAMn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 13 Sep 2014 20:12:43 -0400
Message-ID: <DUB130-DS112D34DA745F1B5BF78DF6DBCB0@phx.gbl>
From: "Robert" <RJSmith92@live.com>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: <linux-pci@vger.kernel.org>
References: <DUB130-DS10845119A34A53DA8A6430DBC50@phx.gbl> <CAErSpo4GRh2LzeoDu-84h1+YfkYuCz4yLE2xGV8V4GG8ajsrcw@mail.gmail.com> <DUB130-DS63ED85165793FD03D1CB1DBC50@phx.gbl> <CAErSpo4_S_9OLrODQO8u0VZU-7sv2XbhcAUd7CxjaV37zcY_Sg@mail.gmail.com> <DUB130-DS11BD5E00A5726DD8D15192DBCC0@phx.gbl> <CAErSpo6oma4rJwJbAF55pL6x1Es+eQxgOSpnPPOro+SkMrzufw@mail.gmail.com>
In-Reply-To: <CAErSpo6oma4rJwJbAF55pL6x1Es+eQxgOSpnPPOro+SkMrzufw@mail.gmail.com>
Subject: Re: PCIe root bridge and memory ranges.
Date: Sun, 14 Sep 2014 01:12:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thanks for all your help with my questions Bjorn, it really has been 
appreciated :)

Kind Regards,
Robert

-----Original Message----- 
From: Bjorn Helgaas
Sent: Thursday, September 11, 2014 9:56 PM
To: Robert
Cc: linux-pci@vger.kernel.org
Subject: Re: PCIe root bridge and memory ranges.

On Wed, Sep 10, 2014 at 6:18 PM, Robert <RJSmith92@live.com> wrote:

>> We did a lot of work a few years ago to support an arbitrary number of
>> apertures, e.g.,
>>
>> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=2fe2abf896c1
>
> ... but in basic terms, does it allow for a root bridge to
> have 2 or more memory address windows e.g. 0xC0000000 - 0xCFFFFFFF and
> 0xD0000000 - 0xFFFFFFFF?

Yes, that's very common.  For example, my laptop reports these windows:

  pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
  pci_bus 0000:00: root bus resource [io  0x0d00-0xffff]
  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
  pci_bus 0000:00: root bus resource [mem 0xbf200000-0xdfffffff]
  pci_bus 0000:00: root bus resource [mem 0xf0000000-0xfedfffff]
  pci_bus 0000:00: root bus resource [mem 0xfee01000-0xffffffff]

> 1 last question :) Regarding PCIe, I understand that it is a packet based
> protocol but where are the packets created? Online a lot of resources say
> the Root Complex generates a PCIe transaction on behalf of the processor,
> but isn't the Root Complex made up of multiple devices (host bridge/s and
> memory controller etc.) Do you know which specific device generates the 
> PCIe
> packet, is it the root bridge?

I'm not a hardware person, and I would only be guessing here.
Obviously packets leave a Root Port, so they have to be created there
or farther inside the Root Complex.  My understanding is that a Root
Port is conceptually part of a Root Complex.

Bjorn 

