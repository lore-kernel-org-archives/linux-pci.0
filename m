Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484523;
	b=B9oWE88n2kcK7vgWnYYMMUiWpkAY9mOnpc6cBrRz9WrefvM4Eykuf90Rjr46DrIG86CT
	 J19IppgmSyaRibNl1xcNtSm3YD/mXzd628MEpNuLA38zOO1OAJLlExwHleuHqah1gcb1Z
	 xdwlVJucu3K/uDKCTZ2mEMm0cI7DX0o8xKHtDCs/lSakbEBTtUBp9Xln8V8N94h3ls/cV
	 3P6OY1C+OWtViJzj+IJpSTsDC1yzCEvIQOinhhVZ/qbx/bAcuYWMB0Hcd7rPOblztcMys
	 5vtvEKLKsTq4N6b0loJ/elMVQeiytwykshRShcE2OKtqW5250VbEStiNnASqc9nIDHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484523;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/sgGRyHFsCIEDui9tLBmqX8onTIM+Rf2BWhIEV4mC/0=;
	b=o0k6asDbW6DdMLdfDrc0EPocCYaf2sz+VDCxmfaXLZ2lDcmef+j7k1qoOQQtI+G8wIX4
	 YV7hv+d2wd3iMrGGEaVFuejUPswCoNWmuJPtfFS8StToxWEWBGfCSL8dhmZttqEfxb9QO
	 wQpOKiHQFe77Cq5CS+MzekBTberxxkO/8GsXlws4zv0296vP2BMt41HAC19jGbjBfRfnJ
	 eUceh6EXZM/pJootZit+NYbDugtNPe5UU464BoGqL+sbe6exn2NtqE7xCgRcIE29EesAp
	 zbboZv262VrY484MeYVXz/LC7kCvdTfd0KZReuVq5drX49tsVFYG+5efdZBaB7NqosA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Mor/zEQ4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D055606A31B
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mor/zEQ4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784411F000C4;
	Tue, 20 Oct 2026 08:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792484522;
	bh=/sgGRyHFsCIEDui9tLBmqX8onTIM+Rf2BWhIEV4mC/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mor/zEQ4HPw8JEoUlpah5dfWA/C2s1IKrTQwwUEs3Gd8zwjy2r4VYdPRJSedItDMz
	 5uN9MuTHPXqKxA2WrevCkfo/dXHvfhV+oR+TkrNtc+eg99uyG/zlF2to864Y/pY2t2
	 bICSmHQZW1LAIrSLucvbCkuGKHYOpr9gMvOBEJxBzTaF4/+nMaP2Z10XYZkQX1KKMn
	 lTtyi2ymMFLsuqZ4h5IVFKLPfc/5VNuseZRqM2RflFKT5r3NfYBQqvUxByQwTy4PuI
	 TbDOqelH4Fxa44a/6MoJ/6D8Qu2NB+kuUZUQQLIvC89RTgz/KnVE7oBz1QJni2sRUG
	 8nXSixEEusD7Q==
Message-ID: <sashiko-outbox-178530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/17] PCI: rcar-gen4: Assert resets when Gen5 SoC
 PHY initialization fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-8-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:22:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> common_init() enables the clocks and deasserts the power and
> Application/Local resets before phy_init(). If phy_init() fails, the
> error path only disables the clocks, leaving those resets deasserted.
>=20
> Assert both resets before disabling the clocks to unwind the completed
> common initialization.
>=20
> Fixes: 3283c4db6009 ("PCI: rcar-gen4: Add support for R-Car X5H PCIe4")
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D7

