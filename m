Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE61A2C0B;
	Thu, 15 Oct 2026 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042859; cv=none; b=R7AQ62u2OmvJMdHjBeOM+2OhOLr4p7ZbG0UbErFd8GV26b65qGOKCtjq5qSLiOMH8MMjpUzC1RL3ZSC746Cfnf49Wda72KwB2sn2+9p1vpSU9ZJg7G8QmZTwD+3NebtdnMWQsIBxoS+z1GqdAoCdMaZDE05d7I1gCeFK8K9x8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042859; c=relaxed/simple;
	bh=60h/AF4kAwJ0nNWfIv00sY6S9PL5kkDZviQScRL1YtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNmMSr6Kb7l/XluL4+i2OJ/lyxeaBzX65cui8Zq6myaGNb7BoOOqg+JGrRAQ8HWPMqrM/dzIydCDIL3OX8s40WIb94QUPQPXEIgjZGyJKT4LOhs8VUeheq6u8VNKoxuieruWKKekDD/jGRLmMdvMBfiN7RuUEzmW5MXW96kPkw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTVQal+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTVQal+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992F71F000C4;
	Thu, 15 Oct 2026 05:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792042858;
	bh=e+pp3mKzbb91ORUWGgV2fdgl67WxzZCNNBh+W0iCaXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QTVQal+Aj5xF8kncdNXwZfRocTiXpkK0/mDvgUYW+xoAk7dB0v6zVkOIrf9ks5NVc
	 YxLg2jbawcsNupRkc1VhMQ7Ne5FfDVMxThYgzuMPWXTPWXhJcPV5q8QmUa6fgsiL3Q
	 pxeLAg2dCmKBOhQk3A34h+orotkIVRE7S4CmYhp4av89r6lJHElm6yUIiVOVaRZxKN
	 14FhloM/+nCBEHXM2dXN1ZQn+167MWnupcu8lTn5p6CCTPR0i7aDa++05A8n7cLhFR
	 Q2bsRhZerjAP5jjItYHmUnxcYXUMEDdVXmdV5llcUmZalsdOGrCpsPoff7d0GZxaQ8
	 SocuMWG6bROhQ==
Date: Thu, 15 Oct 2026 11:10:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Message-ID: <atBkh5nZEL88Gr6c@debian>
References: <20260908-dma_bypass-v2-1-c3c81d408c0c@oss.qualcomm.com>
 <20261014192049.GA1654252@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014192049.GA1654252@bhelgaas>

On Wed, Oct 14, 2026 at 02:20:49PM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 08, 2026 at 11:48:22AM +0530, Sumit Kumar wrote:
> > An outbound iATU region matches any local (AXI/application-side)
> > address that falls within its Base/Limit window and rewrites it to
> > the PCIe-side address programmed in that region's Target Address
> > Registers before the transaction goes out on the link. This matching
> > does not distinguish CPU-initiated transactions from ones issued by
> > the internal DMA engine (eDMA/HDMA).
> > 
> > Example: outbound region 0 is programmed with Base/Limit covering
> > local addresses 0x8000_0000-0x8000_0FFF and Target 0x1_0000_0000, for
> > CPU-initiated accesses. The DMA engine is later given a descriptor
> > whose destination is the host address 0x8000_0080, which happens to
> > fall inside region 0's Base/Limit range. The iATU matches the DMA
> > transaction against region 0 too and rewrites it to 0x1_0000_0080
> > instead of passing 0x8000_0080 through unchanged. The transaction
> > then lands on the wrong host address, causing data corruption or an
> > IOMMU fault when the rewritten address has no valid mapping.
> > 
> > Set the DMA_BYPASS bit (bit 27) in PCIE_ATU_REGION_CTRL2 when
> > programming outbound iATU regions so only CPU/AXI-initiated
> > transactions are matched against the region; DMA engine transactions
> > bypass the translation and go out on the PCIe link with their
> > original address.
> > 
> > Signed-off-by: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
> 
> Thanks for the fix.  A data corruption is pretty disastrous.
> 
> Is there a Fixes: tag we can add here?
> 
> Probably also a stable tag?
> 

Just to clarify, there is no reported data corruption due to kernel. Our
internal teams saw corruption in the bootloader with overlapped mapping between
iATU and eDMA and fixed it with this BYPASS flag. So Sumit wanted to do the same
thing in kenrel to avoid hitting such scenarios. That's why there is no fixes
or stable tag.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
