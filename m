Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E71338E129
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 14:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088840; cv=none; b=DVRpk49xlB3BUpbfDeGniJmOqEnbCqzCGvC2PWK1wJAUpXlo27o1ZtNN4sdeMFkFU73fbjyrhs3AeRJOyEBhX6cpzxtoyGFCOAcx5xImhOM91aEEbqUVOFh9oepQpMkFsbYt1E1pfexWpC1g/S8M0cLvhv12EGNlfSBYbICFw5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088840; c=relaxed/simple;
	bh=wtgpnRBzsLqDv/xOqAxwNGLU58e1iebyp4+nIUreZhc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKu/pU8An1FosFEjMBMG+DGzI//HOZoc9KBIAg+rgqzZAEqZyFbGcaT8I7dzg7xjdQIiQW9QcKJBUU/iiBz0hC28RDsEPss928sEy+s08txkQM0OFJlQD7WcksMZAyb9F00SJMO+NKY1uj5B2EFeyKbQXXFGzlLNaPI+8ZxDDik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmRUZ8Wv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmRUZ8Wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8291F000FF;
	Tue, 22 Sep 2026 14:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088838;
	bh=x9ic/v0wys3WBvnofEWVuW7JUsztU3PD2EUcNRtI7gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jmRUZ8WvIhjO+P1duDAf5bpKqLZeQF/IdMh3zV70II7cNht5WRaZyxjjW+qjeZRf4
	 j+fAZoYeryDBt1dUu8Q93m8aJQ6hBA3G9DVUMjAiLNa5H7UYU+9OaFE77u8jPP+zDa
	 TngDqTlP/Vq3JwIDF1+WB57wVawhvp0qKGW7Psuhw3+BVOr+m31m/rzgVCfS9cPwDc
	 OUMdKtBiUcYy48IV17byrT5wUcmaDG1Q7uDVyyCPZLl7Jr/6hXygSI9PRPXSi97mrQ
	 AwZrXr2ZutWTuputkDyQDxp2atGbxhqDWqCqdMs9Wjs1I0wwyUTOClw10A5ScoQu6a
	 1OIULIJGM8ZdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/8] PCI: rzg3s-host: Fix runtime PM handling in the
 NOIRQ suspend/resume phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260922144629.586997-3-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
 <20260922144629.586997-3-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:53:57 +0000
Message-Id: <20260922145358.0F8291F000FF@smtp.kernel.org>
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
> domain callbacks to power the device off and on.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922144629.5869=
97-1-claudiu.beznea@kernel.org?part=3D2

