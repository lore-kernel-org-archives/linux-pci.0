Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f180.google.com ([209.85.128.180]:35125 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab3A3Xsu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 18:48:50 -0500
Received: by mail-ve0-f180.google.com with SMTP id jx10so1554200veb.39
        for <linux-pci@vger.kernel.org>; Wed, 30 Jan 2013 15:48:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130130232836.1b1fd89b@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo5H08j=dZx9zapDaf1c9x6VUfuJ5oB=J0M1UFF55pg=mw@mail.gmail.com>
 <20130129055508.GA3339@obsidianresearch.com> <CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
 <20130129184157.GA29274@obsidianresearch.com> <CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
 <20130129191853.GB29274@obsidianresearch.com> <CAErSpo4Zvy7=ROajygecfsEFVJxy-yNbSntdQdDFcQBPz=Qgfg@mail.gmail.com>
 <CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com>
 <20130130103501.1873d39c@skate> <CAErSpo5NTyrHv8AQkw3hYpJRiZsk1HKHP3jP_MMpEVVhCgjKYg@mail.gmail.com>
 <20130130232836.1b1fd89b@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Jan 2013 16:48:28 -0700
Message-ID: <CAErSpo4R4CsPHO_rHZN+FAKrkxdHCxfOvvzgkh-zUmpEO-n9TA@mail.gmail.com>
Subject: Re: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP systems
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 30, 2013 at 3:28 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> On Wed, 30 Jan 2013 11:52:15 -0700, Bjorn Helgaas wrote:

>> It looks like your current system doesn't support trees below the
>> bridges, but hopefully we can make it so the generic enumeration
>> algorithms still work.
>
> In practice, in our situation, there isn't a tree below the bridge.
> There is one single device. I'd prefer to not implement features that I
> cannot effectively test, and let the implementation of those additional
> features to whoever will need them, and therefore be able to test them.

I understand the concern about testing, but my advice is to not use
that as an excuse to artificially limit the functionality of the code
you're writing :)

You're talking about emulating a bridge, and the bridge really doesn't
know or care what's downstream.  If it works with a single device
downstream, it should work with another bridge downstream.  Many
aspects of bridge configuration can be tested with creative
application of setpci, so that might be a possibility, too.

> I guess that if I integrate the PCI-to-PCI bridge emulation code within
> the Marvell driver, then I can keep it fairly limited to whatever the
> Marvell PCI driver requires, no?

Yeah, it's just that the pci_dev for this emulated bridge is used by
the generic PCI core code, e.g., pci_scan_bridge(), so whatever
emulation you do has to be robust enough that the core won't notice
it's emulated.

Bjorn
