Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD63EA942;
	Wed, 29 Jul 2026 21:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361034; cv=none; b=tl55aDqTP1ldNHfSTH37tWPcjd65wz/iPDW5LI0FMULW1y+PTccuJCziPXWttLkdPmVfAQAl26NpY0TKs4kJ74j+0xCUy078jYjBKf/WP9MIYsd7NwB0Ff8zD+WMT9QWi+6tFROXyZVlLQ8Tkfq6yRwxFnu7m9KRmYBSc3zhD38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361034; c=relaxed/simple;
	bh=sJjz4YwwDxNjU73C/ZQAuiGVUqyvzzN4CpNdNpeJ0n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fNm40RIf2oT78TB+Gzpp22hIyMdYSEsCScotBBzFUe4VKB0OGWTg+dQ6/Z02ZtWhnk2mQNcZGmkwa05rgu8BwabrpGF28s+6vlff4yuApET+tFjPG7loBQ3e/6KadhbNokfLQIpyNi9vnGEyIqXs9T28ZyZTvyzLdeKCAZzo+YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgwTzK6+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgwTzK6+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2AB1F000E9;
	Wed, 29 Jul 2026 21:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785361032;
	bh=xiEf5k85slsAb9+rwzYqikDtr5cWMx7s3bZUKGZdR1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KgwTzK6+vyfGRIUQbwnDl2Ud/w/aRY7zdRioS39jSHpXuG7+KMuSKHUVhTBxyKanO
	 8AB0bOGmmyCAsFVQVsNbvQEsZI9Jd37pAGgYn8/uDIGYfLOZucTWw0Q1PeeTRBrqXh
	 /+nPc2R3XuK7pM8yU+DDNpIZ7kMvircDthIGKesV8L868OEaHdKj/JMmwJyJ/IckUQ
	 2p1X1NU49GbHlBxRHXJM8G4V/6RB6Xd3JsG8hSdYlWDSrtEWtEqH2X7vZyks2a8wBi
	 eO5wnfT+LwWNqJbs1Y+pNnp+edVcdifGPTRFXT6xepeCBO/dteAAHQwnIdMToeQsSv
	 67ukznHJZPLYA==
Date: Wed, 29 Jul 2026 23:37:09 +0200
From: Niklas Cassel <cassel@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
 dw_pcie_ep_cleanup()
Message-ID: <ampyhZmYPQl3U8HT@ryzen>
References: <20260729-pci-port-reset-v9-0-53570b92064d@oss.qualcomm.com>
 <20260729-pci-port-reset-v9-1-53570b92064d@oss.qualcomm.com>
 <20260729051542.DC2741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729051542.DC2741F000E9@smtp.kernel.org>

On Wed, Jul 29, 2026 at 05:15:42AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: High]
> This is a pre-existing issue, but does the persistent MSI iATU mapping
> conflict with dynamic MSI-X iATU mapping?
> 
> Both MSI and MSI-X use the same physical address (ep->msi_mem_phys). If
> dw_pcie_ep_raise_msi_irq() caches the ATU mapping, and then
> dw_pcie_ep_raise_msix_irq() is called, it maps the same address to a new
> window:
> 
> drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_ep_raise_msix_irq() {
>     ...
>     ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>                               map_size);
>     ...
> }
> 
> When dw_pcie_ep_raise_msix_irq() later calls dw_pcie_ep_unmap_addr(), the
> lookup function returns the first matching address:
> 
> drivers/pci/controller/dwc/pcie-designware-ep.c:dw_pcie_find_index() {
>     ...
>     if (ep->outbound_addr[index] != addr)
>         continue;
>     *atu_index = index;
>     return 0;
> }
> 
> Could this unmap the cached MSI window instead of the newly allocated MSI-X
> window, permanently leaking the MSI-X window?

This pre-existing bug sounds a bit nasty.

I sent a proposed fix, please review:
https://lore.kernel.org/linux-pci/20260729213520.1187704-2-cassel@kernel.org/T/#u


Kind regards,
Niklas
