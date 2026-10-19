Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E53485CF7
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393039; cv=none; b=kkxTFe88MrSoJIcg8rLmiFlr4h53xEZqwcwo8mDjXjoSqX04BeZe1jlPqcVt3eMVDKRgFat7rNaklBWGlp5QvbeRoRgZseQJc/5caEa+TzqpmLLU/PIBIufHa/eL84C3qmg1lTlAzuy531RzgYKKWyXEGE5jjLto+zTdA2Xmq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393039; c=relaxed/simple;
	bh=9TOyxc2ZPOYF2SRd/nUthSAuEKdVnMHPcyoGjHB2iq0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UkkagILH3YQpM5P+YMYOG47MbR9WFEyZCMTmN4AWJN5okXvMzvctHxu3AyM2r0kkzanwjNSmn1l4gXF3sH8WTckXKd+IIb8g4wz6YeM5un/iwsmZbYuCpXayXV/SiEf5d2mUpIDbHsYn+yIow9yxLuO8/RyncQ8LESW4gR4qLpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH8It6Ao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH8It6Ao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C631F000C4;
	Mon, 19 Oct 2026 06:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792393037;
	bh=mS7/pOLrJN19yfPeN9sui2UgHsxIPFcNGqVYzCZIJ2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FH8It6AoOD8T7RpiLORYqHij3H2tTMFSvT4iS/Lj4AisQMsXG2oslOe/mWca3fjps
	 J9s5UaWZNCyjV+UP7UC8oqftNjuV4O4MnYfIEDPpJ2idINYJyrsfjwfQS12zW4fFTE
	 a6/3hMOrpu1XtQDr7gQGw9G9PZHed38AkcWbJOmduLSl63iCGv/554X6C9IA8AeZ+0
	 Lu06QMSdSdfGiQb9bJP/Drdt0k1cZ0d+drw07arb025+cvHpJfsJRIUaEk3b29VlCg
	 hOitoFr3vcdWke4SCVI2qvFurpxPSsdUTNjZtn4inak/Q9pEFD9G6oH8aofkaObx29
	 TQBkePO5bMqKw==
Message-ID: <sashiko-outbox-176722@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/14] PCI: rzg3s-host: Fix runtime PM handling in
 the NOIRQ suspend/resume phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-3-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-3-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:57:17 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The runtime PM documentation states the following:
> - During system suspend, pm_runtime_get_noresume() is called for every
>   device right before executing the subsystem-level .prepare() callback
>   (in device_prepare()). In addition, the PM core disables runtime PM for
>   every device right before executing the subsystem-level .suspend_late()
>   callback (in device_suspend_late()).
> - During system resume, pm_runtime_enable() is called for every device
>   right after executing the subsystem-level .resume_early() callback (in
>   device_resume_early()), and pm_runtime_put() is called right after
>   executing the subsystem-level .complete() callback (in
>   device_complete()).
>=20
> The driver's .suspend_noirq() callback is invoked after .suspend_late(),
> [ ... ]
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D2

