Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776936;
	b=01umKCn5jOzegNXlAvdSeHrOHOGkFDC2+9TY/dQeyGyw7HvNN8SMcjZDo9bmsp22LJoW
	 FozikoA1++iXxgKYhVxNis94TQs1/ijZEmnVzi+K68viESpXHN69N5kMfcF3ODSgPQtFb
	 Pqbs9W/B50hd8emxxEWt14x8pSVImSP29yu9Ja3e2vkdcRUl18ILHkII4zG1xNBqhBk2b
	 bnzVOKLNaFyhPuWSvsNAAvWPgYFU9coG4IN9JwLAHfh2/zYxklZt2gRxvaPtIc82Hmhgv
	 nF6ldMJDtyl6HcU0+LqdQB8x/qMkRtk40sOGIcUEcBuSqIYEMNTnkkL99Dm/Atx7vcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776936;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/WGNPaz1Q46mz1z2FdJLebYivzPiE7Ffu3QqCdpn7qw=;
	b=spx0mHpreymyUTW4bxd4rFZHaqjz4wVZFK1dSwnoWYYgz/z67Sw3JiWWM5byA2qKzs5g
	 N+iJ0ObAZrIwVXAW065K59HIEpJhWoc+O+DkK9ecMvC0e3LhZcfS49h241fo8e9GODLhX
	 tNzeEehaUiKvkaAuNAMjsvD2hXh5I0AMgzrG0F6N3UJZjG/b0onsZ4mZNr4OmAE1u0wcN
	 mGrARiLY5vwJxIa/4p7+qB+A0qHwYX/5VNA6+WGJDGbhfKlcItddvxN85Fi+CjRs6wOum
	 6rZpKEecum/3XZwCF677qRh4cz1dGZJ8CWpOJN1jPaxEVshmuEYTJYP9Yw9QYBo3BhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5DS7J6I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475A606A31C
	for <linux-pci@vger.kernel.org>; Fri, 27 Nov 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g5DS7J6I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB261F00893;
	Fri, 27 Nov 2026 10:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776935;
	bh=/WGNPaz1Q46mz1z2FdJLebYivzPiE7Ffu3QqCdpn7qw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g5DS7J6IE3h0nCguFuE51zfiGTC2IwJKwk+zyyYoWhkmRt1hfVnX6TWzuryzn+2EP
	 u0skG2ej2NrszEiRpI0qHuikPhx/+hTvfJL9ViWigOYNW5GRnobu9hQ9fY76npEI2W
	 oa+9KzUjWkjJwJ47YghGhgSJb+kXbiMuIQ+rEwV5qjHPW9B3j2mDfdqiwekrCorr02
	 N5Tm0+VLorS3/s7bdQqrboBHnw5VD378XfdPBt0ppaClX3+SJay56yOaEqJ/kfeXa9
	 t63TFV8X4ZNro0PANZCojn0yC87QNVXhfiEDsCdJVhWMgUueMPG8yfw9cKXVp88j8I
	 WxZPIc92D6EjA==
Message-ID: <sashiko-outbox-237183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvme-pci: wait for MMIO to come back after resume from
 suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Moritz Hiller" <m.hiller@pc-heini.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261127104637.219891-1-m.hiller@pc-heini.de>
References: <598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-heini.de>
 <20261120180814.GB1810@lst.de>
 <20261127104637.219891-1-m.hiller@pc-heini.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:55:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On an ASUS ROG STRIX X570-F GAMING (BIOS 5044) with a Samsung 9100 PRO
> attached directly to a CPU root port, the root NVMe drive sporadically
> does not come back after resume from S3 (roughly 5-10% of resumes):
>=20
>   nvme nvme0: Disabling device after reset failure: -19
>=20
> The single readl() of CSTS in nvme_pci_enable() returns all-ones about
> 200 ms after resume. At that point config space answers, the link is
> up, the device is in D0 and there are no AER errors. The controller is
> not dead, it just needs a few hundred milliseconds longer before its
> MMIO space responds.
>=20
> The platform apparently removes power from the device during S3 while
> the PCI core still treats it as D3hot. pci_power_up() finds PMCSR
> already in D0 and does not wait, and pci_bridge_wait_for_secondary_bus()
> [ ... ]
> the help of an LLM assistant (Claude). I reviewed the change and ran
> all tests on my hardware.
>=20
> Link: https://lore.kernel.org/r/598ee2b4-32aa-4ad3-99c7-db7f9a7e7736@pc-h=
eini.de
> Signed-off-by: Moritz Hiller <m.hiller@pc-heini.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127104637.2198=
91-1-m.hiller@pc-heini.de?part=3D1
