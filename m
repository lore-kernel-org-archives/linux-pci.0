Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210FB35E957
	for <linux-pci@vger.kernel.org>; Wed,  1 Jul 2026 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937992; cv=none; b=XxYy8MRKjuym28nsT5Vg6qHfRQBy6v/WvgD2t5tsr96zGw+LpZ0il37eBexGXA6bt2FBYXS6U8gnrSbzwp7A2m+3m8XNCmknpr+gwgd+lLU0GTbZI+LwjKMM/drvwd7jzrfeZGNGbJ4U9+1SXuSEJa8p6rUW+jXnCTd8DrCMPiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937992; c=relaxed/simple;
	bh=qq47YaioOnrKS6e9a1K17Ied7bzyqzFkCVLE+o1JM7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OWoidHMU5G9+PiRqqFG+zxRr9W/LMesgHhPp8mobd0VaolUgPpYYAHhIitfc6J9eJMRcbSrSVnUviEl17fWuMMRr6GOJHqNr2V9yhjYGZAW3EDnLU0OGAc5mpjeMNH4lhHg0r5WT3/7I1ZNNKALXSxsg7Xxcg0ge2ZkA7GcU5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQKQ98ZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQKQ98ZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBB61F000E9;
	Wed,  1 Jul 2026 20:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782937989;
	bh=W0LPrFc2mvdH2vwuLAN6uxuEtvpydIp1QwXC7DaefBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EQKQ98ZBgsnnJc8hP8TpRhjv4myN3hYR/7xEN2A7DldKRqNIdV17YRz23XKyHCkxI
	 uTIxTb6Fx9Rr2QieFBsAsD7k5KAzaV9bc/+HaXzYTlYqfMhR79U2RcFcpcVmxyf2V2
	 JBc2MVE8QEx0STuAOM0g0gdxfayKeNA/mjq06G+quCesk6AVsnKgIRRaJyKyFjilku
	 TxyWm7CLxQsX4/me+JpNng697cZ90UIs1hoaNXvisLZ9QuV9by8u8SnsReLIRGLSWC
	 mhJDQ1iC8sPqs9DYTpeREoDM68CjXod0IMjGj3DhMcHa8SC1ya6T/7F6XEOlmDhhx5
	 yhiykdDJ4RaHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC RESEND 5/7] i3c: mipi-i3c-hci-pci: Propagate I3C
 wakeup requirements to PCI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: "Alexandre Belloni" <alexandre.belloni@bootlin.com>, linux-i3c@lists.infradead.org, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260701201533.220818-6-adrian.hunter@intel.com>
References: <20260701201533.220818-1-adrian.hunter@intel.com>
 <20260701201533.220818-6-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 20:33:08 +0000
Message-Id: <20260701203309.3CBB61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Keep the PCI wakeup state aligned with the wakeup requirements of the
> devices served by the controller(s).
>=20
> The PCI function is the wakeup source for HCI instances exposed beneath
> it.  However, wakeup is only needed when at least one attached I3C device
> is enabled as a wakeup source.
>=20
> During suspend, check whether any HCI instance has a wakeup-enabled I3C
> device and enable wakeup for the PCI function only in that case.
> Otherwise leave PCI wakeup disabled.
>=20
> Note, the suspend callback is used for both system and runtime suspend.
> Although this change may update the PCI wakeup state during runtime
> suspend, it does so only when the required wakeup state changes.
> Moreover, PCI wakeup-capable devices already have PME wakeup armed for
> runtime suspend, so changing the wakeup-enabled state does not affect
> runtime PM wakeup behavior.
>=20
> Note also, since the PCI wakeup state is derived from the wakeup
> configuration of the attached I3C devices, the PCI device power/wakeup
> sysfs attribute no longer provides independent wakeup control.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701201533.2208=
18-1-adrian.hunter@intel.com?part=3D5

