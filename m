Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9EE316199
	for <linux-pci@vger.kernel.org>; Fri,  3 Jul 2026 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783052799; cv=none; b=O7ut07IC3nSW8e99ypwPhogZGNIqqTo5qU/FDPcJnu9dEgelbQ5fPGx0PvnZTV+tgsAsoR7A/l4JTH4q1+Pufrv23+Z0LBiW5J/59qDTJ1FZOsMn2KzrRhwVKBix7S8QlUUXHchqis+dxdWMm1pSarlU172ewBN1zCt0XdkwJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783052799; c=relaxed/simple;
	bh=6/3BsalpgFDRT/UafcqZ+YPWi+MXk+xvTDGAkLFvYSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B2+6a8ey3A8O5+1G8O+brpDaG7clx40rD/yM3f22cp+03daYPYD3/YoO6oPjcV2sr6g+rGXzlUy/tD7/gf3euXriWpf/8mwQ+22DBX9AO7rxPelXbXHtrSi0gpRkPzYkM9oyFicC903LpdAZ5Cn0gDOGy/YLDObiOqzkP2s+v5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkwWne3T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkwWne3T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5921F00A3A;
	Fri,  3 Jul 2026 04:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783052787;
	bh=6/3BsalpgFDRT/UafcqZ+YPWi+MXk+xvTDGAkLFvYSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GkwWne3T6xKRC0PXPsBogbXvjaKdu3NPLE/3cdT/aL630DJNUPUCP+TAMrLgZ2+qE
	 t+OCNwo43HCXIp1e7nXiqcauscxRa5DYNjLtxapR2wLQHNOh0nV16S1yb+4C+a95Ea
	 QniGQcIfKWaG5GjG2vgWLOG0b2ef6Lv9yfGozPe59t5pOCnIhAqcdGmyXQmpp5lI63
	 Jw4lwnWTovfC0eoQfFpTp7MH+oNSGrJkYzVZB5zAvuknL6OJztqTyhZt4DHEVCCZ0B
	 2SD++tjLTSrbERakvD90Hwxy1fApl00p6eI4bRRoKSaStlwIzmli6wPqNJ+AfI2k/t
	 jLuWbPm3L882w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/18] iommu/arm-smmu-v3: Mark ATC invalidate
 timeouts via lockless bitmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <032232b9bd506075910c9a809138c0a2ebcbd5c4.1783044582.git.nicolinc@nvidia.com>
References: <cover.1783044582.git.nicolinc@nvidia.com>
 <032232b9bd506075910c9a809138c0a2ebcbd5c4.1783044582.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 04:26:27 +0000
Message-Id: <20260703042627.9C5921F00A3A@smtp.kernel.org>
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
> On the issuer side, after polling completes (or times out), test and clear
> its dedicated bit. If set, return -EIO to trigger device quarantine. This
> reader site tests with a plain test_bit() first and clear_bit() only when
> the bit is set, sparing the shared cache line an atomic RMW in the common
> no-timeout case. An smp_rmb() ahead of the issuer-side test orders it aft=
er
> the completion poll, which may observe the completion using a relaxed load
> that would otherwise allow this bitmap read to be hoisted over it.
>=20
> When inserting a CMD_SYNC, clear any stale bit left in its slot by a prior
> wraparound, before the slot becomes visible to the SMMU, so that the GERR=
OR
> ISR can only set the bit for the new CMD_SYNC.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783044582.gi=
t.nicolinc@nvidia.com?part=3D7

