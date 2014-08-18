Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Mon, 18 Aug 2014 15:26:22 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Russell King <linux@arm.linux.org.uk>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Sinan Kaya <okaya@codeaurora.org>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-arch <linux-arch@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Device Tree ML <devicetree@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 00/12] Support for creating generic PCI host bridges
 from DT
Message-ID: <20140818142622.GP20043@localhost>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 12, 2014 at 05:25:13PM +0100, Liviu Dudau wrote:
> This is my updated attempt at adding support for generic PCI host
> bridge controllers that make use of device tree information to
> configure themselves. This version incorporates Catalin's proposal
> for managing domain numbers that got Bjorn's approval. I am now requesting
> ACKs from the relevant maintainers as I would like to get the upstream ball
> rolling.

As this series kept me busy on a long flight, you can add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
