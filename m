Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EDD3876C5;
	Tue, 22 Sep 2026 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790043363; cv=none; b=nfl77N0MS3pTc/VDD1FlvMk8/ZJlk6RoKtBP/o1Yiw6plPQ0bT76fwQbNnCjRwNbTCHF3mzlFFnnD86mX7nWRr+5PDQUciKXQRCTsOtSjnAXMg1C2FPn4XZ5aD/kRsHrYWIt7tlt2QfBjEIki1kYFEt/CtfbIJKOXnNKeycSMAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790043363; c=relaxed/simple;
	bh=5DSyt7jSs1X9nu3vxXjK4VyHP46+sf28b/O1TBhQ254=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jI8zZ/DQH/WpLSAMIjmUScrJX/BUlhfB6vtZzsL+VXF+A+lPQmgN80WxhdDkmNdRkZfllIonqEVRTGP+WAI651ID51lx/Gj1PMyP3iVuZx/GMCz48PzI7n41iw0OlY8LMur1bXrZ9YkLtfpvGilKlARordiROvJlUMxmlcq090M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=UgAtVYvj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z5H5Z23N; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="UgAtVYvj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z5H5Z23N"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 55E6F7A006C;
	Mon, 21 Sep 2026 22:15:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 21 Sep 2026 22:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790043359;
	 x=1790129759; bh=7JGaL35QfotK52wcCfu2s9/lcCZXmGa+0M1VM4MG8N4=; b=
	UgAtVYvjW0J19tyiDara3f6hPpPGl9HkQMl7NWU6X88UUywjjcK3mRvl5i6hX9gD
	7VxBJkFrfPYaHe3Pvp8cd+KAEOcGxUD3NPiZqGJ7GncL6UzqPbGAUgPKe7lt7Ygy
	e0OTghy/r8/XtUPB8oUb1ksSJFtNsTK0I5dEYAWhNFj1kIWaBuQGRJK0FI1GiajQ
	KgcBXMfJTtaucNLBcfvHLmtIFDLSivr/Ccua+tAcfIFFHpMQEkfxfwTswBJuaBbi
	hRt3qKq0pOpWutdcYM2Skkts9vcwYIniQwr6EjWXWmH8gORzqxYm8O7ScxQsc3Nn
	Ll9l+G2Si4CfRvyoc+0r5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790043359; x=
	1790129759; bh=7JGaL35QfotK52wcCfu2s9/lcCZXmGa+0M1VM4MG8N4=; b=Z
	5H5Z23NcKkTo41P99HbVUIbPDmhshxIzH2Zst45szswpsVjdV8G/qAZKAdlKKq8u
	zTITNVmCauC9lMWwZ5nrd89KnoAcg9q+as4s6MIsftu8DpjWKVqfP78ASL21JHxx
	iLDJIzn0ZDtJr1p25dmXYHEvh/Bn956nEZXKsh4xJIp0zz+2IZtEUhA1MVOYEhaR
	0DxQIl9zyNodbrdMaGEHRu5LaQyZqrokMyAgvXO8VVuH5X3aLTSK3HLes6ZY76i0
	Xj7J2bh8oxlJHwm7/SjfD3Z/+mE+KXj3cxiRJIjDrB3qdVCmll0U9DBdnWTNbp1A
	Zu1oooFNfvXOCkFBQq1YQ==
X-ME-Sender: <xms:3-SxatQEX9ZBdIki3iN_vGah027PPKTpDw8Ezy-1wZLuHhIxe28MXA>
    <xme:3-SxakZB2z1_hBEPav2a5X2xUmUxrqlNaCq4B1wDj-FxknyRLHh8tSiVyv4LCJn-K
    T1d_3qb3ioWfGAb474mtjMtmzU9ZaM6n8LdvOM5pl16tv-ez077Ewc>
