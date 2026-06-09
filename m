Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00BD3914FD;
	Tue,  9 Jun 2026 03:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780976651; cv=none; b=q8B7oU/YlNOlI4LbZNYGzUVfxx2LgDBCDC0W5lifmtKmDf0in5sfpzmITV8dnPz//BgbLc89JJrBPltVN82hUA3rAUIJRp+Bkc5EWFLZ8bvUYv7XtH5H8AKickauslp4nT7mM5mhRhgsvyYH4swXhCjf8ZBFry/tlqUhc6qD2Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780976651; c=relaxed/simple;
	bh=zahZW4SKIx4Wavl07hjPwNc14csC4ewYXlAadqq5SjY=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mKFt21aW9z1AiJVBotVrtphY6mtchsbVuCJsIe1WtZ3gqDzwe6DyOctxwtK58LB3ncBYsylk9wNH2ugd4W+OJmMSk4/slnQH7AM/UxjxOTnAHlLastTTmW3UqQjcLBn+FDMWCT5l+Ld8tg+jzBOk6RdD3syhafwsGmHlPSVUx5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsyiHsXC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XsyiHsXC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC69D1F00893;
	Tue,  9 Jun 2026 03:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780976649;
	bh=vm213frcQziPdn+k5M2H8S8AKd+49YZC43IVjClcHzE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=XsyiHsXCI4WGaQwbDDXWlLxWaImrxoAWn+uZpwFolk1Fn5fMT+O9aJhmjTDOw/NG5
	 IsYqTlTvPLW8mNzFLrKbqRm8CLeR8ewg3rezpT4jSnSOQ2iypp5voni5Eig7mtVfXz
	 fmei/Gp93JTHPQx1cW96UkZ6+ShH1CICvlUprI+6vEIRtEdpUZogljOz6aJE5v5qqL
	 26VDYpyfxab5Haca5kL+YZUblnxKc1OnV7I1cFNLfpN2bd0O3KF/+wxaH4CUTHUP6V
	 RNeNYAfxkVm4hKhNobLRIeQ72R6QyyO43ccVlQxVXIU6Y4IIgZHahs1X5/udwg1eeO
	 JnQkNsSvi31uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: connector: pcie-m2-e: Add 3.3Vaux
 supply support
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, robh@kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
References: <20260609033840.2006078-2-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 03:44:08 +0000
Message-Id: <20260609034408.BC69D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `vpcie3v3aux-supply` property describes a non-existent hardw=
are feature on the M.2 Key E connector to work around a software policy.
--

commit 0268cb00caa35acacc055d760f1155866bebdf1d
Author: Sherry Sun <sherry.sun@nxp.com>

dt-bindings: connector: pcie-m2-e: Add 3.3Vaux supply support

This commit adds a vpcie3v3aux-supply property to the M.2 Key E connector
binding. The commit message indicates this is added to support special
lifecycle handling for the regulator during system suspend.

> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connec=
tor.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.=
yaml
> --- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> @@ -25,6 +25,9 @@ properties:
>    vpcie1v8-supply:
>      description: A phandle to the regulator for VIO 1.8v supply.
> =20
> +  vpcie3v3aux-supply:
> +    description: A phandle to the regulator for 3.3v AUX supply.
> +

[Severity: Medium]
Does this property model a physical hardware pin that actually exists in the
M.2 specification?

The PCI Express M.2 Specification does not define a separate 3.3Vaux power
rail; it only defines a single primary 3.3V supply alongside an optional 1.=
8V
VIO supply. The concept of 3.3Vaux existed in older standards like PCIe Mini
Card and standard PCIe CEM slots, but was removed in the M.2 standard.

Device tree bindings are expected to strictly model physical hardware rather
than software lifecycle policies. Adding a non-existent hardware pin to the
standard M.2 connector binding purely to instruct the driver to keep the
regulator enabled during system suspend pollutes the permanent device tree =
ABI.

Could the existing vpcie3v3-supply regulator instead be properly configured=
 in
the board device tree using standard regulator suspend states (such as
regulator-state-mem), or could the host driver be made aware of the wake
requirements to leave the primary supply on?

>    i2c-parent:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: I2C interface

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609033840.2006=
078-1-sherry.sun@oss.nxp.com?part=3D1
