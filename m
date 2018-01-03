Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:21320 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeACJOc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jan 2018 04:14:32 -0500
Subject: Re: [PATCH v2 0/9] PCI: Add support to the Cadence PCIe controller
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <d30e0abe-8b08-b2bf-8410-e0fc2b18cacc@ti.com>
 <27684b50-ff08-5238-4cb0-8bc4431211bf@free-electrons.com>
CC: <adouglas@cadence.com>, <stelford@cadence.com>,
        <dgary@cadence.com>, <kgopi@cadence.com>, <eandrews@cadence.com>,
        <thomas.petazzoni@free-electrons.com>, <sureshp@cadence.com>,
        <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d170202a-4860-7ff5-a6a3-df696ce23729@ti.com>
Date: Wed, 3 Jan 2018 14:44:18 +0530
MIME-Version: 1.0
In-Reply-To: <27684b50-ff08-5238-4cb0-8bc4431211bf@free-electrons.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Saturday 30 December 2017 02:23 AM, Cyrille Pitchen wrote:
> Hi Kishon,
> 
> Le 28/12/2017 à 14:00, Kishon Vijay Abraham I a écrit :
>> Hi Cyrille,
>>
>> On Monday 18 December 2017 11:46 PM, Cyrille Pitchen wrote:
>>> Hi all,
>>>
>>> this series of patches adds support to the Cadence PCIe controller.
>>> It was tested on a ARM64 platform emulated by a Palladium running the
>>> pci-next kernel.
>>>
>>> The host mode was tested with some PCIe devices connected to the Palladium
>>> through a speed-bridge. Some of those devices were a USB host controller
>>> and a SATA controller. The PCIe host controller was also tested with a
>>> second controller configured in endpoint mode and connected back to back
>>> to the first controller.
>>>
>>> The EndPoint Controller (EPC) driver of this series was tested with the
>>> pci-epf-test.c EndPoint Function (EPF) driver and the pcitest userspace
>>> program.
>>
>> Did you get to test multi function EP?
>>
> 
> No I didn't: I tested only with a single function to check for regression
> but currently I'm not able to test with multiple functions.
> 
> With devmem, I've tried to read then write the Physical Function Configuration
> Register (offset 0x2c0 in the Local Management registers) to enable
> functions other than function 0.
> 
> This is the CDNS_PCIE_LM_EP_FUNC_CFG register that the pcie-cadence_ep.c
> driver updates in cdns_pcie_ep_write_header() since v2 of the series.
> 
> As written in the datasheet, BIT(0) is actually hard-wired to 1, hence
> function 0 can't be disabled: that makes sense. However other function
> enable bits were read as 0 whereas the datasheet claims they should be set
> at power up. Besides, I can't set any of them with devmem.
> 
> Actually, I have 2 slightly different datasheets, in the first one I should
> have 4 functions but only 2 based on the second datasheet.
> 
> Then I guess it's a design parameter used when synthesizing the controller.
> 
> So I've asked Cadence whether I've missed or misunderstood something in the
> datasheets or whether the IP they provided me with has a single function
> for now. I'm waiting for their answers.

hmm.. It would be nice to have multi function tested since it would both
validate multi function support of PCI EP core and the cadence multi-function
itself.

Thanks
Kishon
