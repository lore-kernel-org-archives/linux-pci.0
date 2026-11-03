Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731160;
	b=T3CpsNUsefGTIGDs+SDC6h5toXozgH6c3cbk7HYgtlRMmIXhmJTKaLQYD89FkSJZS2Pf
	 ZJsgyYp+/CEdOOiwAuw9oqoLx3CG0r2UtONtsX8sbm1uXSK7GbAVcBcT6imCXQOY7+RMP
	 dlOuLm6/nEBhEcLC+wMmTFMnjo+4yc/nGqz4YcQNKm1jRzakIInqRlGnD3pFQmazGgdYL
	 hirsTql0e2SLe15mm7sybwg4n5ysYky1/odWgCTuyE2YX36/40/nGf1cG5IbBEl8D8IZ+
	 nFOmdsRSEzEJm9aO7ki5PReXSq05B5f6dpf2er36VHLn/YfAm8jCvzsAXxvo7Ck4TmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731160;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WcIYDN0WM4cdXivr2HhK7SYZuOgRcaKYgtszo26Er1A=;
	b=1zW8IafzkzO4eJHLelpCc4RekFB6y3AihitIRDrM4SDt5tdEuUTZEugXVSBe85KarHB9
	 nAeQfJT1vxF9jWjGZhJLQwIT5QPKiaqvND8pCQVbd4gLSw0dcCydtYU1TO3mwunJoCqfd
	 m3ch/fR52IAw0tA9pB/1TLK6kaLpGs5W6706j5r8ldHYXrdqTSnpkSNGh9WxUoLm3JjJe
	 qyPDEPuOSAeEM61lFVnDxvDj+7Q0PaRjNHQ2ZfySny/FLKQprPiUOnE3/SXQjsHEXkxWx
	 5BeK6wx19/D/GeOKXZPak0hRR4eEqfqJUR8dBQUHVUmbTqpX36ZaC4osgdFrSv4TMQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBHXTKYf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5D4606A324
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VBHXTKYf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99541F000C1;
	Tue,  3 Nov 2026 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731159;
	bh=WcIYDN0WM4cdXivr2HhK7SYZuOgRcaKYgtszo26Er1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VBHXTKYfE/oPeKouM1M4kJNobMxdj7wp+XS37JV1U4aow7/ByEj6qagWH2QilCRa3
	 eW1WmnyHMxGA81FsWlPWKI1zVSDkCMH0JKwl3PrvxldVhVdtOFQUgyx1o2DG1pgQ+8
	 XSGe82xaoCGgFctYfZihr52WgRLXE8Yo4FdFt4kJZrtDGV4h3r3hao4QOWfg5avxEz
	 /YuaKjJ6SNx0CoAfWbWsafk6Um7bvTTPYT1CkW3a3lv9/lKywsM1Q1eZbNwOA14ZPv
	 MWb974QGVX+834s5LD/wmydGx2H2DPHo5ESfn5Ea39XbsBlj/akMMH0FPuPG0quYNg
	 osm/7rMdDos8g==
Message-ID: <sashiko-outbox-195851@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/5] iommu: Convert gdev->blocked from bool to enum
 blocked_reason
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <f60d229c210e30a814528bc402b211d32c8a68f2.1793729707.git.nicolinc@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
 <f60d229c210e30a814528bc402b211d32c8a68f2.1793729707.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:39:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The gdev->blocked flag tracks whether a device is individually being held
> in the group->blocking_domain while group->domain is retained. Up to now,
> a PCI reset in flight is the only producer, so a bool suffices.
>=20
> Subsequent changes will add more reasons to keep a device blocked, e.g. a
> failed-reset case that must not auto-unblock, or a driver-side quarantine
> for a hardware fault. These reasons are cleared by different events, which
> a single bool cannot encode.
>=20
> Convert the "bool blocked" into "enum blocked_reason blocked", provisioned
> with two initial values: BLOCKED_NONE and BLOCKED_RESETTING, covering the
> existing use cases. All readers keep the "if (gdev->blocked)" form, since
> BLOCKED_NONE =3D=3D 0.
>=20
> This is a pure type change with no behavior change. Follow-on changes will
> add new enum values along with their producers.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793729707.gi=
t.nicolinc@nvidia.com?part=3D3

