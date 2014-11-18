Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:53270 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932385AbaKRO1z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 18 Nov 2014 09:27:55 -0500
Received: by mail-qc0-f180.google.com with SMTP id i8so7217659qcq.11
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2014 06:27:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141118123402.7318ec94@free-electrons.com>
References: <20141118105542.457d7863@free-electrons.com> <20141118105843.3c1651d5@free-electrons.com>
 <20141118123402.7318ec94@free-electrons.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 18 Nov 2014 07:27:29 -0700
Message-ID: <CAErSpo4k57tdqbEYYcqEiviwoR0LCMUszECumpeL6w80xDeVfg@mail.gmail.com>
Subject: Re: Regression caused by "PCI: Shrink decoding-disabled window while
 sizing BARs"
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Myron Stowe <myron.stowe@redhat.com>,
	Kevin Hilman <khilman@kernel.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	=?UTF-8?Q?Gregory_Cl=C3=A9ment?=
	<gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Yinghai]

On Tue, Nov 18, 2014 at 4:34 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> On Tue, 18 Nov 2014 10:58:43 +0100, Thomas Petazzoni wrote:
>
>> Another issue (possibly related, or not), is the following compile time
>> warning:
>>
>> /home/thomas/projets/linux-2.6/drivers/pci/probe.c: In function ‘pci_read_bridge_mmio_pref’:
>> /home/thomas/projets/linux-2.6/drivers/pci/probe.c:430:5: warning: left shift count >= width of type
>>      base |= ((dma_addr_t) mem_base_hi) << 32;
>>      ^
>> /home/thomas/projets/linux-2.6/drivers/pci/probe.c:431:5: warning: left shift count >= width of type
>>      limit |= ((dma_addr_t) mem_limit_hi) << 32;
>>      ^
>>
>> This happens because dma_addr_t is 32 bits on ARM platforms, which
>> isn't properly taken into account by the commit that introduces support
>> for 64 bits DMA addresses.
>
> Not sure about this one: the commit introducing the issue is in
> next-20141117, but not in the current pci/next of Bjorn. Was it
> reverted? Am I looking at the wrong place?

Yes, that change (3a02517d5e2a ("PCI: Support 64-bit bridge windows if
we have 64-bit dma_addr_t")) is in my for-linus branch because it
fixes a regression and I intend to merge it for v3.18 (after we figure
out these issues, of course).

I saw this warning yesterday, but haven't heard from Yinghai yet.

Bjorn
