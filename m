Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399F407567;
	Thu, 26 Mar 2026 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541624; cv=none; b=jri1FNspTYkj7SfLhQMYPhxkNRw9t8f/XKolGsa1rg/M13c2Ljt7l77mmQxQqLG5IDBk/dqa2NCP+iFID0qIAMys3OSPumSF8+Bw0mIpxo7Y4eA0gvLRDpzHFfO97RBCWGPyjWZa5x2AjnEwy1BuwQwLFgk56ZAGhrnOOXe5Wow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541624; c=relaxed/simple;
	bh=2FivwWdAEPbyRYFOc3ia6/y4NhlckpliW1NAWvLYC+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1a76oB3J9eJbstjEEFc+SZpdKxdYFVgA/NAQEizJJgvfl0opSVhyjDXWjoKOjq/DL9x302tG6ye9O37cscz0qF1KokGFxLUVpti7zvxU6OXQ33PRCooilVXVRFaj2h9EqK+BgbCykwnfKBKikLXaXp2si2VJ/FT4ggG6km0k3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHSQfnsB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHSQfnsB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E120BC19423;
	Thu, 26 Mar 2026 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774541623;
	bh=2FivwWdAEPbyRYFOc3ia6/y4NhlckpliW1NAWvLYC+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHSQfnsBawnvlESfik6M5ZSnlSFopJTN0QGEomrgTzLoqqaiilEz7Ul9F9cOCBBl4
	 yJNCmGv/FO4+ceppYfeQuDc0g3BYjNN1nHgytpl05Xdm0MyOo2t0H2XC9CHvm2TnbN
	 c9UoG/E3TgHTkQxem0gzbDqXHFMvXcIVEXyiDVeXVllmdEOhjpVbGxTG39Fzk1dzPi
	 PFqIJCC8Y2FHCk3toQDc5kt/8XM3VXbfzQBzeCTLQ4pZfvJkHgd5ZHLEMXKy9gy7Ph
	 pbb5ymtRULswxQ/IGSnogNSmkpgU2xUctc6PEarCQOu/2CZw6GB3djjFpUm2LkcJiS
	 a37lD/qcNEGqA==
Date: Thu, 26 Mar 2026 21:43:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Florian Eckert <fe@dev.tdt.de>
Cc: Chuanhua Lei <lchuanhua@maxlinear.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Johan Hovold <johan+linaro@kernel.org>, Sajid Dalvi <sdalvi@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: intel-gw: Add start_link callback function
Message-ID: <jbjoym5wutdacmfhjstu2ek7k4pqdj4bqii4jszilju5d53z3h@vfdtqihgfaam>
References: <20260317-pcie-intel-gw-v1-0-7fe13726ad4f@dev.tdt.de>
 <20260317-pcie-intel-gw-v1-3-7fe13726ad4f@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260317-pcie-intel-gw-v1-3-7fe13726ad4f@dev.tdt.de>

On Tue, Mar 17, 2026 at 11:12:51AM +0100, Florian Eckert wrote:
> The pcie-intel-gw driver has no start_link callback function. This commit
> adds the missing callback function so that the driver works again and does
> not abort with an error during probing.
> 

So the driver was broken due to the below commits? If so, please share some
failure logs as well.

- Mani

> Fixes: c5097b9869a1 ("Revert "PCI: dwc: Wait for link up only if link is started"")
> Fixes: da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  drivers/pci/controller/dwc/pcie-intel-gw.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 6110a8adb8732dbbd5e9e2db68a0606ccf032ae1..6bd25f8da605032bfdb97596fb3a1f6a03e88bfc 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -285,6 +285,16 @@ static void intel_pcie_turn_off(struct intel_pcie *pcie)
>  	pcie_rc_cfg_wr_mask(pcie, PCI_COMMAND, PCI_COMMAND_MEMORY, 0);
>  }
>  
> +static int intel_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct intel_pcie *pcie = dev_get_drvdata(pci->dev);
> +
> +	intel_pcie_device_rst_deassert(pcie);
> +	intel_pcie_ltssm_enable(pcie);
> +
> +	return 0;
> +}
> +
>  static int intel_pcie_host_setup(struct intel_pcie *pcie)
>  {
>  	int ret;
> @@ -310,20 +320,8 @@ static int intel_pcie_host_setup(struct intel_pcie *pcie)
>  	intel_pcie_ltssm_disable(pcie);
>  	intel_pcie_link_setup(pcie);
>  	intel_pcie_init_n_fts(pci);
> -
> -	ret = dw_pcie_setup_rc(&pci->pp);
> -	if (ret)
> -		goto phy_err;
> -
>  	dw_pcie_upconfig_setup(pci);
>  
> -	intel_pcie_device_rst_deassert(pcie);
> -	intel_pcie_ltssm_enable(pcie);
> -
> -	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		goto phy_err;
> -
>  	intel_pcie_core_irq_enable(pcie);
>  
>  	return 0;
> @@ -386,6 +384,7 @@ static int intel_pcie_rc_init(struct dw_pcie_rp *pp)
>  }
>  
>  static const struct dw_pcie_ops intel_pcie_ops = {
> +	.start_link = intel_pcie_start_link,
>  };
>  
>  static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
> 
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்
