Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC3C38D3F9
	for <linux-pci@vger.kernel.org>; Sat,  1 Aug 2026 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615602; cv=none; b=posjsEGTp4J4YPO3xvAh0rhmOIr2tjng/JGGczhr8VZkAh0r7KOsXyEhxJlIOfFKarM0C0iCZzPZuHaUW+N+IUG5KCAAdyMQQx/Md605I/Qkh20/2O91mFlT4XRHdFRxPyLz5bqIj/d4yiZ7VqermeBOb1MkQxmttjmSPFQOFxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615602; c=relaxed/simple;
	bh=9F43h7PNRJoWhR5kjaLti8mZ+p0J55cQyEdMpywFjcA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jXW3VguP0nIUr+kk1SIBB3Tl0T2dPstf/J9K8sYeG0Ye8D7TiPdouoU3p/fBdnrhi5352LJ5WtRokhp7hFEomsc71ZujqdXQ/foMv2gghrQZ+5xZe0bFPduDp/UVyzk8+C83/Lb9dvJnOdZVF+CDFDBgSqrH/ikx6kwXJBfoeJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg5PJIV5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg5PJIV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18D51F00AC4;
	Sat,  1 Aug 2026 20:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785615600;
	bh=OPI/biYHawpfyCbtXfvMp1HEs9zXqkdoSFnc+l0YDZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Fg5PJIV5pKk0Y5Zs13WCY9923zuplfFRJitDEqRvDQtU99o0I2Ku6iRP7jGB3eqay
	 cE3GwGQEbz8PwzW/VQ5veJq2c5uYU1W2Ldw/Pwz8ZHcTa89voSEyKxY05nXc1axEzj
	 wEITmNOz6M4cuoW4td45ybqi6N9hX82MgbN60mImFspS2yBsiKxcuwBRieWHFEo6xH
	 AwbeNs3bE8TypzVMVS1rmmL9Uwvbpi+udVLy2nEP9LHyXFxTJ/QXESC8YjqYvNViuz
	 BDPUjHdahKoDBClzNp5w1nOKRpnJkyURby1156/6iuglNc8bTr2LQXHd9K2de5Nvo8
	 tB14vS/x+WIVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: Skip Target Speed quirk on clamped ports with
 no link
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Wild" <andiwild@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260801201244.4421-1-andiwild@gmail.com>
References: <20260801201244.4421-1-andiwild@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 20:20:00 +0000
Message-Id: <20260801202000.D18D51F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Maciej W. Rozycki" <macro@orcam.me.uk>
>=20
> Since commit 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe
> failed link retraining") the Target Speed quirk lifts a firmware-imposed
> 2.5GT/s restriction on any downstream port, without checking whether the
> link is up.  Where nothing is plugged in, the retraining that follows can
> never complete, so each attempt costs PCIE_LINK_RETRAIN_TIMEOUT_MS.  The
> quirk makes two of them -- the initial one and the restore on the error
> path -- adding a fixed 2 s to every boot.
>=20
> On an MSI PRO Z690-A WIFI DDR4 (Intel 600 Series PCH) with one empty x1
> slot, running v7.2-rc5:
>=20
>  0.541 pci 0000:00:1c.0: removing 2.5GT/s downstream link speed restricti=
on
>  1.541 pci 0000:00:1c.0: retraining failed
> [ ... ]
> Reported-by: Andreas Wild <andiwild@gmail.com>
> Closes: https://lore.kernel.org/lkml/20260801092152.5643-1-andiwild@gmail=
.com/
> Tested-by: Andreas Wild <andiwild@gmail.com>
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Signed-off-by: Andreas Wild <andiwild@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801201244.4421=
-1-andiwild@gmail.com?part=3D1

