Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4F32E7F11;
	Wed, 21 Jan 2026 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009925; cv=none; b=P3pJ903nUukivalJRJBS0hHpaagaaoezOIBI3617smEdxaggozif2Bhp2BuQLm+2BLOXaWhY9Czmu1u0o0TeY2Trv4wK95yUkM53V95RSvkRtKsrgjHURbQgHGPDGuWhcv1sYIvmAMKNvJENSw/CdyabptPLQkgf6pS/dIftVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009925; c=relaxed/simple;
	bh=/cVYzMvPGg66Vrzx3Yi95/UVwa8uQUFIqIWw2gNIqhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3xQfT0HlCsHKcI2yZ38ONWC38Yia14ysovtN6v8zE1s/z2d6YV+qYyi86CUh6j+Z3vUgHsY+oTwOhNIIPP3P2wuhTGRtRV/yOaPLE9r0Lt10cfSxiH5DE2AX+iPcSo+CwZx6GqI9RAWPSlB7hDQJGexejbys89XR2gI1Sgz/r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6PkgkSQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6PkgkSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD779C4CEF1;
	Wed, 21 Jan 2026 15:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769009925;
	bh=/cVYzMvPGg66Vrzx3Yi95/UVwa8uQUFIqIWw2gNIqhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P6PkgkSQb3rgd4ZIHBcbFy0V6dCraPgc7hqfXIzxNXQApNgiv6xjUuL1cZj0UN/C4
	 fmT1jMMOOhjhszS5pTxS0dZPuGRGY/GcpLSekCRnBDi8388HvCtiHNvhQuVYYgKuKA
	 +2Ejhh0O7wIhuklxP0Ved/cq8pnmac+4WZu8nJvnbpXJoPeBQhVTI4znIEhxbsuhDl
	 BPDPL/ih2QfD1WKTwnlI7ql3qhGaHYB2AeeFvQH5OuvUPmWDrLNrTftV3aSbHSTxOj
	 yuJ3aihKlVkt3CB2XVbLSmWwopBZeoPoNhVQDBRV1+8XBgckLRY24BBoYLfMMKMFmE
	 IT15N5tLaOuUA==
Date: Wed, 21 Jan 2026 21:08:34 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, cassel@kernel.org, 
	frank.li@nxp.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] PCI: endpoint: BAR subrange mapping support
Message-ID: <ugxohcm4tvtjwnhkkz7jw226upm7o5hihohzn2f4eoamhkd77v@mjefdgxneghm>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <x64g63zkz5t75vxxlzd7rhbvpus2mmhz2phyvxykuax5wm5cnh@zgpomauf75pv>

On Mon, Jan 19, 2026 at 10:00:38PM +0900, Koichiro Den wrote:
> On Thu, Jan 15, 2026 at 05:49:23PM +0900, Koichiro Den wrote:
> > This series proposes support for mapping subranges within a PCIe endpoint
> > BAR and enables controllers to program inbound address translation for
> > those subranges.
> > 
> > - Patch 1/5 introduces dynamic_inbound_mapping feature bit. This can be
> >   used as a safeguard to check whether a BAR can really be reconfigured
> >   without clearing/resetting it.
> > 
> > - Patch 2/5 introduces generic BAR subrange mapping support in the PCI
> >   endpoint core.
> > 
> > - Patch 3/5 advertises dynamic inbound mapping support via
> >   DWC_EPC_COMMON_FEATURES for all DWC-based glue drivers.
> > 
> > - Patch 4/5 adds an implementation for the DesignWare PCIe endpoint
> >   controller using Address Match Mode IB iATU. It also advertises
> >   subrange_mapping support via DWC_EPC_COMMON_FEATURES.
> > 
> > - Patch 5/5 updates a documentation for pci_epc_set_bar().
> > 
> --(snip)--
> > Koichiro Den (5):
> >   PCI: endpoint: Add dynamic_inbound_mapping EPC feature
> >   PCI: endpoint: Add BAR subrange mapping support
> >   PCI: dwc: Advertise dynamic inbound mapping support
> >   PCI: dwc: ep: Support BAR subrange inbound mapping via Address Match
> >     Mode iATU
> >   Documentation: PCI: endpoint: Clarify pci_epc_set_bar() usage
> > 
> >  Documentation/PCI/endpoint/pci-endpoint.rst   |  24 +++
> >  drivers/pci/controller/dwc/pci-dra7xx.c       |   1 +
> >  drivers/pci/controller/dwc/pci-imx6.c         |   3 +
> >  drivers/pci/controller/dwc/pci-keystone.c     |   1 +
> >  drivers/pci/controller/dwc/pcie-artpec6.c     |   1 +
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 203 +++++++++++++++++-
> >  .../pci/controller/dwc/pcie-designware-plat.c |   1 +
> >  drivers/pci/controller/dwc/pcie-designware.h  |   8 +
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c |   2 +
> >  drivers/pci/controller/dwc/pcie-keembay.c     |   1 +
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c     |   1 +
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |   1 +
> >  drivers/pci/controller/dwc/pcie-stm32-ep.c    |   1 +
> >  drivers/pci/controller/dwc/pcie-tegra194.c    |   1 +
> >  drivers/pci/controller/dwc/pcie-uniphier-ep.c |   2 +
> >  drivers/pci/endpoint/pci-epc-core.c           |   8 +
> >  include/linux/pci-epc.h                       |   9 +
> >  include/linux/pci-epf.h                       |  27 +++
> >  18 files changed, 285 insertions(+), 10 deletions(-)
> 
> Hi Mani, Bjorn,
> 
> Based on the feedback so far (thanks to Niklas and Frank), the design seems
> to be converging. At this point, I would appreciate confirmation on the
> following points before proceeding further.
> 
> 1) Does the current (v8) approach for BAR subrange inbound mapping at the
>    EPC/core level look reasonable?
> 

In this series you didn't add a consumer of this subrange mapping, which I
believe is the epf-vntb driver [1]. Even so I don't see a justification of why
the BAR needs to be split into multiple subranges. Can you explain that?

> 2) From a process perspective, does it make sense to continue this as a PCI
>    endpoint subsystem-led series, with the dwc-specific changes layered on
>    top, or would you prefer a different split or ownership?
> 

Is is OK to have both controller driver and endpoint changes in one series.

- Mani

[1] https://lore.kernel.org/linux-pci/20260118135440.1958279-14-den@valinux.co.jp

-- 
மணிவண்ணன் சதாசிவம்
