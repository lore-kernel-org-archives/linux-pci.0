Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04247F2DD;
	Thu, 24 Sep 2026 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790256160; cv=none; b=FliT0FjoSwwXJ4WWwhOxYdBd2p6O06LoqGaUxULy9a9HD8iR6YiIFcNqDKjQsD8LvGbChyvOh6pbiiI/HC9quwmafuyoLnbtG/CyWrXPpWFeOXtcKFfwTQpLr+sqbeGoX6g8AH2VWdjr/cu72P9CdvFj2YBHJ2qZ8P22U4QYND4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790256160; c=relaxed/simple;
	bh=7LSJuHWbf7zWMenXZbU2vMC6u93w8r3XTA4dO7mr7+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cy7JnDuPf2pEhtTxTztnpecMI2WKduYLCs0JiWzgRl5OdXRHrPrugl2lJthwGZliUMeq1bhJ2SMRrttyccSIrbZ4yvmYQg+PWP/5LsCqY6yYXMKO4mlnq8SVFAYA0i/KR6DLNnrpgUXR8Fm4SXhtDdcc/EVYYbQUTIt0N1ev8js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDnHmgUm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDnHmgUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CF41F00893;
	Thu, 24 Sep 2026 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790256149;
	bh=u1v1eJ1dTnpQo/8U1PoAH4WTm7EYUCskGS2V3g6xaF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FDnHmgUmffigrIAX0NkzkOQjU6RD4poOU2tsQl9zry0+fc4+h+Ul/WmyS4ocuCMuh
	 HYrZmcnzTDDWyu77b4TFUqib5cDSOuarF+gECTDZnUSgQVciUNumTtDkcqTrHDZOC7
	 mTqWNBEUvIqR17EBmBrpBuasK/vJIbEu+BN9e46EDwePFAl0O1mt2tIjniafYqu3m/
	 3ULeisknIZ8G7TFOdOOaIU4nTPAERNOniUdzAVluDn+9ub5Xyk1dIbT9lFE/vvlEXW
	 t5FbVgsh8ncQLIqRv38DIrxtz+olOmqZ2UA8g5H4SGtlciXUlGqNv7tX+xnywOtJaJ
	 IMlMIK0tr6shg==
Date: Thu, 24 Sep 2026 15:22:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, shengchao.guo@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: phy: qcom: add Nord QMP PCIe PHY
 binding
Message-ID: <20260924-lumpy-robust-fulmar-1bfbe0@quoll>
References: <20260921-nord-v4-0-ed05c6e09240@oss.qualcomm.com>
 <20260921-nord-v4-1-ed05c6e09240@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260921-nord-v4-1-ed05c6e09240@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 11:07:09AM +0530, Krishna Chaitanya Chundru wrote:
> +
> +  vdda-pll-d-supply: true
> +
> +  qcom,link-mode:
> +    description:
> +      Reference to the TCSR syscon register containing the PCIe link mode
> +      selected by firmware. The property consists of the TCSR syscon
> +      phandle followed by the offset of the TCSR_PCIE_LINK_CONFIG_MODE
> +      register.
> +      The register value selects one of these topologies.
> +        0 (QMP_PCIE_NORD_MODE_X16)         =E2=80=94 all ports combined =
as one x16 PHY
> +        1 (QMP_PCIE_NORD_MODE_X8_X8)       =E2=80=94 port A as x8 and po=
rts B+C+D as x8
> +        2 (QMP_PCIE_NORD_MODE_X8_X4_X4)    =E2=80=94 port A as x8, port =
B as x4, and ports C+D as x4
> +        3 (QMP_PCIE_NORD_MODE_X8_X4_X2_X2) =E2=80=94 port A as x8, port =
B as x4, and ports C and D as x2

Same question as last time. phy-cells tells which mode you are here.
This is duplicating it and the register value CANNOT choose the
topology. If it does, then phy-cells should be 0 as topology is defined
by hardware already, no?

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: Phandle of the TCSR syscon
> +          - description: Offset of TCSR_PCIE_LINK_CONFIG_MODE register

Best regards,
Krzysztof

