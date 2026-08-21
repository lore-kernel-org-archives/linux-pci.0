Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCEA29CE9
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341924; cv=none; b=L2UFVQSRGWWYPWYoIRAtFWArGAA8Zdw5/FzFTQZ3TDtsJxT4AZ3TGylFYvz4LHcXWdoLlBmsbCdVke55X7K36rB5y+/MQsjwH8T77oSMFnJY5Kh7u3VWXDg7b9L4CQLkoO+Sm/lQQ4UjZo0rz34RFlaHRFVdkAGIc0ZCUFBgH/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341924; c=relaxed/simple;
	bh=XS1D0ETm9KV7E9V+YW4oVd6rkIOh0jTmvzidgcEpNH8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZHmHBeQX67Ow2l4V0wnP3hDo0b4aVicZ8KiPbarn6OzzXQemgBuJnbPpNneKrRl9I+CWJpRIyclzhBC+D7MVNFtIIoUHvhSanzHH2fZGo5Z0KGJcHX047xnoB29GB9Gzzu0Z3R2fxINS/XZKf9doNkCyXs1WZFVB0xMxZs4jK2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G797gogw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G797gogw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23C41F000E9;
	Fri, 21 Aug 2026 19:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341922;
	bh=XS1D0ETm9KV7E9V+YW4oVd6rkIOh0jTmvzidgcEpNH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G797gogwYpk3evP9HOLcFfWeNyHiJcuTW515ZYM+xB92Nz+q1m6Fgo+PX5BqXYSTY
	 85VbYcFDPJeKRdgoxz8MMT71J7NUqDm+KXvSfisrmbevDaTCKSYZQFSHHRwz3dePgX
	 6qdkfLu8bJtNogGwsJwxkhIg5+g7bJUsDosZkzWD3uE14UlUrWZ3m8ib1RYHM7ZIgj
	 NBRoZ3EWsYPAM5liB0YdbIklQn3QlLnQX0fz7GR13l/9AVKMqr0gMitNnVacI8Ax/Z
	 lKjopZ5jWcbWwkPSwthvoWRS3xnl8ILT7oxqgGcA36c3nbcObf8XcYy0l+vg/BYUjl
	 96gCVgYzzdKZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/18] PCI: Add KUnit coverage for ACS isolation
 checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-17-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-17-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:52:02 +0000
Message-Id: <20260821195202.B23C41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Direct Translated P2P and Egress Control both let a peer request reach
> the peer without Request Redirect, and whether Request Redirect still
> isolates depends further on Translation Blocking and on the flags the
> caller requests. Firmware owns these bits, so the combinations are not
> reachable on a given machine.
>=20
> Drive pci_acs_flags_enabled() with a fake pci_ops supplying the ACS
> Control register and check each combination, in both scopes: an
> Untranslated-only caller such as pci_enable_pasid() is unaffected by
> Direct Translated P2P but still loses Request Redirect to Egress
> Control. Cover the two ways the check gives up as well: a device with no
> ACS capability, and a control register that cannot be read.
>=20
> The function is exposed under CONFIG_KUNIT via VISIBLE_IF_KUNIT.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D17

