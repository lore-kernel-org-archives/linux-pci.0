Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54020317153;
	Thu, 21 May 2026 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779397046; cv=none; b=h/vgGSKX2w2b88mSLqOlWwdFYvEBENuVLpZOBcbRlRhInpQvoMNYq9wOtjs29k2+U56gBGhrKehJKpqhnY99g/HMrMeqeFd02CAw1S2LdHZaxzlgT5m8aNA0kJwohDqnxjGU3BWzzU6SV01fiqAJx7fS3MjX/iR12Xa/9mOZs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779397046; c=relaxed/simple;
	bh=ykjVOJXBvmuGaD559BtIBrR/fcmDRNRWOhuFPJO24Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ronZc2f2Yu1D1GWv4cT2cFLFnyNRBhDgnHeHGSee7TGYJo0CYe4mERZUYHnD0aIgmXkiImQG49/cL4E2CrlNeR6SW1+gcgtfVwU1S7ZrgwtpppPpgvwiiuo1YjodRgHht9pebsLstoIWwOyDCUHysTaWeCvU+xRx4mtm7RzVKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8VJ5uQg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8VJ5uQg"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C1C541F000E9;
	Thu, 21 May 2026 20:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779397045;
	bh=LQMjIQsaCicY2Fa/lpMnojX2PU9qBdlfzsvyl1rTCWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=O8VJ5uQg8aY08tRXHOgueVfNu0+dKjNarBou83/g4bGTBFpQLuOMwynz6F0LkpNuS
	 f3OVSYTX2s+3CDmP4fL7ApHSbPjGbmqIBWWqaWlULtLD4GsYwjx2r2WEfM8+ulaimW
	 ow5zfwLdy0zVL+ywuyCEj122ecPDiMVpTWuyFilA0nLbYorSOwleBb/RS4JdXiOwBv
	 9fc4iQ5WaDLdQuwc4unGL7bWBd1tgt2SfpYn4ih6CepSCwaB7C/+R4WykCsD9UZrme
	 h3dQcvddREavCmtePS2cVu5RKH1AzmbidMC6/qFYB++dYDAju5j64vYhxSq246oIvs
	 F7nVU1N8gNAEA==
Date: Thu, 21 May 2026 15:57:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	bhelgaas@google.com, praan@google.com, baolu.lu@linux.intel.com,
	kevin.tian@intel.com, miko.lenczewski@arm.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	vsethi@nvidia.com, linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 1/3] PCI: Add pci_ats_required() for CXL.cache capable
 devices
Message-ID: <20260521205723.GA184317@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05044d2113e20d81f96677ba53605311662b6b10.1779392420.git.nicolinc@nvidia.com>

On Thu, May 21, 2026 at 01:34:20PM -0700, Nicolin Chen wrote:
> Controlled by IOMMU drivers, ATS can be enabled "on demand", when a given
> PASID on a device is attached to an I/O page table. This is working, even
> when a device has no translation on its RID (i.e., RID is IOMMU bypassed).
> 
> However, certain PCIe devices require non-PASID ATS on their RID even when
> the RID is IOMMU bypassed. Call this "ATS always on" in IOMMU term.
> 
> For example, CXL spec r4.0 notes in sec 3.2.5.13 Memory Type on CXL.cache:
>  "To source requests on CXL.cache, devices need to get the Host Physical
>   Address (HPA) from the Host by means of an ATS request on CXL.io."
> 
> In other words, the CXL.cache capability requires ATS; otherwise, it can't
> access host physical memory.
> 
> Introduce a new pci_ats_required() helper for the IOMMU driver to scan a
> PCI device and shift ATS policies between "on demand" and "always on".
> 
> Add the support for CXL.cache devices first. Pre-CXL devices will be added
> in quirks.c file.
> 
> Note that pci_ats_required() validates against pci_ats_supported(), so we
> ensure that untrusted devices (e.g. external ports) will not be always on.
> This maintains the existing ATS security policy regarding potential side-
> channel attacks via ATS.
> 
> Cc: linux-cxl@vger.kernel.org
> Suggested-by: Vikram Sethi <vsethi@nvidia.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Nirmoy Das <nirmoyd@nvidia.com>
> Acked-by: Nirmoy Das <nirmoyd@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ...

> +bool pci_ats_required(struct pci_dev *pdev)
> +{
> +	if (!pci_ats_supported(pdev))
> +		return false;
> +
> +	/* A VF inherits its PF's requirement for ATS function */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	return pci_cxl_ats_required(pdev);

I acked this before I saw this sashiko feedback, which looks like a
legit issue to me:

  Will this VF inheritance logic ever be reached?

  According to the PCIe SR-IOV specification (section 9.3.3.1), VFs do
  not implement the ATS Extended Capability, which means pdev->ats_cap
  is always 0 for VFs.

  Because of this, pci_ats_supported(pdev) will unconditionally return
  false for any VF. This causes the function to return false before it
  can ever reach the pdev->is_virtfn check.

  Could this prevent VFs from correctly enabling the ATS always on
  feature and leave them unable to access host memory without
  triggering IOMMU faults?

(From https://sashiko.dev/#/patchset/cover.1779304390.git.nicolinc%40nvidia.com)

I withdraw my ack for now until we figure out if it's a real issue.

> +}
> +EXPORT_SYMBOL_GPL(pci_ats_required);
> +
>  #ifdef CONFIG_PCI_PRI
>  void pci_pri_init(struct pci_dev *pdev)
>  {
> -- 
> 2.43.0
> 
