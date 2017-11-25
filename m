Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11220 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdKYTlY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Nov 2017 14:41:24 -0500
Subject: Re: [PATCH 01/10] genirq: Export irq_set_msi_desc()
To: Thomas Gleixner <tglx@linutronix.de>
CC: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <bhelgaas@google.com>, <rjw@rjwysocki.net>, <vidyas@nvidia.com>,
        <kthota@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
 <1511538800-8275-2-git-send-email-mmaddireddy@nvidia.com>
 <alpine.DEB.2.20.1711250050520.2316@nanos>
From: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <600a7b65-670e-b164-913c-99e18ae593d2@nvidia.com>
Date: Sun, 26 Nov 2017 01:11:05 +0530
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1711250050520.2316@nanos>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 25-Nov-17 5:25 AM, Thomas Gleixner wrote:
> On Fri, 24 Nov 2017, Manikanta Maddireddy wrote:
> 
> Please CC the proper mailing list for irq related changes.
> 
>> PCI bus support MSI interrupts, allow PCI host driver to set MSI descriptor
>> data for an irq.
> 
> This is not really an explanation why this export is needed.
> 
> Thanks,
> 
> 	tglx
> 
Updated the commit log with why Tegra PCIe driver is using this function in V2.
Please review.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>  kernel/irq/chip.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 5a2ef92c2782..bfbd17386bc4 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -136,6 +136,7 @@ int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
>>  {
>>  	return irq_set_msi_desc_off(irq, 0, entry);
>>  }
>> +EXPORT_SYMBOL(irq_set_msi_desc);
>>  
>>  /**
>>   *	irq_set_chip_data - set irq chip data for an irq
>> -- 
>> 2.1.4
>>
>>
