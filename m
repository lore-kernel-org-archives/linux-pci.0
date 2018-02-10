Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.134]:37826 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeBJIKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Feb 2018 03:10:37 -0500
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI: rockchip: Add rockchip,rk3399-pcie-host
 compatible
To: Rob Herring <robh@kernel.org>
References: <1517971650-61555-1-git-send-email-shawn.lin@rock-chips.com>
 <1517971650-61555-5-git-send-email-shawn.lin@rock-chips.com>
 <20180209233857.osoyfvst3waa54b3@rob-hp-laptop>
From: Shawn Lin <shawn.lin@rock-chips.com>
Message-ID: <37408ad8-f962-a411-3987-ee86c55b7c25@rock-chips.com>
Date: Sat, 10 Feb 2018 16:10:28 +0800
MIME-Version: 1.0
In-Reply-To: <20180209233857.osoyfvst3waa54b3@rob-hp-laptop>
Content-Type: text/plain; charset=gbk; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Rob,

On 2018/2/10 7:38, Rob Herring wrote:
> On Wed, Feb 07, 2018 at 10:47:28AM +0800, Shawn Lin wrote:
>> To avoid confusion when folks use this controller as endponint
> 
> s/endponint/endpoint/
> 
>> mode, we add rockchip,rk3399-pcie-host to clearly state that
>> it's driver for host here. And rename/update the document to
>> reflect this fact.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   .../bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt}         | 3 ++-
>>   drivers/pci/rockchip/pcie-rockchip-host.c                              | 1 +
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>   rename Documentation/devicetree/bindings/pci/{rockchip-pcie.txt => rockchip-pcie-host.txt} (98%)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
>> similarity index 98%
>> rename from Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> rename to Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
>> index af34c65..f2f3091 100644
>> --- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
>> +++ b/Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
>> @@ -5,7 +5,8 @@ Required properties:
>>   - #size-cells: Size representation for root ports, set to <2>
>>   - #interrupt-cells: specifies the number of cells needed to encode an
>>   		interrupt source. The value must be 1.
>> -- compatible: Should contain "rockchip,rk3399-pcie"
>> +- compatible: Should contain "rockchip,rk3399-pcie" or
>> +	"rockchip,rk3399-pcie-host"
> 
> I don't think this is necessary. Endpoint is generally the exception and
> having "endpoint" or "ep" in the endpoint compatible should be enough.
> 

I was following the convention of other controllers that support
both of RC mode and EP mode, for instance, pcie-cadence-{host, ep}.txt

Sure, I agree that endpoint is generally the exception, so will drop
this in v2.

>>   - reg: Two register ranges as listed in the reg-names property
>>   - reg-names: Must include the following names
>>   	- "axi-base"
>> diff --git a/drivers/pci/rockchip/pcie-rockchip-host.c b/drivers/pci/rockchip/pcie-rockchip-host.c
>> index f5b0492..efb740d 100644
>> --- a/drivers/pci/rockchip/pcie-rockchip-host.c
>> +++ b/drivers/pci/rockchip/pcie-rockchip-host.c
>> @@ -1120,6 +1120,7 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
>>   
>>   static const struct of_device_id rockchip_pcie_of_match[] = {
>>   	{ .compatible = "rockchip,rk3399-pcie", },
>> +	{ .compatible = "rockchip,rk3399-pcie-host", },
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(of, rockchip_pcie_of_match);
>> -- 
>> 1.9.1
>>
>>
> 
> 
> 
