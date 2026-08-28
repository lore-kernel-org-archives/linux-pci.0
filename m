Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0D369D6E;
	Fri, 28 Aug 2026 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937371; cv=none; b=gxpmrku8nNw3fgROrvjj/CQY5lVDMA6xHZHL+VaKH+AFHTW1baV9v/KhfGDdFourxfxT28NDhbD+1Su+7+uTGxki6Bd4RbK1RTkXKGBmvCfC71T0y/tQgyA2F/Px1/FqGu3smSMEIZBudiVx3UFO/4sd2yWDwBL61E6BerCEAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937371; c=relaxed/simple;
	bh=Vjq9kdyBOXPVw+sWkiLN3h2vVnuMaF4+NuEgEB7HlDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hu7h4X7OYJNKtjBJ48kcHI+94Gk396J50r7IG1/+xUANgphyEDvoba51LZoDXzBuyLRthsy/piIxHuxDB3lwAoZbwZp7ZzYfeW39KFhj6ZNwswhawp5mWbYXQgOzLuE5jrLlAs6bwWSnKxVqaA3QRgPx/uVLHkLG3PsGlcJsq0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCtNl1lA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCtNl1lA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4E01F000E9;
	Fri, 28 Aug 2026 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787937370;
	bh=Vjq9kdyBOXPVw+sWkiLN3h2vVnuMaF4+NuEgEB7HlDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JCtNl1lAGho+4eYr4gEezXI+xY6zYZfEugCBAG+SgGete94LjZSyOCJZ28kEXk6cS
	 YiFnb8Cg0bFh4caNi4z7yATdtyzM7rOHWy8cha8iqmC7hJU/xedSv5/viNjVpReSv2
	 Gm2pM7VUdWW/skVMIfJevWsha/oH077+Qm1jl4HElqE5JivAR4SohqrwLNIL715S33
	 fL4PD960pGJ2iKnJtIRvalQ1CqlCeCKNvGX0LS7d4xMKkIzB09GgxGMqmEifgT5yBY
	 /KFnSVJL0czbv5Nz4KRrGNY2wIg3zWYO9LRQCFLd0En00NFmi8EnuZwvHtIAd9UcNG
	 k2+4B+oG7M+gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] PCI: dwc: Expose endpoint DMA resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260828170932.2735807-3-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
 <20260828170932.2735807-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:16:10 +0000
Message-Id: <20260828171610.6B4E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Expose the endpoint-integrated eDMA register window and linked-list memory
> through the EPC auxiliary resource API. Endpoint functions can then choose
> which channels to export and map the required windows.
>=20
> Associate each linked-list region with the direction-flattened static
> channel ID used by the local dw-edma device. Report these resources only
> after that device is registered and only for channels with linked-list
> memory.
>=20
> When the register window is already part of a reserved BAR, report its BAR
> and offset. Otherwise report its CPU physical address.
>=20
> While at it, harden the existing doorbell resource query. Report it
> only after the local dw-edma device is registered, and reject VF
> queries because DWC cannot assign DMA/HDMA registers to VFs.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828170932.2735=
807-1-den@valinux.co.jp?part=3D2

