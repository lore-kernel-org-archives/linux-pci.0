Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:54843 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755254AbeDCKo0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Apr 2018 06:44:26 -0400
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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
Message-ID: <87ba8936-e870-f52b-2ff1-0aea90d0a25c@synopsys.com>
Date: Tue, 3 Apr 2018 11:43:32 +0100
MIME-Version: 1.0
In-Reply-To: <405911c8-fffc-5bd7-76c5-f7aabde3b7bc@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Kishon,

On 02/04/2018 06:35, Kishon Vijay Abraham I wrote:
> 
> 
> On Wednesday 28 March 2018 05:08 PM, Gustavo Pimentel wrote:
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> 
> Please add a commit message.

Ok. I'll add. Thanks for noticing it.

>> ---
>>  Documentation/devicetree/bindings/pci/designware-pcie.txt | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> index 6300762..4bb2e08 100644
>> --- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
>> @@ -3,6 +3,7 @@
>>  Required properties:
>>  - compatible:
>>  	"snps,dw-pcie" for RC mode;
>> +	"snps,dw-pcie-ep" for EP mode;
>>  - reg: Should contain the configuration address space.
>>  - reg-names: Must be "config" for the PCIe configuration space.
>>      (The old way of getting the configuration address space from "ranges"
>> @@ -56,3 +57,15 @@ Example configuration:
>>  		#interrupt-cells = <1>;
>>  		num-lanes = <1>;
>>  	};
>> +or
>> +	pcie_ep: pcie_ep@dfc00000 {
>> +		compatible = "snps,dw-pcie-ep";
>> +		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
>> +		      <0xdfc01000 0x0001000>, /* IP registers 2 */
> 
> Doesn't this have iATU unroll space?

I don't think EP has it, but I'm no expert on this matter. Can you provide me
some example of having iATU unroll space mapping would be useful in EP scope?

> 
> Thanks
> Kishon
> 

Regards,
Gustavo
