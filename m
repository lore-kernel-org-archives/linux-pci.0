Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA043F8A7;
	Wed,  9 Sep 2026 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788941690; cv=none; b=ncUtXIq4wVK7P7h2GtJADxWrrHyoVOmyxMGqv10MoQn7GymCvuVSvOUnnv6Uo8umL5jjpGsdE78jBiPNqN0DEU9hnMmednGNbU5bssr0UZPUrAMP6zbpJZiVJw5nu1wj3G2X36vxeaWBp45QEHgvTCGBD6oBB/qHWrtQ5cn+ylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788941690; c=relaxed/simple;
	bh=LjPu+xVxCckFtiDVLJSPXVB8jGzShltyzfDqE96lHB8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NvP4iZnURmt+gNpZ3my6KNODThJHIOplibpnS6I5F6JqfOHKnJOwRIQDEitOT1VR3tUzU/42G2W4EjCxM696d5Q1JTIwSE4AqZuDVN7891iNRpkD9ukLj2saf387EoK4CqaVNgUUDNSVfGhW0aO2fpuFfZK2iTFAA7Eezdxybck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNLm0eaA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNLm0eaA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57FA1F00A3A;
	Wed,  9 Sep 2026 08:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788941688;
	bh=LjPu+xVxCckFtiDVLJSPXVB8jGzShltyzfDqE96lHB8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNLm0eaAzK89guQfWqsHob4QrkbRLIvlAzgcOE1biCWPexNk4L5mZlXdHIIOI1ISA
	 U0twVyn4OhYOtvUt0WD6TbEOx8S7mpybxhmxng7+BQVujwAGzHg5gKEwJ/eF9v5v2h
	 LJj39xGX842ZxQYjYz1qD3NlCcELVMPxQ+4oArHLKFwdtlMyL6GAm3bHrKmjxm0MYs
	 V60pmi0PLnv+gw0VXd/5k0/zcleuVhgAtuDeMfd88XIHX0EOfO5Y5qRj/bCnEKVCur
	 gmaAoAU/BBM9ypMSsEBtHr1hsqeuxY2IZEAQEzdqXjqcSdFBZub9tf4NfNw77jA+NZ
	 PscQaay/vlykg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/10] PCI: of: Set fwnode device of newly created
 PCI device nodes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260909080114.591938-9-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
 <20260909080114.591938-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 08:14:48 +0000
Message-Id: <20260909081448.B57FA1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Device-tree node can be created when CONFIG_PCI_DYNAMIC_OF_NODES. Those
> nodes are created and filled based on PCI core information but the
> fwnode device field is not set.
>=20
> When later an overlay is applied, this confuses fw_devlink. Indeed,
> without any device attached to the node, fw_devlink considers that this
> node will never become a device. When this node is pointed as a
> supplier, devlink looks at its ancestors in order to find a node with a
> device that could be used as the supplier.
>=20
> In the PCI use case, this leads to links that wrongly use the PCI root
> bridge device as the supplier instead of the expected PCI device.
>=20
> Setting the fwnode device to the device of the PCI device allows devlink
> to use this device as a supplier and so, correct links are created.
>=20
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909080114.5919=
38-1-herve.codina@bootlin.com?part=3D8

