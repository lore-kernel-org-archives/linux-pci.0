Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 0/5] PCI: Add support to the Cadence PCIe controller
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171128155039.GA17154@red-moon>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <adouglas@cadence.com>, <stelford@cadence.com>,
        <dgary@cadence.com>, <kgopi@cadence.com>, <eandrews@cadence.com>,
        <thomas.petazzoni@free-electrons.com>, <sureshp@cadence.com>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <8c6c50fc-47a9-7b93-d826-1dba9c4d09c2@ti.com>
Date: Thu, 30 Nov 2017 12:43:20 +0530
MIME-Version: 1.0
In-Reply-To: <20171128155039.GA17154@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 28 November 2017 09:20 PM, Lorenzo Pieralisi wrote:
> On Thu, Nov 23, 2017 at 04:01:45PM +0100, Cyrille Pitchen wrote:
>> Hi all,
>>
>> this series of patches adds support to the Cadence PCIe controller.
>> It was tested on a ARM64 platform emulated by a Palladium running both
>> linux-next (next-20171123) and pci-next kernels.
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
>>
>> For linux-next, I applied this series on top of Kishon's patch
>> ("PCI: endpoint: Use EPC's device in dma_alloc_coherent/dma_free_coherent")
>> otherwise dma_alloc_coherent() fails when called by pci_epf_alloc_space().
>>
>> Also, I patched drivers/Makefile rather than drivers/pci/Makefile to make
>> the drivers/pci/cadence/pcie-cadence-ep.o linked after

The reason to patch drivers/Makefile should be because pcie-cadence-ep has to
be compiled even when CONFIG_PCI is not enabled. CONFIG_PCI enables host
specific features and ENDPOINT shouldn't depend on CONFIG_PCI.
>> drivers/pci/endpoint/*.o objects, otherwise the built-in pci-cadence-ep
>> driver would be probed before the PCI endpoint framework would have been
>> initialized, which results in a kernel crash.
> 
> Nice :( - isn't there a way to improve this (ie probe deferral or
> registering the EPF bus earlier) ?
> 
>> I guess this is the reason why the "pci/dwc" line was also put in
>> drivers/Makefile, right after the "pci/endpoint" line.
> 
> Or probably the other way around - see commit 5e8cb4033807
> 
> @Kishon, thoughts ?

Lorenzo, ordering Makefile is one way to initialize EP core before other
drivers. the other way is to have PCI EP core have a different initcall level..
subsys_initcall??

Thanks
Kishon
