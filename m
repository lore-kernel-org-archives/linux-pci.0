Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C1135CB66
	for <linux-pci@vger.kernel.org>; Fri, 19 Jun 2026 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861739; cv=none; b=l5JjXkDvdouZpMhOAlyqaRewkmhKB0D+l7cwnGQenJM1VFID+MkW+yf1bW/GU9Jf0RWSwBRauAPqUDX2waF+ZCY9sB0ECmSx+z4KmyfbM265qQGffUF2hXg88g/g8iaYzuvE5zjrjxwNqfQ/a/+o1FUg6NvP3i6cHqKtWkwvo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861739; c=relaxed/simple;
	bh=HevXSsRAD8RqDDg5x9stuAH/XC3G8aMxP8cPnBIL5ao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bay0M4d/VdWeDChyoS/EX8iHNEJyPOPgG5lQ4RChHSa+3GVX4l/UjwOebTpewaokhzlbEAcDbjwzihRGmu1AQ9dQ+RQQcUlWODNogelgKO13wm8I0uCTl/VRYm20ln9rCDgkYqzmDehHQPwzNidwBfioXVmQ7WYfTqtHwrM10mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGtGYM/S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGtGYM/S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C5791F000E9;
	Fri, 19 Jun 2026 09:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781861736;
	bh=l/XFoI1jklbpVF5KJ2B/1I3K8+BNYabKDj9bB6yc5NU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGtGYM/SGWzXQTcFrAZgeHWwnUuRyrdrTSYWcDO7Qt9rxUYskr8AjIR83OE/KRRDG
	 u/ARVj1yWM+/2X2lsQKBNtR+YrKMNi6PzB5ElM2aG+P2UDLjj0Zq/Ph52mUIkyap9m
	 F3rQKCoWhMjqfOeEQRXMeO0zrV7XjwrfADSDMO455tzgrfgB5NhlgS86B2yUUkBHbH
	 v8XrXZ9OfBu4ndkSOuZhJesrzDVKOBRy20uzRcijwkTS6E6tQfzybGirxgP/DcwPKy
	 b0xEY2tG/TaCAN9UY+HVSO4aEBvPraFes/YTVLlDQV5QG7KaiMK3eQp/ktZk4ufLgg
	 4w3yIfY8IipTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/25] PCI/sysfs: Limit pci_sysfs_init()
 late_initcall compile scope
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260619085200.3729431-11-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
 <20260619085200.3729431-11-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 09:35:35 +0000
Message-Id: <20260619093536.4C5791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, pci_sysfs_init() and sysfs_initialized compile
> unconditionally, even on platforms where static attribute
> groups handle all resource file creation.
>=20
> Thus, place them behind a new HAVE_PCI_SYSFS_INIT macro,
> especially as the late_initcall is only needed when:
>=20
>   - HAVE_PCI_LEGACY is set, to iterate buses and create legacy
>     I/O and memory files.
>=20
>   - Neither HAVE_PCI_MMAP nor ARCH_GENERIC_PCI_MMAP_RESOURCE is
>     set, to iterate devices and create resource files via the
>     __weak pci_create_resource_files() stub override (this is
>     how the Alpha architecture handles this currently).
>=20
> On most systems both conditions are false and the entire
> late_initcall compiles away.
>=20
> Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619085200.3729=
431-1-kwilczynski@kernel.org?part=3D10

