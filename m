Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662622;
	b=XaMPPKRjfoNrwf6CUFqEfmesxPh02kHYW7+jfDqNffSg9TLJSAShySQBZ/MSJPQeQoAG
	 Kb4+VkuA/euLa0x61Hc/TKAi7bDsYX7OtQ0pMu1Lyv0ApV63r+FjQUQnxLXHGBQabtBBW
	 +vhLItRKepPEbFLpAquop3YFTYnm/IBhmnVIw4eugDnAjKt1KkTfJ54X27xgekQr90r+h
	 SDmfuYc5j8rQZQV7s4bigBZSvwAknHd8nyp1z4ston2AkDR6NKqkhmngk9dSvvJNcQ/92
	 g/7K9PjlIEySXEC0782fKk2RMk3nG/vKZH3ZLiW/BTUCKgmpWLZFeL8huiNVcSB/wWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662622;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OmbDwKTPv9Vhyd576I3oDOBuRR1wx1NfzLwaR4N0rck=;
	b=nLQlPf4N4GOK639g0yWmbt8rgEnv2q0z/z3aQK+iX4SCLiFe8W034lkdrIi5NXtTx6cZ
	 hL6CgWKFnvRL8qJl0FfDzc8QqvBMdZ//FENAjf4QGjNafDO1mY5uYSxdua90H/WjQWo/e
	 F5sdbhqC1rpVfpZDbQTmQz1lmib/RxwB9VNnPwVye0Sm5Ts/vp/XBntvtqlqI3c6Brf1n
	 hSw7g56kzYfRPSaxO8SVi6kGGM8vxMPRk95w4gAi8ZzWCkdLQOfNM0i6ISXK89oRJDV41
	 KUPPLrHrNfSxUuyCA2Q2T0tksqnHqW8AWaPDewMxx7IMCFW5E6a14gfXxUHX7vn5Iig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lp5vzeyf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E4606A31D;
	Thu, 22 Oct 2026 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lp5vzeyf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6111F000C6;
	Thu, 22 Oct 2026 09:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792662621;
	bh=OmbDwKTPv9Vhyd576I3oDOBuRR1wx1NfzLwaR4N0rck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lp5vzeyfqd/HJVg2ip47pTpk1/JsZFxXtHNEod6B7ibNUWscdhgRUtDKZ5+3U6NdO
	 HKZjCTy/YMx+qQP17kYafRmHrjBxwKZBxvfiVBgZCF5TpUEAR2Df8sU41VVbl8UNPD
	 KGq7NRXgpKfkpepxoZjH1nLlA6V6McI2i0Qe6ZLYTnxYB5335JLcuxeSRbYMEgtIlc
	 ni44YEd4jxIf1kDl7lbM8r6Lg5gtZAZwHDN4SqKWCoZ47TeoGLDe4P0hXiTZdJgKNn
	 wu3jvnoseHxbPQqxSkxYZTXatWvqqXwA3heKZQZ3EyRUt/QmDkCDGXmxBH+nWZB0zN
	 cZ/2Erloq1Ldw==
Date: Thu, 22 Oct 2026 11:50:18 +0200
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
Subject: Re: [PATCH v2 2/6] dt-bindings: PCI: qcom-ep: Add QCS8300 compatible
Message-ID: <20261022-classic-muscular-quoll-cd3038@quoll>
References: <20261019-monaco_ep-v2-0-852cb9f5d012@oss.qualcomm.com>
 <20261019-monaco_ep-v2-2-852cb9f5d012@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261019-monaco_ep-v2-2-852cb9f5d012@oss.qualcomm.com>

On Mon, Oct 19, 2026 at 02:55:10PM +0530, Krishna Chaitanya Chundru wrote:
> The QCS8300 PCIe Endpoint controller is compatible with the SA8775P
> PCIe Endpoint controller and uses the same programming model. Document
> the QCS8300 compatible string and its fallback to the SA8775P
> compatible.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

