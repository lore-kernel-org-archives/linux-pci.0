Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794236284;
	b=IdrJwbfWyb1djTxyxEpksGtxboPSSd5nlrP/fF3RdbaJxThc/r8y1NDh21dF4lwyEv62
	 hglqD3sgsO17hiSKflA2VupgCW8Gae4xx/6G0VXOXf/qVNv6TsCVwwLbIPdExV/tG0I99
	 G4SdlJjygjYZl+GaIj5+1Gh/j6BBKKZCEanPfuOTnN1warSmkE101dXtLXUKl2Qu9Z+7P
	 g6cpRxkMnDWnVbPz+teXYKut3V6FAfUzB9yWrIZhaAfTLZOiLIdEClfJWy64V2bdXC55l
	 dOCNPEGsHz/STK9+p6WD687aiXhon0XrpX8cHsg3/eFCwjYUIA7PCqv/N+0LjW0BHmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794236284;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1htrRmBMbFqS0FQKOSHBLw9QbjmjrwQ7ECDeEV8iOqk=;
	b=dAjsaJAq8thqYGh08rjVWcYg5v1MsxwCTPHrxeqI7USzD5N2d7mUk4XWXmMD/nBkArnT
	 STMHrNswbsBCjWrrC71IJtAPy8Sj8CoD3DB3oirBSf6R0ON6GRGW5+iXfC9ooJ0jYWZub
	 nOiMBn4d0F8AfASRt61wIOPCHXd9fEGhI+/wRDt+zXy94aA11X5/njHjDICGDaFrW7B7Z
	 DcyHe2xSLyCYhsSSRq5Sc45tpzij3P2sFKQlVT2BHmiDoyKpIjcuAhTZSWw5l4jJ96JlX
	 gMmDDHHakmn8GCKDkxvcE5cQ8fS2wdZVQP9hRysmlVAlOJqBDLDIUyHMsEwYNBP95mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XE/TemaK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFA606A331
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XE/TemaK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 434461F008A3;
	Mon,  9 Nov 2026 14:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794236284;
	bh=1htrRmBMbFqS0FQKOSHBLw9QbjmjrwQ7ECDeEV8iOqk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XE/TemaKUax/20R7Iz9rU1GR770acfmTGFDcYuXeNLrL03cvLfyauik/rdZxI2AUE
	 KYrMyDay4xqN+QbS+1xnhYpB/SIwqxInMdnJ8xnLTzSPCuv6y8kV4uiGiSTCZuzvf/
	 yRmowmdjldVF3c0WDmZevLFWETUWTikjD1A1/MjjGUmjFt+M2i0gUbd4qhQ7NYcujU
	 Bx9r+P1FS+WIVPdwW7o8rzV3ASZ735uC+nD6TBNSkMObD9yqSzxtYakyDrGqRWhgP8
	 Z64z1C/W1RDEvXV7GCOQwpTUn5zLk+J/lRz83828rj9ZYjESU9v61CVW6GhWFrREhk
	 xLxyiDZrhqmjQ==
Message-ID: <sashiko-outbox-205139@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] PCI: Honor window granularity during resource
 distribution
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109144553.2516-4-ilpo.jarvinen@linux.intel.com>
References: <20261109144553.2516-1-ilpo.jarvinen@linux.intel.com>
 <20261109144553.2516-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 14:58:03 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> When a bus below a hotplug bridge has BARs smaller than the window
> granularity, removing them leaves available[i].start unaligned.
> pci_bus_distribute_available_resources() then aligns the start up for the
> downstream bridge but keeps the end, so the size passed to
> adjust_bridge_window() has a sub-granularity tail. The bridge window ends
> up not being a multiple of the window granularity.
>=20
> Align the size down to the window granularity after aligning the start.
>=20
> Consider a hotplug Root Port (bus 01) with a Switch Upstream Port (bus 02)
> below it that has an e1000 and an ivshmem with a 64k pref BAR as its other
> Functions. When the switch is hot-added (emulated with a remove and
> rescan), /proc/iomem before and after this change is:
>=20
>    faa00000-fe9fffff : PCI Bus 0000:01
> [ ... ]
> of 01:00.1 and 01:00.2.
>=20
> Fixes: 9db0b9b6a142 ("PCI: Take other bus devices into account when distr=
ibuting resources")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109144553.2516=
-1-ilpo.jarvinen@linux.intel.com?part=3D3

