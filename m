Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792889497;
	b=ctJbAp2/elgrX46zfGlMq4YsakaSk7rIfP1J8r2r+b2chsEBVYaKhWN3iV8aOvkpE5Il
	 AJ7gWK3byYenE9d1EWkWbQq5h91IBACTyn3duDrILieqwdlB0o6Xu1XEVUrWb97thU4U5
	 PbPfSgYWNmj7R9qKl4YDVettWtIfN7OYYE2nOMXScC3l4eN56G/e/BhYCKVD4ok3K2sWr
	 tesCc1NwflP22Mo40BJUnsNoH2jH5g2noPoRhFW6SGZSxSf65xZUotGH1gX8M212JNYzQ
	 IAuYoCGZ2W120UjOfXtGsre2s7mVjv5REW88JGfr1p4amWvn7XBqlCHWkFyahZJTpvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792889497;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sNQhGdUsx6GoNWRBR0Irz7ccf3RJfq5arZ8FVWkgNX0=;
	b=mKlWVlFRh8Xz9bx6UMpASPtScRVEMBZT2A1jbdkBBblarPnk6bzs7VqG9PklkWOwq07A
	 vn97nf3qZyZg75THnE0HtHSVxpX/gTmqTML6AtajcubBVYIw1ZgYhE01Ey4yl1KbJg9Ie
	 4ozZIvlq9fmh5wCuYTq80y8S1gYd+nYP4Qpsj2E+UC+oxM9pQGcJoYfL13372Yx6syd8/
	 eSC3cK8yi0rdDd2EhbWlSmdpdR+WzrCYvt3hw3Lc9nRfX18JtAUofjx6aTsBeonGTA6d+
	 /VXWNfZgvE+xuh7KgeKQ1LfEDtUYDAtsDJREaBJvxDsFSLTVbXtNNgvc7pvJ2nfrF9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eQ5q/gcb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C16606A31A
	for <linux-pci@vger.kernel.org>; Sun, 25 Oct 2026 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQ5q/gcb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C0B1F01825;
	Sun, 25 Oct 2026 00:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792889496;
	bh=sNQhGdUsx6GoNWRBR0Irz7ccf3RJfq5arZ8FVWkgNX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eQ5q/gcbcR+g2vlC1CFoWGY9a/2vmp3Txus63wFbBR4A1pO62WC32C6O5ZBjbsDBs
	 QQWT5zQ6a2A/YHDTQo4skgpRfvBy7Re1sH4R9QT+nfppxgHXZ0guvu8IN9RtwwUXCR
	 hbhC7p8nuQ37NAJhs4ITmpXzXxzZ7as/Q8FmVXXoUXvfbc2z5ovkPmGSGbH322i1nD
	 Padgj6gyaDhFs63w9VO76awnA91k6udWhVwMh+lDqZu38jsb3j51u6vfOWTYEPHuJO
	 q7cmM4LerayLatIBzyEr1J1pjzzbmqyZReGSk+B6JSFCsSKB1r5xmHTA1Pwdbo9Z4g
	 Hk0t0OnHN3QUg==
Message-ID: <sashiko-outbox-183955@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] PCI: Add pcie_capability_user_read_{word,dword}()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matthew Wood" <thepacketgeek@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261025000836.58294-4-thepacketgeek@gmail.com>
References: <20261025000836.58294-1-thepacketgeek@gmail.com>
 <20261025000836.58294-4-thepacketgeek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 00:51:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pcie_capability_read_word() and pcie_capability_read_dword() use the
> kernel config accessors which don't check block_cfg_access, so they
> can't be used for reads on behalf of userspace that should wait for a
> reset (or other pci_cfg_access_lock() holder) to finish.
>=20
> Add pcie_capability_user_read_word() and
> pcie_capability_user_read_dword() helpers, which provide the same function
> using the user config accessors.
>=20
> These are for use within the PCI core, so they are declared in
> drivers/pci/pci.h and not exported.
>=20
> Signed-off-by: Matthew Wood <thepacketgeek@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025000836.5829=
4-1-thepacketgeek@gmail.com?part=3D3

