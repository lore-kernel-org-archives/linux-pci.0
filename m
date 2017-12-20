Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:44612 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755929AbdLTTrs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Dec 2017 14:47:48 -0500
Subject: Re: [PATCH v6 00/18] dwc MSI fixes, ARTPEC-6 EP mode support,
 ARTPEC-7 SoC support
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>
CC: <linux-arm-kernel@axis.com>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, Niklas Cassel <niklass@axis.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20171219232940.659-1-niklas.cassel@axis.com>
 <20171220173416.GD1709@red-moon>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <32f6e02c-4230-9222-0ee1-54a045e78bd5@synopsys.com>
Date: Wed, 20 Dec 2017 19:47:41 +0000
MIME-Version: 1.0
In-Reply-To: <20171220173416.GD1709@red-moon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hello to all,

Às 5:34 PM de 12/20/2017, Lorenzo Pieralisi escreveu:
> On Wed, Dec 20, 2017 at 12:29:21AM +0100, Niklas Cassel wrote:
>> This is a series that adds:
>> - PCI endpoint mode support in the ARTPEC-6 driver.
>> - ARTPEC-7 SoC support in the ARTPEC-6 driver (the SoCs are very similar).
>> - Small fixes for MSI in designware-ep and designware-host,
>>   needed to get endpoint mode support working for ARTPEC-6.
>> - Cleanups in pci-dra7xx to better prepare for endpoint mode in other
>>   DWC based PCIe drivers.
> 
> Joao, Jingoo,
> 
> Gustavo tested the series and Kishon ACK'ed the relevant patches,
> I need your ACKs on designware patches to queue this series for
> v4.16.
> 
> I am away from tomorrow (noon) till beginning of January which means
> that either I queue this series tomorrow or at -rc6, please do
> chime in if you can.

Sorry, I have been a bit tied up! Already checked each patch related to DWC.
Could anyone from artpec finish the revision, since there are some patches
related to that SoC?

Thanks,
Joao

> 
> Thanks,
> Lorenzo
> 
>> Changes since V5:
>> -Dropped GFP_DMA32 from "PCI: dwc: Use the DMA-API to get the MSI address"
>>  so that we use the exact same GFP flags as before.
>> -Rewrote commit message for "PCI: dwc: Make cpu_addr_fixup take struct
>> dw_pcie as argument" to be more detailed.
>>
>> Niklas Cassel (18):
>>   PCI: dwc: Use the DMA-API to get the MSI address
>>   PCI: designware-ep: dw_pcie_ep_set_msi() should only set MMC bits
>>   PCI: designware-ep: Read-only registers need DBI_RO_WR_EN to be
>>     writable
>>   PCI: designware-ep: Pre-allocate memory for MSI in dw_pcie_ep_init
>>   PCI: designware-ep: Remove static keyword from dw_pcie_ep_reset_bar()
>>   PCI: designware-ep: Add generic function for raising MSI irq
>>   PCI: dwc: dra7xx: Refactor Kconfig and Makefile handling for host/ep
>>     mode
>>   PCI: dwc: dra7xx: Assign pp->ops in dra7xx_add_pcie_port() rather than
>>     in probe
>>   PCI: dwc: dra7xx: Help compiler to remove unused code
>>   PCI: dwc: artpec6: Remove unused defines
>>   PCI: dwc: artpec6: Use BIT and GENMASK macros
>>   PCI: dwc: artpec6: Split artpec6_pcie_establish_link() into smaller
>>     functions
>>   bindings: PCI: artpec: Add support for endpoint mode
>>   PCI: dwc: artpec6: Add support for endpoint mode
>>   PCI: dwc: Make cpu_addr_fixup take struct dw_pcie as argument
>>   PCI: dwc: artpec6: Deassert the core before waiting for PHY
>>   bindings: PCI: artpec: Add support for the ARTPEC-7 SoC
>>   PCI: dwc: artpec6: Add support for the ARTPEC-7 SoC
>>
>>  .../devicetree/bindings/pci/axis,artpec6-pcie.txt  |   5 +-
>>  drivers/pci/dwc/Kconfig                            |  68 +--
>>  drivers/pci/dwc/Makefile                           |   4 +-
>>  drivers/pci/dwc/pci-dra7xx.c                       |  27 +-
>>  drivers/pci/dwc/pcie-artpec6.c                     | 470 ++++++++++++++++++---
>>  drivers/pci/dwc/pcie-designware-ep.c               |  59 ++-
>>  drivers/pci/dwc/pcie-designware-host.c             |  15 +-
>>  drivers/pci/dwc/pcie-designware.c                  |   2 +-
>>  drivers/pci/dwc/pcie-designware.h                  |  22 +-
>>  9 files changed, 554 insertions(+), 118 deletions(-)
>>
>> -- 
>> 2.14.2
>>
