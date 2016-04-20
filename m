Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [RFC PATCH 06/11] drivers: iommu: make of_xlate() interface DT
 agnostic
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1460654743-7896-7-git-send-email-lorenzo.pieralisi@arm.com>
 <5715EC12.2000009@samsung.com> <20160419113046.GD9571@red-moon>
Cc: iommu@lists.linux-foundation.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Will Deacon <will.deacon@arm.com>,
	Hanjun Guo <hanjun.guo@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Joerg Roedel <joro@8bytes.org>,
	Marc Zyngier <marc.zyngier@arm.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jon Masters <jcm@redhat.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
From: Marek Szyprowski <m.szyprowski@samsung.com>
Message-id: <57172C66.2080602@samsung.com>
Date: Wed, 20 Apr 2016 09:14:46 +0200
MIME-version: 1.0
In-reply-to: <20160419113046.GD9571@red-moon>
Content-type: text/plain; charset=utf-8; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

On 2016-04-19 13:30, Lorenzo Pieralisi wrote:
> Hi Marek,
>
> On Tue, Apr 19, 2016 at 10:28:02AM +0200, Marek Szyprowski wrote:
>> Hello,
>>
>> On 2016-04-14 19:25, Lorenzo Pieralisi wrote:
>>> On systems booting with ACPI, the IOMMU drivers require the same
>>> kind of id mapping carried out with a DT tree through the of_xlate()
>>> API in order to map devices identifiers to IOMMU ones.
>>>
>>> On ACPI systems, since DT nodes are not present (ie struct
>>> device.of_node == NULL), to identify the device requiring the translation
>>> the struct device_node (and the structure used to pass translation
>>> information - struct of_phandle_args - that contains a struct device_node)
>>> cannot be used, so a generic translation structure to be used for IOMMU
>>> mapping should be defined, based on the firmware agnostic fwnode_handle
>>> type.
>>>
>>> This patch mechanically refactors/renames the of_xlate API to make
>>> it DT agnostic, by declaring a new type (struct iommu_fwspec), that
>>> allows the kernel to pass a device identifier (fwnode - which can
>>> represent either a DT node or an IOMMU FW node) and by changing the
>>> of_xlate signature so that it does not take anymore the DT specific
>>> of_phandle_args argument and replaces it with the DT agnostic
>>> iommu_fwspec one.
>>>
>>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Matthias Brugger <matthias.bgg@gmail.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Hanjun Guo <hanjun.guo@linaro.org>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Tomasz Nowicki <tn@semihalf.com>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> I'm not sure if this is the right approach, although I have not enough
>> knowledge on ACPI firmware. Do you plan to rewrite all subsystems to the
>> new "fwspec" based interface? Right now of_xlate is rather common
>> interface used by various subsystems. Maybe it will be much easier to
> Yes, that's a valid concern, when you say "it is rather common" though,
> it seems to me that the of_xlate footprint is still subsystem specific,
> so this patch should be self-contained anyway (granted, doing this
> conversion for a specific subsystem is questionable, I guess that what
> you are asking is, if you do it for IOMMU, why would not you do it for
> other subsystems ?).

I was curious if you want to replace of_xlate() interface in other 
subsystems
like clocks, power domains, regulators, etc. Each of_xlate interface is
specific to particular subsystem, but they all more or less follows the same
style, what makes it easier to understand the code.

