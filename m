Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794982953;
	b=hTYhXHbkFuXwoBhMXn6jiGTQwlzny/quEIhFaiV+9V15JFPiGRN657VmBXJ0/vMj3ykH
	 AOZCGqDKEjOE4xKKLanCcS80rP6Kchmjss5vlKFNJEBONBj0rlAjnaIBvk04mn5+WhQHb
	 RgPWFoPKDy9Ufy0G/5swReEfd2X2/NS1Qi1xDaX1UMY0H5I/r1hkYOlsV2Vgkm9w5egNp
	 xvlwTlMEFTWYNlQG/heB9kQa4rMG3Y0DY4wDDIxa6fwnOxb21XJwp2PS0A34yz6D1ke2F
	 1rRFDnt7SmeLnzSsejH4P//q8qSiRCqMgJxiAT+ZW4+rwUULeu+0hhc+fjFERZwHQCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794982953;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5qvGevppyORFINrIiKWRwEC5pW9ZVAN1DMYJdGdOakY=;
	b=3TYUzkJV8r/b1zjM9kCx2j9KKow/Qvh8pNrGA9XPGovLAocjHTGAeJd2WFSCUkAnR9nO
	 dozBHohEXhA3ZONyqeELIaOjgkVlJTLGnZkleX4LN4Al26k8nXtTBmplbHpDaeyAS8Pfh
	 tkG7WOO/MxpqMbK5C3rH/CTX2KCJjUX37MNo9wk3MxrRtRqB5VybrS36TAo07TPzNi4Uv
	 k31INcKI2sy5PPwNBl0Xo0gnCOu9vGRJghnycL9qFcGyN3JgWNCPxybEchEsjAhkWO4KG
	 LVQWlxwseAEfzJOn6r0U3rrdZq8Rnk9PaDD8NlMTDauVV9vgfPyhSUWwZb6PboqBhBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVfYaALl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD82606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kVfYaALl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8BF1F000C4;
	Wed, 18 Nov 2026 06:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794982953;
	bh=5qvGevppyORFINrIiKWRwEC5pW9ZVAN1DMYJdGdOakY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kVfYaALlgYr4Xju+BkZH3H/ua2K4U40ZOYYYP1+3Oxu3BTESwg2qLTfT1sSWgEI/+
	 Q7hm1XcQoDTlaIJZQPZGkeoi00mpck6IMjMA/ZBck2dKpv/mF6SnsyBA4b2ke1hxKP
	 jgx3cd8xMTFYcK9He12MoSW54nmTmoSF6tMKWCvwL0go0FcD1e8wMQCaE9bGRb0KT0
	 dCkV/w/Gp9jpqWY1+Sa/a+ll8AatYGDAZEg25FpLk3Jhf4JUEPfT3Yo5EleJYzIumB
	 y1jknMvPaZwEbH2JIGWSJR3/oh3UJ4lh+6iVEAPyCA+bjRkmrWq0f+lJL8lb83XF19
	 GFl+4ZONqP/GQ==
Message-ID: <sashiko-outbox-220236@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Fix pcim_iomap_regions() error path rollback
 and leak
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261118061809.2327-1-lirongqing@baidu.com>
References: <20261118061809.2327-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 06:22:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> pcim_iomap_regions() has two problems in its error path.
>=20
> First, the rollback loop walks every BAR index below the failing one
> and unmaps it, regardless of whether that BAR is in the mask this call
> was asked to map. pcim_iounmap_region() matches devres entries by
> (type, bar) only, so it can release a mapping that an earlier
> pcim_iomap_region()/pcim_iomap_regions() call made. The driver is then
> left with an __iomem pointer that has been unmapped and a legacy table
> entry cleared. Restrict the rollback to bars in mask.
>=20
> Second, when pcim_add_mapping_to_legacy_table() fails, the current
> bar's mapping is not released: the rollback loop starts at --bar, so
> the failing BAR itself is skipped, and the mapping stays registered
> until the driver detaches. Release it on this path as well.
>=20
> Fixes: bbaff68bf4a4 ("PCI: Add managed partial-BAR request and map infras=
tructure")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118061809.2327=
-1-lirongqing@baidu.com?part=3D1

