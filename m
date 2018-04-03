Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 3/8] bindings: PCI: designware: Add support for the EP in
 designware driver
To: Kishon Vijay Abraham I <kishon@ti.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
 <dd582bfc2780679b7a092d23547c316234a84c34.1522235224.git.gustavo.pimentel@synopsys.com>
 <405911c8-fffc-5bd7-76c5-f7aabde3b7bc@ti.com>
 <87ba8936-e870-f52b-2ff1-0aea90d0a25c@synopsys.com>
 <f94889e3-ba6f-5aba-d0ab-85db5d434cc9@ti.com>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <331e32c4-a39b-b5a6-6fbd-6eef7ca4b27c@synopsys.com>
Date: Tue, 3 Apr 2018 14:20:45 +0100
MIME-Version: 1.0
In-Reply-To: <f94889e3-ba6f-5aba-d0ab-85db5d434cc9@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On 03/04/2018 11:55, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 03 April 2018 04:13 PM, Gustavo Pimentel wrote:
>> Hi Kishon,
>>
>> On 02/04/2018 06:35, Kishon Vijay Abraham I wrote:
>>>
>>>
>>> On Wednesday 28 March 2018 05:08 PM, Gustavo Pimentel wrote:
>>>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>
>>> Please add a commit message.
>>
>> Ok. I'll add. Thanks for noticing it.
>>
>>>> ---
>>>>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 13 +++++++++++++
>>>>  1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>>>> index 6300762..4bb2e08 100644
>>>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>>>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>>>> @@ -3,6 +3,7 @@
>>>>  Required properties:
>>>>  - compatible:
>>>>  	"snps,dw-pcie" for RC mode;
>>>> +	"snps,dw-pcie-ep" for EP mode;
>>>>  - reg: Should contain the configuration address space.
>>>>  - reg-names: Must be "config" for the PCIe configuration space.
>>>>      (The old way of getting the configuration address space from "ranges"
>>>> @@ -56,3 +57,15 @@ Example configuration:
>>>>  		#interrupt-cells = <1>;
>>>>  		num-lanes = <1>;
>>>>  	};
>>>> +or
>>>> +	pcie_ep: pcie_ep@dfc00000 {
>>>> +		compatible = "snps,dw-pcie-ep";
>>>> +		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
>>>> +		      <0xdfc01000 0x0001000>, /* IP registers 2 */
>>>
>>> Doesn't this have iATU unroll space?
>>
>> I don't think EP has it, but I'm no expert on this matter. Can you provide me
>> some example of having iATU unroll space mapping would be useful in EP scope?
> 
> I'm not sure. I thought if the dwc3 core version is 4.80, then it'll have a
> separate ATU space irrespective of RC mode or EP mode.

As replied on patch 1, let's leave out  any reference of iATU unroll to avoid
any confusion. Agree?

> 
> Thanks
> Kishon
> 

Regards,
Gustavo
