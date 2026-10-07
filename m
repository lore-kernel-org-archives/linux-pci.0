Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416EC3EA66
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 05:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352419; cv=none; b=US+FHTdRZqhqjYUvXTCduo1WTlJ67evQox0PABE5uRAdcBoBJ5r5o1WvDvMArl8+LL8zv87qWg0R5Vm9fRw25+gHWTfljO4cnZaBEODn0znpiC2g/9TnNlHzwJjYioA0GstnjsvrlXuEfIqYn31b2lafyft23YesnUKSODq/OGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352419; c=relaxed/simple;
	bh=GzZwY1oka4nLigA3gacdYxqKZU/X6jNo6IrysuDWjVQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SaGhqt/rBmgIF4ufArwKSmGeqLTy+je/SEQ+bzOBRo4GmF3EwC81X/OjTfaknO7IiYUbm9BghdzYVmM2PXYZlcw4SrW6CiKaLQq8rgb9tkGveA/Pw357x3ihDJYK9VXj5jRZEzMEKOCtmWOt5viLbOwakZdoQQtSs6BS1YltmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X5Tavwan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X5Tavwan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CA91F0089B;
	Wed,  7 Oct 2026 05:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791352418;
	bh=cuaKNRESejD0iblKiGhEtzTi4Qi21TyPF2VWUjyRqtk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X5Tavwanx2p3ESJBTVSYdw5a29NZ9wzZO0QUGeEJV9h+rU43OtvkH93pivg9+6HYg
	 zTvb4/V44Y0BpRJcc26Al/SmYAhFjMy3hFRbzA+2hiDlZHr9qspaMkL3QGHY41QyFr
	 GiyuRMZtwi/SlR0wZwL4lDoaq2v07Zv8UO1b0cMFdMbkAj1+bIoE1iI9nbRg3Eq7RG
	 krP4gNBEt7SUoFPDzL7prd+kTlzeZnQqKHHHt5Ux1DTfdFPnIG8lmK4AHc/0MNiW3I
	 H/ZSnwbGLnkcKT/lOQb//2C6rRJzohbmqsy0dCwTHh0vifL6xC3jTtVwdogOkfhUmW
	 VxitNUP9yWNKw==
Message-ID: <sashiko-outbox-162652@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/9] PCI: rzg3s-host: Fix runtime PM handling in the
 NOIRQ suspend/resume phase
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261007053645.1391545-3-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
 <20261007053645.1391545-3-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:53:37 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053645.1391=
545-1-claudiu.beznea@kernel.org?part=3D2

