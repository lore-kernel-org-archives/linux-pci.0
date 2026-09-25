Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACF440A3E;
	Fri, 25 Sep 2026 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373939; cv=none; b=PNxGnu3S1SA7Av1qHKlQS4N18K3UDtQ9HiIzTG94hmK5zknamYNCGidz1/apJZ19RGwkf9kBev9nz4XI7RqKVEApkWwA1NqJmhcv2TkU6sgiDx5FsoK6Eyy/7sJOPuMCOv/AIqtMs5ElSJQFa48FPCDn5qSeT87kH4Kd7dQnMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373939; c=relaxed/simple;
	bh=2EOpSBVwiFTyJODrgdVakePWlXOI6UWDhn5KowBzIQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OzrHuRszoq2ahITQ8RARyoFZIL/EMAz2dlH0EtWw14o1Irff/3M6/eUBEjpn80swtXcJeDpPWQfm3xifEc7HpqPUls9gWS6E0i5g/DzlaGwHrCEHr/dYJyf1i6DkIgd0X8TB73EYCc+i1DdSElVjRQbPgLoFVvUX9LWHdTH6DyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW/1X2dA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW/1X2dA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79301F000FF;
	Fri, 25 Sep 2026 22:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790373937;
	bh=l+YfFAXDtzOvvAcpNn6JM07GzhHKVnZX6drhhNawXKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aW/1X2dAcrgTp6XTDHYRMTvAIo3LsC0iWnytkzVEcKaiv3k8e7ot3mkyzAj9pd6S2
	 s5YoLVCD4DscVM+BZ7b8QabDnL2am+4sOjnDiaD01LQX860U7sek8Yhc5IXJ/ThyD2
	 7CAHYsbH2iA9OHQ2d/g1TjDTOQy+bZ51RmEa1LpKc5uyYSO9gXaNk5HIlbhGhkEfvS
	 lAuY+eel3A196tXEYYZA7IA+eX38zrquyLZUPBxBU4xUDt/6OkF5TrA3pI4R2BeN1q
	 Q4oIWBhYHXEwAOKY+msEAGZPZ8YUTTIT+WYGMAjNM28Jp+0D5VIsE3uDucb2BTtZ9J
	 2HMxrLbIeJKZg==
Date: Fri, 25 Sep 2026 23:05:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alex@shazbot.org>, <jgg@ziepe.ca>, <ankita@nvidia.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <smadhavan@nvidia.com>, <corbet@lwn.net>, <skhan@linuxfoundation.org>,
 <dave@stgolabs.net>, <alison.schofield@intel.com>,
 <vishal.l.verma@intel.com>, <iweiny@kernel.org>, <ming.li@zohomail.com>,
 <yishaih@nvidia.com>, <skolothumtho@nvidia.com>, <kevin.tian@intel.com>,
 <bhelgaas@google.com>, <dmatlack@google.com>, <kees@kernel.org>,
 <gustavoars@kernel.org>, <cjia@nvidia.com>, <kjaju@nvidia.com>,
 <vsethi@nvidia.com>, <zhiw@nvidia.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v5 09/27] vfio/pci: Add a generic excluded-range list
Message-ID: <20260925230528.33f70daf@jic23-hlaptop>
In-Reply-To: <20260916183540.3813685-10-mhonap@nvidia.com>
References: <20260916183540.3813685-1-mhonap@nvidia.com>
	<20260916183540.3813685-10-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 00:05:22 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> The MSI-X table is virtualized in vfio_pci_bar_rw() by an open-coded
> x_start/x_end window that fills reads with -1 and drops writes. Now that
> a generic excluded-range list expresses the same fill/drop behavior,
> register the MSI-X table as a read and write excluded range instead of
> special-casing it in the read/write path.
> 
> Add the range when the MSI-X capability is parsed in
> vfio_pci_core_enable() and clear the list in vfio_pci_core_disable()
> alongside the config teardown. The read/write path now relies solely on
> vfio_pci_bar_find_exclusion(), so MSI-X and a provider's (e.g. vfio-cxl)
> trapped registers share one mechanism.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
A few things inline that might tidy up the implementation and make
it a little more readable. Also you've use object allocators in some
places but not universally.  

