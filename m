Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C5521C9EA;
	Thu,  5 Mar 2026 04:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772685999; cv=none; b=VWdLO3qoSzB4ZlBWdCT68HtaTg6UdnOH7oKkK4KtWRIgF1dAjIjMy+UVs/1cJgkdwn1cgIQPAhMOPTaFMYj0+PPbMO+B9SiEbE30ZEVcu4KhLPZEHB8qoEVfpRY+VpsJIagQf1gafp5kZ4HypZNap2ieOXnKr9eiu1Frgd9CVlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772685999; c=relaxed/simple;
	bh=JgKMY70MTFLFYeeqkpmSDs8x1Iw6TfduL41te7pOKaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PjKYHzapOtoTnV7R53KtVV1AMGdVA6tDokhfPvwFj8OuvAbwE7Glq1bIlrr8RtqWF+7AKUS1NnRPPHrXEVN5Hs7nk1U+UA5bnf/zHa9FgdY08xMKoS97pHwF16r0apRyAcTjD4FBlzlpWD3Db9lkTD7+7a7oz0YKGq93ZKfafbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vv2AM8Of; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vv2AM8Of"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBB2C116C6;
	Thu,  5 Mar 2026 04:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772685998;
	bh=JgKMY70MTFLFYeeqkpmSDs8x1Iw6TfduL41te7pOKaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Vv2AM8OfNCYKCF8oybSB65u47mk84qpKo3CobajR06QlzkVCPddoMBNxBca3Uhn4z
	 Hpit0Lgf5xxccru5P/U599UgwZQug6X2x+FxfZh8kPlkGg441ZafR8s2eNCZCNnE1z
	 B4NvMOYk07qwEmA6QJbWodv71En3egkPxAuGxXIQvRjhWlK4XPfjQxJh/borxOrFNC
	 3MQL3y6LRFUEj64arQRnSAkvoPhYApOOqGmLxmEBLocVz9l8TwqNWxU3DGSBBBo+v2
	 plbqfuiruyFtChytgGzm3lZfMBQfxIrTNcVrALR4iubREI/O8W4qswH6p2gaSdmU3J
	 5nL7Rw6OrRAIw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, aik@amd.com, yilun.xu@linux.intel.com,
	bhelgaas@google.com, alistair23@gmail.com, lukas@wunner.de,
	jgg@nvidia.com, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 09/19] PCI/TSM: Support creating encrypted MMIO
 descriptors via TDISP Report
In-Reply-To: <20260303000207.1836586-10-dan.j.williams@intel.com>
References: <20260303000207.1836586-1-dan.j.williams@intel.com>
 <20260303000207.1836586-10-dan.j.williams@intel.com>
