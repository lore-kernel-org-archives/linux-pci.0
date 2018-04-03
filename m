Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:31393 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752397AbeDCKxq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2018 06:53:46 -0400
Subject: Re: [PATCH 1/8] bindings: PCI: designware: Example update
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
 <33aa86ee667e8b435db080b8c683cb5df1bd6544.1522235224.git.gustavo.pimentel@synopsys.com>
 <fa001440-0dfe-b84a-e5ef-9285043b5ede@ti.com>
 <36a36857-2d79-2c2d-198d-a3b65cafc768@synopsys.com>
 <c5ffa7d6-40b1-1702-c0fd-9ebb1b4197f8@ti.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <170b150d-d2c6-fee8-17f7-12a3107c13ff@ti.com>
Date: Tue, 3 Apr 2018 16:23:33 +0530
MIME-Version: 1.0
In-Reply-To: <c5ffa7d6-40b1-1702-c0fd-9ebb1b4197f8@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Tuesday 03 April 2018 04:22 PM, Kishon Vijay Abraham I wrote:
> 
> 
> On Tuesday 03 April 2018 04:03 PM, Gustavo Pimentel wrote:
>> Hi Kishon,
>>
>> On 02/04/2018 06:23, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Wednesday 28 March 2018 05:08 PM, Gustavo Pimentel wrote:
>>>> Changes the IP registers size to accommodate the ATU unroll space.
>>>>
>>>> Replaces "ctrlreg" reg-name by "dbi" to be coherent with similar drivers.
>>>>
>>>> Replaces the pcie base address example by a real pcie base address in use.
>>>>
>>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 12 ++++++------
>>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>>>> index 1da7ade..6300762 100644
>>>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>>>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>>>> @@ -1,7 +1,8 @@
>>>>  * Synopsys DesignWare PCIe interface
>>>>  
>>>>  Required properties:
>>>> -- compatible: should contain "snps,dw-pcie" to identify the core.
>>>> +- compatible:
>>>> +	"snps,dw-pcie" for RC mode;
>>>
>>> I think irrespective of RC mode or EP mode, "snps,dw-pcie" can be used to
>>> identify the pcie core?
>>
>> I guess so. What you suggest? I was just folling the same guideline present
>> here: https://lkml.org/lkml/2017/11/3/310
> 
> Okay, I think you should have
> "snps,dw-pcie-rc", "snps,dw-pcie" for RC mode;
> 
> and in the later patch
> "snps,dw-pcie-ep", "snps,dw-pcie" for EP mode;
> 
>>
>>>>  - reg: Should contain the configuration address space.
>>>>  - reg-names: Must be "config" for the PCIe configuration space.
>>>>      (The old way of getting the configuration address space from "ranges"
>>>> @@ -41,11 +42,11 @@ EP mode:
>>>>  
>>>>  Example configuration:
>>>>  
>>>> -	pcie: pcie@dffff000 {
>>>> +	pcie: pcie@dfc00000 {
>>>>  		compatible = "snps,dw-pcie";
>>>> -		reg = <0xdffff000 0x1000>, /* Controller registers */
>>>> -		      <0xd0000000 0x2000>; /* PCI config space */
>>>> -		reg-names = "ctrlreg", "config";
>>>> +		reg = <0xdfc00000 0x302000>, /* IP registers */
>>>
>>> which version of synopsys IP is this. I think the ideal thing to do here is to
>>> have a separate register space for iATU.
>>
>> I also agree with that. The unroll iATU was introduced on Synopsys IP version
>> 4.80 and the kernel patch was release on 2016-08-10
>> https://patchwork.ozlabs.org/patch/657796/
>> However a separate register space for iATU implies some extra code do handle it
>> (and of course some tests) that don't fit into this patch series, in my point of
>> view. Can this task enter in the backlog in order to be done in another patch
>> series?
> 
> Yes sure. I think we should also make sure existing binding doesn't break.

And IMO we should have a new compatible "snps,dw-pcie-4.80" in order to enable
iATU unroll.

Thanks
Kishon
