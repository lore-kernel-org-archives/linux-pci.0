Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760993;
	b=3aX6IU9P8uSmVLQ+DE3n2uTlUnDraUDjMxyNZdNGl3zsh8chwFSr2F7TeNutE2cGJK8n
	 9WJIaW3XpTaQnlFNLpttR4MREc6EO0r7KmGBOBLsqTWDuhieMQGMPDoz2EWyZ4Pcf5tbe
	 78TuBTTZVXxt2/PJ4m08bH712/eJXm5LbSRK9zLuV2EWN4OxPw121w0Y89kytAgF4OL7O
	 HYrwsypSvmbnZkSy2eLv6zfFFO7ynjBJZyHp0WDRPj+gxy/3kJZRtv+bIBavpgVWxmZ+h
	 ieTEhO/6kdQZIobiQ28f64Wl/rnb4ivyCSXYx2Tfc9FBcr2l1RJkyNS3RuNOETqDiJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760993;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=34Tfyz8Xu6Jg4xiOOwwtWxXGP4dHXwSIrqISbH5P8bE=;
	b=dAhhnz/p5XIrN1bfTVwTdYQ5ZHaJo2WqjOmydJIy+uKEXFFQnqiWDun1/kTzRTBb3wMe
	 gNOp8SGhGybt7v3x1VQTD9szOlA+yXBsJHVqJsCY77TthsaWfSBi4Pt5K5UWKE0J5k3+s
	 mrnhKcz4VvNVdWe2Ux6b0OqmkFNUz2PlTwPbj2DWzegRFR/f7O/Dvbr/He52S2f5HSax5
	 b4HraUKe1LortE6p9dTnyqC/ND7i08uxrzj329s2x06wdaTPu35xlwsxdgUgQtLrzVBdY
	 mg41HbBw/2iNRXCnB89nduyO3AUimUBhBrvaSgJe9/b3q/Qim1JZ/BYmQt81sDQ1gMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBGnIbDu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8244606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBGnIbDu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655291F00919;
	Wed,  4 Nov 2026 02:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760992;
	bh=34Tfyz8Xu6Jg4xiOOwwtWxXGP4dHXwSIrqISbH5P8bE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fBGnIbDu0q7r5HbcbqcyPPB33Q8KVNjRDLlNHu2n4xTksdMGcnX/cIxT4jWlB7P3D
	 Xx+Ns3Usg16AELo/i1FLKGj3B6dZR3IV4csDow3fTK7K/LaR5TsKLB+37w2iiYKNva
	 KGJ6PgAk8P6d3sauSGXH73OWAQwilCEiJG09kc50MEwvxpWQ/8NOAVoG+J1n0jZ8N4
	 E07QIgyyTvMgH+vg1P9qmU/suwaRSwkazxvq6Yo9bhUsQuoyIDrSVDcEB6nLKFKYw2
	 Y2d2qmKgYPb+lqtukYftSocjlDOL6RvshE6HgWVvS2x43tkSacHFiQn35RoWpfGblh
	 vAF3IRVplykqA==
Message-ID: <sashiko-outbox-196550@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/25] dmaengine: sdxi: Introduce submission queue
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-8-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-8-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:56:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Add the sdxi_sq (submission queue) type and APIs that act on it. The
> sq contains three control structures shared with hardware: descriptor
> ring, write index, and context status block (which contains the read
> index). Define the hardware context-status and generic descriptor
> layouts, including assertions for their sizes.
>=20
> The descriptor ring requires only 64-byte alignment, so it's practical
> to implement it as a flexible array member. The write index and context
> status are small enough to place in the struct as well, so we have a
> single DMA coherent allocation to manage.
>=20
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D8

