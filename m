Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843289;
	b=c8ek+iWr85CQC7Zbzg6XGekw5oPACegO23M7+6vJFipGcdPhqb3XjAfNW7eja2RfvvDG
	 Fk6mPp+QQYOJHdfXKA1sv+9t8uBxDrbjeXj3AFIVAYIZ45a4/9QwuaHwtEqO/1iP1CFIM
	 7ZDYFZGCsHZuWQW38WrIQcrYbm0Kgg62aKYBcgqMpphzQm8p+i3qzX7HiM5MwBLjZkSfz
	 XBAeTiR/2zfiplMap0O7KuoRi8ZKkKTwR/tp5A5Y/CanCxKPjFCypKwsG2Ok5PQq7/Du6
	 tpDKxBoicd2Mfp7/KFXpAGqqLH//hgiWSHD9QRHhHbrIvlGoQg8u+qTk4qgQ/7SdGsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QQ4egRsBgzzwLHWrBRDSSnKaQLE2nFwrU0rFAI2X5TA=;
	b=4b+aRgx78HUAPUczKqZKDVxnIAKP3ztfqLujtT41/NeJkB35ejJ8cPdOdZf4De3IJdJj
	 vw2vPFqe2C7sG8hrVYFF+elTB9hWX2+5dhMaAXu0AtE2KVlUE7+oP3b99ADJhtBC3wGxR
	 A4/4yXXM96zJOP43ur8WSh4y0EMMEJeF8RohX9Uc5r9OI9T6/gfk8sIikL8jaAiIPAMxF
	 g0R4rl5ANc1aeMSphbdkhHI0kPRlr5EEJ8kmRoHLogbzHHovZ0s1CYwT75rnhAu+QnU4T
	 +0B8sIDatUlNM87MzHXNm6V2hBhyk4Rmef4kKukVVo73RLaaWY+qXy+krqyFEi5KzGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bfO53hA/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46705606A31C
	for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2026 15:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfO53hA/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A5D1F000C5;
	Mon, 16 Nov 2026 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843288;
	bh=QQ4egRsBgzzwLHWrBRDSSnKaQLE2nFwrU0rFAI2X5TA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=bfO53hA/yZH9Uo7ygqu9R3Tskt2fImmQWQwy5v3bkY/W2r83F9v+YTI1Q94hgqHuf
	 YmeG4dSwTkxJU0Oq37ikGqGn1tGbnJ0MWg1pk+G5UFt97bTOlvxr4UHXJr1SVxI9TR
	 BK5xHX0sCOMzHzOkqUjGtk+55k8YHUoifKSPtNft9pBTG9fdscEhtg2WRZc/sMpdxq
	 Vvw1EPUycUbI4CsFwtIL3ojn8BOtRbPplwzIDZRdIrHsgig9FYFYQEhjn26ThCh12u
	 XL0WS1z6VDHgB6hBAMUniAkX9ZN9tNGXN2HcflOZvs0hu0PP+VenwsfyPIrgpeQpLO
	 fB6BGF24UZXHA==
Message-ID: <sashiko-outbox-217293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] PCI: ftpci100: Convert to
 pci_assign_unassigned_bus_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261116152403.2672-12-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
 <20261116152403.2672-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:34:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The ftpci100 driver attempts to assign bus resource using
> pci_bus_assign_resources(). That function makes bridge window sizing
> disjoint from the assignment phase and is going to be removed.
>=20
> Convert pci_bus_assign_resources() to
> pci_assign_unassigned_bus_resources(). If no other bridges are involved,
> the extra sizing should be no-op.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116152403.2672=
-1-ilpo.jarvinen@linux.intel.com?part=3D11

