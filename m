Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A50581254;
	Wed,  9 Sep 2026 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966245; cv=none; b=KSbG7RacUFY7r8hAa+S59cCYRxulgpHJBdCfeG6K3FgjIZ7EM4DnuHAB8QQO6jsFt9UIcoItGmP/CdFZXJmWr/PiwDJht313Ga4F12sRMmgU4bhEAz//1cYolihXGIAgoFGAFt8MYg5Y1QR8efq0heptakqceitIW0FFysnhj84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966245; c=relaxed/simple;
	bh=2MdT73wBYQ5aWH6GiQDkiljtBumUdwQvf14tdmmF+qc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lBWX6UVNVpHdj7uI/wlD/SVagO7gEl/SYI6SIBm17ScyaxHAlNhHsfy8aU5AHdncxRPNSSQu5L0nJemZTmkHBTK53IfA6VoiBO1pteMrFQui+V/AMXP/UqM13Pf+oCMYCCGC2zBjbaBQN3ldTzKZar4G4KR8WjUe5fpUVQ9MYqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfGxj2UL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfGxj2UL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C511F00A3A;
	Wed,  9 Sep 2026 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966243;
	bh=hAWisZvYjjfSPgo/JC7Keaq0zB23MCYXUy0DsQS86bQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AfGxj2UL3bT9uqwD/nNTxJ/0giIjGbdOj3SBiQhZK7bMWm/2WjcPqYP+HHK4RGela
	 dPM0nVOU3J02xhTEUTWTj4KJXKn0ketXcczQ4rzgdyxEWazocmTluAPSqV+0zsXkP3
	 HNmCZv1c7siUCQGqhwJFMOFNdl8LDrUmXUccZGwX9yArPUUqnhhF6Qb+nu6qXkGLWr
	 elsdbFAqKtqt/UO9Qv1SFXYwQAJRaixiBUxqQL9LsNT6z2aDz78yU92KXbZsB8+lhF
	 1wgv8GWSRPv5zmVTXICrP7BIt9pU87ImoqYP513jY2RmuoZdz6S2Crt96elKBKjVJr
	 ildKWHAniTzDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] dt-bindings: PCI: toshiba,tc9563: Document
 embedded GPIO controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260909-pci-tc9563-aux-v5-1-c9b33f56c8d3@oss.qualcomm.com>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-1-c9b33f56c8d3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 15:04:03 +0000
Message-Id: <20260909150403.A5C511F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Missing Required Properties for new GPIO provider capabilities
--

commit 384b355928f0212bcff0ab6c4447b15d28dc4109
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

dt-bindings: PCI: toshiba,tc9563: Document embedded GPIO controller

This commit documents the embedded GPIO controller within the TC9563 PCIe
switch. It exposes the controller by adding the gpio-controller and
#gpio-cells properties to the switch node, and updates the example to
demonstrate downstream ports utilizing these lines.

> diff --git a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml b/=
Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> index f084830c6d0cb..c4ebb99f50c37 100644
> --- a/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> +++ b/Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml
> @@ -31,6 +31,11 @@ properties:
>      description:
>        GPIO controlling the RESX# pin.
> =20
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
>    vdd18-supply: true
> =20
>    vdd09-supply: true

[Severity: Medium]
Does this binding need to include the newly added GPIO provider capabilities
in the required properties list?

When hardware gains new provider capabilities, the subsystem guidelines
stipulate that the corresponding standard properties (gpio-controller and
#gpio-cells) must be added to the required properties list.

Looking at the required properties block further down in this file:

Documentation/devicetree/bindings/pci/toshiba,tc9563.yaml:
required:
  - resx-gpios
  - vdd18-supply
  - vdd09-supply
  - vddc-supply
  - vddio1-supply
  - vddio2-supply
  - vddio18-supply
  - i2c-parent

If gpio-controller and #gpio-cells are omitted from this list, device trees
created with the pci1179,0623 compatible string but lacking these properties
could silently pass dt_binding_check validation but fail at runtime when
dependent subsystems attempt to use the GPIO functionality.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-pci-tc9563=
-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com?part=3D1
