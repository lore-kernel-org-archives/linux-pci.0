Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C043C9881;
	Wed,  1 Jul 2026 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903766; cv=none; b=H+FomOyKOrfNTEZgJQq6+68SnEYsdIlMU2/Zxs2vtEjm3KtOfVs/TqxSCXLnWIes4gR1EZnZPC4TyE45JtPuC/4L0m31FEfv7Boblecpew6Fg+Tk+AUQINly+lPtxNBVpm0x6NUq2knnbzM7n6yEIEfB5gze3zZOqchq2CnJIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903766; c=relaxed/simple;
	bh=rctbfzYC0wzya3XVZ9f3Spu7RZB9Ckokz8i0U7rIorw=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZQ/LK4lUqSf5J2tJPWLcBWcbw9kuC4apWDJbIfmXHJkuI7aXft4KnAvGPRLuVjn79A+jvssXmF71IvgwpPA9P9FMhuAEPrny4HuvWPp/ydtQIhYytjPFqEjbozwSwFYZurJ0cTlaXaEIi4mgSGL1mSXRY84in8EU8VXJhXVFCQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgUneNY3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgUneNY3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F3D1F00A3A;
	Wed,  1 Jul 2026 11:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903765;
	bh=rctbfzYC0wzya3XVZ9f3Spu7RZB9Ckokz8i0U7rIorw=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=ZgUneNY3GnTq+TQVAFsGCANGa1zcV+mTZOFtIA0NkvK8QrXaVTWmV2sHCi1iAq0Rw
	 qh6povmAi76KzjFvcTdCzOcK1e12N2va7daCD0U0tD88DVjqyKa6mn/qcPTEeZXI1B
	 6UT5EmQIPxO21ivbCw4HhyhyG/OVqaAh8z7MckPVCRH4ntqctgdHmqq3JpMcy5mYuw
	 mE1oIYjoZT6oJWVBFB+6Naagv8dbRiCTzIIyxf+BAyv5O9qJd+blWOPilRieo528iJ
	 A6v5oqMMsYGYpv0MhNOAcxTBcdQSIgshVrHInu0w4k9GnJrxgETmjjmxpGfiBeBGQf
	 e3VVbcDqTzbXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V5 4/7] arm64: dts: imx8mp-evk: Add power supply
 properties to Root Port node
Reply-To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260701105234.198987-5-sherry.sun@oss.nxp.com>
References: <20260701105234.198987-1-sherry.sun@oss.nxp.com>
 <20260701105234.198987-5-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 11:02:44 +0000
Message-Id: <20260701110244.C7F3D1F00A3A@smtp.kernel.org>
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
87-1-sherry.sun@oss.nxp.com?part=3D4

