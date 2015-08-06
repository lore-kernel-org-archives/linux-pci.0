Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33205 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463AbbHFQlz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2015 12:41:55 -0400
Received: by lbbyj8 with SMTP id yj8so46226173lbb.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Aug 2015 09:41:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55C37C92.1020509@arm.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<20150804215457.9189.27595.stgit@bhelgaas-glaptop2.roam.corp.google.com>
	<55C37C92.1020509@arm.com>
Date: Fri, 7 Aug 2015 00:41:53 +0800
Message-ID: <CAFiDJ58U9u0YOzqVbty8+z+sF82h=F09Y0q-Ks8zMDokdiSEbg@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] PCI: xgene: Use pci_scan_root_bus_msi()
From: Ley Foon Tan <lftan.linux@gmail.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jayachandran C <jchandra@broadcom.com>,
	Pratyush Anand <pratyush.anand@gmail.com>,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Duc Dang <dhdang@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	Simon Horman <horms@verge.net.au>,
	James Morse <James.Morse@arm.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 6, 2015 at 11:26 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Hi Bjorn,
>
> On 04/08/15 22:54, Bjorn Helgaas wrote:
>> Previously there was no way to specify the MSI controller when creating a
>> new PCI root bus, so we had to create the bus, set its MSI controller, then
>> scan the bus.  With the new pci_scan_root_bus_msi() interface, we can
>> specify the MSI controller up front and get rid of that intermediate step.
>>
>> Look up the MSI controller first, then use pci_scan_root_bus_msi() to
>> create and scan the root PCI bus.
>
> I'm wondering about these XGene patches.
>
> With the code that is queued for v4.3 in tip/irq/core, the X-Gene MSI
> driver doesn't export a struct msi_controller anymore, and entirely
> relies on IRQ domains to identify to be matched with the actual PCI driver.
>
> Do you intend this as a cleanup until everything lands in mainline? At
> that point, we'd be able to remove all traces of struct msi_controller
> from this driver.
>
> Alternatively, we could ask tglx to add an extra patch to the existing
> queue in order to clean up pci-xgene.c (nuking the whole
> xgene_pcie_msi_enable function).
>
> Thoughts?

In pcie-altera driver, it uses pci_scan_root_bus() and it doesn't call
to of_pci_find_msi_chip_by_node() to retrieve msi_controller struct as
well.
But, the msi domain stuff is still working. Should I change it to
pci_scan_root_bus_msi()?

Regards
Ley Foon
