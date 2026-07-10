Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44F13B58C;
	Fri, 10 Jul 2026 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783644487; cv=none; b=lG88XMWoNAKvBmLYDVTAwEtz5vRwxLaP3PFvwxExNf+C6EbbzsLsJnJqQXGFyqN7pSo7fUbzTXW9LzWH/SymN9JB1m+4cxuMQYvqSKGd2noklAuj4wbia+b8wl5Bx3wpeRdU9ms5M9BAIdq6D0FFzYZAldsViEqqeIDsLiKbb3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783644487; c=relaxed/simple;
	bh=1rTLZOGkuFC5pAZ6g6/rNfMiuQJvPvcNzswdteI63ME=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FezMQPue10bNnHFJ9HjYW7X0h8n1WGrykjyPXC7ktQOTEFdZSTVZhG+HSHP/c4rkm+jvAXeNmgs6QThJIzERn+B/aN/EjwH4XSkLv+E3gt9wOY/zk+UWlB1eJEjZK+znKy1CmDbgUjwKPgt6FDrDbrgDGtAD+cpUbsfAa/YJhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqhLesfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqhLesfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4321F000E9;
	Fri, 10 Jul 2026 00:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783644486;
	bh=uDX+UXw+iRrcq6w7q663nafyg7itD38w/KC0N+AvHyE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=YqhLesfmVZOpXFLHAyk3hwppemwKNbH0cu9YQZrEtYSmLaZOW4E7RbmQFii0ZYTYA
	 EX1/BIY662sWVmX8+lViNTHdWkVjmGlfYLA8JCYWln6Kg00/C2573tItnpLAiDLXg7
	 4n3HRkr3ipNR8GhTIIINuUL9t2IUoVk6C9OVchHYzqI5u9oQLiIlg12l4CAj+/uWbo
	 spOwGC+mg+ZHkVaPeJYJ0NLyM5eHRb9lrTYYDcezJssB/lgUwRyrRXJsljV1FxuYUY
	 8um+Tbdjl67F2cjiGfHmqC1mvgBmV7BConSN2XWyXL4XuM+bmHuJbiBOLPX+vzTFmR
	 Kg3fmu2RnpT7w==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id C2CE3F40068;
	Thu,  9 Jul 2026 20:48:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 20:48:04 -0400
X-ME-Sender: <xms:REFQarYTpRKGOHxlgUETPUN5x3v__-l7V8n6ugBPgj8EVu04baS5yw>
    <xme:REFQaq2vM1vZtAFnDqdNyumJaqGLyc3pPMuRr1nztryIWusSmy6T20XH-jshmWzuq
    JQFeXXPk0OjA4SuqPB6-sK0n9zdMQcwwhsFI2YWD5OWEUL76lYi9QU>
X-ME-Received: <xmr:REFQajZ-ERP8QKwQctT6L_T8q48rnYEDWUjX7FoyXeYzEOO-vFYbj3RF2beFKvxtPkQg0zh3vroFRWGrakyH9Oc_qlamM-O5yZA>
X-ME-Proxy-Cause: dmFkZTF3gdlp/Vpg3xaP425RWWk50euOBYGo+xKlz++Pc7lxWNW56Kax9ay5zz8ZwcTXol
    nsAYwBVzSJJWc0JED9nwjEG9VFRkrYuE/Y28vPrnPbB8uMvMwG6Nb1dh2SVP/XYot6Yajf
    oISVrFrnUkzx7AonAqC1bxTQ6mHeGQaxSns/zJ/LLpNrsePTn0Q9lDlfFgcwiROXoT3JT0
    UIa5il8xf4nM3PHv1LEu6yF6a8F3FfUuCGKfIkFupTczfjMGuhu5W0ZrDYzj84Ju23hFQf
    MhRjjHpvWiZ+A1k37f/c1iYzhQq+vCXjc5piht4oMn8vScQWQZVzhBeFqCCPqT37B1yMnx
    +VN5yGnfPboWduSSns60xKxNHiz3++nywnT2Bj/iHMLAEYFc0b7KMgARX+ywWhcexA4tqL
    pCa7LnxvIXPKZrSUGH4lys+G9ekatNjR5ymsauZyiBjbfWudF7yUh4zBb/KUaqc9s+xOpP
    8HDPYDK2kOW4nS59/ukaHpd6zsjeWLlVb5yiw8oCmkG+OWO/bVQSjcmTXJMn4iDqF5fEcW
    FlYVXOnyhkGaCh3slAGL0wfjGntf1QILdGifOLpwLIDr+xVZU384wmd5/le/RjsworDDci
    9q48M38q81jGIbg4Ie3qiMzEYgS1hXqaJ8MJzEZzKDVc0ssFtEsGGLGYiZVw
