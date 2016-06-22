Return-Path: <thomas.petazzoni@free-electrons.com>
Return-Path: <thomas.petazzoni@free-electrons.com>
Date: Wed, 22 Jun 2016 19:33:30 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org, Nadav Haklai
 <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Hanna Hawa
 <hannah@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Jason Cooper
 <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth
 <sebastian.hesselbarth@gmail.com>, Gregory Clement
 <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] PCI: host: new PCI host controller driver for
 Aardvark
Message-ID: <20160622193330.490d1bce@free-electrons.com>
In-Reply-To: <20160622161607.GD25485@localhost>
References: <1465574056-8787-3-git-send-email-thomas.petazzoni@free-electrons.com>
	<201606111501.h2bC6u5a%fengguang.wu@intel.com>
	<20160622161607.GD25485@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-pci.vger.kernel.org>

Hello,

On Wed, 22 Jun 2016 11:16:07 -0500, Bjorn Helgaas wrote:

> > All errors (new ones prefixed by >>):
> >   
> > >> drivers/of/Kconfig:4:error: recursive dependency detected!  
> 
> Was there a resolution to this?

Yes, Arnd sent a patch which I believe addresses this:

	[PATCH] arm/arm64/irqchip/pci: fix PCI_MSI dependencies

I'll verify locally that it indeed solves the problem.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