X-ME-Received: <xmr:3-SxaqNAwAJxZmQZrWAg8Cpl-CfnP0WgvK58D_iGpwQEdrCANcHkAg8-ahW5bg>
X-ME-Proxy-Cause: dmFkZTEyG7J3G3wtUErbXM+kbHXPJ8Ln3dDavkdqFi286FuebQhzZDs5oYyTWaUsVddIJq
    MAkGZfhkFIOn+fvROSbATwtowJ20cYkswiH8QAVkuyS8jj+GlIxmK/4kyQ/HwKIvZmrbN3
    QixydvI/v5+XbtAn5xtcKNXGxxdISA0Fz49h7n7i1hcQ1g3h6X6AGfzFq3Zuj6Jcv3SqR9
    TdMaObJIcoaoNUOp+9v3vFVXydn9Wh/7J7/43Q4yiFui0cAYoKOY7uRiaR7nUiqmIqs6iN
    wT9IBpA3Gf9//85sMg+B4aWHoXiI2qIFSJS+r3xVz/OQrC/grxg6RyaZMxHRZjpHip2hWb
    nV4TjeeGkWySUcOuLPtmddZrcDMJWDVl3NfpJEoH+lhcKNyLtDI/pdrIjxy0m8jd9W/mFb
    1RZG3Lpt8uiHiNnQuuNDT43zZUP3lXCA3rmX2774jaRsX2HKZPwI463F925ihiZsparYKe
    WfjFyHNMqP04lQgDwsB+bE3st5R+rKhcPN+hgqpQmwQuwCaG7pLOIt81vcPxFk+Qct4rxK
    AwQJuebL1x+znRBIyG8CXuxCJroBXo8n4zeVWDnln7YISwc2sMGjRMy9IAIJUDJV9hhtVQ
    0ztf0mNYL7bSO3RsOtuKlavVb642LtReLdCaDoy+a3u5VCUbq7NTmfdjCpLA
X-ME-Proxy: <xmx:3-SxatPDWai9r1wGfmRtHvYBk8IPks9c9OCqCuHa2Y6L9KnalGoYHA>
    <xmx:3-SxauOqk9590bt-0mmLXwz9HsoIldGHoh9RrJ9L1BS6QsIbm-1H4Q>
    <xmx:3-SxapY1O7dwNRRbFud7AqmpQWAkOBUJR139SYgaz7urFhj99FqN0Q>
    <xmx:3-SxasjfgLuHtpO3xwBXnilGjmsTt2Xsk-W672lT3mKP-Dd49cWsVQ>
    <xmx:3-SxatYSbvaRCgvKhFHu2U2pl5SkTPmHcWMUfXGnQKKyITsV6tKHweQg>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Sep 2026 22:15:51 -0400 (EDT)
Date: Mon, 21 Sep 2026 20:13:31 -0600
From: Alex Williamson <alex@shazbot.org>
To: <mhonap@nvidia.com>
Cc: <jgg@ziepe.ca>, <ankita@nvidia.com>, <jic23@kernel.org>,
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
 <linux-kselftest@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 alex@shazbot.org
Subject: Re: [PATCH v5 09/27] vfio/pci: Add a generic excluded-range list
Message-ID: <20260921201331.0c54aaf5@shazbot.org>
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

This is kind of a backwards introduction.

"Now that a generic excluded-range list expresses the same fill/drop
behavior, register the MSI-X table as a read and write excluded range
instead of special-casing it in the read/write path."

The generic excluded-range list doesn't exist now, we're adding it
here.  We don't change MSI-X to use it until the next patch.  We're not
doing anything noted in the second paragraph in this patch either.  The
next patch has a nearly identical commit log, please be precise in what
each patch does.

> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
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

Better packed to move the bar to the end, it only needs to be a u8, but
is it instead better to make a per-BAR list and keep it sorted on
insert to avoid the runtime complexity?

There should be a comment somewhere relative to the list only being
filled at the already serialized open_device and therefore safe for
lockless access runtime.

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
> +	range->bar = bar;
> +	range->start = start;
> +	range->size = size;
> +	range->flags = flags;
> +	list_add_tail(&range->entry, &vdev->excluded_ranges);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_add_excluded_range);