X-ME-Proxy: <xmx:REFQavmX1xn1ebstspWbd5bemHPK87YPyGx6raSDCkiLlMYY2R7dgg>
    <xmx:REFQaqfjmLJS3L3JX_uf1HvEXZOugZoT89UjHKCXkrUTu7YcTwpXEA>
    <xmx:REFQal3_XS10DfWILtO2qXueuCPn6s4s3ocyEWpFlMCLgxj3HV1oMw>
    <xmx:REFQavkt8Troj89ihqm1nj7dUSloVr_9JpJ3JlYFzBftQxl-RY52Hw>
    <xmx:REFQaubvm91_i4YtapURy3y47BjNxT6eK3TeAwgEjhTaOx54b-NkCjor>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Jul 2026 20:48:03 -0400 (EDT)
Date: Thu, 09 Jul 2026 17:48:03 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 linux-cxl@vger.kernel.org, 
 linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>, 
 vsethi@nvidia.com, 
 alwilliamson@nvidia.com, 
 Dan Williams <danwilliams@nvidia.com>, 
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>, 
 Vishal Aslot <vaslot@nvidia.com>, 
 Manish Honap <mhonap@nvidia.com>, 
 Jiandi An <jan@nvidia.com>, 
 Richard Cheng <icheng@nvidia.com>, 
 linux-tegra@vger.kernel.org, 
 Srirangan Madhavan <smadhavan@nvidia.com>
Message-ID: <6a50414371e3_3cabcb1007e@djbw-dev.notmuch>
In-Reply-To: <20260709010304.680422-5-smadhavan@nvidia.com>
References: <20260709010304.680422-1-smadhavan@nvidia.com>
 <20260709010304.680422-5-smadhavan@nvidia.com>
Subject: Re: [PATCH v9 04/11] cxl: Cache endpoint decoder settings during PCI
 enumeration
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Srirangan Madhavan wrote:
> Populate pci_dev->hdm from PCI capability initialization for CXL.mem
> functions. If Memory Space Enable is clear, temporarily set it while
> reading HDM MMIO and restore the original PCI_COMMAND value before
> returning. This gives driver-free reset paths an early HDM snapshot.
> 
> CXL core later reuses and refreshes the same cache. Move the register
> helpers into the built-in CONFIG_CXL_HDM set so the early cache path is
> available without cxl_core.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
[..]
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 4c977fc47f8d..97b72cc67b6b 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c

To Dave's point, and now the fact that Manish needs this information too
for VFIO, it probably best to call this file
drivers/cxl/core/resource.c. The scheme being PCI Core caches PCI MMIO
resource in the pdev, and CXL Core caches CXL HPA resources in the pdev.

> @@ -2,9 +2,16 @@
>  /* Copyright(c) 2026 NVIDIA Corporation. All rights reserved. */

Should be "Copyright (c) 2026 NVIDIA Corporation & Affiliates"

...no requirement for All rights reserved.

