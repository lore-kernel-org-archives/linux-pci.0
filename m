Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245611;
	b=KBPc2x3HHeRhoO+H61ir95IGo/OEy5/nNmrmtZwo22OrWMkXuJg5qyy+DGX1lw2F3TLs
	 NVuCDerZwnhng7k1lUzGGTEx086VqWFY9toHsg38RSO7dCfg6xhgPOndA+gMlAY3oBQpd
	 1ZBrXRd4uWCTj5dLB8M5BA1rTIkIPCDlSMonQ0J+AjPVBKAmlKkqbqwqNwln5HyN53VyD
	 X/UPBoq7tAxgSRlID55CQW8MsZq6c6729dsCnvl+2Po11DxMdRMRkVPLC3S0R2HDlZPu3
	 WOEo7Ysnr4/XpFOSwwwBpzu1ZJC7k7V1JkTaBJ2SmyYZXLHXFOMpLp1bkTVzq21T0sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245611;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Inir2BaRnVMDhUyUoteKvoszf0OxlCPGv6CRErVG1DA=;
	b=PvDvYf8TZwCJZopJDe6z0H0pBSnSvamNDbNEeQDc30JZVAehXD5P8D91DiXrRAAHaqZ0
	 GQ6ER8Qn8ggx9UgwCWDWNBM8S/ZY7/CFlk0MZswOW1TNvnEBpnNbHuhsa42qY2PbySFsH
	 JuQ/PcbfXZkNjAxft2yuNU+VLl4neIH48nhbsjGobMOVzZBkttsGBzvJ+aTW6A6Hn5XDU
	 FIIGjqUTLg9k305Jep8WgpPfEEk+fZR7N2x52UZBP1LCJ79qVW7n+YXjgcOPzzoG8xwaY
	 UArCjhrVRMo44mUujKEKVcydjoXlQKnkTbHa3WnRnWZ/+miaGjCov36RF/0QGiJJ/iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djPySGxs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F7C606A332;
	Mon,  9 Nov 2026 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djPySGxs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974581F0089F;
	Mon,  9 Nov 2026 17:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794245610;
	bh=Inir2BaRnVMDhUyUoteKvoszf0OxlCPGv6CRErVG1DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=djPySGxsZ6iEOQmv7jIjsonj7PjIFm4ls4iJ6JGTnv7gdAXiBEifz5ckdtKAk/DVC
	 KlhALj0Ws8vGo8pJSMxiay/BLWFRS8fkhDwvwfhSsEMH14sCyvtgOQBXqnO1CrxoYq
	 yrd2mNGvpHZZ2iklTgiBwq6WI/UxPeNteunEDnLMaP/nwIwg183acu1TsA3wg7GTrP
	 5k4zBmog6niDLxHxVaRTT8nnQ3JbfyTJSamxZklnW5u7LeWf54WWioccQVqn+4U4RF
	 varZMkequd4efC7MkflJx2hn0+nZaKADE9BNtQr/cyuJG+EuZhsoDRSf7XzulbiH0i
	 xAEb5sMVY4LCA==
Date: Mon, 9 Nov 2026 11:33:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jingoo Han <jingoohan1@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v9 1/9] PCI: dw-rockchip: Fix LTSSM set functions
Message-ID: <20261109173329.GA252206@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v9-1-a2e55846649e@collabora.com>

On Thu, Nov 05, 2026 at 02:33:09PM +0100, Sebastian Reichel wrote:
> Before the Rockchip PCIe driver has been switched over to the
> FIELD_PREP_WM16 macro, PCIE_CLIENT_ENABLE_LTSSM and
> PCIE_CLIENT_DISABLE_LTSSM were setting bits with a mask of 0xc = 0b1100,
> which means BIT 2 and BIT 3. After the conversion it only sets bit 2,
> with bit 3 being handled by a separate define named
> PCIE_CLIENT_LD_RQ_RST_GRT. Apparently the conversion missed to make use
> of this new macros resulting in the third bit not being set.
> 
> Fixes: 30e919570581 ("PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro")

This commit appeared in v6.18, so this looks like it might be a
candidate for a stable tag?

> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index bd86e32cc2b1..c35c5583c797 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -322,14 +322,16 @@ static void rockchip_pcie_ltssm_trace(struct rockchip_pcie *rockchip,
>  
>  static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
>  {
> -	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
> -				 PCIE_CLIENT_GENERAL_CON);
> +	u32 val = PCIE_CLIENT_ENABLE_LTSSM | PCIE_CLIENT_LD_RQ_RST_GRT;
> +
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_GENERAL_CON);
>  }
>  
>  static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
>  {
> -	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DISABLE_LTSSM,
> -				 PCIE_CLIENT_GENERAL_CON);
> +	u32 val = PCIE_CLIENT_DISABLE_LTSSM | PCIE_CLIENT_LD_RQ_RST_GRT;
> +
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_GENERAL_CON);
>  }
>  
>  static bool rockchip_pcie_link_up(struct dw_pcie *pci)
> 
> -- 
> 2.53.0
> 
