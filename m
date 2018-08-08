Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42660 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbeHHS65 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Aug 2018 14:58:57 -0400
Date: Wed, 8 Aug 2018 17:38:21 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Alan Douglas <adouglas@cadence.com>
Cc: bhelgaas@google.com, kishon@ti.com, linux-pci@vger.kernel.org,
        gustavo.pimentel@synopsys.com, cyrille.pitchen@bootlin.com,
        stelford@cadence.com
Subject: Re: [PATCH 0/5] Add MSI-X support for cadence EP driver
Message-ID: <20180808163821.GA486@e107981-ln.cambridge.arm.com>
References: <1532971260-5269-1-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532971260-5269-1-git-send-email-adouglas@cadence.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Alan,

On Mon, Jul 30, 2018 at 06:21:00PM +0100, Alan Douglas wrote:
> Patch series made against Bjorn Helgaas's pci next branch.

Always rebase patches on a fixed -rc (ie Bjorn and I are using
v4.18-rc1) and mention the dependency rather than rebasing the
series on pci-next please.

> It relies on Gustavo Pimentel's patch series adding MSI-X
> support in the PCIe EP driver framework, and implements
> MSI-X support for the cadence endpoint driver.
>  - Use AXI region 0 for interrupt signalling
>  - Write MSI and MSI-X with 32bit value rather than 16bit
>  - Check for masking before sending MSI or MSI-X
>  - Check link is up before sending IRQ

These first four are fixes or changes required before enabling
the last patch in the series ?

Reworded: does the current driver work without the first 4
patches applied ?

If they are fixes please mark them as such in the commit log.

Thanks,
Lorenzo

>  - Use BAR5 for MSI-X vectors
> 
> Alan Douglas (5):
>   PCI: cadence: Use AXI region 0 to signal interrupts from EP
>   PCI: cadence: Write MSI data with 32bits
>   PCI: cadence: Check whether MSI is masked before sending it
>   PCI: cadence: Check link is up before sending IRQ from EP
>   PCI: cadence: Add MSI-X capability to EP driver
> 
>  drivers/pci/controller/pcie-cadence-ep.c |  129 ++++++++++++++++++++++++++++--
>  drivers/pci/controller/pcie-cadence.h    |    1 +
>  2 files changed, 124 insertions(+), 6 deletions(-)
> 
