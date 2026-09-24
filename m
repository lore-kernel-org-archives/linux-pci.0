Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15743CF032;
	Thu, 24 Sep 2026 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790220978; cv=none; b=GUofiGNRXus7lK5G/0kDKbJXEjMfB21ls7OZs9W2JcFebZCIUnXFmIZJ0dm+w+NrONxkGj6aw+guvLwHFYLUah+hBi06ua0ERJXjmieVOhdglI7xUaqR4GGqbbrCRJMEg/PI6z4hM1QeSuLvx+cySDWn+1spW6DfA/7ASK77Eo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790220978; c=relaxed/simple;
	bh=37NG+zVsSRo8YaXnUJldRHtHxbZhsJ41nENKVL4Woy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC7hRs2Jp59Ekhz+KwmNj+NsgXxVPdSRZNBMR/JLCslcp6/mOwSrIuV6CNwoNVeOgxsK6fu6bfwVpXvNQEm6TKk47hSMnnLFVQWND1WR9QGzCZWIpeDhJyc8GmJ6B8l9wL5KJX50iEaQ3WN7a9Ni65VQbypRaMEDaJQrQDb4HgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLRAX8E/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLRAX8E/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340C71F000FF;
	Thu, 24 Sep 2026 03:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790220976;
	bh=hqUONY15mblfrbweb+lCaDMlvswl82wq+y8LoUP1c2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BLRAX8E/hBDbFGUNbcIn38hmzGpyyheRUw3pAkMmcH2slqhqTCaYk+8xGpe7tydN8
	 WoQpASf63EQmkF3NDF+H/6hnm3gy5fcwgzkBtFT0wwSdCpnB3zYvU5F3XpYoLtAlJu
	 q2tEPme9WiNUo+IQC5K3UnjHokFj5UxD6cXrioK1uiJEChe1OEkNrMoSKyrH2qu3XD
	 LgsnoJXok8qr1wD/W53cd2nkhsHHXXLFtw7Oyzf0ew/r8Zw/YC2d0+JQpSt/c02N2E
	 aT0TyLdE2F560gwXXGNcITYQkI09Nch3+0Zq9ZJujFTT5dc9fCN04MRDzz2WZu9hYa
	 0SP0y8gGJKZcw==
Date: Thu, 24 Sep 2026 04:36:09 +0100
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
Subject: Re: [PATCH v13 09/15] cxl: Cache endpoint HDM state during PCI
 enumeration
Message-ID: <20260924043609.5dc4a7f4@jic23-hlaptop>
In-Reply-To: <20260922083924.2451158-10-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
	<20260922083924.2451158-10-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 08:39:18 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> PCI capability initialization runs before BAR resources are finalized,
> while driver binding is too late for driver-independent reset support.
> Create pci_dev->hdm during pci_bus_add_device(), after PCI resource setup
> and before driver binding.
> 
> Cache BAR-relative HDM location, global control, decoder settings, and CXL
> Device DVSEC Control, then publish the completed cache under cxl_rwsem.dpa.
> Restore PCI_COMMAND after temporary MMIO access and reject decoder-count
> changes.
> 
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

A few things inline.  Maybe well overlap with Benjamin's comments!

> diff --git a/drivers/cxl/core/resource.c b/drivers/cxl/core/resource.c
> index 7eea2bc38d94..b5f8c28e613f 100644
> --- a/drivers/cxl/core/resource.c
> +++ b/drivers/cxl/core/resource.c


