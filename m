Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4819A36167D;
	Thu, 22 Jan 2026 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769064390; cv=none; b=RGQninlbWu+S5iLTOpKmdv/pe41k0ryeV0inggVksLm4hB+yAKCvINtu5VqCAFL7TDBrKc/aHIIgSEsFtPV8ZXQbd9DsRwfJzLAoInI36Nc2XvX72crXuYWRpYeaQtiU9MRJq9MDnHt9X9CJwexI14fmZ9dLJPmG/poW69YQ15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769064390; c=relaxed/simple;
	bh=l3C4leNeP122VLwNxNXIopmSx5plqphSAE2vsEkdocc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEdRhbbNNIriCICSdGeIGdqwbyUIYZMg2rtMr3E2NTVlBF5hKvOZ357VL4xXbBJPVs0joiaQ7usVf8cgCWp54Xo8AIamvRFC2YXbvh1S3H5P/6K1ummtbvfQvvvP3PjuB9jBeCDNI6Ps2cmctUgt7A2wgLJCibxc+/I9vBEGba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxbGUz07; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxbGUz07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660D4C116C6;
	Thu, 22 Jan 2026 06:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769064389;
	bh=l3C4leNeP122VLwNxNXIopmSx5plqphSAE2vsEkdocc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxbGUz076Q3Y1Q6egPECvGTwjDJR8is169bgUxyu9kdv63v71cfpgh5uWQ+j7j6x8
	 u8xtgxjVtn3C6vvn7UXaJ63ElHoQcP0PXz8mWTeiI6hy8fBumsAF4N/2jzyGPtmnCS
	 upRav+xy50LFevvd/KYWMbsBnaFQ776SMSOBNhcx/q4+PhX3bcwfAazaPlZbVttTRl
	 q1LLALm76TM56gkkcNQNaIHN6NquiN3A4SwwZhIlRoKkfz0ZfbX+zrYtjYPmiHVl4F
	 bwOn1BFraT9ew5+kvfjZYWB3VlGVnQoNNa6Yn87nR7rQJmhw/Virkj/60hYyVQphAu
	 t+cZMbq3GJFig==
Date: Thu, 22 Jan 2026 12:16:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, cassel@kernel.org, 
	frank.li@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <olnmctbz5u5xkheciqqqb2fmjuilpxlnkfuc3bjnsgm2o3t5qx@ffc5ct6jbuxn>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
 <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
 <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <waapztvy6jyjqtfcoo3rbgvagi4z3p5afw6x2acgf5bxatcui6@nkodhtqqtetr>

