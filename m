Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88A6364959
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380975; cv=none; b=jTioGOiHITZ43JAY4dfRa7fUxcmmem0Jl82v4VvbiCUWvjCdVdFOn8VctHYDKHomIFGz8LlAuHj8pDcCmnjrOL5HlE62I1AiJt0aDfMtGa7JhIk5oXOLGZxuzDPxd5EKAcErzeCNQewRmUWe1ZTUuRvnOK1NQIvuFs75vVS9iFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380975; c=relaxed/simple;
	bh=FF3l0vsjWP9LExqiRujCquzYDOOQi8mdX8riIuh5TZU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PRvk2teOkEjv4+5uIosh1Ix1uqXA8qQAK45lreXZ5IRUBrnAPOjBdc4Ltks4G7z+b2qDzmPa0rwSVc4iRs4t1Z9mjVZp7RfOE3BCelU5W4enL+t+g4e68LR/YPYnQrzhhnscdS6luoOkj92qBvhAHFqxvyEfEXycQerAIj0yZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erqHauf3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erqHauf3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BAB1F00AC4;
	Thu, 30 Jul 2026 03:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380971;
	bh=FF3l0vsjWP9LExqiRujCquzYDOOQi8mdX8riIuh5TZU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=erqHauf3TArzad9W8AlO3l6Ij+oSrocnAbcGptHSi6DaOht8eHJyLH82i7r4vlVEO
	 YJXO8T8vS9sTFzEFLugJAgF5HDS8hT/LHHloTZjdFQ+0EDgNVsGMiQ3vQPQTA13BpI
	 zUPpzBgmX3/eBvdAMCOTXqhfMKAtsKuNFlQRcUkAkEAP00d4URy4lwklcdaYeTkIzj
	 oFGJBGE8rBT5egDjYl5A9tLWPH2ifff1Os/8PJ3D+PWU6e+8MK7a3c1gV0zhsfChPU
	 DMPA0jk/iKw0MWZpNx+9x3Oa/lxKiGbQ+QeS8kOWLOJMzx5LRcPzbuRU5dXSzR9pdP
	 FE+9ytpV1bj4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] PCI/sysfs: Avoid runtime PM at config-space EOF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ziming Du" <duziming2@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260730032438.1643450-5-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
 <20260730032438.1643450-5-duziming2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 03:09:30 +0000
Message-Id: <20260730030931.35BAB1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_read_config() and pci_write_config() only reject offsets beyond the
> end of configuration space. An offset exactly at the end is reduced to a
> zero-length transfer after the bounds adjustment, but still takes and
> drops a runtime PM reference despite doing no work.
>=20
> Return immediately for offsets at the end of configuration space.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730032438.1643=
450-1-duziming2@huawei.com?part=3D4

