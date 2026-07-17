Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623C527B32C;
	Fri, 17 Jul 2026 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784300807; cv=none; b=Q+NAXj39OuVrLM2Y4iohnJlS3I2LREL5T3j8KLJmYNIViDs88q+EjRMPeAI5Bbgqj/9ZRPKftY4IBwWYtKF54Il31LMvJPlXJN1XbK+JEmttTQmbVdhLVdQkgO4ET+/J+vGaSBN0bxJDhDX82Blp5g43JiUmqY8L43Bu3Uhp4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784300807; c=relaxed/simple;
	bh=xqePXw8KLC/pWpGLS78mSceejL5lczDvK++5fdvkPhY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EXYubuKJM93S/xY6eAe4Y46K3pns0a5O8Ylu0trqcbbAa5dZxcEwtiea80lKNUQHiCHGN1NS70PypLphoVkazQ17191npz3212HdGyFMFi5xqQb45eDftOMxok50igSLN1C70XPpUd2B42LtWOy6ufVVa+nnKxIhpPzszp+IzSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl8Hf/wh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl8Hf/wh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477251F000E9;
	Fri, 17 Jul 2026 15:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784300804;
	bh=j2M9Ig71aObShf0X4BVU5xwzwbApMZx3HrdD1cxMkHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gl8Hf/whdYPBOiHrwrNUFz0ui4vM8zjbWoTGsxcqPKNgEkuHmoJPl1c8DrgiDhvkc
	 BOvgWsKQzmAOChWnIQCWNA3PAlpFZ9q8FrXFxiqoI0w0CJeRLmLqvd4kxwyhc+7fl4
	 iVjkphu8EvrVAWS8eInf4JsCFVkNr4a10z+0Or+pWfqFbZ36HBoE9F/7VokyE9uoox
	 vBq21dlNTOq9QTW6ClOH2sQorNLUy32L377Bz7J3/KXA18bN2BNiIPZAhuwJgdBil0
	 H3OfmaBT7IeeuVfGCdCfLF7qq6xVdv/YiejE4cnT0r7R351hZLNuWhcQ+IDFZUL9DY
	 rB6QvCAdO9p5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 07/10] PCI: of: Clear fwnode->dev during root bridge
 node removal and error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260717145147.823749-8-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
 <20260717145147.823749-8-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 15:06:42 +0000
Message-Id: <20260717150644.477251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During the of_pci_make_host_bridge_node() call, an OF node is created
> dynamically and its fwnode device (fwnode->dev) is set to the PCI root
> bridge device using the fw_devlink_set_device(&np->fwnode, &bridge->dev)
> call.
>=20
> On removal, of_pci_remove_host_bridge_node() is called and calls
> device_remove_of_node() which in turn set to NULL the related
> dev->fwnode.
>=20
> Later in the removal sequence, device_del() is called and runs its
> cleanup logic:
>=20
>     if (dev->fwnode && dev->fwnode->dev =3D=3D dev)
>         fw_devlink_set_device(dev->fwnode, NULL);
>=20
> [ ... ]
> error path.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717145147.8237=
49-1-herve.codina@bootlin.com?part=3D7

