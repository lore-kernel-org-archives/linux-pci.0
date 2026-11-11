Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377794;
	b=PSKyNHvUvB6lAy9AqteRDDQBN0NaLfjS3DfbDPgOHojtrK37Ia+I4taxrg3P1fa53L0+
	 K7oN0PFQMxPQnEd+ZJjkjjg/NfJ/aSFwFSQ7Cjs5DQhhL9ThknSipAEqUgP0JGqtY90F/
	 6D7xXaJP4X8MgVwRCclPqirWp5isPdSCkXf0rLyqAEKFObrd6ABx5Fg2/OlylHAampJbU
	 B0hgEQoT/j9dGuD9IGNYnd7VgmYcs6TI1Sv3jSHpFsrcoOA/pWffh4hMOlsl447yXawG7
	 kGUqAH6/OtZ9L8Ead/7ExMqlnj8fbB/9JIzmc/7eSF9h7wsSooCrGW179UZJuavd4gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377794;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mn5WxWxOlcQCOPTzfYH1jZr+FBFLyVP9kPYAoIj5LLY=;
	b=1sRmkLDQIrIb68OX18ISY0fJl2mzzYhViSdm7VRqSeqH7aJJELF17/dXBdAQESuvrhTF
	 9dhuVperBV8NTDifBkhQpw2N3dMdRq97uMlKKNbzF64K2zThMqv4R1l07iOC9yo5cFbSd
	 fvwOli71yU6O4CMn8JNhYNDI5ChdTlYvd0uptELoeuJcu+dr+Vn31SHJMP4AbvoQHp41r
	 X8L563ORrIB2okERU3gJ7tnkLBx46DDqNZZbnfhKJxjNA6fo/7UmToDLs4rKdbGgiwnMX
	 RlYPtxvl9r/khSJRwyq23lEbE5mUuVcTcO7SVgkRVZt2Km6dQ7bG/Db7qKN4dLdSfZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNRSeb96;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D729606A32D
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TNRSeb96
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B321F00A05;
	Wed, 11 Nov 2026 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377794;
	bh=mn5WxWxOlcQCOPTzfYH1jZr+FBFLyVP9kPYAoIj5LLY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TNRSeb965bqob+KSwGp5xy1zmM0n2fxtzu5gZ+UOZ5j+zpbQ4+olLMUXbyH+iKSry
	 9+QwZ1E2acN6mBtq9O2vnFJ1dbFOwk0jlvbkUnzp7UqFqvnmuIC0JjGon5DFjR0K0W
	 aukmxlvDMK1KJtBjPs+AUfDAPaw3B0XE5Q+BRksMhT2mDe/12C6hpYhRyqInQ+PNBD
	 gMqX1gb+zoVDTsVl5sg1PHiUlqrb44kbVqsFcJXpasdvSV5b6sUUyxUmMGftnqwshz
	 aq7HZsOzIzk4xk7ekRgjIlfClIUCoiIalka2lL1CrZ9GCVIshPXWC7f9SvsNRXsnH5
	 z6iS6OW0KobFg==
Message-ID: <sashiko-outbox-208407@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/19] liveupdate: Reference struct luo_file_set_ser
 via serialized pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-5-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-5-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> struct luo_session_ser currently embeds struct luo_file_set_ser directly
> by value. Embedding struct luo_file_set_ser couples the session layout's
> size and field offsets to struct luo_file_set_ser, preventing either
> structure from appending fields independently across kexec.
>=20
> Convert struct luo_session_ser to hold a DECLARE_KHOSER_PTR pointer to
> struct luo_file_set_ser instead of embedding it by value. Reserve space
> for both structures in each session block-set entry, placing struct
> luo_file_set_ser immediately after struct luo_session_ser, and bump
> LUO_ABI_COMPATIBLE from luo-v5 to luo-v6.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D4

