Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E249238F25C
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089119; cv=none; b=Qi8wF5sE/GVmDsZo9fTYE8rlhA8bbsRkTHOeqUlG3b8pjiE7tcwmmZUSpnWolcaUPE5IwyFE52fmKl9OKcaU0AyfB8S8sXZ1jpnithDd3Q6FUykkc2RioMq+jAabrNTuEo2b/3RDN+BkWiyN3Z57d30iPRrjkPUE8jUfXPIIZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089119; c=relaxed/simple;
	bh=As7kleAl+4HMAkZbNSSRNniSnGN46ojhHwmCMU+zQ8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=liSIAuy95irMCeuWDDn+KB94lurART3W51PzpRlRHuG8RqSvMYmBmXgfIihK9BwjhfhPwLJMZF08Ad61xCI5kmE6TScdyhag9eboUEV20TvRhIE8Kxr/ZoilpwOj1JN0i8zH59S6zBxqyOaMU0ZFIW/qRVqyaFuz/xKOJ6hShJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGOTQKPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGOTQKPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D5E1F00893;
	Tue, 22 Sep 2026 14:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089117;
	bh=As7kleAl+4HMAkZbNSSRNniSnGN46ojhHwmCMU+zQ8E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RGOTQKPZP3689qhSUecBhEtYDuu+xE9g1EIFj/m8G5fvvkKW8ZZ+EZn2WyyzG2bH9
	 57oV1NiArtl867s5zWQ1UhLzHAwc+2Wt7bKHDtolcIWQ82604+ziOjBdZboVs1m+h4
	 munrrnNMZV1BRTbMBkk6SzAhLG6JpfArQc11DDNhasW4Uc3U3kEST2gSU6RnIeTt59
	 5ymogmi0zeRcxzWNRj2l+h9Lt7060OxqBmrjAXoWTVYGi/FA9jkmqM/eQlHv09QRsU
	 hjb4PuQaJE/8re/BnC2KqjJOV7d+IEUnHEIeQyEZmRc12HmvJJWnZNKM6wyQpryOJ5
	 ArmOznaoCCrdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/8] PCI: rzg3s-host: Follow hardware manual
 clock/reset initialization order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260922144629.586997-2-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
 <20260922144629.586997-2-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:58:36 +0000
Message-Id: <20260922145837.22D5E1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The RZ/G3S PCIe hardware manual specifies that the clocks must be enabled
> before the reset signals are deasserted during initialization.
>=20
> Follow this sequence in the probe(), suspend(), and resume() paths to
> match the hardware requirements and avoid potential issues.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922144629.5869=
97-1-claudiu.beznea@kernel.org?part=3D1

