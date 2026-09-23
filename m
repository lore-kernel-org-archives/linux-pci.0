Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7DF425CC0;
	Wed, 23 Sep 2026 20:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195062; cv=none; b=odJnXePMqSFivkJWqQnzwww3Be4s6zMyq0eXB9iGXQj2x+wz19c1Lfi18Bh4SzWNM5l2NVqBlIqoqtkourLsodQD4sfqhSwttPtLPgnY0kbiMm5ijhqHoT42oLnhDEtJZEIu5nmhwJ2tE+zwE/Png2V6cU0Ve03tkVJ+3L+8aoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195062; c=relaxed/simple;
	bh=W1ClhZ8FOWrO5yzZKGnsBCEcLDMVnHubq5vKdZyiJSo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VAHS9mUaDB37Pk2o3SAxJHoXKTYC5HeYvYAIsbWUevtt40TYMsBpn2NJA8vCfawnkzNz0OPN/fDVQ8dbWskjbE82SO5E3FGRXlUKKlukqp/4nqUsQ42tVF/JhsXoTMLvw/ZLrHKZXhNTQHvGXRGZ0bdSjkMGA1pjPGdBKLExTJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Um+c2h4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Um+c2h4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1DD1F00898;
	Wed, 23 Sep 2026 20:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790195056;
	bh=W1ClhZ8FOWrO5yzZKGnsBCEcLDMVnHubq5vKdZyiJSo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Um+c2h4uNf+tjPXbO9Q4L2IkWbv7UYWBIvb6E+8o6ZgoLPX9xV5jpQIPPIMWlfcUP
	 yIc/k7uwukmm+xMQZDn9DYurnQu8LObwHd9zs4w2B9woOLu4XOlmHs8IflzXx9xoZh
	 93aakxaiiBjWDDJ8xHrtn79q/nkNhxaInODrxE9gKgjV6TptWAh8C4GtZKNRU9IFKY
	 B09eqje0IohuoMh06bLb6W/58lj+4Anr/nu9GEJ2hRx7NAuBMPTr1P5TL8sT2fhDfj
	 rWk7TEZKMHAtrXIT4gKBZYuGw1N8zMxnoDQOsTErQcuTD8PX0qI4iH0jKjtWGQG3li
	 urk3l1eJLVFgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/17] iommu/arm-smmu-v3: Track ATC invalidation
 timeouts in a bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <7cc48ac58d0609b46d39291218db12ea84991ab3.1790188510.git.nicolinc@nvidia.com>
References: <cover.1790188510.git.nicolinc@nvidia.com>
 <7cc48ac58d0609b46d39291218db12ea84991ab3.1790188510.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 20:24:16 +0000
Message-Id: <20260923202416.9A1DD1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> An ATC invalidation timeout is a fatal error. While the SMMUv3 hardware is
> aware of the timeout via a GERROR interrupt, the driver thread issuing the
> commands lacks a direct mechanism to verify whether its specific batch was
> the cause or not, as polling the CMD_SYNC status doesn't natively return a
> failure code, making it very difficult to coordinate per-device recovery.
>=20
> Introduce an atc_sync_timeouts bitmap in the cmdq structure to bridge this
> gap. When the ISR detects an ATC timeout, set the bit corresponding to the
> physical CMDQ index of the faulting CMD_SYNC command.
>=20
> On the issuer side, test the bit after the poll completes or times out, a=
nd
> return -EIO when it is set, so the caller can quarantine the device. Order
> the test after the poll with an smp_rmb(), since the poll may use a relax=
ed
> load. Test before clearing, to spare the shared cache line an atomic RMW =
in
> the common no-timeout case.
>=20
> Clear any stale bit before publishing a new CMD_SYNC in a reused slot, so
> the GERROR handler can only mark the new command.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790188510.gi=
t.nicolinc@nvidia.com?part=3D7

