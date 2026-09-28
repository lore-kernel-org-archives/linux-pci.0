Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFD04E2F35
	for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612424; cv=none; b=RjprC+vJcI/y540mfNqOxBSBkhi16IKowZW/9SSV+41AaqNzM2TnbAru08BerPDDIh3Fegbn47Ty1xmmEwHCJVjuS6C8De0g10qUO7ds7hPgALqkRCn/uMexjIvzd+IGtHazLpa4alp0bYWcOnmlaiMwWRbuDyaaScaO61FoVRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612424; c=relaxed/simple;
	bh=p9PEiSlA/jPUQ46miFxSEO0iX76mlXyBHBrdy/bhaRg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rp3dw7W/20Qgaka8uqbBBqrjPH5bmvlXq+Mz5vzX906ux9KnNIEiQCVF4cNIdrtQUqZbGOoiFJzzRnhkuNiLgsOXTCL+xXfvfYeczBsyo0/ILf/i/mt8QYqSH2RJTqciJxsiqrwky+fPmUUzs0L70R2iraEyEU5MXSJ1lsB7l28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVkCY17/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVkCY17/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A481F000FF;
	Mon, 28 Sep 2026 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790612423;
	bh=p9PEiSlA/jPUQ46miFxSEO0iX76mlXyBHBrdy/bhaRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LVkCY17/BRIwXBkG50bOH4y3FuDWTpfGMu7m9/c7KMKEd6q3W+9UC3ntQWmicUNyb
	 jh4y6kYRmANLs0Hk6cai52quGIF1yek7kGXzt9otWA368ycpzXUb+2XOXsl3uXRsjO
	 EqrVj6c5HGnVcW+RdpcLaTJBiBGHrl7J8AEP+e2V6xYLzfwks02Vrxwf354zJER/SR
	 8k6iv/yK/+5rG2AOSex9ctE7D8Ikpu/oKzyiAMEpiPPH2EMaGBL6a36HLETs2FCpkx
	 0/OrUueQRts7vZB6ZQDiEacPh4/iBRgP7VSdBPuvU58ZHbVnHvo5qKq//3DbSuo+vM
	 DhIaEtTv/Fbwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/IOV: fix building without CONFIG_PCI_IOV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260928161811.2846627-1-arnd@kernel.org>
References: <20260928161811.2846627-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 16:20:22 +0000
Message-Id: <20260928162023.25A481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The newly added code dealing with virtual functions causes
> a harmless build warning:
>=20
> drivers/pci/probe.c: In function 'pci_class':
> drivers/pci/probe.c:1902:12: error: unused variable 'rev' [-Werror=3Dunus=
ed-variable]
>=20
> Move the unused variable into the #ifdef block that uses it.
>=20
> Fixes: 8a2a9fa37b81 ("PCI/IOV: Read VF config values that need not match =
PF")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928161811.2846=
627-1-arnd@kernel.org?part=3D1

