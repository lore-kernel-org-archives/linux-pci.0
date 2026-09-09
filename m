Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A0563FB0;
	Wed,  9 Sep 2026 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966306; cv=none; b=dLQckXMMeyppT/YOJ2vWk3LfZQhtQBoDrF7sUMlVNzFyoDIy6S8GfTkUrninpEDctkc9M6CkFubiPvnyU7EUEjH7TYuQ0RHh5iojKfk50iFQF3S2AXalfABGtsjnXKlJOKIFOkzBtWU6qbFg+JMTDU4WBjF7JeDzsrDpGETg57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966306; c=relaxed/simple;
	bh=XWmyOwWTYRlKWj147cORsomk+33Nquvk457pMcpNGko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BlPpC8beY/WlyHkO/kKtBI9R+nfbVfPcXrrwjPyvUyMoWskq6svNfnQVYxG3wjroqBflnvIBzDXQ4OgqRwuO3Ow5zbeM0UpOO78LrP1O8bgcrT+MgYr59XRydYxUfVfkykgy1N/3xVMyFGfP3zLUFwXv1k11xzyKBcVmRJ7vDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7yPY72J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7yPY72J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735FE1F00A3A;
	Wed,  9 Sep 2026 15:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966304;
	bh=XWmyOwWTYRlKWj147cORsomk+33Nquvk457pMcpNGko=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7yPY72JSF00oBQr1qTmnlLmyQSg9SqYh6rmV2XAjzEcpUS/ue+e2+mEapC4A1vuQ
	 R8jaNL8yPDAhwSOJQBThXFJNEuHaioiyv5dMc37yjFEPhRc6N6rWCRAXyKNPEvOGwD
	 ioI9stidsUpxV8M9aSkulR4xpzaLCEB+9XeHmtyapQU6ihOFoErLcfybLEnVv4HWuY
	 a9Hmf3avW0EQBNHiEqxAL+yqBZh72/YCvB7trUQ1p5sSGDA90p1OvtpzlUxbtXPBE4
	 mbaUGPLjoj1LkAkqKNGCYxv/KYMIGeBeOwnehzkgzp79g/uAMS47K369VAT8BwJs76
	 dm7mSGEKO/amA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/5] arm64: dts: qcom: qcs6490-rb3gen2: Enable TC9563
 embedded GPIO controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260909-pci-tc9563-aux-v5-5-c9b33f56c8d3@oss.qualcomm.com>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-5-c9b33f56c8d3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 15:05:04 +0000
Message-Id: <20260909150504.735FE1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Toshiba TC9563 PCIe switch embeds a GPIO controller providing 37 GPIO
> lines. The controller is registered as an auxiliary device by the TC9563
> power controller driver and accessed through the same i2c device.
>=20
> Describe the switch node itself as the embedded GPIO controller and us
> it to drive the PERST# reset lines of the two external downstream port
> (pcie@1,0 and pcie@2,0), as expected by the TC9563 power controller after
> switching to the GPIO descriptor API for per-port resets.
>=20
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-pci-tc9563=
-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com?part=3D5

