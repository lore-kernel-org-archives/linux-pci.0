Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48122 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759570AbbLCLB2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 3 Dec 2015 06:01:28 -0500
Date: Thu, 3 Dec 2015 11:02:38 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jayachandran C <jchandra@broadcom.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH 0/3] ACPI PCI support for arm64
Message-ID: <20151203110238.GE2110@red-moon>
References: <1449095086-5138-1-git-send-email-jchandra@broadcom.com>
 <20151203105628.GD2110@red-moon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151203105628.GD2110@red-moon>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[Resend, LAKML copied-in]

On Thu, Dec 03, 2015 at 10:56:28AM +0000, Lorenzo Pieralisi wrote:
> [CC'ing Tomasz]
> 
> On Thu, Dec 03, 2015 at 03:54:43AM +0530, Jayachandran C wrote:
> > This is a very simple and generic implementation of a PCI host controller
> > based on ACPI. This approach does not pull in the MMCONFIG and ECAM code
> > from x86.
> 
> Why ? Tomasz's patchset does not move MMCONFIG and ECAM code to the generic
> PCI layer for fun, it is generic code and should be shared by all
> architectures and most importantly we should not add more churn on
> top of it which would complicate consolidation even further.
> 
> > It is important for us to have a working ACPI based PCI host controller
> > implementation for arm64, so I thought I would post this as a simple
> > and less disruptive alternative.
> 
> It is important for everyone but that's not a reason granting shortcuts.
> 
> > This is tested with arm64 QEMU and OVMF. Comments are very welcome.
> 
> Tomasz's patch went through several review cycles, please help review
> it and test it, that's my comment.
> 
> A new version should be posted soon, previous version here:
> 
> https://lkml.org/lkml/2015/10/27/504
> 
> Thanks,
> Lorenzo
> 
> > 
> > Thanks,
> > JC.
> > 
> > Jayachandran C (3):
> >   arm64: pci: Add ACPI support
> >   pci: Handle NULL parent in pci_bus_assign_domain_nr
> >   pci/host : Add a generic ACPI based host controller
> > 
> >  arch/arm64/kernel/pci.c          |  47 ++++++++-
> >  drivers/pci/host/Kconfig         |   7 ++
> >  drivers/pci/host/Makefile        |   1 +
> >  drivers/pci/host/pci-host-acpi.c | 211 +++++++++++++++++++++++++++++++++++++++
> >  drivers/pci/pci.c                |   7 +-
> >  5 files changed, 270 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/pci/host/pci-host-acpi.c
> > 
> > -- 
> > 1.9.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
