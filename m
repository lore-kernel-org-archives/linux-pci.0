Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116400;
	b=U7oyTYFOtwMqBlrMWjVYnf4FOY3+tDmOh2LFVLUzYZUpSVhkGMvvxQQxBNm+6bu6jcC1
	 2oyJVkIAGmqMz/vFu0o9d75/v+hUW8gNpfCBG+TCjN+w+sAhwgGhlBXTcKr/wmN5n2PNp
	 A+RsWU12mOkE3q9P3XMroHJiGQZw2PoCF08q7EMHjQMXRqkWF/k7Qbiv6ZPSwnIhPJ20x
	 8UEgyo+CJowDXw+7iyVh5e9wjsVqfW4rTQxdjscXOfSjcB3ZbqDfAPBe8G0fKk9yspJWO
	 lgsjYon/GEfksvIZf3Ih4V10yVeKkJglFjeWkwdCA3iEXu0GyjNO2NsmB23Vq9twskA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116400;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sjJwcd3TMN5OUVX45Wq0Xz3Jyhhq0jivrY470OqlJao=;
	b=B53GGVnFFZ/eWrPlcUWnXUp40qla/8aye7hfQ71p0JaxzOLut80TbOzBc90GLMpSV1bl
	 rtXbS5DpkqpFx75SZHc/Wvhq+dKh4xQycou9X+ua+LOTrve1GlZ0Y9R0TFIoPJM2fmE6l
	 oajvj/OxdzpkhvbEiOujSltZOLR/+/Cv+mEvD1KsrlqcSGylk35W/PxUa8r2k+h+XP9rD
	 vFk2NS9tDl0yTQsFE1ULw6ZT24JqQKBdStVZnI1p4bR7f/L5nW/seR/sGbfP+Nbtepw3B
	 ecZ1ZesHAHqSmg62msCWTyMkK57OjA0qWPx8wpLuRZbRVjDOvy0w00jrpnjQ9tM9hIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJTQPcDF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C55606A324
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IJTQPcDF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EEE1F000C4;
	Thu, 19 Nov 2026 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116399;
	bh=sjJwcd3TMN5OUVX45Wq0Xz3Jyhhq0jivrY470OqlJao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IJTQPcDFLoBITWdf5pEkMBKzxkmLgX/h7Mn4CGuvnXdi0+oy1yrHiCG6U8c8DsVzu
	 eXFgQDJQJ50WjVMiIdMLDHr7Kk1M4QjraJZhGXRZcK0uImm9WUF9M2Bhq6kmqCOw3j
	 Tf+GacPPZF85Jx3TpvbKQ/fL9BpHJTaeqoMiondgqEs+TtL7LcLRxDDEGbocyXj8w1
	 gCmEtfVTM3BuJR/4j708Fz9SwZcYn7Xx+Kq2ZPqT6Ua8TaWtLinllXdp6vlZ8GiXlD
	 VdFqWlpSBgZwZfarwT2IjSk8KZvz6sb/WOqkeUE5alxD2/7InJ0zYC/pw2LLHJ738m
	 JMLJVFhV/6QCg==
Message-ID: <sashiko-outbox-223879@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/3] drm/radeon: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261119-vfct-regression-v8-v8-3-12463194e457@amd.com>
References: <20261119-vfct-regression-v8-v8-0-12463194e457@amd.com>
 <20261119-vfct-regression-v8-v8-3-12463194e457@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:26:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> VFCT records the PCI bus number from BIOS POST. The current bus number
> can change after PCI core renumbers the bus, while accepting a mismatch
> based only on device identity can select the wrong VFCT image when
> matching devices are present.
>=20
> Compare against the secondary bus number of the upstream bridge at
> FW/OS handoff, which the PCI core caches before any renumbering. Fall
> back to the current bus number for devices on a root bus, which is
> never renumbered.
>=20
> While here, return a bool from radeon_acpi_vfct_match() so callers
> read naturally.
>=20
> Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft =
filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-vfct-regre=
ssion-v8-v8-0-12463194e457@amd.com?part=3D3

