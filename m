Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31630BF52;
	Thu, 25 Jun 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782425069; cv=none; b=QRIVgKP8F91EmMIziol/nPlCW36+Tx4llGxoK77jt1llQ6gDB1DJiAYGqMJWY35/1VzLl3Rchf9zyS+7BY3+GmrmDrp9rACZHOzLm8bZj/FVvk6Aju9EzlCMkNDIsBX/qc9gWHQZ0ZiXYAFip3wXqKBRFJFG0PnAVT0ngy5bcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782425069; c=relaxed/simple;
	bh=f7DoB95TT1HinndX9/UxfkAD0QRJt22jICZX/XbVpJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N8CXFnmQGgPeoD0KdaPRshi0SIqrUP9rcwYOW01FaS3EesD/NFz8gI/Gw+DweOdavb57AdXJTzin/M24E8Q89iA2yiOaFyXLTTdshdtY9lRoXA/FpgfIrPGfnRWzfm1ZlGlPw0b1rT4rCLMEr8fusU5CLOQxZ08T/bq0J614Zzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnLFqWWg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnLFqWWg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0241F000E9;
	Thu, 25 Jun 2026 22:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782425067;
	bh=oqyZb0FjYDp1OLMYrtkIQ3AI8fomSQlXKoHElKCBj7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OnLFqWWgJD6XFBuhDMcgOMnQAp7wZEs3i3SKi4XqasrTw4RZTV1s630IeGs7NoKPG
	 R/aasfz/64zsIXuK04bpeT4eY+zThMMpSV/kUhy8o5Wt8BDS+zMNjVZHZYfxjwjmcI
	 lRKLpaP8HqlfrusPxr4cy0pZZdXhj2WpoAmE/6m1WatYVl7kDb+FiTPLwUBw2pU0R0
	 AuGWJdPPnggbTDOJSJZaPKkCaQUZH3f7ho7HhTFIK4Y2UUGi/fwrjDw5nGtPKAZEVc
	 k+SXFCk/V+aqlMThh0cChSxm5h/ew64kdIfFtpnY4mLgXGlKxVKJ31FWf/+JmzHyX4
	 +N+J4nivC73OA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: PCI: mediatek-gen3: Split Airoha
 schema and document 2-lanes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260625215741.3253212-4-ansuelsmth@gmail.com>
References: <20260625215741.3253212-1-ansuelsmth@gmail.com>
 <20260625215741.3253212-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 22:04:27 +0000
Message-Id: <20260625220427.7A0241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The schema incorrectly uses `regs` instead of `reg` in the `allO=
f` conditional block for `num-lanes =3D=3D 2`, failing to enforce the requi=
rement for a secondary register region.
- [Medium] Typographical error `phy-lan2` instead of `phy-lane2` in the `re=
set-names` enum constraint for the 1-lane fallback block.
--

commit bb5683e00f2f10ba9133fc862deba2acbfb939ed
Author: Christian Marangi <ansuelsmth@gmail.com>

dt-bindings: PCI: mediatek-gen3: Split Airoha schema and document 2-lanes

This commit splits the Airoha PCIe schema from the mediatek-gen3 schema into
a dedicated file. This allows documenting the required properties for PCIe
configured in 2-lanes mode, while cleaning up the mediatek-gen3 schema.

> diff --git a/Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yam=
l b/Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml
> new file mode 100644
> index 0000000000000..977c1816572cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/airoha,en7581-pcie.yaml

[ ... ]

> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +  - if:
> +      properties:
> +        num-lanes:
> +          const: 2
> +    then:
> +      properties:
> +        regs:
> +          minItems: 2

[Severity: Medium]
Does this schema enforce the minItems constraint as intended? It looks like
there's a typo where "regs" is used instead of "reg". This might allow a
node with num-lanes =3D <2> but only a single register region to silently p=
ass
validation.

> +
> +        reg-names:
> +          items:
> +            - const: pcie-mac
> +            - const: sec-pcie-mac

[ ... ]

> +    else:
> +      properties:
> +        reg:
> +          maxItems: 1
> +
> +        reg-names:
> +          items:
> +            - const: pcie-mac
> +
> +        resets:
> +          minItems: 2
> +          maxItems: 3
> +
> +        reset-names:
> +          minItems: 2
> +          items:
> +            - enum: [ phy-lane0, phy-lane1, phy-lan2 ]

[Severity: Medium]
Will this properly validate phy-lane2? It appears there is a typo here
(phy-lan2 instead of phy-lane2) which would cause valid configurations
to fail schema validation while accepting the misspelled name.

> +            - enum: [ phy-lane1, perstout ]
> +            - const: phy-lane2

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625215741.3253=
212-1-ansuelsmth@gmail.com?part=3D3
