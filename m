Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:51579 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286AbaIKU4j (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Sep 2014 16:56:39 -0400
Received: by mail-qg0-f52.google.com with SMTP id i50so6900039qgf.25
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2014 13:56:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <DUB130-DS11BD5E00A5726DD8D15192DBCC0@phx.gbl>
References: <DUB130-DS10845119A34A53DA8A6430DBC50@phx.gbl> <CAErSpo4GRh2LzeoDu-84h1+YfkYuCz4yLE2xGV8V4GG8ajsrcw@mail.gmail.com>
 <DUB130-DS63ED85165793FD03D1CB1DBC50@phx.gbl> <CAErSpo4_S_9OLrODQO8u0VZU-7sv2XbhcAUd7CxjaV37zcY_Sg@mail.gmail.com>
 <DUB130-DS11BD5E00A5726DD8D15192DBCC0@phx.gbl>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 11 Sep 2014 14:56:18 -0600
Message-ID: <CAErSpo6oma4rJwJbAF55pL6x1Es+eQxgOSpnPPOro+SkMrzufw@mail.gmail.com>
Subject: Re: PCIe root bridge and memory ranges.
To: Robert <RJSmith92@live.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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
> memory controller etc.) Do you know which specific device generates the PCIe
> packet, is it the root bridge?

I'm not a hardware person, and I would only be guessing here.
Obviously packets leave a Root Port, so they have to be created there
or farther inside the Root Complex.  My understanding is that a Root
Port is conceptually part of a Root Complex.

Bjorn
