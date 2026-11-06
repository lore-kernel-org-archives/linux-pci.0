Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980788;
	b=YAil3AeTn5J2kNiKJ0gidHeHPCEv8J4wbtxUDPgahGQhbzY0+52mSbnQ8M9uc3+VKdEm
	 gUaqi+dzmyqS1sOK6SKT2UBlzlB3nzPIdeBvB8x5V7NPx9kFg6v/os5s0uxd0MvKabJqQ
	 p3z/A2nDB2J+DlMwLNl8tIwtt6OHcP7h8Tw17sEf/DaC4VmJOmLB+bc3Ki97Vs1EBCyOc
	 K3OWveplhM+A9nbPPd+IWSPik68LAjSB3gD/VLeBL41vOnQHofbL5OOALedYNrZvPK1AS
	 XPXteIviGTfFh7GRpvsz1zzJHyZyzuR+GXgIF783gaIuOhZ67TVX12ehakMRF5To4jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980788;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5vCHEs/V9pwMAPmRu7ggjXlWX/ar9c5h5bZvjFU/NuY=;
	b=Y6FVTO0ryRFKEkWgRd58PViTGIGu2l5eG/Q5WJLAvc7qvrQvDbXZBCIBVIawZLRh3yq5
	 PJOMyCKqSZJxCf/YmCAEz22uset/YxpYQv/JVbdBTbYqF1iY3I3IlhmQJ2VN3pQeuHVw2
	 oZo3x0EikLtOkWe3+RQ+SpGhHm+NCnZ7qdWYdYuXclbuAzsLCdtqzDWKzUIxgcewgsd3g
	 tVOfT4oYC8pmOa2G6Y3G3ITmjEYhNnk3t7arSOn7MTK4lq0VjQbz501lwT2DO5/tQB9P9
	 o0aXb6NjCG+HK5Z7U0y9PBGKfRv89gHTi6cxYTr1/hONodeONQ+NypbNV/2aMm5aIzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=nERuFrRL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="Z2//7IVs";
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1579D606A32D
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 15:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1579D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=nERuFrRL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Z2//7IVs
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 41FE5EC01CF
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 10:59:46 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 06 Nov 2026 10:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793980786;
	 x=1794067186; bh=5vCHEs/V9pwMAPmRu7ggjXlWX/ar9c5h5bZvjFU/NuY=; b=
	nERuFrRLTWYTI5xz0mw41UCpX7FH3vTABdoNJscvHHh/gDqqdGH7TKRh8W+DLUgy
	tj3KLLe+YCaw9Uv+3ChAJ0YnBFp2NcTSdGrbpQl79iyyzyRkbRA6reG59gM4YDOn
	BFXyGLvBND4jzoGeO7TnP4jXf8LpDN6BF5IQJCfzvjEaZNfitmsqcdG3ZaTkPtsn
	Cezkzl8OpvNR8KV3D+wN4huCbbKYHwlag1VV0gXUjOcu2MB3waGf2S9ObNE5QZJP
	zC41iNzBrZ/baSdQUtHYFhxzkpRR0etjsoSfaoCUGF4OK+E5X51tMA3DQFOWJoxN
	UGhewNR6EnHWEdQb1l2CvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793980786; x=
	1794067186; bh=5vCHEs/V9pwMAPmRu7ggjXlWX/ar9c5h5bZvjFU/NuY=; b=Z
	2//7IVsGyLgFWDQTyJFlcawLVyKEXf8AS1D25nd4BfdsvanttokG1zBxYwtBVdCJ
	aP2gsIX5sT0UrRPQ4w9TgE34prZE2iDrfMxvPV76JXB//HNbULxf5mbgIlDFqsr6
	9ZC7KeZVR8E0orAnskj5WeFKO41sTwMM32/+uKmPB6+uyxOt5A8eBDL4QYtuuQSY
	R6V+UrbOmA322mkRfpAI/U+0f/0u714Oney7HQPqKRmZnppXxtwc7X9YZnbOW3Xp
	VyROnJ1hwK4ixvi9he9koZkzCsZtMrkZzfrEgByyx3fRvb7Uh5sE7J6+qEtHh0bJ
	fQyRJeBaymwceD7aRRKvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793980786; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:U+m9oD+dCayPzO6SBrXTfQYY0TIlvBgvhHGzDsFA6+WVl3c
	q55GU24VeZzxyOYfL0EyWm7M/Vk4ElTtnat8tY/151AaTbsITrQFqu0/kuWA/l6N
	rK6egLHsQZ1cPp7EnZNWAqHo8gILyW/Yz4JTNcyUtvAGW2BhWvQHxrPUUCDeiBLG
	UU776eqgzrlcT8Hyiaggm38Z3xkY48Ju0RQKsaNW6AEqmohylvHKynMvaVS9M6Sg
	pSPBauK0D/XLh329FleEFhMvSUzYJ9hGhhcBfU8rkivF8QCbxceiSkmFJJwD+Ov6
	dbnEPWUiK5JuxrO5HtdRvDMYcoB89P4t6y1ChwQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:CBv6ZLQEXEPM/QvmFdsa7reN9JhcaJ97AJYWwHzfetI=:81TKJqx7C5qiiTvWEFzqK95usjHpuInXwJRUhFglNhg=;
