Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78373F411F;
	Thu,  9 Jul 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594144; cv=none; b=AHKQrf9g1H6G6RmGcdf+BNRYDAsDnWSVq4NIgEnLwpfD2kxlDQRLOSGJO/T9XCsrtyDaNOw2IsXh4M+0B4t3S0/nw9kQuCQMdP8jDrn3hZWyTNpwaHdh8mvp4rtgHvXPQiJnupSUZDFW+vP8LZNgj6KIbFVJY4spEMsz7BM6tD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594144; c=relaxed/simple;
	bh=YI6tWy9xpqSyTmSO6IJ8KTBuUwfWNf2qe1Uej1Bwe68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uwFGzDWquuvF/KFRs8y4mrc41+70Sqk3TvADjgebWMnJusgXW9uBhePipfm8NgvO0TsDQwxuviApy0GfAnjXmXhTZeFDtNrmJj299FJHtANxL0J97pK9VXKxRQ0xipoHtwAYdkQ1rvgQA8Y1wVwi0Oe67yyziOvRUIWHWDWu+0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct+yQB0a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct+yQB0a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001AF1F000E9;
	Thu,  9 Jul 2026 10:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783594143;
	bh=YI6tWy9xpqSyTmSO6IJ8KTBuUwfWNf2qe1Uej1Bwe68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ct+yQB0a1UV8iVjxlmTiIREpUY1gJ9vujMTbxodlsEMT3ogtkyeSaVCoecZqmVXHL
	 d2cTiuqdbtiXcusCvVQVJKqSAyQmvHqBgn8Gc+mrIrmxD+H7kUGmYgOm90buDMARTf
	 LEKAvGakwpHEa3XmqrgmDQlm0hC0SpucSmdqvgjYDdXA4WZMQIYkHbZKttu2uAKdP2
	 uylxyjCodvlDnPXeCzOE2Bks7V5Fv4onZXOFgR2YKdY0erhyAh9Q6g1bhZLhnMflB8
	 OEZOzBdpZJQUT8nCN9aOS63XJNgxedsbfbAOy3w3Sn3q3NW2e3K0UiFDVid+tXOfUD
	 EpF/hbCukJzkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 2/4] PCI: imx6: Add skip_pwrctrl_off flag support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org
In-Reply-To: <20260709101555.3034853-3-sherry.sun@oss.nxp.com>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
 <20260709101555.3034853-3-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:49:02 +0000
Message-Id: <20260709104903.001AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> Use dw_pcie_rp::skip_pwrctrl_off to avoid powering off devices during
> suspend to preserve wakeup capability of the devices and also not to
> power on the devices in the init path.
>=20
> This allows controller power-off to be skipped when some devices (e.g.
> M.2 Key E cards without auxiliary power) need to support PCIe L2 link
> state and wake-up mechanisms.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709101555.3034=
853-1-sherry.sun@oss.nxp.com?part=3D2

