Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46848 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbaKNFKY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 14 Nov 2014 00:10:24 -0500
Message-ID: <54658EBA.9020706@ti.com>
Date: Fri, 14 Nov 2014 10:40:18 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jg1.han@samsung.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dra7xx: Add __init annotation to dra7xx_add_pcie_port()
References: <001e01cff983$c76f0ed0$564d2c70$%han@samsung.com> <20141113165104.GE5064@google.com>
In-Reply-To: <20141113165104.GE5064@google.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Thursday 13 November 2014 10:21 PM, Bjorn Helgaas wrote:
> On Thu, Nov 06, 2014 at 02:37:39PM +0900, Jingoo Han wrote:
>> Add __init annotation to dra7xx_add_pcie_port(), because
>> the dra7xx_add_pcie_port() is called only by dra7xx_pcie_probe()
>> that was already marked as __init. Also, this patch fixes
>> section mismatch warning.
>>
>> WARNING: drivers/pci/host/built-in.o(.text.unlikely+0xcc): Section mismatch in reference from the function dra7xx_add_pcie_port() to
>> the function .init.text:dw_pcie_host_init()
>> The function dra7xx_add_pcie_port() references
>> the function __init dw_pcie_host_init().
>> This is often because dra7xx_add_pcie_port lacks a __init
>> annotation or the annotation of dw_pcie_host_init is wrong.
>>
>> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> Applied to pci/host-dra7xx for v3.19, thanks!
> 
> Kishon, let me know if there's any issue with this.  It looks like a pretty
> obvious fix.

Indeed. Don't see a problem with it.

Thanks
Kishon
> 
>> ---
>> This patch is based on the submitted patch "[PATCH V2] PCI:
>> dra7xx: Add dra7xx prefix before add_pcie_port".
>>
>>  drivers/pci/host/pci-dra7xx.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
>> index 5b4a644..8c69697 100644
>> --- a/drivers/pci/host/pci-dra7xx.c
>> +++ b/drivers/pci/host/pci-dra7xx.c
>> @@ -270,8 +270,8 @@ static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> -static int dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>> -				struct platform_device *pdev)
>> +static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>> +				       struct platform_device *pdev)
>>  {
>>  	int ret;
>>  	struct pcie_port *pp;
>> -- 
>> 1.7.9.5
>>
>>
