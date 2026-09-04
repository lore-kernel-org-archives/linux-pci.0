Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0CE28373;
	Fri,  4 Sep 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788485987; cv=none; b=ZmZwmOTUu6KDW7mhiCIJOdAvQ7Yp79T2D0mwSwmA/ob+1N60JYhX6AJEo681EQIT8hAlVXn9ib6ygUTHsVeP+1tvLiA1BMoGe8mO/hxnxZJnABjiiCYVMzrCmS/9SWeIcLF2tJPk4UNFX7OU5gRn0aRNvkAT3BiqNG8a/d05GwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788485987; c=relaxed/simple;
	bh=7BXc+MZEP69IhjLaFKBZOfL+z7cgd8mBlGRivMRGKvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AT5JVvn2CqHJqtKIUoGw3CCZrDuccGtZ+q2U5tPGH+nx5Ymtc4uZivdfA4o/lERu5PYUSEY5eEz0NTPkpo7bys6XkkXJf2F1xYPG7xBg7nn6u3vB0ZwpZFPKzeTOELAbu/inFIZHthbwvDUNb6y8rvJri/qxYEyYrWwc23AI8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzaD8vkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzaD8vkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B681F000E9;
	Fri,  4 Sep 2026 01:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788485985;
	bh=wHXcR4Fknosa38qio6l3rf++gqqxvDAnZxlkG2wo9tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YzaD8vkk4IhORpI3dtJGluBRsXPZ6Vi6PqG0MozpBc2y77SgOPCf5yTfI2MC7tuMf
	 5Z//wL2Rssu/eZ8esm0hkc9zRh1J1RBdL3+NIfe2eN/L1G0EAPvL5B0qhPhwRECrpj
	 aU7Wmgz+XyEskWMtKAy4BklKjGLAAqG/iDW5580hm8YHeZY+ydyCCcap7OAXc8Ohc3
	 5cOQdFAwe9fxHO6ivN0lZtJTJwVPTRhu+Z7bX8D9QT2IczNlbvSA+GEE0NLHzOUqLE
	 ap0dPSHZ0odwqVbbyXkrzfDMIOJs1hZXZliP04mawQtyQeNN1lKt6qyIV/XNae5309
	 +USpZfcNvmC3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] PCI: imx6: fix resource leaks in probe error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhijian Han" <hanzhijian1991@gmail.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260904012307.3434449-1-hanzhijian1991@gmail.com>
References: <20260904012307.3434449-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 01:39:45 +0000
Message-Id: <20260904013945.73B681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> imx_pcie_probe() leaks both pwrctrl devices and power domains on failure:
>=20
> - imx_pcie_attach_pd() attaches the "pcie" and "pcie_phy" power domains
>   and adds device links to them, but nothing detaches the domains or
>   removes the links on probe failure or deferral, so they leak.
>=20
> - A failure of devm_pm_runtime_set_active_enabled() returns directly
>   without destroying the pwrctrl devices.
>=20
> - A partial failure inside imx_pcie_attach_pd() leaks the power domains
>   that were already attached.
>=20
> Add imx_pcie_detach_pd() to remove the device links and detach the power
> domains in reverse order of acquisition and register it with
> devm_add_action_or_reset() so they are released automatically on probe
> failure.
>=20
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel=
.org/
> Fixes: 2c5768344f88 ("PCI: imx6: Move pci_pwrctrl_create_devices() to imx=
_pcie_probe()")
> Signed-off-by: Zhijian Han <hanzhijian1991@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904012307.3434=
449-1-hanzhijian1991@gmail.com?part=3D1

