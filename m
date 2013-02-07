Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:37724 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629Ab3BGPq0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 10:46:26 -0500
Received: by mail-ob0-f169.google.com with SMTP id ta14so2877794obb.14
        for <linux-pci@vger.kernel.org>; Thu, 07 Feb 2013 07:46:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130207112459.5f382ad4@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F9F9.3010905@wwwdotorg.org> <20130129094143.1aad9377@skate>
 <20130129092006.GA16377@avionic-0098.mockup.avionic-design.de> <20130207112459.5f382ad4@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 7 Feb 2013 08:46:06 -0700
Message-ID: <CAErSpo7UOTGH7kjYBADymDdgmHwPxbXqczeXm1BH9C+XViQDRQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>, linux-pci@vger.kernel.org,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 7, 2013 at 3:24 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Thierry Reding,
>
> On Tue, 29 Jan 2013 10:20:06 +0100, Thierry Reding wrote:
>
>> > I didn't test recently, but with my first version of the patch set,
>> > having an initialization as late as module_init() was too late. Some
>> > PCI fixup code was being executed *before* we get the opportunity of
>> > initializing the PCI driver, and it was crashing the kernel. I can
>> > provide more details if you want.
>>
>> Does this patch perhaps fix this crash?
>>
>>       http://patchwork.ozlabs.org/patch/210870/
>
> I investigated a bit more, and managed to reproduce my crash even with
> your patch applied. And indeed, my crash is really unrelated to the
> pcibios function disappearing. Here is the kernel panic (and a short
> analysis afterwards) :

Hi Thomas,

Can you post the entire dmesg log, ideally with CONFIG_PCI_DEBUG=y?
That should have more information about the enumeration process,
including what we think the XHCI BARs are and the apertures leading to
them.

The PCI core assumes that we know the host bridge apertures up front,
and I'm not sure that is true on your platform, so maybe we'll need
some changes to accommodate that.

Bjorn
