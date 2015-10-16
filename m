Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40229 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753882AbbJPIuz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 16 Oct 2015 04:50:55 -0400
Message-ID: <5620BA6B.6040405@arm.com>
Date: Fri, 16 Oct 2015 09:50:51 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>
CC: Ma Jun <majun258@huawei.com>, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/7] platform-msi: Factor out allocation/free of private
 data
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <1444923568-17413-3-git-send-email-marc.zyngier@arm.com> <56208F46.7090402@linux.intel.com>
In-Reply-To: <56208F46.7090402@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16/10/15 06:46, Jiang Liu wrote:
> On 2015/10/15 23:39, Marc Zyngier wrote:
>> As we're going to have multiple paths to allocate/free the
>> platform-msi private data, factor this out into separate
>> utility functions.
>>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>>  drivers/base/platform-msi.c | 84 ++++++++++++++++++++++++++-------------------
>>  1 file changed, 48 insertions(+), 36 deletions(-)
>>
>> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
>> index 6148c78..92666cd 100644
>> --- a/drivers/base/platform-msi.c
>> +++ b/drivers/base/platform-msi.c
>> @@ -189,21 +189,11 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
>>  	return domain;
>>  }
>>  
>> -/**
>> - * platform_msi_domain_alloc_irqs - Allocate MSI interrupts for @dev
>> - * @dev:		The device for which to allocate interrupts
>> - * @nvec:		The number of interrupts to allocate
>> - * @write_msi_msg:	Callback to write an interrupt message for @dev
>> - *
>> - * Returns:
>> - * Zero for success, or an error code in case of failure
>> - */
>> -int platform_msi_domain_alloc_irqs(struct device *dev, unsigned int nvec,
>> -				   irq_write_msi_msg_t write_msi_msg)
>> +static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
>> +					irq_write_msi_msg_t write_msi_msg,
>> +					struct platform_msi_priv_data **data)
> How about making platform_msi_alloc_priv_data() return a pointer
> instead of an int, that may simplify the code a bit.
> 

That's a good point. I could encode the error code in the return pointer
(PTR_ERR).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
