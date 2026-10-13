Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F45221F0;
	Tue, 13 Oct 2026 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912578; cv=none; b=GgReAxQUw5hIx+1etuxRNz4fCXH+M35e+I+6EZdlw1b0V5PyqROFSQ2mPfAomdZ5pP+HXGwSOy6u/wMvEeShklLlTtT8oOl0jVhXEkSbF1MZ71Zz2hrgd+Xb0HPUIaon2Ocpv3YARdVaNWdjmVPj/EF5wNrS3G50VZfMISkWJm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912578; c=relaxed/simple;
	bh=gX936auQn/4bFr8iOTHvtW8beKIHFNLtLQiaQL514Ag=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UJmdIQI6yP+cXLxtXrBk4yWEa3UJh58cp9VOtBGzceyLMWHPlWugSg2EiBznNVutoflu6bRL+x1U4VgDNus5eaZo+mu2hg5LZkvkDn65rG/NuGEVJ+gbmR6pFmoZWohekstCyLcbWNAG0uOPKN1pT4K5QeCVcjajLPTmUXuFhAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WijAxQMl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WijAxQMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBC81F000FF;
	Tue, 13 Oct 2026 17:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912577;
	bh=P8VEovx8JONIwJgHiq9qjYKdW2rGuYmIo2hI8vH7e/Q=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=WijAxQMlggVG2Nt+6tHnQK2j2LdbSFh+sb5Ffqf3oG5ynJ3NRMwJNOEP/JRzlc21n
	 6GhyB62CxLBzrRZH9QlSc+cniYNn1FihFt3ZHKcHAAOkxyeUGlUYvRFXhIKldm4t53
	 Zh/iyczWTUSXiiFIrVF9cFepA4I3WFsxEVi7OOGo6C+l0pWJRBO+n+8AMFajqjgNXC
	 ThCt0wvkd6jWY/V1+FhEKO68ZEQY5azCxdIC3Ukao5HzUQMyByu2ujp3vqh4jrd3vs
	 NXU/GqULDJXpoO2lwsIkppGVph1v1kle4kwaSDoeeUQTBIElzyr3etumR+ZPUwtR90
	 dtorQJcqXmoIg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6 02/10] PCI: dw-rockchip: Restore vpcie3v3 regulator
 handle
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Alexey Charkov <alchark@flipper.net>, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com
In-Reply-To: <20260908-rockchip-pcie-system-suspend-v6-2-fbabcca9921b@collabora.com>
References: <20260908-rockchip-pcie-system-suspend-v6-0-fbabcca9921b@collabora.com>
 <20260908-rockchip-pcie-system-suspend-v6-2-fbabcca9921b@collabora.com>
Date: Tue, 13 Oct 2026 22:59:20 +0530
Message-Id: <179191256030.12828.12537293247860204675.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2211; i=mani@kernel.org;
 h=from:subject:message-id; bh=gX936auQn/4bFr8iOTHvtW8beKIHFNLtLQiaQL514Ag=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqzmpz29diTcasNkOcChxQ3Mpfp/32IhiCxbGwk
 xiwMs1fjOmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas5qcwAKCRBVnxHm/pHO
 9fE9B/90x7NRyqLgmO824AjUzkKW3dwQHQH4pLj5pehJeGcYhuJxrur8hVe2zGul+gCczmJsm2n
 eQCsgt01NtV5jymJPvG7PfP7okwHyJ/A8pIHm8xJZ8MMCtk7cAm5L+a5e+qTGqub3Mgjk2i/epF
 orzjNaI/z/tcyWgcEkZyZh6NN85XC8NidZYKfjOgzrYdrFIrvDTNwuCIUJ2dlkyi79fGaJkMBGf
 IfKlqOYpEEx8bcGAPqnOha6/nXtOPbA/oe+RX06k8aQCpkHheb3huKQsiHyTYVZ6cffXYOb5JyG
 1NTbSg/ZZL9LTESgD6AWPZ5bEKnp/DjEjskbqVRc3lZb5kWA
X-Developer-Key: i=mani@kernel.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-08 16:51 +0200, Sebastian Reichel wrote:
> This reverts commit c930b10f17c0 ("PCI: dw-rockchip: Simplify regulator
> setup with devm_regulator_get_enable_optional()"), which nicely cleaned
> up the code.
> 
> The vpcie3v3 regulator handle is needed to disable the regulator during
> system suspend (to be added in its own patch).
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index dc85564e5001..f67ad3c31c35 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -112,6 +112,7 @@ struct rockchip_pcie {
>  	unsigned int clk_cnt;
>  	struct reset_control *rst;
>  	struct gpio_desc *rst_gpio;
> +	struct regulator *vpcie3v3;
>  	struct irq_domain *irq_domain;
>  	const struct rockchip_pcie_of_data *data;
>  	bool supports_clkreq;
> @@ -844,15 +845,22 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	/* DON'T MOVE ME: must be enable before PHY init */
> -	ret = devm_regulator_get_enable_optional(dev, "vpcie3v3");
> -	if (ret < 0 && ret != -ENODEV)
> -		return dev_err_probe(dev, ret,
> -				     "failed to enable vpcie3v3 regulator\n");
> +	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +	if (IS_ERR(rockchip->vpcie3v3)) {
> +		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
> +					"failed to get vpcie3v3 regulator\n");
> +		rockchip->vpcie3v3 = NULL;
> +	} else {
> +		ret = regulator_enable(rockchip->vpcie3v3);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable vpcie3v3 regulator\n");
> +	}
>  
>  	ret = rockchip_pcie_phy_init(rockchip);
>  	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "failed to initialize the phy\n");
> +		goto disable_regulator;

Not a deal breaker, but keeping dev_err_probe() here wouldn't hurt.

- Mani

