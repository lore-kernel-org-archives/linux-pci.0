Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB7D3D5647;
	Wed, 20 May 2026 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299430; cv=none; b=pKFUuiK2QZeSP5vB31k2JCQOyghg7xbak12V3z8a+d9JfZJsSPS52rNXQeMQw1BQhNMDMHDc5q9iIuq2rs1V7qDElp+OGxbdq/1EBg7RJWpw2OpjoSO1WYFu68nUHWRAJXwhuc+YcYJ+H8fI1PIyDAkl8q0kZaCxz/5Exxc+sD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299430; c=relaxed/simple;
	bh=1o5gb79KOTG7JlPeBytflBdEb0YgHSTMbdt10n3C7IM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Eddtxpostvgi3SSgIr3CRP4zLGbR7xkFOJSpq9rEdLNNfK0rp5q6wCnXNmIRnWiBZNRcBZLSnM+vYvgeYl8OOwV02ewn0Ys5o9JPf3f0KVGEg6OAc+ygHjIcsyIGZdpX1jKy1497bh0z8iQ9pMBuz9GrM6PLYpubxBj0ExXTXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o04FxFSe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o04FxFSe"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 67E7F1F00894;
	Wed, 20 May 2026 17:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779299429;
	bh=R0zqzL14QP54GH3jHTaO1SQNTYgp8+cLjLzjCAobAGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=o04FxFSeEu2JsqhZx5OZM3BDhGPv6QRlZ3tyjx7QyJCNH4PgvpbY6crWRP0ySi/Bk
	 eoFlnOUTyjrv3TfWKUA17ZP154W66QqbDBz8+f8TimC+9g0o1DU/zBKtezMnpUJyiw
	 2D9ME/z+rrqUOp5eXspuvuC+1uS6d6LTPE2Pav4/DhwzGb+1h9RI5VlNl5KgvJ4D1O
	 bN++qKkiaa1yIh5e5QK1md2NiLHH4tSBGFwkXF2S7ihdKUJSh5EbNPF+E0vNfMR8JL
	 HG2/UCVDv7Cfwlg6DbemkAm9EBFvu6ow8EhGcaBk9grywLGOf6AW4ZlfQVkqHH/rEg
	 rl9W0y+gl3nAg==
Date: Wed, 20 May 2026 12:50:26 -0500
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
Subject: Re: [PATCH v4 2/3] PCI: Allow ATS to be always on for pre-CXL devices
Message-ID: <20260520175026.GA67027@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a8cf5e88051ab5c10417edb94df598ecbc810cf.1777269009.git.nicolinc@nvidia.com>

On Sun, Apr 26, 2026 at 10:54:01PM -0700, Nicolin Chen wrote:
> Some NVIDIA GPU/NIC devices, though they don't implement CXL config space,
> have many CXL-like properties. Call this kind "pre-CXL".
> 
> Similar to CXL.cache capability, these pre-CXL devices also require the ATS
> function even when their RIDs are IOMMU bypassed, i.e. keep ATS "always on"
> v.s. "on demand" when a non-zero PASID line gets enabled in SVA use cases.
> ...

> +/* Some pre-CXL devices require ATS when it is IOMMU-bypassed */

I guess these devices are purely PCIe, with no actual CXL
transactions, so a hint here about what leads to the ATS requirement
would be useful.  It sounds like an actual functional requirement, not
just a performance optimization.

> +bool pci_dev_specific_ats_always_on(struct pci_dev *pdev)
> +{
> +	const struct pci_dev_ats_always_on *i;
> +
> +	for (i = pci_dev_ats_always_on; i->vendor; i++) {
> +		if (i->vendor != pdev->vendor)
> +			continue;
> +		if (i->ats_always_on && i->ats_always_on(pdev))
> +			return true;
> +		if (!i->ats_always_on && i->device == pdev->device)
> +			return true;
> +	}
> +
> +	return false;
> +}
>  #endif /* CONFIG_PCI_ATS */
>  
>  /* Freescale PCIe doesn't support MSI in RC mode */
> -- 
> 2.43.0
> 
