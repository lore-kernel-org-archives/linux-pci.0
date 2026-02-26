Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC60F15746E;
	Thu, 26 Feb 2026 00:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064751; cv=none; b=Uv9rVFBOS9uOPGltc7Vj7v4enja7L3/GC5hNgu+zOaPY6fM+/fGxgQTSxWusxHnTmg1B4Ps/9yal10ztxfzXb5+X3Su3ZKbuSSnqSqyCIiGvJF0q+SBia8ztj29cKPeDb+Komuht/Iec16jIHTF08bYaXsT2CaxhaDGetRtX6GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064751; c=relaxed/simple;
	bh=SZbKF5LZ0Uxj5izv92WB0gGvM+uY2clH0am/IhAUQjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OzA1fQ+S2Y9CNgAmgZHgyafl18XzIyaYsWVIn1ilfOJfHI217RkulPWVl0pUWjoe8cjTu2UBpNe6wNJEEDzzmsDORbB2isINGedyUdVV6p0LObio6kzF7B9ggDMu4mZZYvmDqBWn/orXXwuT7jTn+boBSM0HLoWQrsmDdSuPeks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuuEX/5n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuuEX/5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBE6C116D0;
	Thu, 26 Feb 2026 00:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772064751;
	bh=SZbKF5LZ0Uxj5izv92WB0gGvM+uY2clH0am/IhAUQjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZuuEX/5nsJRDb87pDiZEk+Bl3zs3sV/IR76IFAEn7XYMguL5oGLr+UfGes1arGTU7
	 t6K7+sBZ0czvpFNzo1h1PmQhwy7pvORAUIDEXQLNttrkDqD5m/Qicy+6nC07hIh6sX
	 rnqNoqhsfNXnw5nTFujE9MZmd7G/xlOh3Ux3VS6z5tVMyIu8s50vo6Wpjv/0t2Gw9z
	 HBktI78WwKedIPUYnxIcY0SLoegCaNzR8hHaf0C+mIrYp5hfHDIvTaCxrew30qJESd
	 lnEpMgGatd4Vb8IdtzfevmFR+B0fb7msOenSntmwCR6D3wRtaUIhAGTrm3thMULkuB
	 qRJ28/tNJp9Uw==
Date: Wed, 25 Feb 2026 18:12:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Geraldo Nascimento <geraldogabriel@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] PCI: rockchip-host: comment danger of 5.0 GT/s
 speed
Message-ID: <20260226001229.GA3794668@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8db835ffe384db63ee598a203751b298ad1cc267.1772057799.git.geraldogabriel@gmail.com>

On Wed, Feb 25, 2026 at 07:27:44PM -0300, Geraldo Nascimento wrote:
> According to Rockchip sources, there is grave danger in enabling 5.0
> GT/s speed for this core. Add a comment documenting this risk of
> "catastrophic failure" and discouraging end-users from forcing
> higher speed.

A comment in the code might be useful but doesn't discourage end
users.

> Link: https://lore.kernel.org/all/ffd05070-9879-4468-94e3-b88968b4c21b@rock-chips.com/
> Cc: stable@vger.kernel.org
> Reported-by: Dragan Simic <dsimic@manjaro.org>
> Reported-by: Shawn Lin <shawn.lin@rock-chips.com>
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip-host.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index ee1822ca01db..4faf3e29b7d5 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -332,6 +332,10 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
>  		/*
>  		 * Enable retrain for gen2. This should be configured only after
>  		 * gen1 finished.
> +		 *
> +		 * Dangerous and may lead to "catastrophic failure", with data loss
> +		 * or worse!
> +		 *

Wrap comment to fit in 80 columns like the rest of the file.

Remove spurious blank line at end.

This should probably be squashed with the first patch; I don't see the
benefit of having them separate.

Why don't we just remove this whole "link_gen == 2" block?  If we
don't want to use it, there's no point in keeping the code.

>  		 */
>  		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
>  		status &= ~PCI_EXP_LNKCTL2_TLS;
> -- 
> 2.52.0
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
