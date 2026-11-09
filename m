Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794194347;
	b=EVGsCob5k9e2ajCnNDV/NPt0L+okDvmHeHmwMItkgEJNx1e9frUT2ln3/SVufqLl2mkG
	 6g/DfiPVcdJy/1fddaTveBurORk2tOumMLxroiGbr30UnrLsqbO+oWj4gkQatHm5LOApA
	 BOU1MpTnx3nqOq1f+O1wcxlw+anaScQJb4o9YewL+Xuyzvn7lPgp+LXG+ZLf4q2gPe48p
	 1yrTlm2QDP3Kh41NkP4X58P9xcnuh1EfPgUkEJc+XruJPavu1XEtvv5NMXEsA0aTmk/Qi
	 KTCZI6hzAvdt2ThvSrjYbV/nPsn8BEFBihGu35V+zYttVpmRoR3Z5SGeMWnk4+fying==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794194347;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=31A3OVdZM3nXI0ZELYtVYTwENN5kmcfOE+L6jQGmb0I=;
	b=RHwetDPWry46Lw2I74k1Gg990iUMhv8MMOUt0P1YmuJn+LYx+EJ7ahFsZtKjosQK5AIA
	 EQlpKlOQ5/mR7I3aunnU4Gmj0P8QU4z7+pleqXvYgsy4qokan+dWhcwJMEi0OCAmzYSpk
	 QHXXe+b+DU8x+8iXaGy5D/zwnBgX8qpwZSbEYFBmTw6ZZkBAaukqK8UEtfA6A8OZURL7g
	 CjkeLHxr2UJInVj07C7mzcJ5h+Iq2ek7o+warxQH4vcxMZ9NOkcmiTNasna+80Mr6qWJN
	 CZpirT/NZUgok/8J2xbxXXqrJpYTN2teMSiAHAfLj4ItWz8Cg/TVCYjvmc0CygNIugw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRbZMV62;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B2606A321
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eRbZMV62
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3A31F008A4;
	Mon,  9 Nov 2026 03:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794194346;
	bh=31A3OVdZM3nXI0ZELYtVYTwENN5kmcfOE+L6jQGmb0I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=eRbZMV625HIUH2CltCKaXIoRBSr+iKwzt2X5ySZK96vZcs7c8Q9QUwb3rKoumDAiX
	 B17WCMkFDVqQ1SOHNmm7wHjgqFC/c4rH1kQ4aTAE6lByGl9dYQpRYSHvL4iZKHsCeT
	 AAsNviNpYy0syWS0hMYkapaYpWL0FuwYIaIUj26f+1MbFmKyZAXqbuvglqYfk6dz0S
	 r+4gKnGHldXZrPYWCC/fzImCdkob9IgMmGgJHA9gka7ka9PcZco7JB2HAmeZHyPg6z
	 zfZooZ5INjHkm6aVKshcmCLts5I7SndQCJkfNQBwuAXbxaURhfxssYyD60xfPqIsx0
	 u74QL1VyDBgCA==
Message-ID: <sashiko-outbox-204367@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/MSI: Initialize MSI-X descriptors in the setup loop
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109031411.2205-1-lirongqing@baidu.com>
References: <20261109031411.2205-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 03:19:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Li RongQing <lirongqing@baidu.com>
>=20
> msix_setup_msi_descs() reuses a single stack descriptor for all
> MSI-X entries.
>=20
> Since msix_prepare_msi_desc() only sets can_mask for non-virtual
> descriptors, a virtual descriptor can inherit can_mask =3D=3D 1 from
> the preceding real descriptor.
>=20
> As msi_domain_insert_msi_desc() copies the descriptor, this stale
> value can cause pci_msix_write_vector_ctrl() to access beyond the
> mapped MSI-X table.
>=20
> Clear the descriptor inside the loop to ensure each MSI-X entry
> starts with can_mask =3D=3D 0.
>=20
> Fixes: 3ece3e8e5976 ("PCI/MSI: Handle the NOMASK flag correctly for all P=
CI/MSI backends")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109031411.2205=
-1-lirongqing@baidu.com?part=3D1