X-ME-Sender: <xms:cfntarfKi8uqdpErz2J5U4rpxtOZ41MaPkmenwzc4OqEuykcC7I13A>
    <xme:cfntasBLkqQCvCQB1iyInoG8NNveaNX6CyW6vPGuLuTOs6FnPmrnK2BIssT0hMeyJ
    Pt6bns_BY1PgMoNrBHeekhbIrTKXDjITQoETC0xjW5GwbEdxENEriw>
X-ME-Received: <xmr:cfntaiyNgKn5xqpkEe7xf2F8ALcspO6H1jmZ0vEogO9iZF1kRGck3-iqM3soCQ>
X-ME-Proxy-Cause: dmFkZTFpUT5vBtxbnF/rnvk3LllbaN8gFpLNZfC6psZaVuAjZ2AADsNePuieI+jKlLbikJ
    GZoOIky3XhhbwcwbpxVc5KI/rWpFcmhFEfDDSSzHfGoZM2o23k5o7UpOTux9cqU5RTCDHK
    xYABdJQY+Kshd4AQeEPEGNe7hBkbw145KSxcKC4cHR1jNJnHJFVOD5xW56Eh3kW+NAtRWX
    cNa4A0YM84Z6+ydCIxRtrg1JF/CEsXK5jSdn8xdISlKQ/fDA68pbUWQp+SOJ3V0MyYe42Z
    SzHvx/hBcbCcsboQuFIaNmAof4Wseh8RGDxC1c6fLUk8/mrXgRoseDOjPHY8GNOYMP+iKU
    5ThjqqxsbGjuL7i+qK+081ep8fiUYETNa4jtiIeOexhAjw00zLFYCBdqiHUuAM5bcwzT0X
    +Uh7wvcKAslTF/AxFDIUjJRxY+0iETPeysggIiioj+j2m+0WDOxq7Scp/El0H6qFLMDlm9
    o1kcK+HtBQFcknQdHE7Zx5ayTcXwoMjeeoJqy6ony1yNhVjVg4hxIBAOR9FkfCVPDlWtdK
    f1T8wXktm3RV55jfyoLZXLYi9wuwW4TQN5SGqPG6IHtk/o3wXtq9D1NfkNCv8ww97C8BUg
    0edHAKRJU59npRS7BTS7ZvHy1yuiaKxJ1YQ0RJ7PBd+SxTaeRsIcNslmauxA
