Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4457E396B9D;
	Thu, 22 Jan 2026 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769095076; cv=none; b=KHh+5hWAQHlrFA84bsr/siAiJeqIbcj7Gq9pRScPv+4lJhb5/wZ8hKX7p1QWDWGbfNQeU+1FCMNM5QqpbBgYKrdge81uehJjn7AqM2XCF059OVnZNdNRUy9WP6a8z/wn3io6xPtWJ/0Fhu39QNUl7pF/kbQQJwhuxZojQ7V+uhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769095076; c=relaxed/simple;
	bh=qEODlWXdMd+0Sm+sbjlafpL7KR/Cpsa/l7N+JEj2i/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmfxtGkzRfedTvHB2ydBgLtNU/pkuDpRbSXrdC9qiVwm3cwEsDFDQyl7wM4ICP5qdgOjnFAMAivVYHXRZhRYYYoqqb47B/KA5RHb8/TFFrKRagGWHuPgpQWIfz80V5Hj6k3S/ybfEwTkTO7BQFYSfgfTRo2xHqJCdrTK2fW5+LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCLx8PBm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCLx8PBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A59FC116C6;
	Thu, 22 Jan 2026 15:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769095075;
	bh=qEODlWXdMd+0Sm+sbjlafpL7KR/Cpsa/l7N+JEj2i/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCLx8PBm6k2mCIayRhJISqPPa68x2ZxObznluwsmbZ/WLj8AySmjnNbwDPog6NWTe
	 JdmhXQ7x07aBVZWpOqFivMFlU+E5X1LtDvCH0I8pYGpwv1nzkO4pLAM0wbEm5BG60I
	 b42LIeDK6j5DbiE06nidTvjcWelc4M7SFtF44Et8ucsqElhAPkHajk27wSsUXRH8CM
	 nyCAKIHubfmZmO5iG2FIFEtQblwVO5Sx2aNTPm2PkpWly/8oNJa/DwhJQmliziRwFW
	 6Q7XoVOFQyMmbmLtFGWNVJR6ioCAFPE1hwHzsKy/v9lwXNP2DaV78cy20bDwybMPZ4
	 /SF5QWPo1yrOw==
Date: Thu, 22 Jan 2026 16:17:51 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, bhelgaas@google.com,
	kwilczynski@kernel.org, frank.li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <aXI_ny1-5NlN8r_z@ryzen>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
 <aXHfUyd0EPFnoVBO@ryzen>
 <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tvaumsi4ahosz4herbxoc636fj3lhetjzqlwp5n4e34tthmn26@bld32k6xntmw>

On Thu, Jan 22, 2026 at 11:02:42PM +0900, Koichiro Den wrote:
> On Thu, Jan 22, 2026 at 09:45:13AM +0100, Niklas Cassel wrote:
> > Hello Koichiro,
> > 
> > On Thu, Jan 22, 2026 at 10:52:31AM +0900, Koichiro Den wrote:
> > > > 
> > > > In this series you didn't add a consumer of this subrange mapping, which I
> > > > believe is the epf-vntb driver [1]. Even so I don't see a justification of why
> > > > the BAR needs to be split into multiple subranges. Can you explain that?
> > > 
> > > Yes, the first consumer I have in mind is epf-vntb / remote eDMA-backed NTB
> > > work referenced in [1].
> > 
> > Another consumer in your RFC series is pci-epf-test, specifically:
> > [RFC PATCH v4 35/38] PCI: endpoint: pci-epf-test: Add pci_epf_test_next_free_bar() helper
> > [RFC PATCH v4 36/38] PCI: endpoint: pci-epf-test: Add remote eDMA-backed mode
> > [RFC PATCH v4 37/38] misc: pci_endpoint_test: Add remote eDMA transfer test mode
> > [RFC PATCH v4 38/38] selftests: pci_endpoint: Add remote eDMA transfer coverage
> > 
> > where the pci-epf-test exports the eDMA registers (using subranges) over a
> > BAR, and then in the host side driver, calls dw_edma_probe() on this subrange
> > and uses the host side driver to control the eDMA residing in the endpoint.
> > 
> > Most of your patches in [RFC PATCH v4 35/38] have NTB prefix.
> > 
> > Would it not be possible to simply include patches 35-38 in this series,
> > so we actually have a consumer, or do you need some other patches as well?
> 
> Sorry, I sent v9 just a few minutes after your email, without noticing it,
> and then I was AFK for several hours.
> 
> > 
> > E.g., perhaps
> > [RFC PATCH v4 01/38] dmaengine: dw-edma: Export helper to get integrated register window
> > 
> > Would also be required?
> 
> Yes, please see the section "Patch layout" in:
> https://lore.kernel.org/all/20260118135440.1958279-1-den@valinux.co.jp/
> 
>   [...]
>   1. dw-edma / DesignWare EP helpers needed for remote embedded-DMA (export
>      register/LL windows, IRQ routing control, etc.)
> 
>      Patch 01 : dmaengine: dw-edma: Export helper to get integrated register window
>      Patch 02 : dmaengine: dw-edma: Add per-channel interrupt routing control
>      Patch 03 : dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
>      Patch 04 : dmaengine: dw-edma: Add notify-only channels support
>      Patch 05 : dmaengine: dw-edma: Add a helper to query linked-list region
> 
> Patches [RFC PATCH v4 01/38] through [RFC PATCH v4 05/38] are prerequisites
> for the PCI test update, in addition to this "PCI: endpoint: BAR subrange
> mapping support" series. Note that this series is described in "Kernel
> base / dependencies" section of the large RFC series cover letter.
> 
> For this reason, those test cases cannot be included in this series.

Ok, I assumed that some of those 5 patches were either eDMA optimizations
or things needed for NTB.

But if you need them even to just probe the eDMA driver on the host side
(using registers from the remote eDMA), then perhaps it is too much.

I was hoping that we could at least have a very simple test,
e.g. pci-endpoint-test only supporting READ or WRITE using remote eDMA.

At least then we would have a consumer part of this series.

pci-endpoint-test could have been further extended in a follow up series
if there were some eDMA driver patches that were needed for more complex
operations than a simple READ or WRITE using remote eDMA.


Kind regards,
Niklas
