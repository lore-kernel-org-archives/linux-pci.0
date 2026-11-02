Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618969;
	b=H6KFpfVeyBaI+lNxzYGDyTPNE02SuhYUwwFFTbAuKps6HPHXsR91Fd3fadjfUeCfrIIG
	 doIpiScztjA8Z6iu3+qGAw6kMYth6LBhRdq8xwjkM4zkbR+//TnWGhUodlRHIVq0IRSp0
	 YwzQa9I2SJeSorzzw8/yb2bYby/iVRCHbz8ivKgfFz+RqBJW440Ja7BdT3a7xp6G5qV06
	 YpupAkFMwaBmFUktS+QEaCHivbv8VZ06unSYM+qS8Vq96++02DF6IDlWS82g305qZERpM
	 4+lbjgbmK1qwe1hAobSR5UxVxDTOa8fBKcO2NIZo8HOeih/fvXMRhPTq2awa5kyNeqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WblFal2oQlJyjGE+U6nJiGJz3t69TKmvJ5n9CC/nRKw=;
	b=NBpOt7PHOEocO72xItjSXGd+ugmt3uHJ9uL8Xl69OW7rxZ5Xg5kR8iF98Tae/qZg1Mcl
	 pfkQ1B92JzSztPaE/8vtK4Bj+hJTIHr42tFPpMmbmAYQw0zlrFvKJNDLo9JDDaosQQ+K2
	 8lKa9OUJqkGoUCE41+Dq7YFFOZcHy5FpKfp4ajSiIQ8kXdvmEMB/URefq9yobTSzwgiNr
	 fUwZsDQjPUSr+Hi4QoVvcWSRQySO3P5eEwooNv9mAEmKh0XJlxYF/bWmQ/Zs5XC9oo2UR
	 hYrDvPcUQfMwGSAdLJXD1wohoMJFkfzOetbMm87SLl1SxBFf7lHtleKgbqWl5Nl2CDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XYXgf/FM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DBF60A3803
	for <linux-pci@vger.kernel.org>; Mon,  2 Nov 2026 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XYXgf/FM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92C21F00A16;
	Mon,  2 Nov 2026 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793618968;
	bh=WblFal2oQlJyjGE+U6nJiGJz3t69TKmvJ5n9CC/nRKw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XYXgf/FMlWzhc5Bv5ci/1B4UnMf//EHyxP9r4vH4X7tgS73T/3uJgDwOYMC8u094Q
	 ODGBVN5DMp031da5r96hg16rZodWW8JjcSFuzKbPgdznUARwFzH8p4vaMXMPhytZNL
	 ZWSn/lrisvMyI9Kezh9KtekYZlDM5wz+JTPzWaIDftUnKoRmEHtfipdBDJ0Lu1fios
	 yu8cWGlxI9hfMU8aQ4TNy50OrEIM7ef7Hzqkdhzu0mFMf5PK9ggSpzEUmq75oxjMqM
	 S33OL2WBAyk5XN3lwsvuFJRXbJjl8C98JRch9sw1kI9UxAE/hklJWCVqhk/xr9Zaaq
	 z6LnxFENSRu0g==
Message-ID: <sashiko-outbox-193333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] PCI: endpoint: Skip upper halves of 64-bit BARs
 during search
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manikanta Maddireddy" <mmaddireddy@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261102112306.4018464-2-mmaddireddy@nvidia.com>
References: <20261102112306.4018464-1-mmaddireddy@nvidia.com>
 <20261102112306.4018464-2-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:29:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_epc_get_next_free_bar() skips the upper half of a 64-bit BAR only
> when it is the starting BAR. If the search subsequently passes a
> reserved or disabled 64-bit BAR, it can return its upper half as an
> independent BAR because that slot has a default programmable descriptor.
>=20
> For example, Tegra exposes a programmable 64-bit BAR0 and reserved
> 64-bit BAR2 and BAR4. A search starting at BAR1 skips BAR1 and BAR2,
> then incorrectly returns BAR3. The next search can similarly return
> BAR5, causing the EPF test driver to allocate and program BARs that
> belong to the reserved hardware windows.
>=20
> Check each candidate's preceding descriptor inside the search loop so
> upper halves are skipped throughout the search. With the Tegra layout,
> BAR0 is the only available BAR and subsequent searches return NO_BAR.
>=20
> Fixes: 27ce1d8ecb9b ("PCI: endpoint: Allow only_64bit on BAR_RESERVED")
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102112306.4018=
464-1-mmaddireddy@nvidia.com?part=3D1

