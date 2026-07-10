Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D02434408;
	Fri, 10 Jul 2026 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703009; cv=none; b=lksEF6QI6hVxPZfMk/dovhOcK1SRYD0o8GIQblSvEXfS+TlSHBgh57icOD2tDsI+wdnW1bXFFiPahIXWJeM/2I6pMmPSkJPN/2Me050pOTFURf9eDTjajz3Z3N23sJ95Li2VUpH3Huqywb+4537QT12l0VGMkH4Gb8XtkwUWgY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703009; c=relaxed/simple;
	bh=UaFbx8Jz4ZpIlmAR6RfSV5G1BEKBSHmiR3nvZi7Gk3c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mg5fH9gn7NUZSzZfFUOWKWSrAqVmz8PzQAcIy8r5hkFLTnjtNLxpHNqTY2Y3bHS/C6xBG/gu0Gs4z9ikL41sixf6KO3kvbx8IeXp9knhrJfPOJwgAruHAGGu8eZZOq/ZMv8Gied6P9g/3eLXHwKXD53R4tEkNln90QGisNnAJRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZdHrdWu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZdHrdWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A70961F000E9;
	Fri, 10 Jul 2026 17:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783703008;
	bh=UaFbx8Jz4ZpIlmAR6RfSV5G1BEKBSHmiR3nvZi7Gk3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZdHrdWu06MggDX8DCxtFxcn1IWtGjrsQcSEQnnxPWb1kJ8awa8xy9VM8loZulXCB
	 uAd77NsUY1eJsLQeqEkpe6gskT2xaGne32dUYlNUcEYHo64hjAQCiMXC2544TUJYZC
	 hID2vjyxSwm1K/TOpRK5XIJv5MFC0l1D4VUCw9DS8ntXGbnC0mhGZ7RmqAraJDI018
	 DKaunK479C7+Glg6iqo3e9hN0oLn1z/UVhZTQX1jsay7wWrKe2Kpig/PqsvAI0qIMh
	 u8KYPgz8kbYs9j3bTBB3mDlK7lzYXZvdwSEKculqjTAbtj+5q9xxK8YgaB8Hpbunue
	 /o3Fi44IjlJoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/10] dmaengine: dw-edma: Use common
 dw_edma_core_start() for both eDMA and HDMA
Reply-To: sashiko-reviews@lists.linux.dev
To: Frank.Li@oss.nxp.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260710-edma_ll-v6-8-1471d278b73a@nxp.com>
References: <20260710-edma_ll-v6-0-1471d278b73a@nxp.com>
 <20260710-edma_ll-v6-8-1471d278b73a@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 17:03:27 +0000
Message-Id: <20260710170327.A70961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Frank Li <Frank.Li@nxp.com>
>=20
> Use common dw_edma_core_start() for both eDMA and HDMA. Remove .start()
> callback functions at eDMA and HDMA.
>=20
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-edma_ll-v6=
-0-1471d278b73a@nxp.com?part=3D8

