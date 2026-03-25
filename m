Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD142303A37;
	Wed, 25 Mar 2026 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422390; cv=none; b=OMs+NSuig5i4PXgfCJeMfipf9F8fFsDF7vEZxjmMg/AMUzgDA1DNrneCAMi0PcNjw5pHA/M7Y2o/zwJAlXY0SwzWPKrlkRDX0K7toQjZlwbLuLtn2IrjHRw8EHSNJlDU38GWcPMldcgFDG1bnz2g8EMoVT8Qa6XK1+tDIDW2luQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422390; c=relaxed/simple;
	bh=yH2pUn92qroFRpAG5jB7Pum69ylh4btcLL6GWZG4RIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuXB10H+51ynihf4zdcn6FM0k9FYzGceLBUcdrL2iI+QZ22El46xR/H6MnLL9GPvA4CxaeMABwq7os9thhCwv8Pc/LLgy5LI4LeEONdvuF6N5WrhhDUpyhroBg34YR80jy0YLrp4nSkNp1JZkqmr7SCCkiuxwaUWqw5CW3YC8+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTN6+iAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTN6+iAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6206C4CEF7;
	Wed, 25 Mar 2026 07:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774422390;
	bh=yH2pUn92qroFRpAG5jB7Pum69ylh4btcLL6GWZG4RIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTN6+iAvabDH1PT7tq9kY9NHiUsHhNJwYcxlAwYSxJDycthQK1jq+cjuNmPbC1G9Z
	 gaACanAIangH4lVjlJGhLJ3/f/8eJRQ4NlaaSTCUo4g3GG4Kx6vqIAtQT46pUM4uYO
	 Ak8tFN7MnK8Woa/HtTwnmS+TzB2DpOY1QtnLYlEJi4DBxZwMPbOOZf7Y3qvYoSMQ+c
	 McS1mzha8QT1GhAG6yJpmhdFoqpX/qoMezSzrLwhHdKWRmMJadzc/Xa/l+tpn2WPUi
	 CO/pwMTIvqMKy2DaQ3dhjisouSEOvvKLtAdo3etjTODPVr030b5HsypnTrLLgXSOh8
	 Z8WGMhug+1USA==
Date: Wed, 25 Mar 2026 08:06:24 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Frank Li <Frank.li@nxp.com>, Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v10 7/7] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <acOJcMt7E8PLHAD6@ryzen>
References: <20260302071427.534158-1-den@valinux.co.jp>
 <20260302071427.534158-8-den@valinux.co.jp>
 <acGK6rUIyuJP6gF7@lizhi-Precision-Tower-5810>
 <ksr6hlcwmrkrgrql5jqhtpkaihsugtsztfhxxjbq3au6kz3ksu@mk7hhmwabgsi>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ksr6hlcwmrkrgrql5jqhtpkaihsugtsztfhxxjbq3au6kz3ksu@mk7hhmwabgsi>

On Tue, Mar 24, 2026 at 10:40:24AM +0900, Koichiro Den wrote:
> On Mon, Mar 23, 2026 at 02:48:10PM -0400, Frank Li wrote:
> > On Mon, Mar 02, 2026 at 04:14:27PM +0900, Koichiro Den wrote:
> > > Some endpoint platforms cannot use platform MSI / GIC ITS to implement
> > > EP-side doorbells. In those cases, EPF drivers cannot provide an
> > > interrupt-driven doorbell and often fall back to polling.
> > >
> > > Add an "embedded" doorbell backend that uses a controller-integrated
> > > doorbell target (e.g. DesignWare integrated eDMA interrupt-emulation
> > > doorbell).
> > >
> > > The backend locates the doorbell register and a corresponding Linux IRQ
> > > via the EPC aux-resource API. If the doorbell register is already
> > > exposed via a fixed BAR mapping, provide BAR+offset. Otherwise provide
> > > the DMA address returned by dma_map_resource() (which may be an IOVA
> > > when an IOMMU is enabled) so EPF drivers can map it into BAR space.
> > >
> > > When MSI doorbell allocation fails with -ENODEV,
> > > pci_epf_alloc_doorbell() falls back to this embedded backend.
> > >
> > > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > > ---
> > ...
> > > +	 */
> > > +	if (doorbell->bar == NO_BAR) {
> > > +		phys_base = addr & PAGE_MASK;
> > > +		off = addr - phys_base;
> > > +		map_size = PAGE_ALIGN(off + sizeof(u32));
> > > +
> > > +		iova_base = dma_map_resource(epc->dev.parent, phys_base,
> > > +					     map_size, DMA_FROM_DEVICE, 0);
> > 
> > DB should write. Is it DMA_TO_DEVICE?
> 
> Thanks for reviewing.
> 
> The write is initiated by the peer (RC) and lands in this EP-side doorbell
> target, so from the EP side this is a DMA_FROM_DEVICE mapping.

I don't understand.

If the RC side does a PCI TLP write, the iATU on the EP side should translate
that to an AXI write, no?

If the target address (doorbell register in this case) is only mapped as a
DMA_FROM_DEVICE (read), I would have expected that AXI write to result in an
IOMMU fault.

Is the IOMMU really running in strict mode and not in passthrough mode on
your platform?

Do you get an IOMMU fault if you change this code to DMA_TO_DEVICE ?


Kind regards,
Niklas
