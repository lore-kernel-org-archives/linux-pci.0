Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995102;
	b=JvjLd5Am4rgfdVaibZc4EM/CVZHgncD4LyaV54OqdxF6bRc6l1pQZ0WavJ+RBzGm9pGE
	 t3xZizjUZKFii2DHhigZ+rXvBUGOMfixdBA2kRsqsrx/BYeNojZ4UTiRLj4if01tcc4Ap
	 nRRKTj008ngIviC2N+j8sPiK/NFngksFhNxKMumF74CaJzCDYLHxtKihmou48w3D4JVen
	 xfrVoZ37JFnzGpj5pOcTpaCWBCXnh7/9Y6wuqz8FGW6TTwrI7VRtNyyqxslNVQD8HD8IR
	 AS/sEYgQ77zzUYE8Ppsa03bCvw+oPWflTXOkPSfZUpGW2hAaLAbUZ4PfYgmgQH6BDmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995102;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sOuD7DIZ1N7Lk4J+H1e/U+NioF6bCrs0YcrsOW1saUg=;
	b=PNE5AgMgzNg86a3oL/u4q8Cyx6532cV5YtMm1CJJ4k4WCbTs/AJHuD0qAc1Dxmn8ICvq
	 AIk4XK3u1vWaSnmMA8JQj8L6IDI4Ir158lFFssQ4XcukXD4tR2S7VFpZA0UsDU+HC2NAT
	 63ELZIv9MRDhhLke8K9D64MIDfb52f7FM5mdDJZiYkVUc6qo4FcCZEFdZs4y7x1tXFM/n
	 pDpegaYjxP2T4kqJXKtIb4UEB7Ny7/c40xoKnyfGmUC5OBBIWsjdoAxBOCIECJpvu6KNK
	 /hPDZ8TB+w8XJbsMwoxazJESkmx2TFud180dP7d4FyZmEQJ/YmJvlyNbr/4ZbTeMv/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIXl7m21;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C35606A325
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIXl7m21
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2EA1F000C4;
	Wed, 18 Nov 2026 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794995101;
	bh=sOuD7DIZ1N7Lk4J+H1e/U+NioF6bCrs0YcrsOW1saUg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIXl7m21GXFIl3bMpdUSNBWDHa/vlnky/ZrOdAu+6J4qyf6LVING/VvfCkY9FkQPN
	 K/aj7/fNPtktu3T0tMa6V++lzN6YKuM4/V2HfiqurbDdmJZgoA2BlFckK5t8Rv/9tL
	 7CUzTUkKxbpBH9f2oHh1JDR2uk048ijgSklVFLkTdqmMT+wwU5arxNqn/TvP1CY74g
	 xKwqnYDnPQlIS7ClWU6cCvqjfOmusBNuJwNcDAOK0DV51bEFoSuuuYjNWVL/sxN1Yz
	 ecKKh6olH74jT/a64EzOXFhLc/XrFOQ2GiqfG5tMPzSdDpbfrxAM223csM+l5g18vX
	 lkoSqXEPjuaOg==
Message-ID: <sashiko-outbox-220618@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 03/13] PCI/TPH: Cache negotiated max requester type
 at probe time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-4-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 09:45:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pcie_enable_tph() recalculates the TPH requester capability and queries
> root port completer type on every invocation, causing redundant config
> space reads.
>=20
> Calculate the negotiated maximum requester type once during pci_tph_init()
> and cache it in a new pdev->tph_max_type bitfield. Simplify the enable pa=
th
> by reusing the cached value to eliminate repeated hardware access.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D3

