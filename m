Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v11 03/10] ARM: Define PCI_IOBASE as the base of virtual PCI IO space.
Date: Sat, 20 Sep 2014 04:14:10 +0200
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	"linux-pci" <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	"linux-arch" <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com> <1411003825-21521-4-git-send-email-Liviu.Dudau@arm.com>
In-Reply-To: <1411003825-21521-4-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201409200414.10675.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 18 September 2014, Liviu Dudau wrote:
> This is needed for calls into OF code that parses PCI ranges.
> It signals support for memory mapped PCI I/O accesses that
> are described be device trees.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
