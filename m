Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258759;
	b=SNwd9zoAgswCoY8rjR6VPrVltkLqvCAJ5BEL85YR2Ez/J/lTv6t7iTSwd/BloeGCuIRq
	 plu0w0eexW6aQvcAVskIy9yq2N2VZKoRkluroMaYfOx3g7zIybKfHXhSna/8cmSSpqT7X
	 drX/I4k2d4XyJ6DmRd16ox1xTAJRj2nGsXb9JUUChIVG7td5tYH3PY5LljvGHVbCU+p1V
	 S0otputFsWaK9sc1AjR6zIYSnjgyHSUdLaFcvqmOaPsa+lzyhqztby5VWynGjw40nPh7P
	 Wl+Wg/Y1PD2LpJMW9E6WGGBfn4xeDvbSzcRkdzCso3SY3JGtPNH3xssyRK7COoVdxxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pIvnnrgrcOHCVcUPQah9vPyt8usuAMFlxxoFaE8t+mw=;
	b=MTtWfX3Vg0Yn4EUgmg4Y21SlK2f4R+uQD/t1izKzUCTWWAq/jOMXmVlH+qUiElo0WM53
	 3qYUX+lrUlXjZpOHSvr+piELgrBEv2AXQUMy6v/sC7U4YXOXwVuwiFTs5xNPBDNOKMQAy
	 bwI8BoKuzGi2aJGlFEvyd9jv2F/EIeIeNr345/Kozm/MCSY/SHJl5CM9KMA2ukaSxtplC
	 5L2Gq+gZiEXbK4vj+++fOujI+GJReBZNW61nZfQBhg7Q3w6TdS4vpErqyneoTH5sdZkR8
	 LPnuNRk2vFCnHmpOPAW21Nt6tAeHdC0ru8RAxinNh7APvyFREfLJYjTc+tYNBtSDvCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6M96Ths;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD7606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6M96Ths
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B1C1F0089F;
	Mon,  9 Nov 2026 21:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258758;
	bh=pIvnnrgrcOHCVcUPQah9vPyt8usuAMFlxxoFaE8t+mw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B6M96ThsGp7rHqkjx/WgPgfFScsT1xtivcP2cq0W/uG0+1J6hLd/u+Q55JmPx4a4g
	 U2quAdrbTYmVquhiMabTu0mZ5vEeIcLHYZO0dmkjUfo7LNrkjvQtSqIZGT7kx6Ksw/
	 QFsWS1J/Ahmq5PgZ0HbeLnczOv85r15jRd7Cca42iyHR6jt7fE6u09W0x4dO3wJgMr
	 25NSHJzmQ65CKyu/Vjvd5NqmrfK95zYKhY378GD3zdA3sPu+ZFM+PWPpJM0aw9NUNM
	 OaBK5WqN9IgjO8LX0ThiFaTecXinxpCUCCUYb/4InoTYyCDuqD6LmK6WPUumFHILh1
	 wDVdQcaO+PZJg==
Message-ID: <sashiko-outbox-205640@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] PCI: Fix off-by-one in CardBus resource names
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-5-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:12:37 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> cardbus_name[] in pci_resource_name() has no entry for resource index 6
> (PCI_ROM_RESOURCE). As a result, all names after it are off by one: the
> last non-window resource is named "CardBus bridge window 0", each
> CardBus bridge window is given the name of the preceding window, and
> PCI_CB_BRIDGE_MEM_1_WINDOW falls outside the array.
>=20
> Add the missing entry.
>=20
> Fixes: 65f8e0beac5a ("PCI: Update BAR # and window messages")
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D4

