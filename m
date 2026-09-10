Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6743CB542;
	Thu, 10 Sep 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025107; cv=none; b=mxJYpwF2uO1lCbk7ci3bYQChYYkCrkLr7Q44+DzQegM67IP/hmaAndBJ2x3NaOegklvMac5wKGTNbN9SidbItJBHvf8LGaumpNxAxyrKuU4ckb9X1gQZyh1Is33dsJz27jo4TexHhc29foA38uEQ1H3HYxy8dufw08ezG01iLhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025107; c=relaxed/simple;
	bh=BuNh+9iki4bCHezswMDWFz8ALnXQlahPlLUZbhi7gk4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TzUNA2leZ68nfwDrIx0Xpi4OqrwZUMcL3jNsuZlAvLcOq92SnDiG4tSflSIYdDnXkaf8ECrzEvjCMes//xkJ2yfGEQQ+e7ifmnu8T0Z+muaa7R7uA09M6/aB0B8fL+V2/Rgw3I7cDzfBHLvtsWRshVlKubVKP9pRI9tY+p4woP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyo6Q4cQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyo6Q4cQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248381F000FF;
	Thu, 10 Sep 2026 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025102;
	bh=BuNh+9iki4bCHezswMDWFz8ALnXQlahPlLUZbhi7gk4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cyo6Q4cQpCx5wIUnrs6QrwqTBfMAj8jVwUQeZ5i2Ens/KQAq5C63JJLMpCLqr7z/D
	 M3u5WLa4nu4MqUTKqCLdMysWPARSYOcVu4S5IM6z8Ka9iTrSPoiyTdbwqSTPC3Jdu9
	 WdG7mnppTpMWL0cXfZnyKtO3pd59rO+EXaAXlCDwLNcnxbG2msrgF7/dPYsOU8EUKw
	 nPHNmWxGPgR21k39D3soqgY8sr7wZKA5oXerr7CEzOLItqFvN8Mtt1cyTfLO30mnUB
	 SAwO+UtMDzQAcOmLgzUWtCNVEWsGfuH9tnW0JDHRULco1KgDkSPrm9VT2+600OJ48M
	 jjaEpvgOcynXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 09/12] cxl: Restore CXL state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260910070808.1444264-10-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:25:01 +0000
Message-Id: <20260910072502.248381F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> After CXL reset, restore PCI config state enough to reach HDM MMIO,
> restore cached global and per-decoder HDM state, restore the cached
> CXL.cache and CXL.mem enable bits, and then run the normal PCI restore
> callbacks.
>=20
> If reset clears a previously locked decoder, restore and commit its
> programming before reapplying the cached lock. Leave a locked committed
> decoder unchanged when that state survives reset.
>=20
> Keep the target IOMMU reset block active until CXL state restore completes
> so Bus Master Enable cannot reopen DMA before decoder state is valid.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D9

