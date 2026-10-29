Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238095;
	b=tKhGeVUFv/GegHEgJWuLXWFmEdKosiPiC4j0WAXmsVIWgNBQxk4WkOGFxemmejYzQzG5
	 yyWFhuPPAaHlbncQjzWwkt5FHImPM1zh7FXgfQtbZbBnpQh2mJiCiC7QqDD37QAvk8WCo
	 iBFGRu8M6znXznbkcsp35Z3zFzVZW5z4P9NzcFDA+ENq+Mt8vuHzjI8gYARKE5G6Eb3fn
	 PRI/H2ojqiFo3iwKFBT5D/tuUOQM07b1Hz30Kf1Ea0qDhuMFwgvRNb//daq7SxO44aYwc
	 BuNf7jUWJU63UOIqqd5yEUVwhj8qC9NypEAkFZsaVDBPwNE3qVLdcp+37wwldjxNonw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238095;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Un0ZTWXf40atHdCz4/9dtBWaLJdCxZtxT5kqKuYgVg=;
	b=iw0imAe3k5Au7lAWm8SVNYZT0cLnDkRmnUTOfhRCcBkMGH7Xu6BFWHEj4neDU52FYi0o
	 06ELZZpS8dbCgru368wH2cXZtqsUsFfFMRDrSYuZ7Ex33C4p+b1NJEwQgGHRjJitbamnt
	 B9AMQieUDIGrFF0DSsV2HmhjNkV/vsb2MKYb5MEfbiTvHRRIl7eNx9ekIdOHxQcclr/lv
	 aKyuuab9pa91XJn3GAi18bvyM5CaE40ZTDUdRg9XA/jXon573MNsD3wDfOXmqrWHxDA8M
	 KoJVEUv1uzn0fw3BN0I96RMAO80o9hTKGrSWrFl/KM8cWt3NJDdwsIlM1/TrJ+5LLXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k10ybUKv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E50606A324
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k10ybUKv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C178B1F031E0;
	Thu, 29 Oct 2026 01:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793238094;
	bh=+Un0ZTWXf40atHdCz4/9dtBWaLJdCxZtxT5kqKuYgVg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k10ybUKvYC/CADhYxFbAYkthkgqJqXn53rzPu741/wt/VhXk0BRIZuaunsVwSKNnq
	 16i6gEkOl24kT4wMK4K5/SzQlHOCTQKFod+ilnokGeaCecFs0SqdYZYKiArz7Zy6Ra
	 TRBMPSrxSkOaIsh9HF2UYG3lfD+bw0becAXPRMb0QX6X9O9Cu8k5y48nqdLlQTjx9g
	 c15DnKGi51N+mh7Z+LXaWNPC3TR83irj7TE44JpMJDb5PbtglrZpPZVhl6xxOSxs3J
	 9c9BV2zryaGwxOETf0A0/4DwElXhg+AUGvPrWELRigmLwJxftf/WHYRXriyKq7OGjd
	 ACtbyPUpxWMlg==
Message-ID: <sashiko-outbox-188600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] docs/zh_CN: PCI: Update the pci_device_id header
 reference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <203f4407e5ed5335cda17a74fa6aeac311a572d5.1793221199.git.kmehltretter@gmail.com>
References: <cover.1793221199.git.kmehltretter@gmail.com>
 <203f4407e5ed5335cda17a74fa6aeac311a572d5.1793221199.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 01:41:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> struct pci_device_id moved from <linux/mod_devicetable.h> to
> <linux/device-id/pci.h>. Update the header reference in the Chinese PCI
> guide to match its new location.
>=20
> Fixes: ad428f5811bd ("mod_devicetable.h: Split into per subsystem headers=
")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793221199.gi=
t.kmehltretter@gmail.com?part=3D2

