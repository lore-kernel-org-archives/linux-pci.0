Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422913B8944;
	Sun, 30 Aug 2026 15:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788103710; cv=none; b=DCwrV+f22whmArZWPwhbw/BQ/pFrds8papqjQ208nPWhDF3HNMy1HrQXyhv1EDI/N5dzU3Ssx4revaysxVpjm65frZs8IypWqH1HIW+I+jKA+BAD0bpDi7/Smp4VnhQ/DUbR86WuTxq76nleAR+CKo2vvmkk23zWfd/jsOwuhPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788103710; c=relaxed/simple;
	bh=8xeo5H9ss2s8HvJ5DOxqNsTkZ2yC7HqtyF7jo/8ZLYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l1mB4eL5xBLuDYAvxG7t745L7Q76S3240ym3EI5b6spgpEbfHr4rNMr6eu6UAJqeMW3APfV5bL4hFdmHbtJP7ybt/mBMs2QsUSLGAdi5ltfHfi26djuVCN/kLWBkSmma2owN32mwZ+a7HIU/DYh2hw0pzGHJ4XOb7eTkGZP8FjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBpNm1Lc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBpNm1Lc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A468D1F000E9;
	Sun, 30 Aug 2026 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788103708;
	bh=8xeo5H9ss2s8HvJ5DOxqNsTkZ2yC7HqtyF7jo/8ZLYc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DBpNm1Lc5Ey70YqM6IwqkukQ7S7JGGMM7UkoJglzkURDke8egcDAJ4iF/n6YVju3I
	 dmjqQiB8PNnKrfuWzENwBnB6psN8aSDX1Kp5POE5hqMlzldeVfyxS/MG1EPORD4AR1
	 7TbzmHDN/6/6VzC3wE2+Lf2rUQjoh08/MVfYEu6R0udJsd9mInS4DAye4wv3J7tMJW
	 tSPdGvfRceiVdhhIuBjpAPTvx3WuS7eTaOFQ/8B5eOceUj3AMqyqgsMDb/cYHbz9eV
	 rubvX7xNg2CtED3Avx/6hNlT+QE+sryoffKMGW4TJObVK22UVNiTmiM/lD+An/Xp2L
	 86dIGPxhGbUxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI: dw-rockchip: Support fixed MSI-X table and
 PBA on RK3588
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260830151948.3547577-3-den@valinux.co.jp>
References: <20260830151948.3547577-1-den@valinux.co.jp>
 <20260830151948.3547577-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 15:28:28 +0000
Message-Id: <20260830152828.A468D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The RK3588 PCIe endpoint controller exposes its MSI-X table at
> BAR4+0x4000 and its PBA at BAR4+0x5000. Describe both as reserved regions
> so EPF drivers can select the hardware-owned layout.
>=20
> The regular DesignWare MSI-X interrupt path reads an EPF-owned table
> through epf_bar[]. A reserved, hardware-owned table has no such backing.
> Record whether the layout selected for each function matches the
> hardware-owned layout, and use the controller MSI-X doorbell on RK3588
> only in that case. Continue to use the regular path for EPF-owned
> layouts.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830151948.3547=
577-1-den@valinux.co.jp?part=3D2

