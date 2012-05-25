Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50803 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753005Ab2EYBIH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 May 2012 21:08:07 -0400
Received: by pbbrp8 with SMTP id rp8so1032006pbb.19
        for <linux-pci@vger.kernel.org>; Thu, 24 May 2012 18:08:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo7dySdFPdLvVZJN6WwB29xMx7CS0Xxdxs7=0=ME7kqBVA@mail.gmail.com>
References: <CAEH94Ljfjiu3MPLz8_P=1JSJS=hQVY_CJ4kZ=8Oq+0VpweGA4Q@mail.gmail.com>
	<CAJSP0QXgR5w09LgWDbFzg6EajEoMLY0DHmvA8DndmvnCcBRSZg@mail.gmail.com>
	<CAEH94Lh0gmHSR1ugVFg0ZhtFTahb9LQJsxjWZzwqzNLSO0aVug@mail.gmail.com>
	<CAJSP0QXoL3Tr7EAGxX77xZ71bj16oCf0ndL0iMopeYexLPJ93w@mail.gmail.com>
	<CAEH94Lg2qs2_2_zGm9aChqz_6Ues57-KXwGmUquXjKFXo8RbeA@mail.gmail.com>
	<CAErSpo7dySdFPdLvVZJN6WwB29xMx7CS0Xxdxs7=0=ME7kqBVA@mail.gmail.com>
Date: Fri, 25 May 2012 09:08:07 +0800
Message-ID: <CAEH94LgjHNmFOAaDOVHmmKTDvj2krh29K8Q9kJ1bcEcBEcV_sQ@mail.gmail.com>
Subject: Re: PCI: cardbus bridge
From: Zhi Yong Wu <zwu.kernel@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, linux-pci@vger.kernel.org,
	Ram Pai <linuxram@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 25, 2012 at 7:56 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Thu, May 24, 2012 at 3:24 AM, Zhi Yong Wu <zwu.kernel@gmail.com> wrote:
>> On Thu, May 24, 2012 at 5:21 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>> On Thu, May 24, 2012 at 9:56 AM, Zhi Yong Wu <zwu.kernel@gmail.com> wrote:
>>>> On Thu, May 24, 2012 at 4:37 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>>>> On Thu, May 24, 2012 at 9:26 AM, Zhi Yong Wu <zwu.kernel@gmail.com> wrote:
>
>>>>>> By the way, someone usually mentioned pci host bridge, pci root
>>>>>> bridge. What the differences among them are?
>>>>>
>>>>> I'm not sure what the exact difference is.  PCI "root" bridge refers
>>>>> to the hierarchical nature of PCI, while PCI "host" bridge refers to
>>>> You mean that PCI "root" bridge is one alias of another some bridge?
>>>
>>> The root bridge is the root of a tree of PCI busses.  It's the bus
>>> that the host interacts with - there may be PCI bridges that attach
>>> additional busses.
>
> "Root bridge" and "host bridge" mean the same thing in Linux: a bridge
> that connects host CPUs to a PCI fabric.  This bridge is not
> architected.  The upstream interface and the programming interface are
> implementation specific.  The downstream interface is PCI, so that
> part is standard, but since the programming interface is not defined,
> you can't *do* anything useful to it without an
> implementation-specific driver.
>
> On x86 and ia64, that driver is an ACPI driver, and the BIOS supplies
> ACPI methods that hide the implementation details from the OS.
>
> The PCI and ACPI specs use the term "host bridge," so that's what I
> prefer.  The ACPI driver is "pci_root.c" and it calls it "PCI Root
> Bridge."
>
> A PCI bus immediately below a host bridge is commonly called a "root
> bus."  This may be bus 0, but it need not be.  Most modern systems
> have multiple host bridges, each of which has a root bus.
>
> A PCI-to-PCI bridge is different: it has PCI interfaces on both
> upstream ("primary") and downstream ("secondary") sides.  It is
> defined by the spec.
>
>>> BTW I don't know the terminology, maybe it's PCI "domains" not
>>> "busses".  Again, you'd have to look at the PCI specification to get
>>> the exact definition.
>
> Linux uses "domain" to refer to what the PCI and ACPI specs call a
> "segment group."  Here's the definition (from the PCI Firmware Spec):
>
> "A number in the range 0…65535 that uniquely selects a PCI Segment Group.
>
> PCI Segment Group is purely a software concept managed by system
> firmware and used by the operation
> system. It is a logical collection of PCI buses (or bus segments).
> There is no tie to any physical entities. It is a
> way to logically group the PCI bus segments and PCI Express Hierarchies.
>
> PCI Segment Group concept enables support for more than 256 buses in a
> system by allowing the reuse of the PCI bus numbers. Within each PCI
> Segment Group, the bus numbers for the PCI buses must be unique. PCI
> buses in different PCI Segment Group are permitted to have the same
> bus number.
>
> A PCI Segment Group contains one or more PCI host bridges."
Great, very very clear, it is very helpful to me, maybe plus other
guys, thanks a lot.

>
> Bjorn



-- 
Regards,

Zhi Yong Wu
