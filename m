Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:59928 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544AbcAKKiq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jan 2016 05:38:46 -0500
Subject: Re: [PATCH v3 0/2] adding PCI support to AXS10x
To: Bjorn Helgaas <helgaas@kernel.org>,
	Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1450694884.git.jpinto@synopsys.com>
 <20160108203358.GI5354@localhost>
CC: <Vineet.Gupta1@synopsys.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56938609.5050304@synopsys.com>
Date: Mon, 11 Jan 2016 10:38:01 +0000
MIME-Version: 1.0
In-Reply-To: <20160108203358.GI5354@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Bjorn,

On 1/8/2016 8:33 PM, Bjorn Helgaas wrote:
> Hi Joao,
> 
> On Mon, Dec 21, 2015 at 03:44:14PM +0000, Joao Pinto wrote:
>> This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
>> AXS10x. It includes the necessary tweaks to the ARC architecture, necessary
>> tweaks to the PCI subsystem and a new driver (pcie-snpsdev).
>> This new driver will be used extensively in the PCIe RC Prototyping Kit.
>>
>> The patches were produced against Bjorn Helgaas' repository. It was properly
>> tested in an IP Prototyping Kit.
>>
>> Joao Pinto (2):
>>   PCI support added to ARC
>>   add new platform driver for PCI RC
>>
>>  .../devicetree/bindings/pci/pcie-snpsdev.txt       |  33 +++
>>  MAINTAINERS                                        |   7 +
>>  arch/arc/Kconfig                                   |  23 ++
>>  arch/arc/include/asm/dma.h                         |   5 +
>>  arch/arc/include/asm/io.h                          |  10 +
>>  arch/arc/include/asm/pci.h                         |  43 ++++
>>  arch/arc/kernel/Makefile                           |   1 +
>>  arch/arc/kernel/pcibios.c                          |  55 ++++
>>  arch/arc/mm/ioremap.c                              |  10 +-
>>  arch/arc/plat-axs10x/Kconfig                       |   1 +
>>  drivers/pci/Makefile                               |   1 +
>>  drivers/pci/host/Kconfig                           |   5 +
>>  drivers/pci/host/Makefile                          |   1 +
>>  drivers/pci/host/pcie-designware.c                 |  11 +
>>  drivers/pci/host/pcie-designware.h                 |   1 +
>>  drivers/pci/host/pcie-snpsdev.c                    | 286 +++++++++++++++++++++
>>  16 files changed, 492 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-snpsdev.txt
>>  create mode 100644 arch/arc/include/asm/pci.h
>>  create mode 100644 arch/arc/kernel/pcibios.c
>>  create mode 100644 drivers/pci/host/pcie-snpsdev.c
> 
> This failed the kbuild test, so I'm waiting for a refresh to fix that.
> 
> Bjorn
> 

I am going to check what happened and send you an update ASAP.

Joao
