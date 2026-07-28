Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF3432E97
	for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2026 12:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785241627; cv=none; b=lys6mtzDTTDheVXEYrjHDij+5/bRragQtjQjV8avOwAq6HQ3Xqcq76zztonZkQfXlIKQFBLYAj7bMDlYeHD3ak+QKk7S2IWjsj6eksD2/+VQ5hxc2/4l0nZEJDCi0UuRSWVQL2bzHbpOE2w5aC9UT7Xnlx9yEUOOALC0NhBFwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785241627; c=relaxed/simple;
	bh=3GD9rGONS1owzrFHYKBNxPFsqmSGBBh+1+gWXWOK+CY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FhikJMwo5OPgNVp4sSVwTB0bfizwVDEK7y7Jt4l+MEVq7LAQqYNQNtoNv8dZkpbPJCszQhvT8OtegpBFcaf5S1R4Z5AfghevTkyBA9CyGDHtFhbSVUlZC9urgRTgROC/rZZIkRSHiJj4RHh3LSTmsplF7nysFhG8WiKYWndn2RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gn6/jt2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gn6/jt2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1051F000E9;
	Tue, 28 Jul 2026 12:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785241626;
	bh=3GD9rGONS1owzrFHYKBNxPFsqmSGBBh+1+gWXWOK+CY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gn6/jt2eYgJUhcAurjBEhyINHjPmI09gVrEkSVJoRpi1OKzNltKZwGmQqvDl7XnKh
	 yIIcuX5XOJEG3pDazuOQ/lLZk9CViMl8PUiddngFc1/iUWSBfF1KAr1kwtGQFDYrZp
	 x7C90xOyF4Q64mAVatailx/C1Ir+UhdAJ6e2F7UMzAPX/PtiV/1BSxJv/AmgjAn+3F
	 YxASUKpHT3+mOQ5NgT8EnSxQuJIRuauloA40aarDks0TMU8x6FmykaZj/9Ew9aOUX4
	 fQomKVkEM1FG/LNoelo+3XjUY2PQN4FSFyGg5FpKA6d9EoeFoQNgPUk5T2YhgDrHQP
	 kLjnFn8KUBACA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Fix 64-bit type truncation in
 mtk_pcie_set_trans_table()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260728122023.3338-1-sreekuttan2156239@gmail.com>
References: <20260728122023.3338-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 12:27:05 +0000
Message-Id: <20260728122706.2C1051F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728122023.3338=
-1-sreekuttan2156239@gmail.com?part=3D1

