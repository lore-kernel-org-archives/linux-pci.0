Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118033;
	b=p7wWj49SFZY5SAoDf8OE4uYRpWRvd5PuNig/KvtQCWgBw42RcWrYB9CH536JMsMhXDqy
	 BCWT+MCDAc/KZpHFN2DOcmvwdgtZiBtipcJ1wIMwZE5ZnEhHf8OmxjxGwUvo56ozvnH8T
	 uRkh5ZYa6SkmLaqnCo8PtbMjr8BhhtNJ7jObiuMvpk6QHyK4nvQ5ti26umNrwoNnUTbH0
	 5Cla6T5SHtj3rntZohWyKU5umwpt0blnTQta4szeeD2b+7Dkv/BpWW4TizalgULBh1m9H
	 zDdon6MSjlmnBIAzU9BQ1qGiQhAfgYEF9sUKhR3HoDC5Duaax1EwgnqhD4F2z8vlH6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118033;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+CqoGAwUEsvRg6eGVElVtQaLJpyOx+h3r3LxgqwdwoE=;
	b=X0hse2noYMaBSxieRm3K8fKb91PK/cNh8BzGg40fapY9Lvgpi8BW+CSHdEgMl7eJwmHn
	 he9yFjIGv7l6P59mnrmNkX/xRveifIjkA4UAx+pRNLBMvqWBFJCKhC89LtaVkH2pEUGY0
	 s19KFTTzm2S2LJ2lyaLNTTYTCPr5zLuyVTT4SqS/bggX3NlvOW0IDiTMQI2jtuiGDfx73
	 pqq4VpyXFyBcVmZhG5g1iYABH2D1z04KRKRBKTxAVh6YPa2FoK/GQohz2j2DJbIHs1Knm
	 LodEJV5GXO3Qrn/bT1hIxGyPxgjX4ZDL789n69xaVAdxJOhY4U1fmirxW4ihwMhKPdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="G/TOY1Mp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC22606A31A
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G/TOY1Mp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09FA1F01825;
	Tue, 27 Oct 2026 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118032;
	bh=+CqoGAwUEsvRg6eGVElVtQaLJpyOx+h3r3LxgqwdwoE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=G/TOY1MpGCB6jCacyxiUboKLJ9y+6MJVzY3onHomyL6/qhj7kLPdX5Waen/YHjOkl
	 KtYkxlGU4Uknm+Xm6JzJ7czF+BtUNjHOnzm6RpyPLf+XyTZHreNUyRkiM9VUXS2hsS
	 roVuguBXCFfyV4gZct0AC9mNd/EAGyjuji97G6VoznuV8wJEd0pQEQfFSTQBrpIMNH
	 hT7b+ZuTmJ5A/45bH40/pe9eDmxEDv+ji0JDIsVCTPNf3Qm+07XTtjkXo+ANGJeZph
	 HmodQdonghxpQH4J3Cx0h1ThUe5JWXiiQ0cTc9JmQKmpgc/Ny8nWQrj5xY1a9d2PHa
	 HDQGWcXg8/QFw==
Message-ID: <sashiko-outbox-186899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] PCI/IOV: Allow bus reset_method for PF with
 VFs enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-9-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-9-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:20:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_parent_bus_reset() accepts a device for secondary bus reset only when
> no other devices are present on that bus.
>=20
> While that makes sense in most cases, it is too strict for SR-IOV. When
> a PF has VFs enabled, those VFs are enumerated on the same bus. That
> causes this check to reject the PF, even though its VFs are in the same
> reset domain and should not block a PF bus reset.
>=20
> Ignore PF-owned VFs in this check, so the bus reset method remains
> available for PFs with VFs enabled.
>=20
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D8

