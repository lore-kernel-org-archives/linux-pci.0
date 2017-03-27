Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [RFC PATCH 01/30] iommu/arm-smmu-v3: Link groups and devices
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-2-jean-philippe.brucker@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <9ce9e3c5-3f94-8b06-2bd7-a665f0f33304@arm.com>
Date: Mon, 27 Mar 2017 13:18:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170227195441.5170-2-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>,
 iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>,
 Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Nate Watterson <nwatters@qti.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jean-Philippe,

On 27/02/17 19:54, Jean-Philippe Brucker wrote:
> Reintroduce smmu_group. This structure was removed during the generic DT
> bindings rework, but will be needed when implementing PCIe ATS, to lookup
> devices attached to a given domain.
> 
> When unmapping from a domain, we need to send an invalidation to all
> devices that could have stored the mapping in their ATC. It would be nice
> to use IOMMU API's iommu_group_for_each_dev, but that list is protected by
> group->mutex, which we can't use because atc_invalidate won't be allowed
> to sleep. So add a list of devices, protected by a spinlock.

Much as I dislike that particular duplication, with patch #4 in mind I
think there's a more fundamental problem - since the primary reason for
multi-device groups is lack of ACS, is there any guarantee that ATS
support/enablement will be actually be homogeneous across any old set of
devices in that situation, and thus valid to evaluate at the iommu_group
level?

That said, looking at how things end up at the top commit, I think this
is fairly easily sidestepped. We have this pattern a few times:

	spin_lock_irqsave(&smmu_domain->groups_lock)
	list_for_each_entry(&smmu_domain->groups)
		spin_lock(&smmu_group->devices_lock)
		list_for_each_entry(&smmu_group->devices)
			do a thing for each device in the domain...

which strongly suggests that we'd be better off just linking the devices
to the domain directly - which would also let us scope ats_enabled to
the per-device level which seems safer than per-group as above. And if
only devices with ATS enabled are added to a domain's list in the first
place, then ATC invalidate gets even simpler too.

The only other uses I can see are of smmu_group->domain, which always
looks to be directly equivalent to to_smmu_domain(iommu_group->domain).
Overall it really looks like the smmu_group abstraction winds up making
the end result more complex than it needs to be.