Jonathan

> ---
>  drivers/vfio/pci/vfio_pci_core.c | 209 +++++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_priv.h |   9 ++
>  drivers/vfio/pci/vfio_pci_rdwr.c |   8 ++
>  include/linux/vfio_pci_core.h    |  14 +++
>  4 files changed, 240 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 9a75c30b67e2..9e4fa5d088a4 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -24,6 +24,7 @@
>  #include <linux/pci.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> +#include <linux/sort.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/vgaarb.h>
> @@ -1012,6 +1013,204 @@ static int msix_mmappable_cap(struct vfio_pci_core_device *vdev,
>  	return vfio_info_add_capability(caps, &header, sizeof(header));
>  }
>  
> +struct vfio_pci_excluded_range {
> +	struct list_head	entry;
> +	int			bar;
> +	u64			start;
> +	u64			size;
> +	u32			flags;
> +};
> +
> +int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev, int bar,
> +				     u64 start, u64 size, u32 flags)
> +{
> +	struct vfio_pci_excluded_range *range;
> +
> +	range = kzalloc_obj(*range);
> +	if (!range)
> +		return -ENOMEM;
> +
I'd be tempted to do kmalloc_obj and
	*range = (struct vfio_pci_excluded_range) {
		.bar = bar,
		.start = start,
		.size = size,
		.flags = flags,
	};
	list_add_tail(...)

> +	range->bar = bar;
> +	range->start = start;
> +	range->size = size;
> +	range->flags = flags;
> +	list_add_tail(&range->entry, &vdev->excluded_ranges);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_add_excluded_range);
> +
> +static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_excluded_range *range, *tmp;
> +
> +	list_for_each_entry_safe(range, tmp, &vdev->excluded_ranges, entry) {
> +		list_del(&range->entry);
> +		kfree(range);
> +	}
> +}


> +
> +/* A page-aligned mmap hole, derived from an mmap-excluded range. */
> +struct vfio_pci_mmap_hole {
> +	u64 start;
> +	u64 end;
> +};
This is just a range. Do we need another define for this specific case?

