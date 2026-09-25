Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ADF26ED3D;
	Fri, 25 Sep 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342185; cv=none; b=rYxyZDOS6dzHcuUd564DtIonNaxEw/htVjMP8od64LKw6SFICxZeAEkDeOqG79gPthAYBphmjgqyya+XiZJb3Cw3xBx8qDtPGUa0Ic+rK93tiXfZ21RyFuV7iCWkcygqhpCAAB7bCe7fbJk660kQZEytch68BBJnXN7P4HgJsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342185; c=relaxed/simple;
	bh=zAZ88Ys7QZCTvU3GIl4RCyctambXW1BT1UZrIqk5jOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trohEi8RGJfLKVmdPv3K+ldabpT/A/uAxBqiMW1i2D3yCHLBavok3F5Qc7W0koVvJg/hKzozaRzIBvChNeKPrAe5BGFndr21IpuTIvqMB0bDqP9pDhYMYwHn+041DHb3Ctj61E3cegJQJy6kMEc3WxHv7Q+F0RpUiSSbgfh6QSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPo8/T1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPo8/T1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C601F00893;
	Fri, 25 Sep 2026 13:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790342173;
	bh=ZFewOo4+btBAk/SPPiDXihf8TjRThF1b6LAoGvmnSa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bPo8/T1wjVNsUZ7GVFtAQVrq3rFuFCgfmjkdxiFUc4G1hI7azTA0LmEJBQbT8q1/Q
	 Tj77zizFq4+xCAHSvFNelJRlc6ygL7WqH4SYEUNehJWYyUQqLZ1ufT2QLdi87w6XqW
	 ezj2B0aMF+hZRQ1oH6IIk2xMcZwCgooDO5xqRG90EVvi//mfcj8Xv+x5bYbhoWjyvI
	 aAZKo+4ZZSo3qrcq4CJ6/5OhDcOxZz0qjTd2iNMXgs5EVQvXOw/pwIBPhWcA1t0uAL
	 FrekanlSuto0sAAUFl2hGYG1q/+t8NVEK+7eUl8fZxyfMBaAZ+a1Sy7RpxD6JcO7cr
	 AqNLL+G1xyo4w==
Date: Fri, 25 Sep 2026 15:16:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: PCI: qcom-ep: Add QCS8300 compatible
Message-ID: <20260925-lavender-cicada-of-vitality-1784de@quoll>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-2-63c5282fb0db@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-monaco_ep-v1-2-63c5282fb0db@oss.qualcomm.com>

On Mon, Sep 21, 2026 at 04:28:13PM +0530, Krishna Chaitanya Chundru wrote:
> The QCS8300 PCIe Endpoint controller is compatible with the SA8775P
> PCIe Endpoint controller and uses the same programming model. Document
> the QCS8300 compatible string and its fallback to the SA8775P
> compatible.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index bed9a40b186b..7f9a0bc958d1 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -13,10 +13,15 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,qcs8300-pcie-ep

Drop, cannot be both compatible and incompatible.

>            - qcom,sa8775p-pcie-ep
>            - qcom,sar2130p-pcie-ep
>            - qcom,sdx55-pcie-ep
>            - qcom,sm8450-pcie-ep
> +      - items:
> +          - enum:
> +              - qcom,qcs8300-pcie-ep
> +          - const: qcom,sa8775p-pcie-ep

Best regards,
Krzysztof

