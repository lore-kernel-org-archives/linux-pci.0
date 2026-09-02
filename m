Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E0347CC61;
	Wed,  2 Sep 2026 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365860; cv=none; b=ZzKfi+MGDTgv988M9YaTWXQhM/z7COPyyI8SBSIBTj65ZEKMeY0rr2CGP+pyO4Qhrm/8U3a8m2oJy/dUc7yTYfmJxUmUtD3JHlSsIzii6lAX9jzN4y6YPivhGlpiylF8q8F+5mNAd8TgaLWedxl7ee10NrdyNExnPiL6ru7+QM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365860; c=relaxed/simple;
	bh=feJLjaoRO5MTUw07fK0MovOxVpKZEyTBIhRlwxGt338=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgG6EzVAJeEnm6ybwOlP7mk0Ku//t/zIFhzEs1VCJvgsOUFsS55wgg9a23qmV/EnKDpXOov2MQAnw4fBcMR3tNsrQ1Kgm4/sO+pPfp+MeBLQEIT/mNkN4uA7TmGH0H4IlZiAhC2BM6gKgDnPKyfAIvpcMvy9Nn3aaad5XQrsfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qnz4sLd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qnz4sLd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AE21F000E9;
	Wed,  2 Sep 2026 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788365858;
	bh=0uPuxViRRq9sGuevsb7PIbKIcGOTftVVcH6FfLyGlRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qnz4sLd6aFj/IwhnhG/QX4Wm4Ns41YYSiMb7IYCBNw1kx6fyLMdDfaMpNa6p+FxMk
	 Ehb9f/WjWSOfgIWOWS2ofoxfu9pJWXQqrtgDMS/QIGc0NgkFOJUAh6QCFefXhL3eWO
	 /neTpPSFWLy32rWcetRdO5onWurynCLx/dybD+w8NBt8HW3PhiwimtQSdrS7vd61Ew
	 feD/oje/JdvZVhoRtWkmbNPdP2xJU4du3MHzX5QsRjvk1nE578iwM60mh3l/9ipnmq
	 Ln+fpVgkiPXME6ZopLAA93nmwcUJogIJMMUIN+GGNQTPLWt8Uneo2kCQEqV47uIREh
	 hYgKkcbfEzPjQ==
Date: Wed, 2 Sep 2026 18:17:27 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Sumit Kumar <sumit.kumar@oss.qualcomm.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: designware: Set DMA_BYPASS bit in outbound IATU
 CTRL2 register
Message-ID: <ycyc7cm4y6s4nmez3aojdenqikh35eqvk2ady2azbiyghbbg4v@r3dzmymx2xuf>
References: <20260826-dma_bypass-v1-1-3a53dc748ce2@oss.qualcomm.com>
 <mivyhgl3axsebyqktjqqglqgra3ptx4q3u5a3ybudmnxigvdqy@tn5sga4z45cu>
 <1fe0ff27-abc6-4813-a4a8-8bf8ca92b91a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fe0ff27-abc6-4813-a4a8-8bf8ca92b91a@oss.qualcomm.com>

On Wed, Sep 02, 2026 at 08:44:57PM +0530, Krishna Chaitanya Chundru wrote:
> 
> 
> On 9/2/2026 7:37 PM, Manivannan Sadhasivam wrote:
> > On Wed, Aug 26, 2026 at 02:41:20PM +0530, Sumit Kumar wrote:
> >> Outbound IATU apertures are configured with local device-side addresses.
> >> When DMA engine transactions use destination addresses which fall within
> >> an outbound IATU aperture range, they get unintentionally translated by
> >> the IATU, causing the wrong address to be sent on the PCIe link.
> >> This results in data corruption or IOMMU errors at the host if the
> >> translated address is not mapped.
> >>
> > Why are you using the same device address in both DMA and iATU mapping? This
> > sounds like a mapping problem that you should fix instead.
> issue happens, when host address(DMA destination address) matches with the
> internal iova address programmed in iATU src address.
> As we can cannot address in both,  we need to program iATU in DMA bypass mode,
> so DMA transcations will not go through iATU window.
> 

This needs to be explained clearly in the commit message with an example
matching the DWC terminologies such as 'Target Address Registers'.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
