Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31373327C0D;
	Tue, 19 May 2026 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219414; cv=none; b=J/F5/jNo9bn4P+DWkQmXLKX5GG+T11VQBnR0BkLhaRis9olUgnF48oQHl+nWrGOnFqmdlndl+ToETO5iud4eiivBzkLEadfmuslZCbmbUHR8itdxfhj26pEGwx1AJ0asr7NHkiHqxz3u08QYfEQDn18DnkrELuMpLMdtuu5MhSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219414; c=relaxed/simple;
	bh=XrTaU0zXVXOmf8pCUBn5T700clsPXs6t+wtPQD/DKys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rpYNAdRN1DPb+tw9FZZ3xObeSHDqAzXvKqDtIDWk3HvHWSUKfYpW1SMQ/0EorSpiuIP5Ia15V4pOsaCEY5oNhMbvpiIfEYN1HfIAqJMCRivrcIrJYF6A3uj9BdK0rHonJm/8c98U7DSwObexQk14ZZ4SCUXm9d46XPDmhUxrws0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOBYQZpO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOBYQZpO"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 05A641F000E9;
	Tue, 19 May 2026 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779219411;
	bh=9zWCT6L164MPpYxvYUUjyVKQRnNx7/uPmsbeHhH1oG0=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hOBYQZpO0e5XVVO2zoVjayrxSbwRpUYoEspSmgSZEssnaM0rlFey8b0rrdN6hHa/S
	 YYHhOnIlzQfHOHq4vRYUL1BJ+81JZJXEpIIeUGJAK1kgsruLHfVECy0Q12LHNTXv1x
	 h8bzSY2wPKz+tS7IArsZYnRqR2Te7xVKbARE9af8YXEIa4nUNtOQw8SuXYjczAq9RG
	 2zE7IJm0aQdh0Kw+LDghyeoGwhLxf0S5zO5weZuODHmeteQ2M1O7yMZfN9vxn5V+wD
	 kYzFQvjTFbDXdS+rlXFCYjnZX5aFo2ckcyEkdz6NZO0E88o2gwwt4dxTvgll+cv5Jq
	 i92uvT88ytZUQ==
Date: Tue, 19 May 2026 14:36:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, joro@8bytes.org, praan@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v4 1/3] PCI: Allow ATS to be always on for CXL.cache
 capable devices
Message-ID: <20260519193649.GA715262@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6734b9dad0050138676f11ecd14e9db1cf6b697.1777269009.git.nicolinc@nvidia.com>

On Sun, Apr 26, 2026 at 10:54:00PM -0700, Nicolin Chen wrote:
> Controlled by the IOMMU driver, ATS is usually enabled "on demand" when a
> given PASID on a device is attached to an I/O page table. This is working
> even when a device has no translation on its RID (i.e., the RID is IOMMU
> bypassed).
> 
> However, certain PCIe devices require non-PASID ATS on their RID even when
> the RID is IOMMU bypassed. Call this "always on".
> 
> For example, CXL spec r4.0 notes in sec 3.2.5.13 Memory Type on CXL.cache:
>  "To source requests on CXL.cache, devices need to get the Host Physical
>   Address (HPA) from the Host by means of an ATS request on CXL.io."
> 
> In other words, the CXL.cache capability requires ATS; otherwise, it can't
> access host physical memory.
> 
> Introduce a new pci_ats_always_on() helper for the IOMMU driver to scan a
> PCI device and shift ATS policies between "on demand" and "always on".
> 
> Add the support for CXL.cache devices first. Pre-CXL devices will be added
> in quirks.c file.
> 
> Note that pci_ats_always_on() validates against pci_ats_supported(), so we
> ensure that untrusted devices (e.g. external ports) will not be always on.
> This maintains the existing ATS security policy regarding potential side-
> channel attacks via ATS.

IMO this doesn't really fit in the PCI core.  ats.c encapsulates
discovery and provides interfaces to access the ATS Capability, but
the users of those interfaces are all outside the PCI core.

The decision to enable enable ATS for CXL.cache devices is fine but
it's really an IOMMU usage policy, and I think it should be
implemented in the IOMMU core.  All the pieces needed
(pci_ats_disabled(), pci_ats_supported(), pci_find_dvsec_capability())
are already exported.

One motivation for putting this in the PCI core was to use the quirk
infrastructure, but this series doesn't use any of that.  It doesn't
declare any fixups, e.g., DECLARE_PCI_FIXUP_FINAL, and it doesn't
update any state cached by the PCI core.

> +++ b/include/uapi/linux/pci_regs.h
> @@ -1349,6 +1349,7 @@
>  /* CXL r4.0, 8.1.3: PCIe DVSEC for CXL Device */
>  #define PCI_DVSEC_CXL_DEVICE				0
>  #define  PCI_DVSEC_CXL_CAP				0xA
> +#define   PCI_DVSEC_CXL_CACHE_CAPABLE			_BITUL(0)

This makes good sense, I'm fine with adding
PCI_DVSEC_CXL_CACHE_CAPABLE.

> +bool pci_ats_always_on(struct pci_dev *pdev)
> +{
> +	if (pci_ats_disabled() || !pci_ats_supported(pdev))
> +		return false;

Isn't this the same as:

  if (!pci_ats_supported(pdev))
    return false;

If pci_ats_disabled(), dev->ats_cap should be zero, so
pci_ats_supported() should always return false.

> +
> +	/* A VF inherits its PF's requirement for ATS function */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	return pci_cxl_ats_always_on(pdev);
> +}
> +EXPORT_SYMBOL_GPL(pci_ats_always_on);
