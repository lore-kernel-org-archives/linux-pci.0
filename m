Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F492C11FD;
	Sun, 22 Mar 2026 23:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774221005; cv=none; b=LuD85DJWWjPjkkRcleVF+/7HChJu4ZS90HKt20Xe7tuXeC2nxaQTnmpwFbLjpTuLQyTaJXclojRex0M0Hcil/Xau+4kAaPZqGOHUM9497iyq1WuUtCgwku64AukINShqZncSpHr6DjsDK1bILFGQFhGipB/EAVPjkarKMUSnMKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774221005; c=relaxed/simple;
	bh=uU/gc7NH6waZjUqKluW+RwGApT2GspyV96WOVgY/dUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g26JLFuwLocvXSNoUlCFA/e/UNkFZwn4tL/4+ynziFfxmuZ52J1B4YghS1CI+KlvMMsgsjzhmiyaTFfZBCILElSx25TIY/HbEUptMNxKCIhejRvuRGfJfMAWhT7hD7SFRuH5NnsTPcaDcwv9GMImZqQfun44uIH2gGEwJUZvMJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRITkAg4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRITkAg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6E2C19424;
	Sun, 22 Mar 2026 23:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774221004;
	bh=uU/gc7NH6waZjUqKluW+RwGApT2GspyV96WOVgY/dUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRITkAg4e52ie5vkQ91//aE+MGP8xDDqT77uMOuDKDad3W6DVicVxCKPuz5dBiD43
	 z8LFZdzUNoEU7O5EWCyDBSCmBcEakvs7nz08D0mTb1ohxTR2/qinjmJ9Tn11VzBhtS
	 jvGGeio0HZmZvuAijXR5hSkTINtY6LlFWRsZrhQT1wUcn/XXpoP50UeDXeF0B6ZdQe
	 Azl64EnW6zlF5B0C2fkZVBtsvCbSBhdJbBYgfD6YGCybKIyJLZptLrlbmg7BX/qP3m
	 27u+Uh+6h7HHHYOeZtzALs9tAlnHk+0wUI5EC+gc8iWhF+aYl9P3Z/Ml6ejaUbZ49E
	 KNxP1rt1QA9Fg==
Date: Sun, 22 Mar 2026 18:10:03 -0500
From: Rob Herring <robh@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] dt-bindings: PCI: imx6q-pcie: Add i.MX94 and
 i.MX943 PCIe compatible strings
Message-ID: <20260322231003.GA69234-robh@kernel.org>
References: <20260313083443.2391254-1-hongxing.zhu@nxp.com>
 <20260313083443.2391254-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313083443.2391254-3-hongxing.zhu@nxp.com>

On Fri, Mar 13, 2026 at 04:34:40PM +0800, Richard Zhu wrote:
> Add i.MX94 and i.MX943 PCIe compatible strings and fallback to
> i.MX95 PCIe compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/pci/fsl,imx6q-pcie-ep.yaml       | 20 +++++++++----
>  .../bindings/pci/fsl,imx6q-pcie.yaml          | 28 ++++++++++++-------
>  2 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> index 0b3526de1d62..b3b1ece6681e 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
> @@ -18,12 +18,20 @@ description: |+
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx8mm-pcie-ep
> -      - fsl,imx8mq-pcie-ep
> -      - fsl,imx8mp-pcie-ep
> -      - fsl,imx8q-pcie-ep
> -      - fsl,imx95-pcie-ep
> +    oneOf:
> +      - enum:
> +          - fsl,imx8mm-pcie-ep
> +          - fsl,imx8mp-pcie-ep
> +          - fsl,imx8mq-pcie-ep
> +          - fsl,imx8q-pcie-ep

> +          - fsl,imx94-pcie-ep
> +          - fsl,imx943-pcie-ep

These should be dropped if they are compatible with imx95.

> +          - fsl,imx95-pcie-ep
> +      - items:
> +          - enum:
> +              - fsl,imx94-pcie-ep
> +              - fsl,imx943-pcie-ep
> +          - const: fsl,imx95-pcie-ep
>  
>    clocks:
>      minItems: 3
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 21dda8066014..fd5f7ff9c4a4 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -21,16 +21,24 @@ description: |+
>  
>  properties:
>    compatible:
> -    enum:
> -      - fsl,imx6q-pcie
> -      - fsl,imx6sx-pcie
> -      - fsl,imx6qp-pcie
> -      - fsl,imx7d-pcie
> -      - fsl,imx8mq-pcie
> -      - fsl,imx8mm-pcie
> -      - fsl,imx8mp-pcie
> -      - fsl,imx95-pcie
> -      - fsl,imx8q-pcie
> +    oneOf:
> +      - enum:
> +          - fsl,imx6q-pcie
> +          - fsl,imx6sx-pcie
> +          - fsl,imx6qp-pcie
> +          - fsl,imx7d-pcie
> +          - fsl,imx8mm-pcie
> +          - fsl,imx8mp-pcie
> +          - fsl,imx8mq-pcie
> +          - fsl,imx8q-pcie
> +          - fsl,imx94-pcie
> +          - fsl,imx943-pcie
> +          - fsl,imx95-pcie
> +      - items:
> +          - enum:
> +              - fsl,imx94-pcie
> +              - fsl,imx943-pcie
> +          - const: fsl,imx95-pcie
>  
>    clocks:
>      minItems: 3
> -- 
> 2.37.1
> 
