Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189231F9B7;
	Mon, 13 Jul 2026 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783910562; cv=none; b=QSeN4yxLHU8ukAS1lzrSBV6NXrLbZVMCyx6snCItCpbhFx2LfBNpFWmG4PZIVDvQuqKqQnN7bDHSzYl5mut6YmUFSTo2rjDCuATqG1vD4pZbFR0ab6aoDGBMdVoswMxErQzOrE+PxQxQFWbm5sCoEg/9rtmGeZHm4U1HdRIyIko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783910562; c=relaxed/simple;
	bh=1atDIKHwMjynoblZHTOW4nNv2oBZmbM8JAEJSelY1Vc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NgG+PBUjyignLmRNeyC7f4E0ap/H6PIog8f8l3vZF8I6UZQUq6Pe0g2H5kAUyiMLeNEHQnm164KQIo1lzuA8Rvi8yjTIHtjAb9B97Q6sjBJNlWxXTNq+ayFZCazCNztRCym1mdhPP7QarcrtMkiMgMQdqbsHoTqbjoAUhbOk62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhWHgmIk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhWHgmIk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1B01F000E9;
	Mon, 13 Jul 2026 02:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783910560;
	bh=1atDIKHwMjynoblZHTOW4nNv2oBZmbM8JAEJSelY1Vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MhWHgmIkDpqOuLM783VvKM4yKkgaVD8ukvuH6ky2cL61QA2ggM9snxFvb/JDZV6Ay
	 y1ssPfyrzlDBt5CnBjIfXFMEQXYpbDxvz+x/G8Rio/0tZQ/V+zcVZp127jgpzmTUwH
	 KgiZFn7ORfxWgDJ1idXEGyF36GI8q1wK7Bdrq6/h5GKTSzFtbEgkZUNWJZXDGI/Rir
	 KJ0UEvkpgI76DQv/ZPmgeT1FRNXQg/n/RQsH6M1Idqkv7cSID+WXlGmm1iwz5kcHJg
	 qV7ZGAWfyr7mGo3Y5VACx4+/QUin4FcNvU4xFAiwpJlWlWxGqwrfarXj2pnz/5Rx8V
	 MbZsT6FUlZiAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V6 4/4] arm64: dts: imx95-19x19-evk: Describe the PCIe
 M.2 Key E connector
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U2hlcnJ5IFN1biAoT1NTKQ==?= <sherry.sun@oss.nxp.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev, robh@kernel.org
In-Reply-To: <20260713023435.235765-5-sherry.sun@oss.nxp.com>
References: <20260713023435.235765-1-sherry.sun@oss.nxp.com>
 <20260713023435.235765-5-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 02:42:39 +0000
Message-Id: <20260713024240.3F1B01F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713023435.2357=
65-1-sherry.sun@oss.nxp.com?part=3D4

