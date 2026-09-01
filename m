Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74A2E2DD2;
	Tue,  1 Sep 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252139; cv=none; b=gRYnSx/UEdUP1uOdutojZOj4V6Ndg+10HaGOKRV0EVWNw5JPHrNw4XHV/9VX17zestlG7Gw13KfoXMriMtHl9EmhFxD1rLJwVcu0hpSzRszUNJevr79hAL6/R6OtSMsvzKuSDSWZ9aYd3sg34xJ0qZ1ExaVjVD14zOeM0Fr3SdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252139; c=relaxed/simple;
	bh=suI7VOOUJ+S8ZmFBV8++cFxT4yO04pkfs1fAeeNMO1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJe1xrtdJ8ZaHcSZ9nAfRjnLKlfqKO+wJ7hnXcEwpZo2QOcmPl4EjfQDhOLlXVy4scqpl5Oryzt7SzEnM3OZZMJP+16r5iSQx3WfaeVtTxrkbHBkp21B0S8PhMy/bknD5yrzZp04/7huQWCnH19pHhf534nVRz9cS+aCyycj5Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3fC9SEb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3fC9SEb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8B41F000E9;
	Tue,  1 Sep 2026 08:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788252138;
	bh=R7W+a2UbB22q8xIFgqQ71VC8d3erwcb0D9ctEbZEfvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=o3fC9SEb1fgtnpV8N6JwNhkg505uC9y5v+JTfWLjYtch0TFlv/6D1sbp/5jujKDWv
	 b9PerdM0AV9IdN/aX4l+gj7XO8aAi+teDUY3Jk2vw2X3Lh8w/qeOpn5FmXmsYSgali
	 EIHkROwuCmpyrXnrMnOWt3//4U7RgzaHtDj6Q/HxHC8iwTJAlUfCO6qKfYVs5chr/6
	 K/Qe0fkZQq3UfI1iyPar111jKsEh0go7c2COtcIlhFSGF8olqon+Z9EDj1LF19qtlv
	 rXZiQBt8TlQa9drttHDSSaQVLBe1LBFNUJqL/QK1veEPIpdmaqDXt2/nNhgbNiBlII
	 uqkfU41pHlEUw==
Date: Tue, 1 Sep 2026 10:42:14 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: PCI: qcom,shikra-pcie: Document the
 Shikra PCIe Controller
Message-ID: <20260901-silent-pearl-shrew-c63a16@quoll>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-2-406661d75afa@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831-shikra-upstream-v2-2-406661d75afa@oss.qualcomm.com>

On Mon, Aug 31, 2026 at 12:56:02PM +0530, Sushrut Shree Trivedi wrote:
> Add a dedicated schema for the PCIe controller found on the Shikra
> platform.
> 
> Shikra controller supports upto PCIe Gen3 but the PHY is
> only capable of Gen2, hence the max link speed  is limited
> to Gen2 to avoid link-up failures.
> 
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/qcom,shikra-pcie.yaml  | 218 +++++++++++++++++++++
>  1 file changed, 218 insertions(+)
> 

What is the difference in the binding against Eliza? IOW, why does this
need a separate file unlike Eliza?

...

> +            reset-names = "pci";
> +
> +            power-domains = <&gcc GCC_PCIE_GDSC>;
> +
> +            max-link-speed = <2>;
> +
> +            operating-points-v2 = <&pcie_opp_table>;
> +
> +            pcie_opp_table: opp-table {
> +                    compatible = "operating-points-v2";

Are you sure dt-check-style does not complain?

> +
> +                    /* GEN 1 x1 */
> +                    opp-2500000 {
> +                            opp-hz = /bits/ 64 <2500000>;
> +                            required-opps = <&rpmpd_opp_low_svs>;
> +                            opp-peak-kBps = <250000 1>;
> +                            opp-level = <1>;
> +                    };
> +

Best regards,
Krzysztof

