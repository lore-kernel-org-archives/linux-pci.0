Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377789;
	b=trRKqgwgcz6pQPk9BunkW/taKZ8RoCm6gJr21yqZwf1tUZUlvHOwypAN8KIhT2fO9AD6
	 /34KLzUxiljF6+x0PUH29CFxPmJ8Xo/62tsecLhhE36I2+fdYR8sgqmXgAtHHdGz3nnTE
	 smAJcGOEIiIkshFINqiN63NFJWuLUxRB51520/IG34XvQAr+IIF6FBHmTDQFksC96AQaC
	 iLPg0Ml3p2Nin1JOiVUe57YDdW38wz0Gah4KuXClpdorWJqM9b1+E8aTnt7KnZVJRwiqx
	 egJJUQXDM5vgXIqLTfW2EP5NWhuVY9Zmehnnxnv0WJlJ0VFwJBBmVLEur9quXuWJUcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377789;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wm+QBXzWox8/MSAn20XhSTfS6IOUVHhSpLLWhk/HeBw=;
	b=Jf+tZNMEY4kjpY7eBPNyei5/Mf0veMv6MT5DroHLwYRC/SXo4T0P1IRACir18Zs1StSj
	 TC8GhevcxiCtsxlWHlMl/Is6u9gU6qXJHNhMR3yCSVbwvfM8eV/DyCc9UCJyV1atpvF2k
	 NnyiuUJi2IbmpMGrj8Z9BZeab1JFpOge5XvqGdD/llYNBWOAU3uuhuDnHM5kv8dxwx1NE
	 FmChlAGYzbrgZuZJ/2ZHPxVCS3nVWuhSsSoVTCOSSIxvSTtlDASSlKp0HhYuSocKQ+zcz
	 KCPYb7EBM2Sm3A/ZK9D+uFLwdduNmIj47EyQhkEqZLnUIEdSmaDJASTerZB6msUtrLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSQRUEek;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45939606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSQRUEek
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD671F00A05;
	Wed, 11 Nov 2026 06:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377789;
	bh=Wm+QBXzWox8/MSAn20XhSTfS6IOUVHhSpLLWhk/HeBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TSQRUEekdkwGDLq2LTN3GpGBXdfZ0KxjVfw1G/H3ctBMN+1gGe6dsT4aoct25Juk4
	 RC2k5L2Wzt255/pRIiYYzul4oYZOEDbAvn21gL0CXCXTqrLwNg/Ek1ppeJKUI6nnqn
	 LpX26y68ngPrK14CYEUiFFg9OnXkKdCPdFxNguAV/ZnBQ9ggBtPlPFUSJd6R2/Cp0P
	 0LwXznFmywYWVdRdykNiRvonxDbsnT3Oyh2UXYXnTNN4s4GPYg737ndvazO1Odinpb
	 LCEsg8yrQX+7ewzrEjofiw0AWPjpdeye4IcdgxjXYTPu1c2jWfNqFCPtTgGa9B/aeo
	 lRIUpxC23ir2w==
Message-ID: <sashiko-outbox-208404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/19] liveupdate, kho: Remove __packed from KHO, LUO
 and memfd ABI structures
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-2-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-2-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> All structures in include/linux/kho/abi/block.h (struct
> kho_block_header_ser), include/linux/kho/abi/luo.h (struct luo_ser,
> struct luo_file_ser, struct luo_file_set_ser, struct luo_session_ser,
> struct luo_flb_header_ser, struct luo_flb_ser) and
> include/linux/kho/abi/memfd.h (struct memfd_luo_folio_ser, struct
> memfd_luo_ser) have naturally aligned fields on 64-bit architectures,
> with no padding holes between fields or tail padding. Assert both the
> structure size and 8-byte alignment under CONFIG_64BIT at compile time.
> Any future unaligned field addition should come with reserved field to
> keep the structure aligned.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D1

