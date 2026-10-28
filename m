Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157164;
	b=1QOZpr7Dlx8Uvr4giCjWd+u8HOk+mQNCaNvVVT6nuJ6NB+64Yk+lWr1WTRapsZ2nwTeS
	 tTL3T8Fa20PnF51DLgtjRaEg3diBYEF3Q5XKLlABUH2VxWM3NvU5evOiFssHgzgndtZ2k
	 1FLJDJNFlHJpnukutYLyV3W+lpT7ALLUoPZJYP6Q3Fi7uMWjbs1a595i9FdeQyOdacMnQ
	 t0JI1Byht4ItgIJYG9m61R1FlV0HKjQVzu4x/VL2OzKKx9SEDhiV6yOG/p7mk7JBg8svi
	 h5E65TP43gmhVtcOl4sQA7erw1Hu3t9ojoqcGb/6otXnWeKCEKOqnEwlAyG1QpyduYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+O8Nhhs2X4esOpM5ShigU1X2QYOzI1/3uhaqfh1ytxQ=;
	b=K4XiqEkSLI0693u8kremlHm227KFzpNqGDWITx5LZGwZPFud5oDw2Io7Y4+4kUju91XE
	 yjDXwbRw0DY0FnoJBV3Z8m0Uxs2hM3K2bHPitBU+BDkRoPlzTwcCpMQa/2UbgwHXLiqbQ
	 2OXKy9Q8khZJRXTnLaM1SalAAt5Zb2YaGBG8NNZR4ETVpGFz6eIbghUIaeSYPja4id6m2
	 yM7Fq8Zb1fmzNQlYWJQoB3cHa1GvfCFWWhBKntWp2czEBCBor/wzhhU2GFTpwPwyp0s/H
	 MXVR4mBssLU3pi2O+r5c9ZwoqDr70/0AN2EvaZA3ce8wvZkGN4SLtH60Izbc0PeYiPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDdlWsfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE2F606A31D
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UDdlWsfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F87D1F031E4;
	Wed, 28 Oct 2026 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157163;
	bh=+O8Nhhs2X4esOpM5ShigU1X2QYOzI1/3uhaqfh1ytxQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UDdlWsfIcTF3VRo6GSZdQQdkw+xPMGFew4PYv4HCmfkCuaB94pxW5gZ/FUOg7Gipx
	 KwJyt+46hohFXGUpkun6JN/bL2kJ17wZLpzj2KUtDwyGFJMjcIyJhIKJ5Se7Wnou7M
	 w8xzKpxfEFCcDdElRrB8BJlg3Zc1RvJLy1src3NZ0FbCiCkWjvyt4255Q7x6X5xTou
	 KRo/bnTbHo0Jf6YpXz6YgJdSrlrllGgpRmr55XrKMMAL9+nx11E3J2jx+IRvHRmqjD
	 3aZAEeMySHBM1bbnKW8vgsiP/lQnaqmGiNpzx+6jpbeIlpcgSjJauW8UVkn1B/2KJI
	 IDj4dEmBb/SnA==
Message-ID: <sashiko-outbox-187395@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/16] PCI: dwc: meson: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-6-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-6-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:12:42 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Replace the dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) calls in
> meson_set_max_payload() and meson_set_max_rd_req_size() with
> dw_pcie_get_pcie_cap() and store the offset in a u8, which is the type
> used everywhere else for a capability offset.
>=20
> Both functions are called from meson_pcie_host_init(), which runs after
> the controller clocks and resets have been enabled, so the first lookup
> happens exactly where the open coded search used to happen.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D5

