Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([198.47.19.12]:34335 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753520AbcI0LgD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Sep 2016 07:36:03 -0400
Subject: Re: [RFC PATCH 08/11] pci: controller: dra7xx: Add EP mode support
To: Rob Herring <robh@kernel.org>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-9-git-send-email-kishon@ti.com>
 <20160923145259.GA28285@rob-hp-laptop>
CC: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jingoo Han <jingoohan1@gmail.com>, <hch@infradead.org>,
        <Joao.Pinto@synopsys.com>, <mingkai.hu@nxp.com>,
        <m-karicheri2@ti.com>, Pratyush Anand <pratyush.anand@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joao Pinto <jpinto@synopsys.com>, <nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <57EA5962.90700@ti.com>
Date: Tue, 27 Sep 2016 17:04:58 +0530
MIME-Version: 1.0
In-Reply-To: <20160923145259.GA28285@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 23 September 2016 08:22 PM, Rob Herring wrote:
> On Wed, Sep 14, 2016 at 10:42:04AM +0530, Kishon Vijay Abraham I wrote:
>> The PCIe controller integrated in dra7xx SoCs is capable of operating
>> in endpoint mode. Add support for dra7xx SoCs to operate in endpoint
>> mode.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |   30 ++-
>>  drivers/pci/controller/Kconfig                   |   21 +++
>>  drivers/pci/controller/pci-dra7xx.c              |  211 +++++++++++++++++++---
>>  3 files changed, 225 insertions(+), 37 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> index 60e2516..b0e76f6 100644
>> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> @@ -1,17 +1,22 @@
>>  TI PCI Controllers
>>  
>>  PCIe Designware Controller
>> - - compatible: Should be "ti,dra7-pcie""
>> - - reg : Two register ranges as listed in the reg-names property
>> - - reg-names : The first entry must be "ti-conf" for the TI specific registers
>> -	       The second entry must be "rc-dbics" for the designware pcie
>> -	       registers
>> -	       The third entry must be "config" for the PCIe configuration space
>> + - compatible: Should be "ti,dra7-pcie" for RC
>> +	       Should be "ti,dra7-pcie-ep" for EP
>>   - phys : list of PHY specifiers (used by generic PHY framework)
>>   - phy-names : must be "pcie-phy0", "pcie-phy1", "pcie-phyN".. based on the
>>  	       number of PHYs as specified in *phys* property.
>>   - ti,hwmods : Name of the hwmod associated to the pcie, "pcie<X>",
>>  	       where <X> is the instance number of the pcie from the HW spec.
>> + - num-lanes as specified in ../designware-pcie.txt
>> +
>> +HOST MODE
>> +=========
>> + - reg : Two register ranges as listed in the reg-names property
>> + - reg-names : The first entry must be "ti-conf" for the TI specific registers
>> +	       The second entry must be "rc-dbics" for the designware pcie
>> +	       registers
>> +	       The third entry must be "config" for the PCIe configuration space
>>   - interrupts : Two interrupt entries must be specified. The first one is for
>>  		main interrupt line and the second for MSI interrupt line.
>>   - #address-cells,
>> @@ -19,13 +24,24 @@ PCIe Designware Controller
>>     #interrupt-cells,
>>     device_type,
>>     ranges,
>> -   num-lanes,
>>     interrupt-map-mask,
>>     interrupt-map : as specified in ../designware-pcie.txt
>>  
>>  Optional Property:
>>   - gpios : Should be added if a gpio line is required to drive PERST# line
> 
> Don't you need gpios as the input side of GPIO outputs in RC mode? Or 
> for EP mode they are all handled by h/w?

I couldn't find any mention of the gpios being used in EP mode. I'll check this
again.

Thanks
Kishon
