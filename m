Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377801;
	b=TQ6Mrs5XSxhw0ZonfVxlMIx+qcFRrajQWFUhvQQpmNsLJZm7FZ9DXWTOrA0BKJOXcLeg
	 GJ8+rXFQ2PICx2RD6gbhlY+dt5qqMQTp47RwNOxQszSv5o/SXNcINk+0Y4ECiSCoBSHVq
	 zruS7zcvRW1W/Cmc/pFjbweMB+AYHODiandOHZOsjKIzi0qBXYiWCjhmrSlQ36RgrSNZ0
	 /uXyP6ujb7aDbgSRsDNpVcenT1CXoIehVpCksIsp3JdlcEgASlj+zveJ0V1ilALS1a/d0
	 kVV9JQqrhmkrBeac8wYwKU3z6hLWcrN/1vbpqEFZovDtVX9s0KFGZ5B7IgMvpup8Z+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377801;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fscXIP2li/I0NRYzz1oi4vQZQC1ldclu1W8hz2ayPZM=;
	b=v6NlVmi1WYgYIvEF7VAuss3ry+U5CU6qJI0GqyTfDEcPUanFw2AKecJtez0cIyGyhKz3
	 yI+NypgzJpzKCBCZH2qqJinyaCvJ5XKXwMD8Fvtf9YYVwdJT/7iv6eJRo9qv7tadZ8Q1S
	 ToBPgjz7meeZBeY9oEWXoq3lAFbg1g0vn+a4kx6vAoiE2zaLV9xA9Y/5PotbUFbfagDOe
	 0yD0VoaUrLwOW7siUa0sJ4Kl8M7CuVpDdHhg5Uuhc4ieSOW21Hp6Ct01jKVYKba1yx03k
	 hsShK5xnWFZyJnYmDIMqd/UNRxh/GDXiLgs+aBOWBMkEg6F59OEWP87nKJ8YEriVMWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OArMx+t8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529C606A33E
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OArMx+t8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3621F00A06;
	Wed, 11 Nov 2026 06:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377801;
	bh=fscXIP2li/I0NRYzz1oi4vQZQC1ldclu1W8hz2ayPZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OArMx+t8JccceqnmvhU8sc6QFtIfmaCVldSfP6Y/co0u6nZzbEAwSYMrHdIqGuhiR
	 Ygi7CsqEgyE/v3uqMYgJ7hNlWG0fErD/UHsSU/WEH8JpofK3/5G+mFvMQ4Z+wTi1jL
	 syEORqaGNydjbql0uOpp9w3allnnjaYYeZMnrs5IRVxLT/u8XrHkP0rZL8UVvWDMXT
	 3j+9eNVtco746JUidsgVUGDFyu4rrVoiO4OxdjPDPKvvnTCCEjIODem5aOS84JFH1u
	 ltbzVdzhbbsskPFTy44U0XzR42rNVCKuliar2uI8IMjzqrxA0TSpZvVSKQ1oNTPqz3
	 tGmNATGDTbZdA==
Message-ID: <sashiko-outbox-208411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/19] kho: block: Add the feature header to blocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-9-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-9-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Subsystems using the KHO Serialization Blocks framework currently rely
> on whole-structure compatibility strings to validate serialized block
> sets across kexec. Any modification to the block structure layout
> constitutes a breaking change and breaks compatibility between adjacent
> kernels.
>=20
> Precede struct kho_block_header_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Each block in a block set starts with struct
> kho_ser_hdr followed by struct kho_block_header_ser. Serialized entries
> start immediately after the header payload at offset fhdr->size.
> Block capacity is computed as (KHO_BLOCK_SIZE - fhdr->size) /
> bs->entry_size. Subsystems can append future block-level metadata under
> new feature indices without altering existing offsets.
>=20
> On restore, the location of the first entry and the block capacity no
> longer depend on the caller. They are derived from the header size and
> entry size the source kernel serialized with, even if the target kernel
> structures have a different size. Fields that the source kernel did not
> serialize are absent: a subsystem must not access them unless the
> corresponding feature is present in the incoming header, as doing so
> reads memory outside the serialized data.
>=20
> During restoration, blocks whose header does not fit the block are
> rejected, and the chain walk stops at such a block. Validate each block
> header and reject unknown required features.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D8

