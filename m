Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B603EA967;
	Tue, 30 Jun 2026 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819123; cv=none; b=k5AHSVhs4+0sQtsOdssHLCQ6+lQwsuv74dr2q+jBDczEKIP86fizi9zZE+kCo8WFweM7R0ixfyI/1N21diWQqiq1AOCpZwSZwJRFv+IhZ873MLpYdjz5/kQMuacBBZN8tQ1idGR0i7Ze65HH2vmLHYwJH8UP2Sd+zY5HN+yYQyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819123; c=relaxed/simple;
	bh=qw5eUodpuuhbgntKIhL27/6ojGdVojQhvgW3kPZO6z8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cwuQdVqmXH0rxhkH51OwPzTJKch3dEd8YJzQN5dRTYkBRjUWcvZdyo/5mwN8HwM0x9E0NgK2fi61ENlDq10uP+JAmmACnBBW7qCT9sJozFJUfRGHi7VWTyPw870oCfrYGJTqRK/rdjFwRT88eNoKhRcO00Mzc+aG6D51J69AFUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOD5rb/f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOD5rb/f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFB51F000E9;
	Tue, 30 Jun 2026 11:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782819122;
	bh=e6UWuCee3PVTFV11gKaFyBHMHcmKAXHf4jjgdE4xenk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fOD5rb/fBmsX0lZewMbsKHnm2SPmCGCgkx54A2B8Zn6iuVXc87ZeY+AxSCBV2ZyY8
	 vshfvwuSnZ5jeO/SzvAJBg0Sl5z8lUH1sv7/FgIKeeIiNEhO3Q8coTlS8CvGg1cbiZ
	 8toPes+fPcZhpENfaAfr8rUlwkZPNAYanoWprBmdu1zfKdJRv9BTGqY/QVGixi9Znr
	 2rU6a8JrUkKNkg83nFpcV2jdee/YrDDw3GTQGeJ57fFT5wKFFNndM/903ae2nmSU5t
	 Ne35z2i62ucu6xo46xqzcfWZBx96yo4qOR9gQR0pwfFzKo5sgalDhfXXmgEBQitKwY
	 7vSVwxZ1RKtBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/8] PCI: of: Remove fwnode_dev_initialized() call
 for a PCI root bridge node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260630102804.413563-9-herve.codina@bootlin.com>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
 <20260630102804.413563-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 11:32:01 +0000
Message-Id: <20260630113202.2CFB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> During the instantiation of devices described by a device-tree overlay
> applied on a PCI device, devlink displays the following kind of debug
> messages instead of creating the expected links:
>    'Not linking xxxx - might never become dev'
>=20
> Without those expected links, the device removal order cannot be
> correct.
>=20
> Those debug traces are printed by fw_devlink_create_devlink(). In our
> use case, they are all printed because the supplier of the link has at
> least one of its ancestor with its fwnode flag FWNODE_FLAG_INITIALIZED
> set.
>=20
> The culprit ancestor is the PCI root bridge.
>=20
> [ ... ]
> are correctly created.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630102804.4135=
63-1-herve.codina@bootlin.com?part=3D8