X-ME-Proxy: <xmx:cfntashbCQFnfXUc6hv2vGQmzCCYK630pYkP5PN2bzoJGlhI2Mp9pw>
    <xmx:cfntahdFYcnBgtFPSQvkdDincNG5ksX8L_pvMCvk7h2GAGCoaLp2yw>
    <xmx:cfntarVfj9BaexnCq2I2Sg0MtQocqRKiZ2getqdmOd5ChDhj2UZiLA>
    <xmx:cfntajx6OYsy9DSFO2T1GJYAAAxO-9Ygp7IQBEsD0JELrNa-plhpww>
    <xmx:cvntagsEMDxUFCpjoqrAndcmzhTqWg2xKKkyTyhPeBoo4hVD8gMDhEc0>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 10:59:42 -0500 (EST)
Date: Fri, 6 Nov 2026 08:59:39 -0700
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
Subject: Re: [PATCH v6 08/31] vfio/pci: Add a generic excluded-range list
Message-ID: <20261106085939.764b6dde@shazbot.org>
In-Reply-To: <20261016161839.2765592-9-mhonap@nvidia.com>
References: <20261016161839.2765592-1-mhonap@nvidia.com>
 <20261016161839.2765592-9-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 21:48:15 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> A provider such as vfio-cxl needs to keep sub-ranges of a BAR off the
