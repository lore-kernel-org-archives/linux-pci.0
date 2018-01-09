Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57100 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758820AbeAIPxE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jan 2018 10:53:04 -0500
Date: Tue, 9 Jan 2018 15:54:03 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Ray Jui <ray.jui@broadcom.com>, Oza Oza <oza.oza@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Regression: NULL pointer dereference caused by
 iproc_pcie_map_dma_ranges
Message-ID: <20180109155403.GB16285@red-moon>
References: <CACna6rxOBUfVhqrMZ2=-6NLrey7193Dtgf-DniSw8Y+qCD6kKA@mail.gmail.com>
 <6707e532-7a5e-261c-4d5b-950d0ccc8f66@broadcom.com>
 <CACna6rygToq7xL0U4-qD5dftYq4=PRhcrpKqAafvuB3mw6Dcsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CACna6rygToq7xL0U4-qD5dftYq4=PRhcrpKqAafvuB3mw6Dcsw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jan 02, 2018 at 11:00:43PM +0100, Rafał Miłecki wrote:
> On 2 January 2018 at 19:44, Ray Jui <ray.jui@broadcom.com> wrote:
> > Can you please give the following patch a try to see if that fixes the
> > issue? Thanks.
> 
> It does, thank you!
> 
> 
> > From f91de124bc8fb5645d7dbbfd68a9a68617955749 Mon Sep 17 00:00:00 2001
> > From: Ray Jui <ray.jui@broadcom.com>
> > Date: Tue, 2 Jan 2018 10:36:03 -0800
> > Subject: [PATCH] PCI: iproc: Fix NULL pointer dereference for BCMA
> >
> > With the inbound DMA mapping supported added, the iProc PCIe driver
> > parses DT property "dma-ranges" through call to
> > "of_pci_dma_range_parser_init". In the case of BCMA, this results in a
> > NULL pointer deference due to a missing of_node.
> >
> > Fix this by adding a guard in pcie-iproc-platform.c to only enable the
> > inbound DMA mapping logic when DT property "dma-ranges" is present
> >
> > fixes: dd9d4e7498de3 ("PCI: iproc: Add inbound DMA mapping support")
> > Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> 
> Please add:
> Tested-by: Rafał Miłecki <rafal@milecki.pl>
> Cc: stable@vger.kernel.org # 4.10+

FYI, if you want the patch to be applied please post it on linux-pci
in a separate thread.

Thanks,
Lorenzo