On Thu, Jan 22, 2026 at 10:52:31AM +0900, Koichiro Den wrote:
> On Wed, Jan 21, 2026 at 09:08:34PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jan 19, 2026 at 10:00:38PM +0900, Koichiro Den wrote:
> > > On Thu, Jan 15, 2026 at 05:49:23PM +0900, Koichiro Den wrote:
> > > > This series proposes support for mapping subranges within a PCIe endpoint
> > > > BAR and enables controllers to program inbound address translation for
> > > > those subranges.
> > > > 
> > > > - Patch 1/5 introduces dynamic_inbound_mapping feature bit. This can be
> > > >   used as a safeguard to check whether a BAR can really be reconfigured
> > > >   without clearing/resetting it.
> > > > 
> > > > - Patch 2/5 introduces generic BAR subrange mapping support in the PCI
> > > >   endpoint core.
> > > > 
> > > > - Patch 3/5 advertises dynamic inbound mapping support via
> > > >   DWC_EPC_COMMON_FEATURES for all DWC-based glue drivers.
> > > > 
> > > > - Patch 4/5 adds an implementation for the DesignWare PCIe endpoint
> > > >   controller using Address Match Mode IB iATU. It also advertises
> > > >   subrange_mapping support via DWC_EPC_COMMON_FEATURES.
> > > > 
> > > > - Patch 5/5 updates a documentation for pci_epc_set_bar().
> > > > 
> > > --(snip)--
> > > > Koichiro Den (5):
> > > >   PCI: endpoint: Add dynamic_inbound_mapping EPC feature
> > > >   PCI: endpoint: Add BAR subrange mapping support
> > > >   PCI: dwc: Advertise dynamic inbound mapping support
> > > >   PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match
> > > >     Mode iATU
> > > >   Documentation: PCI: endpoint: Clarify pci_epc_set_bar() usage
> > > > 
> > > >  Documentation/PCI/endpoint/pci-endpoint.rst   |  24 +++
> > > >  drivers/pci/controller/dwc/pci-dra7xx.c       |   1 +
> > > >  drivers/pci/controller/dwc/pci-imx6.c         |   3 +
> > > >  drivers/pci/controller/dwc/pci-keystone.c     |   1 +
> > > >  drivers/pci/controller/dwc/pcie-artpec6.c     |   1 +
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 203 +++++++++++++++++-
> > > >  .../pci/controller/dwc/pcie-designware-plat.c |   1 +
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |   8 +
> > > >  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +
> > > >  drivers/pci/controller/dwc/pcie-keembay.c     |   1 +
> > > >  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   1 +
> > > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |   1 +
> > > >  drivers/pci/controller/dwc/pcie-stm32-ep.c    |   1 +
> > > >  drivers/pci/controller/dwc/pcie-tegra194.c    |   1 +
> > > >  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +
> > > >  drivers/pci/endpoint/pci-epc-core.c           |   8 +
> > > >  include/linux/pci-epc.h                       |   9 +
> > > >  include/linux/pci-epf.h                       |  27 +++
> > > >  18 files changed, 285 insertions(+), 10 deletions(-)
> > > 
> > > Hi Mani, Bjorn,
> > > 
> > > Based on the feedback so far (thanks to Niklas and Frank), the design seems
> > > to be converging. At this point, I would appreciate confirmation on the
> > > following points before proceeding further.
> > > 
> > > 1) Does the current (v8) approach for BAR subrange inbound mapping at the
> > >    EPC/core level look reasonable?
> > > 
> 
> Hi Mani,
> 
> Thanks for the question.
> 
> > 
> > In this series you didn't add a consumer of this subrange mapping, which I
> > believe is the epf-vntb driver [1]. Even so I don't see a justification of why
> > the BAR needs to be split into multiple subranges. Can you explain that?
> 
> Yes, the first consumer I have in mind is epf-vntb / remote eDMA-backed NTB
> work referenced in [1].
> 
> The motivation for BAR subrange mapping is that some EP platforms
> effectively have only two practically usable BARs, while needing multiple
> logically independent inbound mapping.
> 
> For example, on Renesas R-Car Gen4 Spider, 64-bit BAR0 and BAR2 are the
> only practically usable BARs, since BAR4 is only 256 bytes. epf-vntb
> already needs two separate regions (config+spad and MW1 for the
> data-plane), leaving no spare BAR. Adding ntb_msi requires yet another MW,
> which simply does not fit unless an existing BAR is further divided.
> 
> In theory, some vNTB regions (e.g. config+spad and dynamically allocated
> memory-backed MWs) could be tightly packed into a single physically
> contiguous BAR region to barely make it work. However, it immediately makes
> features mutually exclusive (e.g. ntb_msi / ntb_edma cannot coexist), and
> the layout becomes extremely fragile.
> 
> Similarly, for remote eDMA-backed NTB transport, the host needs separate
> inbound access to the eDMA register block and the LL regions, which are
> distinct local address ranges. Without subrange mapping, the only choice is
> unnatural layout (e.g. dedicating one BAR entirely to eDMA register block,
> and another one to everything else that can be packed into a single locally
> contiguous memory region), even when this is barely possible.
> 
> So while some cases might be made to work by aggressive packing, they are
> already at the limit on platforms such as R-Car Spider. BAR subrange
> mapping allows these features to be implemented in a straightforward,
> loosely-coupled, and extensible way on platforms with severely constrained
> BAR resources.
> 

Thanks for the explanation, makes sense. When you respin this series, please
include it in cover letter and relevant commit message.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
