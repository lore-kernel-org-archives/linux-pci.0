Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42534 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdK3SpT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Nov 2017 13:45:19 -0500
Subject: Re: [PATCH 0/5] PCI: Add support to the Cadence PCIe controller
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        adouglas@cadence.com, stelford@cadence.com, dgary@cadence.com,
        kgopi@cadence.com, eandrews@cadence.com,
        thomas.petazzoni@free-electrons.com, sureshp@cadence.com,
        nsekhar@ti.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        devicetree@vger.kernel.org
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <20171128155039.GA17154@red-moon>
 <8c6c50fc-47a9-7b93-d826-1dba9c4d09c2@ti.com>
 <20171130181819.GD12096@red-moon>
From: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Message-ID: <a02af401-2eb8-dc34-6f3c-092f04ec2636@free-electrons.com>
Date: Thu, 30 Nov 2017 19:45:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171130181819.GD12096@red-moon>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

Le 30/11/2017 à 19:18, Lorenzo Pieralisi a écrit :
> On Thu, Nov 30, 2017 at 12:43:20PM +0530, Kishon Vijay Abraham I wrote:
> 
> [...]
> 
>>>> For linux-next, I applied this series on top of Kishon's patch
>>>> ("PCI: endpoint: Use EPC's device in dma_alloc_coherent/dma_free_coherent")
>>>> otherwise dma_alloc_coherent() fails when called by pci_epf_alloc_space().
>>>>
>>>> Also, I patched drivers/Makefile rather than drivers/pci/Makefile to make
>>>> the drivers/pci/cadence/pcie-cadence-ep.o linked after
>>
>> The reason to patch drivers/Makefile should be because pcie-cadence-ep has to
>> be compiled even when CONFIG_PCI is not enabled. CONFIG_PCI enables host
>> specific features and ENDPOINT shouldn't depend on CONFIG_PCI.
>>>> drivers/pci/endpoint/*.o objects, otherwise the built-in pci-cadence-ep
>>>> driver would be probed before the PCI endpoint framework would have been
>>>> initialized, which results in a kernel crash.
>>>
>>> Nice :( - isn't there a way to improve this (ie probe deferral or
>>> registering the EPF bus earlier) ?
>>>
>>>> I guess this is the reason why the "pci/dwc" line was also put in
>>>> drivers/Makefile, right after the "pci/endpoint" line.
>>>
>>> Or probably the other way around - see commit 5e8cb4033807
>>>
>>> @Kishon, thoughts ?
>>
>> Lorenzo, ordering Makefile is one way to initialize EP core before
> 
> Makefile ordering is fragile, I do not like relying on it.
> 
>> other drivers. the other way is to have PCI EP core have a different
>> initcall level..  subsys_initcall??
> 
> Yes, registering the bus at eg postcore_initcall() as PCI does should do
> (if that's the problem this is solving) but still, the code must not
> crash if the ordering is not correct, we have to fix this regardless.
> 
> I would appreciate if Cyrille can debug the cause of the kernel crash
> so that we can fix it in the longer term.
> 

I had the crash kernel few weeks ago hence I have to test again to confirm
but if I remember correctly it was a NULL pointer dereferencing crash:

cdns_pcie_ep_probe()
|
+--> devm_pci_epc_create()
     |
     +--> __devm_pci_ep_create()
          |
          +--> __pci_epc_create()
	       |
	       +--> pci_ep_cfs_add_epc_group()
	            |
		    | /*
		    |  * Here controllers_group is still NULL because
		    |  * pci_ep_cfs_init() has not been called yet.
		    |  */
		    +--> configfs_register_group(controllers_group, ...)
		         |
			 +--> link_group()
			      /* Dereferencing NULL pointer */

Best regards,

Cyrille

> Thanks,
> Lorenzo
> 


-- 
Cyrille Pitchen, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
