Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13E3EFD37;
	Wed,  1 Jul 2026 10:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903469; cv=none; b=W78Jx9kIHJCxULEE0zIWc+0KHiJ0/H7Ez2urnEOZBbPIm3q7M2gvqREIrXD8lW8A8aIqCaH4fMvNksuB0LS3FxPvdB57+fz//Yhr5mVX++TxI/v9u0MuImm8DjzqisL6KetFNMOQ8WCz+wbcTFEwTYMcAvONgStqo4ooje+xsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903469; c=relaxed/simple;
	bh=yWtNQHCZI7apySTTxXuHad5vReJdsRTISEnyKkk2TTw=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WDqopwBL+zcjYm+BtYaiKW7VkRVXZaIPou7tOWNMxEcN6WNHmpdTMUb2YULOrtPNEJZq8XdP2EJrWlUBRziNd301x5qG1Hm+6R3AN92UESjrsEQe6M4kfo0Sp+9ThNwdbV3l54hIBgrtAsxcHnVHU/HbmnsZTZb5xUyOWQrplb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kw03Nnrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kw03Nnrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10D51F00A3D;
	Wed,  1 Jul 2026 10:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903466;
	bh=yWtNQHCZI7apySTTxXuHad5vReJdsRTISEnyKkk2TTw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=Kw03NnrfiZ3KDexC83Ui7bPIXMRB2TWSyFMJOsHrP6SwoURM7wFsB/v4WjRuan/dj
	 CkXBOOlPFo16ukMyeKHRmNQZO4wXUxmh7IdrhOHP2ccEjLaF6KpvxQ0kQ4dygmlVyw
	 hM6HQEMUSoygLhDuG8bSoIHB/RWusyiXnC6kvA/eDvoRsO0dstm8XPLwkIIYdF0U6e
	 o2nQw/X/ayqub3yeV0a0YXqKpl4XsZJjpQ/ACvqFEtUYV3Pb7wNVe0+1V8SCt5lJTY
	 nXoapJ6NxitMDnpQC+ZNPQGjzLtDzdJcZN13SJoYx5CLjPXoS6cXxjXuobo7caqXbe
	 yYd51+Wd8q6yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 6/7] arm64: dts: imx8dxl/qm/qxp: Add power supply
 properties to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260701105234.198987-7-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
 <20260701105234.198987-7-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 10:57:45 +0000
Message-Id: <20260701105745.F10D51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> Add the power supply properties to the Root Port child nodes to support
> the new PCI pwrctrl framework.
>=20
> Legacy power supply properties are retained for backward compatibility
> with existing kernels. New device trees should specify power supplies at
> the Root Port level to utilize the pwrctrl framework.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701105234.1989=
87-1-sherry.sun@oss.nxp.com?part=3D6

