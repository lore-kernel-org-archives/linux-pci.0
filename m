Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:55331 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S935228Ab3DII0G (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 9 Apr 2013 04:26:06 -0400
Date: Tue, 9 Apr 2013 09:25:32 +0100
From: Andrew Murray <andrew.murray@arm.com>
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Maen Suleiman <maen@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Olof Johansson <olof@lixom.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Mitch Bradley <wmb@firmworks.com>
Subject: Re: [RFCv1 08/11] PCI: Introduce new MSI chip infrastructure
Message-ID: <20130409082532.GA31140@arm.com>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1364316746-8702-9-git-send-email-thomas.petazzoni@free-electrons.com>
 <CAErSpo42AFdKH2RKTxOaeJgCPrYD5KYkOs3UEBez8x8Bjmun5w@mail.gmail.com>
 <20130409081119.GA30736@arm.com>
 <20130409082232.GC27255@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130409082232.GC27255@avionic-0098.mockup.avionic-design.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 09, 2013 at 09:22:33AM +0100, Thierry Reding wrote:
> On Tue, Apr 09, 2013 at 09:11:19AM +0100, Andrew Murray wrote:
> [...]
> > Also I believe pci_alloc_child_bus function would need to be changed to add
> > "b->msi = msi" to inherit msi_chip for child buses in the above patch?
> 
> The patch already does:
> 
> 	child->msi = parent->msi;
> 
> in pci_alloc_child_bus(), the same way that ops is inherited. I have
> admittedly only tested this code on Tegra, but I don't see why that
> wouldn't be enough. Or maybe I haven't understood your question?

Sorry I missed that part of your patch - that was exacatly what I was
hoping to see.

Andrew Murray
