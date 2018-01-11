Return-Path: <SRS0=/bLX=EG=broadcom.com=ray.jui@kernel.org>
Return-Path: <SRS0=/bLX=EG=broadcom.com=ray.jui@kernel.org>
Subject: Re: [PATCH] PCI: iproc: Fix NULL pointer dereference for BCMA
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, Rafal Milecki <rafal@milecki.pl>,
 stable@vger.kernel.org
References: <1515527140-24964-1-git-send-email-ray.jui@broadcom.com>
 <20180111171450.GA12148@red-moon>
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <576164e1-fffd-7ba0-5e35-9f0dd501df8e@broadcom.com>
Date: Thu, 11 Jan 2018 12:37:28 -0800
MIME-Version: 1.0
In-Reply-To: <20180111171450.GA12148@red-moon>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 1/11/2018 9:15 AM, Lorenzo Pieralisi wrote:
> On Tue, Jan 09, 2018 at 11:45:40AM -0800, Ray Jui wrote:
>> With the inbound DMA mapping supported added, the iProc PCIe driver
>> parses DT property "dma-ranges" through call to
>> "of_pci_dma_range_parser_init". In the case of BCMA, this results in a
>> NULL pointer deference due to a missing of_node.
>>
>> Fix this by adding a guard in pcie-iproc-platform.c to only enable the
>> inbound DMA mapping logic when DT property "dma-ranges" is present
>>
>> fixes: dd9d4e7498de3 ("PCI: iproc: Add inbound DMA mapping support")
> 
> s/fixes/Fixes >

Will fix.

>> Reported-by: Rafał Miłecki <rafal@milecki.pl>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>> Tested-by: Rafał Miłecki <rafal@milecki.pl>
>> Cc: <stable@vger.kernel.org> # 4.10+
>> ---
>>   drivers/pci/host/pcie-iproc-platform.c | 3 +++
>>   drivers/pci/host/pcie-iproc.c          | 8 +++++---
>>   drivers/pci/host/pcie-iproc.h          | 2 ++
>>   3 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/host/pcie-iproc-platform.c b/drivers/pci/host/pcie-iproc-platform.c
>> index a5073a9..235c545 100644
>> --- a/drivers/pci/host/pcie-iproc-platform.c
>> +++ b/drivers/pci/host/pcie-iproc-platform.c
>> @@ -92,6 +92,9 @@ static int iproc_pcie_pltfm_probe(struct platform_device *pdev)
>>   		pcie->need_ob_cfg = true;
>>   	}
>>   
>> +	if (of_property_read_bool(np, "dma-ranges"))
>> +		pcie->need_ib_cfg = true;
> 
> Nit:
> 	pci->need_ib_cfg = of_property_read_bool(np, "dma-ranges"));
> 
> will do. Add a comment to it to explain why it is needed.

Will fix.

> 
> Please update the patch, send a v2 and I will merge it.

Okay will send out v2 with comments from you addressed. Thanks!

> 
> Thanks,
> Lorenzo
> 
