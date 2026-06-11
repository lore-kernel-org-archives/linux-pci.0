Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D4D377EBA;
	Thu, 11 Jun 2026 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166527; cv=none; b=YgWCGTEI/C3Y9op0w6+pX9V+xPKprund5HNEDDYyyy1TEXnLo6kPgqxiXvdfa5UP8jeNYTycgDBtjdL1jd0sOlJrdM2YbeYQ+KQq13HtMYug18kBps2xTIirvVqddXDuXZDFAGlVa+mV+k2+t5rEbkUmx91C/th+zlGemIEWdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166527; c=relaxed/simple;
	bh=yJ+2Fb5Y3WUBwkJzBeUs5i5EGIeX+wRWckwiMgI9y/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egZbKIRgEg+6NsDb0hNwyrtEPFQw9oNhAxP6lWUWJYwJcLHztIkHtVhtKYuPE9V1kQgESR1URE/Fc91x5dYVkrgGl2flMwybcyVPRUsqkZfi9RpDX2fYXJCI587Wr/5eGjlvmh6VM5RmzKBW89yq6aVZDnLLPJvBi398OT/YNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APdw0CEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APdw0CEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190C01F00893;
	Thu, 11 Jun 2026 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781166526;
	bh=mIItnzeRNiCGiAYpvLIcP7qPLzcBA8tl5IY3rl/XUYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=APdw0CExym2Okn3/vvV8GOrsZ6TB/tJLjk/5HF640ogXmtlxxgRUTzUGM03Maeu/2
	 YF+U8YQWKmqVuI9ShLXz7YXg3sP3/NWEyDNgArco9r2K6AzcUnoQo7l/mfSykCMosH
	 8N1I8/HwVvVAmmKjyQKAIifqir5/JQP3eU2JIX4g85utftKPZ3OExdZNkF9qidLMQQ
	 rs1B4y1wQDD7U0x+zSWJ6bqcVoPiisYAYhrZOiPO1CvSmjIBQF0zGw3Fgoce0bKhCg
	 MDQFPDeSTp+6C8hzZ9gkUBLfONEvy1MO8mymt8SJkrDsYS2oUwhc9X6u6g9Jqxrvoj
	 Xj1KqBUxn04bw==
Date: Thu, 11 Jun 2026 10:28:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: PCI: qcom,pcie-ipq9574: Document the
 ipq5210 pcie controller
Message-ID: <20260611-swinging-hyena-of-order-fbe932@quoll>
References: <20260610-ipq9650_pcie_binding-v2-0-69e27a1fbf1c@oss.qualcomm.com>
 <20260610-ipq9650_pcie_binding-v2-2-69e27a1fbf1c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610-ipq9650_pcie_binding-v2-2-69e27a1fbf1c@oss.qualcomm.com>

On Wed, Jun 10, 2026 at 04:30:54PM +0530, Kathiravan Thirumoorthy wrote:
> From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> 
> Document the ipq5210 PCIe controller using ipq9574 as fallback compatible.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

