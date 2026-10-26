Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030003;
	b=iJd4vdfv/m4ePxEaxLCzGb5hHEKl/55ilV3xTKJRRpUOJIO+Kp548D+IaxfWSEelpN0w
	 pZE/V51uS0qAklia92FlbcMltdI5Vgh7zlI+Q9cV5u9fuQQsy50IUasUFNX6U/B2oIAvW
	 mV9Nbh3OU3kzEeVAr3nmPQ1m1Y9qAdE78lebuj/NpB0toje1saPkgc+4RXQKDKWbPwFbR
	 2U7s0yeYR6YvXKP8Sw9uWPxcNwYP7YBKaLzCdzoyqqoKK7Zjaz5KQSCOyBEcZBfJbBbB2
	 8+Kip/bWvNxc0m/W0juTaGD1BhRRdNAH4lfCpVL45NxwktLXakITtr3d7sgz95djdUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=22etFq1az8Kir0ncw7hBg4dI+/Th0dcp42s3EVi6CP8=;
	b=CUZwNZhhfcKCoP9RUdmC6VEvUdDP+iKFfD3PjboIegAoPKAvs3lGskVLYrorXxcRz1+1
	 R9IvyCqb4yDTsZsBVQ8WA/pXz/U5s+ilM1x4v3b4jSWOJKrT6Kn3A4td0yhT4aeKELyFL
	 BsBAspAhXoRNSMOPyv1yGbYJPkq35QjV3nB0+nKoP9EWq154Pm8T34RH89hBKUDrbphJI
	 1kQGAQzmddOEDx23JUtx9C2B8TwHwH26uq520QjTccCu78Us5SaBMuktwzRl6nbkHonL3
	 1Bsi+fCWiE8iTOQYNN2qmw4TBLVcEShCQk3n3EDAI5xk+AXcMTEOnxipAmZIyhIUHKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gq8GrTmv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A3606A31A
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gq8GrTmv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E591F01825;
	Mon, 26 Oct 2026 15:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793030002;
	bh=22etFq1az8Kir0ncw7hBg4dI+/Th0dcp42s3EVi6CP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gq8GrTmvD2WOGIyKNYfft/6hIfAW/qgC3UTmTVHj33B7akw9Qz10J2Sw1Vfg2Zc2h
	 iJit5FlfGlpf0XIy8zv+vUms1bMlvYVhYQnE0jD67MWB82thsdb2NyTTQlzMc49AO0
	 oNaaOb3UUfTQH7GCxQpBj8yvS0IbLpgN61ruQwXcvtHk/xrbV4ufJVaLZ1M4BG42sr
	 4etttbRzGUC8hBuwdFu6iC8viMsG5+afyMjIOgp6622giJefuxf73FxVf9v+5GnDQ1
	 QDJtCtE2nLS+6e6KeY8LpI9aacKQE+d/+svFWIWzWal51+Whc4/tMLlPKwg1Ze4qaB
	 3xrmFgMQprB4w==
Message-ID: <sashiko-outbox-185465@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] drm/radeon: Match VFCT using initial PCI bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261026-vfct-regression-v3-3-fe9586ed6978@amd.com>
References: <20261026-vfct-regression-v3-0-fe9586ed6978@amd.com>
 <20261026-vfct-regression-v3-3-fe9586ed6978@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 15:53:22 +0000
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
> matching devices are present. Compare against the bus number captured
> from the firmware bus assignment before bridge renumbering.
>=20
> Fixes: 4059e2f02c8a ("drm/radeon: Fix VFCT bus number matching with soft =
filter")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-vfct-regre=
ssion-v3-0-fe9586ed6978@amd.com?part=3D3