> +static int __cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				   struct cxl_register_map *map, int dvsec,
> +				   struct cxl_hdm_info **out)
> +{
> +	struct cxl_reg_map *hdm_map = &map->component_map.hdm_decoder;
> +	struct cxl_hdm_info *info = NULL;

Fits in with comments below, but that should not be set to NULL up
here.

> +	resource_size_t hdm_offset;
> +	void __iomem *hdm;
> +	int decoder_count;
> +	size_t required;
> +	u16 dvsec_ctrl;
> +	int rc;
> +
> +	rc = cxl_setup_regs(map);
> +	if (rc)
> +		return rc;
> +	if (!hdm_map->valid)
> +		return -ENODEV;
> +	if (hdm_map->offset > map->max_size ||
> +	    hdm_map->size > map->max_size - hdm_map->offset)
> +		return -ENXIO;

That first lot can happen before setup regs.  Does it makes sense
to do that, then setup the regs before the follow up check?

> +	if (check_add_overflow(map->bar_offset,
> +			       (resource_size_t)hdm_map->offset, &hdm_offset))
> +		return -EOVERFLOW;
> +
> +	hdm = ioremap(map->resource + hdm_map->offset, hdm_map->size);
> +	if (!hdm)
> +		return -ENOMEM;
> +
> +	decoder_count = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (decoder_count < 0) {
> +		rc = decoder_count;
> +		goto out_unmap;
> +	}
> +
> +	required = CXL_HDM_DECODER0_TL_HIGH(decoder_count - 1) +
> +		   sizeof(u32);

I'd add a comment on why this size.

> +	if (required > hdm_map->size) {
> +		pci_err(pdev,
> +			"CXL HDM decoder count exceeds mapped register block\n");
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	rc = pci_read_config_word(pdev, dvsec + PCI_DVSEC_CXL_CTRL,
> +				  &dvsec_ctrl);
> +	if (rc) {
> +		rc = pcibios_err_to_errno(rc);
> +		goto out_unmap;
> +	}
> +
> +	info = kzalloc(struct_size(info, settings, decoder_count), GFP_KERNEL);

Ah. So burried in here is where info is allocated.
If you can use struct_size for the size you can use the _obj allocators instead.
Probably kzalloc_flex().



> +	if (!info) {
> +		rc = -ENOMEM;
> +		goto out_unmap;
> +	}
> +
> +	info->decoder_count = decoder_count;
> +	info->hdm_bar = map->bar;
> +	info->hdm_offset = hdm_offset;
> +	info->hdm_size = hdm_map->size;
> +	info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
> +	info->dvsec_ctrl = dvsec_ctrl;
> +	info->dvsec_ctrl_valid = true;
> +
> +	for (int i = 0; i < decoder_count; i++) {
> +		rc = cxl_pci_hdm_read_decoder(pdev, &info->settings[i], hdm, i);
> +		if (rc)
> +			goto out_unmap;

with ordering below fixed this should goto free_info; or something like that.

> +	}
> +
> +	/*
> +	 * A changed decoder count means the snapshot no longer describes the
> +	 * complete hardware state. Reject it rather than publish a partial cache.
> +	 */
> +	rc = cxl_hdm_decoder_count(readl(hdm + CXL_HDM_DECODER_CAP_OFFSET));
> +	if (rc != decoder_count) {
> +		pci_err(pdev, "CXL HDM decoder count changed from %d to %d\n",
> +			decoder_count, rc);
> +		rc = -ENXIO;
> +		goto out_unmap;
> +	}
> +
> +	*out = info;
> +	info = NULL;

Don't use this pattern of papering over stuff before then
running your error path.  Given no __free magic for iounmap just
have two exit paths and duplicate the iounmap().

> +	rc = 0;
> +
> +out_unmap:
> +	kfree(info);
> +	iounmap(hdm);

FWIW these are in the wrong order. You should unwind in reverse of
setup.

> +	return rc;
> +}
> +
> +static int cxl_pci_hdm_read_info(struct pci_dev *pdev,
> +				 struct cxl_register_map *map, int dvsec,
> +				 struct cxl_hdm_info **out)
> +{
> +	bool restore_command = false;
> +	u16 command;
> +	int rc, rc2;
> +
> +	guard(pci_dev)(pdev);
> +
> +	rc = pci_read_config_word(pdev, PCI_COMMAND, &command);
> +	if (rc)
> +		return pcibios_err_to_errno(rc);
> +
> +	if (!(command & PCI_COMMAND_MEMORY)) {
> +		rc = pci_write_config_word(pdev, PCI_COMMAND,
> +					   command | PCI_COMMAND_MEMORY);
> +		if (rc)
> +			return pcibios_err_to_errno(rc);
> +		restore_command = true;
> +	}
> +
> +	rc = __cxl_pci_hdm_read_info(pdev, map, dvsec, out);

To keep ownership and lifetimes clear I'd have this helper return "out"
and use a PTR_ERR() for errors.  Then I'd hand over to a __free()
in here so that you can then explicitly hand ownership on by again
returning out (with a ptr_no_free() or similar).  Basically
we want that flow of ownership to be obvious.  That may lead to dances
where you allocate then pass the ptr on via a ptr_no_free() in two
lines but that is fine.

> +	if (!restore_command)
> +		return rc;
> +
> +	if (!rc) {

This looks like a good path?  If so have the bad path out of line
not this.

> +		rc = pci_write_config_word(pdev, PCI_COMMAND, command);
> +		return pcibios_err_to_errno(rc);
> +	}
> +
> +	rc2 = pci_write_config_word(pdev, PCI_COMMAND, command);
> +	if (rc2)
> +		pci_err(pdev,
> +			"failed to restore PCI_COMMAND after CXL HDM cache init: %d\n",
> +			pcibios_err_to_errno(rc2));
> +
> +	return rc;
> +}
> +
> +static int __pci_cxl_hdm_cache_init(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info __free(kfree) = NULL;

See cleanup.h documentation.  I have no idea where the = NULL
at the top pattern is coming from, but there has been strong
push back from Linus and others on that in the kernel because
it introduces ordering problems. 

Here I have no idea where it is getting allocated.
If possible make that allocation function return info.


> +	struct cxl_register_map map = { };
> +	struct resource *bar;
> +	int dvsec;
> +	int rc;
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.dpa)
> +		if (pdev->hdm)
> +			return 0;

Add a comment on why just taking the lock briefly for this
check is useful. I'd expect something to need hdm to stick around
though perhaps lifetimes are fine and that isn't an issue.

> +
> +	dvsec = cxl_pci_hdm_dvsec(pdev);
> +	if (dvsec < 0)
> +		return dvsec;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +	if (map.bar < 0 || map.bar >= PCI_STD_NUM_BARS)
> +		return -ENODEV;
> +
> +	bar = &pdev->resource[map.bar];
> +	if (!pci_resource_len(pdev, map.bar) ||
> +	    (bar->flags & (IORESOURCE_UNSET | IORESOURCE_DISABLED)) ||
> +	    resource_type(bar) != IORESOURCE_MEM || !bar->start || !bar->end)
> +		return -ENODEV;
> +
> +	rc = cxl_pci_hdm_read_info(pdev, &map, dvsec, &info);
> +	if (rc)
> +		return rc;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (!pdev->hdm)

Needs a comment. I'm going to guess race given this pairs
with the one above?

> +		pdev->hdm = no_free_ptr(info);
> +
> +	return 0;
> +}

> +
> +void pci_cxl_hdm_cache_release(struct pci_dev *pdev)
> +{
> +	struct cxl_hdm_info *info;
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	info = pdev->hdm;
> +	pdev->hdm = NULL;

I'd like a comment on why we need to set this NULL.
I'd kind of not really expect there to ever be a path by
which this is checked after release but maybe there is?

> +	kfree(info);
> +}

