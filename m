Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 27 Feb 2018 10:51:21 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 16/37] iommu: Add generic PASID table library
Message-ID: <20180227105121.7c6e1110@jacob-builder>
In-Reply-To: <20180212183352.22730-17-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-17-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, ilias.apalodimas@linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, xuzaibo@huawei.com,
 jonathan.cameron@huawei.com, will.deacon@arm.com, okaya@codeaurora.org,
 yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, ashok.raj@intel.com,
 tn@semihalf.com, joro@8bytes.org, robdclark@gmail.com, bharatku@xilinx.com,
 linux-acpi@vger.kernel.org, catalin.marinas@arm.com, rfranz@cavium.com,
 lenb@kernel.org, devicetree@vger.kernel.org, jacob.jun.pan@linux.intel.com,
 alex.williamson@redhat.com, robh+dt@kernel.org, thunder.leizhen@huawei.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
 shunyong.yang@hxt-semitech.com, dwmw2@infradead.org, liubo95@huawei.com,
 rjw@rjwysocki.net, jcrouse@codeaurora.org, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 christian.koenig@amd.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 12 Feb 2018 18:33:31 +0000
Jean-Philippe Brucker <jean-philippe.brucker@arm.com> wrote:

> Add a small API within the IOMMU subsystem to handle different
> formats of PASID tables. It uses the same principle as io-pgtable:
> 
> * The IOMMU driver registers a PASID table with some invalidation
>   callbacks.
> * The pasid-table lib allocates a set of tables of the right format,
> and returns an iommu_pasid_table_ops structure.
> * The IOMMU driver allocates entries and writes them using the
> provided ops.
> * The pasid-table lib calls the IOMMU driver back for invalidation
> when necessary.
> * The IOMMU driver unregisters the ops which frees the tables when
>   finished.
> 
> An example user will be Arm SMMU in a subsequent patch.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/iommu/Kconfig       |   8 +++
>  drivers/iommu/Makefile      |   1 +
>  drivers/iommu/iommu-pasid.c |  53 +++++++++++++++++
>  drivers/iommu/iommu-pasid.h | 142
> ++++++++++++++++++++++++++++++++++++++++++++ 4 files changed, 204
> insertions(+) create mode 100644 drivers/iommu/iommu-pasid.c
>  create mode 100644 drivers/iommu/iommu-pasid.h
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e751bb9958ba..8add90ba9b75 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -60,6 +60,14 @@ config IOMMU_IO_PGTABLE_ARMV7S_SELFTEST
>  
>  endmenu
>  
> +menu "Generic PASID table support"
> +
> +# Selected by the actual PASID table implementations
> +config IOMMU_PASID_TABLE
> +	bool
> +
> +endmenu
> +
>  config IOMMU_IOVA
>  	tristate
>  
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index f4324e29035e..338e59c93131 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_IOMMU_FAULT) += io-pgfault.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> +obj-$(CONFIG_IOMMU_PASID_TABLE) += iommu-pasid.o
>  obj-$(CONFIG_IOMMU_IOVA) += iova.o
>  obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
>  obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
> diff --git a/drivers/iommu/iommu-pasid.c b/drivers/iommu/iommu-pasid.c
> new file mode 100644
> index 000000000000..6b21d369d514
> --- /dev/null
> +++ b/drivers/iommu/iommu-pasid.c
> @@ -0,0 +1,53 @@
> +/*
> + * PASID table management for the IOMMU
> + *
> + * Copyright (C) 2018 ARM Ltd.
> + * Author: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include "iommu-pasid.h"
> +
> +static const struct iommu_pasid_init_fns *
> +pasid_table_init_fns[PASID_TABLE_NUM_FMTS] = {
> +};
> +
> +struct iommu_pasid_table_ops *
> +iommu_alloc_pasid_ops(enum iommu_pasid_table_fmt fmt,
> +		      struct iommu_pasid_table_cfg *cfg, void
> *cookie) +{
I guess you don't need to pass in cookie here.
> +	struct iommu_pasid_table *table;
> +	const struct iommu_pasid_init_fns *fns;
> +
> +	if (fmt >= PASID_TABLE_NUM_FMTS)
> +		return NULL;
> +
> +	fns = pasid_table_init_fns[fmt];
> +	if (!fns)
> +		return NULL;
> +
> +	table = fns->alloc(cfg, cookie);
> +	if (!table)
> +		return NULL;
> +
> +	table->fmt = fmt;
> +	table->cookie = cookie;
> +	table->cfg = *cfg;
> +
the ops is already IOMMU model specific, why do you need to pass cfg
back?
> +	return &table->ops;
If there is no common code that uses these ops, I don't see the benefit
of having these APIs. Or the plan is to consolidate even further such
that referene to pasid table can be attached at per iommu_domain etc,
but that would be model specific choice.

Jacob 
> +}
> +
> +void iommu_free_pasid_ops(struct iommu_pasid_table_ops *ops)
> +{
> +	struct iommu_pasid_table *table;
> +
> +	if (!ops)
> +		return;
> +
> +	table = container_of(ops, struct iommu_pasid_table, ops);
> +	iommu_pasid_flush_all(table);
> +	pasid_table_init_fns[table->fmt]->free(table);
> +}
> diff --git a/drivers/iommu/iommu-pasid.h b/drivers/iommu/iommu-pasid.h
> new file mode 100644
> index 000000000000..40a27d35c1e0
> --- /dev/null
> +++ b/drivers/iommu/iommu-pasid.h
> @@ -0,0 +1,142 @@
> +/*
> + * PASID table management for the IOMMU
> + *
> + * Copyright (C) 2017 ARM Ltd.
> + * Author: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + */
> +#ifndef __IOMMU_PASID_H
> +#define __IOMMU_PASID_H
> +
> +#include <linux/types.h>
> +#include "io-pgtable.h"
> +
> +struct mm_struct;
> +
> +enum iommu_pasid_table_fmt {
> +	PASID_TABLE_NUM_FMTS,
> +};
> +
> +/**
> + * iommu_pasid_entry - Entry of a PASID table
> + *
> + * @token:	architecture-specific data needed to uniquely
> identify the
> + *		entry. Most notably used for TLB invalidation
> + */
> +struct iommu_pasid_entry {
> +	u64		tag;
> +};
> +
> +/**
> + * iommu_pasid_table_ops - Operations on a PASID table
> + *
> + * @alloc_shared_entry:	allocate an entry for sharing an mm
> (SVA)
> + *			Returns the pointer to a new entry or an
> error
> + * @alloc_priv_entry:	allocate an entry for map/unmap
> operations
> + *			Returns the pointer to a new entry or an
> error
> + * @free_entry:		free an entry obtained with
> alloc_entry
> + * @set_entry:		write PASID table entry
> + * @clear_entry:	clear PASID table entry
> + */
> +struct iommu_pasid_table_ops {
> +	struct iommu_pasid_entry *
> +	(*alloc_shared_entry)(struct iommu_pasid_table_ops *ops,
> +			      struct mm_struct *mm);
> +	struct iommu_pasid_entry *
> +	(*alloc_priv_entry)(struct iommu_pasid_table_ops *ops,
> +			    enum io_pgtable_fmt fmt,
> +			    struct io_pgtable_cfg *cfg);
> +	void (*free_entry)(struct iommu_pasid_table_ops *ops,
> +			   struct iommu_pasid_entry *entry);
> +	int (*set_entry)(struct iommu_pasid_table_ops *ops, int
> pasid,
> +			 struct iommu_pasid_entry *entry);
> +	void (*clear_entry)(struct iommu_pasid_table_ops *ops, int
> pasid,
> +			    struct iommu_pasid_entry *entry);
> +};
> +
> +/**
> + * iommu_pasid_sync_ops - Callbacks into the IOMMU driver
> + *
> + * @cfg_flush:		flush cached configuration for one
> entry. For a
> + *			multi-level PASID table, 'leaf' tells
> whether to only
> + *			flush cached leaf entries or intermediate
> levels as
> + *			well.
> + * @cfg_flush_all:	flush cached configuration for all entries
> of the PASID
> + *			table
> + * @tlb_flush:		flush TLB entries for one entry
> + */
> +struct iommu_pasid_sync_ops {
> +	void (*cfg_flush)(void *cookie, int pasid, bool leaf);
> +	void (*cfg_flush_all)(void *cookie);
> +	void (*tlb_flush)(void *cookie, int pasid,
> +			  struct iommu_pasid_entry *entry);
> +};
> +
> +/**
> + * struct iommu_pasid_table_cfg - Configuration data for a set of
> PASID tables.
> + *
> + * @iommu_dev	device performing the DMA table walks
> + * @order:	number of PASID bits, set by IOMMU driver
> + * @flush:	TLB management callbacks for this set of tables.
> + *
> + * @base:	DMA address of the allocated table, set by the
> allocator.
> + */
> +struct iommu_pasid_table_cfg {
> +	struct device			*iommu_dev;
> +	size_t				order;
> +	const struct iommu_pasid_sync_ops *sync;
> +
> +	dma_addr_t			base;
> +};
> +
> +struct iommu_pasid_table_ops *
> +iommu_alloc_pasid_ops(enum iommu_pasid_table_fmt fmt,
> +		      struct iommu_pasid_table_cfg *cfg,
> +		      void *cookie);
> +void iommu_free_pasid_ops(struct iommu_pasid_table_ops *ops);
> +
> +/**
> + * struct iommu_pasid_table - describes a set of PASID tables
> + *
> + * @fmt:	The PASID table format.
> + * @cookie:	An opaque token provided by the IOMMU driver and
> passed back to
> + *		any callback routine.
> + * @cfg:	A copy of the PASID table configuration.
> + * @ops:	The PASID table operations in use for this set of
> page tables.
> + */
> +struct iommu_pasid_table {
> +	enum iommu_pasid_table_fmt	fmt;
> +	void				*cookie;
> +	struct iommu_pasid_table_cfg	cfg;
> +	struct iommu_pasid_table_ops	ops;
> +};
> +
> +#define iommu_pasid_table_ops_to_table(ops) \
> +	container_of((ops), struct iommu_pasid_table, ops)
> +
> +struct iommu_pasid_init_fns {
> +	struct iommu_pasid_table *(*alloc)(struct
> iommu_pasid_table_cfg *cfg,
> +					   void *cookie);
> +	void (*free)(struct iommu_pasid_table *table);
> +};
> +
> +static inline void iommu_pasid_flush_all(struct iommu_pasid_table
> *table) +{
> +	table->cfg.sync->cfg_flush_all(table->cookie);
> +}
> +
> +static inline void iommu_pasid_flush(struct iommu_pasid_table *table,
> +					 int pasid, bool leaf)
> +{
> +	table->cfg.sync->cfg_flush(table->cookie, pasid, leaf);
> +}
> +
> +static inline void iommu_pasid_flush_tlbs(struct iommu_pasid_table
> *table,
> +					  int pasid,
> +					  struct iommu_pasid_entry
> *entry) +{
> +	table->cfg.sync->tlb_flush(table->cookie, pasid, entry);
> +}
> +
> +#endif /* __IOMMU_PASID_H */

[Jacob Pan]

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
