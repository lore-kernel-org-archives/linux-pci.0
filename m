Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89F61D63F3;
	Sat, 12 Sep 2026 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789174994; cv=none; b=b9VsTRaLUzNLYIk9QO4wdBj7YKaL9KuCb8FbvHwzOhD1W9PdPCcz2aci9ZaGT/Ry8hoSjiPZ6+MKtcpwcilGxZJXKP3dltfwCUKFWJ4DpUHby4cxXvpKZ9uITgFMGin0Shk0kjuTAmbrcUx7tAcyW0I7nKhwXy8au3Mn+1QrwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789174994; c=relaxed/simple;
	bh=8MkNwe5RstKs9Kd2HvvwPHFzjCuvRoRcQpOVrYM0pc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmUQGhQCKKiZCjDTOwGbSG9P4dxQHChKeftKhM+FDVIod5ep6mkGdmrxMgun5REmK8JP2Eyxk8pNHjkRjuPQBPDpI53NNS8misXPnON6FKwtF+RHitaqrl/uAyI8u0vbxBK6/KY7LlFBzHIZlsjh90EAU26kXln228bThGCD3h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW39ZZUw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW39ZZUw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426931F000FF;
	Sat, 12 Sep 2026 01:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789174992;
	bh=AJ46AAeoNGVFUj9R6LYnyRog+WYh7ZcgP75I2J2b0og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XW39ZZUwu0G4g0c03wd1172SHr91Hw8XvR0KwrVYBMkzLV/phBpWVTZwlaBHSJeGQ
	 czRoGb1tU/0wqv6G0evwVQeWPEQ6BG3iLLGH1nFm9Xg6Zf3Juq5hIleDCdvZQJUYib
	 1wZ4a49nsM4fPsX0fD9jJBz4lEP2xtbLUdQF7sLcPUCRJihvm4E3muYyEp/YAove74
	 O1CiXepzFoO+2TQT/QLxaIxVSFDJsuZVtjsc4qIYU6y5rFy4JHi8talNGfOZ882ZfS
	 AphwRPOAgPZG4YaoZ8NnGOYWheLfEm+nTeb5lpjKbbW5I933M+MPrB7JCCiTA6/ozJ
	 yeYK3BlCKChOQ==
Date: Sat, 12 Sep 2026 02:03:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: Alison Schofield <alison.schofield@intel.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, vsethi@nvidia.com, alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, Vishal Aslot
 <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v12 05/12] cxl: Cache endpoint decoder settings during
 PCI enumeration
Message-ID: <20260912020305.64278c3e@jic23-hlaptop>
In-Reply-To: <20260910070808.1444264-6-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
	<20260910070808.1444264-6-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Sep 2026 07:08:01 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Populate pci_dev->hdm for CXL.mem functions from pci_bus_add_device(),
> after final PCI fixups and state save but before driver binding. This
> gives driver-free reset paths an early HDM snapshot while avoiding the
> pre-resource-assignment window in PCI capability initialization.
> 
> Use the CXL Register Locator BAR Indicator to find the component register
> BAR, reject unassigned, disabled, or zero memory BAR resources before
> temporarily enabling Memory Space, and restore the original PCI_COMMAND
> value before returning. Cache the CXL Device DVSEC control register with
> the HDM state for reset recovery before a driver can alter it.
> 
> CXL core refreshes the cache as decoders are committed or reset, and keeps
> the cached DVSEC control synchronized when CXL.mem is enabled or disabled.
> Move the register helpers into the built-in CONFIG_CXL_RESET set so the
> early cache path is available without cxl_core, and keep the cxl-test mock
> core from building a duplicate regs.o.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
Hi Srirangan,

Unless I'm reading this wrong, this has evolved to the point that it
needs a step back and a rethink.  There is complexity in here I
don't think you need at all.  I may well be missing something
though given it's Friday evening!

Jonathan


> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index e6aa55079c76..6d9f8fe14b16 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c
> @@ -2,9 +2,17 @@
>  /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxl/pci.h>
>  
>  #include "cxl.h"
>  #include "core.h"
> @@ -156,3 +164,331 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
>  				  &settings->interleave_granularity);
>  }
>  EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_decode_decoder, "cxl_core");
> +
> +struct cxl_hdm_decoder_state {
> +	u32 ctrl;
> +	u32 base_low;
> +	u32 base_high;
> +	u32 size_low;
> +	u32 size_high;
> +	u32 target_low;
> +	u32 target_high;
> +};
> +
> +static void cxl_pci_hdm_info_free(struct cxl_hdm_info *info)
> +{
> +	if (!info)
> +		return;
> +
> +	kfree(info->decoder_state);
> +	kfree(info);
> +}
> +
> +DEFINE_FREE(cxl_pci_hdm_info, struct cxl_hdm_info *,
> +	    cxl_pci_hdm_info_free(_T))
> +
> +void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info = pdev->hdm;
> +
> +	pdev->hdm = NULL;

If the order here matters, you need a barrier or WRITE_ONCE() might
do it.

> +	cxl_pci_hdm_info_free(info);
> +}
> +
> +static bool cxl_pci_bar_usable(struct pci_dev *pdev, int bar)

This doesn't seem to have anything CXL specific about it.  Maybe
give it a more generic name and move it to pci.c?
However, see later - I'm not sure you need this.

> +{
> +	struct resource *res = &pdev->resource[bar];
> +
> +	if (!pci_resource_len(pdev, bar))
> +		return false;
> +	if (res->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED))
> +		return false;
> +	if (resource_type(res) != IORESOURCE_MEM)
> +		return false;
> +	if (!res->start || !res->end)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
> +				resource_size_t hdm_size, int *bar,
> +				resource_size_t *offset)
> +{
> +	resource_size_t hdm_end;
> +
> +	if (!hdm_size)
> +		return -EINVAL;
> +
> +	hdm_end = hdm_start + hdm_size - 1;
> +	if (hdm_end < hdm_start)
> +		return -EINVAL;
> +
> +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {

This feels unduly painful and overly specific to this case.
It is just looking for a resource to bar and offset.

It is not CXL specific so maybe ask Bjorn if such a helper might go
in pci.c (assuming not discussed and dismissed in earlier rounds of
review!)  I'd still like it to mention hdm or anything even if
local to here.
static int cxl_pci_find_resource_bar(struct pci_dev *pdev,
				     resource_size_t start, resource_size_t size,
				     int *bar, resource_size_t *offset)

Noted later, you can skip this entirely as this is going in a circle.

> +		struct resource *res = &pdev->resource[i];
> +
> +		if (!cxl_pci_bar_usable(pdev, i))
> +			continue;
> +		if (hdm_start < res->start || hdm_end > res->end)
> +			continue;
> +
> +		if (bar)
> +			*bar = i;
> +		if (offset)
> +			*offset = hdm_start - res->start;
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}

> +
> +static void cxl_pci_hdm_read_decoder_state(struct cxl_hdm_decoder_state *state,
> +					   void __iomem *hdm, int id)
> +{
> +	state->ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	state->base_low = readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	state->base_high = readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	state->size_low = readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +	state->size_high = readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	state->target_low = readl(hdm + CXL_HDM_DECODER0_TL_LOW(id));
> +	state->target_high = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(id));
> +}
> +
> +static int cxl_pci_hdm_read_decoder(struct pci_dev *pdev,
> +				    struct cxl_hdm_decoder_state *state,
> +				    struct cxl_decoder_settings *settings,
> +				    void __iomem *hdm, int id)
> +{
> +	u64 target_or_skip, base, size;
> +	int rc;
> +
> +	cxl_pci_hdm_read_decoder_state(state, hdm, id);
> +
> +	base = ((u64)state->base_high << 32) | state->base_low;
> +	size = ((u64)state->size_high << 32) | state->size_low;
> +	target_or_skip = ((u64)state->target_high << 32) | state->target_low;

I'm not sure I get why we cache the registers and the stuff derived from them.
Why isn't one source of info enough? Or do the have different lifetimes?
If they do then add a comment to structure definition on that.

> +
> +	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
> +				    target_or_skip, NULL);
> +	if (rc) {
> +		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +	return 0;
> +}

