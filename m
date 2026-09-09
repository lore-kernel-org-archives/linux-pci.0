Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DB568FD7;
	Wed,  9 Sep 2026 15:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966382; cv=none; b=GgDekvHv88R+6xaD21wtnQ8Xc8J1p5rVVB6pqCxSJaMMUZMkUZXxcRHvPWuZVdiSDaTxnRj6P6RMbOIqCDnv7m6jepM8yccm1mLibNlxxXyD3h5sXSFgXZ0FQoy7qDrFW6t78jE/t4tFooq993PepGtr9hhwwXM1A95cmrFpvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966382; c=relaxed/simple;
	bh=c9uChHPsmm3lypu47rWqnbu1Pm4Muealm+ob75yYJm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nE/7t5arWfg62h+SaJtmUKS1zofM4S1V36Z5QD7db33q2KlVlJaO+EOia83ir+feII6Ic6W+/9epyMUJi7xCBw44B7DchJm5/OsaZy5VFhnjIMckuMfFhwTnZ+3T/bEyyTr9oVV5edaisATnmhKQ2/NeD1dw8Gh4lJAb1Z6zI0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0nJJksF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0nJJksF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1887D1F00A3A;
	Wed,  9 Sep 2026 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788966381;
	bh=c9uChHPsmm3lypu47rWqnbu1Pm4Muealm+ob75yYJm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f0nJJksFqnhjJLsYqAvdW1+abYfLAkoFY6vrWH4I7+gQ2lU0xd5r/iqLbK31bZ6Si
	 wuK0okPLwrGpR7hdJEVUpWCfYeqVQFJra1hILxPHGbkjsNX0zko4o8F5jxIIsuO28L
	 5LQvVcHdSpBM3DY0QORFCgyy+WK/7MzowH99/aQBrC+qbVBx4bXetKrIAA3jGd6gZ2
	 Vmci18ZDOyheX6KKgwSGYHTjMd5icHlL08mMq8X6zXTTn7cX7ObjXIa3erAdKWJS9D
	 CyUnGbRG4ha1wVPRoSj4fR2SMVEsTVWeG+mhPOXHdzTKPYL5OVPb/T6FiwDhevno0N
	 slwXmhkas1qdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] gpio: tc9563: Add support for the embedded GPIO
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260909-pci-tc9563-aux-v5-2-c9b33f56c8d3@oss.qualcomm.com>
References: <20260909-pci-tc9563-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com>
 <20260909-pci-tc9563-aux-v5-2-c9b33f56c8d3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 15:06:20 +0000
Message-Id: <20260909150621.1887D1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-pci-tc9563=
-aux-v5-0-c9b33f56c8d3@oss.qualcomm.com?part=3D2