If this does an ordered insert, I think we could also require that
ranges cannot overlap.  Everything we're considering currently, MSI-X
vector table, HDM registers, are distinct.  They could theoretically
overlap relative to the sparse mmap capability once page aligned, but
the excluded range list itself should only contain distinct,
non-overlapping ranges, and I think that simplifies things a little.

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
> +bool vfio_pci_bar_find_exclusion(struct vfio_pci_core_device *vdev, int bar,
> +				 loff_t pos, size_t count, bool iswrite,
> +				 size_t *x_start, size_t *x_end)
> +{
> +	u32 want = iswrite ? VFIO_PCI_EXCLUDE_WRITE : VFIO_PCI_EXCLUDE_READ;
> +	struct vfio_pci_excluded_range *range;
> +	bool found = false;
> +
> +	list_for_each_entry(range, &vdev->excluded_ranges, entry) {
> +		if (range->bar != bar || !(range->flags & want))
> +			continue;
> +		if (pos < range->start + range->size &&
> +		    pos + count > range->start) {
> +			/*
> +			 * A BAR can carry more than one excluded window (e.g.
> +			 * the MSI-X table and a CXL HDM decoder block). Return
> +			 * the overlapping window with the lowest start so the
> +			 * caller can walk them in order.
> +			 */
> +			if (!found || range->start < *x_start) {
> +				*x_start = range->start;
> +				*x_end = range->start + range->size;
> +				found = true;
> +			}

For example, we wouldn't need to iterate if the list were sorted.

> +		}
> +	}
> +
> +	return found;
> +}
> +
> +/* True when [start, start + len) on @bar overlaps an mmap-excluded range. */
> +static bool vfio_pci_bar_mmap_excluded(struct vfio_pci_core_device *vdev,
> +				       int bar, u64 start, u64 len)
> +{
> +	struct vfio_pci_excluded_range *range;
> +
> +	list_for_each_entry(range, &vdev->excluded_ranges, entry) {
> +		if (range->bar != bar ||
> +		    !(range->flags & VFIO_PCI_EXCLUDE_MMAP))
> +			continue;
> +		if (start < range->start + range->size &&
> +		    start + len > range->start)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/* A page-aligned mmap hole, derived from an mmap-excluded range. */
> +struct vfio_pci_mmap_hole {
> +	u64 start;
> +	u64 end;
> +};
> +
> +static int vfio_pci_mmap_hole_cmp(const void *a, const void *b)
> +{
> +	const struct vfio_pci_mmap_hole *x = a, *y = b;
> +
> +	if (x->start < y->start)
> +		return -1;
> +	return x->start > y->start;
> +}

We wouldn't need sorting if we just did an ordered insert.

> +
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
> +	sparse = kzalloc(size, GFP_KERNEL);
> +	if (!sparse) {
> +		kfree(holes);
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
> +		}
> +		pos = holes[i].end;
> +	}
> +	if (pos < bar_len) {
> +		sparse->areas[j].offset = pos;
> +		sparse->areas[j].size = bar_len - pos;
> +	}
> +
> +	kfree(holes);
> +	ret = vfio_info_add_capability(caps, &sparse->header, size);
> +	kfree(sparse);
> +	return ret;
> +}

I imagine this could be simplified quite a bit:

 - walk the list once, count mmap exclusions, if none return
 - allocate sparse structure assuming # mmap exclusions + 1 == # areas
 - walk list again aligning to page alignment, fill in areas, coalesce
   as needed, set resulting nr_areas.

