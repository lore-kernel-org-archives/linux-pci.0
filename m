Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCF330650;
	Tue, 30 Jun 2026 06:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782799964; cv=none; b=cbRYV3zEV/CJThHAgA88E8W1Js/eHvCfp1IrPZ+c+aZtvSXbJRNuqFBd4ymGfnZ05uGh8t/cF+tbrwMtFs/F6aJY4l8Rd9gKBXhiY7LcZ6pQEslqPZXm8dGtvK8mkkZKmV0si7klV5VdWjWy42+ULCAKaALF+iIPpBmDfydiJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782799964; c=relaxed/simple;
	bh=Huwlm+d2dh+53k1NCyHGfuxM5X+7Sm9Q1yGS9BYwEMA=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fIGieWOdlonmWjE4NhnsRQk7V6yu7tCqxB45YwH8ZxvIeIPPVqqecGGLRFOzRJQ2YhgEu6NobzstwdIh/ja2IqI42xy0a353Wovlr5pH/iDodlamv6o2W8y0AyWgAf7Jsui3smV8PyX2AIIqtlGwIKYeHOyHkGNqPyguBTqcs7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZLD0mQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZLD0mQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F7F1F000E9;
	Tue, 30 Jun 2026 06:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782799963;
	bh=Huwlm+d2dh+53k1NCyHGfuxM5X+7Sm9Q1yGS9BYwEMA=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=gZLD0mQbHVmU1Bea0UVXOOD6QI3Phv6Jeimfc2u+BWQY8kSpb4PLXnm1arkNWq4ZP
	 Imo2AnvmvqcDdZlfuOeJ1GcTrUavtFastmewcPjuBCyI53mOL25D6qIpYxfDuv08Ir
	 990TeIzoo/CrN5CN1NCCS2I9zCYpzJXSLGeanPQUxqn4i3UyN/c6r87/nJqpI+lHAu
	 oCn/0c20eLtskMfxo1hsoJ/WOwqMxRkK8/dwfOPi8JL7EtHwicwP73ihoTdHP9dKRe
	 BdzMBjn0YDVDH5wWuhGHWP+xElKsDC0LcZz01mLxmY9VsxkoPgsKvc8ye372rMa0XS
	 lKRAJIDqu1TXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 3/7] arm64: dts: imx8mm-evk: Move power supply
 property to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260630060710.3294811-4-sherry.sun@oss.nxp.com>
References: <20260630060710.3294811-1-sherry.sun@oss.nxp.com>
 <20260630060710.3294811-4-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 06:12:42 +0000
Message-Id: <20260630061243.02F7F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> Move the power supply property from the PCIe controller node to the Root
> Port child node to support the new PCI pwrctrl framework.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630060710.3294=
811-1-sherry.sun@oss.nxp.com?part=3D3

