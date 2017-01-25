Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH V7 01/11] iommu/of: Refactor of_iommu_configure() for
 error handling
To: Robin Murphy <robin.murphy@arm.com>,
        Sricharan R <sricharan@codeaurora.org>, will.deacon@arm.com,
        joro@8bytes.org, lorenzo.pieralisi@arm.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-2-git-send-email-sricharan@codeaurora.org>
 <4388779a-0e83-fadc-83f4-98c46c88d42e@semihalf.com>
 <c7bad124-d9f2-0ddf-168f-0b1950d3e1ed@arm.com>
From: Tomasz Nowicki <tn@semihalf.com>
Message-ID: <b350f6d3-dd33-10c4-94ae-a3a7ba5e938a@semihalf.com>
Date: Wed, 25 Jan 2017 19:13:20 +0100
MIME-Version: 1.0
In-Reply-To: <c7bad124-d9f2-0ddf-168f-0b1950d3e1ed@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Robin,

On 25.01.2017 18:35, Robin Murphy wrote:
> Hi Tomasz,
>
> On 25/01/17 17:17, Tomasz Nowicki wrote:
>> Hi Sricharan,
>>
>> On 23.01.2017 17:18, Sricharan R wrote:
>>> From: Robin Murphy <robin.murphy@arm.com>
>>>
>>> In preparation for some upcoming cleverness, rework the control flow in
>>> of_iommu_configure() to minimise duplication and improve the propogation
>>> of errors. It's also as good a time as any to switch over from the
>>> now-just-a-compatibility-wrapper of_iommu_get_ops() to using the generic
>>> IOMMU instance interface directly.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>  drivers/iommu/of_iommu.c | 83
>>> +++++++++++++++++++++++++++++++-----------------
>>>  1 file changed, 53 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
>>> index 0f57ddc..ee49081 100644
>>> --- a/drivers/iommu/of_iommu.c
>>> +++ b/drivers/iommu/of_iommu.c
>>> @@ -96,6 +96,28 @@ int of_get_dma_window(struct device_node *dn, const
>>> char *prefix, int index,
>>>  }
>>>  EXPORT_SYMBOL_GPL(of_get_dma_window);
>>>
>>> +static const struct iommu_ops
>>> +*of_iommu_xlate(struct device *dev, struct of_phandle_args *iommu_spec)
>>> +{
>>> +    const struct iommu_ops *ops;
>>> +    struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
>>> +    int err;
>>> +
>>> +    ops = iommu_get_instance(fwnode);
>>> +    if (!ops || !ops->of_xlate)
>>> +        return NULL;
>>> +
>>> +    err = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
>>> +    if (err)
>>> +        return ERR_PTR(err);
>>> +
>>> +    err = ops->of_xlate(dev, iommu_spec);
>>> +    if (err)
>>> +        return ERR_PTR(err);
>>> +
>>> +    return ops;
>>> +}
>>> +
>>>  static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
>>>  {
>>>      struct of_phandle_args *iommu_spec = data;
>>> @@ -105,10 +127,11 @@ static int __get_pci_rid(struct pci_dev *pdev,
>>> u16 alias, void *data)
>>>  }
>>>
>>>  static const struct iommu_ops
>>> -*of_pci_iommu_configure(struct pci_dev *pdev, struct device_node
>>> *bridge_np)
>>> +*of_pci_iommu_init(struct pci_dev *pdev, struct device_node *bridge_np)
>>>  {
>>>      const struct iommu_ops *ops;
>>>      struct of_phandle_args iommu_spec;
>>> +    int err;
>>>
>>>      /*
>>>       * Start by tracing the RID alias down the PCI topology as
>>> @@ -123,56 +146,56 @@ static int __get_pci_rid(struct pci_dev *pdev,
>>> u16 alias, void *data)
>>>       * bus into the system beyond, and which IOMMU it ends up at.
>>>       */
>>>      iommu_spec.np = NULL;
>>> -    if (of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
>>> -               "iommu-map-mask", &iommu_spec.np, iommu_spec.args))
>>> -        return NULL;
>>> +    err = of_pci_map_rid(bridge_np, iommu_spec.args[0], "iommu-map",
>>> +                 "iommu-map-mask", &iommu_spec.np,
>>> +                 iommu_spec.args);
>>> +    if (err)
>>> +        return ERR_PTR(err);
>>>
>>> -    ops = of_iommu_get_ops(iommu_spec.np);
>>> -    if (!ops || !ops->of_xlate ||
>>> -        iommu_fwspec_init(&pdev->dev, &iommu_spec.np->fwnode, ops) ||
>>> -        ops->of_xlate(&pdev->dev, &iommu_spec))
>>> -        ops = NULL;
>>> +    ops = of_iommu_xlate(&pdev->dev, &iommu_spec);
>>>
>>>      of_node_put(iommu_spec.np);
>>>      return ops;
>>>  }
>>>
>>> -const struct iommu_ops *of_iommu_configure(struct device *dev,
>>> -                       struct device_node *master_np)
>>> +static const struct iommu_ops
>>> +*of_platform_iommu_init(struct device *dev, struct device_node *np)
>>>  {
>>>      struct of_phandle_args iommu_spec;
>>> -    struct device_node *np;
>>>      const struct iommu_ops *ops = NULL;
>>>      int idx = 0;
>>>
>>> -    if (dev_is_pci(dev))
>>> -        return of_pci_iommu_configure(to_pci_dev(dev), master_np);
>>> -
>>>      /*
>>>       * We don't currently walk up the tree looking for a parent IOMMU.
>>>       * See the `Notes:' section of
>>>       * Documentation/devicetree/bindings/iommu/iommu.txt
>>>       */
>>> -    while (!of_parse_phandle_with_args(master_np, "iommus",
>>> -                       "#iommu-cells", idx,
>>> -                       &iommu_spec)) {
>>> -        np = iommu_spec.np;
>>> -        ops = of_iommu_get_ops(np);
>>> -
>>> -        if (!ops || !ops->of_xlate ||
>>> -            iommu_fwspec_init(dev, &np->fwnode, ops) ||
>>> -            ops->of_xlate(dev, &iommu_spec))
>>> -            goto err_put_node;
>>> -
>>> -        of_node_put(np);
>>> +    while (!of_parse_phandle_with_args(np, "iommus", "#iommu-cells",
>>> +                       idx, &iommu_spec)) {
>>> +        ops = of_iommu_xlate(dev, &iommu_spec);
>>> +        of_node_put(iommu_spec.np);
>>>          idx++;
>>> +        if (IS_ERR_OR_NULL(ops))
>>> +            break;
>>>      }
>>>
>>>      return ops;
>>> +}
>>> +
>>> +const struct iommu_ops *of_iommu_configure(struct device *dev,
>>> +                       struct device_node *master_np)
>>> +{
>>> +    const struct iommu_ops *ops;
>>> +
>>> +    if (!master_np)
>>> +        return NULL;
>>> +
>>> +    if (dev_is_pci(dev))
>>> +        ops = of_pci_iommu_init(to_pci_dev(dev), master_np);
>> I gave the whole patch set a try on ThunderX. really_probe() is failing
>> on dma_configure()->of_pci_iommu_init() for each PCI device.
> When you say "failing", do you mean cleanly, or with a crash? I've
> managed to hit __of_match_node() dereferencing NULL from
> of_iommu_xlate() in a horribly complicated chain of events, which I'm
> trying to figure out now, and I wonder if the two might be related.
>

Cleanly, of_pci_iommu_init()->of_pci_map_rid() can't find "iommu-map" 
property for my case. Probably not related to your crash.

Thanks,
Tomasz
