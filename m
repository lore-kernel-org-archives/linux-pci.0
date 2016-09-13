Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 13 Sep 2016 14:55:17 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux-foundation.org,
        Will Deacon <will.deacon@arm.com>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 05/14] drivers: iommu: make iommu_fwspec OF agnostic
Message-ID: <20160913135517.GA2334@red-moon>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
 <20160909142343.13314-6-lorenzo.pieralisi@arm.com>
 <4e8110c4-edf3-15db-206c-b83794f138a0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4e8110c4-edf3-15db-206c-b83794f138a0@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 02:38:35PM +0100, Robin Murphy wrote:
> >  static int arm_smmu_match_node(struct device *dev, void *data)
> >  {
> > -	return dev->of_node == data;
> > +	struct fwnode_handle *fwnode;
> > +
> > +	fwnode = dev->of_node ? &dev->of_node->fwnode : dev->fwnode;
> > +
> > +	return fwnode == data;
> >  }
> 
> Maybe we should hoist the dev_fwnode() helper from property.c up to
> property.h so we can just have "return dev_fwnode(dev) == data;" here?

Yes, that's one way of doing it. The other would be initializing
dev->fwnode to &dev->of_node->fwnode in the DT probe path but first
I need to understand why that is not done in the first place.

[...]

> > +int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
> > +{
> > +	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
> > +	size_t size;
> > +
> > +	if (!fwspec)
> > +		return -EINVAL;
> > +
> > +	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + 1]);
> > +	fwspec = krealloc(fwspec, size, GFP_KERNEL);
> > +	if (!fwspec)
> > +		return -ENOMEM;
> > +
> > +	while (num_ids--)
> > +		fwspec->ids[fwspec->num_ids++] = *ids++;
> 
> You've still got the +1 bug and incomprehensible loop from the old code
> here, rather than the fixed version being removed below. Although now
> that I've taken the plunge and done it properly in core code from the
> outset, that should hopefully become moot.

Gah sorry, rebase mistake. I will wait for the dust to settle before
churning out a new series, it is hard to respin without a stable
base (hopefully your series will make this patch useless).

Thanks !
Lorenzo

