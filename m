Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F4747FB0E;
	Wed, 14 Oct 2026 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792006617; cv=none; b=BJdW+NW2P6AaL9p1mOwLlKyfnK6NUZA+eDroXmXk6FcZJ8AZkWKTKcrlCJ6tU0Uzt+UHokqLI4I4s8XsnXypB4muPI+rBoWbGFSd0xrn2APer8SGWXG6h19mu3Ii2rCHe0t9SpWfSMo+cSTWeUddSV/VnX7YLR63K85uCqBHS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792006617; c=relaxed/simple;
	bh=1acUDNEMfrMnTEtQ+y38gOMUhY0Pjk+FMS3fFJIeuSM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XShLX4PhnNRy1aEXdP6sJQ3vN6YreFTjXRZPzK3PGyPEm9AOQXghCxMn2tWUWSY+u2JikRhtRqlXcM5GUzMkwN2//jYACckQigEP9uz0NZnYyiNjAHbtpaJz20zRjRgDkXTDlM0QGwItJGQijshEQEM0Gt5tmgFbv3VvpjIz39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVvcvc7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVvcvc7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975291F000C4;
	Wed, 14 Oct 2026 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792006615;
	bh=Nwo7fummJ1+6uAUT8/LcA06d2mBN1HNQjSCHgbIgjcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DVvcvc7UX80k12qRiHESe3D5qMFFVXrS38E48C9Buz1YyN3x0yyLjfN8PE2O8obfo
	 z1EWyL8sTL4Zx59tmp6xOzDVuU7hCj2hbkXdM89M3tJdnXtlc9u49ZO+Lto+g3BsGu
	 hsyH6xqZqSuHs9uSkr1db02NQdGYUUb5hKuZQNs6e0mShBs1+p9oLvNshC5gBtfnxU
	 5ICHjv7tO8lQQurcDTA1KP612gBPLumtixcyZjH0oDoeejT+40FVxVkP9zTNGRb27e
	 QFXad8keYB8IZ/hC1pkcJr6OqlI6NaCTwLEk0M52Cn+ZuieNdgR4uXGSCl8QqcT2Fo
	 xOB+33S6zENxQ==
Date: Wed, 14 Oct 2026 14:36:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: vjardin@free.fr
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: async probe by default
Message-ID: <20261014193654.GA1656473@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>

On Mon, Sep 28, 2026 at 03:48:09PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> dw_pcie_wait_for_link() polls for up to
>   PCIE_LINK_WAIT_MAX_RETRIES x PCIE_LINK_WAIT_SLEEP_MS (10 x 90 ms)
> per controller.
> 
> The controllers are probed one after the other, so, it leads to slow
> boot time.
> 
> On an LX2160A board with 4 enabled controllers and no link on any
> of them, ls_pcie_driver_init took almost 4s.

"ls_pcie_driver_init" doesn't exist; I suppose this means
dw_pcie_host_init()?

> Probing the 4 in parallel allows to have it down to 1s.
> 
> The controllers are independent, other DWC based drivers are already
> using async probing such as qcom, imx6, s32g, rcar-gen4 or stm32.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 14d6ac4fc53f..7f37a0537159 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -419,6 +419,7 @@ static struct platform_driver ls_pcie_driver = {
>  		.of_match_table = ls_pcie_of_match,
>  		.suppress_bind_attrs = true,
>  		.pm = &ls_pcie_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  module_platform_driver(ls_pcie_driver);
> 
> ---
> base-commit: 94e8d4e94266bb9737a5963810a3f9365cb2f39d
> change-id: 20260928-for-upstream-pci-layerscape-async-probe-084cae5d0907
> 
> Best regards,
> -- 
> Vincent Jardin <vjardin@free.fr>
> 
> 
