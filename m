Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37093 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDIPV6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 11:21:58 -0400
Received: by mail-lf0-f68.google.com with SMTP id m200-v6so7151171lfm.4
        for <linux-pci@vger.kernel.org>; Mon, 09 Apr 2018 08:21:58 -0700 (PDT)
Subject: Re: [PATCH 4/4] pcie-rcar: factor out rcar_pcie_hw_init() call
To: Simon Horman <horms@verge.net.au>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
 <4462b4d1-1e56-d6d2-ad38-8f02405d1d96@cogentembedded.com>
 <20180409110404.5qjnvaig7ng2cyzt@verge.net.au>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0abaa14d-08fb-6c41-1479-220250ae0048@cogentembedded.com>
Date: Mon, 9 Apr 2018 18:21:55 +0300
MIME-Version: 1.0
In-Reply-To: <20180409110404.5qjnvaig7ng2cyzt@verge.net.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/09/2018 02:04 PM, Simon Horman wrote:

>> We now have rcar_pcie_hw_init_{h1|gen2|gen3}() differing only in the PCIe
>> PHY init code and all ending with a call to rcar_pcie_hw_init(), thus it
>> makes  sense to move that call into the driver's probe() method and then
>> rename those functions to rcar_pcie_phy_init_{h1|gen2|gen3}() -- doing
>> this saves 48 bytes of object code (AArch64 gcc 4.8.5)...
> 
> I'm not sure the churn is worth it, but if you do then that is find by me.

   s/find/fine/? :-)
   I think it's worth it -- makes the code follow more closely the manuals
where the only gen1/2/3 specific init is PHY related.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>>  drivers/pci/host/pcie-rcar.c |   42 ++++++++++++++++++++++--------------------
>>  1 file changed, 22 insertions(+), 20 deletions(-)
>>
>> Index: pci/drivers/pci/host/pcie-rcar.c
>> ===================================================================
>> --- pci.orig/drivers/pci/host/pcie-rcar.c
>> +++ pci/drivers/pci/host/pcie-rcar.c
[...]
>> @@ -1082,17 +1078,18 @@ static int rcar_pcie_parse_map_dma_range
>>  }
>>  
>>  static const struct of_device_id rcar_pcie_of_match[] = {
>> -	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
>> +	{ .compatible = "renesas,pcie-r8a7779",
>> +	  .data = rcar_pcie_phy_init_h1 },
>>  	{ .compatible = "renesas,pcie-r8a7790",
>> -	  .data = rcar_pcie_hw_init_gen2 },
>> +	  .data = rcar_pcie_phy_init_gen2 },
>>  	{ .compatible = "renesas,pcie-r8a7791",
>> -	  .data = rcar_pcie_hw_init_gen2 },
>> +	  .data = rcar_pcie_phy_init_gen2 },
>>  	{ .compatible = "renesas,pcie-rcar-gen2",
>> -	  .data = rcar_pcie_hw_init_gen2 },
>> +	  .data = rcar_pcie_phy_init_gen2 },
>>  	{ .compatible = "renesas,pcie-r8a7795",
>> -	  .data = rcar_pcie_hw_init_gen3 },
>> +	  .data = rcar_pcie_phy_init_gen3 },
>>  	{ .compatible = "renesas,pcie-rcar-gen3",
>> -	  .data = rcar_pcie_hw_init_gen3 },
>> +	  .data = rcar_pcie_phy_init_gen3 },
>>  	{},
> 
> I would avoid the line wrapping here, but its up to you.

   I didn't want to break the 80-colums limit; and then again, wanted to keep the initializers alike... 

>> @@ -1140,7 +1137,7 @@ static int rcar_pcie_probe(struct platfo
>>  	struct rcar_pcie *pcie;
>>  	unsigned int data;
>>  	int err;
>> -	int (*hw_init_fn)(struct rcar_pcie *);
>> +	int (*phy_init_fn)(struct rcar_pcie *);
> 
> Looking at this I wonder if we also need a phy_cleanup() code or
> similar.

   Makes sense -- iff we start supporting PM?..

[...]

MBR, Sergei
