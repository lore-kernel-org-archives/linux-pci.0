Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C073C07A;
	Mon, 12 Oct 2026 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815854; cv=none; b=f1fLGCqC75s29jLv9LYQRNLKv+DglPNeS1RGAVQD+yC8BD02vWTZJW7lF9OXrvooit6SSHp8uw03DbuHs5vTmH1YMWyMVfBETyr+8FSxFw+E9wbhUlvZ+hP9eYDiH6glmOnAfTSuTcTiEZoryNPQdM5hkGsM0zvuKvNqI0Sgwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815854; c=relaxed/simple;
	bh=ltjGmxaGIGT13Wa59fVdC88hLDR21C2Q3xXYg1/ANac=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gg+fyBHqLLYjui43UpqeZr2NAl0RPkfuo/+bdsPuxky01BY5w7z8yAlTfxcQCZJ5JyI312GINfIY95+mPrZC1huEYoNbpqq0yo1gtu1sN80qJCHk95pJHnYnRUVlXXUNAkBaJttvHgrMD6fV+fxFEIKTk0a6gtWDJvQDXf1hJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0bgycju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0bgycju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00E01F0089B;
	Mon, 12 Oct 2026 14:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815853;
	bh=FbWHLuIhiVeVC6Iz++nbZRg0RbIczCgKHw6OfUQ4AQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R0bgycjuquD6Kd/k3+91olNBVVusDVR5bzUOsUj1cZY/7Eo9xru+2NNm3fL3oFMam
	 QQ/DBILtyE/cgAPPdClDGUjTB4rkrUk+lX7QnDCggv2E2XbNDX8RF4rWYB1Gh8U2wK
	 L5NalfJGUtI/Ju8Zlwuo9XqZuJJiRk5ekRja6g0IyFuJbBhcGQG95gbosAFt6nrGdq
	 UGHtHTjNCCxhjZEvIkRfNwPmm4RJxqxS2tZQqUdUX0dUeHWQfBa+7jsGOiIDkeyMI6
	 uvNZulujy5+itnzuAwdxb4gATVbdR583ha15Tr7aN3BVSMdtmWThIn7DaS2qVP5lJM
	 TsxmxCFPYY7zQ==
Message-ID: <sashiko-outbox-168273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 07/10] PCI: of: Clear fwnode->dev during root bridge
 node removal and error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261012142826.159178-8-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
 <20261012142826.159178-8-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 14:37:32 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012142826.1591=
78-1-herve.codina@bootlin.com?part=3D7