> +
>  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>  				      unsigned int type, unsigned int subtype,
>  				      const struct vfio_pci_regops *ops,
> @@ -1160,6 +1359,10 @@ int vfio_pci_ioctl_get_region_info(struct vfio_device *core_vdev,
>  				if (ret)
>  					return ret;
>  			}
> +			ret = vfio_pci_excluded_sparse_cap(vdev, info->index,
> +							   caps);
> +			if (ret)
> +				return ret;
>  		}
>  
>  		break;
> @@ -1853,6 +2056,10 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>  	if (req_start + req_len > phys_len)
>  		return -EINVAL;
>  
> +	/* An excluded sub-range is reachable only through its trap, not mmap. */
> +	if (vfio_pci_bar_mmap_excluded(vdev, index, req_start, req_len))
> +		return -EINVAL;
> +
>  	/*
>  	 * Ensure the BAR resource region is reserved for use.
>  	 */
> @@ -2317,6 +2524,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	INIT_LIST_HEAD(&vdev->dmabufs);
>  	init_rwsem(&vdev->memory_lock);
>  	xa_init(&vdev->ctx);
> +	INIT_LIST_HEAD(&vdev->excluded_ranges);
>  
>  	ret = vfio_pci_core_cxl_init(vdev);
>  	if (ret)
> @@ -2332,6 +2540,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
>  
>  	vfio_pci_core_cxl_release(vdev);
> +	vfio_pci_free_excluded_ranges(vdev);
>  
>  	mutex_destroy(&vdev->igate);
>  	mutex_destroy(&vdev->ioeventfds_lock);
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 4e7162234a2e..c268c99aea82 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -44,6 +44,15 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite);
>  
> +/*
> + * If a read (or write) to [pos, pos + count) on @bar overlaps an excluded
> + * range, report the byte window do_io_rw() should fill with -1 (or drop) and
> + * return true. A single access spans at most one such window.
> + */
> +bool vfio_pci_bar_find_exclusion(struct vfio_pci_core_device *vdev, int bar,
> +				 loff_t pos, size_t count, bool iswrite,
> +				 size_t *x_start, size_t *x_end);
> +
>  #ifdef CONFIG_VFIO_PCI_VGA
>  ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite);
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 7f14dd46de17..48da1cb08296 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -261,6 +261,14 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  		x_end = vdev->msix_offset + vdev->msix_size;
>  	}
>  
> +	/*
> +	 * A provider-excluded sub-range is filled with -1 on read and dropped on
> +	 * write for the same reason: the guest reaches it only through the trap.
> +	 * An access spans at most one exclusion window.
> +	 */
> +	vfio_pci_bar_find_exclusion(vdev, bar, pos, count, iswrite,
> +				    &x_start, &x_end);
> +

This is not well integrated, we're stomping on the MSI-X and ROM set
exclusion range just above.  As a result, we likely need to integrate
support for both at the same time, and we also need to address the
multiple exclusion range per access range, that's only in the next
patch for some reason.

I don't think we want to move the pci_map_rom() call elsewhere, we try
to do it in correlation to the access.  People are crazy enough to
update device firmware while in use as well, so I'm not sure the length
read from the ROM is static.  Maybe this should instead be handled as a
hard stop at the end of the BAR vs a soft stop at the end of the data,
filled with -1 on read, and have that live outside the excluded range
list?  It needs some finesse, this is clunky.

Also, what about ioeventfds and dmabufs?  Thanks,

Alex

>  	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
>  				      count, x_start, x_end, iswrite, max_width);
>  
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 7f3a2bcb5830..92e3db116068 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -162,6 +162,7 @@ struct vfio_pci_core_device {
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
>  	struct list_head	dmabufs;
> +	struct list_head	excluded_ranges;
>  };
>  
>  enum vfio_pci_io_width {
> @@ -172,6 +173,19 @@ enum vfio_pci_io_width {
>  };
>  
>  /* Will be exported for vfio pci drivers usage */
> +/*
> + * A provider can keep a BAR sub-range off the direct guest path, reached only
> + * through its own trap. The flags select which paths are excluded: mmap, and
> + * region read and write (an excluded read fills -1, an excluded write is
> + * dropped).
> + */
> +#define VFIO_PCI_EXCLUDE_MMAP	BIT(0)
> +#define VFIO_PCI_EXCLUDE_READ	BIT(1)
> +#define VFIO_PCI_EXCLUDE_WRITE	BIT(2)
> +
> +int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev, int bar,
> +				     u64 start, u64 size, u32 flags);
> +
>  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>  				      unsigned int type, unsigned int subtype,
>  				      const struct vfio_pci_regops *ops,

