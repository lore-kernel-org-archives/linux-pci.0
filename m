Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:41953 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374Ab3EEHJF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 5 May 2013 03:09:05 -0400
Received: by mail-ob0-f179.google.com with SMTP id xn12so2391695obc.10
        for <linux-pci@vger.kernel.org>; Sun, 05 May 2013 00:09:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1367732090.11982.38.camel@pasglop>
References: <1367712653.11982.19.camel@pasglop>
	<1367712932.11982.20.camel@pasglop>
	<CAE9FiQX=h4H1gcbW=EfQo_ZtAgHGOZ2GxVxLG59C1iMH+qgH2g@mail.gmail.com>
	<1367732090.11982.38.camel@pasglop>
Date: Sun, 5 May 2013 00:09:04 -0700
Message-ID: <CAE9FiQUN3qqVmdw_EdOC-JZGc219M3tu=roOX98xns+77LJhMw@mail.gmail.com>
Subject: Re: Resource assignment oddities
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, May 4, 2013 at 10:34 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sat, 2013-05-04 at 22:18 -0700, Yinghai Lu wrote:
>> we intend to assign unassigned resources in two try,
>> first one will try to allocate must_have and optional ones the same
>> time.
>>
>> if it fails to do that, will only allocate must_have again.
>>
>> now optional one only include SRIOV related.
>
> Hrm... ok. We'll eventually need some kind of hook here for power as
> the way we deal with SR-IOV will have to be somewhat "special", but
> I'll explain that some other time.
>
> Anything shows up from my log about what you think might be the cause
> of those assignment failures ?

Yes, there is something wrong

pci 0001:01:00.0: BAR 8: can't assign mem (size 0x800000)

as bridge only can support 32bit mmio non-pref.

There is one bug for arch other than x86, but it should not be related.

in pci_bus_alloc_resource()

|        /* don't allocate too high if the pref mem doesn't support 64bit*/
|        if (!(res->flags & IORESOURCE_MEM_64))
|                max = PCIBIOS_MAX_MEM_32;

we should call pcibios_resource_to_bus ... to make
sure that actual bus addr is still 32bit

But i'm confused, Did you happen to define your own
    PCIBIOS_MAX_MEM_32 ?
as default one should be -1 other than x86.

Thanks

Yinghai
