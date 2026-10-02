Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A990463B8D
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939922; cv=none; b=jBHgZyv2EtwuuVdJmDudIssRWSOWa93aSUWhXcD+dzyfAmn7pfCb8NyJkxKdDjiVoJt0JyyNSayz//bSItf/LUDbbbZV7c0I3lz3neQx6D2cYYb5cI3Zf3nZ/ugfH7vu8aSDqBqW+a1GeGmhPPwvbEfVXXNx97f3X62gM0SANV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939922; c=relaxed/simple;
	bh=6ZX4Bg4U0z4ynr4D2nsJvMlTXVT0Njuvr9sM9pConnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PsAA6aMA1F8KKhXmBO1MfRr1HxdwuPjhMUCPz0tstjih2IKe0TBLlxBk+1jCEPmkNUWyFOtcyRsHbODOYbNWhakFGNOgpf6FwlOU9mX4GsAa6DZOJuBCLiY7MwVL+yCOeC7zmBMxeREEx6SviVHkZdqmmWdIniNZZoqnSqdo8Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am+JFMF2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am+JFMF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976A21F000FF;
	Fri,  2 Oct 2026 11:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939920;
	bh=GxFOH5g6F+VcWEVkbe9eo4aYC4WvPrcI8dq+F2NxzQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Am+JFMF2rBGouScydhV9y1oP/V8JYoVnx9pKDOPn00eLvidRBo6nLLsCxdYS9OyTq
	 O0rBm1KrYNnFnJl/Y+vJoKg2fa4dEvTbT7TTbtWQw9mOAI0H7Cnv86YvzELpo/qAkj
	 eNgNianKmdlZ1iT1/xPfImuRiUnCAwXYTzd9eUoAXyYWA0pwnCN/cUesfkZ3aDvhKb
	 ibmmlMCS15sWifi6DhqoxzpwRTFGeulfDtv3Dagd/iNjYP9Gj83CrmWTiP7DMv60xm
	 pdP+Mvdox8GPXZwTh8+QKKu/0EUXuTt2eW88oXFoBk2LUB7kMzBw6X7yIpl83DjuJQ
	 vqXRUyNNyHsWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] PCI: rzg3s-host: Fix runtime PM handling in the
 NOIRQ suspend/resume phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261002110935.2004349-3-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-3-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:18:40 +0000
Message-Id: <20261002111840.976A21F000FF@smtp.kernel.org>
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002110935.2004=
349-1-claudiu.beznea@kernel.org?part=3D2

