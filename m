Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBE45516F
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699489; cv=none; b=IEbfIc91+0iq9rFA0XSuyC63IWyMLfAg1UeAoaYiAZ8Odqm+R8NvrL5t9Cgq+wKyvPuWF56IjncXLxgxrJyTjAE2sYT7L0yUnKFIlo4RNXLI6ZB/TkkDVNGhvEWPt0apMpQVWVN0r8dJUBAHumywYqSGO/cJKqMFfnVpunnzY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699489; c=relaxed/simple;
	bh=rUAqwrms0PkoPimZz8+EAw7lZ5556vlDFGPt2l4juKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BhAid4dUxYNw50+hg0ZXfENHLuOV7fQkSlgbH6BCFwrk8yU1UMYelE8/3SbZrYjTdiPDgHstbf5bCPZomhfQrbVb4HWI58O4BKw/z+AfY5tzOCRZe3oA70KB72XcKJGAWZ5oufZrri/zvX6WQC2vJFTdU66T731PnBAccrTFzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq2ljg21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq2ljg21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF671F000E9;
	Fri, 14 Aug 2026 09:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786699488;
	bh=m2+4X1cvFlzzZa4nAwJjtkO7zCeFQ34pcL0nAd0glto=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kq2ljg21Eg1qyQgHTMd+5B7184nvr7deBv8Z8WH2tLDeveiPtIHeuCj2FlLz9wpuv
	 v9+THU8dy2TBfCWRiIlInltAjfIwQNDwpHEK1nGCWHrAHfSWZgqFEGF7Vl7SR0fHMf
	 SoQbOrbREpoR7t2ea5lrmATuuzLmwSnkBPnMIDqVKVVpNf1bLcBUUtzl98kyEguWQx
	 qUsjt57sy3YcuB4bWjojPw34Ri1heMVIREwJkkIBfGAStIY4IDtWgNN5MKGznmBRHy
	 M62XbV9eXgnW6UvriGSQau4MWkGXA1IEW+VEQ5vTlDaBdI0LzOw0H/rJBJ83ag9D8c
	 Rx/uT1NX3gxzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add quirk for ID mutation of MSI Claw A8
 cardreader
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Wunner" <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <36578f6e0829bbcdf68659ffad27b65715a97768.1786698126.git.lukas@wunner.de>
References: <36578f6e0829bbcdf68659ffad27b65715a97768.1786698126.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 09:24:43 +0000
Message-Id: <20260814092448.4DF671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Derek reports a lockup on resume of the MSI Claw A8 if a card is inserted
> into the onboard Realtek RTS525A cardreader.  He has root-caused it to a
> mutation of the cardreader's Subsystem Vendor and Device ID:  Firmware
> sets an MSI-specific ID on boot, but neglects to reset it on resume.
> The ID thus changes to the generic Realtek Vendor and Device ID.
>=20
> The firmware also incorrectly sets the Hot-Plug Capable bit on the Root
> Port and the PCIe hotplug driver interprets the ID mutation as removal of
> the cardreader during system sleep (see pciehp_device_replaced()).
>=20
> The lockup is caused by the block layer being unaware of the hot-removal
> and waiting indefinitely in sync_filesystem().  That is fixed with a
> separate commit for the cardreader driver.  However despite that other
> commit, the cardreader is still hot-removed and re-enumerated the first
> time the system is put to sleep.  This is undesirable because it prevents
> [ ... ]
> Reported-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Tested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Closes: https://lore.kernel.org/r/20260806214808.1202819-1-derekjohn.clar=
k@gmail.com/
> Link: https://github.com/ValveSoftware/SteamOS/issues/2473
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/36578f6e0829bbcdf68=
659ffad27b65715a97768.1786698126.git.lukas@wunner.de?part=3D1

