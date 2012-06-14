Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:63074 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829Ab2FNKZb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jun 2012 06:25:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
Date: Thu, 14 Jun 2012 10:25:09 +0000
Cc: linux-arm-kernel@lists.infradead.org,
	Mitch Bradley <wmb@firmworks.com>,
	Russell King <linux@arm.linux.org.uk>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Colin Cross <ccross@android.com>, linux-tegra@vger.kernel.org
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <201206132021.09774.arnd@arndb.de> <20120614083719.GC31283@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120614083719.GC31283@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201206141025.09325.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 14 June 2012, Thierry Reding wrote:
> > 
> > I believe you will need an "interrupt-map" property here, to map the host
> > interrupts to the INTA-INTD lines of the attached devices.
>
> Legacy interrupts are something I cannot test at all because I have no
> hardware that supports them.

Hmm, I thought all PCIe hardware has to support them when you do not
enable MSI. What hardware do you have then?

> > I'm not sure whether we want to have a device_type="pciex" property here.
> > powerpc and sparc seem to use that information, to distinguish a pcie
> > bus from pci or cardbus.
> 
> That'd be rather useless information given that the Tegra is unlikely to
> support either PCI or CardBus at some point.

But the generic code does not know that.

	Arnd
