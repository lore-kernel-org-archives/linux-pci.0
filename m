Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301851;
	b=NP9pytEn2tt8CHpjvmuZkDKRPZ1pl9JHvxUjS5P/OUWWZGy6VJkO747tY7qvHjr3BUwX
	 iuP2byHDeMGltt/x9S8GSVUPsIqAHn1AINRYXvxFwmYdEWBajqvbScKOv+Y3t1VZ+wjr3
	 NGxN9JkRJF39B1fYQnKl+hq2XqZRfcRJbFzTjpeTDtp7lw0TQg+vJEMdwGCvpH97SBdQN
	 HsQdJR6PrSW8X7018uJxZE8oZVvFs/XkIu/iI82vwotY9ypDk/cX0/lIxL9/EI41Be7zA
	 VVtXrDqcgT978otBQzuuaXTyg/Nba14B7JPUEkU1FPUxof2L5iyBiFIaFSn/l+gOBog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301851;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SJ1jh5qYu25e5WGwCNVuWcA0KA7eHryK6e08Xt31220=;
	b=f9St21iRPdRhaUdPuRJ18OHExFL+k9rqyrnZH5aBGcs97L03WjYnT1QoPsJk6ftcTYBa
	 gfY8zXk5NQsFcee79krFZK3F6jg2qxgC2OGlbod/rxyuJ/EhKny3SRsg4ptk7jRqhOH9O
	 v/BZREd2FEIA2m5eNB5zS+ZjX5t0Lc8oP356vUTntS8ZjesopZDproiWG4QG+JRUxP0D+
	 ks8Wyq+9sbgfdIUadZE53aWYnJwNyc45mly0+bUmNtvOGXp8vT33afrNxUllIArOdZKY+
	 /YPZ+F0JF6J20eZPSjwj/9ZEUMKa4PwsWWuhPQVzMc4UXoojLCKX/Fjw+iy6e4tzG5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ua89wcX1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EF5606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ua89wcX1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305EB1F01816;
	Thu, 29 Oct 2026 19:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301851;
	bh=SJ1jh5qYu25e5WGwCNVuWcA0KA7eHryK6e08Xt31220=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ua89wcX1ivXmilUotY8vQOch1CA65dhYYZ1uQsJ35h8DMPlkz/XsVMEMCJCYi3mZt
	 JapBeuiy0/8C/ikxoscSwgdAfdxSy2mGkDafMgNDQov0yd1WhLuZPjpp2w1r9mqQCc
	 UyFq8GLEyEfPeGCG4CR3dNQNHENTFCbqourHzZYweSg+aQ+gYXAqqbn8D7pwKdqYuA
	 lWDGIzTWyi20/SECUi30957gY3l5wHkx5Aethk06zq3rh6BzvWEE+rpLKdeexSiKaJ
	 ozePIn1oqjTS+4MrAVTMhspKq+ECziN46sq8KEHg9X0YWMx03cZsBpl0EOlEuc2l+e
	 DG5qFz0+FA43A==
Message-ID: <sashiko-outbox-189871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] PCI: Add disconnected device checks to user
 config reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029192032.1325629-2-thepacketgeek@gmail.com>
References: <20261029192032.1325629-1-thepacketgeek@gmail.com>
 <20261029192032.1325629-2-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:24:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Since commit 4b1038834739 ("PCI: Don't attempt config access to
> disconnected devices") the kernel config read accessors skip devices
> marked disconnected, returning PCIBIOS_DEVICE_NOT_FOUND and ~0 data.
> The user config read accessors still issue the read, and if the host
> bridge completes it with ~0 data and no error, they report success.
>=20
> Check pci_dev_is_disconnected() in pci_user_read_config_*() as well,
> failing with -ENODEV and ~0 data. Do the check after waiting for any
> pci_cfg_access_lock() holder so a reader blocked behind a reset also
> sees a device that was disconnected while it waited.
>=20
> This prepares for converting sysfs attributes from the kernel
> accessors to the user accessors so they keep skipping disconnected
> devices.
>=20
> On a disconnected device, existing callers of the user read accessors
> now behave as follows:
>=20
>   - The sysfs "config" file and /proc/bus/pci ignore the return value
>     and return the same ~0 data as before
>   - pciconfig_read() fails with -EIO
>   - VPD reads and VFIO config reads fail with -ENODEV instead of
>     returning ~0 data
>   - VPD writes fail with -ENODEV instead of timing out with a
>     "firmware bug" warning
>   - VFIO writes to PCI_COMMAND fail with -ENODEV, since VFIO reads the
>     current value first
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029192032.1325=
629-1-thepacketgeek@gmail.com?part=3D1

