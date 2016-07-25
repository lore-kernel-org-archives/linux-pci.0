Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34655 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbcGYPvE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Jul 2016 11:51:04 -0400
Subject: Re: [RFC PATCH v3 05/13] drivers: iommu: make iommu_fwspec OF
 agnostic
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1469013815-24380-6-git-send-email-lorenzo.pieralisi@arm.com>
 <1499f802-5f98-b0c0-d3aa-dabcac81e84e@arm.com>
 <20160725154103.GA28507@red-moon>
Cc: iommu@lists.linux-foundation.org,
	Will Deacon <will.deacon@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <856415fc-b9bf-ca44-cc70-85d454574e53@arm.com>
Date: Mon, 25 Jul 2016 16:51:00 +0100
MIME-Version: 1.0
In-Reply-To: <20160725154103.GA28507@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 25/07/16 16:41, Lorenzo Pieralisi wrote:
[...]
>>> diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
>>> index 308791f..2362232 100644
>>> --- a/include/linux/of_iommu.h
>>> +++ b/include/linux/of_iommu.h
>>> @@ -15,13 +15,8 @@ extern void of_iommu_init(void);
>>>  extern const struct iommu_ops *of_iommu_configure(struct device *dev,
>>>  					struct device_node *master_np);
>>>  
>>> -struct iommu_fwspec {
>>> -	const struct iommu_ops	*iommu_ops;
>>> -	struct device_node	*iommu_np;
>>> -	void			*iommu_priv;
>>> -	unsigned int		num_ids;
>>> -	u32			ids[];
>>> -};
>>> +void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
>>> +const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
>>
>> Is there some reason we need to retain the existing definitions of
>> these? I was assuming we'd be able to move the entire implementation
>> over to the fwspec code and leave behind nothing more than trivial
>> wrappers, e.g.:
>>
>> #define of_iommu_get_ops(np) iommu_fwspec_get_ops(&(np)->fwnode_handle)
> 
> Yep, that's exactly what I did but then I was bitten by config
> dependencies. If we implement of_iommu_get/set_ops() as wrappers,
> we have to compile iommu_fwspec_get/set_ops() on arches that may
> not have struct dev_archdata.iommu, unless we introduce yet another
> config symbol to avoid compiling that code (see eg iommu_fwspec_init(),
> we can't compile it on eg x86 even though we do need of_iommu_get_ops()
> on it - so iommu_fwspec_get_ops(), that lives in the same compilation
> unit as eg iommu_fwspec_init()).
> 
> So short answer is: there is no reason apart from dev_archdata.iommu
> being arch specific, if we were able to move iommu_fwspec to generic
> code (ie struct device, somehow) I would certainly get rid of this
> stupid code duplication (or as I said I can add a config entry for
> that, more ideas are welcome).

OK, given Rob's comment as well, I guess breaking that dependency is to
everyone's benefit. Since it's quite closely related, how about if we
follow the arch_setup_dma_ops() pattern with an
arch_{get,set}_iommu_fwspec(dev) type thing?

Robin.

> 
> Thanks,
> Lorenzo
> 
>>
>> Robin.
>>
>>>  #else
>>>  
>>> @@ -39,17 +34,14 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
>>>  	return NULL;
>>>  }
>>>  
>>> -struct iommu_fwspec;
>>> -
>>> -#endif	/* CONFIG_OF_IOMMU */
>>> +static inline void of_iommu_set_ops(struct device_node *np,
>>> +				    const struct iommu_ops *ops)
>>> +{ }
>>>  
>>> -int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np);
>>> -void iommu_fwspec_free(struct device *dev);
>>> -int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
>>> -struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
>>> +static inline const struct iommu_ops *
>>> +of_iommu_get_ops(struct device_node *np) { return NULL; }
>>>  
>>> -void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
>>> -const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
>>> +#endif	/* CONFIG_OF_IOMMU */
>>>  
>>>  extern struct of_device_id __iommu_of_table;
>>>  
>>>
>>
> 

