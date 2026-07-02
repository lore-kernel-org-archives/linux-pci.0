Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489954A1380;
	Thu,  2 Jul 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998260; cv=none; b=Y3CkArO8jyN6+qMdBgAYzk5Pr6sorfDGKt3BfShKhu5hnH82kDa2tqaBwbSaxfCJgnvdlxWBzZw9/8V5tPvLxmw5nqxzpY/8l1HWGjnVFU4fnp8fQ1l8MZ8e2LSiOEaZ+LkR5haErUfb6OcJJppJRW1G+u008RVznK/aHuhsLxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998260; c=relaxed/simple;
	bh=Zymgnv6zVWO08sjR4mMo+c+FbJu27EsjGNszV8nMdaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VwPlyxFzRvFDRDRGnXJ+ifE4p7lqDuwILXuvhpbHIopNME1F5i5DwCxQGxXUFF+RAxjXO+K8dqvvHLpLScff5MqyxC8Oz5UZ6PihcMBmxtqfu2dGUa7kzBIdgCyFnbcJp0NYkOiSTBZlVQyjCG7fW3OjozBowsA+unpIcSBWEZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DurhYIEc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DurhYIEc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBE21F00A3A;
	Thu,  2 Jul 2026 13:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782998259;
	bh=xFDSizrwfHcYIYvyWrCoWez1eVBBb77mKr1ZSRXLBbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DurhYIEc7EnHoyjUZL0nYRcXQc8xKhCFfnqp/rlRDY2UoB34BMdtGt70fuU7wv7bI
	 gt7gkX/lI3SzctbYYz5JX8OR+q9tYiGmv7/bSJ04O/wTLrLTTDo6nMD4zwljrtBl3i
	 8rtuQv91ymRG1Wv72TmYno/t8vd29hIwwg8FuSXwhY28ZQlqvgNuoZlTbtmAnKOxWA
	 gd5j384wRN6tRftqFX8IudrkJLat+L/7kCCVXypPxur1XMPKSKDHahQpU54VL+z1KK
	 go/IRNN2+LD/NVO1KWq8QEDGsEEdJu6X3B8t5P9+E1uOHAOMm2nZ4I5qWgxJ2eYOQZ
	 CLmUh6zEsmd3Q==
Date: Thu, 2 Jul 2026 15:17:30 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Message-ID: <4m2ad2qfwdwwyv3nhfpq2rzyrzywohip6jz5drv4jferi7rmer@cmxomm7jofgr>
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
Content-Transfer-Encoding: 8bit
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

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

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
