Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B393EC2EA;
	Wed,  8 Jul 2026 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493845; cv=none; b=nRSEWbMI8cyqhYK8N907w1FzEcbRW5BbayLL2gnJInP/5zWjn5X38T5Eitev4jHJir6udM5mmb1EkXUBc39edVTamA1R+Olb1SPVg3ib8DAtQ2EuWY6KmXOTachrKZuiZqZUxHsoogRdHLpqTADvNweRB+B50ScTjkE3ke+a3kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493845; c=relaxed/simple;
	bh=jJ4T48rcmC+OU/PHmOEe9vX/9z2ICtuW0y9WD7i/Uhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoxUPle4/R+M8DAHjSNIqEIgf5++VvXrGBmOYhD6rnxufqwJ2PRoig2nYjh+aHQxPO55pF1C3Y7jovdGJKyPOgNpiJmqq00lpfflIN0ifUsu3dxgQX7SxZ8ZKw4yL0t0QHsSKVpkAvX1jyp7OBReJTMk9QETv86Q7vVK1i/FKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlJJmE5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlJJmE5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2350D1F000E9;
	Wed,  8 Jul 2026 06:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783493837;
	bh=5kjvYq+hPIOZf2fI3IboUq8Nx67NFkcfG/9dSAjNlQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AlJJmE5MBOV3RxR+gOmUca79Mna2NqNYuOr81Xd5eUb6dWVFBfwyBwqITIEihmGmk
	 dfg1POW7oyPl8gO0PIqAJ45o4eBU9TOYwRGL4V1AQFcHju2t0xTHiTZc842+0tFlny
	 AjMUivg1slFZxrBmeXrxRLpljKSozv8PSbgfgY+Bt1IDyY1kqMSvIxvnEjwRPNYKOo
	 WDfeapElhZ2HIYhticksRiFLr6L3eade7JEnJ7ayJO2HZ+p9QVAki/pZ9oUxlEH8A6
	 ihPmEb/cB4YilPJkkf4RNdrdk9dofna28fvzdnaCc8oeaDUv8jXVtM+3DzolS8xpsj
	 vuuxgf1tt5h6A==
Date: Wed, 8 Jul 2026 08:57:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Message-ID: <20260708-optimal-wrasse-from-betelgeuse-efe1c0@quoll>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com>

On Thu, Jul 02, 2026 at 12:46:13PM +0200, Loic Poulain wrote:
> Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> Key E interface signals but are physically soldered as an LGA package
> rather than plugged into a real M.2 Key E connector socket. Such designs
> are not actual M.2 Key E connectors, so describe them with a dedicated
> vendor-specific compatible while keeping "pcie-m2-e-connector" as a
> fallback for the shared signal semantics.
> 
> Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 module.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/connector/pcie-m2-e-connector.yaml         | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

