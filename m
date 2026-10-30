Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381012;
	b=ifER20WmuDoS1zmz4EHcx0E354dEGrPD0YXSyOwQMjduHNUpwCl3naaDPHIKA2ZVXnxF
	 ydIfxpChnNnB0LvI20R56dKM4VxniKOXU1SpkjtvMTJvWHHSmgs3PT/4OurfmT7hmc3w9
	 nTgtp6Eh9cUyIoE+q5LsfRRmWnueaja7nxiOIqHrssYI8zQ/hYQMZaEAQXdgKy2UEMqLD
	 OsjR7bzdjVT2mSzG2EoA2aS+G+g86lDsxTCdaPjVCge9w9Ss1buvsVzh5c4BJOC/S/w+I
	 0n/9XgJqQollgmVsRxw2swAfkvIB117r3gnYLvAnv9Uc9m6M35ixnV+OSR1/4zUpNFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381012;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A6M8emdpAwqCROjAFP0fm/aQxtZAzNn3wIgSZeuUwH8=;
	b=onQ4uNXsRFxySpjI1mwbXh7slcsTqOulNRKxSIi6WjBox1Ssw+Hvc4049FQhUzbEAtuF
	 30t/nBT+Q5a+zf9d7TY6G96yj0GZVBz4ViKU0+n+QIfvlMRmcuxCUOEGU/y8UHW6fk04C
	 kJkPi0UmDgyqcHms5S/gdJ1E5ZevYb/mirIWzfzkxoUBV3ptrZojz+y6YX64QaOOF4urF
	 SpApz32OtD0QHwIW1mODWzU9gcMepUCouPU3SjsICvlZOIMCkurkc+GFS0OfAj5SFJb5t
	 quPQ9DdzpWa+9veZsuCusPcuTi2bskqd+vrYz4H6ov+0i2Pjs1OrUryucA93Jn1FXLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGr6S3J5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F17606A31C
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGr6S3J5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEED1F00A18;
	Fri, 30 Oct 2026 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793381011;
	bh=A6M8emdpAwqCROjAFP0fm/aQxtZAzNn3wIgSZeuUwH8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nGr6S3J5oNaXWYY8u4s/4kScoKg7Bt3U9FsVro63RzUslMxsDzpxZAwZGegcMAjaz
	 U07jXyITqyvuTd1ZSmUum038Us6yN5NabCLkQoOZuw3BkNNl7mf3Ie6UN/Pr06TkNq
	 NUuN++pNTpK8Fh118yZ5oTflBl19DGDPCvEfv4SxrxAL+IGRM0GHEumo03Wgww0jLA
	 +pPPn80Nnh2ORti7EjiPuTVlPW5i4TA8x7R5hmPSive4UcCO3aeVrPckD0HfjfX1Gz
	 uxdI41SWJZzxnQcAfbuT+iWLBAq+tqJbMUMOu+Ot7gXWswu6NaJd9YFRBDgnLsA5wU
	 +AaHqa2D3Zwfw==
Message-ID: <sashiko-outbox-191332@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] rust: pci: add SR-IOV enable and disable
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261030171230.196717-9-xinmengs@nvidia.com>
References: <20261030171230.196717-1-xinmengs@nvidia.com>
 <20261030171230.196717-9-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:23:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Peter Colberg <peter@colberg.org>
>=20
> Allow Rust PCI drivers to configure SR-IOV through sriov_numvfs.
> Split the C configure callback into sriov_enable() and sriov_disable(),
> passing pinned driver data and a token for the requested operation.
> Require drivers to implement both callbacks together.
>=20
> Return the enabled guard's VF count on success and disarm its rollback.
> On a disable request, verify that the driver has removed all VFs before
> reporting success. VfRegistration handles VF removal during PF teardown;
> these callbacks only handle explicit configuration requests.
>=20
> The PCI core invokes sriov_configure only through the PF-only
> sriov_numvfs sysfs attribute, so no extra PF role check is needed.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Peter Colberg <peter@colberg.org>
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030171230.1967=
17-1-xinmengs@nvidia.com?part=3D8

