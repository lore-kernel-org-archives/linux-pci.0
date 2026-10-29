Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301893;
	b=ojdCSFQME/V8xWiPmQQ7txINuSGiTnRBGxR5wtlWQISVvd9JYTPNoGOtMfmGmWNJnVmI
	 lx0CzzmCV3+i+RHRHDyY3+d400ClyraUzFErza2zdYqt3NU5sY6PtZxp3anonvuimmHZp
	 whYOH9s1cw1yS71JaYjG7jzpxs4ekCOJb2ifYaYdnu85q1ffD70KOaV+xJIXSngo/jpOc
	 5RS999vPl10NFlX8TEeiqJqBMKHMqVIn3X0xjbYGarhAZ7MvrrmqwLXoNldHxETb7kWnB
	 Bdpsr1qaR/sa7DTd/4hDb+QUJiIUcALtwY+pycGFJ7L6J/dAEXO0UYTfx9CcCAQ4WyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iHn1Kx7ZRTJp3w3C/HPS2RFL58IifG2L82teHwy0AnY=;
	b=Mg62FsFQ9QXmMgJnCOhSRHxf5RmpKKTADavE56B9ayZYbvXyQCSPYglXMhzKW+8/N4xV
	 8ILYhKNYzh4MN6by6IuPtI5rNlVZ+DCHEge7hAH507IaUvExLEW3li6dsCb/V5pX225fy
	 ko9R3XvQSQs10ADJepZxAshAh5mCMTiBG57WDIicdp1jY6zH20APA2L8M6RgNcYaQ2yl9
	 y7v5k8GgoTBL7zTVDfLpIIwQmnh2MNxoivgHDsxHXxgMN4NNGganEyKyudMTsN8gXYE/i
	 Mcx0EDRdnYDvLgSIRqhBJv3EWmE83ZL6yNTxEe9+1R1gmtp6p7egjnWDBs/rot6l47A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbi2MAUN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68848606A321
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbi2MAUN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A871F01824;
	Thu, 29 Oct 2026 19:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301893;
	bh=iHn1Kx7ZRTJp3w3C/HPS2RFL58IifG2L82teHwy0AnY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kbi2MAUN4XdwZuC36xGM6gxu0gkByUUo8Fq1KAkU5pwQVrDVtB0oppk2UvYHWcaJW
	 VxyWPH2D8lnOw2sqO5yCxbtc7epLrO9k8NolJjAi23GamNUo1IsmXOmLhLGF675RY8
	 D1gddnbZx6H5HL+2/m3bF5wE9PDKtyBq08Z2qpu50xbbQX1YXrcEtXVrNFW4TsUHxO
	 U1PRUdOwMJbb7B7EoxZYfQ7zXDCO0idFfGkEfWyiwoB0rswG3+esQofsTee1c0XfI2
	 4Pcb+X8Zy6CAKKjgRyz5ianJzyn1PokvtBMrhPzHxP1ZEJMIAIjA/D2Dmvj/hXXvWv
	 mGHqGCGixO5Kw==
Message-ID: <sashiko-outbox-189874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] PCI/sysfs: Use user config accessors for
 serial_number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029192032.1325629-6-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
 <20261029192032.1325629-6-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:24:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> serial_number_show() reads the device serial number with pci_get_dsn(),
> which uses the kernel config accessors which don't check
> block_cfg_access, so a read that races with a reset goes to the device
> mid-reset and can fail with -EIO or report an all-ones serial number.
>=20
> Do the capability walk and DSN reads with the user config accessors
> instead, as the "config" attribute does, so each access waits for any
> pci_cfg_access_lock() holder (e.g. pci_reset_function()) to finish.
> Also wrap the reads in pci_config_pm_runtime_{get,put}() like the other
> attributes that read config space.
>=20
> A reset can still start between two accesses, but the next access just
> waits for it to finish, and the DSN capability is unchanged by a reset.
>=20
> Add a check that both DSN reads are successful, unlike pci_get_dsn(),
> and fail with -EIO instead of reporting an all-ones serial number if
> the device is disconnected between the capability walk and the reads.
>=20
> Unlike pci_find_ext_capability(), the walk doesn't check dev->cfg_size
> first. serial_number is only visible if pci_get_dsn() found the DSN
> capability when the device was added, and cfg_size is final by then.
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029192032.1325=
629-1-thepacketgeek@gmail.com?part=3D5

