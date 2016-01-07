Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34293 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbcAGGVw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 7 Jan 2016 01:21:52 -0500
Subject: Re: [PATCH 2/2] pci: host: pci-dra7xx: Enable x2 mode support
To: Rob Herring <robh@kernel.org>
References: <1452077393-25880-1-git-send-email-kishon@ti.com>
 <1452077393-25880-3-git-send-email-kishon@ti.com>
 <20160106141324.GA24713@rob-hp-laptop>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	<linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<nsekhar@ti.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <568E03ED.9030207@ti.com>
Date: Thu, 7 Jan 2016 11:51:33 +0530
MIME-Version: 1.0
In-Reply-To: <20160106141324.GA24713@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Wednesday 06 January 2016 07:43 PM, Rob Herring wrote:
> On Wed, Jan 06, 2016 at 04:19:53PM +0530, Kishon Vijay Abraham I wrote:
>> Perform syscon configurations to get x2 mode to working in DRA74x and
>> DRA72x. Also add a new compatible string to dfferentiate
>> DRA72x and DRA74x, since b1c0 mask is different for both these platforms.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  Documentation/devicetree/bindings/pci/ti-pci.txt |    8 ++-
>>  drivers/pci/host/pci-dra7xx.c                    |   81 +++++++++++++++++++++-
>>  2 files changed, 86 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> index 60e2516..0b10e84 100644
>> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
>> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
>> @@ -1,7 +1,9 @@
>>  TI PCI Controllers
>>  
>>  PCIe Designware Controller
>> - - compatible: Should be "ti,dra7-pcie""
>> + - compatible: "ti,dra7-pcie" is deprecated
>> +	       Should be "ti,dra746-pcie" for DRA74x
>> +	       Should be "ti,dra726-pcie" for DRA72x
>>   - reg : Two register ranges as listed in the reg-names property
>>   - reg-names : The first entry must be "ti-conf" for the TI specific registers
>>  	       The second entry must be "rc-dbics" for the designware pcie
>> @@ -14,6 +16,10 @@ PCIe Designware Controller
>>  	       where <X> is the instance number of the pcie from the HW spec.
>>   - interrupts : Two interrupt entries must be specified. The first one is for
>>  		main interrupt line and the second for MSI interrupt line.
>> + - syscon-lane-conf : phandle/offset pair. Phandle to the system control module and the
>> +   register offset to specify 1 lane or 2 lane.
>> + - syscon-lane-sel : phandle/offset pair. Phandle to the system control module and the
>> +   register offset to specify lane selection.
> 
> These should have a ti prefix.

Okay. Will fix that and post a new version.

Thanks
Kishon
> 
>>   - #address-cells,
>>     #size-cells,
>>     #interrupt-cells,
