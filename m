Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D494513555;
	Fri,  4 Sep 2026 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542609; cv=none; b=Ehf+jDlldm+LnZQXnx8YWfyBfJKFL75dz5FWsnQ68cIosmUMpqqzz9mldbKYT4ThfPB4D0vLiC+RWWr0cNBqz5qNw/Lbn0MqCgS4R1JWaKtrxQA4z+VrJQTwUdtGpnSSlCpzHQwnFtFAmdW/Xq8XgnlfaZpM/TXGj9uGNRya2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542609; c=relaxed/simple;
	bh=RSdAt5w7fZBMg/JsGFlxf1PvaqoVUHi5WnnKytITUro=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BxrmRMiyn2JINKDFXDsupN2yV767/hIVzv5cTL5oTMboKwcjvpcV7fNf5YcOHdlSsaX2qQxS/W1r/5MWE2Q3yG7slARFhawQRSOVZBnuiCPB5/R81EyJ1yj1ykzi2aVCoTGKJWv3/NlkAf9xEUUHkt/8aNGfOGPo3muNuMzsBGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FCg6QY2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FCg6QY2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2032D1F00A3E;
	Fri,  4 Sep 2026 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788542607;
	bh=RSdAt5w7fZBMg/JsGFlxf1PvaqoVUHi5WnnKytITUro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCg6QY2mrUv8BRlcchXRNzhaz2SP5xUbUbpWaUNaQO3FRvz3GCYtMS4A7bBwD/sj2
	 aZkR4lSzdEVdXerH8Er1A1W8orPjBZrCLCmnNCUkNUWN+0+YWr3hwKDfbIEWQP01m4
	 aweo7CeOLZMTWhalPppDo3WgV1jEIRYlK+yiPZn5KWo+4Mqv36V4ofbbk4l9VWmH36
	 JB9nIbxaEaG+40jmGYhlJn/Bx2ltb7PstcNGM85jg0EF6vkKugnitNcv4TBSqvJ+3Q
	 wk4/xjRqkQDXR0n6tgCFW6vthtVpaKAAwQm5dlX6A2QdRvO7Wpw34oAsLvTRSjuYOP
	 RvZ+Um/PEcKyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] gpio: tc9563: Add support for the embedded GPIO
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260904-pci-tc9563-aux-v3-2-5b1449d62ba2@oss.qualcomm.com>
References: <20260904-pci-tc9563-aux-v3-0-5b1449d62ba2@oss.qualcomm.com>
 <20260904-pci-tc9563-aux-v3-2-5b1449d62ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 17:23:26 +0000
Message-Id: <20260904172327.2032D1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Alex Elder <elder@riscstar.com>
>=20
> Add a driver for the GPIO controller embedded in the Toshiba TC9563
> PCIe switch (and the Qualcomm QPS615). The device implements 35
> GPIOs using two register banks: three registers control the first 32
> GPIOs (20 and 21 are reserved) and three more control GPIOs 32-36.
> GPIOs 22-24, 27-28, 31, and 34 are input-only.
>=20
> The driver is registered as an auxiliary device driver. The TC9563
> power controller creates the auxiliary device and provides a regmap
> that gives access to the GPIO registers, so the gpio-regmap helpers
> are used to implement the GPIO chip.
>=20
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.co=
m>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Co-developed-by: Daniel Thompson <daniel@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>
> Co-developed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pci-tc9563=
-aux-v3-0-5b1449d62ba2@oss.qualcomm.com?part=3D2

