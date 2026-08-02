Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AF3B05B8;
	Sun,  2 Aug 2026 11:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785670866; cv=none; b=N0ttdmTAyPlRA0hn5nZQ+lNU7yRnrE5MDZYVBKwiv6+GtoCNBneKJzBHavOtidW+ABmBn/TpjgQ7mzQL5bikC1ow7QluBYbOHoVaclSUPIk5poSHLJzAt3RY/xrHRlSdhgzpBTXJrjx2Bvqv3zYz+JtQwgK8AKCgWSSG/7+/WKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785670866; c=relaxed/simple;
	bh=gJeqcNjGKhg4ra7YERdKWsJwggmrs0ek2ddMhRWnfHk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cVAkZAa9hL8EtA4HTHaavyrDa6iZd1wJAVetb96ytjZTFNsWS9Jv6EAzoYLV1si02pTgiOEcRiFZB8SnT387VKRHd4r950DKoz/vKB9HO8EaLVVUCupx7mZeMbehE5xnlxWVSQBFmHhQ2JNC8dmmXXPIhYsd6/1zTrUPbG3epYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhESa4Q3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhESa4Q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1A21F000E9;
	Sun,  2 Aug 2026 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785670855;
	bh=orMZo8XC5q8wzUoZRvS161bOQVWl8wv42guc5mSh2YM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bhESa4Q3WT36KyjVnZuVrajJ55PbcVapZvXgr+r/AN7ax4Zuau5NFlhq480dsDExd
	 APy9k2FmAm1TgE+2IRHhE61bXu2p5Nrhn75u78wXnVM7bNWru1HzMcpwmZ9fKlXV14
	 Jy81KwN7A4ojfJk5tH5ecnrnEhinDXLKThi9WsE06oWP1gxa3Yjkk0bJ6TGxlJ83lM
	 oISrdkMyG5KjPnerBkH09g467vUL6/vaSwbcZqYCJogd14v6eAEwvbx14BF1T/8sHq
	 tEKJOSOwuIJCNdemQSZXz3T+1w4NgBzdXeqsUoHkj7Xdb+F6tOAeD62/cMMuOUy9Eq
	 1RGYTkvlnkS7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: pci: fsl,imx6q-pcie: Add extref clock
 for i.MX8MQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rudi Heitbaum" <rudi@heitbaum.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <7f99a670eba4b76c391cb87a487f7a837f66d838.1785669457.git.rudi@heitbaum.com>
References: <cover.1785669457.git.rudi@heitbaum.com>
 <7f99a670eba4b76c391cb87a487f7a837f66d838.1785669457.git.rudi@heitbaum.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 11:40:54 +0000
Message-Id: <20260802114055.4F1A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The optional 'extref' clock was added to the Root Complex bindin=
g for i.MX8MQ but omitted from the corresponding Endpoint mode binding, res=
ulting in schema validation failure if the endpoint uses the clock.
--

--- Patch [1]: [PATCH 1/3] dt-bindings: pci: fsl,imx6q-pcie: Add extref clo=
ck for i.MX8MQ ---
commit 4169458ec9055f45e1c7d18a9eea850e75cf9b6a
Author: Rudi Heitbaum <rudi@heitbaum.com>

dt-bindings: pci: fsl,imx6q-pcie: Add extref clock for i.MX8MQ

i.MX8MQ can drive PCIe REF_CLK either from the internal PLL or from an
off-chip oscillator. This allows an optional fifth extref clock to describe
the latter, matching the name already used for i.MX95.

> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/=
Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index e8b8131f5f23b..8fb0c919ae572 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml

[ ... ]

> @@ -173,13 +174,16 @@ allOf:
>      then:
>        properties:
>          clocks:
> -          maxItems: 4
> +          minItems: 4
> +          maxItems: 5
>          clock-names:
> +          minItems: 4
>            items:
>              - const: pcie
>              - const: pcie_bus
>              - const: pcie_phy
>              - const: pcie_aux
> +            - const: extref  # Optional

[Severity: Medium]
Will this same clock be used when the hardware is configured in endpoint mo=
de?

Currently, this adds the optional extref clock to the root complex binding =
for
fsl,imx8mq-pcie, expanding the maximum items to 5. However, the correspondi=
ng
endpoint schema in fsl,imx6q-pcie-ep.yaml for fsl,imx8mq-pcie-ep still
restricts clocks to exactly 4 items:

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml:
  - if:
      properties:
        compatible:
          enum:
            - fsl,imx8mq-pcie-ep
            - fsl,imx95-pcie-ep
    then:
      properties:
        clocks:
          minItems: 4
          maxItems: 4

If an endpoint device tree describes the hardware using this 5th extref clo=
ck,
will it fail schema validation because the endpoint binding was not also
updated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785669457.gi=
t.rudi@heitbaum.com?part=3D1
