Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00063E92AF;
	Thu, 19 Mar 2026 16:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936848; cv=none; b=aX62lo8rh4wOOuxLXtd5U+BsoyJ4HMDn8NSdPd7SZ6P4gLm9z1qBvG8TFVzg+yOFoOsh/24k3b3M8oRcdLBmmQ1v+qWEVL63votVi5dYrepZ5ddanmAafPdwcE0qHL7nsLlg0tqDpCItrhdOBCO6/FYJ0FbXVS3RRyJUhQ8+vL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936848; c=relaxed/simple;
	bh=YyGyzHhjiS6Q7JqdSeWBVWSOKYj9sWfvhHK3sunGlFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdOVHe8lJ6h5o77ol/cNchid5vC3gRN2BOZ5TGz1mkdQ0ceP82gUJ3r4hRhaBB3EjAj7GxR/037ifyIzC01TJEQAPXFtKo6U4QlExqkVBggCvkTC6wexwjrQjZ2t2/FmFVBWCuXZHj8daeAeVbQ8xpafMIjCehTzTt+ETaRILW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYAipH4u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYAipH4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A42DC19424;
	Thu, 19 Mar 2026 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773936848;
	bh=YyGyzHhjiS6Q7JqdSeWBVWSOKYj9sWfvhHK3sunGlFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DYAipH4uoIgq0CWL1m4H+gOpzLLaXqv+Rj20kKzzN8lg4JmOyimrjSfBazEhzM4TU
	 t3tIaO19kH8+oqix8V5IoKTVwV6XIlYxbjevLcNPTVNZ8HaEvuxVumNS7cruF3H7DE
	 NyBnWlhAQ2yQR8qm6biB4mH/raZhYmIAZP6CX58HhKMc5ffUUSf+QINRJugE0OYqd2
	 zzV7tvPQW5m2cRdzd00FYwLpL1k/yOOyOtsMk2hhcKkJfMLNtet9Ot1p7cjNOumBgV
	 2mMdm9m3o4EiF78h5QffogbBbojjXJasKbmSxn6QTSeinqgkOjR2HZPh5GmZRcoRNw
	 rxtRYIJWe7FCQ==
Message-ID: <a20bf111-6c5f-4ae2-b8f3-697854626c10@kernel.org>
Date: Thu, 19 Mar 2026 17:14:03 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] PCI: tegra: Add Tegra264 support
To: Thierry Reding <thierry.reding@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Jon Hunter <jonathanh@nvidia.com>, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260319160110.2131954-1-thierry.reding@kernel.org>
 <20260319160110.2131954-5-thierry.reding@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260319160110.2131954-5-thierry.reding@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2026 17:01, Thierry Reding wrote:
>  obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
>  obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
>  obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
> diff --git a/drivers/pci/controller/pcie-tegra264.c b/drivers/pci/controller/pcie-tegra264.c
> new file mode 100644
> index 000000000000..0c8351b88941
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c
> @@ -0,0 +1,506 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// SPDX-FileCopyrightText: Copyright (c) 2022-2025, NVIDIA CORPORATION. All rights reserved.

Don't use that tag, please, but standard Copyright.

> +static int tegra264_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct tegra264_pcie *pcie;
> +	struct resource_entry *bus;
> +	struct resource *res;
> +	int err;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(struct tegra264_pcie));
> +	if (!bridge) {
> +		dev_err(dev, "failed to allocate host bridge\n");
> +		return -ENOMEM;
> +	}
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	platform_set_drvdata(pdev, pcie);
> +	pcie->bridge = bridge;
> +	pcie->dev = dev;
> +
> +	err = pinctrl_pm_select_default_state(dev);
> +	if (err < 0) {
> +		dev_err(dev, "failed to configure sideband pins: %d\n", err);
> +		return err;
> +	}
> +
> +	err = tegra264_pcie_parse_dt(pcie);
> +	if (err < 0)
> +		return dev_err_probe(dev, err, "failed to parse device tree");
> +
> +	pcie->xal = devm_platform_ioremap_resource_byname(pdev, "xal");
> +	if (IS_ERR(pcie->xal)) {
> +		err = PTR_ERR(pcie->xal);
> +		dev_err(dev, "failed to map xal memory: %d\n", err);
> +		return err;

What's with this syntax here? This is just one call return
dev_err_probe. Looks like you are sending us some old code, instead of
use recent drivers starting point.

> +	}
> +
> +	pcie->xtl = devm_platform_ioremap_resource_byname(pdev, "xtl-pri");
> +	if (IS_ERR(pcie->xtl)) {
> +		err = PTR_ERR(pcie->xtl);
> +		dev_err(dev, "failed to map xtl-pri memory: %d\n", err);
> +		return err;
> +	}
Best regards,
Krzysztof
