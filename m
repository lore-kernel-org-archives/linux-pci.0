Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64958 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762167Ab2FVNsw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jun 2012 09:48:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Date: Fri, 22 Jun 2012 13:48:39 +0000
Cc: Mitch Bradley <wmb@firmworks.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Rob Herring <rob.herring@calxeda.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
References: <20120613081910.GB6528@avionic-0098.mockup.avionic-design.de> <20120622110403.GA15710@avionic-0098.mockup.avionic-design.de> <20120622132253.GA30704@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120622132253.GA30704@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201206221348.39346.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 22 June 2012, Thierry Reding wrote:
> > It seems like this isn't working properly. For some reason both the reg
> > property of pci@0 and pci@1 are translated to the same parent address
> > 0x80000000. I'll have to investigate where exactly this goes wrong.
> 
> So it turns out that while of_read_number() can actually read any number
> of cells, only the two least significant are kept because it returns a
> u64. Since of_bus_default_map() uses of_read_number() the addresses
> <0 0 0> and <1 0 0> are in fact the same. I'm not sure how best to solve
> this. I'm not aware of a 128 bit integer type in the kernel, so I guess
> the better alternative would be to fix of_bus_default_map() to cope with
> #address-cells > 2 properly.

of_translate_address should get it right. Which codes uses of_read_number()?
Can it be converted to use of_translate_address()?

	Arnd
