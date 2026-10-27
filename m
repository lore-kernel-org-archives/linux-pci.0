Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118848;
	b=gYEOBpP519jxfeipHLigbB4mxCUvXrfBtlXM0c2COMDjRGzDkH+qQMCc8taiZujc0ZYT
	 V/jjsY1hg/DBXdA7nYSg1H93ckKDKh7I/EUIT9xIaHH0/GCL4rcrLGrTXX7PDNQHM0UnW
	 88OKjZelUu+gQ2biQJtmHcPKyXjOnp47lBV6x89Jlm8NIG+sdLPBKysOkXvCq7ceGecnD
	 gYK3vCbRi12EUL8FilxUHd1ZsIyIv3QMaI9Ka7+GUJ8lX7+3b5k7iDON14RgjUmPfMPA8
	 sn3BS4cJ4tEouO6YFUb0M/jdKf5e13y5RnKx0FUcexVUtR4Ewi1Gqju7xyzhZ77q6AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fG7vjn1e7G1hHRyJ9/mdqNVyy8TcH8r9a3WMXbtnmFM=;
	b=aPP2woBDoSdYOV0lPTywFSnP6kCkuldz+1T9lheBhBdHty9DKI8+pDP/CXvPNl8GfeAD
	 lhM90Iu2/FjALpG4H8z9Aq8w8xgXFYaidu+61raSx5RexhmAiJAWXLZBAxLUpjvKu1M0a
	 Qqnq2eQo8XUzGz3KJw2nm9J0lBq8MxdrTCfuyWEnKiw/LxB08ptqr7YXsyAzBD4m+k7JQ
	 QM6mzvuSEGTUZLnmJDmpJ91zrtFri+MgFv38S11YqNvk4MH1lqV/fgZ7PnmpVv3CUOwEz
	 Ifzsk02lOuwNN2CYJ7eKdnrByqVnv3QA5NMsxSv4eOiCo6M2N5C4ho9MCgrp7RbfbOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBYmAx2f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FE606A331
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lBYmAx2f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F25F1F01828;
	Tue, 27 Oct 2026 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118847;
	bh=fG7vjn1e7G1hHRyJ9/mdqNVyy8TcH8r9a3WMXbtnmFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lBYmAx2fLAlhT0hLOxQrxGkL5duixdpkrMPddvpD0GnLrv/u27PGGFZKKebfSaWTi
	 czXo9+DrrAE4DzjBXamKNcfxaejoWdXP38CpxERIsU62foF+G0H3Xy9jkJlowQjHQM
	 DC9NBQd5GcJz+8EPdb5iIMyUdtoG/06Hz8iTQ1Uxa1FEBMmPU3SNDSgtzPHwV22Ujg
	 TBCXeOOf+Q+9xVNDZo7DprIT3Ke4s+EsiGF3bmuYYhDYXHVnMxbbNiZh8Apk5oCZRP
	 5Y0s1aHIKxu8Y4Gu7/pCdrpxf9vVRwKM8L+6w2KBwb9g+nLmf6w8CA7ECtycUMbLbo
	 MV2xpeAiKEVbw==
Message-ID: <sashiko-outbox-186927@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] PCI: Preserve the initial bus number in pci_bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261027-vfct-regression-v4-1-0e7190e39c2c@amd.com>
References: <20261027-vfct-regression-v4-0-0e7190e39c2c@amd.com>
 <20261027-vfct-regression-v4-1-0e7190e39c2c@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:34:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Bridge scans are split into two passes when bus numbers need reassigning.
> Save the firmware secondary bus number on the bridge in pass 0, before it
> is disabled. Use it to initialize number_initial when the child bus is
> created in pass 1, before bus registration callbacks run.
>=20
> Keep the saved secondary number on the bridge so a later rescan does not
> replace the child's initial number with its reassigned runtime number.
>=20
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027-vfct-regre=
ssion-v4-1-0e7190e39c2c@amd.com?part=3D1

