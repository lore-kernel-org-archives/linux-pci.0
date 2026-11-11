Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377792;
	b=fFmjy9BePavmF2eB5I80agVcBhYmFXnTC5N0oEDtcB9bzEiQjCXIPnCg/0wkSUMe2Vdc
	 iNKiZd63f/H96C13YkpBmmcQoUFzeOBb3oX/WzQKSn6delTLEQdVjIQULWM1N9LppwLjO
	 /4vrEOd0NDiPPFOceM0jKXrTd3WVCad8l/oNfB3zh1ueaOqTcnSHy9SZqaGPrj82dQCKi
	 jf7ueSUF8dbfLiMTEhGMePewM7aTehbpbryRl0AysT/9yVL1c55a4s8BSXhMvkhoxc812
	 K4ZDi9jBXsCRnfyrVb/nqfj5z5iuI5UnWRq2kJxqj3a3NObYcEk7d3ZZZD3I93fKFSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377792;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jKhtAJpIMZr5zkQ90WAPxbGozyWEzkhOTKXWRTKOuzQ=;
	b=f4XVQHlns5RJYYhEmE5x8Yi4ehRr6LYAxAz2WHudF+Sa9svOjUQuby8vnvIRtDqTxuM8
	 uMNpHSmBrZNRqkdXku5I+CojCqlxN1avrZ1Dre1KXp7lKqy4IM0JMll+XYs8ok3QF9muq
	 MTBF/SmqRycqzvu60Fr7AG6X0Rga8RkNZSJtt5wTsfU3jWMHiSptV9GmeFkIuB8dx1pjY
	 a+9IWPCF/13BCCOt4/2PPQ3jcpvoGqGb7oyZH2O8dtvevuV8QNMY8nqyJ1ZN14At4Fuuf
	 42Ltgot3ogWoZnk2dZQ1bomBoeOYOOenUN3GSOtZy3ERirsFjc3ZmM1RTH7HdrxuUVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwJUZaGA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF4B606A327
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YwJUZaGA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D1D1F00A05;
	Wed, 11 Nov 2026 06:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377792;
	bh=jKhtAJpIMZr5zkQ90WAPxbGozyWEzkhOTKXWRTKOuzQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YwJUZaGAA10OJ8aiAKAfQiaMUgxpaWWXnuTeSXsf8IhhOa9PSFn0Rvo6UeCC7aFWQ
	 M5bUtR/NUyDFBnPlnu9WNKosXkTMlZEk2Z35BS+/rHzCTnZKmuGOWP81WE6Ntf6cNe
	 z39Y6Ox86l/URlLcEA8Qon1RSSEKWMkYNk70/DNyWR3wQvqU2i87DrX4/HnzPwVf1T
	 sAtuUMCB0r+QrZZYojiWp7j8rMT7x4k0pdmuFKBgemd+3oYMIrkOIsd++Tg9NXdMaN
	 ++gPQPTiOvJaK7abOWxvJ9pugS05EsrLCxSaBed8IiaQ3qLh3QPBM2pUbuZy8YJzjC
	 /Z3DAKhxlGJWg==
Message-ID: <sashiko-outbox-208406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-4-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Subsystems preserving vmalloc allocations currently embed struct
> kho_vmalloc directly by value in their serialized structures or device
> tree properties. For example, struct memfd_luo_ser embeds struct
> kho_vmalloc folios, and test_kho writes the structure directly into the
> folios_info FDT property.
>=20
> Embedding struct kho_vmalloc directly couples the containing layout's
> field offsets and size to struct kho_vmalloc. Any modification to struct
> kho_vmalloc shifts subsequent fields in the containing structure and
> breaks the handover ABI across kexec.
>=20
> Convert callers to hold a DECLARE_KHOSER_PTR pointer to struct
> kho_vmalloc instead of embedding it by value. In memfd_luo, allocate the
> main structure and struct kho_vmalloc in the same preserved folio, placing
> struct kho_vmalloc in the remaining 8-byte-aligned space, and bump the
> compatibility string to memfd-v3. In test_kho, place struct kho_vmalloc
> in the remaining space of the FDT folio, store the serialized pointer in
> the folios_info property, and bump the compatibility string to
> kho-test-v2.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D3

