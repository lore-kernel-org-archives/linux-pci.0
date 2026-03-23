Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB1A3164DF;
	Mon, 23 Mar 2026 20:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299435; cv=none; b=U+AOOVEOPArqQ06ZxPa3Cj+srnXp/pnvNIfPvmGDN5WRZ3Jzl+BoWKG3tw8Mhd1VZu8fPSV2QW/8+0ozMtw5JwS8u3SLRfuEBVn2xhBwp4lT3qgssjVzgzZGnPhNegFydrd+l3AzqDrzgt8eXnxNTBHNE4kSOmgzD99IjQm8Ckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299435; c=relaxed/simple;
	bh=eZyDyMqrRYDi005zTzlOiL4Zzl7uahSPcsjGAookGrM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=vBno3rgh2Rajvl1qugBoRiu3EJ+S81hnuBNE55m57lZeHpWYJtZ4hVqpJ89xZDWtjQn/Dfjgbp8NtmmbANEs2XwMYGBIXj1653HIzwtnchbiKEcIqR4aHHzQxFJ+AG9x92u6Jus4j2lLbLSLL+0Z14Ff7H8NIoATnPb2AOJguIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/a09kjr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/a09kjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE6FC2BC87;
	Mon, 23 Mar 2026 20:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774299435;
	bh=eZyDyMqrRYDi005zTzlOiL4Zzl7uahSPcsjGAookGrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=R/a09kjrkciGuLlmtVpoon6XVHd3HmWbbxbp+UT/zhfG2OmxBCk84cCbGHpddRBTL
	 SDI3S5I0DwfCK9PjBY9Bp2HYM1s2N4hs9KGC4OO9kaBvEGURhzOI1BoO1SAa9y7BRF
	 BYrYSCT1pD+a/wvmE0+zqxbwOzH/dsABSS02VXGvaeWX3ZyQdjq2hL269cNtiqsSUz
	 P0qnTKg4oAfBr2zjVvyc1ISVETTtqhoDXclY3jKMGyswDzh5S326ynOXJPyFZI+xMU
	 WW0LlPoxLPFyThvNpkpuPYluYwtFM70LhciTD6+MN+C6VkUSRlGv69Q2iJshox74En
	 MQEVDdW0bIvVQ==
Date: Mon, 23 Mar 2026 15:57:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Fix device node leak in
 pci_pwrctrl_is_required()
Message-ID: <20260323205713.GA998251@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323-pwctrl-v1-1-f5c03a2df7fb@gmail.com>

On Mon, Mar 23, 2026 at 07:05:22PM +0800, Felix Gu wrote:
> The for_each_endpoint_of_node() macro requires calling of_node_put() on
> the endpoint node when breaking out of the loop early.
> 
> Add of_node_put(endpoint) before the early return to properly release
> the reference.
> 
> Fixes: cf3287fb2c1f ("PCI/pwrctrl: Ensure that remote endpoint node parent has supply requirement")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

cf3287fb2c1f appeared in v7.0-rc5, so I put this on pci/for-linus for
v7.0, thanks!

Would you also take a look at pwrseq_pcie_m2_match()?  It can
similarly return early from a for_each_endpoint_of_node() loop, so I'm
concerned it may have a similar issue.

> ---
>  drivers/pci/pwrctrl/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 7754baed67f2..97cff5b8ca88 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -299,8 +299,10 @@ static bool pci_pwrctrl_is_required(struct device_node *np)
>  			struct device_node *remote __free(device_node) =
>  				of_graph_get_remote_port_parent(endpoint);
>  			if (remote) {
> -				if (of_pci_supply_present(remote))
> +				if (of_pci_supply_present(remote)) {
> +					of_node_put(endpoint);
>  					return true;
> +				}
>  			}
>  		}
>  	}
> 
> ---
> base-commit: 785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
> change-id: 20260323-pwctrl-fe840d733443
> 
> Best regards,
> -- 
> Felix Gu <ustc.gu@gmail.com>
> 
