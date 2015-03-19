Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:36351 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbbCSUtc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Mar 2015 16:49:32 -0400
Received: by obdfc2 with SMTP id fc2so64075489obd.3
        for <linux-pci@vger.kernel.org>; Thu, 19 Mar 2015 13:49:32 -0700 (PDT)
Date: Thu, 19 Mar 2015 15:49:29 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Duc Dang <dhdang@apm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Grant Likely <grant.likely@linaro.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>, Loc Ho <lho@apm.com>,
	Feng Kan <fkan@apm.com>, Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v2 0/4] PCI: X-Gene: Add APM X-Gene v1 MSI/MSIX
 termination driver
Message-ID: <20150319204929.GH26935@google.com>
References: <1678162.2PJ2o1jRen@wuerfel>
 <cover.1425497218.git.dhdang@apm.com>
 <CADaLND=+Aq-zgMWE6vnn1kt1g2iz1k-AxMj4--kejF-q=f=bfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADaLND=+Aq-zgMWE6vnn1kt1g2iz1k-AxMj4--kejF-q=f=bfg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Marc]

On Wed, Mar 18, 2015 at 10:43:10AM -0700, Duc Dang wrote:
> On Wed, Mar 4, 2015 at 11:39 AM, Duc Dang <dhdang@apm.com> wrote:
> > This patch set adds MSI/MSIX termination driver support for APM X-Gene v1 SoC.
> > APM X-Gene v1 SoC supports its own implementation of MSI, which is not compliant
> > to GIC V2M specification for MSI Termination.
> >
> > There is single MSI block in X-Gene v1 SOC which serves all 5 PCIe ports. This MSI
> > block supports 2688 MSI termination ports coalesced into 16 physical HW IRQ lines
> > and shared across all 5 PCIe ports.
> >
> > v2 changes:
> >         1. Use msi_controller structure
> >         2. Remove arch hooks arch_teardown_msi_irqs and arch_setup_msi_irqs
> >
> >  .../devicetree/bindings/pci/xgene-pci-msi.txt      |  61 ++++
> >  MAINTAINERS                                        |   8 +
> >  arch/arm64/boot/dts/apm/apm-storm.dtsi             |  27 ++
> >  drivers/pci/host/Kconfig                           |   4 +
> >  drivers/pci/host/Makefile                          |   1 +
> >  drivers/pci/host/pci-xgene-msi.c                   | 393 +++++++++++++++++++++
> >  drivers/pci/host/pci-xgene.c                       |  25 ++
> >  7 files changed, 519 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/xgene-pci-msi.txt
> >  create mode 100644 drivers/pci/host/pci-xgene-msi.c
> >
> > --
> > 1.9.1
> >
> Hi Bjorn, Arnd, and All,
> 
> Did you have a chance to take a look at this v2 patch set for X-Gene 1
> MSI support?

Marc had some comments, and as far as I can tell, you haven't addressed
them yet.  Am I mistaken?

Bjorn
