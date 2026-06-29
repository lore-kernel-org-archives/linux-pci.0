Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D75191;
	Mon, 29 Jun 2026 22:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771341; cv=none; b=s9mpiuazTV/L6d3X92FLb3f8EVg05eWsqVyWf9820wzFw+Dsv/FVSJJUvT1GucAqkkeRxiePnrC0brIwIQt4R5IGjrbZ8XuGgtp6e+tBgF876FP4OwHKQDgjVK3SdwNy7PrqZq6f6YRL7p1Qe3WY3fb2dzDtvnvbBiSk8FZiF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771341; c=relaxed/simple;
	bh=s2lGu4iAeEUl42sSwYI0OpUe9gLW2IsebNJICi/W6M8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SIQfWz3SJe3tXmhzYHYYNKrSY3pg/4+i8KqxqLYDEiN4OZGp1AHwEhrkO9XlRjwngnvV1k3XLpkS5OKZnsd554Xn2O2qMR5iZ4gTAqytd9LKFVw8reEmAMVk3FA7TZ/J08R7IBLmghQO5O1k1M8nXzct6tvu87nsY6hBXVwRsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiFD7iMl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiFD7iMl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B8C1F000E9;
	Mon, 29 Jun 2026 22:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782771339;
	bh=s2lGu4iAeEUl42sSwYI0OpUe9gLW2IsebNJICi/W6M8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LiFD7iMloFj4V2Vk7K9T0b0GnN7im8/vxlxKBKuLLOrV2b7lCrscOnXIVsr3Ja+ON
	 rYw5UBSa6EEsqV1rKj0e2j8qH90stsshEKcDVQpIH8WGELq8p5lx2xeJv/EQ/mayx8
	 gy7/MStnNt8i7Kn2l3R69fj04p7+axY3PVHg/vNlalOeDlCfA/QbiSloGfSKnjAYbA
	 gWULwfxaZRA6qaJ2gS/WmCPAgCnHIt/W79uqcry6L7KjslvDJQk22NKfVpDlpQilZK
	 wndJ8jy6qKSS6wfMVuymE0MBFWLV96VLgf2lrXm/VoBe2vySF1Xfixrwq0vt8tum5w
	 XuVM1yONS5NPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] dt-bindings: PCI: renesas,r9a08g045-pcie: Add
 RZ/V2H(P) support
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260629220932.861445-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260629220932.861445-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 22:15:39 +0000
Message-Id: <20260629221539.71B8C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add support for the PCIe controller found on the Renesas RZ/V2H(P) SoC.
>=20
> The RZ/V2H(P) controller is similar to the RZ/G3E variant but includes
> additional registers and configuration bits for PCIe lane control. It
> supports multilink operation configured as either a single x4 link
> or two independent x2 link controllers.
>=20
> Unlike earlier SoCs supported by this driver which only feature a single
> PCIe controller, the RZ/V2H(P) SoC implements two controllers. Both
> instances rely on the system controller (SYSC) for configuration, but
> the required registers reside at different offsets for each controller.
>=20
> To correctly identify the controller instance and map the corresponding
> system controller registers, update the "renesas,sysc" property to a
> phandle-array. For the RZ/V2H(P) SoC, require an accompanying cell to
> specify the controller instance index (0 or 1). For all earlier SoCs,
> strictly restrict the property to a single phandle with zero argument
> cells.
>=20
> Additionally, make the "num-lanes" property mandatory for this SoC and
> restrict its values according to the hardware capabilities.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629220932.8614=
45-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1