> +/*
> + * Advertise the BAR as mmappable minus every page-aligned mmap-excluded hole.
> + * A BAR can carry several holes at unrelated offsets (for example an MSI-X
> + * table and one or more trapped CXL component sub-blocks, which the CXL spec
> + * locates by pointer, not at fixed offsets).
> + * Collect the holes, page-align and sort them, coalesce any that overlap or
> + * touch, and advertise the gaps.
> + */
> +static int vfio_pci_excluded_sparse_cap(struct vfio_pci_core_device *vdev,
> +					int index, struct vfio_info_cap *caps)
> +{
> +	u64 bar_len = pci_resource_len(vdev->pdev, index);
> +	struct vfio_region_info_cap_sparse_mmap *sparse;
> +	struct vfio_pci_excluded_range *range;
> +	struct vfio_pci_mmap_hole *holes;
> +	int nr_holes = 0, nr_areas = 0, i, j;

Generally avoid mixing declarations with assignment with those that don't
on a single line. It is harder to read than splitting them into each
time of declaration.

> +	size_t size;
> +	u64 pos;
> +	int ret;
> +
> +	list_for_each_entry(range, &vdev->excluded_ranges, entry)
> +		if (range->bar == index &&
> +		    (range->flags & VFIO_PCI_EXCLUDE_MMAP))
> +			nr_holes++;
> +
> +	if (!nr_holes)
> +		return 0;
> +
	struct vfio_pci_mmap_hole *holes __free(kfree) =
		kzalloc_objs(*holes, nr_holes);
or something like that.  Kees is well his way to getting rid of almost
all places where objects are allocated in non typesafe ways.

> +	holes = kmalloc_array(nr_holes, sizeof(*holes), GFP_KERNEL);
> +	if (!holes)
> +		return -ENOMEM;
> +
> +	/*
> +	 * mmap is page granular, so each hole rounds out to the page boundaries
> +	 * enclosing its excluded sub-range. The byte-granular exclusion still
> +	 * governs the fault and read/write paths; only the advertised mmap areas
> +	 * round to whole pages.
> +	 */
> +	i = 0;
> +	list_for_each_entry(range, &vdev->excluded_ranges, entry) {
> +		if (range->bar != index ||
> +		    !(range->flags & VFIO_PCI_EXCLUDE_MMAP))
> +			continue;

		holes[i++] = (struct vfio_pci_mmap_hole) {
			.start = ALIGN_DOWN(range->start, PAGE_SIZE),
			.end = ALIGN(range->start + range->size, PAGE_SIZE),
		};

Mind you vfio_pci_mmap_hole seems a lot like a range. So maybe just use a
struct range then you get 

		holes[i++] = DEFINE_RANGE(ALIGN_DOWN(range->start, PAGE_SIZE),
					  ALIGN(range->start + range->size, PAGE_SIZE));


> +		holes[i].start = ALIGN_DOWN(range->start, PAGE_SIZE);
> +		holes[i].end = ALIGN(range->start + range->size, PAGE_SIZE);
> +		i++;
> +	}
> +
> +	sort(holes, nr_holes, sizeof(*holes), vfio_pci_mmap_hole_cmp, NULL);
> +
> +	/* Coalesce holes that overlap or touch after page alignment. */
> +	for (i = 0, j = 0; i < nr_holes; i++) {
> +		if (j && holes[i].start <= holes[j - 1].end)
> +			holes[j - 1].end = max(holes[j - 1].end, holes[i].end);
> +		else
> +			holes[j++] = holes[i];
> +	}
> +	nr_holes = j;
> +
> +	/* One mmappable area per gap: before, between, and after the holes. */
> +	for (i = 0, pos = 0; i < nr_holes; i++) {
> +		if (holes[i].start > pos)
> +			nr_areas++;
> +		pos = holes[i].end;
> +	}
> +	if (pos < bar_len)
> +		nr_areas++;
> +
> +	size = struct_size(sparse, areas, nr_areas);

	struct vfio_region_info_cap_sparse_mmap *sparse =
		kzalloc_flex(*sparse, areas, nr_areas);

> +	sparse = kzalloc(size, GFP_KERNEL);
> +	if (!sparse) {
> +		kfree(holes);
with the __free above this can simply return.
> +		return -ENOMEM;
> +	}
> +
> +	sparse->header.id = VFIO_REGION_INFO_CAP_SPARSE_MMAP;
> +	sparse->header.version = 1;
> +	sparse->nr_areas = nr_areas;
> +
> +	for (i = 0, j = 0, pos = 0; i < nr_holes; i++) {
> +		if (holes[i].start > pos) {
> +			sparse->areas[j].offset = pos;
> +			sparse->areas[j].size = holes[i].start - pos;
> +			j++;
Bit of a long line because of the indent but I'd still go for setting whole
structure in one shot - so something like:

			sparse->areas[j++] = (struct vfio_region_sparse_mmap_area) {
				.offset = pos,
				.size = holes[i].start - pos,
			};
> +		}
> +		pos = holes[i].end;
> +	}
> +	if (pos < bar_len) {
> +		sparse->areas[j].offset = pos;
> +		sparse->areas[j].size = bar_len - pos;

Similar for setting it in one go so we only do the indexing
once + looks more like above (where this trick is more advantageous!)

		sparse->areas[j] = (struct vfio_sparse_mmap_area) {
			.offset = pos,
			.size = bar_len - pos, 
		};


> +	}
> +
> +	kfree(holes);

This looks like a good place to use __free magic to simplify things.

> +	ret = vfio_info_add_capability(caps, &sparse->header, size);
> +	kfree(sparse);
> +	return ret;
> +}
> +


