Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996D4B04BB
	for <linux-pci@vger.kernel.org>; Sat,  5 Sep 2026 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788625278; cv=none; b=bPvdlfvRZzQN9AY8uX+vYa9m3g1u87yGefFQK6wmTIE+mL9lSUKXHbK3br19ifvWcannvphW3i2jqsll3wwcQmKWsKHqTR783MrmNqwKz85WSFJxqFyvnUnM6tHvGUllpWykyFEi3sAAD7qyR/ybfyFObYE/RKNiy77wVWOrAZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788625278; c=relaxed/simple;
	bh=LOTLeCu6en+5Cl3V53wYHkmt2VfsAT1PAsW1c24rouE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=krb+xQM/DDuqJdYlhi8eVxeURS7ZvUiQTEA163+nfdm+go0o/uvUr46j+N3ZEZY589uVYYJCWpMQPiQj4v/7BW4Y7Y6SL6qf/hiCybnV/iSidTxnHL/lXGYiYRWZRHFcH/pzlpzh/HYC+R2j+yXu1BWBV+NH2VRPaWUbfU5qbU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyOQG1kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyOQG1kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DFE1F00A3A;
	Sat,  5 Sep 2026 16:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788625272;
	bh=LOTLeCu6en+5Cl3V53wYHkmt2VfsAT1PAsW1c24rouE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LyOQG1kfahWvNIMrjCkk69Lgsh087kzGWHw+1DMV/zPeZZYw6C0yUlXjAXVxoclhq
	 bgJGjuYOueaqN+2mP3pWGofk2+L7eeU0qGtK1khCn74Tsz07Ej8jDIBiphCxtP+EP2
	 ZRbx56rTbfVR0D7sBh+ijRyGj2Ur4yeOg3poPhs2y85k5eJLWBOW/PkPUHfLU/dOwZ
	 0GtGQh5juIQYmpQKUq2SItfB2WXUWvebUjjl/ID9iI+n2xRIe7IyAwh/5oNaDEIBR8
	 Hz+5oZR6+zFNfVdZsBl9cUfuoZjhd7ZncBiOu4j9kf7UvHr6xIz4nqWtpEZ7Pkmdvl
	 Gvwo9isyYuu9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: quirks: Fix out-of-bounds MMIO read in
 mellanox_check_broken_intx_masking()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260905161743.5766-1-raizudeen.kerneldev@gmail.com>
References: <20260905161743.5766-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 16:21:11 +0000
Message-Id: <20260905162112.39DFE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The mellanox_check_broken_intx_masking() function maps 4 bytes of MMIO
> memory using ioremap() with a size of 4 bytes, but then reads two 32 bit
> values using ioread32be(fw_ver) and ioread32be(fw_ver + 1).
>=20
> Because fw_ver is a pointer to a 32 bit type, fw_ver + 1 advances the
> address by 4 bytes. Reading 4 bytes at offset 4 goes past the mapped 4
> byte boundary. This violates the API contract.
>=20
> Fix this by increasing the mapping size to 8 bytes to safely cover both
> 32 bits.
>=20
> Fixes: 1600f62534b7b ("PCI: support INTx masking on ConnectX-4 with firmw=
are x.14.1100+")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905161743.5766=
-1-raizudeen.kerneldev@gmail.com?part=3D1

