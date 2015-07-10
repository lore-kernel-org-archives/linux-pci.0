Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54035 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932406AbbGJOuy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 10 Jul 2015 10:50:54 -0400
Message-ID: <559FDBC8.1020403@ti.com>
Date: Fri, 10 Jul 2015 20:20:48 +0530
From: Kishon Vijay Abraham I <kishon@ti.com>
MIME-Version: 1.0
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<pratyush.anand@gmail.com>, <linux-omap@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nsekhar@ti.com>
Subject: Re: [PATCH 3/3] PCI: host: pci-dra7xx: add pm support to pci dra7xx
References: <1435921425-15121-1-git-send-email-kishon@ti.com> <1435921425-15121-4-git-send-email-kishon@ti.com> <55967A3A.7000907@ti.com>
In-Reply-To: <55967A3A.7000907@ti.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Friday 03 July 2015 05:34 PM, Grygorii Strashko wrote:
> Hi Kishon,
> 
> On 07/03/2015 02:03 PM, Kishon Vijay Abraham I wrote:
>> Add PM support to pci-dra7xx so that PCI clocks can be disabled
>> during suspend and enabled back during resume without affecting
>> PCI functionality.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>   drivers/pci/host/pci-dra7xx.c |   74 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/drivers/pci/host/pci-dra7xx.c b/drivers/pci/host/pci-dra7xx.c
>> index d8b6d66..1f5c039 100644
>> --- a/drivers/pci/host/pci-dra7xx.c
>> +++ b/drivers/pci/host/pci-dra7xx.c
>> @@ -433,6 +433,79 @@ static int __exit dra7xx_pcie_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>
>> +#ifdef CONFIG_PM_SLEEP
> 
> [...]
> 
>> +
>> +static const struct dev_pm_ops dra7xx_pcie_pm_ops = {
>> +	.suspend_noirq = dra7xx_pcie_suspend_noirq,
>> +	.suspend = dra7xx_pcie_suspend,
>> +	.resume_noirq = dra7xx_pcie_resume_noirq,
>> +	.resume = dra7xx_pcie_resume,
> 
> Could you use here SET_SYSTEM_SLEEP_PM_OPS()
> and SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() macro, pls?

sure!

Thanks
Kishon
