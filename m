Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2582930C142;
	Thu, 24 Sep 2026 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290787; cv=none; b=S5/v1jb92CM1RuVE+YEYvNSKxQtOufem1TJgrKobwF8i17lyOUO0q8cwG1l/L++EC5JWDFzs1X8bsp7eaunWCPdc0CqfumfM5TrdoWmLk4v4aBGGRcm/G2I2cJoqHQ+pQcve82YZxoqr7DBbpABeEslJ4Ze5DY0WyENHpkDE/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290787; c=relaxed/simple;
	bh=9JQK3M/VYXH0V21F08JN9AMfn4uIqvfsnEr/dnFvinA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CX2/u0r6RjEYxyp0tby7kQDb0lRwENXgAEGWlXp7/BdTO2OmR1E/rxeg/YUhhn5loU/tD1MMAgs6gG384wFarewNpE2XZmjG2mX2GEdJZx1C6u56yhMebvQtvl7ZmElVeJ89LjCR8Dby1v3xuKltNyJB3Ai172jqPBiR3GVMF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5OyMajW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5OyMajW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845001F000FF;
	Thu, 24 Sep 2026 22:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790290785;
	bh=mI3J2i30KPpFZYMpVTCMbFJCud+nlZX6Sr3yoCszAPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=S5OyMajW2Q0pyrAqwoqi2sTGH/hHvrcC4PvtkCP7i23twR1JsPt9TjMrLCX1nrWmO
	 2kQV8lZdoapN+LgzO00Qhh2ZAazks011ikS9gBx4GloT5zXeQg11YV+8mmceA0CTp6
	 +0kcbZGg81LbygFrJJ8eQpQ4IQ73E5BpbDdROV/kFs6N3uPlT2nDX4BYj1yZXhvBLq
	 1QbA0uYieAZI4hBDv0QCH19am6+Wcygcss31G8LZfDsNPuxagx7GGekmdy4xIbGPwc
	 CH2KIcc601fenoKsWT6y4LaKMexJKdzO4B9pE03WAILj1ZcNFnpuLZm6IpDqmnXnYt
	 eMcyC8YvMRKsA==
Date: Thu, 24 Sep 2026 17:59:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Odell <loganodell@google.com>
Cc: karahmed@amazon.de, bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: Make VF config reads match PCIe 7.0 spec
Message-ID: <20260924225944.GA2019638@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910173648.1304517-1-loganodell@google.com>

On Thu, Sep 10, 2026 at 10:36:48AM -0700, Logan Odell wrote:
> The revision and subsystem ID of the VFs for a given PF do not all have
> to match per 7.5.1.1.5 and 7.5.1.2.3[1]. Read these values from the
> config space instead of using cached values from VF0. Class codes and
> subsystem vendor IDs do need to match per 7.5.1.1.6 and 7.5.1.2.3. Use
> the PF's value instead of reading from the VF config space. Per
> 7.5.1.1.9, the header type for a VF should be 0, so hardcode that
> assignment.
> 
> [1] https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/22464
> 
> Fixes: cf0921bea66c ("PCI/IOV: Use VF0 cached config registers for other VFs")
> Signed-off-by: Logan Odell <loganodell@google.com>

Applied to pci/iov for v7.4, thanks!

> ---
>  drivers/pci/iov.c   | 25 -------------------------
>  drivers/pci/pci.h   |  4 ----
>  drivers/pci/probe.c | 14 +++++++++-----
>  3 files changed, 9 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 9d408fb8ac25..9185934a900f 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -179,29 +179,6 @@ bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
>  	return cmd & PCI_SRIOV_CTRL_MSE;
>  }
>  
> -static void pci_read_vf_config_common(struct pci_dev *virtfn)
> -{
> -	struct pci_dev *physfn = virtfn->physfn;
> -
> -	/*
> -	 * Some config registers are the same across all associated VFs.
> -	 * Read them once from VF0 so we can skip reading them from the
> -	 * other VFs.
> -	 *
> -	 * PCIe r4.0, sec 9.3.4.1, technically doesn't require all VFs to
> -	 * have the same Revision ID and Subsystem ID, but we assume they
> -	 * do.
> -	 */
> -	pci_read_config_dword(virtfn, PCI_CLASS_REVISION,
> -			      &physfn->sriov->class);
> -	pci_read_config_byte(virtfn, PCI_HEADER_TYPE,
> -			     &physfn->sriov->hdr_type);
> -	pci_read_config_word(virtfn, PCI_SUBSYSTEM_VENDOR_ID,
> -			     &physfn->sriov->subsystem_vendor);
> -	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
> -			     &physfn->sriov->subsystem_device);
> -}
> -
>  int pci_iov_sysfs_link(struct pci_dev *dev,
>  		struct pci_dev *virtfn, int id)
>  {
> @@ -329,8 +306,6 @@ static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
>  	virtfn->physfn = pci_dev_get(dev);
>  	virtfn->no_command_memory = 1;
>  
> -	if (id == 0)
> -		pci_read_vf_config_common(virtfn);
>  
>  	rc = pci_setup_device(virtfn);
>  	if (rc) {
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index ba3c3fddddc2..5b3dd1adbf35 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -711,10 +711,6 @@ struct pci_sriov {
>  	u16		driver_max_VFs;	/* Max num VFs driver supports */
>  	struct pci_dev	*dev;		/* Lowest numbered PF */
>  	struct pci_dev	*self;		/* This PF */
> -	u32		class;		/* VF device */
> -	u8		hdr_type;	/* VF header type */
> -	u16		subsystem_vendor; /* VF subsystem vendor */
> -	u16		subsystem_device; /* VF subsystem device */
>  	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
>  	u16		vf_rebar_cap;	/* VF Resizable BAR capability offset */
>  	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5af..693c07cf45ff 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1888,10 +1888,14 @@ int pci_cfg_space_size(struct pci_dev *dev)
>  static u32 pci_class(struct pci_dev *dev)
>  {
>  	u32 class;
> +	u8 rev;
>  
>  #ifdef CONFIG_PCI_IOV
> -	if (dev->is_virtfn)
> -		return dev->physfn->sriov->class;
> +	if (dev->is_virtfn) {
> +		if (pci_read_config_byte(dev, PCI_REVISION_ID, &rev))
> +			rev = 0;
> +		return (dev->physfn->class << 8) | rev;
> +	}
>  #endif
>  	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
>  	return class;
> @@ -1901,8 +1905,8 @@ static void pci_subsystem_ids(struct pci_dev *dev, u16 *vendor, u16 *device)
>  {
>  #ifdef CONFIG_PCI_IOV
>  	if (dev->is_virtfn) {
> -		*vendor = dev->physfn->sriov->subsystem_vendor;
> -		*device = dev->physfn->sriov->subsystem_device;
> +		*vendor = dev->physfn->subsystem_vendor;
> +		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, device);
>  		return;
>  	}
>  #endif
> @@ -1916,7 +1920,7 @@ static u8 pci_hdr_type(struct pci_dev *dev)
>  
>  #ifdef CONFIG_PCI_IOV
>  	if (dev->is_virtfn)
> -		return dev->physfn->sriov->hdr_type;
> +		return 0;
>  #endif
>  	pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type);
>  	return hdr_type;
> -- 
> 2.55.0.1007.g17ff1f9808-goog
> 
