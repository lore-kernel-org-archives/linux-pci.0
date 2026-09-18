Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E403D4123
	for <linux-pci@vger.kernel.org>; Fri, 18 Sep 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789744485; cv=none; b=iZD2ozdwdC2YiTlryJQffL2JkWz6IoBPy2YjY6wXvYKo1up05adeWAxkx+bFNFC2abJOYIBr31hU8gnnUGnFIVI3a71SwLxnKsU1KIP/fkHvydMVicx7PzGLhggvvKRC8IF7W/YTe4Kp9NKp2k8UZmXaMuphnx4G3WKRCFIfWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789744485; c=relaxed/simple;
	bh=FdZCpwMnjJ2xGBE+eO8AzduOi4uc1FUuHeGGnBIfBjw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ifRPvihZ7oxrdl/UFpzwODFoqiZNFx0v3n5bWzwrHhYqFFIiU+8ekICXjPaHnfYJPjeFyuB12ZC0Bj/HkLfEX74aZGLjvIhQ3I8EztMJW73mzzJu8OK8w7PCxvB8OdgPSVNKTplu1T64kUgIEk88hmSVzOXAZ5c77HhWXh6hBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW3OtzpE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW3OtzpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941F21F000FF;
	Fri, 18 Sep 2026 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744483;
	bh=FdZCpwMnjJ2xGBE+eO8AzduOi4uc1FUuHeGGnBIfBjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XW3OtzpEcip7OBaKDwPDntAMuOkgMlFTTEE6NSy0C8suzpv4yJb//3cqr2CUW27Ws
	 hS9qvOjSZ8HU3iJo/o42hrdnJOJlkLyRWlkES6w7tX0cBL0A6dnjt9HTcydG6w41G0
	 uLtXV8gnSbbooVXUiwhRhcBmWIucNPecU6tyASlKH84PIHMuImooyPLdYkukofwU7N
	 /FKp5ZtxQPZHFrmSlkAS+Y2epH+b83d/NdUG1lloRtxf1Wf7FNwVOdz5zPpWH6zwuB
	 HS3Vq143bJ0G3LHaDngVzXtYdRRAfJSM3m756IVZGmpnnF+dgoAhTO5i8A7g/IOoD/
	 o/Y9X+FTwIO+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] PCI/AER: Hide the "aer" sysfs directory when
 AER is unavailable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yazen Ghannam" <yazen.ghannam@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260918145619.3016889-5-yazen.ghannam@amd.com>
References: <20260918145619.3016889-1-yazen.ghannam@amd.com>
 <20260918145619.3016889-5-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:14:43 +0000
Message-Id: <20260918151443.941F21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> aer_attr_group is a named group, so sysfs creates an "aer" directory for
> every PCI device. aer_attrs_are_visible() hides the attributes when the
> device has no aer_info, but internal_create_group() only skips the
> directory when is_visible() returns SYSFS_GROUP_INVISIBLE for the first
> attribute. The result is an empty /sys/bus/pci/devices/*/aer/ on every
> device without AER.
>=20
> Switch to DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(), which returns
> SYSFS_GROUP_INVISIBLE when the group predicate is false. Drop the
> per-attribute callback, since all four attributes share one condition.
>=20
> aer_stats_attr_group is unnamed and creates no directory, so it is left
> alone.
>=20
> Fixes: b4fe7398def6 ("PCI/AER: Add sysfs attributes for log ratelimits")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-pci/20260714191826.BA81E1F000E9@smt=
p.kernel.org/
> Assisted-by: LLM
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918145619.3016=
889-1-yazen.ghannam@amd.com?part=3D4

