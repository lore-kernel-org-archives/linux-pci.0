Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753632AbeGFJcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Jul 2018 05:32:42 -0400
Subject: Re: [PATCH v6 00/11] Add MSI-X support on pcitest tool
To: Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "adouglas@cadence.com" <adouglas@cadence.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
 <77139978-65cc-b954-bc61-bebf3bcc67ac@synopsys.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <284a6871-4687-e437-6876-3cd1e0329cbb@ti.com>
Date: Fri, 6 Jul 2018 15:02:25 +0530
MIME-Version: 1.0
In-Reply-To: <77139978-65cc-b954-bc61-bebf3bcc67ac@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On Friday 06 July 2018 02:24 PM, Gustavo Pimentel wrote:
> Hi,
> 
> Just a gentle reminder.

sorry for the delay. I've now reviewed the pending patches.

Thanks
Kishon

> 
> Thanks.
> 
> On 21/06/2018 17:01, Gustavo Pimentel wrote:
>> Patch series made against Lorenzo's master branch.
>>
>> Add MSI-X support on pcitest tool.
>>
>> Add new callbacks methods and handlers to trigger the MSI-X interrupts
>> on the EP DesignWare IP driver.
>>
>> Allow to set/get MSI-X EP maximum capability number.
>>
>> Rework on set/get and triggering MSI methods on EP DesignWare IP driver.
>>
>> Add a new input parameter (msix) to pcitest tool to test MSI-X feature.
>>
>> Update the pcitest.sh script to support MSI-X feature tests.
>>
>> Gustavo Pimentel (11):
>>   PCI: endpoint: Add MSI-X interfaces
>>   PCI: Update xxx_pcie_ep_raise_irq() and pci_epc_raise_irq() signatures
>>   PCI: dwc: Add MSI-X callbacks handler
>>   PCI: dwc: Rework MSI callbacks handler
>>   PCI: dwc: Add legacy interrupt callback handler
>>   pci-epf-test/pci_endpoint_test: Cleanup PCI_ENDPOINT_TEST memspace
>>   pci-epf-test/pci_endpoint_test: Use irq_type module parameter
>>   pci-epf-test/pci_endpoint_test: Add MSI-X support
>>   pci_endpoint_test: Add 2 ioctl commands
>>   tools: PCI: Add MSI-X support
>>   PCI: endpoint: Add MSI set maximum restriction.
>>
>>  Documentation/ioctl/ioctl-number.txt              |   1 +
>>  Documentation/misc-devices/pci-endpoint-test.txt  |   6 +
>>  drivers/misc/pci_endpoint_test.c                  | 259 ++++++++++++++++------
>>  drivers/pci/controller/dwc/pci-dra7xx.c           |   2 +-
>>  drivers/pci/controller/dwc/pcie-artpec6.c         |   2 +-
>>  drivers/pci/controller/dwc/pcie-designware-ep.c   | 205 +++++++++++++++--
>>  drivers/pci/controller/dwc/pcie-designware-plat.c |   7 +-
>>  drivers/pci/controller/dwc/pcie-designware.h      |  31 ++-
>>  drivers/pci/controller/pcie-cadence-ep.c          |   3 +-
>>  drivers/pci/controller/pcie-rockchip-ep.c         |   2 +-
>>  drivers/pci/endpoint/functions/pci-epf-test.c     |  81 +++++--
>>  drivers/pci/endpoint/pci-ep-cfs.c                 |  24 ++
>>  drivers/pci/endpoint/pci-epc-core.c               |  68 +++++-
>>  include/linux/pci-epc.h                           |  15 +-
>>  include/linux/pci-epf.h                           |   1 +
>>  include/uapi/linux/pcitest.h                      |   3 +
>>  tools/pci/pcitest.c                               |  51 ++++-
>>  tools/pci/pcitest.sh                              |  15 ++
>>  18 files changed, 644 insertions(+), 132 deletions(-)
>>
> 
