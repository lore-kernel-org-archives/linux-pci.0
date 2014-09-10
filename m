Return-Path: <linux-arch-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>
Subject: Re: [PATCH v10 07/10] OF: Introduce helper function for getting PCI domain_nr
Date: Wed, 10 Sep 2014 20:19:52 +0200
Message-ID: <2908259.jgJNuDxCCa@wuerfel>
In-Reply-To: <20140909112054.GD29639@arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com> <3780051.0eHpCN6UC9@wuerfel> <20140909112054.GD29639@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 09 September 2014 12:20:54 Catalin Marinas wrote:
> 
> We can assume that if a domain is not specified and there is a single
> top level PCIe node, the domain defaults to 0. Are there any arm32
> platforms that require multiple domains (and do not specify a number in
> the DT)?

In theory, I think all of them could work with a single domain, but then
you need to partition the bus number space between the host controllers,
so you have the exact same situation that you either need to make up
random bus numbers or put them in DT.

Using multiple domains is way cleaner for this, even if we have to
make up the numbers.

	Arnd
