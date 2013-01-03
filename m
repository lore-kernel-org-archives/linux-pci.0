Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:51268 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753206Ab3ACPBU (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jan 2013 10:01:20 -0500
Received: by mail-la0-f52.google.com with SMTP id fq12so8064368lab.11
        for <linux-pci@vger.kernel.org>; Thu, 03 Jan 2013 07:01:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130103143931.GA28451@avionic-0098.adnet.avionic-design.de>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 3 Jan 2013 08:00:58 -0700
Message-ID: <CAErSpo4O9jCjLrdky2C-7EarJwBPSTRrhHb7pNsQNWcNNgenEw@mail.gmail.com>
Subject: Re: [RFC v1] PCIe support for the Armada 370 and Armada XP SoCs
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Eran Ben-Avi <benavi@marvell.com>,
	Yehuda Yitschak <yehuday@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robherring2@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 3, 2013 at 7:39 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> Hi everyone,
>
> Thomas' RFC series incited me to put in some more work on the Tegra PCIe
> controller driver. This in turn brought up an old issue: should we move
> PCIe controller drivers to some central location rather than keeping
> them in machine-specific directories? Last time I brought this up there
> was no consensus but I really think there's some value in keeping these
> drivers in a common location, especially now that a few people are
> starting to work on similar problems. It may also provide some more
> momentum to get the various DT implementations factored out of various
> architectures.
>
> Stephen proposed drivers/pci/host on IRC and I second that.
>
> Bjorn, is this something you would be on board with?

Sounds fine to me.
