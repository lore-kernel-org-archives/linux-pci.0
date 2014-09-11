Return-Path: <linux-arch-owner@vger.kernel.org>
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>
CC: Yijing Wang <wangyijing@huawei.com>,
	Rob Herring <robherring2@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rob Herring <robh+dt@kernel.org>,
	"Jason Gunthorpe" <jgunthorpe@obsidianresearch.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Will Deacon <Will.Deacon@arm.com>,
	Russell King <linux@arm.linux.org.uk>,
	linux-pci <linux-pci@vger.kernel.org>,
	"Linus Walleij" <linus.walleij@linaro.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	"Grant Likely" <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	"Jingoo Han" <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	"Suravee Suthikulanit" <suravee.suthikulpanit@amd.com>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Device Tree ML" <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>
Subject: RE: [PATCH v10 07/10] OF: Introduce helper function for getting PCI
 domain_nr
Date: Thu, 11 Sep 2014 14:11:05 +0000
Message-ID: <ae98d68652f1495a857f081c3a6aecb2@HKXPR06MB168.apcprd06.prod.outlook.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <3780051.0eHpCN6UC9@wuerfel> <20140909112054.GD29639@arm.com>
 <2908259.jgJNuDxCCa@wuerfel>
In-Reply-To: <2908259.jgJNuDxCCa@wuerfel>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On 10 September 2014 19:20, Arnd wrote:
> On Tuesday 09 September 2014 12:20:54 Catalin Marinas wrote:
> >
> > We can assume that if a domain is not specified and there is a single
> > top level PCIe node, the domain defaults to 0. Are there any arm32
> > platforms that require multiple domains (and do not specify a number in
> > the DT)?
> 
> In theory, I think all of them could work with a single domain, but then
> you need to partition the bus number space between the host controllers,
> so you have the exact same situation that you either need to make up
> random bus numbers or put them in DT.
> 
> Using multiple domains is way cleaner for this, even if we have to
> make up the numbers.

Maybe this is a stupid question, but why would you want to specify the domain
in the DT at all? Doesn't every instance of a driver imply a separate domain?

Thanks
Phil 
