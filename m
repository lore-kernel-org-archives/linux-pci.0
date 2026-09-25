Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C534F6468;
	Fri, 25 Sep 2026 21:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370131; cv=none; b=JfujFDTfqPkBnnD6EO3DcXk/dN86UlYcsNLC0x08EL24PD/xAIbCtjLCAkpyLoFw7nwm4j9zlAfPIFXYaQgwa8WOpyM9+rS0vaDBEcewboldwKrfNzEtN3b1S9XJYsLec6Xr2xhv1eJA32pbWDJF/h+clo3wEL/Nl9uTro94ljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370131; c=relaxed/simple;
	bh=1meTcNlj9NWmKXjNVxoCO1GoHjR2aMAFZtfd2GRj6ho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Cd8fK5/iOWXkTm0KsV7By223oWK7+vNOnmt+6pneZeHLy9zeX751g6BA9RExSEqaKzPp8KT+wzO39LRIBupa+JeSSfBd2Xe4QYNvnHfH7gFwKFvUoWbVqRQdyDhzu6QH32T8B5Fvod5kXxFVn5cTfNbt1MwLJglRLNQuwIoeGqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkDam5UB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkDam5UB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC491F000FF;
	Fri, 25 Sep 2026 21:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790370129;
	bh=Xxnwq2liuR/h0COSiDia8u8avPdnrITgnRI+KPDTj+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=QkDam5UBe8G1n6b3cupssgLkR09k8GjbnTRnTKeXzPli2mC+EaHP11wDhlNwO9cM9
	 3dwAaOfD3jVRE0ZO1JMGSlXMD0t/Hlt49JTlUVcqZ8c8ScJrJ/6JTiIW0YBm/agDQr
	 BfU/OWGxFP7zotKQVtiCuwhl7bA5cpGxAp2xQir9FYbr0YXSqT4JXaEkls03yj5JWJ
	 BnHaRFNerl9qIpOSiSXoHudJP2JqhbDbb/Ta3m/2totL8S73gwgkw3ZoAw8tT3+Ga6
	 Ca+h5uk78MgLBOloico1WnfoEysIO6ITHxaRIO+3f2IvDIaHazODT2tdnqT8fUnVAo
	 TJLtgjJlXCNeg==
Date: Fri, 25 Sep 2026 16:02:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Odell <loganodell@google.com>
Cc: KarimAllah Ahmed <karahmed@amazon.de>, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/IOV: Make VF config reads match PCIe 7.0 spec
Message-ID: <20260925210208.GA2098512@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924225944.GA2019638@bhelgaas>

