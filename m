Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013B489887;
	Wed,  9 Sep 2026 08:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941088; cv=none; b=M1QxXpQwzX+5NM2NhsNY48zN/mW+4yLPoFYKSPmdm39lCX3A0SSVuTh4xLAcRiGsm0xvEOR1ywXSFtLX0e0iK05Qe5VWVqQQlIpg+AVp4olUvlzKTbKt8uogvMP0YEQxar+WFk+EkjceYc6kuD3Ik9MpdLEN0s93US0Pkx6xkuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941088; c=relaxed/simple;
	bh=V+OUzFfm/b9RKym1++zuIYg5iGbJfZaHsedqYTEyRB4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KxHc8l8FXi1r4SBZZsdx1e8z7CH4yixFCODmg5P9UvNTL/OgdVvjpKDMH4519bnZhBQ6VF7OQh/KEqUMqCGlnO7xO/emobvgMc6LqNKaV4hn46AZTcHfilB6xenPSSR4KEskT3+d2XAkoRaVTi/e3Cnl0sUGtp46/YYWWs7wNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7tgRIcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7tgRIcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25A61F00A3A;
	Wed,  9 Sep 2026 08:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941087;
	bh=V+OUzFfm/b9RKym1++zuIYg5iGbJfZaHsedqYTEyRB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n7tgRIcQ2IH0DLWdcXvzGEN/82j2su8ePMeHoFVj/Me9hX9El2J8nXfMLHF66C96A
	 /ZGrISaTyNEs5JUKM3SAykJHCSqqLkE742VPAQ9hn07u1cp4ZEj1HzMhkmBcbOHWnv
	 NUO/i+0JdLZPg2y6YRDJYTZoFLQhUjUhtNlrH9US3WxOQsUN7SILdVFo2QxqbUpQ9Q
	 DGR082CdOP7o1wtOXFbeVFiXOXYmuW2I2mO4zRzv8tTzi67hpGG/rhbRGEjJxdy8M4
	 cVMvy9ynooM0lDLRPHJzaPtq4RZJu42Fyd1bOUmGKlOoeqbIWEBHXwRwfOj2T0+E83
	 dZ5n530hnMwew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/10] cxl/test: Use fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260909080114.591938-6-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-6-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:04:46 +0000
Message-Id: <20260909080446.C25A61F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The code set directly fwnode.dev field.
>=20
> Use the dedicated fw_devlink_set_device() helper to perform this
> operation.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D5

