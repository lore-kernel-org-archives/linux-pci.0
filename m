Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB699326939;
	Wed, 14 Oct 2026 08:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966485; cv=none; b=Laovhz7Ucv81GdlHfT3iNyj5UbeVh9R08kBgT+zqQ9cn/LfeXzWPm0HM/NsAwk0ShbpTxAFcn1zSgPlMf2haOsQw0fcp1pR9A75bu3YG1WU6It8smcHuU5qz5FQ0ZQDGGFcHMRNMyng5wIjHInEN3pDmEexg5cKOO2ez6xK6ljY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966485; c=relaxed/simple;
	bh=8giWh1T12GMTVztM/2ioAl4OXuZ/f+xoOalqtETpsWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8xhValXPmKmBHHKlHeTTziizxa+/ab4HJekazRnf9ffXxHbSdRcpQSa97jVnZfSIqKaJ04VXD/qGa4UhR1774xWKKw5ASPgISh+sDWX9goRHar/QVUc5MWOLlfQ5K8k/0oFqYLjKq14SWTmU0bDuUvyPkEaZRr4lHq99M9nDwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlvjZqfb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlvjZqfb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E6FF1F000FF;
	Wed, 14 Oct 2026 08:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791966483;
	bh=6+YSXriowuORNbNN2ZVVTJAIku37Aff7wkvRdfJWxGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GlvjZqfb2wQfqajnaQCD5sQHfN64KKq5oGHhCNPJVNwER+Amc9CexBwMBaUp5ihZm
	 wLNpv5ELGTpL4QSIII0+pyiwdlrV8Wo/YbpA8FCaOqfiHysXUOwLCruV33ojsVWkK0
	 tQysYT/Bd7Ss06u9fvPYWnAUm/lFQgtmY3EhVl34a9wbjH3hLG/5BhlhKM2+V+6Tug
	 LfzwysFBKfvViibY0k4BWte2MvApQ3meupb8MsCR35hA4E04Xg41uilvkWCB6ITImp
	 8ClHIDppAVQfXkhyIPJsEZnUAV1B3Ltj4zaYhMT0Vb5qu6ayB6gbpDuYvaQtPY7y/7
	 yXpCNwSJSpkiQ==
Date: Wed, 14 Oct 2026 10:27:57 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Xincheng Zhang <zhangxincheng@ultrarisc.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jia Wang <wangjia@ultrarisc.com>, Frank Li <Frank.Li@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU
 setup
Message-ID: <as89A9X9wAHJ-dIR@ryzen>
References: <20260905025635.211390-1-zhangxincheng@ultrarisc.com>
 <20260905025635.211390-2-zhangxincheng@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905025635.211390-2-zhangxincheng@ultrarisc.com>

On Sat, Sep 05, 2026 at 10:56:34AM +0800, Xincheng Zhang wrote:
> Some DWC-based controllers do not require outbound iATU windows for MEM
> transactions. For those platforms, programming outbound iATU windows for
> host bridge MEM ranges is unnecessary and may constrain the available MEM
> aperture.
> 
> The DWC PCIe RP Controller Databook v6.00a, section 3.12.2, describes the
> default outbound no-match behavior as pass-through. Section 3.12.5.6, "No
> Address Match Result", says the address is not translated and programmable
> TLP header fields come from the application transmit interface.
> 
> This no-match path cannot translate between different parent-bus and PCI
> addresses, so require skipped MEM ranges to be identity-mapped.
> 
> Add dw_pcie_rp::bypass_ob_mem_iatu so drivers can skip generic MEM iATU
> setup while using the common DWC host init path.
> 
> Existing drivers keep the current behavior because the flag defaults to
> false. The I/O iATU setup does not use the MEM resource iterator, and the
> iterator may be uninitialized when MEM setup is skipped. Avoid using it in
> the I/O iATU error path.
> 
> Signed-off-by: Xincheng Zhang <zhangxincheng@ultrarisc.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c   | 17 +++++++++++++++--
>  drivers/pci/controller/dwc/pcie-designware.h    |  1 +
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f5a38e6fd8d79..b06797b4e31d2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -918,6 +918,20 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		atu.parent_bus_addr = entry->res->start - pci->parent_bus_offset;
>  		atu.pci_addr = entry->res->start - entry->offset;
>  
> +		if (pp->bypass_ob_mem_iatu) {

Sorry for commenting on this patch after it was accepted.

But... since this behavior is intrinsic to the DWC controller, rather than
being SoC specific... Why bother creating a flag for it?

Is there a reason why this can't just be a simple:

if (atu.parent_bus_addr == atu.pci_addr)
	continue;

?


Kind regards,
Niklas
