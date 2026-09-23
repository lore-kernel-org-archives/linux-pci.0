Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E862D6E64;
	Wed, 23 Sep 2026 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195339; cv=none; b=Z6abdNuU1E+axuaZSkAdVCHE0eZ31SZ7VQpBG9HxRWMomcTNIahiOwMI+RPE3kwFO0uPoEWrUHIJNjF0sqWfPzS+3HcshR69yIrQUocHJWr1mpUeUhf2uDIQI0r7d7WOUQJZNQhup4Wl4XYf1twxSo31S+UJZX66OLYWCwGQfNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195339; c=relaxed/simple;
	bh=ik/gybDTLgxXxdSUyz0vdCnIxM65CCx6V/ylXOxhFoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Et4Yk7SpAktNEM1wrYJBVTAAz7Wsiw00ib8u+wJnikRx3SqtwzySAXVLKAqtDK0wTF41rtzSdLfjWtmEVjB8Pw3uPcEjWlnCUhqtUEvNPh9l1iAK3P9MtW9lT8q0+zpd8SSqd2hGeodA3vmNkwQA6Vcg0nd6uVIi0kPf7A1fqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4d25RrM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H4d25RrM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B17611F000FF;
	Wed, 23 Sep 2026 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195323;
	bh=ik/gybDTLgxXxdSUyz0vdCnIxM65CCx6V/ylXOxhFoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H4d25RrMtPnlr9F0D2zunJpJR7yUyagPLhs0Fr8eXpCx2YRSWMF4kMvCBMXmf3J+M
	 sj0DsT3ZhOZ5AmqxvQlIzXzaYsQOlI87gCHEiQ2pCvTF2DDS937zt3+w7Xy6769uXi
	 TMDNTbHVUKG08LEcx2R88jwgI/8O598TQFLscRM8aVVIBejDhYLMRuJU8Q96TSG5Iz
	 //Yx2qzQGGWJ5dMFYK3nfns85fZpOZmUs9A8tUifIwjHQIcc+naEnkTndMXGQVLWi/
	 56tapOIfS7YTCL9f8xFUXo8jHlE1TNNlDsVysKiniPfVkVG8C33GULxPGbp8bSL1ii
	 dG48qLeXcBboQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/17] iommu/arm-smmu-v3: Add INV_TYPE_ATS_BROKEN for
 quarantined masters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <d27ae4b7788ef8582c60fd5865f11c955e277174.1790188511.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <d27ae4b7788ef8582c60fd5865f11c955e277174.1790188511.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:28:43 +0000
Message-Id: <20260923202843.B17611F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Clearing STE.EATS makes the SMMU reject ATS requests from any quarantined
> master, but does not stop the driver from issuing ATC invalidations for i=
t.
> Those commands would continue to time out.
>=20
> Introduce INV_TYPE_ATS_BROKEN, which a subsequent change will assign to t=
he
> master's ATS invalidation entries. Treat it as an ATS type during iterati=
on
> and ordering, but skip it when issuing commands.
>=20
> The subsequent quarantine path changes inv->type in place via WRITE_ONCE()
> while readers hold the invalidation array's read lock. Since a u8 load is
> already atomic, arm_smmu_inv_type() uses READ_ONCE() to annotate the race
> for KCSAN. Whole-struct copies in merge and purge cannot use READ_ONCE(),
> so annotate those copies with data_race().
>=20
> A stale read at worst issues one more ATC_INV, which times out and causes
> the master to be quarantined again.
>=20
> Treat ATS, ATS_FULL, and ATS_BROKEN as one comparator class. This preserv=
es
> the sort position and matching identity when an entry is changed in place.
>=20
> No functional change yet; the new type is never set anywhere.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D15

