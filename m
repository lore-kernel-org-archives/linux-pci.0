Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34496 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751046AbbC0VBz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2015 17:01:55 -0400
MIME-Version: 1.0
In-Reply-To: <551495EE.20201@oracle.com>
References: <5514391F.2030300@oracle.com>
	<CAE9FiQXw3QUCNNZj2SVhn-AYWWnggT=7JXPkGNpYFzq-qAB1aQ@mail.gmail.com>
	<551495EE.20201@oracle.com>
Date: Fri, 27 Mar 2015 14:01:54 -0700
Message-ID: <CAE9FiQXAD1ncuJ=ZiOSR4xCKbamPJ-5JSqEx1Veiai5bZKBcGA@mail.gmail.com>
Subject: Re: d63e2e1f3df breaks sparc/T5-8
From: Yinghai Lu <yinghai@kernel.org>
To: David Ahern <david.ahern@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Mar 26, 2015 at 4:27 PM, David Ahern <david.ahern@oracle.com> wrote:
> On 3/26/15 2:43 PM, Yinghai Lu wrote:
>>
>> Can you send out boot log with "debug ignore_loglevel"?
>
>
> attached

So the kernel config is sparc32 or sparc64 ?

pci 0000:06:00.0: reg 0x184: can't handle BAR above 4GB (bus address
0x110204000)


only could happen when dma_addr_t is 32bit.

in drivers/pci/probe.c::__pcie_read_base()
                if ((sizeof(dma_addr_t) < 8) && l) {
                        /* Above 32-bit boundary; try to reallocate */
                        res->flags |= IORESOURCE_UNSET;
                        res->start = 0;
                        res->end = sz64;
                        dev_info(&dev->dev, "reg 0x%x: can't handle
BAR above 4GB (bus address %#010llx)\n",
                                 pos, (unsigned long long)l64);
                        goto out;
                }

also root bus has
pci_sun4v f02dbcfc: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x804000000000-0x80400fffffff]
(bus address [0x0000-0xfffffff])
pci_bus 0000:00: root bus resource [mem 0x800000000000-0x80007effffff]
(bus address [0x00000000-0x7effffff])
pci_bus 0000:00: root bus resource [bus 00-77]

and children device have
pci 0000:05:00.0: can't claim BAR 0 [mem
0x800100000000-0x800100001fff]: no compatible bridge window
pci 0000:06:00.0: can't claim BAR 0 [mem 0x800110000000-0x8001101fffff
pref]: no compatible bridge window
pci 0000:06:00.0: can't claim BAR 4 [mem 0x800110200000-0x800110203fff
pref]: no compatible bridge window
pci 0000:06:00.1: can't claim BAR 0 [mem 0x800110600000-0x8001107fffff
pref]: no compatible bridge window
pci 0000:06:00.1: can't claim BAR 4 [mem 0x800110404000-0x800110407fff
pref]: no compatible bridge window
pci 0000:07:00.0: can't claim BAR 1 [mem
0x800120000000-0x80012000ffff]: no compatible bridge window
pci 0000:07:00.0: can't claim BAR 3 [mem
0x800120040000-0x80012007ffff]: no compatible bridge window


looks like some root bus resource get dumped because it is out of range.

Also please make sure your config have

CONFIG_PCI_DEBUG=y

and capture serial console with "debug ignore_loglevel", so we check if
pci 0000:00:01.0 really have resource assigned.

Thanks

Yinghai
