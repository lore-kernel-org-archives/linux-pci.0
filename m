Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([37.128.190.40]:39691 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbaA0N1S (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jan 2014 08:27:18 -0500
Message-ID: <52E65EAD.9000909@codethink.co.uk>
Date: Mon, 27 Jan 2014 13:27:09 +0000
From: Ben Dooks <ben.dooks@codethink.co.uk>
MIME-Version: 1.0
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC: linux-kernel@lists.codethink.co.uk,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/8] pci-rcar-gen2: add of match table
References: <1390754945-28142-1-git-send-email-ben.dooks@codethink.co.uk> <1390754945-28142-2-git-send-email-ben.dooks@codethink.co.uk> <52E6559D.6090708@cogentembedded.com>
In-Reply-To: <52E6559D.6090708@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/01/14 12:48, Sergei Shtylyov wrote:
> Hello.
>
> On 26-01-2014 20:48, Ben Dooks wrote:
>
>> Add OF match table for pci-rcar-gen2 driver for device tree support.
>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: linux-pci@vger.kernel.org
>> Cc: linux-sh@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> ---
>>   drivers/pci/host/pci-rcar-gen2.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>
>> diff --git a/drivers/pci/host/pci-rcar-gen2.c
>> b/drivers/pci/host/pci-rcar-gen2.c
>> index ceec147..ea65bac 100644
>> --- a/drivers/pci/host/pci-rcar-gen2.c
>> +++ b/drivers/pci/host/pci-rcar-gen2.c
>> @@ -311,9 +311,17 @@ static int __init rcar_pci_probe(struct
>> platform_device *pdev)
>>       return rcar_pci_add_controller(priv);
>>   }
>>
>> +static struct of_device_id rcar_pci_of_match[] = {
>> +    { .compatible = "renesas,pci-r8a7790", },
>
>     Why only H2 SoC, if the driver is for both Gen2 SoCs?

I can add a "renesas,pci-rcar-gen2" as a fallback match however
I've not got anything other than an r8a7790 to test on. Also the
compatible properties are preferably named after the soc.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