> Robin.
> 
> > +
> > +	arch_set_iommu_fwspec(dev, fwspec);
> > +	return 0;
> > +}
> > +
> > +inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
> > +{
> > +	return arch_get_iommu_fwspec(dev);
> > +}
> > diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> > index 38669b8..ab3c069 100644
> > --- a/drivers/iommu/of_iommu.c
> > +++ b/drivers/iommu/of_iommu.c
> > @@ -96,45 +96,6 @@ int of_get_dma_window(struct device_node *dn, const char *prefix, int index,
> >  }
> >  EXPORT_SYMBOL_GPL(of_get_dma_window);
> >  
> > -struct of_iommu_node {
> > -	struct list_head list;
> > -	struct device_node *np;
> > -	const struct iommu_ops *ops;
> > -};
> > -static LIST_HEAD(of_iommu_list);
> > -static DEFINE_SPINLOCK(of_iommu_lock);
> > -
> > -void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops)
> > -{
> > -	struct of_iommu_node *iommu = kzalloc(sizeof(*iommu), GFP_KERNEL);
> > -
> > -	if (WARN_ON(!iommu))
> > -		return;
> > -
> > -	of_node_get(np);
> > -	INIT_LIST_HEAD(&iommu->list);
> > -	iommu->np = np;
> > -	iommu->ops = ops;
> > -	spin_lock(&of_iommu_lock);
> > -	list_add_tail(&iommu->list, &of_iommu_list);
> > -	spin_unlock(&of_iommu_lock);
> > -}
> > -
> > -const struct iommu_ops *of_iommu_get_ops(struct device_node *np)
> > -{
> > -	struct of_iommu_node *node;
> > -	const struct iommu_ops *ops = NULL;
> > -
> > -	spin_lock(&of_iommu_lock);
> > -	list_for_each_entry(node, &of_iommu_list, list)
> > -		if (node->np == np) {
> > -			ops = node->ops;
> > -			break;
> > -		}
> > -	spin_unlock(&of_iommu_lock);
> > -	return ops;
> > -}
> > -
> >  static int __get_pci_rid(struct pci_dev *pdev, u16 alias, void *data)
> >  {
> >  	struct of_phandle_args *iommu_spec = data;
> > @@ -226,57 +187,3 @@ static int __init of_iommu_init(void)
> >  	return 0;
> >  }
> >  postcore_initcall_sync(of_iommu_init);
> > -
> > -int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np)
> > -{
> > -	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
> > -
> > -	if (fwspec)
> > -		return 0;
> > -
> > -	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
> > -	if (!fwspec)
> > -		return -ENOMEM;
> > -
> > -	fwspec->iommu_np = of_node_get(iommu_np);
> > -	fwspec->iommu_ops = of_iommu_get_ops(iommu_np);
> > -	arch_set_iommu_fwspec(dev, fwspec);
> > -	return 0;
> > -}
> > -
> > -void iommu_fwspec_free(struct device *dev)
> > -{
> > -	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
> > -
> > -	if (fwspec) {
> > -		of_node_put(fwspec->iommu_np);
> > -		kfree(fwspec);
> > -	}
> > -}
> > -
> > -int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
> > -{
> > -	struct iommu_fwspec *fwspec = arch_get_iommu_fwspec(dev);
> > -	size_t size;
> > -	int i;
> > -
> > -	if (!fwspec)
> > -		return -EINVAL;
> > -
> > -	size = offsetof(struct iommu_fwspec, ids[fwspec->num_ids + num_ids]);
> > -	fwspec = krealloc(fwspec, size, GFP_KERNEL);
> > -	if (!fwspec)
> > -		return -ENOMEM;
> > -
> > -	for (i = 0; i < num_ids; i++)
> > -		fwspec->ids[fwspec->num_ids + i] = ids[i];
> > -
> > -	fwspec->num_ids += num_ids;
> > -	arch_set_iommu_fwspec(dev, fwspec);
> > -	return 0;
> > -}
> > -
> > -inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
> > -{
> > -	return arch_get_iommu_fwspec(dev);
> > -}
> > diff --git a/include/linux/iommu-fwspec.h b/include/linux/iommu-fwspec.h
> > new file mode 100644
> > index 0000000..f88b635
> > --- /dev/null
> > +++ b/include/linux/iommu-fwspec.h
> > @@ -0,0 +1,70 @@
> > +#ifndef __IOMMU_FWSPEC_H
> > +#define __IOMMU_FWSPEC_H
> > +
> > +#include <linux/device.h>
> > +#include <linux/iommu.h>
> > +
> > +struct iommu_fwspec {
> > +	const struct iommu_ops	*iommu_ops;
> > +	struct fwnode_handle	*iommu_fwnode;
> > +	void			*iommu_priv;
> > +	unsigned int		num_ids;
> > +	u32			ids[];
> > +};
> > +
> > +#ifdef CONFIG_IOMMU_FWSPEC
> > +int iommu_fwspec_init(struct device *dev,
> > +		      struct fwnode_handle *iommu_fwnode);
> > +void iommu_fwspec_free(struct device *dev);
> > +int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
> > +struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
> > +
> > +void fwspec_iommu_set_ops(struct fwnode_handle *fwnode,
> > +			  const struct iommu_ops *ops);
> > +const struct iommu_ops *fwspec_iommu_get_ops(struct fwnode_handle *fwnode);
> > +
> > +#ifdef CONFIG_HAVE_IOMMU_FWSPEC
> > +#include <asm/iommu-fwspec.h>
> > +#else /* !CONFIG_HAVE_IOMMU_FWSPEC */
> > +static inline void arch_set_iommu_fwspec(struct device *dev,
> > +					 struct iommu_fwspec *fwspec) {}
> > +
> > +static inline struct iommu_fwspec *
> > +arch_get_iommu_fwspec(struct device *dev) { return NULL; }
> > +#endif
> > +#else /* CONFIG_IOMMU_FWSPEC */
> > +static inline int iommu_fwspec_init(struct device *dev,
> > +				    struct fwnode_handle *iommu_fwnode)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline void iommu_fwspec_free(struct device *dev)
> > +{
> > +}
> > +
> > +static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
> > +				       int num_ids)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline struct iommu_fwspec *dev_iommu_fwspec(struct device *dev)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline void fwspec_iommu_set_ops(struct fwnode_handle *fwnode,
> > +					const struct iommu_ops *ops)
> > +{
> > +}
> > +
> > +static inline const struct iommu_ops *
> > +fwspec_iommu_get_ops(struct fwnode_handle *fwnode)
> > +{
> > +	return NULL;
> > +}
> > +
> > +#endif /* CONFIG_IOMMU_FWSPEC */
> > +
> > +#endif /* __IOMMU_FWSPEC_H */
> > diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> > index 358db49..4b02861 100644
> > --- a/include/linux/of_iommu.h
> > +++ b/include/linux/of_iommu.h
> > @@ -3,6 +3,7 @@
> >  
> >  #include <linux/device.h>
> >  #include <linux/iommu.h>
> > +#include <linux/iommu-fwspec.h>
> >  #include <linux/of.h>
> >  
> >  #ifdef CONFIG_OF_IOMMU
> > @@ -14,14 +15,6 @@ extern int of_get_dma_window(struct device_node *dn, const char *prefix,
> >  extern const struct iommu_ops *of_iommu_configure(struct device *dev,
> >  					struct device_node *master_np);
> >  
> > -struct iommu_fwspec {
> > -	const struct iommu_ops	*iommu_ops;
> > -	struct device_node	*iommu_np;
> > -	void			*iommu_priv;
> > -	unsigned int		num_ids;
> > -	u32			ids[];
> > -};
> > -
> >  #else
> >  
> >  static inline int of_get_dma_window(struct device_node *dn, const char *prefix,
> > @@ -36,28 +29,19 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
> >  {
> >  	return NULL;
> >  }
> > -
> > -struct iommu_fwspec;
> > -
> >  #endif	/* CONFIG_OF_IOMMU */
> >  
> > -int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np);
> > -void iommu_fwspec_free(struct device *dev);
> > -int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
> > -struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
> > -
> > -#ifdef CONFIG_HAVE_IOMMU_FWSPEC
> > -#include <asm/iommu-fwspec.h>
> > -#else /* !CONFIG_HAVE_IOMMU_FWSPEC */
> > -static inline void arch_set_iommu_fwspec(struct device *dev,
> > -					 struct iommu_fwspec *fwspec) {}
> > -
> > -static inline struct iommu_fwspec *
> > -arch_get_iommu_fwspec(struct device *dev) { return NULL; }
> > -#endif
> > +static inline void of_iommu_set_ops(struct device_node *np,
> > +				    const struct iommu_ops *ops)
> > +{
> > +	fwspec_iommu_set_ops(&np->fwnode, ops);
> > +}
> >  
> > -void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
> > -const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
> > +static inline const struct iommu_ops *
> > +of_iommu_get_ops(struct device_node *np)
> > +{
> > +	return fwspec_iommu_get_ops(&np->fwnode);
> > +}
> >  
> >  extern struct of_device_id __iommu_of_table;
> >  
> > 
> 
