Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54402 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755047AbbGTHye (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 20 Jul 2015 03:54:34 -0400
Message-ID: <55ACA936.3060800@arm.com>
Date: Mon, 20 Jul 2015 08:54:30 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: "majun (F)" <majun258@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v4 09/19] drivers: base: Add MSI domain support for non-PCI
 devices
References: <1436962613-17359-1-git-send-email-marc.zyngier@arm.com> <1436962613-17359-10-git-send-email-marc.zyngier@arm.com> <55AC5DF3.8090502@huawei.com>
In-Reply-To: <55AC5DF3.8090502@huawei.com>
Content-Type: text/plain; charset=gbk
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 20/07/15 03:33, majun (F) wrote:
> 
> 
> ÔÚ 2015/7/15 20:16, Marc Zyngier Ð´µÀ:
>> With the msi_list and the msi_domain properties now being at the
>> generic device level, it is starting to be relatively easy to offer
>> a generic way of providing non-PCI MSIs.
>>
> [...]
>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index c10ec56..b55cf63 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -18,6 +18,11 @@ struct pci_dev;
>>  void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>>  void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
>>  
>> +typedef void (*irq_write_msi_msg_t)(struct msi_desc *desc,
>> +				    struct msi_msg *msg);
>> +
>> +struct platform_msi_priv_data;
>> +
>>  struct msi_desc {
>>  	struct list_head		list;
>>  	unsigned int			irq;
>> @@ -42,6 +47,10 @@ struct msi_desc {
>>  				void __iomem *mask_base;
>>  			};
>>  		};
>> +		struct {
>> +			struct platform_msi_priv_data *platform_msi_priv_data;
>> +			u16 msi_index;
>> +		};
>>  	};
>>  };
>>  
> When I add this patch in linux 4.2.rc2, this part is rejected. So I added this part
> myself. But there is compiling errors.

[...]

Did you read this crucial part of the cover letter:

<quote>
[...]
Patches are on top of 4.2-rc2 and Jiang Liu's series, and available at:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
irq/npci-msi-v2
</quote>

Without Jiang Liu's series as a prerequisite, it is not surprising
nothing applies, let alone compile...

	M.
-- 
Jazz is not dead. It just smells funny...
