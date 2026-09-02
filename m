Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1F3D170E;
	Wed,  2 Sep 2026 07:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335129; cv=none; b=uX8jU6PzwDR9eOmiTfl4n6T19XxTk6DMESaTlfiPk0hIihsjaADJFwzmyMj04FaL11zgbzO7qc+VUgnmRoqDVlx5Ub8njEzwq9WqoHHXRO3f86Nb40zHa6UVuAVvnXY2FhMs8XxViZI51Kpe5ihGfLydOlAf/D1d1oPKYUtLj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335129; c=relaxed/simple;
	bh=iMuP/VvHSwtSkyPruxArQd7FG4N8zMqjU1+Y6KXtFpk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g2mmvfavZ5lU+4ZVknmmOnH1I8FWb0+KP6lDD7LrYKfOU0swTy01sRyn4IXJeoKsc7CN6MLW9vm38UnvQAaU4sY41u4omcAFpvr1Xs58WJWR870/Jk3ROAwGqmFhdNBVZJ+jZH1atAeHZdBC4roduXXiDnMbI0q5Gs5sqn6Ltg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMTBhOIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMTBhOIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533581F00A3D;
	Wed,  2 Sep 2026 07:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788335127;
	bh=iMuP/VvHSwtSkyPruxArQd7FG4N8zMqjU1+Y6KXtFpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMTBhOIFVjO9Bz+pP+2InOH35RMk9hwRk8WZwGyMwQzyhJQPfK6qs7YHSQQpq2fbC
	 O13X6x5TFrPzEB6JAMi+4kU+wOnMktkLL3oKpqAq5ycVPEqJMl8JhPY681FC2Z5LRo
	 7P0YfCGeQWLHGWgfRkZkNHeSIikEYHHLR5pPvtPvNp1E9KPKnT1Pw06Bg7u/4pdpqq
	 RYEMTq2ayOw4bqQGa1pG/pYHmOkL0aLDjBGhFuCE4QfDcaCyNwbxxOsuXcDh64ib9T
	 Sk/fcLBthJ4qSz72sum3l+92Wnr6BB5FHRzE59/hMiBJaYBgBHnRJDhjv1iuQPoIpg
	 oyNdD6tZxEWhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/12] cxl: Restore CXL HDM state after PCI reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902072804.665639-10-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:45:26 +0000
Message-Id: <20260902074527.533581F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> After CXL reset, restore PCI config state enough to reach HDM MMIO,
> restore cached global and per-decoder HDM state, and then run the normal
> PCI restore callbacks.
>=20
> Keep the target IOMMU reset block active until HDM restore completes so
> Bus Master Enable cannot reopen DMA before decoder state is valid.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D9

