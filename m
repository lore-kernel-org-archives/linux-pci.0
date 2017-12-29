Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38676 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751827AbdL2UxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Dec 2017 15:53:18 -0500
Subject: Re: [PATCH v2 0/9] PCI: Add support to the Cadence PCIe controller
To: Kishon Vijay Abraham I <kishon@ti.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org
Cc: adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <d30e0abe-8b08-b2bf-8410-e0fc2b18cacc@ti.com>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Message-ID: <27684b50-ff08-5238-4cb0-8bc4431211bf@free-electrons.com>
Date: Fri, 29 Dec 2017 21:53:15 +0100
MIME-Version: 1.0
In-Reply-To: <d30e0abe-8b08-b2bf-8410-e0fc2b18cacc@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

Le 28/12/2017 à 14:00, Kishon Vijay Abraham I a écrit :
> Hi Cyrille,
> 
> On Monday 18 December 2017 11:46 PM, Cyrille Pitchen wrote:
>> Hi all,
>>
>> this series of patches adds support to the Cadence PCIe controller.
>> It was tested on a ARM64 platform emulated by a Palladium running the
>> pci-next kernel.
>>
>> The host mode was tested with some PCIe devices connected to the Palladium
>> through a speed-bridge. Some of those devices were a USB host controller
>> and a SATA controller. The PCIe host controller was also tested with a
>> second controller configured in endpoint mode and connected back to back
>> to the first controller.
>>
>> The EndPoint Controller (EPC) driver of this series was tested with the
>> pci-epf-test.c EndPoint Function (EPF) driver and the pcitest userspace
>> program.
> 
> Did you get to test multi function EP?
>

No I didn't: I tested only with a single function to check for regression
but currently I'm not able to test with multiple functions.

With devmem, I've tried to read then write the Physical Function Configuration
Register (offset 0x2c0 in the Local Management registers) to enable
functions other than function 0.

This is the CDNS_PCIE_LM_EP_FUNC_CFG register that the pcie-cadence_ep.c
driver updates in cdns_pcie_ep_write_header() since v2 of the series.

As written in the datasheet, BIT(0) is actually hard-wired to 1, hence
function 0 can't be disabled: that makes sense. However other function
enable bits were read as 0 whereas the datasheet claims they should be set
at power up. Besides, I can't set any of them with devmem.

Actually, I have 2 slightly different datasheets, in the first one I should
have 4 functions but only 2 based on the second datasheet.

Then I guess it's a design parameter used when synthesizing the controller.

So I've asked Cadence whether I've missed or misunderstood something in the
datasheets or whether the IP they provided me with has a single function
for now. I'm waiting for their answers.

Best regards,

Cyrille
 
> Thanks
> Kishon
>>
>> For pci-next, I applied this series on top of Kishon's patch
>> ("PCI: endpoint: Use EPC's device in dma_alloc_coherent/dma_free_coherent")
>> otherwise dma_alloc_coherent() fails when called by pci_epf_alloc_space().
>>
>> Best regards,
>>
>> Cyrille
>>
>> ChangeLog:
>>
>> v1 -> v2:
>> - add new properties in the device-tree bindings: 'cdns,max-outbound-regions'
>>   and 'cdns,no-bar-match-nbits'.
>> - add a new patch to regroup all makefile rules in drivers/pci/Makefile, hence
>>   cleaning drivers/Makefile up.
>> - change the license text to use the recommanded format:
>>   // SPDX-License-Identifier: GPL-2.0
>> - add a new patch updating the API of the EPC library to add support to
>>   multi-function devices.
>> - add a 2 new patches to share more common code between host controller drivers
>> - remove some useless tests
>> - add more comments in both drivers.
>> - fix DT bindings examples
>> - remove useless init of the primary, secondary and sub-ordinate bus numbers in
>>   the PCI configuration space of the root port.
>> - remove cdns_pcie_ep_stop() function and rework cdns_pcie_ep_start() function
>>
>> Cyrille Pitchen (8):
>>   PCI: Regroup all PCI related entries into drivers/pci/Makefile
>>   PCI: OF: Add generic function to parse and allocate PCI resources
>>   PCI: Add generic function to probe PCI host controllers
>>   PCI: Add vendor ID for Cadence
>>   PCI: cadence: Add host driver for Cadence PCIe controller
>>   PCI: endpoint: Add the function number as argument to EPC ops
>>   dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe endpoint
>>     controller
>>   PCI: cadence: Add EndPoint Controller driver for Cadence PCIe
>>     controller
>>
>> Scott Telford (1):
>>   dt-bindings: PCI: cadence: Add DT bindings for Cadence PCIe host
>>     controller
>>
>>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |  23 +
>>  .../bindings/pci/cdns,cdns-pcie-host.txt           |  60 +++
>>  MAINTAINERS                                        |   7 +
>>  drivers/Makefile                                   |   5 +-
>>  drivers/pci/Kconfig                                |   2 +
>>  drivers/pci/Makefile                               |  12 +-
>>  drivers/pci/cadence/Kconfig                        |  33 ++
>>  drivers/pci/cadence/Makefile                       |   4 +
>>  drivers/pci/cadence/pcie-cadence-ep.c              | 531 +++++++++++++++++++++
>>  drivers/pci/cadence/pcie-cadence-host.c            | 330 +++++++++++++
>>  drivers/pci/cadence/pcie-cadence.c                 |  95 ++++
>>  drivers/pci/cadence/pcie-cadence.h                 | 310 ++++++++++++
>>  drivers/pci/dwc/pcie-designware-ep.c               |  20 +-
>>  drivers/pci/endpoint/functions/pci-epf-test.c      |  41 +-
>>  drivers/pci/endpoint/pci-epc-core.c                |  62 ++-
>>  drivers/pci/host/Makefile                          |   2 +
>>  drivers/pci/host/pci-host-common.c                 |  87 +---
>>  drivers/pci/of.c                                   |  51 ++
>>  drivers/pci/probe.c                                |  50 ++
>>  include/linux/pci-epc.h                            |  43 +-
>>  include/linux/pci.h                                |  12 +
>>  include/linux/pci_ids.h                            |   2 +
>>  22 files changed, 1624 insertions(+), 158 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
>>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
>>  create mode 100644 drivers/pci/cadence/Kconfig
>>  create mode 100644 drivers/pci/cadence/Makefile
>>  create mode 100644 drivers/pci/cadence/pcie-cadence-ep.c
>>  create mode 100644 drivers/pci/cadence/pcie-cadence-host.c
>>  create mode 100644 drivers/pci/cadence/pcie-cadence.c
>>  create mode 100644 drivers/pci/cadence/pcie-cadence.h
>>
> 


-- 
Cyrille Pitchen, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