> It is an RFC for this specific reason.
>
>> just add acpi_xlate callback and plumb it to the generic code? Maybe later
>> when similar code will be in other subsystems and drivers, it can be
>> unified, having much more real use cases?
> Yes, that's a possibility, it means adding yet another hook into
> the IOMMU drivers, probably a simpler change than this one, I
> posted this code as and RFC to see which direction we want to take
> so further feedback is welcome we can then choose the best approach.
>
> Thanks,
> Lorenzo
>
>>> ---
>>>   drivers/iommu/arm-smmu.c     | 12 +++++++-----
>>>   drivers/iommu/exynos-iommu.c | 11 +++++++----
>>>   drivers/iommu/mtk_iommu.c    | 13 ++++++++-----
>>>   drivers/iommu/of_iommu.c     | 20 ++++++++++++++++++--
>>>   include/linux/iommu.h        | 24 ++++++++++++++++++++----
>>>   5 files changed, 60 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>>> index 6c42770..84bcff7 100644
>>> --- a/drivers/iommu/arm-smmu.c
>>> +++ b/drivers/iommu/arm-smmu.c
>>> @@ -1440,18 +1440,20 @@ out_unlock:
>>>   	return ret;
>>>   }
>>> -static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>> +static int arm_smmu_fw_xlate(struct device *dev, struct iommu_fwspec *args)
>>>   {
>>>   	struct arm_smmu_device *smmu;
>>> -	struct platform_device *smmu_pdev;
>>> +	struct platform_device *smmu_pdev = NULL;
>>> +
>>> +	if (is_of_node(args->fwnode))
>>> +		smmu_pdev = of_find_device_by_node(to_of_node(args->fwnode));
>>> -	smmu_pdev = of_find_device_by_node(args->np);
>>>   	if (!smmu_pdev)
>>>   		return -ENODEV;
>>>   	smmu = platform_get_drvdata(smmu_pdev);
>>> -	return arm_smmu_add_dev_streamid(smmu, dev, args->args[0]);
>>> +	return arm_smmu_add_dev_streamid(smmu, dev, args->param[0]);
>>>   }
>>>   static struct iommu_ops arm_smmu_ops = {
>>> @@ -1468,7 +1470,7 @@ static struct iommu_ops arm_smmu_ops = {
>>>   	.device_group		= arm_smmu_device_group,
>>>   	.domain_get_attr	= arm_smmu_domain_get_attr,
>>>   	.domain_set_attr	= arm_smmu_domain_set_attr,
>>> -	.of_xlate		= arm_smmu_of_xlate,
>>> +	.fw_xlate		= arm_smmu_fw_xlate,
>>>   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>>>   };
>>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>>> index 5ecc86c..84ff5bb 100644
>>> --- a/drivers/iommu/exynos-iommu.c
>>> +++ b/drivers/iommu/exynos-iommu.c
>>> @@ -1250,13 +1250,16 @@ static void exynos_iommu_remove_device(struct device *dev)
>>>   	iommu_group_remove_device(dev);
>>>   }
>>> -static int exynos_iommu_of_xlate(struct device *dev,
>>> -				 struct of_phandle_args *spec)
>>> +static int exynos_iommu_fw_xlate(struct device *dev,
>>> +				 struct iommu_fwspec *args)
>>>   {
>>>   	struct exynos_iommu_owner *owner = dev->archdata.iommu;
>>> -	struct platform_device *sysmmu = of_find_device_by_node(spec->np);
>>> +	struct platform_device *sysmmu = NULL;
>>>   	struct sysmmu_drvdata *data;
>>> +	if (is_of_node(args->fwnode))
>>> +		sysmmu = of_find_device_by_node(to_of_node(args->fwnode));
>>> +
>>>   	if (!sysmmu)
>>>   		return -ENODEV;
>>> @@ -1290,7 +1293,7 @@ static struct iommu_ops exynos_iommu_ops = {
>>>   	.add_device = exynos_iommu_add_device,
>>>   	.remove_device = exynos_iommu_remove_device,
>>>   	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
>>> -	.of_xlate = exynos_iommu_of_xlate,
>>> +	.fw_xlate = exynos_iommu_fw_xlate,
>>>   };
>>>   static bool init_done;
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 929a66a..e08dc0a 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -436,20 +436,23 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>>>   	return data->m4u_group;
>>>   }
>>> -static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>> +static int mtk_iommu_fw_xlate(struct device *dev, struct iommu_fwspec *args)
>>>   {
>>>   	struct mtk_iommu_client_priv *head, *priv, *next;
>>>   	struct platform_device *m4updev;
>>> -	if (args->args_count != 1) {
>>> +	if (!is_of_node(args->fwnode))
>>> +		return -ENODEV;
>>> +
>>> +	if (args->param_count != 1) {
>>>   		dev_err(dev, "invalid #iommu-cells(%d) property for IOMMU\n",
>>> -			args->args_count);
>>> +			args->param_count);
>>>   		return -EINVAL;
>>>   	}
>>>   	if (!dev->archdata.iommu) {
>>>   		/* Get the m4u device */
>>> -		m4updev = of_find_device_by_node(args->np);
>>> +		m4updev = of_find_device_by_node(to_of_node(args->fwnode));
>>>   		of_node_put(args->np);
>>>   		if (WARN_ON(!m4updev))
>>>   			return -EINVAL;
>>> @@ -469,7 +472,7 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>>>   	if (!priv)
>>>   		goto err_free_mem;
>>> -	priv->mtk_m4u_id = args->args[0];
>>> +	priv->mtk_m4u_id = args->param[0];
>>>   	list_add_tail(&priv->client, &head->client);
>>>   	return 0;
>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>> index 910826c..331dd78 100644
>>> --- a/drivers/iommu/of_iommu.c
>>> +++ b/drivers/iommu/of_iommu.c
>>> @@ -135,6 +135,18 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
>>>   	return ops;
>>>   }
>>> +static void of_phandle_args_to_fwspec(struct of_phandle_args *iommu_data,
>>> +				      struct iommu_fwspec *fwspec)
>>> +{
>>> +	int i;
>>> +
>>> +	fwspec->fwnode = iommu_data->np ? &iommu_data->np->fwnode : NULL;
>>> +	fwspec->param_count = iommu_data->args_count;
>>> +
>>> +	for (i = 0; i < iommu_data->args_count; i++)
>>> +		fwspec->param[i] = iommu_data->args[i];
>>> +}
>>> +
>>>   static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>>>   {
>>>   	struct of_phandle_args *iommu_spec = data;
>>> @@ -148,6 +160,7 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
>>>   				     struct device_node *master_np)
>>>   {
>>>   	struct of_phandle_args iommu_spec;
>>> +	struct iommu_fwspec fwspec;
>>>   	struct device_node *np = NULL;
>>>   	struct iommu_ops *ops = NULL;
>>>   	int idx = 0;
>>> @@ -170,8 +183,9 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
>>>   		iommu_spec.np = np;
>>>   		iommu_spec.args_count = 1;
>>> +		of_phandle_args_to_fwspec(&iommu_spec, &fwspec);
>>>   		ops = of_iommu_get_ops(np);
>>> -		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
>>> +		if (!ops || !ops->fw_xlate || ops->fw_xlate(dev, &fwspec))
>>>   			goto err_put_node;
>>>   		of_node_put(np);
>>> @@ -189,7 +203,9 @@ struct iommu_ops *of_iommu_configure(struct device *dev,
>>>   		np = iommu_spec.np;
>>>   		ops = of_iommu_get_ops(np);
>>> -		if (!ops || !ops->of_xlate || ops->of_xlate(dev, &iommu_spec))
>>> +		of_phandle_args_to_fwspec(&iommu_spec, &fwspec);
>>> +
>>> +		if (!ops || !ops->fw_xlate || ops->fw_xlate(dev, &fwspec))
>>>   			goto err_put_node;
>>>   		of_node_put(np);
>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>>> index 0bba25e..5184d81 100644
>>> --- a/include/linux/iommu.h
>>> +++ b/include/linux/iommu.h
>>> @@ -85,6 +85,24 @@ struct iommu_domain {
>>>   	void *iova_cookie;
>>>   };
>>> +#define IOMMU_MAP_SPEC_PARAMS 16
>>> +
>>> +/**
>>> + * struct iommu_fwspec - generic IOMMU specifier structure
>>> + *
>>> + * @fwnode:		Pointer to a firmware-specific descriptor
>>> + * @param_count:	Number of device-specific parameters
>>> + * @param:		Device-specific parameters
>>> + *
>>> + * This structure, directly modeled after of_phandle_args, is used to
>>> + * pass a device-specific description of an IOMMU mapping.
>>> + */
>>> +struct iommu_fwspec {
>>> +	struct fwnode_handle *fwnode;
>>> +	int param_count;
>>> +	u32 param[IOMMU_MAP_SPEC_PARAMS];
>>> +};
>>> +
>>>   enum iommu_cap {
>>>   	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
>>>   					   transactions */
>>> @@ -155,7 +173,7 @@ struct iommu_dm_region {
>>>    * @domain_window_disable: Disable a particular window for a domain
>>>    * @domain_set_windows: Set the number of windows for a domain
>>>    * @domain_get_windows: Return the number of windows for a domain
>>> - * @of_xlate: add OF master IDs to iommu grouping
>>> + * @fw_xlate: add FW master IDs to iommu grouping
>>>    * @pgsize_bitmap: bitmap of supported page sizes
>>>    * @priv: per-instance data private to the iommu driver
>>>    */
>>> @@ -196,9 +214,7 @@ struct iommu_ops {
>>>   	/* Get the number of windows per domain */
>>>   	u32 (*domain_get_windows)(struct iommu_domain *domain);
>>> -#ifdef CONFIG_OF_IOMMU
>>> -	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
>>> -#endif
>>> +	int (*fw_xlate)(struct device *dev, struct iommu_fwspec *args);
>>>   	unsigned long pgsize_bitmap;
>>>   	void *priv;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

