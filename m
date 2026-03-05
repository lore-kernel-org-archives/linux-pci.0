Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB230B53A;
	Thu,  5 Mar 2026 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696049; cv=none; b=CI+aEfK2wn97gB/mBpOTm8oh2IaYKKA8nz0t0GXa/F7FaJoexvJm85AakoBt9DPoh8TbhwgM9YFJI6vW/OtjUJCQE/fi/NMNsVrT//X9Vv7TT7J/BH+03A/rbKc3S1Ah+t9wk+sIpJiciKt7NQ6Rh+RyfE3a4NKAQWavR9OyjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696049; c=relaxed/simple;
	bh=wWFqo5nwh874o4c6BqL2MJLfKZGw+dGSVb34n7B7llM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WapZFNS2TCohMKb7gMpJV0LTqvA65Q9viEp+lwS9n7+ocuqXVZsgc187VSfpP7zdIWasu/WpRQ9/QQeUyQSwSobet+OqY6TydJwaj90wZsfRIIc/tPzLPI9LbXsNFbpiUc5Gg8bndxRW47ZjKot/ekG8hDGkbBBrKuJo40kgV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KboFec8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KboFec8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CA4C19425;
	Thu,  5 Mar 2026 07:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772696049;
	bh=wWFqo5nwh874o4c6BqL2MJLfKZGw+dGSVb34n7B7llM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KboFec8TUIZ5Jy1W4wNYuTsQQTfoLaBsILtowDkXRzPI/6kMtHmfWElNV/V6lmOIe
	 /UatEFysQcbacES7wTpokbIU5+O2r6cfYAPndaY5tAus+5KeWpDfPvnsQK9zUcN3NO
	 q/TU1NfGX2xjmWC94/xTB9YYxFy+y/FWKDUxbDGLM0rX5DrfisQzKFPCWp/D1ortaQ
	 hu3wYXE3Rvk0owSkm2Q57h4Yko1yqBbD1uf96SO4G9weFvUfEWT05PpJPVix6ffgS8
	 Dr6xhHsW/6yvU837b44I3gcq+Er31QAL3xK8uCLIy/h9r5N4ktcx6Svn9fGGX0YYmH
	 GbKQKF9lPjOrw==
Date: Thu, 5 Mar 2026 08:34:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: rcar-gen4: Use 4K EPC BAR alignment
Message-ID: <aakx63RZ-4ayvRAX@ryzen>
References: <20260305015439.1529006-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305015439.1529006-1-den@valinux.co.jp>

On Thu, Mar 05, 2026 at 10:54:39AM +0900, Koichiro Den wrote:
> R-Car S4 Series (R8A779F[4-7]*) uses a 4K minimum iATU region size
> (CX_ATU_MIN_REGION_SIZE = 4K) as per R19UH0161EJ0130 Rev.1.30.
> 
> Update the advertised alignment to 4K, as described in
> commit 2a9a801620ef ("PCI: endpoint: Add support to specify alignment
> for buffers allocated to BARs").
> 
> With the previous 1MB alignment requirement, iATU programming for BAR4
> on this platform often cannot be performed, since a 1MB-aligned target
> address may fall outside the tiny 256B BAR4 window.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 3d4a889e38cc..396ef9432299 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -428,7 +428,7 @@ static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
>  	.bar[BAR_3] = { .type = BAR_RESERVED, },
>  	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256 },
>  	.bar[BAR_5] = { .type = BAR_RESERVED, },
> -	.align = SZ_1M,
> +	.align = SZ_4K,
>  };
>  
>  static const struct pci_epc_features*
> -- 
> 2.51.0
> 

CX_ATU_MIN_REGION_SIZE has
Label: Minimum Size of Translation Region
Value Range: 4, 8, 16, 32, 64 kB
Default: 64 kB

1 MB is larger than 64 kB, so it is clearly wrong.


Kind regards,
Niklas
