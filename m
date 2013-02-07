Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:37096 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161055Ab3BGSaw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 7 Feb 2013 13:30:52 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so3192308oag.32
        for <linux-pci@vger.kernel.org>; Thu, 07 Feb 2013 10:30:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130207181559.GA31508@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <5106F9F9.3010905@wwwdotorg.org> <20130129094143.1aad9377@skate>
 <20130129092006.GA16377@avionic-0098.mockup.avionic-design.de>
 <20130207112459.5f382ad4@skate> <CAErSpo7UOTGH7kjYBADymDdgmHwPxbXqczeXm1BH9C+XViQDRQ@mail.gmail.com>
 <20130207170020.289bac08@skate> <CAErSpo797rhH=xt2x7eqdu7Vwf43FXoXQVcypvHM8-54LRC0wQ@mail.gmail.com>
 <20130207181559.GA31508@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 7 Feb 2013 11:30:32 -0700
Message-ID: <CAErSpo58wLV6JXKrVdVH4X=p6X=U=o0czDSAtqWCtxvJbosaEQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
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
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 7, 2013 at 11:15 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Thu, Feb 07, 2013 at 11:08:45AM -0700, Bjorn Helgaas wrote:
>
>> I think the way you'll have to fix this in the meantime is to use
>> pci_create_root_bus() directly so you can do things in this sequence:
>>
>>   pci_create_root_bus
>>   pci_scan_child_bus
>>   pci_bus_assign_resources
>>   pci_bus_add_devices
>>
>> dino_probe() is an example of similar code that does this.
>
> Erm, but isn't this problem going to strike any system that doesn't
> have resources assigned by the firmware?
>
> If so, a common 'pci_scan_bus_from_scratch' would at least highlight
> the problem and centralize the work around until it is fixed...
>
> Many embedded systems will require this..

Yep, agreed on all counts.
