Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE7443E21;
	Thu, 27 Aug 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849947; cv=none; b=qnFxk0Y0aK5taN65eJ100iUcUsXXwE/+IEGGxbsm2T3PYqqhr3vxwJj3zUNSMV8IbvaCNVEePYgvHv4POgZgALO8rVTxwj/WAE0LaCxoryGaiEZfFbuh40eRiknIROdqM7+4RBoIGhmfjbZUxxzq97etlMqJpX86fwZ7DGdXVB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849947; c=relaxed/simple;
	bh=Km1hhgp5FntH5xOTWaanvDMlbJ9XC71doV52pMT6N5Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BA1Bgnq03OgGMUvUpBCj8bpslUDl/o8BHKy50jvG0qjr4UvMzvdcoxXpAKq8MHYy4OK977M9AcE9IOk+Ykm5O0GnIeFk+qL3DUTMjP4z8BnzRND5ujikHvdoEpLCVbPpZXcqsjxBZ010iOwWONnERra3Ijq5HVMtQ3tC44+7byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDZoUIP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDZoUIP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A731F000E9;
	Thu, 27 Aug 2026 16:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787849944;
	bh=Km1hhgp5FntH5xOTWaanvDMlbJ9XC71doV52pMT6N5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WDZoUIP8Jh088fSZzHBfzmImSzBuaVHblwVx3RLGg8cpc4zo7LZphgy5mebR3zx5w
	 tLxCfmsQmSOFgKotM7shJOfJntHhxPAOXap7RodYhvOahf7/gW/qX3cPD1npifRKLL
	 0iA7bFSjPTEHJAUMOj3Mixc/x1KgQoOh8HqKfJM4X+5bRf3mFYGw3+Wryji1u0qv3W
	 ZR3PQKegT5TF/8IhbiHlDKZ8qg57mUHYIAIv5tlk5PaOSxu8kMZ/FEv8IgU15H3tti
	 ZA7Lr4Bl4xWqO1lrZUjvg0NTbMauTZGYuHoBMQkIGHL29/Imq5iAVQ6CYaREKtcMCH
	 h2c1HMVTWAdQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2] PCI: imx6: Enable ASPM L1 only iff CLKREQ# is
 supported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Gorlas" <michal.gorlas@9elements.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
References: <20260827-l1-conditional-imx-v2-1-40b324aa2a94@9elements.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 16:59:04 +0000
Message-Id: <20260827165904.69A731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Since commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM
> states for devicetree platforms"), ASPM states are force enabled
> on all devicetree platforms. This causes PCI devices on some i.MX SoCs
> (for e.g. i.MX 8M Plus Kontron SMARC eval carrier) to enter L1 even
> though CLKREQ# is not supported (and consequently supports-clkreq is
> not set in pcie controller node of their DT), which causes the device to
> never wake up from L1.
>=20
> Hence, disable L1 capability in the LNKCAP register if supports-clkreq
> is not set in the DT explicitly. For devices that set
> IMX_PCIE_FLAG_BROKEN_SUSPEND, disable L1 on resume as well, as these
> skip imx_pcie_host_init().
>=20
> Note, the logic here is very similar to 613f3255a35a, only difference
> is that leaving L0s enabled does not cause issues (at least
> I never encountered them myself when testing on the device) as its
> not dependent on CLKREQ# being physically there.
> Since there is already a way of specifying its presence in the DT,
> the driver should be aware and disable L1.
>=20
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for de=
vicetree platforms")
> Signed-off-by: Michal Gorlas <michal.gorlas@9elements.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827-l1-conditi=
onal-imx-v2-1-40b324aa2a94@9elements.com?part=3D1

