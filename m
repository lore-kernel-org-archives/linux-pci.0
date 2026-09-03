Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925DF3612EF
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408069; cv=none; b=MredeOsYsLy36DQGB6NVx4DGkRFPu0nUk2sfeLYjer/qYoen1nIwpNbYJXTvPGDc4QihYsqteB/HDw3S+MX5c21lXfo1pwtT7+6NOVNhIOc8VDd+r8J78GnxYuPen2Oa6YByENwiujptqRwmEkLp6uMIchI5bMC/fLx4pS/E8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408069; c=relaxed/simple;
	bh=eKLKgQA6/R4zjJ1ckzBhbxuzjTNRSOq4V10MV/RGolc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zi6/VTbJaXDLq1IUtRjmXYbO2qoDFHQgEyelHitTqEeZiwlwxQKAdY8/AmTx3y2CHjwiqDf2a+zM+AOzyg08R4/Y8cQyV8YZKhnra0/gO/2MJKvssy01UEULn2/7IEgQI2xvrFNY3DM/abjvdVYjJ455ARYNfWttW5Ok2f4Kq/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l52LwIAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l52LwIAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0831F000E9;
	Thu,  3 Sep 2026 04:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788408067;
	bh=eKLKgQA6/R4zjJ1ckzBhbxuzjTNRSOq4V10MV/RGolc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l52LwIAZtuH64ll9u/EHP3O3xukaYIAJrPZJHs2xlnIXKp7TgdP4A2OaOgjlezlq8
	 UFEFHTObz00ZFWBTG+cEVWaZn8sARFUzi2mXtJL7NhjkxWmLqkvYsay9UQiRUpTOnC
	 6l/I2X0y9/X4YwLmtJZPEocDBe8VonuNVd0/eOBJ84NXQvt3eXtYMJW6XggyOfa0it
	 gpjZaKA4a8yW1iP4BlZnTLJCzzrhkR9GMLZllq8eDj0Z7ggUm6EAm/LAsrjq4J72I2
	 Cwvz9tDj6vPxoXiJxb8NBNsraCZE2VepIK0Cn5lf95fNQexTYaywA/xFfp1RnxFnCm
	 uBKOIYYH0V/yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/6] PCI: Validate ACS control bits against
 device-specific ACS capabilities
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Wang" <wei.w.wang@hotmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <SI2PR01MB43931558B27C956BDBDCE0C6DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
References: <SI2PR01MB4393F337A792CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB43931558B27C956BDBDCE0C6DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 04:01:06 +0000
Message-Id: <20260903040107.3D0831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The ACS control validation used the kernel's full set of ACS control bits,
> which allowed users to request ACS features that the device does not
> support. Because hardware silently ignores these unsupported bits, users
> have no indication that their config_acs=3D request was partially
> ineffective.
>=20
> Validate the requested ACS control bits against dev->acs_capabilities so
> that only device-supported ACS controls are accepted. Mask the capability
> with GENMASK_U16(6, 0) to select only the currently defined ACS control
> bits (0-6). Higher bits in the capability structure (e.g. the egress
> control vector size in bits 8-15) do not correspond to control bits in
> the ACS control register. Add a debug message to report which unsupported
> bits were ignored.
>=20
> __pci_config_acs() is also called from disable_acs_redir_param(), which
> passes a hardcoded acs_mask (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC) that
> does not need validation. Gate the new check on !acs_mask so it only
> fires for the config_acs_param path, which always invokes
> __pci_config_acs() with acs_mask =3D=3D 0 and builds the actual mask from
> user input.
>=20
> Also move the check after the device is matched, since the ctrl bits apply
> only to the matched device.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/SI2PR01MB4393F337A7=
92CB3258C2E073DCB62@SI2PR01MB4393.apcprd01.prod.exchangelabs.com?part=3D1

