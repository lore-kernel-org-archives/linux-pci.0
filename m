Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9835137DEBF;
	Wed, 23 Sep 2026 20:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790194712; cv=none; b=gyy0uxqdnuBzP+FA7V0XSd5E7aljZJFnHobdqjn2Ec+dSxOxrTWBDrMF3IW58SkM6qa3kjNhvy6rMIZZ9C6QQh3Z0puB11T9GUjLN42Sb9EOHufuzKs+VqIewpKmhXGuI9NWl4eR+oCuSf6H9c1xtd2LPiKndnUVOmyZQt6exEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790194712; c=relaxed/simple;
	bh=+sdKbcLi5hIZgiM2KikycIKnOZglZuq074u6hnIVjKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jliyanVEvobqAOz1wt5psJAJQniyRmoPpSoWk/GXcsxvoD2kBLvjV63nMFK06tnNFRfWpCJcd5EtUK9hRJmaWI25kKdQQCYr6ELxeC0sWYBF4H51BfzKKV9/WTRpwUufrwBvFXvWlgDo94mWDaI/qGzjzTw5W+V8yodSbwJeu+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZSlQoJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZSlQoJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863A71F000FF;
	Wed, 23 Sep 2026 20:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790194709;
	bh=+sdKbcLi5hIZgiM2KikycIKnOZglZuq074u6hnIVjKo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZSlQoJp1XGOZYKVl/4QMNH830hCxsPolIEj7ZTL8qF9zccUAaPpRJ5WnrTpGn1OS
	 sD7/Yuxp2ni/V7irG/FUh5CD8DWQxxXsmN94A5hx3h725lvosKNKg7o1p4NzCDaoGK
	 kKhe1tCAX2ckUNVlj8q3dIHSJ28QMMPifYF8O8tWQCwqJZ0/TPuj8IGOd7Li3hY9LO
	 W1S0//XexRIjkw6jvNQgMXD7u6zhJYdg/fgEprwEhrbXHwdycuKMLQoyoLmrj20wZl
	 lWElrwBJLEE9uwThwC9cx9A87Dvlnp1BzlRlmYlzB8RwUOD4rVI5cd4j8n09xWGSgs
	 tRF6UwLEo9OvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/17] PCI: Don't suspend IOMMU when probing reset
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <7c2bec39656a79255ad330bb7525565eddb758d9.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <7c2bec39656a79255ad330bb7525565eddb758d9.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:18:29 +0000
Message-Id: <20260923201829.863A71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> reset_method_store() in drivers/pci/pci-sysfs.c discovers supported reset
> methods by calling reset_fn(pdev, PCI_RESET_PROBE, ...) without holding a
> device_lock, since the probe path is expected to query the device's reset
> capability without changing device state.
>=20
> However, pci_reset_bus_function() and __pci_dev_specific_reset() violate
> that contract after pci_dev_reset_iommu_prepare/done() were added, which
> moves the device into a blocking domain and abruptly aborts any in-flight
> DMA. Doing this for a probe -- a state-query call that does not even hold
> device_lock -- can cause driver timeouts and data loss on a DMAing device.
>=20
> The peer reset helpers all handle this correctly: they short-circuit on a
> probe input before touching the IOMMU.
>=20
> Skip pci_dev_reset_iommu_prepare()/_done() entirely when probe is set. The
> inner reset routines already implement their own probe semantics, and they
> perform the capability checks and return without changing device state.
>=20
> Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a de=
vice")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D1

