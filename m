Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A69257844;
	Thu, 10 Sep 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034598; cv=none; b=GKLF5PkQAT2BGbX8hQXyemEC+/XEYC3k7Uhkd9nWcxpO1W9stH/lTUQrfo+BcOKmg5/uOEWKC5UHK3XDNe8HAtZs4QK1jQk29hpF6DZkUeKa0P/cpG04mL8UKUBiW9FlewoV+0tmADAxTRFvVW5Ir+TB4xuVwHbSNh0N3Dn4MMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034598; c=relaxed/simple;
	bh=8KMsO4FVaq5GWzi5LfRwn8CNrUpkIK9DaTsSz7HwljY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7YuSJ40HWEzYjmB8XXuBJFbSQnjyEHr1zNsWFpSWttPzmKjtqLA+aMLxlIKDKEbsdJYVbm5qwC49Ys40wmrksz5B/buyijRSqhC7AnoIljfjjfykjGEv6iutf4p4jSNqOVircUP5dTCwXk7XngZHAtCDB3sQLwWnYrrxjDzaaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te9y/vpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te9y/vpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A42A1F000FF;
	Thu, 10 Sep 2026 10:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789034596;
	bh=ukewkJzWg3+pptkPINmJqZ5vy6B6QPl0Un6jQ2Exu9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Te9y/vpJuyFO9ZT7+Qf8JijMx8Z0O37WT+grjs6GBWCnI7+bpw7P197jBHIy0vEAy
	 fg7VGC2jEW37Akx9JnJYfCSBLtH3jbzABvBAj1GwYR3iudohUOMi7XOPYAaz86rwV3
	 afz2/1dw8RnO7nItIwC7Re6XOYQUMUfyi/gg5SWHlUvWyZoP5j8rM7wbUjyAx0yB+5
	 PM6iWXXEmSxTpLedhqKVvfHIYj96TEaeSHfwl8rSv5E4E98X2Ity4WKediL+p/2DQc
	 xnYtRZj8ibD02ye93XcNNhONUb6fVwRpR1VCPA7b1poYLS09MqtmtmizWQ6BxDtjZA
	 GmUizaAdygi4Q==
Date: Thu, 10 Sep 2026 12:03:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	shengchao.guo@oss.qualcomm.com
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
Message-ID: <20260910-neat-goat-of-prosperity-eeecaf@quoll>
References: <20260909-nord-v3-0-b0a82721c547@oss.qualcomm.com>
 <20260909-nord-v3-1-b0a82721c547@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260909-nord-v3-1-b0a82721c547@oss.qualcomm.com>

On Wed, Sep 09, 2026 at 05:18:16PM +0530, Krishna Chaitanya Chundru wrote:
> +  vdda-phy-a-supply: true
> +
> +  vdda-phy-b-supply: true
> +
> +  vdda-phy-c-supply: true
> +
> +  vdda-phy-d-supply: true
> +
> +  vdda-pll-a-supply: true
> +
> +  vdda-pll-b-supply: true
> +
> +  vdda-pll-c-supply: true
> +
> +  vdda-pll-d-supply: true
> +
> +  qcom,link-mode:
> +    description: |
> +      Reference to the TCSR syscon and the offset of the
> +      TCSR_PCIE_LINK_CONFIG_MODE register.
> +        0 (QMP_PCIE_NORD_MODE_X16)        =E2=80=94 all ports ganged as =
x16
> +        1 (QMP_PCIE_NORD_MODE_X8_X8)      =E2=80=94 x8 (port A) + x8 (po=
rt B+C+D)
> +        2 (QMP_PCIE_NORD_MODE_X8_X4_X4)   =E2=80=94 x8 (A) + x4 (B) + x4=
 (C+D)
> +        3 (QMP_PCIE_NORD_MODE_X8_X4_X2_X2)=E2=80=94 x8 (A) + x4 (B) + x2=
 (C) + x2 (D)

What does this mean? The phy working mode is defined by phy-cells
argument, so what are these numbers above?

Best regards,
Krzysztof

