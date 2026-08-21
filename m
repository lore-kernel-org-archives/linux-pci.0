Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF5383306
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341755; cv=none; b=IAClDt4uv+awhbSy0XFvk/8kvWkwF0CJ49Nt61CeY7SDQXq/ETj4Cq3zr6ZrNdGNorWQnYvMwLIpakdehMjBZ2SadIFxC7ZWj3PLW95kKWEdlJIgayQk6SmBExD/vqxpkZC9HqSY7sJeYB6LJrUoMsPRIGpJWmUHhPDJc6e0K+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341755; c=relaxed/simple;
	bh=7pCcUpMvlamwTTPB19h21gFkLt4s1Y2aIJ+OUaoMr0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=puIN42aohO/Yx8ajlzWyFu/v4BlGVUaxPInJ1Bk2x9zDlNaxzVkUzulsHfWWDaj1K/qr9wndut6uG4Ta/bE88zGti9g33sfHp6JZk7+EZmQwPbBqVjsSq/QwyD1eFjc+eq24Mtr8UnR+lgM8nZFYmxN4khQKK7wIf8dVzLWLzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8rziuiU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8rziuiU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144131F000E9;
	Fri, 21 Aug 2026 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341754;
	bh=7pCcUpMvlamwTTPB19h21gFkLt4s1Y2aIJ+OUaoMr0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f8rziuiUfJD6Pezrk7UEr9mPnPatIei7AYvbbH7MX9bsDfPfWFZcOuyb3xpVtAYAw
	 WZGqKya9JKzMMgB8YOAeuswfImN9SeuHolsVrCSBndfgmI7+OAZlWtmpxctlOckR6Q
	 Lg8f4Gw3r5PFWVLY8LyhcHAZPiLen8k8wJUGB0FNH29rfV67ohzxdOw8ExKtXRs67n
	 UCe1/byEKTHd2vfUeMcMnc+ccX3bfHaDl7+DveyTudA4sv6+OvWqKpt78b8TjwY2EV
	 Zs1U8A08HE4wb04MKc7Q0tA6jvghntNeXz92onPItHiZfL8OAbs2RNY8jszD9sPO9v
	 JjgJX8cSA4xcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/18] PCI/P2PDMA: Extract pure ACS routing decision
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-14-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-14-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:49:13 +0000
Message-Id: <20260821194914.144131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> The ACS routing decision and Egress Control Vector size calculation are
> mixed with config-space I/O, which makes their branch-heavy behavior
> difficult to exercise independently.
>=20
> Extract pci_acs_p2pdma_decision() with explicit Request or Completion typ=
e,
> target availability, and vector state inputs. Extract
> pci_acs_egress_port_valid() for the encoded vector-size boundary. Keep
> config access in their callers and expose only the pure helpers under
> CONFIG_KUNIT.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D14

