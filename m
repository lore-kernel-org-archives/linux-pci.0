Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4150333ADBE;
	Thu, 22 Jan 2026 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072872; cv=none; b=XRjYmFzjEtBYXysx1nucEYhCepYdqETa5Aj73/NQc+lDWLKAOzJi5OtVWI8zcv4DO8fvmdR8q/bKv4DkAZJHN5nItk6FDUJUXO0uqJn7ER+ofewiKrQEylZjuEqO4LQ5F78jea+ElVgJy77fgG9Zw8M6+RD3FA9uLgWkpjpatjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072872; c=relaxed/simple;
	bh=AgonMyAfa9uiPAYfh9C/Bgq2TL9WZTm/OGzex9FWfw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHYfevWIb7PLsIrGal6ewtFLqn4kmWRmVZHLRnioccnqLYZMb4PcFP9Y0+pl041Dlpwov9PthaE0X1l5OFMNFoJQVQCPOWEsCBr/CqbqBC2070pnvl5dcLOxhNEv2h/eEIpDj8YzODLLTej5h0XmJ04wQV8Y2cM2b8Vx4EVNJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgCpabng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgCpabng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850BEC116C6;
	Thu, 22 Jan 2026 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769072871;
	bh=AgonMyAfa9uiPAYfh9C/Bgq2TL9WZTm/OGzex9FWfw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgCpabng6JJHn8xRpFIZe3jTHR9hU+5UBwyWFBOynni6OUUO5/1LoqwoNeWABlfHH
	 gFmvsu+Ub6HroBHFQTsKy+WnxPMz/gQd32yzv35wwosxYpo/r5KPPNHf3S8poDZQ1t
	 HISyuOKpUtPye2gQr26v0sinjWCgnIQYxi5rUZ8wg/pqcqs5ipg8mXkbJumpMhnWR7
	 EXBy2GsYM/M4JjzUfFP3ECw10Z7D8Bfohlp4OSOeSOPVyRSQRir/Lo2mT1CUbha70Z
	 A3+ca+pqctDTrEzrRZ1OKIfJYqzm2ukB26n/6MxUMKSJjmcRWe9D5UpYHAncWnxW3r
	 TwSzrWaOtE4jA==
Date: Thu, 22 Jan 2026 10:07:37 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
	heiko@sntech.de, srikanth.thokala@intel.com,
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org,
	rongqianfeng@vivo.com, 18255117159@163.com,
	shawn.lin@rock-chips.com, nicolas.frattaroli@collabora.com,
	linux.amoon@gmail.com, vidyas@nvidia.com, Frank.Li@nxp.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 5/5] Documentation: PCI: endpoint: Clarify
 pci_epc_set_bar() usage
Message-ID: <aXHo2YDMkMnFb2LI@ryzen>
References: <20260122084909.2390865-1-den@valinux.co.jp>
 <20260122084909.2390865-6-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122084909.2390865-6-den@valinux.co.jp>

On Thu, Jan 22, 2026 at 05:49:09PM +0900, Koichiro Den wrote:
> The current documentation implies that pci_epc_set_bar() is only used
> before the host enumerates the endpoint.
> 
> In practice, some Endpoint Controllers support calling pci_epc_set_bar()
> multiple times for the same BAR (without clearing it) in order to update
> inbound address translations after the host has programmed the BAR base
> address, which some Endpoint Functions such as vNTB already rely on.
> Add document text for that.
> 
> Also document the expected call flow for BAR subrange mapping
> (pci_epf_bar.num_submap / pci_epf_bar.submap), which may require a
> second pci_epc_set_bar() call after the host has programmed the BAR base
> address.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
