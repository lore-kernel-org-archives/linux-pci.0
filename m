Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:42647 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbaKRWgS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 17:36:18 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so1883089igb.11
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2014 14:36:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141118220000.3ab0d2d9@free-electrons.com>
References: <20141118105542.457d7863@free-electrons.com>
	<20141118105843.3c1651d5@free-electrons.com>
	<20141118123402.7318ec94@free-electrons.com>
	<CAErSpo4k57tdqbEYYcqEiviwoR0LCMUszECumpeL6w80xDeVfg@mail.gmail.com>
	<CAE9FiQX0JO40EE=D88EYGwm2uRjnrX5+McTuofW6QLbS5nLMSw@mail.gmail.com>
	<20141118220000.3ab0d2d9@free-electrons.com>
Date: Tue, 18 Nov 2014 14:36:17 -0800
Message-ID: <CAE9FiQXo3ctdFk2Z+duaq1wxSAVCA0tG5_f85-UaLk8+Dafhvg@mail.gmail.com>
Subject: Re: Regression caused by "PCI: Shrink decoding-disabled window while
 sizing BARs"
From: Yinghai Lu <yinghai@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Kevin Hilman <khilman@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	=?UTF-8?Q?Gregory_Cl=C3=A9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 18, 2014 at 1:00 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Is a u64 cast really the appropriate solution here? Have you seen my
> proposed fix "[PATCH] PCI: fix probe.c warning
> on !CONFIG_ARCH_DMA_ADDR_T_64BIT platforms" ?

Yes, that I saw your patch.

We want to make that to be consistent with __pci_read_bases()
and avoid MACRO.

I think the warning is wrong. aka compile should omit out that branch.
as sizeof(dma_addr_t) on !CONFIG_ARCH_DMA_ADDR_T_64BIT
is 4 and it is smaller than 8. and those are const, so the compiler should
not ...

add the cast just shut off the compiler wrong warning.

code segment:

                        if (sizeof(dma_addr_t) < 8) {
                                if (mem_base_hi || mem_limit_hi) {
                                        dev_err(&dev->dev, "can't
handle 64-bit address space for bridge\n");
                                        return;
                                }
                        } else  {
                                base |= (dma_addr_t)(((u64)mem_base_hi)<<32);
                                limit |= (dma_addr_t)(((u64)mem_limit_hi)<<32);
                        }


Thanks

Yinghai
