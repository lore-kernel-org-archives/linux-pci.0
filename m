Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9C4E9C04;
	Mon, 28 Sep 2026 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614753; cv=none; b=ZvwNvhqHBnHAbkC6sfHdTZrldoaJ/9li1YCLJvNGPpImnEyBfiYVDUQhtaW3EJkKI1jJB3tY4l645H5kgWEg2pVE+N/6vsJQuHoTfcakYCnlWHKBIMMpn57hx2W29OCR1QJMAYL5jWhyCFbt7Y7XGswaD2xnabk0pjHPoGmWYUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614753; c=relaxed/simple;
	bh=aht0HsCJ+H1R+fyw4+Qpk+QI0KZlYLztgu6duYSxF+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A7SpjY0dDiQ3QHQB7rBdQU9MeSRmhYnaFp7AaD8Go72u32/Up34Mtz5JOP+2WB1hcc4eZsbJIUI/YVTWdpvxgWtAm2aIaQF4lSybPTv6buBIWdfilYA6CmXgpz56fVQTko/qrleY9NasO9GTZUyxm/EKwXHansQG7lQKo5tuk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC4XsEuc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC4XsEuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877EF1F00893;
	Mon, 28 Sep 2026 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614751;
	bh=aht0HsCJ+H1R+fyw4+Qpk+QI0KZlYLztgu6duYSxF+0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eC4XsEucYk537d0lTIv55tR8Y9Hj0K7hI1zJYEf9D2/Uv+pfW3o5utHPEEixUaRix
	 s185PfIFTAEIBpOz6guvC5K78WbSmcgIwKF6aWyHKbJeVGr/5fQt+J9L4ct/q5//Fm
	 Fq8kKN/BAOGAxzlrsbXzoB6QI4nDPwXIasbqFAMIflasb8HOuSGtgA1VDnNfpiz2+B
	 xUU+gTgQ/h5R9cCwxPtkeP1AsJEeP29Pt45/0oxdADhr2VRp2WYSzk/JPfe5oxs+za
	 ULsLOivqJ+LG135mEG3hB5OBWkwX+24pMJfH2rJ41LOfCBas2HtsGEv1sk2Tk4cvPI
	 xkvMTpasoRW0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/15] arm64: dts: renesas: r8a779f0: Describe the
 PCIe AER interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260928165230.3397664-16-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-16-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:59:11 +0000
Message-Id: <20260928165911.877EF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe controllers report Root Port AER notifications through
> intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
> respectively, separately from the integrated MSI receiver interrupts.
> Describe these interrupts with the "aer" name so the controller driver
> can use them for Root Port error reporting.
>=20
> Append the new interrupts to preserve the existing interrupt indices.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D15

