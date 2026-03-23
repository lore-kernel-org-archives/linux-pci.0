Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD883AE1AD;
	Mon, 23 Mar 2026 13:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274070; cv=none; b=bSRNO3GMwaFbz9uYWvaHr9NhDJn8KbBV8LpFxWlOsWNGfHfNh5UO8oA3L0RFaCojXZ1EFVgjcILRnS4B1xLXWOKDsL3QBTZLHV9m/rh4C4VnYf1c698NYLmC8XnDyGIQC4ZdtXZ+NGTBhDfC+pPcNihvvPlFVME8PbFR4IMc11Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274070; c=relaxed/simple;
	bh=XSPhkD/KqDCw9VQ1qBsIZWpNqiQpkT++OcA+0lBT8fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9neHP00NQ/IxPs33SJ8KjfIc/CncpJz0rRXECTPMc9Qjyw1V4pRWHhn+++QiKwo7xcYHXPPaDdqykeJ12uJmIyionl6wUAXLREUMD+FuTf934RZ4iM+Kjd2mI1/Is2HG+HAsT+dgkv5Cx7fY4H7y9I3gfmxuLSLYwYy+LxRFgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFqogznc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFqogznc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97239C4CEF7;
	Mon, 23 Mar 2026 13:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274070;
	bh=XSPhkD/KqDCw9VQ1qBsIZWpNqiQpkT++OcA+0lBT8fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFqogzncXobgl53KRC1+fTyYTpw6XJUpfL7mW3VMAEp9VDLl/K/HTKiKLfnaeuG9b
	 FJK5E+uWBJe4O186G9cUNmLWPbG3KWRIsz2JhPQBFFZLuwmbTQ4Rx954Q+IBfGRQqB
	 DLnz8vB58EtbjLpQr0bl+NxUwNXYf3oashmQ/HrhkArcJQIe1kjCYqpGONwVQ9olzn
	 Q2YtsFZOAhIK+UhmkwRDFXU2WglZCTC0EEJvpjLfISANFJhiPRAp5M9op7ll7Uceue
	 TRIXT1cgImm8rRxC7plKOtr1d9njChBp3e/dlsZA2REH1Vs+pU0tvC19ug7wKjRzYi
	 gSlXFVy2id4HQ==
Date: Mon, 23 Mar 2026 19:24:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: John Hancock <john@kernel.doghat.io>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org, bhelgaas@google.com, 
	manivannan.sadhasivam@oss.qualcomm.com, joro@8bytes.org, linux-pci@vger.kernel.org, 
	iommu@lists.linux.dev
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU for
 OF platforms"
Message-ID: <o7nnlvtkmatzafs44um6h5wnqo755msiukfn6kbu2zxdhe45ws@mde5lt2ufusz>
References: <20260320172335.29778-1-john@kernel.doghat.io>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320172335.29778-1-john@kernel.doghat.io>

+ Robin

On Fri, Mar 20, 2026 at 01:23:35PM -0400, John Hancock wrote:
> Commit 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF
> platforms") introduced a regression affecting AMD IOMMU group isolation
> on x86 systems, making PCIe passthrough non-functional.
> 
> While the commit addresses a legitimate ordering issue on OF/Device Tree
> platforms, the fix modifies pci_dma_configure(), which executes on all
> platforms regardless of firmware interface. On AMD systems with IOMMU,
> moving pci_enable_acs() from pci_acs_init() to pci_dma_configure() alters
> the point at which ACS is evaluated relative to IOMMU group assignment.
> The result is that devices which previously occupied individual, exclusive
> IOMMU groups are merged into a single group containing both passthrough
> and non-passthrough members, violating IOMMU isolation requirements.
> 

Ouch! Sorry for the breakage.

> The commit author notes that pci_enable_acs() is now called twice per
> device and that this is "presumably not an issue." On AMD IOMMU hardware
> this assumption does not hold -- the change in call ordering has
> observable and breaking consequences for group topology.
> 
> It is worth noting that this is a stable/LTS series (6.12.y), where
> changes to fundamental PCI initialization ordering carry significant
> risk for production and specialized workloads that depend on stable
> IOMMU behavior across kernel updates. A regression of this nature --
> silently breaking PCIe passthrough without any configuration change on
> the part of the user -- is particularly disruptive in a series that
> users reasonably expect to be conservative.
> 

I still haven't investigated this failure deeply, but it is also worth noting
that this regression only happens with v6.12 and earlier stable kernels as
mentioned in [1].

> This revert restores pci_enable_acs() to pci_acs_init() and marks it
> static again, fully restoring correct IOMMU group topology on affected
> hardware.
> 
> Regression introduced in: 6.12.75
> Tested on: 6.12.77 with this revert applied
> 
> Hardware:
>   CPU:   AMD Ryzen Threadripper 2990WX (family 23h, Zen+)
>   IOMMU: AMD-Vi
> 
> Bisect:
>   6.12.74: GOOD -- IOMMU groups correct, passthrough functional
>   6.12.75: BAD  -- IOMMU groups collapsed, passthrough broken
>   6.12.76: BAD  -- still broken
>   6.12.77: BAD  -- still broken
> 
> Fixes: 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF platforms")
> Signed-off-by: John Hancock <john@kernel.doghat.io>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

[1] https://lore.kernel.org/all/2c30f181-ffc6-4d63-a64e-763cf4528f48@leemhuis.info/

-- 
மணிவண்ணன் சதாசிவம்
