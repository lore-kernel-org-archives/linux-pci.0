Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC2252ED35;
	Wed,  9 Sep 2026 11:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951652; cv=none; b=Z2YVh0gvOrtgKoj8TStJEsNMvPzATS6lVPfAKnGIPIWTMQRiPYkYKlKKkwEwTdvvRaMaQRNygfP2wPntj1Mq8kmYcqkKWe0xLFC4cUksNK7iAhKmeZLEoJDcfpsn8WQsIzWUZ3ghje0jGznyvIJ0lbcAQs6LMCRE+eYpslbVmqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951652; c=relaxed/simple;
	bh=uuGwBTr3ObZ4lX0PlC0pqVj5br6iglDdWCsLH+HUjLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDgs1FGKM0TsypMXWCOKVHU10W58ciaKROsjHyIGzB1bL7hXtEjxjCJkZJQNKKRRt5LUqMvYf+EmArOpzP7fKlpuX/rqniss9Z9+rzG6qb4HYIUxi7FoD3ZUyU8Z45xhW7khOD7ub0b+/CjT/IZyWXjcZlBWvi1qMiZEYT4rspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEH80Plb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEH80Plb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9BE1F00A3A;
	Wed,  9 Sep 2026 11:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951648;
	bh=81RFY15HI7q4RaQS4NlHrzl1waLN2dzXgXOHaXwggks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iEH80PlberOVP7ReyTrnxuvlXpi3MPo+RMyVbGHC9JTNivPZBHDdUIX65ri6Uw0nT
	 lB8CLDgXofys76Ww99v9wts+wVcaagLR1Avnx+NVQDTnu/bfF5s3AHyWsmsotyrRnM
	 cjwUgo6gGsrPrMKoZWudHn5n+2McS94Rd9GtGFwh9f3gxldpIH54rgOQhPP1t1N+Yf
	 x12CvJmauj5iX0jYm595+Ll8S08oijotKKrNtiKG1W6kXTdXjEqRGj4Gmf5o0Uiq0P
	 JXfbZQQKpbhhxiDV/UWIzpFlilIZmvAR+JSGeaB4zGm3mRPLsmMBPodiyDo9JDLX3Y
	 flGIVop/kej6Q==
Date: Wed, 9 Sep 2026 13:00:41 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	konrad.dybcio@oss.qualcomm.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/3] PCI: dwc: Force L2 link entry on shutdown/reboot
 without D3cold check
Message-ID: <tkcout2ymlzvcx6my2hal5hgh4fxcpppxl2t5s4wogz3hjykp6@k72ig7seb7m2>
References: <20260905-shutdown-v5-0-f0c6bafa1d4f@oss.qualcomm.com>
 <20260905-shutdown-v5-2-f0c6bafa1d4f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905-shutdown-v5-2-f0c6bafa1d4f@oss.qualcomm.com>

On Sat, Sep 05, 2026 at 06:18:49AM +0530, Krishna Chaitanya Chundru wrote:
> dw_pcie_suspend_noirq() normally calls pci_host_common_d3cold_possible()
> to check whether every downstream endpoint can be put into D3cold before
> bothering to move the link to L2. If no endpoint supports it, the
> function returns early and leaves the link up.
> 
> Querying D3cold support during shutdown is actively harmful, not just
> slow: pci_host_common_d3cold_possible() requires every active endpoint
> to already be in PCI_D3hot, and returns false otherwise. If any endpoint
> is still in D0 -- which is common, since endpoint drivers aren't
> guaranteed to have suspended by the time the host's shutdown path runs
> the check fails and dw_pcie_suspend_noirq() returns early without ever
> moving the link to L2, leaving it up right up to the point where the
> system cuts power/clocks to the controller.
> 
> Add a "force_d3cold" flag to struct dw_pcie_rp that callers set
> explicitly to force this behavior, rather than having
> dw_pcie_suspend_noirq() infer the shutdown/reboot case itself from
> system_state. Still call pci_host_common_d3cold_possible()
> unconditionally, since it's also how "pme_capable" gets set, but ignore
> its return value when force_d3cold is set and force L2 entry regardless.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++--
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f5a38e6fd8d7..a8a3861c2956 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1224,14 +1224,15 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
>  
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
> -	bool pme_capable = false;
> +	bool d3cold, pme_capable = false;
>  	int ret = 0;
>  	u32 val;
>  
>  	if (!dw_pcie_link_up(pci))
>  		goto stop_link;
>  
> -	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
> +	d3cold = pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable);
> +	if (!d3cold && !pci->pp.force_d3cold)

I asked for a parameter in dw_pcie_suspend_noirq().

- Mani

-- 
மணிவண்ணன் சதாசிவம்
