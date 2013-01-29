Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:63494 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab3A2Ckh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 21:40:37 -0500
Received: by mail-ve0-f176.google.com with SMTP id jz10so1813814veb.7
        for <linux-pci@vger.kernel.org>; Mon, 28 Jan 2013 18:40:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130128220904.GA21446@obsidianresearch.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301282018.17714.arnd@arndb.de> <5106F5CB.8050304@wwwdotorg.org> <20130128220904.GA21446@obsidianresearch.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 28 Jan 2013 19:40:16 -0700
Message-ID: <CAErSpo7-qXZTri-T+v4O3rKk9AXjHE4ckkWZ1UT63SC1fG02-A@mail.gmail.com>
Subject: Re: [PATCH v2 07/27] PCI: Add software-emulated host bridge
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 28, 2013 at 3:09 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Jan 28, 2013 at 03:03:55PM -0700, Stephen Warren wrote:
>> On 01/28/2013 01:18 PM, Arnd Bergmann wrote:
>> > On Monday 28 January 2013, Thomas Petazzoni wrote:
>> >> From: Thierry Reding <thierry.reding@avionic-design.de>
>> >>
>> >> [Thomas Petazzoni:
>> >>  - Simplify capabilities handling.
>> >>  - Move to a separate file.
>> >>  - Fix mask used when writing a 4 bytes value.]
>> >>
>> >> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>> >> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> >
>> > Not even a description why this is needed?
>> >
>> > This patch (together with patch 8) seems like the most controversial
>> > one of the series, so you should better provide a really good reason
>> > why we would emulate something in software rather than using whatever
>> > hardware is there.
>>
>> At least on Tegra, there is no HW that exposes PCI configuration
>> registers for the host bridge itself. Only the root ports have exposed
>> PCI configuration registers. There was some debate re: whether a host
>> bridge device needed to exist or not. This patch makes such a device
>> exist if it's required.

Host bridges are not actually PCI devices on any architecture.  The
upstream side of a host bridge is by definition not on a PCI bus.  On
some architectures, it *looks* like the host bridge is a PCI device
because it responds to PCI config accesses and you can get to
configuration registers that way.  But it isn't really; you can't
enumerate host bridges by using normal PCI device enumeration because
you have to somehow discover the root bus and the method of doing
config accesses to it.  That is all outside the scope of PCI.  Even on
the architectures where host bridges appear in PCI config space, the
only reason that works is because we assume a config access mechanism
that works for domain 0.  We can't discover bridges in other domains
without help.

> If Linux will discover properly (I strongly suspect it does) without
> the host bridge, then I would say to ditch this...
>
> The PCI-E standard requires a host bridge device, but if Linux doesn't
> require it then there is no reason to emulate one.

I agree that you don't need to emulate anything in the sense of making
config space accessors as this patch does.

However, I think you *should* use pci_scan_root_bus() (maybe you do
already; I haven't read all these patches), which requires that you
know the configuration of the host bridge, i.e., the config access
mechanism, the bus number range below the host bridge, and the I/O and
MMIO apertures through the bridge.  The PCI core builds a logical host
bridge structure internally from that information, and that's all
Linux really needs.

Bjorn
