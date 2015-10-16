Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5620B9F0.50203@arm.com>
Date: Fri, 16 Oct 2015 09:48:48 +0100
From: Marc Zyngier <marc.zyngier@arm.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>
CC: Ma Jun <majun258@huawei.com>, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 4/7] genirq/msi: Make the .prepare callback reusable
References: <1444923568-17413-1-git-send-email-marc.zyngier@arm.com> <1444923568-17413-5-git-send-email-marc.zyngier@arm.com> <56208EE0.1030604@linux.intel.com>
In-Reply-To: <56208EE0.1030604@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 16/10/15 06:45, Jiang Liu wrote:
> On 2015/10/15 23:39, Marc Zyngier wrote:
> <snit>
>> +int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
>> +			    int nvec, msi_alloc_info_t *arg)
>> +{
>> +	struct msi_domain_info *info = domain->host_data;
>> +	struct msi_domain_ops *ops = info->ops;
>> +	int ret;
>> +
>> +	ret = ops->msi_check(domain, info, dev);
>> +	if (ret == 0)
>> +		ret = ops->msi_prepare(domain, dev, nvec, arg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> Seems a simple "return ret" is enough:)

Ah! yes! ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
