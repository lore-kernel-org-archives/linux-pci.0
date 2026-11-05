Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906247;
	b=PCjsx1sx9fo6/uDBS9eq4tN94Mr77OnWfKqtwdOjB/PNts5RW2EQs/37j1wMp1RKYSXv
	 z8qZEJXCdjQvEIwEE/MaC1FpNKJUkPyGG3gKyc1xwe3FCI3Bsq8v6W90P0Bz0RomVsK4c
	 yD/jI+l6IspHWRqfw911TmaNw54EHUH8yyyNYmuWspFPqUcx17Z9Mfuf8v/rV+0KAq/Hb
	 PF90nVsZZAqn/Cw7wXZhf7OnhWTFWEt4rgxfvCMsjeFDGh3vXnpnQQxm4BormdS4kKFpW
	 VCRNt9VgPSbMOOB9s+HQplxYV0Mt2oVWtqNme+C7E+6k+xCCRBAnGpnaqKWQY/C4Qww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906247;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iW+l31lXvFkN6UlG7/rD4palFEp5gNVmfTSP0m5zPJs=;
	b=lVDjfuigzSYX3k9X3qmQcbi5isYlvQleKJQRRXa86Alvg55491ObbgAK+TTERWRvB+xn
	 Jbv/8GMcNvy4RH7OsUYBlba3TGq+V8poI2S3ATimu12hM+dM7U98vcqX3PGuppuQGMq7Q
	 gPpf6O2Ns/CYh4mBboc5RBFiTsH4R0zGIW6VzV2VZNtjgTHoRsD06zHh1tRYsyDj8m4jf
	 hQuxl4GiuOn8NcaU6szarvfwC8cuZ1iQA4cgXjRtRw1wO31saV+vhtU4hOOVtbM0Cqfhc
	 oci1WzZtto2oQIt28qt7/YqphU7bFjKjjOxASDUy2kwWauNy0BNUCFN8aGSJopWTsYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZ2Wf2dH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2293606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZ2Wf2dH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A421B1F0093A;
	Thu,  5 Nov 2026 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906246;
	bh=iW+l31lXvFkN6UlG7/rD4palFEp5gNVmfTSP0m5zPJs=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fZ2Wf2dHlDZGaKzE2++7860Gvt8MAFKAF3ZskzLAeVX1VMx9mq6gVdVUiDIF/E/+y
	 aSseKwsUrEY7RfxOmyCT8tJwUJelJQUMvfzi7fuqq7X3bPt0B4fiIXCeFyFjEZCHfM
	 zXkaB6wgc8NvWAUhH0zaZpYv+SHkaqrAFS+W5MK4DtHWBtBqWdnAr5IcQZ0S+A2MEB
	 SBuzuLc1+fJIKElSLYU1QmOPwkk5KqyXH8AwNHXxqrej/NyxfnCv1c5GQgG+/Mcl6/
	 oJiUFxsYT+gOFDqWof/oEITN8M8DgOGUsivlQTQe62vf9g1cczdQYOqgN+rzIRP/pg
	 EW5xw51HC16UA==
Message-ID: <sashiko-outbox-199835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 12/19] PCI/CXL: Add CXL Device Reset sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-13-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-13-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:17:26 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
> perform supported writeback, drain transactions, prepare the IOMMU,
> initiate reset with Memory Clear enabled, and wait for completion.
>=20
> Observe the 100 ms post-reset quiet period before polling Status2, and
> treat an all-ones read as not ready. Wait for the timeout the device
> advertises, up to 100 seconds, and access only Status2 until reset
> completion, error or expiry, as CXL 4.0 section 9.7.3 requires. Control2
> cleanup runs only afterwards. Treat Control2 command bits as
> transient state, restore cache policy on exit, preserve the primary error,
> and abort when IOMMU preparation fails.
>=20
> Reuse Device DVSEC discovery from cache initialization and keep the
> reset entry point declaration private to PCI core.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D12

