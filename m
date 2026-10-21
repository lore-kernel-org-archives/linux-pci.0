Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792574876;
	b=s4GyQDRFPjLvLgIwEqzOUjF+rGxzyDDfHojlv9qRI7qSZIhV5kwvi65HXH4DJx4E9mSr
	 ZxxVC3i1oSPkljxhpTH6uvFGkqkTJcaW05iZ/CR89X758Lypkzl7VJIs90tw1Nn3O0oZh
	 kyL40JMO8/rm6roRxpQdodozSbvYxORlfp5Vkq/lCopi8pdbBSQpW5bGAd7ujkzz2PAEv
	 4v/N9Y0LxF2Rpu53x4Hpono3/+A5I4S6O/uJ01ZhuCx5A4ungSfaw9Z7lBqKX1WSWUdBF
	 5gdYI6RrNOTsSCgr9NF0dzspY0De/j12rXN1Ys6oY28F/nod6+KGEz3IFSrR7/fhXgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792574876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gVmOAmvtDoIFvtJ7YXHAySM4n0JsATQweHYdNJDZ6vE=;
	b=iAUGNOskaUC/xauZV7bIrjDIky53TXCeKp3/BsQx+0mXH7YXDug8t5kT6cifQ2ds2abc
	 h5IlDCNjZSVrlGqk+H+Ip6xkYK/G08zLou9AmQtWhXRofderjfCSvIhFrqDV+KuIa+dg8
	 VUXxi+ilFvkgzX8+uLZKL2aYmQjoqT9dw3+cBStpqLN2gBcDCWxUoVPes93jiWqAQPcTr
	 M3zEzmtBfWH/6TCC2Gp8bz0jvTW6HuTtf5da4RDPcI37UDG4BpcIANv8v27lWV2jSXozC
	 k2tYE+aKcmUlPnMOzuwrGCx5pj0U11nooQcj8fhbziuz0TtCARjFSr7SAf5SugAOk5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hygue0X9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F85606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 09:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hygue0X9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCCB1F000CA;
	Wed, 21 Oct 2026 09:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792574876;
	bh=gVmOAmvtDoIFvtJ7YXHAySM4n0JsATQweHYdNJDZ6vE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hygue0X9E8uxytv7fn7gfAWGdUpEIlxOqlYwfQDGU2MufVwi5cC82/SYDklDiBOtb
	 QVZ4NFfa55yQcqxsTkzmfB5MmH0DSMFfYJvDwzuPIhiiMuLhMZFDNzUB3bsfjMUeT1
	 Vh+qSQ4F7iP5cDpoc2JuSxyHOahyiRbbJL2/5/+Tz7ZqKnmsXJfBlkYq/16oAI4pzZ
	 zBxTK22sXbSplc607N9Q/sCGsVgeXzj3mbAnmqGSiV9DGH6bSN3cdlj4yr0hAGenJh
	 dy8K3p8YPVfGsIDuHDpVo1M4ScOCQab5k6vzAZl+tGtzzilCEQFZ8yJ/QczlX8Ywyc
	 ph7zqKcUZ+H9A==
Message-ID: <sashiko-outbox-180029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/pwrctrl/gpio: Correct GPIO_TC9563 /
 PCI_PWRCTRL_TC9563 dependency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <45484c37512a3102495d8b75b6e9f72a141ba42e.1792574560.git.geert+renesas@glider.be>
References: <45484c37512a3102495d8b75b6e9f72a141ba42e.1792574560.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 09:27:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Toshiba TC9563 GPIO controller is embedded in the Toshiba TC9563
> PCIe switch, and its auxiliary device is instantiated by the TC9563 PCI
> Power Control driver.  Hence make GPIO_TC9563 depend on
> PCI_PWRCTRL_TC9563, to prevent asking the user about the GPIO driver
> when configuring a kernel without TC9563 PCI Power Control support.
>=20
> Drop the dependency of PCI_PWRCTRL_TC9563 on GPIO_TC9563, which
> represents the inverse and wrong relationship.
> Let PCI_PWRCTRL_TC9563 select AUXILIARY_BUS, as this is no longer
> guaranteed through GPIO_TC9563.
>=20
> Fixes: eea9a072221d97ab ("PCI/pwrctrl: tc9563: Add GPIO auxiliary device =
support")
> Fixes: 81ec9c22d06aea92 ("gpio: tc9563: Add support for the embedded GPIO=
 controller")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/45484c37512a3102495=
d8b75b6e9f72a141ba42e.1792574560.git.geert+renesas@glider.be?part=3D1

