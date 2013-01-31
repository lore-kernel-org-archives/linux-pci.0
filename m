Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:61361 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab3AaREV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 31 Jan 2013 12:04:21 -0500
Received: by mail-vc0-f180.google.com with SMTP id fo13so1877434vcb.39
        for <linux-pci@vger.kernel.org>; Thu, 31 Jan 2013 09:04:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130131173343.46514422@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo5H08j=dZx9zapDaf1c9x6VUfuJ5oB=J0M1UFF55pg=mw@mail.gmail.com>
 <20130129055508.GA3339@obsidianresearch.com> <CAErSpo7gCFfLB6+ebvANQjkr7Bii8Jqt3y5YqExD-DcnBG7hgA@mail.gmail.com>
 <20130129184157.GA29274@obsidianresearch.com> <CAErSpo5K8yKqjzQ6s+imb3d5wLSkhvWp-d=pPv9CZk+o67kyaQ@mail.gmail.com>
 <20130129191853.GB29274@obsidianresearch.com> <CAErSpo4Zvy7=ROajygecfsEFVJxy-yNbSntdQdDFcQBPz=Qgfg@mail.gmail.com>
 <CAErSpo41TbWTZ_6m0_uv-EaKnnqMR9jpqsarOJLGYZ31mrdkiw@mail.gmail.com>
 <20130130103501.1873d39c@skate> <CAErSpo5NTyrHv8AQkw3hYpJRiZsk1HKHP3jP_MMpEVVhCgjKYg@mail.gmail.com>
 <20130131170401.4b3bfbbf@skate> <CAErSpo7fPzrF_OZSL7Ss0LT70Qz+veXLW-ihA7fAXCwsn142cQ@mail.gmail.com>
 <20130131173343.46514422@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 31 Jan 2013 10:03:59 -0700
Message-ID: <CAErSpo79GFu2Vnrft7OvtHe7d+E+uAtq7xwc6D69nb_6PuxEqA@mail.gmail.com>
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

On Thu, Jan 31, 2013 at 9:33 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Dear Bjorn Helgaas,
>
> On Thu, 31 Jan 2013 09:30:07 -0700, Bjorn Helgaas wrote:
>
>> > Following you're recommendation, I've changed this, and left those
>> > values initialized to 0 by default, in order to let Linux set correct
>> > values. Yes, Linux does assign appropriate values in the Secondary Bus
>> > Number Register. But before that Linux also complains loudly that the
>> > bridge configuration is invalid:
>> >
>> > pci 0000:00:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> > pci 0000:00:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> > pci 0000:00:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> > pci 0000:00:04.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> > pci 0000:00:05.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> > pci 0000:00:06.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>
>> Linux makes the unwarranted assumption that the PCI hierarchy has
>> already been configured by firmware.  If the only problem is the
>> messages above, I think we could just rework the message so it doesn't
>> look like an error.  I would guess that we probably also see the same
>> distressing message when we hot-add a card with a bridge on it,
>> because firmware won't have initialized the bridge.
>>
>> My rule of thumb is that I like to note something in dmesg about the
>> initial configuration of bus/mem/io apertures and BARs, as well as
>> indications when we update them.  That way, the dmesg log should
>> contain enough information to debug most enumeration and configuration
>> defects.  pci_scan_bridge() is somewhat lacking in this regard.
>
> Ok. Would something like:
>
>  "bridge configuration with unassigned bus numbers ([bus 00-00]), reconfiguring"
>
> be an acceptable to replace this one?

Seems reasonable.
