Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58842669E
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240593; cv=none; b=ulaphWOR7LmJGew0bpi9tsknXEAMlDFYxlF9sAyjYnb6c/y6umyA7j4xozUMrbO58q2C7razCV0Sv8dWzWN3htUiR8GIbFd74fQsgwxI0eqJ3di/Wb65jWh4VekaKlbaOk83aeS46mv3RRiSfZbbNY0hy85cP6HMpPCnqLzr5eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240593; c=relaxed/simple;
	bh=mG7dc8pxi+0Ajq4nbJ90DsNsBSJeESU/tH+fKlvbPrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qb9WQlVy32x5UCR2sdCRbDq/30JSrYD4yhbEth2zW0Kk1wFMPeHNu3fWpJZwdHGHhtPIKzp2Mngu1IBkbNpqy8fD7LYvDXntKGB56BBNNY3WW8LuHLCsAgbJ1j2GyZhoIB7cUNSazMSSkbsd5rpt+xQroqKX4cKj2dh/0AHvJNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLo30wRH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLo30wRH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE671F000E9;
	Tue, 28 Jul 2026 12:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240592;
	bh=mG7dc8pxi+0Ajq4nbJ90DsNsBSJeESU/tH+fKlvbPrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kLo30wRH2d5F6vx9MXZHqHJaB0tvjhKGYnsbLf09ST7KbWgda+R5dd5WWmO9vWjvX
	 /DL7a1egzR0bBNlP7JfmTg5B3Boz1nWNWSkbaiQlTMfe4C4ol+O+u8VM6eg56KwsuX
	 xnlsOalz/L3OlSQPiOTmCoRJlNyqvkz4FqaBa8YYcvo7V+uG+OaCmWfb+hpAcV0e/P
	 3B8yOGJdbrsF0PzA/jL60aSkuqrAodc4KwG/4qekcPGlJarhOqudBGZWbyBApDZnne
	 MNUTvgryXkd5Q7wKwJzfnjVS2dggdvRxO9DA1LEsx/Urba6DE4JsX5Iv+DUMLj4wiP
	 +lc1yL7vm92ag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Fix 64-bit type truncation in
 mtk_pcie_set_trans_table()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728120301.3188-1-sreekuttan2156239@gmail.com>
References: <20260728120301.3188-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 12:09:51 +0000
Message-Id: <20260728120951.DAE671F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The variables cpu_addr, pci_addr, and remaining in
> mtk_pcie_set_trans_table() are of type resource_size_t, which is 64-bit
> on 64-bit architectures.
>=20
> Using 32-bit helpers fls(), ffs(), and BIT() causes 64-bit integer
> truncation when computing window sizes and address alignments above 4GB.
>=20
> Fix this by switching to fls64(), __ffs64(), and BIT_ULL(). Note that
> __ffs64() uses 0-based indexing, so the '- 1' offset is removed. Addition=
ally,
> return -ENOMEM when translation tables are exhausted to prevent silent fa=
ilure.
>=20
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728120301.3188=
-1-sreekuttan2156239@gmail.com?part=3D1

