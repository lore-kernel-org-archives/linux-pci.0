Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289F2D6E5C;
	Mon,  8 Jun 2026 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780909005; cv=none; b=Zcie00wgRcNYFptpXBm4sI3TS+r2AEwKccikjSysxTPH/x/2afhSj05LeecHJ/qAdrcYFX7Vzh9P6YMQFeijq3onN9KWP2GwsPLHLQ4ckaaPWRPh5pf8+ymiiAfxWhtLztbWzyqTIX2T6WEfBCyp8ppyG/2+gYNge6dqBBKQG/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780909005; c=relaxed/simple;
	bh=mCvICw+V8x9WUH+ZKxcvySgyc4E0UOJlcSzinCk1qaE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RgvjPCSBBjGB5s8lN2QmgLCSccY+4DcG3JCv5d2XDAqOiFQkmidPrZ1ZzxmRcUSwYC/I8afYZMSejwxrjRLM2i+J1uioVkvAnhHOl23qW1gUeEOPQjxamJUHbAjBZO2XJG3JKgOxM7Fl9Sgg+zeCmLY4GwaAV+HCLHImsTVUpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD44aQBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD44aQBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091731F00893;
	Mon,  8 Jun 2026 08:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780909004;
	bh=sxSE2l6KAAkyWscMU0lKK/VyINcG1PV/kDm4olgmCPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UD44aQBgvuQ7ydJ3q/NMP44zOp6fqdqS1JXELYVlyflEr0U8GrhIs2yLlOahVDYOu
	 EadvKYzuswMa01hqZGD7zaFRoo01JWr+ozPRQu2t9iP2ZiUfIfOupzoAN3VH7aHlah
	 Wox+nw4ilCSggTUaGwioTwjdGDaU9MYS1h7V3NUs2yUKNCzyXa4bRFCrEWmLoIjhUq
	 gQ2x52S4wLmnpfygMuHM7utYY1EPWBm5sChmME6LW1gZHA7rPF/aFuIGR/VL6YQa6/
	 cRVyxsCrOQyMVLF8ijEmYrV593szwidtb5hTFkElJ6celnvtKwmUJTw6CHbCQXzFvd
	 qNv4h4UholpIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza
 compatible
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-phy@lists.infradead.org, olteanv@gmail.com, vkoul@kernel.org, neil.armstrong@linaro.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260608-eliza-v3-2-9bdeb7434b28@oss.qualcomm.com>
References: <20260608-eliza-v3-2-9bdeb7434b28@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 08:56:43 +0000
Message-Id: <20260608085644.091731F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The schema uses four separate `if` conditional blocks to apply cons=
traints for the exact same `qcom,eliza-pcie` compatible string, instead of =
consolidating them into a single block.
--

commit 4a8af2f6d98b918d7b48060ac70342492b7abb27
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

dt-bindings: PCI: qcom,pcie-sm8550: Add Eliza compatible

This commit adds the qcom,eliza-pcie compatible string to the SM8550 PCIe
bindings. It introduces specific property constraints for the Eliza SoC,
defining the required number of registers, clocks, interrupts, and resets.

> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml =
b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
[ ... ]
> @@ -91,6 +92,55 @@ required:
> =20
>  allOf:
>    - $ref: qcom,pcie-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,eliza-pcie
> +    then:
> +      properties:
> +        reg:
> +          minItems: 6
> +        reg-names:
> +          minItems: 6
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,eliza-pcie

[Severity: Low]
Is there a reason to use four separate conditional blocks for the exact same
compatible string? Could the properties for reg, clocks, interrupts, and
resets be consolidated under the then clause of a single if block to reduce
verbosity and schema complexity?

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 8
> +          maxItems: 8
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-eliza-v3-0=
-9bdeb7434b28@oss.qualcomm.com?part=3D2
