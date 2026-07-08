Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BF32BB17;
	Wed,  8 Jul 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505287; cv=none; b=cXNIJlGBIzGKI40sfxPn5roXYYMteF0djjPpjvAse7jfNnESmJ4USEC8JACQHhL3qee+cQmCKrqscn/ZggGzjpmN06twuwHy7A23EMtn9bFC6CbULTROoFIdBf5qU/n/GCxIJh+9rD/XVtULkuUMp36GF5NjnVMtKmofpCLbSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505287; c=relaxed/simple;
	bh=XClyDRFNXXDfIBhavzFIaf1dslfu4te7pxS5A4xHWUM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FDdGPgplHJSbiYJ4AUdQ8cRIZeBOMYUQcjSrdxssGuCk53XO8IxkhubDFAlmRZmm/CMmhUbSOj6Ald1KAi5pHkaEjT3ChFoKUo+cl9EwbnlzxNR0OVvKP8VDEJJDK9I4VRB4yK1/aakQHJv2ItzKN1ms7lPwNza2l9aaUZ7ypgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiJzR9OT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiJzR9OT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041B21F000E9;
	Wed,  8 Jul 2026 10:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783505286;
	bh=XClyDRFNXXDfIBhavzFIaf1dslfu4te7pxS5A4xHWUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SiJzR9OTDnWgSOaU1wlnsyGvOILXVb+Vt9+RUo1m6PYi95XejKjGtn39EoLkdKR39
	 IJTFF6aJxRwNbzQGCFH1PYyntMJAoE63ZeTiGdkC+Ge6VmEJVth/g7SuC2O3Eb/Qbp
	 XEK3qH2SnnwSUIDDCSrqWducZCTgsxfCa0+Y05k+qNZ5bCbgdkf69id+KLLN9L3DkS
	 BUj+CuNfnuEyNC5lkn6XH+obcqgPNy1n3wfqG7SeaqxvyVHbbWjO56N4C15R821ohf
	 iWDsrCzE/HqX3Sf1Hd6Yi2YpobUAK0Q3qwySfasOHklijm+92UtipTb//i7310s49L
	 VXjTcdKDu+RyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/9] driver core: fw_devlink: Introduce
 fw_devlink_set_device()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260708100302.517792-2-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
 <20260708100302.517792-2-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 10:08:05 +0000
Message-Id: <20260708100806.041B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Setting fwnode->dev is specific to fw_devlink.
>=20
> In order to avoid having a direct 'fwnode->dev =3D dev;' in several
> place in the kernel, introduce fw_devlink_set_device() helper to perform
> this operation.
>=20
> Having this helper allows to hide the fwnode devlink related stuff
> behind the helper.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708100302.5177=
92-1-herve.codina@bootlin.com?part=3D1

