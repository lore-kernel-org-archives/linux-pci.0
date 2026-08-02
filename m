Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92092489874
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785686835; cv=none; b=Hp9SGshtB4PpqtD0KXTpfeqWTTgeb6YCAjFOxtlG7TEm+6qvAI7NDXDVnmmaQHq/CK2smHW9GPlpsnap/3ZuK9ArHsv/JP7J/yvR1yyXJqZQoEnVgy16+cqzT0Qv7Bm4b6fp64ti+um4ncl0WcsdxDtYh0AN7qgImkjO+8PzxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785686835; c=relaxed/simple;
	bh=tzg6bWRVFDMc2VkZGTwgCMg/iEsA7xCetYpUgDQlRE0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Dae7m6qj+KOG1KuvZFjrDlH/fdcRsjZtuIuZgXxomqzV2YM1uGMrVrmlEaL3lV3N/sxuRVQoI6LS13RWnvCy9DQerBE5jjCoIISSrOLlSXgI58B3J/YJi0ACG//nO2+Lm6kgEnTcA6xdd2VFNIxuEhXbedLQ3y9WmjVOBBtlg24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLpSpBZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLpSpBZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050911F000E9;
	Sun,  2 Aug 2026 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785686834;
	bh=tzg6bWRVFDMc2VkZGTwgCMg/iEsA7xCetYpUgDQlRE0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cLpSpBZe8Qvp0n1O8YipPlSm2oWIVDvXMk3OnEZj4R8Pd1oGctjLnZk7hFrODLFIj
	 aVvWpuSIs6fBbpmhMGuGfR0Cpvy3A4wE5EXsI74fGptzTUVU9tVbbCXILTovNI6kns
	 k8EPX4HfMAbOMbdaUl55hCa2+pYXRBhuih9JAykfDg17Lq6xFKXO15DZ3Zhbfp1qZp
	 Ztsvz7Fjd2dzj0wBbV5QeOHW/+9XEgX4jXwggf7o3nsz9ESuEUOQq51UTq23YdrYz4
	 X6c4yQGn89FZgaw8Z18/HuZLUPXfZbaARbtpnDRjVNAgCtN9iNvFr5xITKHS8KvZBy
	 xYc3/WNVjHPQA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/13] PCI: Add KUnit coverage for ACS isolation checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802-fix-p2p-acs-v1-13-a7c5eb64fff6@nvidia.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-13-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 16:07:13 +0000
Message-Id: <20260802160714.050911F000E9@smtp.kernel.org>
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
> Control register and check each combination. The function is exposed
> under CONFIG_KUNIT via VISIBLE_IF_KUNIT.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802-fix-p2p-ac=
s-v1-0-a7c5eb64fff6@nvidia.com?part=3D13

