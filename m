Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459768;
	b=Lb3avppIJOiICbHsGSM6BHqWZYhmzovG/nuDZRc514lsTy7mwalOHAQ9Ui2no3kn+wNO
	 Wl252VcQl2SYTzUAbnVNuxejJkabvAr8uG9/f298ZzcwwcEm3QDCV+GZrIMpWJFNC5Jh4
	 B3M3Cs4YPYqs6iBTHleSRBGn/zNjxZmthOoWkWNYl/UmlfySfmw3N0O4VZG+DOkfI03Ph
	 Sd1y/rAQYYpPjbuX+4XnzkZB0v31z2ItzuZn8SQCif/5SJG6GRHJLm9iDw9VgYhUJT/es
	 fElSx3M82WFUOJcRZLTE+UhcNrBKBMdrX8tFHrOCnpz+0yUgfWN68MxWOiKybUwlKoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459768;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qdOirH751T6yc5stWtVH4gVrsmB09EyvutyaMmR4CTw=;
	b=h8AmZHgkNV9v+Jflz8JPbkQctPw5LZQ/KVuipAL5RqB5AqAgavPv4oJLAcIamCgDBFoZ
	 eNypXx5V9uXepz7skT0mMqlNXzHQKCcfUwzDS3DS0sbzrRjfmWtUx75p7mUavR6NdMR/7
	 WI9rhV8MCSouCGC1at5m835caxOuH+lW9OtBoarQSCAvRGgTUTa+eI7IVwY2uUnGDrYQt
	 M6opFAXmBMlvbc8t/M2awPKWmuoAJ+BhARfLhIreMohrnlY9V0DrnmP1+KRARfRZcmF3M
	 4Fd029yoq5Cx3/64vjlvWjOzdPazD+HJrAElMj4+ONsEiZ15z40aTsrfgyLbUXBnShQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ady0plQI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E9A606A31A;
	Mon, 23 Nov 2026 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ady0plQI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B951F000C6;
	Mon, 23 Nov 2026 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459767;
	bh=qdOirH751T6yc5stWtVH4gVrsmB09EyvutyaMmR4CTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ady0plQIBLuWfhEFPx00lOIjz3zchA4MWxao94lM1PamShUVP6YduZZQsc4/RBatX
	 7IWMZ6UEaCkiFAuRMFfNU4rpVsptTi6SvC1RJDxjsDUKUCNdBrEhWrwT2Yenx85qWn
	 8ByZIhTMrDupwrLoHOwoe2YSVHdcuEVRcU1UiiRBSrIyfKZwmQaJFCc8kKtViWPBbk
	 YzSYBmWM9MILxkLVsdfBZbnvT9s80UJT4STBd7ZcFiwn2i5CPgFWFevo9sz9EPe9pN
	 YcBlhySIxhsj4D/6DKZr+LRKkIBgVMEQ0jefSnYSfbiQYXEBNwHO/LAsp8fjZUrB7D
	 jnp3f8E9Wp2/g==
Message-ID: <sashiko-outbox-229877@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: clock: Describe CS7542 PCIe gates and
 resets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261123-b4-cs7542-pcie-v1-2-4cde5201d404@gmail.com>
References: <20261123-b4-cs7542-pcie-v1-0-4cde5201d404@gmail.com>
 <20261123-b4-cs7542-pcie-v1-2-4cde5201d404@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 18:49:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] dt-bindings: clock: virtual child node for parent syscon
  clocks and resets
--

commit 9d52d2650fe35dd9a422c99bb705a36a99c1ed9f
Author: Fil Dunsky <filipp.dunsky@gmail.com>

dt-bindings: clock: Describe CS7542 PCIe gates and resets

This commit adds a Devicetree binding for the Cortina Systems CS7542 PCIe
clock gates and resets as a child node of the global control syscon.

> diff --git a/Documentation/devicetree/bindings/clock/cortina,cs7542-pcie-=
control.yaml b/Documentation/devicetree/bindings/clock/cortina,cs7542-pcie-=
control.yaml
> new file mode 100644
> index 0000000000000..08e0214d2bb22
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cortina,cs7542-pcie-control=
.yaml
> @@ -0,0 +1,47 @@
[ ... ]
> +properties:
> +  compatible:
> +    const: cortina,cs7542-pcie-control
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
[ ... ]
> diff --git a/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542=
-syscon.yaml b/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542=
-syscon.yaml
> index fb074de870bd4..52597c4e84d20 100644
> --- a/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon=
.yaml
> +++ b/Documentation/devicetree/bindings/soc/cortina/cortina,cs7542-syscon=
.yaml
> @@ -29,6 +29,10 @@ properties:
>    "#clock-cells":
>      const: 1
> =20
> +  pcie-control:
> +    type: object
> +    $ref: /schemas/clock/cortina,cs7542-pcie-control.yaml#

[Severity: Medium]
Should the PCIe gate clocks and controller resets be provided directly by
the parent cortina,cs7542-syscon node instead of a resource-less
pcie-control child node?

The parent node already maps the 0x100-byte global control register block
and acts as a clock provider with #clock-cells =3D <1>.  Creating a child
node with no reg property or Devicetree resources of its own puts a
driver split into the Devicetree ABI, contrary to
Documentation/devicetree/bindings/writing-bindings.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-b4-cs7542-=
pcie-v1-0-4cde5201d404@gmail.com?part=3D2
