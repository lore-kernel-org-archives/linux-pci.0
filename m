Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD529ACC0;
	Mon, 16 Feb 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253906; cv=none; b=Nb4tn27iXdRQrAjdGf2HhHjDzm3KjuOiX4AyjkPPRFNRRBOpTs84YKi5Sr/ELVs4tcEJQaIUd7AZSC9j5jqGFaJPpz1D/ZL/4+SaaDENjhNwXu1aJ7xw0cqKm6tST615D8/XqSQEOXR6WXIhf5a8IVOeOHuVejFzvt6GgckweMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253906; c=relaxed/simple;
	bh=l0PoeuUQ0W4SIOqU8eBxrvIWKq27RR5Mnf17zQxc0gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCJ1TJ+zSG5oClJ8VBkSm7zvuS9UJUhHl5x4xWaJTax1Uol3DvcEtvUFZtLnAnmEdNjrAHMIo3emyC6BsMZi0euZ9stIXaFf30JXG4i9SO27Z7+Bgv8kx4ivHGEXDVTgA7sfuC1B6gY1sW1N+DQHUGmScqFNGP1dARdxSG31R78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uj4l9WHq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj4l9WHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B842DC116C6;
	Mon, 16 Feb 2026 14:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771253906;
	bh=l0PoeuUQ0W4SIOqU8eBxrvIWKq27RR5Mnf17zQxc0gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uj4l9WHqA9kzwS4uQ40NaMiqBr3e3eRpGO1RQ440m4/UCfAcIkqfEhqSnBV1IQ2ll
	 aMme+SXNCIdhZJq1mqEzzlHwlF0Xd7oVjH55nBYCs5GksiHIYw7Fh7Xrt5cBFBYd0O
	 AOoox8p6wWpWDydidgFQuWyewB4u4rZhr+Rgqi6Yk9XAygDrCd+dMbhE9cEmSqlqI0
	 aPQv0EXFxC3VBPCITcU8W5QGtUKXXZBVPZVm5UAtbLza0Bd0Y1VR8eGrZDMTZlcgLL
	 7/uHPivfRJcHhgcoVLcAuq4XQXcvHeh+3fq8EEpO9S8/lW6oq0JwAUjB4p4nJhliGM
	 8PULvHt8Gjp9A==
Date: Mon, 16 Feb 2026 20:28:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Jingoo Han <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/5] PCI: qcom: Keep PERST# GPIO state as-is during probe
Message-ID: <twbujrvphqts75hkwzot4bfgiddw7qkg2foidvfh4in2jluxyo@3m3mfskxu2ym>
References: <20260109-link_retain-v1-0-7e6782230f4b@oss.qualcomm.com>
 <20260109-link_retain-v1-3-7e6782230f4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109-link_retain-v1-3-7e6782230f4b@oss.qualcomm.com>

On Fri, Jan 09, 2026 at 12:51:08PM +0530, Krishna Chaitanya Chundru wrote:
> The PERST# signal is used to reset PCIe devices. Currently, the driver
> requests the GPIO with GPIOD_OUT_HIGH, which forces the line high
> during probe. This can unintentionally assert reset early, breaking
> link retention or causing unexpected device behavior.
> 

There is no way asserting PERST# is going to cause 'unexpected device behavior'.

> Change the request to use GPIOD_ASIS so the driver preserves the
> existing state configured by the bootloader or firmware. This allows
> platforms that manage PERST# externally to maintain proper reset
> sequencing.
> 

You should also mention the fact that the driver asserts PERST# during the start
of qcom_pcie_host_init(). So requesting PERST# with GPIOD_OUT_HIGH is redundant
anyway.

- Mani

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 7b92e7a1c0d9364a9cefe1450818f9cbfc7fd3ac..9342f9c75f1c3017b55614069a7aa821a6fb8da7 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1711,7 +1711,7 @@ static int qcom_pcie_parse_port(struct qcom_pcie *pcie, struct device_node *node
>  	int ret;
>  
>  	reset = devm_fwnode_gpiod_get(dev, of_fwnode_handle(node),
> -				      "reset", GPIOD_OUT_HIGH, "PERST#");
> +				      "reset", GPIOD_ASIS, "PERST#");
>  	if (IS_ERR(reset))
>  		return PTR_ERR(reset);
>  
> @@ -1772,7 +1772,7 @@ static int qcom_pcie_parse_legacy_binding(struct qcom_pcie *pcie)
>  	if (IS_ERR(phy))
>  		return PTR_ERR(phy);
>  
> -	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> +	reset = devm_gpiod_get_optional(dev, "perst", GPIOD_ASIS);
>  	if (IS_ERR(reset))
>  		return PTR_ERR(reset);
>  
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
