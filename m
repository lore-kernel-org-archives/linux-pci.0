Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489983B6C1E;
	Mon, 23 Mar 2026 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278848; cv=none; b=o48eARH0oF9lKE9ThNgUFFYu3MJgQc7MVCRik3sW+W/5rYGw8sr1Cia2CRVDj3glcDCj9+ZxDzhEx0HUaU5Nrm/qCUBrDZ0R+vEmlgvzbpwOjmgKvtX+gaol7z8zuUv1cdPjN6yBYVx2Wt5Ioz3ycTkbbIpKX6CAilSNOFxI7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278848; c=relaxed/simple;
	bh=uCTsVCB94ND/6p/t/EZKvsMR2jJxIwXSGTHUGawwKnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTPWG8+8FfcunJGhMOPccSHR+dd7pKHJlRbU8Fskhmwazl1jNr2MHjFS/avny62Jhr/56Qz/1/oKuPLjBvnCaUQMFXU8f4dN/iH0ckF/c22LAJvHS8z3SKAZYyK/3JxZbCRIWsa7GQeMBohiSU7BChefaf6vyl29U/vNcc4GUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OR3o0q+g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OR3o0q+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF373C2BC9E;
	Mon, 23 Mar 2026 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774278847;
	bh=uCTsVCB94ND/6p/t/EZKvsMR2jJxIwXSGTHUGawwKnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OR3o0q+gv2nRbQU0nz8FW1lIDfplTVFV8h1w+r3thFS4Tr4PGFn7nGugr00RL78gX
	 TAjsZlw9bp644wzqzivwgcPgpx0cYcYtXeBTNT2LfKapsYmMCjyu9r5T1OLj9Y4SCU
	 Gnm5oY8e+f+HlzpF9cM9AM9ifg/H6szv4DXlIQ3CpvdH35ksA//FBdXcqRErRbaT2s
	 9Zzvpj7FldX4W/5ejQEAhHKEa1mznNFwO+neeGOaeMPpMS5JzjabyjHVrC6WTDvrO3
	 5RewbwZAkWUAWUiwFs60iAKJwaELshK1OKLbYFd05oTo50jcHOjucRJ7qmoFzdjqW6
	 +Q3UUFiTAIZJw==
Date: Mon, 23 Mar 2026 20:43:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: John Hancock <john@kernel.doghat.io>, stable@vger.kernel.org, 
	bhelgaas@google.com, manivannan.sadhasivam@oss.qualcomm.com, joro@8bytes.org, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [REGRESSION] PCI: Revert "Enable ACS after configuring IOMMU for
 OF platforms"
Message-ID: <ovfco6pqzw734flu7navat36avt6yfosruouduhmbti7umunus@ijmu6nhz56l5>
References: <20260320172335.29778-1-john@kernel.doghat.io>
 <o7nnlvtkmatzafs44um6h5wnqo755msiukfn6kbu2zxdhe45ws@mde5lt2ufusz>
 <fad11c37-5bfb-44fd-b0bf-2a2d15b3382c@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fad11c37-5bfb-44fd-b0bf-2a2d15b3382c@arm.com>

On Mon, Mar 23, 2026 at 03:06:16PM +0000, Robin Murphy wrote:
> On 23/03/2026 1:54 pm, Manivannan Sadhasivam wrote:
> > + Robin
> > 
> > On Fri, Mar 20, 2026 at 01:23:35PM -0400, John Hancock wrote:
> > > Commit 7a126c1b6cfa ("PCI: Enable ACS after configuring IOMMU for OF
> > > platforms") introduced a regression affecting AMD IOMMU group isolation
> > > on x86 systems, making PCIe passthrough non-functional.
> > > 
> > > While the commit addresses a legitimate ordering issue on OF/Device Tree
> > > platforms, the fix modifies pci_dma_configure(), which executes on all
> > > platforms regardless of firmware interface. On AMD systems with IOMMU,
> > > moving pci_enable_acs() from pci_acs_init() to pci_dma_configure() alters
> > > the point at which ACS is evaluated relative to IOMMU group assignment.
> > > The result is that devices which previously occupied individual, exclusive
> > > IOMMU groups are merged into a single group containing both passthrough
> > > and non-passthrough members, violating IOMMU isolation requirements.
> > > 
> > 
> > Ouch! Sorry for the breakage.
> > 
> > > The commit author notes that pci_enable_acs() is now called twice per
> > > device and that this is "presumably not an issue." On AMD IOMMU hardware
> > > this assumption does not hold -- the change in call ordering has
> > > observable and breaking consequences for group topology.
> > > 
> > > It is worth noting that this is a stable/LTS series (6.12.y), where
> > > changes to fundamental PCI initialization ordering carry significant
> > > risk for production and specialized workloads that depend on stable
> > > IOMMU behavior across kernel updates. A regression of this nature --
> > > silently breaking PCIe passthrough without any configuration change on
> > > the part of the user -- is particularly disruptive in a series that
> > > users reasonably expect to be conservative.
> > > 
> > 
> > I still haven't investigated this failure deeply, but it is also worth noting
> > that this regression only happens with v6.12 and earlier stable kernels as
> > mentioned in [1].
> 
> Oops, indeed, relying on pci_dma_configure() to be called prior to group
> assignment in iommu_init_device() only works since bcb81ac6ae3c ("iommu: Get
> DT/ACPI parsing into the proper probe path") added that call path in 6.15 -
> thus the backport probably doesn't actually work for OF platforms either.
> 

Ah, that makes sense. Thanks for finding the root cause. It might be very
obvious to you, but still... ;)

> Dropping this from 6.12.y and earlier stable branches seems like the correct
> action to me (but not a mainline revert, obviously). ACS had essentially
> *never* worked properly on OF platforms prior to 6.15, but that was more
> down to fundamental design flaws in the OF-based IOMMU probe path (dating
> back to 4.12) rather than any easily-fixable bug as such, so realistically I
> think we just leave it that way.
> 

That's my opinion as well. I guess I need to send reverts for rest of the older
stable kernels as well.

Thanks once again, Robin!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
