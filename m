Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54619 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150Ab2HPHDz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 16 Aug 2012 03:03:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
Date: Thu, 16 Aug 2012 07:03:50 +0000
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Mitch Bradley <wmb@firmworks.com>
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de> <201208152025.25252.arnd@arndb.de> <20120816045539.GA17067@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120816045539.GA17067@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201208160703.50364.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 16 August 2012, Thierry Reding wrote:
> At least for the config space this is incorrect. There's a single region
> to access the configuration space for all devices below the PCIe
> controller. So it is shared by both (Tegra20) or all three (Tegra30)
> root ports.
> 
> I'm not sure about PCI domains. Do you have any good pointers as to
> where I could read up on them? If they need special hardware support,
> then I think Tegra doesn't support them either. At least I haven't come
> across any mention of domains while going through the, admittedly some-
> what sparse on PCIe, Tegra documentation.

I was referring to the same thing here: if you had a separate config
space for each root port, they would by definition be separate PCI
domain. So you don't have them.

	Arnd
