Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995600;
	b=SJa2Mi96fPuICwdLMdnvTaZGhuKmZ5mLuzGMCoRJ1vqjWSBusfly7LUMc9wRTt50axtO
	 jUukDitTVhyvnxO7yOtlqNH7rQ7wZIytUDUy9rU/cz/kwEiB1VCjDAaszKvEMnozPdTb4
	 zTSPz1KH2XD7T8cHJp6A1Z0TZE1puU8FKg0RWMkO0RDpk+BAyh9CHFME7OVnDf3UX6EvE
	 wZlWNya8188gQipOV7ZaaBaGbRTAZDrpDohBzDmqRahcNCIgzfpxylQEsfGvpofQF6VAc
	 Ttv88t1Zj8CItvuyZycyziSML7I147O3ze/y+XVvKBU4UV1JUix1ti1c3FNRfGj6i6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995600;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8I/eo/UCcjc+UsOEgrX6GjuLtLmbkkTr/cYsgj0+fzA=;
	b=JlJ6pqE/ORm6Y/Q5Z6xKWwAf1mKdyhGQTc6aj655zMoKn+xoQzXu9y2XWgMwWVrM9hoZ
	 kX/aQfmHwnKTxSn9ucempSxH2QjrzZA0PHUpicEMhfs6Szcmno88fCRDzZrI4aJRVAlQs
	 q0xP0a575bMBcZsN5boP9btveRI8/Muiz5Ppxd12ukeCaa7Ere/phBJzuI9uQne3NKp0n
	 bIXhB4LzeeZkgpyhokDV5N8pdivlc2ZvAjSXpLuxqkltQMs7tMAgvlCK5cw99f17JPk1z
	 KVeV1vIxeWfo9zYkDYJcozCk/KcuMRBgLazAhj6Qr8M9CCDxnHAh803Ncnam9aGRvSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWr8C268;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83E606A32A
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWr8C268
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA821F000C5;
	Wed, 18 Nov 2026 09:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995600;
	bh=8I/eo/UCcjc+UsOEgrX6GjuLtLmbkkTr/cYsgj0+fzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWr8C268Y7z/00awzXGgmqpWBEp3I1GHJO8CF856iV9griKyXR2dXChzDvR+GNwsM
	 3mdtmEsUvatdukgqmLJ6+c32wUD/T6aRoqDnqtbGoavVoWnlQkf7IiBCNqsvsDChXY
	 juq0/T9CV0Be0J5ixah650Nyh10ud3VN10mNUHcJKvSuOMRo9BbJpqW4uGcwN+etQQ
	 y0ATILdGW9rsdHCYYO5o2fcdyDCZ1/mwKQSbx5ejIRK+O58FIScwckuMb7363uOKbf
	 aA2d0rjbQYlTyaEL8D9a1ULrXoRCfk9P3ay3k6CSMdII1kuZ7/6BPSBsfIb/wUf3yq
	 1LhfiGgKne5BQ==
Message-ID: <sashiko-outbox-220635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 05/13] PCI/TPH: Refactor pcie_tph_get_cpu_st & add
 requester variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-6-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:53:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Refactor pcie_tph_get_cpu_st() and add pcie_tph_get_cpu_st_ext() extended
> variant with explicit requester type parameter.
>=20
> - Preserve original pcie_tph_get_cpu_st() as a compatibility wrapper,
>   using the default negotiated tph_max_type automatically, so existing
>   callers require no modification.
> - Add exported pcie_tph_get_cpu_st_ext() to accept an explicit requester
>   type argument for ST namespace selection, used by upcoming VFIO TPH
>   support.
> - Add requester type validation to reject invalid values and enforce the
>   hardware negotiated tph_max_type capability limit.
>=20
> Update pci-tph.h header and CONFIG_PCIE_TPH stub inline definitions
> to match the new function signatures.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D5

