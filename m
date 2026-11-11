Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377809;
	b=O2GsDcOQChNfmA8q1GPmwyF+EWcj7dJ/hEMyVQYKSkbv1QN3wlt8OB/GhjSWT7E8mdhj
	 8efSwvTiHgk9MGy9oqc4btASayVHoHghw0aHtVcoA/Xjc8K7wqX4MoYPVMJi04vihfg3M
	 y3LBsCcMdt2L+9VMvVZM6eDgCFbcB6hb13aLOsIT4JLGmemGcVq82Aev97Eprpp6B4rqd
	 IkTcMj0pIXvxy9WaAQnNiRnMjziX5KuTeieTeupxjm2H4YYZ2U2DRlcBaCklIU2VQnZFl
	 raFIYjOZtSVRfaom4+31IXXJpW9EFxpPkbxYOID7AK2RQTW5KQWvtqcAIKZJYwsWlyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xIvp6AhfTRu2wGtkP0pNUjVE6QvE2czSwCxgFz2Krdk=;
	b=lkm0KtONIoShpTubq0nO7nweIqPeeFlbP7FQub9Wc+NQocXYVyjUQzwTN2Hw4AzOt6Bz
	 DD9PqTIPOeU1esIgSTEr06V3wDsbahBP6+9BF2ofpRSDoODtH3bzsdJsAB7cfkBNgXVcq
	 T4ks1bWVMcK3HSsQIJYb2ahNgbKXoLaJncSjXa+A2KAE4hKc/+rOEJfXjCzUS2c+vTEKk
	 5Z2g2H3PWR6ODtlLlZ31yCHTMhbu5lJ+apOr0ffWoXihRDd0XK3fKJRL32odKmYWOB8fB
	 M3Fn2yU67ierkj8ibwaCPTyvG33+GYC8LXpUvis6i+WAn0CDWaBUDTIIj47qeMcZycQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPfbrvw7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03474606A33D
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VPfbrvw7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ACC1F00A08;
	Wed, 11 Nov 2026 06:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377808;
	bh=xIvp6AhfTRu2wGtkP0pNUjVE6QvE2czSwCxgFz2Krdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VPfbrvw7PRl3E/2TDCDqUfsKq88gP/qsQsrepTsidgoKlHYT0vofXc4nNrgO08Jh7
	 Q38lvLygXMSsmJXoQIqSi+T35Y5tDbwTC9zn8vWZ6BEETOnW5NCa/qq29ZzYnuqG36
	 kcBsqpa23v/quRNOpJkax/MYmbGThxq2dJkdNtQA7eFWEnb3r3NNzD05H/rsM2zXdq
	 jz+elsF4k4HOwQt/J6TAMRrKoTzBO/N0Wdb8mgXsp6ruhTLFM93fYgKouRGbZCa/hx
	 acfwJ4441inspY1vrUclAy/SKE5F2LB7LFYl00SR6DYul9WebCrQSZg7a15Bd4h116
	 oy/i5sp5mEEew==
Message-ID: <sashiko-outbox-208415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/19] liveupdate: Add feature header to struct
 luo_file_ser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-13-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-13-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Precede each serialized file entry in a LUO file set KHO block set with
> struct kho_ser_hdr via DECLARE_KHO_SER so future per-file metadata
> features can append fields to struct luo_file_ser without breaking
> compatibility between adjacent kernels.
>=20
> Initialize file set block sets with kho_ser_size(luo_file_ser), initialize
> each entry feature header in luo_file_freeze(), and validate the incoming
> feature header in luo_file_deserialize_one() before accessing the struct
> luo_file_ser payload.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D12