Robin.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/arm-smmu-v3.c | 74 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 5806a6acc94e..ce8b68fe254b 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -625,6 +625,9 @@ struct arm_smmu_device {
>  struct arm_smmu_master_data {
>  	struct arm_smmu_device		*smmu;
>  	struct arm_smmu_strtab_ent	ste;
> +
> +	struct device			*dev;
> +	struct list_head		group_head;
>  };
>  
>  /* SMMU private data for an IOMMU domain */
> @@ -650,6 +653,11 @@ struct arm_smmu_domain {
>  	struct iommu_domain		domain;
>  };
>  
> +struct arm_smmu_group {
> +	struct list_head		devices;
> +	spinlock_t			devices_lock;
> +};
> +
>  struct arm_smmu_option_prop {
>  	u32 opt;
>  	const char *prop;
> @@ -665,6 +673,8 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
>  	return container_of(dom, struct arm_smmu_domain, domain);
>  }
>  
> +#define to_smmu_group iommu_group_get_iommudata
> +
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>  	int i = 0;
> @@ -1595,6 +1605,30 @@ static int arm_smmu_install_ste_for_dev(struct iommu_fwspec *fwspec)
>  	return 0;
>  }
>  
> +static void arm_smmu_group_release(void *smmu_group)
> +{
> +	kfree(smmu_group);
> +}
> +
> +static struct arm_smmu_group *arm_smmu_group_alloc(struct iommu_group *group)
> +{
> +	struct arm_smmu_group *smmu_group = to_smmu_group(group);
> +
> +	if (smmu_group)
> +		return smmu_group;
> +
> +	smmu_group = kzalloc(sizeof(*smmu_group), GFP_KERNEL);
> +	if (!smmu_group)
> +		return NULL;
> +
> +	INIT_LIST_HEAD(&smmu_group->devices);
> +	spin_lock_init(&smmu_group->devices_lock);
> +
> +	iommu_group_set_iommudata(group, smmu_group, arm_smmu_group_release);
> +
> +	return smmu_group;
> +}
> +
>  static void arm_smmu_detach_dev(struct device *dev)
>  {
>  	struct arm_smmu_master_data *master = dev->iommu_fwspec->iommu_priv;
> @@ -1607,7 +1641,9 @@ static void arm_smmu_detach_dev(struct device *dev)
>  static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  {
>  	int ret = 0;
> +	struct iommu_group *group;
>  	struct arm_smmu_device *smmu;
> +	struct arm_smmu_group *smmu_group;
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>  	struct arm_smmu_master_data *master;
>  	struct arm_smmu_strtab_ent *ste;
> @@ -1619,6 +1655,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	smmu = master->smmu;
>  	ste = &master->ste;
>  
> +	/*
> +	 * When adding devices, this is the first occasion we have to create the
> +	 * smmu_group and attach it to iommu_group.
> +	 */
> +	group = iommu_group_get(dev);
> +	smmu_group = arm_smmu_group_alloc(group);
> +	if (!smmu_group) {
> +		iommu_group_put(group);
> +		return -ENOMEM;
> +	}
> +
>  	/* Already attached to a different domain? */
>  	if (!ste->bypass)
>  		arm_smmu_detach_dev(dev);
> @@ -1659,6 +1706,9 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  
>  out_unlock:
>  	mutex_unlock(&smmu_domain->init_mutex);
> +
> +	iommu_group_put(group);
> +
>  	return ret;
>  }
>  
> @@ -1745,7 +1795,9 @@ static struct iommu_ops arm_smmu_ops;
>  static int arm_smmu_add_device(struct device *dev)
>  {
>  	int i, ret;
> +	unsigned long flags;
>  	struct arm_smmu_device *smmu;
> +	struct arm_smmu_group *smmu_group;
>  	struct arm_smmu_master_data *master;
>  	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>  	struct iommu_group *group;
> @@ -1769,6 +1821,7 @@ static int arm_smmu_add_device(struct device *dev)
>  			return -ENOMEM;
>  
>  		master->smmu = smmu;
> +		master->dev = dev;
>  		fwspec->iommu_priv = master;
>  	}
>  
> @@ -1789,6 +1842,12 @@ static int arm_smmu_add_device(struct device *dev)
>  
>  	group = iommu_group_get_for_dev(dev);
>  	if (!IS_ERR(group)) {
> +		smmu_group = to_smmu_group(group);
> +
> +		spin_lock_irqsave(&smmu_group->devices_lock, flags);
> +		list_add(&master->group_head, &smmu_group->devices);
> +		spin_unlock_irqrestore(&smmu_group->devices_lock, flags);
> +
>  		iommu_group_put(group);
>  		iommu_device_link(&smmu->iommu, dev);
>  	}
> @@ -1800,7 +1859,10 @@ static void arm_smmu_remove_device(struct device *dev)
>  {
>  	struct iommu_fwspec *fwspec = dev->iommu_fwspec;
>  	struct arm_smmu_master_data *master;
> +	struct arm_smmu_group *smmu_group;
>  	struct arm_smmu_device *smmu;
> +	struct iommu_group *group;
> +	unsigned long flags;
>  
>  	if (!fwspec || fwspec->ops != &arm_smmu_ops)
>  		return;
> @@ -1809,6 +1871,18 @@ static void arm_smmu_remove_device(struct device *dev)
>  	smmu = master->smmu;
>  	if (master && master->ste.valid)
>  		arm_smmu_detach_dev(dev);
> +
> +	if (master) {
> +		group = iommu_group_get(dev);
> +		smmu_group = to_smmu_group(group);
> +
> +		spin_lock_irqsave(&smmu_group->devices_lock, flags);
> +		list_del(&master->group_head);
> +		spin_unlock_irqrestore(&smmu_group->devices_lock, flags);
> +
> +		iommu_group_put(group);
> +	}
> +
>  	iommu_group_remove_device(dev);
>  	iommu_device_unlink(&smmu->iommu, dev);
>  	kfree(master);
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
