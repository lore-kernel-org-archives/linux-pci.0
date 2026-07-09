Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6598730D3F5;
	Thu,  9 Jul 2026 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595009; cv=none; b=XkSplNyPN71Ccf5WfsR+t/KGccL9RllhTELsmjlNUoUw1dLkiqVL/sP+Mp0/HpT1rO3sELEES89b6a1AKy+50I0jPLg1z/DgGtvqs7/5RcDun1Sh6iE7GwPGTJt58nTI+nteVRqXayIWoxlYhjEdS5D/UIYQ12BUWrgyjvnsQNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595009; c=relaxed/simple;
	bh=oxi1KYj1sDfy+abyp0oyC9W0JahVvUNVqoB+mIUwHd8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GHcE/tBo81PQR661feDAXGODvYQEcUA68mVsiO4dLbrNgEdnhQY4XGjqmLopYEuycg49SSBUze44CrjBaP0p3vq20ritcZ4bDhCDULDd4d1DpP+IAjQmBMo+CaLJFWs3tlX3dVEnTHh4J4O9PqmeW7Jxa6jCeeDLuzSyIAjxcaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxhhCl7z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxhhCl7z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890B21F000E9;
	Thu,  9 Jul 2026 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783595008;
	bh=oxi1KYj1sDfy+abyp0oyC9W0JahVvUNVqoB+mIUwHd8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YxhhCl7zkONrsZTO0UHKvvA3OrL+DsGYG/ptgIFlcKcWNdwRrW6dcLc+qTb+b5NZ8
	 FWUrXflMKafSoMoWcjpOz44heFFuz1iza9xI0BuTboRWQsX+MQT01M7wZ+/bQX2OQl
	 uvwQkzyRu1hk2dz9qdkfnHjQz2gMjPVz08pwdJ1kw2zx3ApsgzKphSD1j17bGRlZOK
	 MCBOctFfR5LdvxOf7qxdFumV+ME52fM9ZIaRZwWV03CeLJU0sJDS4/taBYKBwAcsUw
	 bOFIAbLZq1Oa0k+wUkyx9vlhtcys3iaSVMUD2CNKVAe6WanQnXCZd6OwA9yXwfUICS
	 7JZs7MixBUNNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 4/4] arm64: dts: imx95-19x19-evk: Describe the PCIe
 M.2 Key E connector
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: robh@kernel.org, Frank.Li@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260709101555.3034853-5-sherry.sun@oss.nxp.com>
References: <20260709101555.3034853-1-sherry.sun@oss.nxp.com>
 <20260709101555.3034853-5-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 11:03:27 +0000
Message-Id: <20260709110327.890B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Sherry Sun <sherry.sun@nxp.com>
>=20
> The i.MX95-19x19-EVK has the PCIe M.2 Mechanical Key E connector to
> connect wireless connectivity cards over PCIe and UART interfaces. Hence,
> describe the connector node and link it with the PCIe 0 Root Port and
> LPUART5 nodes through graph port/endpoint.
>=20
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709101555.3034=
853-1-sherry.sun@oss.nxp.com?part=3D4

