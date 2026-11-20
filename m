Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795162502;
	b=gIjF0zW3EXKTXfDL+xNSnJL7Kl0Fk669DDQg+OR7d5eYP1b3td5WpNC/kf5XnZooppQi
	 IRyCm5I6PgSFyFmZt/QndyFvk6+yWsvObS71g79GaI1jfR0qHFHouw26iqPxKm/yG6/eb
	 fxWT6m4mtmBHjX1dNrtLz4MsgdKd2pqW0Hs9XDOAififvBi48YinBbGFDdkp/HVtEyftH
	 D3BYE86eAGwvlsXRupwknCNuCqQDrorLQnalqC8rO9gLg+zKf0Ow9Ohtotu7btnbYdKkU
	 PW5OjqlrgbLXIRoN2toNhr7iAAgDDSFEuv8bTNQs378hohXykSuTE6HSfszX37U6H9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795162502;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bp3Zua/ZoAGzsr0InnP45LWvK1EzQKzbAYZW5QkgjMw=;
	b=o7iOqAlD2CDmVvj7nZDZnz/lRVyzMACOJWyE17T+QEOEPGngjQmYfsov2wPrqf5fA5xF
	 1g9kvyH5Tp3jiHXcOHMAWBGKlBnySLyZesLBElq2XhavBor0OuI6/eoxa/74NOWL/GLqD
	 aWjlhrtuoNjXoAbR30uMhha2PHgoFLJ/jh2w2Tu58OHH9FP149wXmxIIhoezDyuooRUl+
	 hWnYStOXIr/gNpiUx7mlXfOgi8yjjIFcjaHTD2+OnqCKFn6LUMF1pkRAOJ+W+FoM1p5B4
	 6C/ejmViuJgnEqvf1YcB+jVTgMoaGfPqxkMHLo7wa+IiBz+bhpKVXHxSw4iFKkpIEkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUBpeFBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD8860A2611
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JUBpeFBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2091F000C4;
	Fri, 20 Nov 2026 08:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162502;
	bh=bp3Zua/ZoAGzsr0InnP45LWvK1EzQKzbAYZW5QkgjMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JUBpeFBBcUyBCP/3aDvFGdEsmKASKlPf1l+2wDWaaVf8JgA5l/1lp5oU3S/MDw+AF
	 TARN6g3LqkAyCQ0GRsS/UIQs463i4wraU41zI5ooCrstVTRGS3LjINXOrhTM5aBwEl
	 dGQCurL+lFnCB0LR0p99zVDsOSmNcnIY0lO2LLm1iH4JkuYj7s/3lnuaYTo7pdPxT2
	 2ljDtwfBDzSgV9xMTJgi/HaGQuGYdGhDOwtiZscZgePq3MBMQG+APXUvVJyRUg9/Nh
	 i8NePPVQG2irzmIeWDTmeMzS9k/w2snVUJgTdyX4H4MB1y/ZaooaDN6j50oti8nPLj
	 EgHQk0AEtwi1Q==
Message-ID: <sashiko-outbox-224695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Don't block config access while waiting for device
 locks in bus reset
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SW9udXQgTmVjaGl0YSAoV2luZCBSaXZlcik=?= <ionut.nechita@windriver.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120080031.56565-1-ionut.nechita@windriver.com>
References: <20261120080031.56565-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:15:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> __pci_bus_lock(), used by bus and slot resets, locks the bridge and every
> device below it with pci_dev_lock(), one device after the other.  Each
> pci_dev_lock() takes the device lock and then blocks config access to the
> device.  If another task holds the device lock of a device further down
> the list, the reset sleeps with config access already blocked to the
> bridge and to every device locked before it, and every user config read
> of those devices sleeps in pci_wait_cfg() for as long.
>=20
> This is the same problem as the one fixed for pci_reset_function(): a
> driver unbind of a function held open by a vfio user waits in
> vfio_unregister_group_dev() with the device lock held until the user
> releases the device.  A bus or slot reset that reaches that device during
> error recovery (pci_bus_error_reset()) keeps config access to the bridge
> blocked meanwhile, and lspci hangs in D state.
>=20
> Take all device locks first, from the top of the tree down as before, and
> block config access to the bridge and the devices only once all of them
> are held.  The order in which the device locks are taken is unchanged.
>=20
> The trylock variant does not sleep on a device lock, and the unlock path
> releases each device's config access and device lock together, as
> before, so neither is changed.
>=20
> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120080031.5656=
5-1-ionut.nechita@windriver.com?part=3D1

