Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505872;
	b=xatnewn5WLdWchFls8t4Xp3BmcuqwJAH9fVIGq9Vd85lSWxH2GTMoqa5EzfJTA+YGnvd
	 hfrdoWhQARZF62VwIUBqA7r+zcHH3S9l03+olMCUoFzpgvUuDM3d71zk9MrimxwvBeaJB
	 giSx9uqrqpBdpARxsWcaaSCO3uni/kna35VpI6AiUFx8K+mnmEUEcJHTF5GTi2U97wmnx
	 mqd6JjWMXcUXsQY3ktfaTiNd9dYMLsjAoWSnilcwcmpRo6uea3g3uMmk1HvbKVlRCmGMb
	 w7bNU+xvrJBuK/Gl4/5jNp2gslCfmz2CfsEHeODy7fbk3RBZEJeMDDVZCEQyF0k+aZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505872;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QytWB51UBFHTfYoGtBVP3WzDVHbPpBg3DpsouKyuxmE=;
	b=PLZVCm9UF67p+c/+mQBIvkMaqYAAiB9pM8ylRY6C9OaTwo1OqZ7NVLcAcvghkLwznYa8
	 y6ZqAruWUltw4CIu3a6UlSi5/WmQloAaG78SrJQxcQvdpHbQih0kL7tU++n8GWzG1aZYL
	 Ef5wZUAJ4RIrdpsEmw8h20xHEv/CMeAbB23epf/GmjvABDpqGxGcguhoaUNYm9bpZIqnJ
	 vv+cBY6AWP7C9OD9VQjYh8z1w5rjWbF16npgFC3yD8clICnFEQDNEiKXCmqO+Wo8FCzuK
	 cTkq9uAHftFv6Rl4AhdW2YGywOddraSRjAtyqbcMdjbMDdeBdXBZBJSodtCVYXjAXKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0UmkFwn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D7606D4D1
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 14:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0UmkFwn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE4581F000C5;
	Tue, 20 Oct 2026 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792505871;
	bh=QytWB51UBFHTfYoGtBVP3WzDVHbPpBg3DpsouKyuxmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U0UmkFwnhQ3JdUnrw04UyJPrCEF9MUy1sgod9zUOSB3H7sD0eAB7lPNBePHSd88Uo
	 HVA5X5L5qDyemBtD26AUmnhIi5Fm/1TmgkFaQ02VuanfvWoK24qvrIvttc5dwgFMNK
	 moRjXp8SlQ/ZKWJjlmHi+gYA8N7dnV97jnitJbfeatfN159JcWlNgrMwnXl8SqQGE/
	 0aqdg+MAJ8FjfJH/Fdo5dvYdoAtA3TWo3PxIiEV6wXC/0b3lGbdRjlbtMY8PIWY8P+
	 zyV7a9k84Bmf/aIBZFZX2XNXt/vij5ClFvJs6KVBHicuE/7Edwv8hyxrX0xv2pPytl
	 IY3u2jxc4pT6w==
Message-ID: <sashiko-outbox-179112@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Preserve the initial bus number in pci_dev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020-vfct-regression-v2-1-d2394d11450a@amd.com>
References: <20261020-vfct-regression-v2-0-d2394d11450a@amd.com>
 <20261020-vfct-regression-v2-1-d2394d11450a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 14:17:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Bridges that need bus reassignment are scanned in two passes. Save
> the firmware secondary bus number during the first pass, before the
> bridge is disabled, and carry it to the bus created in the second
> pass. Initialize pci_dev from this preserved bus number so drivers
> can match firmware records after PCI bus renumbering.
>=20
> Handle pci_alloc_dev(NULL) as well; some in-tree callers use it to
> allocate a standalone pci_dev.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020-vfct-regre=
ssion-v2-0-d2394d11450a@amd.com?part=3D1

