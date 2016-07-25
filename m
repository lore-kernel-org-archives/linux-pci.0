Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 25 Jul 2016 16:41:03 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
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
Subject: Re: [RFC PATCH v3 05/13] drivers: iommu: make iommu_fwspec OF
 agnostic
Message-ID: <20160725154103.GA28507@red-moon>
References: <1469013815-24380-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1469013815-24380-6-git-send-email-lorenzo.pieralisi@arm.com>
 <1499f802-5f98-b0c0-d3aa-dabcac81e84e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499f802-5f98-b0c0-d3aa-dabcac81e84e@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 25, 2016 at 04:09:55PM +0100, Robin Murphy wrote:
> Hi Lorenzo,
> 
> On 20/07/16 12:23, Lorenzo Pieralisi wrote:
> > The iommu_fwspec structure, used to hold per device iommu configuration
> > data is not OF specific and therefore can be moved to a generic
> > and OF independent compilation unit.
> > 
> > In particular, the iommu_fwspec handling hinges on the device_node
> > pointer to identify the IOMMU device associated with the iommu_fwspec
> > structure, that is easily converted to a more generic fwnode_handle
> > pointer that can cater for OF and non-OF (ie ACPI) systems.
> > 
> > Create the files and related Kconfig entry to decouple iommu_fwspec
> > structure from the OF iommu kernel layer.
> > 
> > Given that the current iommu_fwspec implementation relies on
> > the arch specific struct device.archdata.iommu field in its
> > implementation, by making the code standalone and independent
> > of the OF layer this patch makes sure that the iommu_fwspec
> > kernel code can be selected only on arches implementing the
> > struct device.archdata.iommu field by adding an explicit
> > arch dependency in its config entry.
> > 
> > Current drivers using the iommu_fwspec for streamid translation
> > are converted to the new iommu_fwspec API by simply converting
> > the device_node to its fwnode_handle pointer.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > ---
> >  drivers/iommu/Kconfig        |   4 ++
> >  drivers/iommu/Makefile       |   1 +
> >  drivers/iommu/arm-smmu-v3.c  |  13 +++--
> >  drivers/iommu/iommu-fwspec.c | 114 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/iommu/of_iommu.c     |  52 --------------------
> >  include/linux/iommu-fwspec.h |  60 +++++++++++++++++++++++
> >  include/linux/of_iommu.h     |  24 +++------
> >  7 files changed, 196 insertions(+), 72 deletions(-)
> >  create mode 100644 drivers/iommu/iommu-fwspec.c
> >  create mode 100644 include/linux/iommu-fwspec.h
> > 
> > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > index d1c66af..2b26bfb 100644
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -67,6 +67,10 @@ config OF_IOMMU
> >         def_bool y
> >         depends on OF && IOMMU_API
> >  
> > +config IOMMU_FWSPEC
> > +       def_bool y
> > +       depends on ARM64 && IOMMU_API
> 
> I think that could be at least (ARM || ARM64).

Yes agreed.

> >  # IOMMU-agnostic DMA-mapping layer
> >  config IOMMU_DMA
> >  	bool
> 
> [...]
> 
> > diff --git a/include/linux/of_iommu.h b/include/linux/of_iommu.h
> > index 308791f..2362232 100644
> > --- a/include/linux/of_iommu.h
> > +++ b/include/linux/of_iommu.h
> > @@ -15,13 +15,8 @@ extern void of_iommu_init(void);
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
> > +void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
> > +const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
> 
> Is there some reason we need to retain the existing definitions of
> these? I was assuming we'd be able to move the entire implementation
> over to the fwspec code and leave behind nothing more than trivial
> wrappers, e.g.:
> 
> #define of_iommu_get_ops(np) iommu_fwspec_get_ops(&(np)->fwnode_handle)

Yep, that's exactly what I did but then I was bitten by config
dependencies. If we implement of_iommu_get/set_ops() as wrappers,
we have to compile iommu_fwspec_get/set_ops() on arches that may
not have struct dev_archdata.iommu, unless we introduce yet another
config symbol to avoid compiling that code (see eg iommu_fwspec_init(),
we can't compile it on eg x86 even though we do need of_iommu_get_ops()
on it - so iommu_fwspec_get_ops(), that lives in the same compilation
unit as eg iommu_fwspec_init()).

So short answer is: there is no reason apart from dev_archdata.iommu
being arch specific, if we were able to move iommu_fwspec to generic
code (ie struct device, somehow) I would certainly get rid of this
stupid code duplication (or as I said I can add a config entry for
that, more ideas are welcome).

Thanks,
Lorenzo

> 
> Robin.
> 
> >  #else
> >  
> > @@ -39,17 +34,14 @@ static inline const struct iommu_ops *of_iommu_configure(struct device *dev,
> >  	return NULL;
> >  }
> >  
> > -struct iommu_fwspec;
> > -
> > -#endif	/* CONFIG_OF_IOMMU */
> > +static inline void of_iommu_set_ops(struct device_node *np,
> > +				    const struct iommu_ops *ops)
> > +{ }
> >  
> > -int iommu_fwspec_init(struct device *dev, struct device_node *iommu_np);
> > -void iommu_fwspec_free(struct device *dev);
> > -int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
> > -struct iommu_fwspec *dev_iommu_fwspec(struct device *dev);
> > +static inline const struct iommu_ops *
> > +of_iommu_get_ops(struct device_node *np) { return NULL; }
> >  
> > -void of_iommu_set_ops(struct device_node *np, const struct iommu_ops *ops);
> > -const struct iommu_ops *of_iommu_get_ops(struct device_node *np);
> > +#endif	/* CONFIG_OF_IOMMU */
> >  
> >  extern struct of_device_id __iommu_of_table;
> >  
> > 
> 