On Thu, Sep 24, 2026 at 05:59:44PM -0500, Bjorn Helgaas wrote:
> On Thu, Sep 10, 2026 at 10:36:48AM -0700, Logan Odell wrote:
> > The revision and subsystem ID of the VFs for a given PF do not all have
> > to match per 7.5.1.1.5 and 7.5.1.2.3[1]. Read these values from the
> > config space instead of using cached values from VF0. Class codes and
> > subsystem vendor IDs do need to match per 7.5.1.1.6 and 7.5.1.2.3. Use
> > the PF's value instead of reading from the VF config space. Per
> > 7.5.1.1.9, the header type for a VF should be 0, so hardcode that
> > assignment.
> > 
> > [1] https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/22464
> > 
> > Fixes: cf0921bea66c ("PCI/IOV: Use VF0 cached config registers for other VFs")
> > Signed-off-by: Logan Odell <loganodell@google.com>
> 
> Applied to pci/iov for v7.4, thanks!
> 
> > ---
> >  drivers/pci/iov.c   | 25 -------------------------
> >  drivers/pci/pci.h   |  4 ----
> >  drivers/pci/probe.c | 14 +++++++++-----
> >  3 files changed, 9 insertions(+), 34 deletions(-)
> > 
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 9d408fb8ac25..9185934a900f 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -179,29 +179,6 @@ bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev)
> >  	return cmd & PCI_SRIOV_CTRL_MSE;
> >  }
> >  
> > -static void pci_read_vf_config_common(struct pci_dev *virtfn)
> > -{
> > -	struct pci_dev *physfn = virtfn->physfn;
> > -
> > -	/*
> > -	 * Some config registers are the same across all associated VFs.
> > -	 * Read them once from VF0 so we can skip reading them from the
> > -	 * other VFs.
> > -	 *
> > -	 * PCIe r4.0, sec 9.3.4.1, technically doesn't require all VFs to
> > -	 * have the same Revision ID and Subsystem ID, but we assume they
> > -	 * do.
> > -	 */
> > -	pci_read_config_dword(virtfn, PCI_CLASS_REVISION,
> > -			      &physfn->sriov->class);
> > -	pci_read_config_byte(virtfn, PCI_HEADER_TYPE,
> > -			     &physfn->sriov->hdr_type);
> > -	pci_read_config_word(virtfn, PCI_SUBSYSTEM_VENDOR_ID,
> > -			     &physfn->sriov->subsystem_vendor);
> > -	pci_read_config_word(virtfn, PCI_SUBSYSTEM_ID,
> > -			     &physfn->sriov->subsystem_device);
> > -}
> > -
> >  int pci_iov_sysfs_link(struct pci_dev *dev,
> >  		struct pci_dev *virtfn, int id)
> >  {
> > @@ -329,8 +306,6 @@ static struct pci_dev *pci_iov_scan_device(struct pci_dev *dev, int id,
> >  	virtfn->physfn = pci_dev_get(dev);
> >  	virtfn->no_command_memory = 1;
> >  
> > -	if (id == 0)
> > -		pci_read_vf_config_common(virtfn);
> >  
> >  	rc = pci_setup_device(virtfn);
> >  	if (rc) {
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index ba3c3fddddc2..5b3dd1adbf35 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -711,10 +711,6 @@ struct pci_sriov {
> >  	u16		driver_max_VFs;	/* Max num VFs driver supports */
> >  	struct pci_dev	*dev;		/* Lowest numbered PF */
> >  	struct pci_dev	*self;		/* This PF */
> > -	u32		class;		/* VF device */
> > -	u8		hdr_type;	/* VF header type */
> > -	u16		subsystem_vendor; /* VF subsystem vendor */
> > -	u16		subsystem_device; /* VF subsystem device */
> >  	resource_size_t	barsz[PCI_SRIOV_NUM_BARS];	/* VF BAR size */
> >  	u16		vf_rebar_cap;	/* VF Resizable BAR capability offset */
> >  	bool		drivers_autoprobe; /* Auto probing of VFs by driver */
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 27008e2ea5af..693c07cf45ff 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -1888,10 +1888,14 @@ int pci_cfg_space_size(struct pci_dev *dev)
> >  static u32 pci_class(struct pci_dev *dev)
> >  {
> >  	u32 class;
> > +	u8 rev;
> >  
> >  #ifdef CONFIG_PCI_IOV
> > -	if (dev->is_virtfn)
> > -		return dev->physfn->sriov->class;
> > +	if (dev->is_virtfn) {

I moved the "rev" declaration here to avoid an unused variable warning
when CONFIG_PCI_IOV is not set:

https://lore.kernel.org/all/179030514298.542007.4329779510355469675@kernelci.org
https://lore.kernel.org/all/arac0WyK8MIbFeNP@sirena.org.uk

Check
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=iov&id=180b6d7bd729d5f07374af6fd4c3b8a7eefde0d1

> > +		if (pci_read_config_byte(dev, PCI_REVISION_ID, &rev))
> > +			rev = 0;
> > +		return (dev->physfn->class << 8) | rev;
> > +	}
> >  #endif
> >  	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
> >  	return class;
> > @@ -1901,8 +1905,8 @@ static void pci_subsystem_ids(struct pci_dev *dev, u16 *vendor, u16 *device)
> >  {
> >  #ifdef CONFIG_PCI_IOV
> >  	if (dev->is_virtfn) {
> > -		*vendor = dev->physfn->sriov->subsystem_vendor;
> > -		*device = dev->physfn->sriov->subsystem_device;
> > +		*vendor = dev->physfn->subsystem_vendor;
> > +		pci_read_config_word(dev, PCI_SUBSYSTEM_ID, device);
> >  		return;
> >  	}
> >  #endif
> > @@ -1916,7 +1920,7 @@ static u8 pci_hdr_type(struct pci_dev *dev)
> >  
> >  #ifdef CONFIG_PCI_IOV
> >  	if (dev->is_virtfn)
> > -		return dev->physfn->sriov->hdr_type;
> > +		return 0;
> >  #endif
> >  	pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type);
> >  	return hdr_type;
> > -- 
> > 2.55.0.1007.g17ff1f9808-goog
> > 