> direct guest path and serve them through its own trap. vfio-pci-core
> already has one such window, the MSI-X table, open-coded in
> vfio_pci_bar_rw().
> 
> Add vfio_pci_core_add_excluded_range(). Each BAR has its own list,
> sorted by start, and an insert that overlaps a range on the same BAR or
> ends past the BAR fails with -EINVAL. Ranges are added only while the
> device is being opened and are freed in vfio_pci_core_disable(), so
> readers on an open device take no lock.
> 
> The MSI-X table is virtualized in vfio_pci_bar_rw() by an open-coded
> x_start/x_end window that fills reads with -1 and drops writes. Register
> the MSI-X table as a read and write excluded range when the MSI-X
> capability is parsed in vfio_pci_core_enable(), and walk the BAR's
> ranges in order in vfio_pci_bar_rw(), so an access that spans several
> ranges is handled in one pass. Only the part of the table inside its BAR
> is registered, so a device whose MSI-X capability points outside the BAR
> still opens, as before. The ROM BAR keeps its trailing -1 window,
> outside the list.
> 
> No behavioral change for an MSI-X table in a standard BAR: an access to
> it still reads -1 and drops writes.
> 
> Assisted-by: LLM
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 97 ++++++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_priv.h |  8 +++
>  drivers/vfio/pci/vfio_pci_rdwr.c | 67 +++++++++++++++++++---
>  include/linux/vfio_pci_core.h    | 20 +++++++
>  4 files changed, 185 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index e50b36751d9a..bee3d1b4d8d2 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -588,6 +588,8 @@ static const struct dev_pm_ops vfio_pci_core_pm_ops = {
>  			   NULL)
>  };
>  
> +static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev);
> +
>  int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  {
>  	struct pci_dev *pdev = vdev->pdev;
> @@ -644,6 +646,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  
>  	msix_pos = pdev->msix_cap;
>  	if (msix_pos) {
> +		u64 bar_len = 0;
>  		u16 flags;
>  		u32 table;
>  
> @@ -654,6 +657,30 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>  		vdev->msix_offset = table & PCI_MSIX_TABLE_OFFSET;
>  		vdev->msix_size = ((flags & PCI_MSIX_FLAGS_QSIZE) + 1) * 16;
>  		vdev->has_dyn_msix = pci_msix_can_alloc_dyn(pdev);
> +
> +		/*
> +		 * Virtualize the MSI-X table through the excluded-range list:
> +		 * reads fill -1 and writes are dropped so the guest never
> +		 * reaches the hardware table directly. BAR access never goes
> +		 * past the BAR, so only the part of the table inside the BAR
> +		 * needs a range; a table placed outside its BAR needs none.
> +		 */

AI comments.

> +		if (vdev->msix_bar < PCI_STD_NUM_BARS)
> +			bar_len = pci_resource_len(pdev, vdev->msix_bar);
> +		if (vdev->msix_offset < bar_len) {
> +			u64 len = min_t(u64, vdev->msix_size,
> +					bar_len - vdev->msix_offset);
> +
> +			ret = vfio_pci_core_add_excluded_range(vdev, vdev->msix_bar,
> +							       vdev->msix_offset, len,
> +							       VFIO_PCI_EXCLUDE_READ |
> +							       VFIO_PCI_EXCLUDE_WRITE);

This is not a terribly elegant flow and I think the AI comment above
misses the main point of what the apparently redundant BAR range and
size cap test are trying to accomplish, compatibility.

In the current code, it doesn't matter if BIR is bogus or the offset
doesn't land in the BAR length or size overflows, those just generate
non-matches when we read or write.

I think this would be cleaner as a separate function that wraps the new
function, returning success (perhaps even with a pci_warn_once) for an
out of range BIR or offset, and performs silent cleanup on a range that
exceeds the BAR, with a human generated comment explaining the
compatibility argument.

> +			if (ret) {
> +				vfio_pci_free_excluded_ranges(vdev);
> +				vfio_config_free(vdev);
> +				goto out_free_zdev;

This is mixing local cleanup with an unwind goto and it bites us later
in the series when we end up leaving this in place and adding:

out_free_config:
        /* A failed first open never reaches vfio_pci_core_disable(). */
        vfio_pci_core_free_dev_regions(vdev);
        vfio_pci_core_unmap_bars(vdev);
        vfio_pci_free_excluded_ranges(vdev);
        vfio_config_free(vdev);

after the cxl open.

> +			}
> +		}
>  	} else {
>  		vdev->msix_bar = 0xFF;
>  		vdev->has_dyn_msix = false;
> @@ -740,6 +767,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>  	vdev->region = NULL; /* don't krealloc a freed pointer */
>  
>  	vfio_config_free(vdev);
> +	vfio_pci_free_excluded_ranges(vdev);

Order is wrong, should be reverse of setup order.  Also doesn't match
the correct ordering used in the error unwind above.

>  
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		bar = i + PCI_STD_RESOURCES;
> @@ -1012,6 +1040,72 @@ static int msix_mmappable_cap(struct vfio_pci_core_device *vdev,
>  	return vfio_info_add_capability(caps, &header, sizeof(header));
>  }
>  
> +/**
> + * vfio_pci_core_add_excluded_range() - keep a BAR sub-range off direct access

"Exclude a BAR sub-range from user access"

> + * @vdev: vfio PCI device being opened
> + * @bar: BAR index, below PCI_STD_NUM_BARS
> + * @start: offset of the range in @bar
> + * @size: length of the range in bytes
> + * @flags: VFIO_PCI_EXCLUDE_* paths the range is excluded from
> + *
> + * Call only while the device is being opened, from vfio_pci_core_enable() or
> + * a provider's open hook; vfio_pci_core_disable() frees the ranges. Ranges on
> + * one BAR must not overlap and must lie inside the BAR.

Are we pushing an overly complicated model just to align with MSI-X?

I think MSI-X is configured on open_device because it's trivial.  Just
a couple config reads and extract the info.  Now it's becoming more
complicated with allocations and lists, and I'm not sure why it doesn't
at the same time move to the .init and .release callbacks instead.

The AI comment also skips the important note reminding us that the
exclude list is lockless and must be immutable while the device is
opened, wherever we decide that boundary should be.

> + *
> + * Return: 0 on success, -EINVAL for an invalid or overlapping range or one
> + * that ends past the BAR, or -ENOMEM.
> + */
> +int vfio_pci_core_add_excluded_range(struct vfio_pci_core_device *vdev, int bar,
> +				     u64 start, u64 size, u32 flags)
> +{
> +	const u32 valid = VFIO_PCI_EXCLUDE_MMAP | VFIO_PCI_EXCLUDE_READ |
> +			  VFIO_PCI_EXCLUDE_WRITE;
> +	struct vfio_pci_excluded_range *range, *pos;
> +	struct list_head *head;
> +
> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS || !size ||
> +	    start + size < start || !flags || (flags & ~valid))
> +		return -EINVAL;
> +	if (start + size > pci_resource_len(vdev->pdev, bar))
> +		return -EINVAL;
> +
> +	/* Keep the list sorted by start; find the first range after @start. */
> +	head = &vdev->excluded_ranges[bar];
> +	list_for_each_entry(pos, head, entry) {
> +		if (start < pos->start + pos->size && start + size > pos->start)
> +			return -EINVAL;
> +		if (pos->start > start)
> +			break;
> +	}
> +
> +	range = kmalloc_obj(*range);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	*range = (struct vfio_pci_excluded_range) {
> +		.start = start,
> +		.size = size,
> +		.flags = flags,
> +	};
> +	list_add_tail(&range->entry, &pos->entry);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(vfio_pci_core_add_excluded_range);
> +
> +static void vfio_pci_free_excluded_ranges(struct vfio_pci_core_device *vdev)
> +{
> +	struct vfio_pci_excluded_range *range, *tmp;
> +
> +	for (int bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +		list_for_each_entry_safe(range, tmp, &vdev->excluded_ranges[bar],
> +					 entry) {
> +			list_del(&range->entry);
> +			kfree(range);
> +		}
> +	}
> +}
> +
>  int vfio_pci_core_register_dev_region(struct vfio_pci_core_device *vdev,
>  				      unsigned int type, unsigned int subtype,
>  				      const struct vfio_pci_regops *ops,
> @@ -2317,6 +2411,8 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
>  	INIT_LIST_HEAD(&vdev->dmabufs);
>  	init_rwsem(&vdev->memory_lock);
>  	xa_init(&vdev->ctx);
> +	for (int bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		INIT_LIST_HEAD(&vdev->excluded_ranges[bar]);
>  
>  	ret = vfio_pci_core_cxl_init(vdev);
>  	if (ret)
> @@ -2332,6 +2428,7 @@ void vfio_pci_core_release_dev(struct vfio_device *core_vdev)
>  		container_of(core_vdev, struct vfio_pci_core_device, vdev);
>  
>  	vfio_pci_core_cxl_release(vdev);
> +	vfio_pci_free_excluded_ranges(vdev);
>  
>  	mutex_destroy(&vdev->igate);
>  	mutex_destroy(&vdev->ioeventfds_lock);
> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
> index 4e7162234a2e..53544e0cbedf 100644
> --- a/drivers/vfio/pci/vfio_pci_priv.h
> +++ b/drivers/vfio/pci/vfio_pci_priv.h
> @@ -44,6 +44,14 @@ ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
>  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite);
>  
> +/* A BAR sub-range kept off direct access; see vfio_pci_core_add_excluded_range() */
> +struct vfio_pci_excluded_range {
> +	struct list_head	entry;
> +	u64			start;
> +	u64			size;
> +	u32			flags;
> +};

If we used struct range as a member here we could use range_contains()
and range_overlaps(), for finding a matching range below and avoiding
conflicts above (mind the inclusive end).

> +
>  #ifdef CONFIG_VFIO_PCI_VGA
>  ssize_t vfio_pci_vga_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite);
> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
> index 7f14dd46de17..93823c6391f6 100644
> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> @@ -198,6 +198,57 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>  }
>  EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
>  
> +/*
> + * Access @count bytes of @bar at @pos, walking the BAR's excluded ranges in
> + * order: a range excluded for this direction reads as -1 and drops writes,
> + * and the bytes around it reach the device. The MSI-X table is one such
> + * range, and a BAR can hold several, for example the MSI-X table and a CXL
> + * HDM decoder block.
> + */
> +static ssize_t vfio_pci_bar_do_io_rw(struct vfio_pci_core_device *vdev,
> +				     int bar, bool test_mem, void __iomem *io,
> +				     char __user *buf, loff_t pos,
> +				     size_t count, bool iswrite,
> +				     enum vfio_pci_io_width max_width)
> +{
> +	u32 want = iswrite ? VFIO_PCI_EXCLUDE_WRITE : VFIO_PCI_EXCLUDE_READ;
> +	struct vfio_pci_excluded_range *range;
> +	ssize_t done = 0;
> +	ssize_t ret;
> +
> +	list_for_each_entry(range, &vdev->excluded_ranges[bar], entry) {
> +		u64 end = range->start + range->size;
> +		size_t chunk;
> +
> +		if (!(range->flags & want) || end <= pos)
> +			continue;
> +		if (range->start >= pos + count)
> +			break;
> +
> +		/* Up to the end of this range; do_io_rw() fills it. */
> +		chunk = min_t(u64, count, end - pos);
> +		ret = vfio_pci_core_do_io_rw(vdev, test_mem, io, buf, pos, chunk,
> +					     range->start, end, iswrite,
> +					     max_width);
> +		if (ret < 0)
> +			return done ?: ret;
> +
> +		done += ret;
> +		pos += ret;
> +		buf += ret;
> +		count -= ret;
> +		if (!count)
> +			return done;
> +	}
> +
> +	ret = vfio_pci_core_do_io_rw(vdev, test_mem, io, buf, pos, count, 0, 0,
> +				     iswrite, max_width);
> +	if (ret < 0)
> +		return done ?: ret;
> +
> +	return done + ret;
> +}

This is mixing fault semantics.  Currently on fault we return the
errno, regardless of work that's been done.  With this, we potentially
return a short read/write on fault if later errors occur.  That short
return is not necessarily representative of the length of the actual
operation, a partial operation in the last call to core_do_io_rw is
discarded.

Therefore, I think both of the above (ret < 0) return branches should
just return ret, not the potentially incorrect done value.


> +
>  ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  			size_t count, loff_t *ppos, bool iswrite)
>  {
> @@ -256,13 +307,15 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>  		}
>  	}
>  
> -	if (bar == vdev->msix_bar) {
> -		x_start = vdev->msix_offset;
> -		x_end = vdev->msix_offset + vdev->msix_size;
> -	}
> -
> -	done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM, io, buf, pos,
> -				      count, x_start, x_end, iswrite, max_width);
> +	if (bar == PCI_ROM_RESOURCE)
> +		done = vfio_pci_core_do_io_rw(vdev, res->flags & IORESOURCE_MEM,
> +					      io, buf, pos, count, x_start,
> +					      x_end, iswrite, max_width);
> +	else
> +		done = vfio_pci_bar_do_io_rw(vdev, bar,
> +					     res->flags & IORESOURCE_MEM, io,
> +					     buf, pos, count, iswrite,
> +					     max_width);