Date: Thu, 05 Mar 2026 10:16:29 +0530
Message-ID: <yq5a4imuanoa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> After pci_tsm_bind() and pci_tsm_lock() the low level TSM driver is
> expected to populate PCI_TSM_EVIDENCE_TYPE_REPORT in its evidence store.
> This report is defined by the TDISP GET_DEVICE_INTERFACE_REPORT response
> payload.
>
> Add a helper to create encrypted MMIO descriptors from that report
> data. With those descriptors the TSM driver can use pci_tsm_mmio_setup() to
> inform ioremap() how to map the device per the device's expectations. The
> VM is expected to validate the interface with the relying party before
> accepting the device for operation.
>
> The helper also provides the obfuscated starting address for each
> encrypted MMIO range as the VM is never disclosed on the hpa that
> correlates to the gpa of the device's mmio. The obfuscated address is BAR
> relative.
>
> Based on an original patch by Aneesh [1]
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/linux-coco/20251117140007.122062-8-aneesh.kumar@kernel.org/
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/ioport.h  |   1 +
>  include/linux/pci-tsm.h |  34 ++++++
>  drivers/pci/tsm/core.c  | 235 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 270 insertions(+)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 9afa30f9346f..1c106608c514 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -143,6 +143,7 @@ enum {
>  	IORES_DESC_RESERVED			= 7,
>  	IORES_DESC_SOFT_RESERVED		= 8,
>  	IORES_DESC_CXL				= 9,
> +	IORES_DESC_ENCRYPTED			= 10,
>  };
>  
>  /*
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index b70b4c0457c4..8869585230a3 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -194,12 +194,42 @@ struct pci_tsm_pf0 {
>  	struct pci_doe_mb *doe_mb;
>  };
>  
> +/**
> + * struct pci_tsm_mmio_entry - an encrypted MMIO range
> + * @res: MMIO address range (typically Guest Physical Address, GPA)
> + * @tsm_offset: Host Physical Address, HPA obfuscation offset added by the TSM.
> + *		Translates report addresses to GPA.
> + */
> +struct pci_tsm_mmio_entry {
> +	struct resource res;
> +	u64 tsm_offset;
> +};
> +
> +struct pci_tsm_mmio {
> +	int nr;
> +	struct pci_tsm_mmio_entry mmio[] __counted_by(nr);
> +};
> +
> +static inline struct pci_tsm_mmio_entry *
> +pci_tsm_mmio_entry(struct pci_tsm_mmio *mmio, int idx)
> +{
> +	return &mmio->mmio[idx];
> +}
> +
> +static inline struct resource *pci_tsm_mmio_resource(struct pci_tsm_mmio *mmio,
> +						     int idx)
> +{
> +	return &mmio->mmio[idx].res;
> +}
> +
>  /**
>   * struct pci_tsm_devsec - context for tracking private/accepted PCI resources
>   * @base_tsm: generic core "tsm" context
> + * @mmio: encrypted MMIO resources for this assigned device
>   */
>  struct pci_tsm_devsec {
>  	struct pci_tsm base_tsm;
> +	struct pci_tsm_mmio *mmio;
>  };
>  
>  /* physical function0 and capable of 'connect' */
> @@ -297,6 +327,10 @@ ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
>  struct pci_tsm_devsec *to_pci_tsm_devsec(struct pci_tsm *tsm);
>  void pci_tsm_init_evidence(struct pci_tsm_evidence *evidence, int slot,
>  			   enum hash_algo digest_algo);
> +int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
> +void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio);
> +struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev);
> +int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio);
>  #else
>  static inline int pci_tsm_register(struct tsm_dev *tsm_dev)
>  {
> diff --git a/drivers/pci/tsm/core.c b/drivers/pci/tsm/core.c
> index 039733fd19b1..e4f830b16d18 100644
> --- a/drivers/pci/tsm/core.c
> +++ b/drivers/pci/tsm/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/pci-tsm.h>
>  #include <linux/sysfs.h>
>  #include <linux/tsm.h>
> +#include <linux/unaligned.h>
>  #include <linux/xarray.h>
>  #include "../pci.h"
>  
> @@ -558,6 +559,240 @@ static ssize_t dsm_show(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RO(dsm);
>  
> +static void mmio_teardown(struct pci_tsm_mmio *mmio, int nr)
> +{
> +	while (nr--)
> +		remove_resource(pci_tsm_mmio_resource(mmio, nr));
> +}
> +
> +/**
> + * pci_tsm_mmio_setup() - mark device MMIO as encrypted in iomem
> + * @pdev: device owner of MMIO resources
> + * @mmio: container of an array of resources to mark encrypted
> + */
> +int pci_tsm_mmio_setup(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
> +{
> +	int i;
> +
> +	device_lock_assert(&pdev->dev);
> +	if (pdev->dev.driver)
> +		return -EBUSY;
> +
> +	for (i = 0; i < mmio->nr; i++) {
> +		struct resource *res = pci_tsm_mmio_resource(mmio, i);
> +		int j;
> +
> +		if (resource_size(res) == 0 || !res->end)
> +			break;
> +
> +		/* Only require the caller to set the range, init remainder */
> +		*res = DEFINE_RES_NAMED_DESC(res->start, resource_size(res),
> +					     "PCI MMIO Encrypted",
> +					     IORESOURCE_MEM,
> +					     IORES_DESC_ENCRYPTED);
> +
> +		for (j = 0; j < PCI_NUM_RESOURCES; j++)
> +			if (resource_contains(pci_resource_n(pdev, j), res))
> +				break;
> +
> +		/* Request is outside of device MMIO */
> +		if (j >= PCI_NUM_RESOURCES)
> +			break;
> +
> +		if (insert_resource(&iomem_resource, res) != 0)
> +			break;
> +	}
> +
> +	if (i >= mmio->nr)
> +		return 0;
> +
> +	mmio_teardown(mmio, i);
> +
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_mmio_setup);
> +
> +void pci_tsm_mmio_teardown(struct pci_tsm_mmio *mmio)
> +{
> +	mmio_teardown(mmio, mmio->nr);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_mmio_teardown);
> +
> +/*
> + * PCIe ECN TEE Device Interface Security Protocol (TDISP)
> + *
> + * Device Interface Report data object layout as defined by PCIe r7.0 section
> + * 11.3.11
> + */
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_TABLE BIT(0)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_PBA BIT(1)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE BIT(2)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_UPDATABLE BIT(3)
> +#define PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID GENMASK(31, 16)
> +
> +/* An interface report 'pfn' is 4K in size */
> +struct pci_tsm_devif_mmio {
> +	__le64 pfn;
> +	__le32 nr_pfns;
> +	__le32 attributes;
> +};
> +
> +struct pci_tsm_devif_report {
> +	__le16 interface_info;
> +	__le16 reserved;
> +	__le16 msi_x_message_control;
> +	__le16 lnr_control;
> +	__le32 tph_control;
> +	__le32 mmio_range_count;
> +	struct pci_tsm_devif_mmio mmio[];
> +};
> +
> +/**
> + * pci_tsm_mmio_alloc() - allocate encrypted MMIO range descriptor
> + * @pdev: device owner of MMIO ranges
> + * @report_data: TDISP Device Interface (DevIf) Report blob
> + * @report_sz: DevIf Report size
> + *
> + * Return: the encrypted MMIO range descriptor on success, NULL on failure
> + *
> + * Assumes that this is called within the live lifetime of a PCI device's
> + * association with a low level TSM.
> + */
> +struct pci_tsm_mmio *pci_tsm_mmio_alloc(struct pci_dev *pdev)
> +{
> +	struct pci_tsm *tsm = pdev->tsm;
> +	struct pci_tsm_evidence *evidence = &tsm->evidence;
> +	struct pci_tsm_evidence_object *report_obj = &evidence->obj[PCI_TSM_EVIDENCE_TYPE_REPORT];
> +	struct tsm_dev *tsm_dev = tsm->tsm_dev;
> +	u64 reporting_bar_base, last_reporting_end;
> +	const struct pci_tsm_devif_report *report;
> +	u32 mmio_range_count;
> +	int last_bar = -1;
> +	int i;
> +
> +	guard(rwsem_read)(&evidence->lock);
> +	if (report_obj->len < sizeof(struct pci_tsm_devif_report))
> +		return NULL;
> +
> +	if (dev_WARN_ONCE(&tsm_dev->dev, !IS_ALIGNED((unsigned long) report_obj->data, 8),
> +			  "misaligned report data\n"))
> +		return NULL;
> +
> +	report = report_obj->data;
> +	mmio_range_count = __le32_to_cpu(report->mmio_range_count);
> +
> +	/* check that the report object is self-consistent on mmio entries */
> +	if (report_obj->len < struct_size(report, mmio, mmio_range_count))
> +		return NULL;
> +
> +	/* create pci_tsm_mmio descriptors from the report data */
> +	struct pci_tsm_mmio *mmio __free(kfree) =
> +		kzalloc(struct_size(mmio, mmio, mmio_range_count), GFP_KERNEL);
> +	if (!mmio)
> +		return NULL;
> +
> +	for (i = 0; i < mmio_range_count; i++) {
> +		u64 range_off;
> +		struct range range;
> +		const struct pci_tsm_devif_mmio *mmio_data = &report->mmio[i];
> +		struct pci_tsm_mmio_entry *entry =
> +			pci_tsm_mmio_entry(mmio, mmio->nr);
> +		/* report values in are in terms of 4K pages */
> +		u64 tsm_offset = __le64_to_cpu(mmio_data->pfn) * SZ_4K;
> +		u64 size = __le32_to_cpu(mmio_data->nr_pfns) * SZ_4K;
> +		u32 attr = __le32_to_cpu(mmio_data->attributes);
> +		int bar = FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_RANGE_ID,
> +				    attr);
> +
> +		tsm_offset *= SZ_4K;
> +		size *= SZ_4K;
> +
> +		if (bar >= PCI_STD_NUM_BARS ||
> +		    !(pci_resource_flags(pdev, bar) & IORESOURCE_MEM)) {
> +			pci_dbg(pdev, "Invalid reporting bar ID %d\n", bar);
> +			return NULL;
> +		}
> +
> +		if (last_bar > bar) {
> +			pci_dbg(pdev, "Reporting bar ID not in ascending order\n");
> +			return NULL;
> +		}
> +
> +		if (last_bar < bar) {
> +			/* transition to a new bar */
> +			last_bar = bar;
> +			/*
> +			 * The tsm_offset for the first range of the BAR
> +			 * corresponds to the BAR base.
> +			 */
> +			reporting_bar_base = tsm_offset;
> +		} else if (tsm_offset < last_reporting_end) {
> +			pci_dbg(pdev, "Reporting ranges within BAR not in ascending order\n");
> +			return NULL;
> +		}
>
....
> +		range_off = tsm_offset - reporting_bar_base;
> 
range_off will always be zero? Should we do

 		range_off = tsm_offset & (pci_resource_len(pdev, bar) - 1);


So that we correctly handle if the interface report is reporting a range
within a bar. The only requirement here is bar address should be aligned
to its size and mmio_reporting_offset should not add offsets in that range.

> +
> +		last_reporting_end = tsm_offset + size;
> +		if (last_reporting_end < tsm_offset) {
> +			pci_dbg(pdev, "Reporting range overflow\n");
> +			return NULL;
> +		}
> +
> +		range_off = tsm_offset - reporting_bar_base;
> +		if (pci_resource_len(pdev, bar) < range_off + size) {
> +			pci_dbg(pdev, "Reporting range larger than BAR size\n");
> +			return NULL;
> +		}
> +
> +		range.start = pci_resource_start(pdev, bar) + range_off;
> +		range.end = range.start + size - 1;
> +
> +		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_IS_NON_TEE,
> +			      attr)) {
> +			pci_dbg(pdev, "Skipping non-TEE range, BAR%d %pra\n",
> +				 bar, &range);
> +			continue;
> +		}
> +
> +		/* Currently not supported */
> +		if (FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_TABLE,
> +			      attr) ||
> +		    FIELD_GET(PCI_TSM_DEVIF_REPORT_MMIO_ATTR_MSIX_PBA, attr)) {
> +			pci_dbg(pdev, "Skipping MSIX range BAR%d %pra\n", bar,
> +				 &range);
> +			continue;
> +		}
> +
> +		entry->res.start = range.start;
> +		entry->res.end = range.end;
> +		entry->tsm_offset = tsm_offset;
> +		mmio->nr++;
> +	}
> +
> +	return_ptr(mmio);
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_mmio_alloc);
> +
> +/**
> + * pci_tsm_mmio_free() - free a pci_tsm_mmio instance
> + * @pdev: device owner of MMIO ranges
> + * @mmio: instance to free
> + *
> + * Returns 0 if @mmio was idle on entry, -EBUSY otherwise
> + */
> +int pci_tsm_mmio_free(struct pci_dev *pdev, struct pci_tsm_mmio *mmio)
> +{
> +	for (int i = 0; i < mmio->nr; i++) {
> +		struct resource *res = pci_tsm_mmio_resource(mmio, i);
> +
> +		if (dev_WARN_ONCE(&pdev->dev, resource_assigned(res),
> +				  "MMIO resource still assigned %pr\n", res))
> +			return -EBUSY;
> +	}
> +	kfree(mmio);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_mmio_free);
> +
>  /**
>   * pci_tsm_accept() - accept a device for private MMIO+DMA operation
>   * @pdev: PCI device to accept
> -- 
> 2.52.0
