Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:51371 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889AbaIDS4q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Sep 2014 14:56:46 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <Will.Deacon@arm.com>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Suravee Suthikulanit <suravee.suthikulpanit@amd.com>,
	linux-pci <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] drivers: pci: convert generic host controller to DT host bridge creation API
Date: Thu, 04 Sep 2014 20:56:01 +0200
Message-ID: <6051177.6dmYKHoDhl@wuerfel>
In-Reply-To: <20140904160217.GC12351@e102568-lin.cambridge.arm.com>
References: <1407861695-25549-1-git-send-email-Liviu.Dudau@arm.com> <6930538.Get2YiuMvJ@wuerfel> <20140904160217.GC12351@e102568-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday 04 September 2014 17:02:17 Lorenzo Pieralisi wrote:
> On Thu, Sep 04, 2014 at 03:05:53PM +0100, Arnd Bergmann wrote:

> > Interesting point: the generic implementation should probably not default
> > to reassigning all buses at all. We could have a (host controller specific,
> > but with standardized name) DT property for it, but it would be best if
> > firmware already probes it to not have to do it again.
> 
> I think that makes sense, let me point out though that this is
> *not* how the code works today, since the pcibios code sets:
> 
> PCI_REASSIGN_ALL_RSRC (pci_common_init_dev() in arch/arm/kernel/bios32.c)
> 
> by default. I won't set the PCI_REASSIGN_ALL_RSRC and PCI_REASSIGN_ALL_BUS
> flags.

Yes, I know it's not what the ARM32 code does at the moment. The main
reason for that is that there is normally no firmware at all. Since
the new code should be shared with ARM64 and we typically have firmware
there, we should reconsider the defaults.

	Arnd
