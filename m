Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106782;
	b=EB6aFFGUTbBFfcFsGbLgmCDekFGtsn+2dtFmGop86Nfl2Yjh98tDLOQeayA5+7i6GDoX
	 BeLj6F697HU1CSJDdJaGcWA4o+jTktTh5ZNlOqGuClS9VmLhjBjEgVNVp6wDhAVJYSvmU
	 bE3t9CTXlZyVDxi4ejT35OOVPfKlaUVe69lNXIrO6/51XXCg701IHFsabI17ucNHwzVuX
	 1qlvwTt+ySYPkx968xJMbv4qXxjmIbaoXTkuPeMYME06XE76UvreNkXfbU2X1jDbpHs+F
	 I9B7pEbMMp+hx45V0Y3xOKJXWyzgqHNS+wSbP24FpD2DhpuDUtyFj0NJalSr4nLW9Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=33zq7guQG5BbN1F8hMsemsXDzUjeG1nRYGH2Px73gks=;
	b=e65QTxjMcHw0kCuX2MSUISWcIcO+YlYfWXLU/uXq8dHCqFCIKXfT89ejvsLoqc5OjvbY
	 BUUvQFu0hRntUKwhSo1t2WE/EHz48ISvGwmqupF5JkQP6xqvMK6DJnB/GbgkSxuf6c6KB
	 +iIekXqWv/q5WTrjOnLraoi6zzXwji6bpF6yRWhOMjauE7VfGY7URwAwcqyHWVinP+Kni
	 PYR1KeSYTtnXXPP5vdzMCqs1i9MX37qI9LR3c9PYstH2XBFSW5/GHPVRKJGPMq2U6H7Ln
	 e63BYWiNm1rIMinrDAvHyhR9x4gcoab+H8jscAK0A0RuYdfeae/7dNbsFy7irmL9FbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDXejQx3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC25606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDXejQx3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9931C1F000C5;
	Thu, 19 Nov 2026 16:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106782;
	bh=33zq7guQG5BbN1F8hMsemsXDzUjeG1nRYGH2Px73gks=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oDXejQx3kGVdEHiI+lYwruw4ewbnpfHaY1E0josK6b40k+KXJHtfc9pYGyIbW6Qan
	 SHK4ua3e+2TSjDbSOyNaRZF0BZdMqJx7V5KBNA6j+FOOsmlf7IQSBn+FFsAeDizkvG
	 7waw3HyXqLuQVn2Zr6c2ejiAQKz3EumCjO8mrYqUN8y8yt5+Fx+8cPGzF4Z/yrAV08
	 2yHnBE7U0sVKEVXtAisHMycBxZF//ZUjbbYnbE5f7ZVmDK0og0FIdvGdWPlaewh63L
	 goNXwKfnodH6lWscxiIYZcI1875PrVWueUsjYoOZh18fSJyS7Kfk8EQGNWrc4YDwr6
	 7COTH6tLkcQTw==
Message-ID: <sashiko-outbox-223565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Skip the CXL state update for a VF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joshua Machauer" <machaujo@amazon.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119164219.51540-1-machaujo@amazon.de>
References: <20261119164219.51540-1-machaujo@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 16:46:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> set_pcie_cxl() runs for every device that is added. It first updates
> the CXL state of the upstream bridge, which walks that bridge's
> extended capabilities and recurses up to the root port. It then walks
> the device's own extended capabilities for the Flex Bus Port DVSEC.
>=20
> For a VF neither walk can change anything. A CXL device exposes its
> Flex Bus Port DVSEC through Function 0 (CXL 4.0, section 8.1.8), so
> the search in a VF finds nothing and the VF's is_cxl stays false.
> pci_upstream_bridge() resolves a VF through its PF, so the bridge is
> the one that was already updated when the PF was added.
>=20
> Enabling SR-IOV adds the VFs one after another, and each add repeats
> both walks against the same bridges.
>=20
> On an NVIDIA Vera system, enabling 256 VFs on a PF whose upstream
> bridge has 18 extended capabilities takes 296 ms instead of 402 ms.
> Enabling 32 VFs on a Rubin GPU takes 218 ms instead of 235 ms. The
> times are for the write to sriov_numvfs, with the PF bound to
> pci-pf-stub and VF driver autoprobe disabled, so no VF driver probes.
>=20
> Return early for a VF. Every device keeps the is_cxl value it gets
> today.
>=20
> Signed-off-by: Joshua Machauer <machaujo@amazon.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119164219.5154=
0-1-machaujo@amazon.de?part=3D1

