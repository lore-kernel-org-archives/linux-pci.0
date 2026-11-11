Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377791;
	b=FEWhtNtgi/0lcCIqflO2aTCE/vPqovwI8P733oNtL1mIQAhRKr7T1fv8XPUxe/bBfxvN
	 u6+UHfKdowGgfVZeGiw5qfNKJC8Fr080zCGZo+DSLzbWjXK4FFmYr55lQYF85cvCjsjJj
	 A7sqgXpwKgmN3jZpYio6aF6U1JLcNU0v5gxBQgzwqApB8lEtY5k/XoZIGxTQpLeMUwT+t
	 rXCbSQWOzT/Da151ArWGYOKBoz1qBayS6gQeBhn/xFRi1DQRpU0PyAd6SWTpYrX3dMCKq
	 h4gK2OLRbB/2aoToCOcMSvnpKpjFWjz84GGmGuAzXEB0k8Kl70McGv+crjzdmMZX+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377791;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V38D8Zzjhgp2B9wmXpv51p2+0Uz9/PgRrujbOQbcK2U=;
	b=VS7Xy4/zDnc1piVUUt0IuyBANVpbDC6TF1L/lj7JficVkvwki01rGdKm7k79pcsSUmiw
	 FGyTIlXqv0BsCF7Zv/JG6ojRtEsPKf7N291OEZS3QbGct9Z3HeB3MZITodV5gq7iRz0bc
	 xKtXtV5zR76h+JuAgA/Wp0RKCuzhNJuoEAMdFW9ynG4KghYgmimRU4QxLVh5KUVAmEJTd
	 C8VSIS4ZrgKQZZ+huPcUz0taiHfyUPkfIB3UDT0j8TmwbtDqtLdOG5dIcgCvgA/Pf5c/o
	 eewcGoIQeyeXdPvT65d5m7V3Tp+6962YyTcHyUgzinw4iA29FTm/Ty854/XJwibWgBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyRy82Vv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394A4606A334
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyRy82Vv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C0A1F00A07;
	Wed, 11 Nov 2026 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377790;
	bh=V38D8Zzjhgp2B9wmXpv51p2+0Uz9/PgRrujbOQbcK2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyRy82VvGymEHSlX2UujKZtj3TAKx4SdCgF0wU7SLG+5++Y0Gwd63UMAm7W1BfNZ+
	 w4AhvZAZOHkwws9Bzc2uLY22yQAGyc+t0mIjiw1DSJiJ5mc4yaOS3spFWnBrFIYCg7
	 3fphGrqq+kSm5+cmODm9pHjIzIoRHM1K6jGBsXEf/qTio16yEnwsb2iKvLPzQ6M1XE
	 C3Yp2Ey6QZDuigxpfmAeelDE/dVoKQtkn529xEVjmSqrQPmMOurl0/gU8cnsyw0IPP
	 AkYlrh3MgW6s8xM8tNKNZQHbx15XAEdMbj8C0q6lWz2ts1n/K6bOGRc9vQe4yGZVUO
	 8rLKSAutAHHIg==
Message-ID: <sashiko-outbox-208405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Subsystems using the KHO Serialization Blocks framework currently do
> not record the serialized entry size in the block header. The entry size
> is only known to individual callers, which must track and store it in an
> owning serialized data structure. If a newer source kernel adds fields
> to an entry, the changed entry size breaks the stride when an older
> target kernel iterates over blocks.
>=20
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,
> or one that differs between blocks of a set, is rejected during
> restoration.
>=20
> This change modifies the serialized layout of struct kho_block_header_ser
> and shifts the offset of serialized entries within preserved blocks.
> Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
> kernels cleanly reject mismatched handover state during boot. Also
> update the stale compatible string example in the documentation.
>=20
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D2