>  #include <linux/delay.h>
>  #include <linux/bug.h>
> +#include <linux/bitfield.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
>  #include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/slab.h>
> +
> +#include <cxlpci.h>
>  
>  #include "cxl.h"
>  #include "core.h"
> @@ -161,3 +168,284 @@ int cxl_hdm_decode_decoder(struct cxl_decoder_settings *settings, int id,
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
> +void pci_cxl_hdm_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		pdev->hdm = NULL;
> +	}
> +	if (!info)
> +		return;
> +
> +	kfree(info->decoder_state);
> +	kfree(info);
> +}
> +
> +static int cxl_pci_hdm_find_bar(struct pci_dev *pdev, resource_size_t hdm_start,
> +				resource_size_t hdm_size, int *bar,
> +				resource_size_t *offset)
> +{
> +	resource_size_t hdm_end = hdm_start + hdm_size - 1;
> +
> +	for (int i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		struct resource *res = &pdev->resource[i];
> +
> +		if (!pci_resource_len(pdev, i))
> +			continue;
> +		if (resource_type(res) != IORESOURCE_MEM)
> +			continue;
> +		if (hdm_start < res->start || hdm_end > res->end)
> +			continue;
> +
> +		*bar = i;
> +		*offset = hdm_start - res->start;
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static void __iomem *cxl_pci_hdm_map(struct pci_dev *pdev,
> +				     struct cxl_register_map *map,
> +				     struct cxl_hdm_info *info)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	resource_size_t hdm_start;
> +	void __iomem *hdm;
> +	int rc;
> +
> +	hdm_start = map->resource + hdm_map->offset;
> +	info->hdm_size = hdm_map->size;
> +
> +	rc = cxl_pci_hdm_find_bar(pdev, hdm_start, info->hdm_size,
> +				  &info->hdm_bar, &info->hdm_offset);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	hdm = ioremap(hdm_start, info->hdm_size);
> +	if (!hdm) {
> +		pci_err(pdev, "failed to map CXL HDM decoder registers\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return hdm;
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
> +	bool committed;
> +	int rc;
> +
> +	cxl_pci_hdm_read_decoder_state(state, hdm, id);
> +
> +	base = ((u64)state->base_high << 32) | state->base_low;
> +	size = ((u64)state->size_high << 32) | state->size_low;
> +	target_or_skip = ((u64)state->target_high << 32) | state->target_low;
> +
> +	rc = cxl_hdm_decode_decoder(settings, id, state->ctrl, base, size,
> +				    target_or_skip, &committed);
> +	if (rc) {
> +		pci_err(pdev, "CXL HDM decoder %d has invalid configuration: %d\n",
> +			id, rc);
> +		return rc;
> +	}
> +	if (!committed)
> +		return 0;
> +
> +	return 0;
> +}
> +
> +static int cxl_pci_hdm_capable(struct pci_dev *pdev)
> +{
> +	u16 cap;
> +	int dvsec;
> +	int rc;
> +
> +	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
> +					  PCI_DVSEC_CXL_DEVICE);
> +	if (!dvsec)
> +		return -ENOTTY;
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CAP, &cap);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(cap & PCI_DVSEC_CXL_MEM_CAPABLE))
> +		return -ENOTTY;
> +
> +	return 0;
> +}
> +
> +static int __pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
> +	struct cxl_decoder_settings *settings;
> +	struct cxl_register_map map = { 0 };
> +	struct cxl_hdm_info *info;
> +	void __iomem *hdm = NULL;
> +	bool restore_command = false;
> +	bool allocated_info = false;
> +	int decoder_count;
> +	u16 command;
> +	int rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa) {
> +		info = pdev->hdm;
> +		if (info)
> +			return 0;
> +	}

Is this function going to be reused for refreshing the state of the
decoder cache? Does not look like it in this set, so it should be
impossible for pdev->hdm to already be enabled, right?