> +
> +static int __cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				   struct cxl_register_map *map,
> +				   struct cxl_hdm_info *info)
> +{
> +	struct cxl_decoder_settings *settings;
> +	int decoder_count;
> +	int rc;
> +
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return rc;
> +
> +	if (!map->component_map.hdm_decoder.valid)
> +		return -ENODEV;
> +
> +	void __iomem *hdm __free(cxl_hdm_iounmap) =
> +		cxl_pci_hdm_map(pdev, map, info);
> +	if (IS_ERR(hdm))
> +		return PTR_ERR(no_free_ptr(hdm));
> +
> +	decoder_count = cxl_hdm_decoder_count(readl(hdm +
> +						    CXL_HDM_DECODER_CAP_OFFSET));

Go long on lines like this.  As long as you stay only a bit over 80 no one will
mind.

> +	if (decoder_count < 0)
> +		return decoder_count;
> +
> +	if (decoder_count > ARRAY_SIZE(info->settings))
> +		return -ENXIO;
> +
> +	if (CXL_HDM_DECODER0_CTRL_OFFSET(decoder_count - 1) + 0x10 >

That 0x10 needs to be a define or other useful code. I have no idea what
it is...

> +	    info->hdm_size) {
> +		pci_err(pdev,
> +			"CXL HDM decoder count exceeds mapped register block\n");
> +		return -ENXIO;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	info->decoder_state = kcalloc(decoder_count,
> +				      sizeof(*info->decoder_state),
> +				      GFP_KERNEL);

That's same size as settings, so put the two of them a struct at the end of
cxl_hdm_info with a short name (e.g. decoder[].state, decoder[].settings) and
use a struct_size() allocation for them both.

> +	if (!info->decoder_state)
> +		return -ENOMEM;
> +
> +	settings = info->settings;
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
> +					      &settings[i], hdm, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				 struct cxl_register_map *map,
> +				 struct cxl_hdm_info *info)
> +{
> +	bool restore_command;
> +	u16 command;
> +	int rc, rc2;
> +
> +	guard(pci_dev)(pdev);
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	restore_command = !(command & PCI_COMMAND_MEMORY);
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +	}
> +
> +	rc = __cxl_pci_hdm_read_info(pdev, map, info);
> +
> +	if (!restore_command)
> +		return rc;
> +
> +	rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (rc2) {
> +		rc2 = pcibios_err_to_errno(rc2);
> +		pci_err(pdev,
> +			"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +			rc2);

> +		if (!rc)
> +			rc = rc2;
> +	}
Dance is more complex to read than just duplicating a little.

	if (rc)
		goto reset_command_reg

	return pci_write_config_word(pdev, PCI_COMMAND, command);

reset_command_reg:
	if (pci_write_config_word(pdev, PCI_COMMAND, command) !=
	    PCIBIOS_SUCCESSFUL)
		pci_err(pdev, ...);

I doubt we care about what return of that is given we are on fire.

	return rc;

> +
> +	return rc;
> +}
> +
> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	struct cxl_register_map map = { 0 };

The 0 doesn't add anything = { };

> +	int dvsec;
> +	int rc;
> +
> +	if (!cxl_pci_hdm_capable(pdev))
> +		return -ENOTTY;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
So this reads the regblock locator to get where the component regs are
by decodeing the bar and offset then finding the resource form that...
> +
> +	rc = cxl_pci_hdm_find_bar(pdev, map.resource, map.max_size, NULL, NULL);
> +	if (rc)
> +		return rc;
This takes the resource and finds the bar and offset?

Going in circles. Can't you pull a helper out of the start of
cxl_decode_regblock() and get the bar and offset directly.
Even if you need the sanity checks along the way, I think you can
do them more directly and only go in one direction.

> +
> +	struct cxl_hdm_info *info __free(cxl_pci_hdm_info) =
> +		kzalloc_obj(*info, GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;

Why allocate here when so much can still fail?  We don't need
it for a few more calls.

> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				  &info->dvsec_ctrl);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +	info->dvsec_ctrl_valid = true;
> +

I'd make this read and allocate - having found the size so we don't
allocate more than necessary.  If any crazy device changes number of
decoders on reset then we can just clamp it and print a rude message.

> +	rc = cxl_pci_hdm_read_info(pdev, &map, info);
> +	if (rc)
> +		return rc;
> +
> +	pdev->hdm = no_free_ptr(info);
> +
> +	return 0;
> +}
> +
> +void pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	int rc;
> +
> +	rc = __pci_cxl_hdm_init(pdev);
> +	if (rc && rc != -ENOTTY && rc != -ENODEV)
> +		pci_dbg(pdev, "CXL HDM cache init failed: %d\n", rc);
> +}


