Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793829966;
	b=bEHbZvtYzzZc31Cz1xLVwY6zf+PkhlJ4iidL5tHotQYkZOLoDGPfaB8nQUSNXxs5qfQV
	 VVdSDCSW8WjGQwfaP+SrduKbStl6jYeax/a2SLa9sI8xD/nKdbdgFdaZBRlNW0o4oE034
	 xnEu10B9yGEvyJYxwSExlcMkB42n/BaqF6r/wxLjvFJCWEPAPbIJivlhPLsrpms6NB/h6
	 xZ6QO96DdOwYvjkRXAcKtj2aA9p51ESo+ugqLG01AbHeZqnX7AtTndXLvhBZYdMPrK1yX
	 eXZQ9otUMAFk5cj5TOOi9m+izMLm3gKcxULXcQWX6rPC+UjO1pre4EesTrrGWiKOlcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793829966;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U1bBV/xX8J5aLWoHVJkM+zZjT4UQKnQCyuDAAFuxwCk=;
	b=STYZPEWh2rIlZB9q9AJB3btc8Rg8Vov0mm7RAmmmz43pYzA9QIZKOd1yMXikqM2Ih1eQ
	 IOA6XkQpifnup8DfS3hQ2zGMQVaUhhfSIVRoBastUXwlU0lCrEPiMKCAqqmt1RvEW+vYS
	 nT06s+ZfDYXp1RH0aM/IR/wxAAffWPIRxVTmkpHO5Q0jaymHjoX75E21LRmwojuvyYnlX
	 Dee1vNYcHZVFZt2rInxxvsIBnzfkXcaMj8hZLuCaPwRNSuZONZHbyFkM7eF31kHHcAH3G
	 eiEwBx86wjLr2XH8V506rJ1IyD+cDv96XG1vHsUDdU9HbT7hXN8zi5vxJoCrDsYb07A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YZzvhv/q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2D606CA38;
	Wed,  4 Nov 2026 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YZzvhv/q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE6F1F000C1;
	Wed,  4 Nov 2026 22:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793829966;
	bh=U1bBV/xX8J5aLWoHVJkM+zZjT4UQKnQCyuDAAFuxwCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YZzvhv/qFfJ3Uog47MLRj6pOTZLtaMizInQgCw/1lgfHv3IODeU04eTMflMiGGG9/
	 fs3o2u4HauKHNLBR/ylPOH0esKu2MggK1rXXgioKgGGgHEUvAdV52s5FL4Ix7zmeWc
	 HUi6gMh+ZXqJjkLS1dbieG0zNjZdfEL3RlCTn44BV5q63m0EkR+O/Ro9JQSIo+ZFUS
	 QRLzi++27Ikgheb3FZZqKw/7zJZBrL//6sUa1tF/8z8ImA9puyZO5B0NBgX2bIL/UD
	 KldreNYIGa2yjOME8M0NAyLD/jOU/pMWAVyGjD011swDLkeQqJkCN7DWiIY1VVLKVn
	 zlohcJjjRiQcg==
Message-ID: <sashiko-outbox-198198@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: rockchip,rk3399-pcie: Add
 PERST# inactive delay properties
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RW5yaXF1ZSBIZXJuw6FuZGV6IEJlbGxv?= <ehbello@gmail.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261104215848.2087944-2-ehbello@gmail.com>
References: <20261104215848.2087944-1-ehbello@gmail.com>
 <20261104215848.2087944-2-ehbello@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:06:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] dt-bindings: PCI: rockchip,rk3399-pcie: OS policy and magic 0 in=
 PERST# props
--

commit 9f3338157ea2855233568eb255bd2687fadd36fe
Author: Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com>

dt-bindings: PCI: rockchip,rk3399-pcie: Add PERST# inactive delay properties

This commit adds the optional rockchip,perst-inactive-ms and
rockchip,s2r-perst-inactive-ms properties to the RK3399 PCIe host controller
binding to configure the reset assertion delay at probe and system resume.

> diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.y=
aml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
> index 720a5f945a4e6..7ac915c267910 100644
> --- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
> @@ -40,6 +40,21 @@ properties:
>      maxItems: 1
>      description: pre-reset GPIO
> =20
> +  rockchip,perst-inactive-ms:
> +    default: 100
> +    description:
> +      Time PERST# is held asserted before it is released, which is also =
the
> +      width of the reset pulse. The default meets T_PVPERL for a slot th=
at
> +      is powered at the moment PERST# is asserted. Some endpoints need m=
ore
> +      settling time than that, while others stop responding when the pul=
se
> +      is that long. A value of 0 selects the 100 us minimum the PCI Expr=
ess
> +      CEM specification sets for the pulse.
> +
> +  rockchip,s2r-perst-inactive-ms:
> +    description:
> +      The same time, applied when resuming from system suspend. Defaults=
 to
> +      the value of rockchip,perst-inactive-ms.

[Severity: Medium]
Are vendor-specific host controller properties split by OS lifecycle state
the right way to model this in Device Tree?

Splitting the reset delay into rockchip,perst-inactive-ms (probe) and
rockchip,s2r-perst-inactive-ms (system suspend-to-ram resume) encodes OS
driver power-management transitions directly into the binding rather than
describing hardware characteristics.

In drivers/pci/controller/pcie-rockchip-host.c, rockchip_pcie_suspend_noirq=
()
only disables vpcie0v9 while leaving vpcie12v, vpcie3v3, and vpcie1v8
enabled, and does not assert perst_gpio on suspend. Then on both probe and
resume, rockchip_pcie_host_init_port() asserts perst_gpio, enables link
training (PCIE_CLIENT_LINK_TRAIN_ENABLE) while reset is still asserted, and
sleeps for PCIE_T_PVPERL_MS (100 ms) before deasserting perst_gpio.

Holding reset asserted for 100 ms after enabling link training or when slot
power rails are already stable looks like a sequencing issue in
pcie-rockchip-host.c rather than a property of the RK3399 controller.

Also, if an endpoint requires a non-standard reset delay, shouldn't that be
described using generic reset or PCI device properties (such as
reset-assert-ms or reset-delay-us) rather than SoC-specific host properties?
Neither rockchip,perst-inactive-ms nor rockchip,s2r-perst-inactive-ms exists
in mainline Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml.

Finally, rockchip,perst-inactive-ms uses the standard -ms unit suffix, but
defines 0 as a magic value that selects a 100 us pulse width instead of 0 m=
s,
and names the active-low reset assertion duration "perst-inactive-ms" even
though the signal is held active (asserted) during this window. Could this =
be
handled by fixing the driver reset sequencing or using standard unit-accura=
te
properties instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104215848.2087=
944-1-ehbello@gmail.com?part=3D1
