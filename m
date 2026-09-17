Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D93B28D
	for <linux-pci@vger.kernel.org>; Thu, 17 Sep 2026 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643938; cv=none; b=fPKE+evkK1GYUjYS9oSc4vnYp8nkrtSPYmcolUwOtjUaucT1yOIbU8lbyjd2K1iI9RiIo581pbOcx2Bu7D+lKMw0Y26b1tdJWr4VdjYx/7dm493nTzmZfqP+KrqP64m9Si5vzBqGbdPYHznJTR1+EGsXCV8IPTY/xOXr5QR/UWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643938; c=relaxed/simple;
	bh=LEjnxrxbYzJ5NrmXyZmCNsuMbvUq1AhYiLfHwXNDdjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SEmBSB4UZuRA60UbkdQyjRecVYViFbgdjkrr08XhNNfiiWbse+PuVErUPngkQGpPPmAl6a5szq4+tcKxW+peI0oG7rHr02qucDw/KSp9OwWlvBsJfRtC+OY/zoy3dLaBuNhYBznuSkI1HnJnFxk8ts3CkKB7FWjp+mIb/qpC86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYKwX9uf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYKwX9uf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246E81F000FF;
	Thu, 17 Sep 2026 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789643932;
	bh=LEjnxrxbYzJ5NrmXyZmCNsuMbvUq1AhYiLfHwXNDdjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CYKwX9ufSKbpoSkQnxnzGAI759Hl+OMKiHPGDhMNdEQ74Lt+MVZzCay7T2BIulMGu
	 pk21l/uagHpK+xd0+LxGztKug4YoLkky3CHP9xP4yWkU7B2rujk3vbrsQpjAfrLM8u
	 PZptHGzY6huFX8r1IlBd6oDmB9MbAcZqTt2YEAwg01zm2Bmfwb7YUfdhLO9OCST1CT
	 qjTa9TB3lk2TmSo22oe+zKXpAJYdCgU4VTRJ35F18WAj3kBsKPtEBcZMnB6FtX1i4k
	 8tFzNqLh+HgA8dJ/Zre/m9Ocj0Xvggsad9n9mncUIAvjobBuo2I/IRBPK/ipvIKFhm
	 giaXcg7qS9hqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Skip DWC MSI host initialization when
 msi-map is present
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ayiluri Naga Rashmi" <ayiluri.rashmi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260917-skipmsi_forlpi-v1-1-14a4932a4311@oss.qualcomm.com>
References: <20260917-skipmsi_forlpi-v1-1-14a4932a4311@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 11:18:51 +0000
Message-Id: <20260917111852.246E81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> qcom_pcie_ecam_host_init() unconditionally initializes the DesignWare
> internal MSI controller and sets use_imsi_rx, irrespective of whether an
> external MSI controller is described for the host bridge. When an msi-map
> property is present, MSI interrupts are handled by the mapped external
> MSI controller. Initializing the internal iMSI-RX domain in this case is
> unnecessary.
>=20
> Set use_imsi_rx based on the presence of msi-map and initialize the
> DesignWare MSI host only when iMSI-RX is required.
>=20
> Signed-off-by: Ayiluri Naga Rashmi <ayiluri.rashmi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-skipmsi_fo=
rlpi-v1-1-14a4932a4311@oss.qualcomm.com?part=3D1

