Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:56430 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbeDJLL7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Apr 2018 07:11:59 -0400
Subject: Re: [PATCH 3/8] bindings: PCI: designware: Add support for the EP in
 designware driver
To: Rob Herring <robh@kernel.org>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <cover.1522235224.git.gustavo.pimentel@synopsys.com>
 <dd582bfc2780679b7a092d23547c316234a84c34.1522235224.git.gustavo.pimentel@synopsys.com>
 <20180409191233.l2s5hnrq7gejrmq6@rob-hp-laptop>
From: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <8336d41a-daa7-ea11-9182-74b2ceeda159@synopsys.com>
Date: Tue, 10 Apr 2018 12:11:01 +0100
MIME-Version: 1.0
In-Reply-To: <20180409191233.l2s5hnrq7gejrmq6@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

On 09/04/2018 20:12, Rob Herring wrote:
> On Wed, Mar 28, 2018 at 12:38:33PM +0100, Gustavo Pimentel wrote:
>> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
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
> 
> pcie-ep@...
> 
> Or what others have used. We should define a standard name in the DT 
> spec for this.
> 

By looking to [1] and [2], I think I should maintain the pcie name instead of
pcie-ep.

[1] ->
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/pci/ti-pci.txt
[2] ->
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt

Thanks for noticing it.

>> +		compatible = "snps,dw-pcie-ep";
>> +		reg = <0xdfc00000 0x0001000>, /* IP registers 1 */
>> +		      <0xdfc01000 0x0001000>, /* IP registers 2 */
>> +		      <0xd0000000 0x2000000>; /* Configuration space */
>> +		reg-names = "dbi", "dbi2", "addr_space";
>> +		device_type = "pci";
>> +		num-ib-windows = <6>;
>> +		num-ob-windows = <2>;
>> +		num-lanes = <1>;
>> +	};
>> -- 
>> 2.7.4
>>
>>

Regards,
Gustavo
