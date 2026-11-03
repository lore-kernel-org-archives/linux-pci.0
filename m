Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731451;
	b=xcrZlNucPHhQr05AW1oAHTRtNNYddYL3b/PxLd1F93GdmRrm6iA6NZxvtyWliiqaBLFs
	 ZRHNitJBSBiCa4tXOa/6sgNaez6UfK+bdhwJnW4jGhxaN1kI4DXCjA5IxIoEx9+zAPfVu
	 59VEtHIjsto+tuRbjmiDYtkGBwdvrQwsAp5uRd6ModwPp4+S9C2qzs4C6HEF6+TsfrJ2C
	 ZOaPaUIkAxU1gLIG50xuszx74/5PeQyZbkDAP+FGcuH6Ix+0uODoVbk69vn6qc69daWoS
	 eIzcPoAOJQ2aBBycMTqkjMSbFaKVxIw3qJb95gGRck0Y8SLdJLlzuZKUa1VywMS+y1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PgXIcyEKFnyeF/HLyWbTgOp8SsJJ+gNcg3iZUZWTrXs=;
	b=PnS1XhL2G73Pilu4NvsJGtpBqI3Ah+agy0YVy8bcyLA0LBn9wE9m4dJaJ4w3kKRD65HI
	 +2lg6IefUlo5shExS5wuAcSXodL28Fo5f9reo/9kkHzlHFVOfbq+PDIn+VJnXJISnBf8K
	 3gqMG0U97EnXIHtJ20eUjxhtqI12MqLPOseYhhx15pO/d3rVlVCGg+UZtYpP9anYxNsHC
	 b3hGM+3lDy3NAL52i66DgvN5D7HuENyY/V3WywHF8gDmuz3R3ETgp1/o4gMoQKMKhadta
	 FJLV4TDQpqbH1GqGJVQWyFIrhGCsNeMIMyM1ASNg+AhiHYIL3AYVlznlKTZh+74lnUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBnCNF5o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCB4606A31B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBnCNF5o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48AC1F000C1;
	Tue,  3 Nov 2026 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731451;
	bh=PgXIcyEKFnyeF/HLyWbTgOp8SsJJ+gNcg3iZUZWTrXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NBnCNF5ohorwU6p9PKKbpWxfbf3tVitWYiJtJmMND8i9wO2Ht3k1RhSGBFj3asKw1
	 exume2qZ0azYwMsz1n4tbr/kPd8TVuJw6jwC/9orSQup5cwc2dFpv/fVaZXPbRpu4/
	 R1/2iVvCFUXTXhUBN0h9nZh32EjpAJSOY2Ej4f6nF5gvt8xVXoWzM8gVfDOu1iAU6m
	 4PV/VWXxo4aExl1k6sV/s2bjQExK9fVm0rgndn2VPk9wh9pz3vEbb7EynBhHN9umnG
	 IOaQrQQpum988q8o2s4bYRctZc2Cxe9M3TCKhb1FjU6dGU47py7jDUpjy5j9Nb1rNz
	 98iESXhOmu8jg==
Message-ID: <sashiko-outbox-195858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/5] PCI/CXL: Probe the underlying bus reset in
 cxl_reset_bus_function()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <6c09d2f78d4bb9db7f49fa14a6550f5176721121.1793729707.git.nicolinc@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
 <6c09d2f78d4bb9db7f49fa14a6550f5176721121.1793729707.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:44:10 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> cxl_reset_bus_function() reports "supported" to a probe after checking on=
ly
> that the upstream bridge carries a CXL port DVSEC. The underlying bus res=
et
> can still be unavailable, e.g. on a bus shared with other devices, so both
> the reset_methods[] array and the reset_method sysfs node end up listing a
> "cxl_bus" that is guaranteed to fail with -ENOTTY when it is attempted.
>=20
> Probe the underlying pci_dev_reset_slot_function() and then, if it is not
> applicable, pci_parent_bus_reset(). These are the same two checks that the
> actual reset runs, so a shared-bus CXL device no longer advertises a meth=
od
> that can never succeed.
>=20
> Probing via pci_reset_bus_function() would not work: its cxl_sbr_masked()
> check rejects every CXL port with a masked SBR, while the do-reset path in
> this function unmasks the SBR before resetting. Such a port would wrongly
> probe as unsupported.
>=20
> Move the port control register read above the probe branch as well, so th=
at
> probe runs the same checks. That read asserts no reset, and a failure mea=
ns
> the device cannot be reset this way, which is a probe-time answer.
>=20
> Also pass an explicit PCI_RESET_DO_RESET at the do-reset call site, since
> probe is always false at that point.
>=20
> Fixes: 53c49b6e6dd2e ("PCI/CXL: Add 'cxl_bus' reset method for devices be=
low CXL Ports")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793729707.gi=
t.nicolinc@nvidia.com?part=3D2

