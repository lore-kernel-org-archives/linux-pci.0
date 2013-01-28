Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:49085 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab3A1WEA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 28 Jan 2013 17:04:00 -0500
Message-ID: <5106F5CB.8050304@wwwdotorg.org>
Date: Mon, 28 Jan 2013 15:03:55 -0700
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
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
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 07/27] PCI: Add software-emulated host bridge
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com> <1359399397-29729-8-git-send-email-thomas.petazzoni@free-electrons.com> <201301282018.17714.arnd@arndb.de>
In-Reply-To: <201301282018.17714.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/28/2013 01:18 PM, Arnd Bergmann wrote:
> On Monday 28 January 2013, Thomas Petazzoni wrote:
>> From: Thierry Reding <thierry.reding@avionic-design.de>
>>
>> [Thomas Petazzoni:
>>  - Simplify capabilities handling.
>>  - Move to a separate file.
>>  - Fix mask used when writing a 4 bytes value.]
>>
>> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Not even a description why this is needed?
> 
> This patch (together with patch 8) seems like the most controversial
> one of the series, so you should better provide a really good reason
> why we would emulate something in software rather than using whatever
> hardware is there.

At least on Tegra, there is no HW that exposes PCI configuration
registers for the host bridge itself. Only the root ports have exposed
PCI configuration registers. There was some debate re: whether a host
bridge device needed to exist or not. This patch makes such a device
exist if it's required.
