Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81195540BD;
	Tue,  8 Sep 2026 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788881851; cv=none; b=SroOWEOGCiEhSO7xL9XaR6XalW4/aEwx8GLJc+MTepIVGcjAm+UO3Z79XGxbB38JjeACVRu2awueJypxf7Tk7q707r9zfsy67ebpDnO9njTcx75A57VDNf5pKi9e7sesUQjB/RVt1GkW5n1v94lETNiBJI1vgvmO09suaNIDkp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788881851; c=relaxed/simple;
	bh=XEkEOs63Xz+1C3Ulnz0inVTZC945fiqUjntTTfcWmJg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LB4ss5hNdPqcN+e+UuMGWfN7GTnFaVb7J0ubdAGCv5nM6xlA+mzkPCZYe5Kg/60GvzQ2du2JX4Gd3mTtKcTCh9SZB5+KmAQ2N29Aw2EWYNYBGmO+OgBCUwCzG04psv/v2fdnHuDDqUG7834M3FTAzNXHuCE5Vf/IV7e4rA194xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B071F00A3A;
	Tue,  8 Sep 2026 15:37:23 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/5] gpio: tc9563: Add support for the embedded GPIO
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260908-pci-tc9563-aux-v4-2-c7fc7778292b@oss.qualcomm.com>
References: <20260908-pci-tc9563-aux-v4-0-c7fc7778292b@oss.qualcomm.com>
 <20260908-pci-tc9563-aux-v4-2-c7fc7778292b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 15:37:21 +0000
Message-Id: <20260908153723.55B071F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-pci-tc9563=
-aux-v4-0-c7fc7778292b@oss.qualcomm.com?part=3D2