Seems like the wrong refactor to add a ROM specific branch, we should
probably instead precede the excluded range loop by a test for a
standard BAR and non-empty excluded range list.  That might mean the
new function is reduced to only the excluded range handling and all
non-excluded range handling falls through to a common call to the core
function.

>  
>  	if (done >= 0)
>  		*ppos += done;
> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
> index 7f3a2bcb5830..70acb03d466e 100644
> --- a/include/linux/vfio_pci_core.h
> +++ b/include/linux/vfio_pci_core.h
> @@ -162,6 +162,13 @@ struct vfio_pci_core_device {
>  	struct notifier_block	nb;
>  	struct rw_semaphore	memory_lock;
>  	struct list_head	dmabufs;
> +	/*
> +	 * Excluded BAR sub-ranges, one list per BAR, sorted by start and not
> +	 * overlapping. The lists are filled only while the device is being
> +	 * opened and emptied in vfio_pci_core_disable(); every reader runs on
> +	 * an open device in between, so readers take no lock.
> +	 */

I'll stop noting these, but I expect all gratuitous AI comments to be
removed by default and evaluated as a human whether a comment is
warranted.  AI assistance doesn't relieve authors of the responsibility
to perform a thorough human self review.  /dismount-soapbox
Thanks,

Alex

> +	struct list_head	excluded_ranges[PCI_STD_NUM_BARS];
>  };
>  
>  enum vfio_pci_io_width {
> @@ -172,6 +179,19 @@ enum vfio_pci_io_width {
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