> +
> +	rc = cxl_pci_hdm_capable(pdev);
> +	if (rc)
> +		return rc;
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(command & PCI_COMMAND_MEMORY))
> +		restore_command = true;
> +
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +	}
> +
> +	if (!info) {
> +		info = kzalloc_obj(*info, GFP_KERNEL);
> +		if (!info)
> +			goto err_nomem;
> +		allocated_info = true;
> +	}
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		goto out_restore_command;
> +
> +	rc = cxl_setup_regs(&map);
> +	if (rc)
> +		goto out_restore_command;
> +
> +	if (!map.component_map.hdm_decoder.valid) {
> +		rc = -ENODEV;
> +		goto out_restore_command;
> +	}
> +
> +	hdm = cxl_pci_hdm_map(pdev, &map, info);
> +	if (IS_ERR(hdm)) {
> +		rc = PTR_ERR(hdm);
> +		hdm = NULL;
> +		goto out_restore_command;
> +	}
> +
> +	decoder_count = cxl_hdm_decoder_count(readl(hdm +
> +						    CXL_HDM_DECODER_CAP_OFFSET));
> +	if (decoder_count < 0) {
> +		rc = decoder_count;
> +		goto out_unmap;
> +	}
> +
> +	if (decoder_count > CXL_HDM_DECODER_MAX_COUNT) {
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	if (info->decoder_count && info->decoder_count != decoder_count) {
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	info->decoder_state = kcalloc(decoder_count,
> +				      sizeof(*info->decoder_state),
> +				      GFP_KERNEL);
> +	if (!info->decoder_state) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	settings = info->settings;
> +	for (int i = 0; i < info->decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &info->decoder_state[i],
> +					      &settings[i], hdm, i);
> +		if (rc)
> +			goto out_unmap;
> +	}
> +
> +	if (restore_command) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		if (rc)
> +			goto out_restore_failed;
> +	}
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.dpa) {
> +		if (pdev->hdm)
> +			goto out_unmap;
> +		pdev->hdm = info;
> +	}

If the plan is to later use this routine to refresh the cached
information then how does it know that pdev->hdm is more fresh then the
recent @info snapshot? Otherwise this looks out of place because there
is no driver to race in this early context.

> +	iounmap(hdm);
> +	return 0;
> +
> +out_restore_failed:
> +	rc = pcibios_err_to_errno(rc);
> +	goto out_unmap;
> +err_nomem:
> +	rc = -ENOMEM;
> +	goto out_restore_command;
> +out_unmap:
> +	if (hdm)
> +		iounmap(hdm);
> +out_restore_command:
> +	if (allocated_info) {
> +		kfree(info->decoder_state);
> +		kfree(info);
> +	}
> +	if (restore_command) {
> +		int rc2;
> +
> +		rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		if (rc2 && !rc)
> +			rc = pcibios_err_to_errno(rc2);
> +	}
> +	return rc;
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
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index dd0abbc63e18..8080389d1fc3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -24,6 +24,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/bitfield.h>
>  #include <trace/events/pci.h>
> +#include <cxl/cxl.h>
>  #include "pci.h"
>  
>  static struct resource busn_resource = {
> @@ -2484,6 +2485,7 @@ static void pci_release_dev(struct device *dev)
>  	struct pci_dev *pci_dev;
>  
>  	pci_dev = to_pci_dev(dev);
> +	pci_cxl_hdm_release(pci_dev);
>  	pci_release_capabilities(pci_dev);
>  	pci_release_of_node(pci_dev);
>  	pcibios_release_device(pci_dev);
> @@ -2674,6 +2676,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_rebar_init(dev);		/* Resizable BAR */
>  	pci_dev3_init(dev);		/* Device 3 capabilities */
>  	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
> +	pci_cxl_hdm_init(dev);		/* CXL HDM Decoder Capability */

I think Richard has a point that this is too early to be using device
MMIO resources. I took a look and the proper place appears to be
pci_bus_add_device(). Note how some of the quirks invoked by:

	pci_fixup_device(pci_fixup_final, dev);

...do their own command register fixups and ioremap().
