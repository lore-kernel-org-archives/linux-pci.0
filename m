Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:42650 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899Ab3BMVCw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 16:02:52 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so1610704iaj.20
        for <linux-pci@vger.kernel.org>; Wed, 13 Feb 2013 13:02:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130213003224.GA32535@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
	<201302121902.14276.arnd@arndb.de>
	<20130212193848.GE1471@obsidianresearch.com>
	<201302122305.28467.arnd@arndb.de>
	<20130213003224.GA32535@obsidianresearch.com>
Date: Wed, 13 Feb 2013 13:02:51 -0800
Message-ID: <CAE9FiQWPhZDQ47Wp+7LkG4H2ZvKFKcAsYZ2Xfb8E4ze7=bpN=g@mail.gmail.com>
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
From: Yinghai Lu <yinghai@kernel.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 12, 2013 at 4:32 PM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Tue, Feb 12, 2013 at 11:05:28PM +0000, Arnd Bergmann wrote:
>>
>> Ah, so you only allow hotplugging into the root ports, but not behind
>> additional bridges that have active devices on them, right?
>
>> I guess that is a common limitation for PCIe hotplugging.
>
> In all the cases I've worked with, it has been a root port hot plug,
> but I could imagine something like ExpressCard requiring a second
> bridge.
>
> The standard answer is to leave appropriate gaps. My *guess* on this
> matter is that on x86 the gaps are left, as appropriate, by the boot
> firmware. Eg an ExpressCard slot will always have a window assigned to
> its bridge and Linux would typically not reassign it (or similar).

Yes, x86 BIOS will leave some pad number for every pcie root port.

Also with patches in
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
 for-pci-busn-alloc

could realloc bus range to get big bus number.

Thanks

Yinghai
