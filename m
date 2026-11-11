Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377821;
	b=AmuQor+BWOz2ArSJcdw1RYTCaO2yJXU+LgSp4ucHA0gClcHzmw3J+4N+BzbPrcUejcvp
	 g8QwylP3ugfB6nGd5OnYjDtDiFas1hScMDz50ACGglYdz/nJp6+acmpf8iQeK8QyCuMzX
	 Z4qO0GSEccX1CP6vBo7Yxjcd/It+5B2eHFQ6rBOST0J2TVZTyruz+nMAiUSMVPx3flhr5
	 CyYlIrbi9knR+yk3p2w6gMsALjYFbx475h7X9BP+ncNb7tVgBhoArZunnr87vrxmnsQYH
	 zFFOLxfCbyV4sgGL47ok743AQPdqb7v/j/Swn6VmNczXw2zoz5ugEe4njgt2yTl0hIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377821;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JZ2AEmQ7pHHLs/eRI52uhacUy5GcrVT3hL0SVdey+uQ=;
	b=CcdAgiUQhHwQBFJcSWNdUD9/q6tASD3XU0yBG7l7Cy2BZAAleJJGmhY/KlDhuwdkIVZZ
	 Cve5UoRtX6gdOCkZEs5BA+mgVqFktQ9uV4BLftFZGQfRwSKP+8oDVaPWQKLu7RgBHl4YG
	 CobDEQW6LRrHrpudz0wNdGSumpXLy2JZFydmURIRelOP0ljKOmlIK+K7UR/n5w7fVgavP
	 MEwfCaAgobVOxNpcohnTESCuEu5RqR0v+Zogpl0WWX6nHipFPOC01t/LnMJUr4Id7jM9F
	 JWWNgbZ9sECnfxD5pfadeBzmIweF3XDEr0RSrBDmWYPq947B+tZB/lYVIq3x/QDaJXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHdllNx1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E220606A321
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SHdllNx1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C131F00A05;
	Wed, 11 Nov 2026 06:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377821;
	bh=JZ2AEmQ7pHHLs/eRI52uhacUy5GcrVT3hL0SVdey+uQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SHdllNx1jfhZK165QTWy5svLHO1Wrs92KBgBpcp/hyaqZtbxG4U8BLvJYbMRW9qGM
	 s4t2QjnyGXZ/pMjNJ/TuAywgaGGqGXEkNjMkqfXB4VxrdNJULOXupe+FF3vWAzuJ0v
	 jFjzJFjd5PBAOikclL6WewLMFAqE5SUiyMCev8rAqVK/uOXCAR+qfKWqBc6MlrJAba
	 a3sGK3cC8EXS+0Ocjbv6rjDiRQwtxPfIBtvio7FfUQe70+K/dv6b1bz700gfFhUgPb
	 RP9Ko7whMcRUDM5TQ4YJXS6LGt8lCxB4V8L1yM/9U9oNgyYTscAOh2a3jEfbMe9J1+
	 MmAvwqExyicqQ==
Message-ID: <sashiko-outbox-208422@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/19] kho: Add KUnit test for the feature header
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-20-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-20-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add a KUnit test suite in lib/tests/kho_feature_kunit.c covering
> the Kexec HandOver feature header declared in
> include/linux/kho/abi/feature.h.
>=20
> The suite contains three focused test cases:
> - kho_ser_hdr_zero_flags_test: verifies zero-feature header
>   initialization, payload sizing, and empty feature queries.
> - kho_ser_hdr_set_get_test: verifies DECLARE_KHO_SER structure sizing,
>   header initialization, payload pointer resolution, and 1-bit
>   feature flag setting and retrieval across flags entry boundaries,
>   including out-of-range queries.
> - kho_ser_hdr_validate_test: verifies __kho_ser_validate rejecting
>   unsupported required feature flags while ignoring optional flags.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D19

