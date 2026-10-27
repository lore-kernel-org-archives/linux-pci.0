Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118406;
	b=KdmIgL+yQS9U+igTtTUEAKoLkkjQup2zEbaza/pRxyNCkyiTQTfP7a9nYG7mzBFB7hIg
	 cpC8hitjvTbUUSrnylyJdXSU30bUjMp16l3D89ixuab8EewxAwPSH8cPUQMDkRo/4Jp7+
	 2SF/AVx8ARbUO9eIDwvOIQ9l1iaTw3AffbsYqut4ZZueZkgToWe1ktD74zc0E2lKyOGcp
	 WOadhZ2s1iGHoZGPEYiiP2/xus5EdtgWjInYkWm6RAfB4juGLluJrmNml+FAVWT9K17tZ
	 gR+7Gxebkjz9mqo2BSFfhHzqJ8Qyx0jmckaWGcU6qCmCcNIn8X3PbALN5C6vsia/47w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118406;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v+jT1ar5EDEARWTrZzRXUSQAn5y/GjkZLhzphpIcRPY=;
	b=lnFwXHylsybRs/l1IzvM0PCf9H63fYBI5JAkSj4/GL14nyoccMEcQgUzbfG/fNG0SznG
	 78Na9xT6SOjfQkRSt0Fwk+4H1lirQOJgvHIl35VBLBEW8Vl0dJ498+bbrtu5UVNJY5h2y
	 vDPlgdO5thUTXcGa3PofUSsOf9tiNf4O6tnpBKwdAzPDEqRpwAqUrYOzOyTevUfhfQk5B
	 Ku77z/ACCq78w2AjRs2hjwXMZFDc1FLU2apOB1B+q2sHHPLAj9GSR4OpMeGmDp1JEoGXx
	 ZI55G/qRrrwVoATgsnZT+Kro06KjzHAK1OFNv1uti68oXAbAeLoa4T9dBCYSsB60V3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSQv9uqV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327BB606A31D
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSQv9uqV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88FB1F01828;
	Tue, 27 Oct 2026 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118405;
	bh=v+jT1ar5EDEARWTrZzRXUSQAn5y/GjkZLhzphpIcRPY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GSQv9uqVdOaGPYIewj+O0vdXk9QgFekBUgSsH7dbyD2SH11nhsQwnNAjw11Oj/GxW
	 bgNF5xVifjT2vfFup5epKLpqJy0dE0Q2nXn7YsVsHMv8n9p0Gnlu+bjDPHFmhFvvOl
	 WNdF16VRvXv3mxX7KDxHqbwfbfzYaFJmXWs0dIs8lssBpcVJkGYS2sxGXacTRDgoHK
	 geTyCW5LYLyRBpDYlCQQ9/58piDJ379FIlUZrgem7obu97G9ErA5w0JdCg0ed4+14a
	 vf9DebYbs+U2SS5cVztaZmhklYEGkzaRegDRMakAjOEj8YcSROcFK7gW2jY20CtXP6
	 E436fVCh8sQLQ==
Message-ID: <sashiko-outbox-186910@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] drm/radeon: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027-vfct-regression-v4-3-0e7190e39c2c@amd.com>
References: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
 <20261027-vfct-regression-v4-3-0e7190e39c2c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:26:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
>=20
> Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft =
filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-vfct-regre=
ssion-v4-1-0e7190e39c2c@amd.com?part=3D3

