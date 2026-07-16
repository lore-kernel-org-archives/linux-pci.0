Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A22430CE6;
	Thu, 16 Jul 2026 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212202; cv=none; b=Dot8R0LJdqX1boL0kZQwqmveXvVgePZv5NGGECtXCsa4T8H43H2z81UlmghZgts+gJE2U2flRz/0UVhx1n25r5XfjUvbAsWJGBU0tbUv+4L5CYFdBFesaluvFjUwDz2GtOP2jpjlYRyoMOMLKSq61ee7LkQfMlg7AIdixYf5t90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212202; c=relaxed/simple;
	bh=m9HKZHymJrqVArQ0SZzxQXEQYPqYOXi02i6SzPQKYyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBXk946VRUU5c2pe51ZbAN28tqjNbb/oWXCKf8NbtUfSkD0o2ZxDtBeB1kgi4D454VL3WIOb3rL7wFu8ceqHHQSHJhVnOVZ7iAGxmXrgmkKFmJtmwLKbO05Ca5TFIc1Vcg3++rzkdXH4Nwt/8mdwbj70rt5ws1B9Xb9phqSbtWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cqcf7QwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cqcf7QwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C9B1F000E9;
	Thu, 16 Jul 2026 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784212201;
	bh=gyJzjFhg0VkpjwNAQWiEbEueO7hNBshnqS6x7ogCitY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cqcf7QwOadvuVsIshM1nZD9aWba6/HkgVsuPOVaYkoNsEXCgXsPdQDN3zoodCKRW4
	 Bkn3KF478toRyhpf7YHs1qMwVGVziyhhlemsbjBBxZvvr5BL+0LyroyAJYJWLMokIK
	 3AlfIHRr5WBb1e767lHM5NeKOB0RcCZwkxKXE1VrBnEV0cicVt5fZcoyJEUTi+x8Pm
	 R1nw+fTKTtqRG5erNRhsTshBcGSkKZcfE4HkxEYdHiWfJEL7mQRtUX/U/2ZTaby/rt
	 Q8FE9yVm17tCgDBsf8xExHZ3Bt1x0VX0kzmi3/LeM18VYGbRd5x6Q/sk4x3OH41s75
	 5/qKMThYMlQww==
Date: Thu, 16 Jul 2026 16:29:42 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: connector: pcie-m2-e: Add vendor
 LGA connector compatible
Message-ID: <6txwszoqlx5msqhspafk2t66hpdf67tfvc6qejeave3gg4fuby@rosphqguupiz>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-9-46253587af64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710-monza-wireless-v3-9-46253587af64@oss.qualcomm.com>

On Fri, Jul 10, 2026 at 11:57:35AM +0200, Loic Poulain wrote:
> Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> Key E interface signals but are physically soldered as an LGA package
> rather than plugged into a real M.2 Key E connector socket. Such designs
> are not actual M.2 Key E connectors, so describe them with a dedicated
> vendor-specific compatible while keeping "pcie-m2-e-connector" as a
> fallback for the shared signal semantics.
> 
> Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 module.
> 

Could you please also add "qcom,pcie-m2-1620-lga-connector"? It is
functionally compatible with the Key E connector. Otherwise, I have to wait for
this series to get merged and send one more patch to add this compatible :)

- Mani

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/connector/pcie-m2-e-connector.yaml         | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> index f7859aa9b63469cb43919c0b5719c18694c5364d..0282c6ee9272446064a99ec6314a5ceb1721e0c4 100644
> --- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> @@ -17,7 +17,12 @@ description:
>  
>  properties:
>    compatible:
> -    const: pcie-m2-e-connector
> +    oneOf:
> +      - const: pcie-m2-e-connector
> +      - items:
> +          - enum:
> +              - qcom,pcie-m2-1418-lga-connector
> +          - const: pcie-m2-e-connector
>  
>    vpcie3v3-supply:
>      description: A phandle to the regulator for 3.3v supply.
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
