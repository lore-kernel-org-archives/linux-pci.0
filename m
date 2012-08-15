Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:64371 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571Ab2HOUZa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 Aug 2012 16:25:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v3 10/10] ARM: tegra: pcie: Add device tree support
Date: Wed, 15 Aug 2012 20:25:25 +0000
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
References: <1343332512-28762-1-git-send-email-thierry.reding@avionic-design.de> <CAErSpo7c4L=Ny=CtZwLB_XWTcN8tVWs_quuE_T+XLEGyhWwHkg@mail.gmail.com> <20120815145708.GA11331@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120815145708.GA11331@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201208152025.25252.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday 15 August 2012, Thierry Reding wrote:
> Yes, that was my understanding as well. So currently I haven't seen any
> problems with this because I only use one of the two host bridges. But I
> suppose I should add code to initialize the bus number aperture properly
> either via platform device resources (for the non-DT case) and the
> device tree otherwise.

I think when we last discussed this, the assumption was that each
root port has its own config space range and its own pci domain,
so you don't have to worry about bus apertures because each root port
can then have all 255 bus numbers. Has that turned out to be incorrect
now?

	Arnd
