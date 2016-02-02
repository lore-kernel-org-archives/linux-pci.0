Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:54989 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932649AbcBBRSI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2016 12:18:08 -0500
Subject: Re: [PATCH v7 0/2] adding PCI support to AXS10x
To: Bjorn Helgaas <helgaas@kernel.org>,
	Joao Pinto <Joao.Pinto@synopsys.com>
References: <cover.1454349430.git.jpinto@synopsys.com>
 <20160202171437.GD11085@localhost>
CC: <Vineet.Gupta1@synopsys.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-snps-arc@lists.infradead.org>,
	<CARLOS.PALMINHA@synopsys.com>, <Alexey.Brodkin@synopsys.com>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<arnd@arndb.de>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <56B0E4C6.6040200@synopsys.com>
Date: Tue, 2 Feb 2016 17:17:58 +0000
MIME-Version: 1.0
In-Reply-To: <20160202171437.GD11085@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,
Thanks. Could you please send me the git URL for me to give it a try?

Joao

On 2/2/2016 5:14 PM, Bjorn Helgaas wrote:
> On Mon, Feb 01, 2016 at 06:07:43PM +0000, Joao Pinto wrote:
>> This patch set has the goal to add suppport for DesignWare PCIe RC in ARC
>> AXS10x. It includes the necessary tweaks to the ARC architecture, 
>> necessary tweaks to the PCI subsystem and a new driver (pcie-synopsys).
>> This new driver will be used extensively in the PCIe RC Prototyping Kit.
>>
>> The patches were produced against Bjorn Helgaas' repository. It was properly
>> tested in an IP Prototyping Kit.
>>
>> Joao Pinto (2):
>>   PCI support added to ARC
>>   add new platform driver for PCI RC
>>
>>  .../devicetree/bindings/pci/pcie-synopsys.txt      |  33 +++
>>  MAINTAINERS                                        |   7 +
>>  arch/arc/Kconfig                                   |  23 ++
>>  arch/arc/include/asm/dma.h                         |   5 +
>>  arch/arc/include/asm/io.h                          |   9 +
>>  arch/arc/include/asm/pci.h                         |  31 +++
>>  arch/arc/kernel/Makefile                           |   1 +
>>  arch/arc/kernel/pcibios.c                          |  23 ++
>>  arch/arc/plat-axs10x/Kconfig                       |   1 +
>>  drivers/pci/Makefile                               |   1 +
>>  drivers/pci/host/Kconfig                           |   8 +
>>  drivers/pci/host/Makefile                          |   1 +
>>  drivers/pci/host/pcie-synopsys.c                   | 257 +++++++++++++++++++++
>>  13 files changed, 400 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pci/pcie-synopsys.txt
>>  create mode 100644 arch/arc/include/asm/pci.h
>>  create mode 100644 arch/arc/kernel/pcibios.c
>>  create mode 100644 drivers/pci/host/pcie-synopsys.c
> 
> I applied these to pci/host-synopsys, and I plan to merge them for v4.5.
> 
> Bjorn
> 

