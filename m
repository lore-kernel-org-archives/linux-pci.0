Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773A3E1203
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 21:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786053382; cv=none; b=WxTFdSIsog7f8mk3b66R9VtcX13wTSDLMRHTP8F5zPVHym3zP0mm/BQtUyWtnb6SYcXUAFEP3C+sxN/dgWnkrtHSbkFuOwWaoy0YGy/G883doDYbRRQe8EcNxdTIbWTVwUzVpXJoRulLC1VzVyhbDXXrviIWDOLqmjbM6RQHxPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786053382; c=relaxed/simple;
	bh=XYziaCo28uf7ZwP+NSoidVHFz3k5BswnDog++S2C5Vs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S4bBuLY5rqTVgdN0E36pp6fsSQg5pbHfCh9xHbQdKoDuRnVPd1CYfZUV06kCsJUMY5kdG4/y7Qr+P5LtqUIOwxBwsR6rtoPP0ccN5hmPONaqvM6YDJrWlKyzxGCpDviU51rW7RrxszBOkoPupGnbX3KaGd+S7pWTi06g6AV6nIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DUngYIO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUngYIO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC0D1F000E9;
	Thu,  6 Aug 2026 21:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786053380;
	bh=XYziaCo28uf7ZwP+NSoidVHFz3k5BswnDog++S2C5Vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DUngYIO/FbGYrRq3CD3cuTX33CiGw4hrogLOK1nwvFcQyGLdLgGU4nABYs7s+qGbF
	 Ih7f8e7XmHXf9jw3ydaGVlCiDx0m2bC51z2eiMDZjOCLMxDT5ziUfNL93HY5DCETBY
	 T9p16MhehhkSPdYipps41WMV4R1fEgZZtbwaHf00CpBMZbexz/lODvNkb9a0ZxXnR6
	 OsG97741MyyqVh/KHU9dq38j81DFLSUZkN5in4K2GilJ3VLTIjpsYx3MNEAuNj074g
	 zy2hGFfvddpeqaKG4A2YZHvDG6NCm0keZElkj6e78X5MHVqIVA2utOHYP2jPlqGELJ
	 9L9SRHcwM7oqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] pci: quirks: Disable native PCIe hotplug on MSI Claw
 A8 root bridge
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
References: <20260806214808.1202819-1-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 21:56:19 +0000
Message-Id: <20260806215620.BBC0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The MSI Claw A8 (MS-1T8K) hard-locks on resume from s2idle whenever an
> SD/MMC card is present in the onboard Realtek RTS525A card reader
> (10ec:525a), which sits behind root port 0000:00:02.2. The reader's
> PCIe endpoint is fixed/soldered and not user-hotpluggable.
>=20
> Firmware advertises this root port as PCIe hotplug-capable, and _OSC
> grants the OS native hotplug control. When native hotplug is OS-owned,
> resuming from s2idle races the port's hotplug/PME resume handling
> against the RTS525A's own resume sequence when a card is present,
> hard-locking the system.
>=20
> Two kernel command line parameters were confirmed to prevent the hang:
> pcie_aspm=3Doff and pcie_ports=3Dcompat. Both stop the OS from running
> its own hotplug/PME resume path against this port. The former does
> so by dropping _OSC negotiation during boot, skipping the path that
> [ ... ]
>=20
> SD card insertion is handled entirely by rtsx_pci's own card-detect logic,
> so is unaffected by this quirk.
>=20
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806214808.1202=
819-1-derekjohn.clark@gmail.com?part=3D1

