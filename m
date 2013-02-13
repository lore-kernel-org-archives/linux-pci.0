Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ia0-f175.google.com ([209.85.210.175]:36917 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab3BMVUq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Feb 2013 16:20:46 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so1631475iaj.6
        for <linux-pci@vger.kernel.org>; Wed, 13 Feb 2013 13:20:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <201302132110.55087.arnd@arndb.de>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
	<201302131853.14617.arnd@arndb.de>
	<20130213191204.GA15710@obsidianresearch.com>
	<201302132110.55087.arnd@arndb.de>
Date: Wed, 13 Feb 2013 13:20:43 -0800
Message-ID: <CAE9FiQVHQqpE+Dupcmt=dpUUEJk=3JoxsMmFf0SXtqE==YJ9Fg@mail.gmail.com>
Subject: Re: Giving special alignment/size constraints to the Linux PCI core?
From: Yinghai Lu <yinghai@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
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

On Wed, Feb 13, 2013 at 1:10 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> The problem I see with the current implementation is that it reserves
> a fixed size window and does not reassign the window of the bridge
> itself, only the devices below it, at least if I am reading the
> code correctly. I have not tried this myself.

Which file?

Current code we *do* change the bridge itself resource (mmio, pref mmio, and io)
in
pciehp_configure_device/pci_assign_unassigned_bridge_resources

Let met if it does not work you.

Thanks

Yinghai
