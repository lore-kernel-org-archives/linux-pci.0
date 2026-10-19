Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446999;
	b=miq6VmhPcNZalwIKrDF8uu7IR6YKJRRIvMDDGJo5YbU/y+rr7PuLySOzk6rJHJpdueGR
	 CM1kiEtzi7uGe+M0/VBMFQAnBN8ZhjdfyPIRqwQQiQyExSGQioyd9ssVJ6vkNutfPxxvi
	 0qf4MBWcnD0rZktctB0HCeV0vaa4MFeal7a/ffQ/nFjWuPjwP2tq8uCyBXq1mO4/gA1bf
	 MdLEUmGsqqZfz8Z/5BKpeHfQ1wMLNlebwQCHYYrxn31G6WpIEDqHMBXWY6P2+V1FExpbY
	 Og15/YZnBEh4PlDs2QxxyOD7vXuBm9k+O2gY8H7kwszkDODLhno0miOOYaLKyG+YZ+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446999;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uDbDRvDPkLpFWAxgfb5Uv4pS9UiCoXyEbXPvzTb819Q=;
	b=WGKx8APegkS/rrmN3bQa8a/oMIP3JL56wJGXnxk9BP47lDFMssfoIbT1BJZp8m6qLR9C
	 SWZ3OVmsOGx4Fjr9t3ooCAGQGzMwAQhI6h7TsMczPijATOKfsGZusnmoXaVdfpzaMCd41
	 lV78hSKHajLcFn+O/m4I33SNRJcnB96HfkXwwzKDTJsnSgJOnokM22ShP7yKsP4YP8Cc7
	 m9L5PP5j8YFjzIj9T9bILdwL6EjAXyMAW6NdDELux88gKYSO0bi64Xyos35ySvJ2BrA60
	 SUHlLkSw8p2diQFWMnkruEHBh0wsbQaHWzCI72UekCce5h0kHWOPrOpm82osoyxqeXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPo1ul98;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292D3606A320;
	Mon, 19 Oct 2026 21:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jPo1ul98
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D711F000C4;
	Mon, 19 Oct 2026 21:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446999;
	bh=uDbDRvDPkLpFWAxgfb5Uv4pS9UiCoXyEbXPvzTb819Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=jPo1ul98XSAB2kcTe2SNsbLB7qBABuJZkr3HXYqzidmUi1YUiqsfPNEco7nZZElgW
	 bLBtGpozjQL1RlXUWLE5MNuJnQUxqek+96SMy1HKFPJ7qtW7RA2SypTbJ5d2/47sRk
	 vkfjQDgB/CRc/o4OKtjZVTZi75hbeyp2cGaGuiIzMaQqnk/AVeYtIW06NNaVABd4B+
	 rpoHXgk9Wo7aIoL4DfW0cs5bWV0DkVGtN26ZEt/1RAEhGiLG5ORsuBmrKo7Zp+v+BD
	 NfQdnxtrkDvSuxiSooQ46HtzsTWBSiyyIxaahmypzjRR4A3lHGwTyeDZdL9FAsq6oJ
	 j0Z3GF4xuNM6A==
Date: Mon, 19 Oct 2026 16:56:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Message-ID: <20261019215637.GA2267961@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019215514.GA2267032@bhelgaas>

On Mon, Oct 19, 2026 at 04:55:15PM -0500, Bjorn Helgaas wrote:
> On Thu, Oct 15, 2026 at 11:10:49AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Oct 14, 2026 at 02:20:49PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 08, 2026 at 11:48:22AM +0530, Sumit Kumar wrote:
> > > > An outbound iATU region matches any local (AXI/application-side)
> > > > address that falls within its Base/Limit window and rewrites it to
> > > > the PCIe-side address programmed in that region's Target Address
> > > > Registers before the transaction goes out on the link. This matching
> > > > does not distinguish CPU-initiated transactions from ones issued by
> > > > the internal DMA engine (eDMA/HDMA).
> > > > 
> > > > Example: outbound region 0 is programmed with Base/Limit covering
> > > > local addresses 0x8000_0000-0x8000_0FFF and Target 0x1_0000_0000, for
> > > > CPU-initiated accesses. The DMA engine is later given a descriptor
> > > > whose destination is the host address 0x8000_0080, which happens to
> > > > fall inside region 0's Base/Limit range. The iATU matches the DMA
> > > > transaction against region 0 too and rewrites it to 0x1_0000_0080
> > > > instead of passing 0x8000_0080 through unchanged. The transaction
> > > > then lands on the wrong host address, causing data corruption or an
> > > > IOMMU fault when the rewritten address has no valid mapping.
> > > > 
> > > > Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when
> > > > programming outbound iATU regions so only CPU/AXI-initiated
> > > > transactions are matched against the region; DMA engine transactions
> > > > bypass the translation and go out on the PCIe link with their
> > > > original address.
> > > > 
> > > > Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> > > 
> > > Thanks for the fix.  A data corruption is pretty disastrous.
> > > 
> > > Is there a Fixes: tag we can add here?
> > > 
> > > Probably also a stable tag?
> > 
> > Just to clarify, there is no reported data corruption due to kernel.
> > Our internal teams saw corruption in the bootloader with overlapped
> > mapping between iATU and eDMA and fixed it with this BYPASS flag. So
> > Sumit wanted to do the same thing in kenrel to avoid hitting such
> > scenarios. That's why there is no fixes or stable tag.
> 
> This doesn't sound very comforting to me.  Unless there's some reason
> similar corruption can't happen in the kernel, I think this deserves
> Fixes: and a stable tag.
> 
> The fact that nobody's reported it doesn't mean it's not happening or
> won't happen.

I guess I had already added a stable tag, but if we knew a Fixes
commit, that would still be helpful for stable kernels.
