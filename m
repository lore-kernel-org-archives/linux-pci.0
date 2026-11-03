Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686194;
	b=Bt96SlqHTFh922z4ov9ZOrFslq2goqp0txSqCKA5bRKX6PDGtdkRxAOC/Q5AQCAgho4X
	 rj/csPYVctimQKlwbuKLbpZ+aEQ5sb8Dbnh0BHYmrMJ/IhmrHIt1xMFlSUdAgxa9ZCXH6
	 GwxPW4lsfB6uA83OKLhYn8Iev7bLpLTk6T39pH8R0e9uyapZ+x9Ad7bsnVSVqxGDFwnZy
	 fku7IaMPjInnFqp8b7uksyPv0OlXG4KRaSW4NlO06/VdxpIenPRZ6ELfRtfCw7kdaloRb
	 Ys4ni0R/kR3azCTejS+tlvLdKAy7MjK7iKoL4eFcIZOtGAO6ZpdlyV+3XABomNBZuZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FBRzD4tJ6kQ7flh6N+M+OyodxJMMm2lwDNaDNsp8K3U=;
	b=Ea/lBlcbvOgoa9VUgqXrqgCz8y9tBi1MSmvIsgwD7OgpQsVHKg+ol5tB8FDaenE+DPk4
	 J13UFECgo+9D7HW9XlqcTvgpTzaHwosH+85r+TXANoIz0+J/89+mnNGvsbB8gqoZnIC83
	 JNjgmfbuqplOnmu915OdJGCA2BxIct9ihgFwErFTz0JRTTuIJW2dkjqvUJiA7pSVtdtWf
	 ka8G5hqfx3k3f5INDr3wJmp32Rc82LtHACI53I5n6zT+DcYmg/JhSwSrxr4bTO0ucdefR
	 BTgNyZsgZH+LtpMjTKlQ54EdbBLZKDoIq9I+7qMhQ2ADAEMToYgINtir31CPdbGUK1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5gdJKqq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7521606A32C
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 06:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C5gdJKqq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E10A1F000C1;
	Tue,  3 Nov 2026 06:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793686193;
	bh=FBRzD4tJ6kQ7flh6N+M+OyodxJMMm2lwDNaDNsp8K3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C5gdJKqqHH/3Tmta/rxceJPrsesnQ28UZ0CjVtqVISBsBIe+Zi+e5wwCkzzM6/EZe
	 v7n9ydjpJq//WI5rVRL6NdA3jbHjhq/a6XliTZOzK3dOzhkrUVXu+SnVZZp0Sp1V3h
	 rF2xuSCnbG28LpHwmwRFU3kqWHumsCDwR3EnTc+dC6gNiHPjK8ak2g9hGd1Qv29kN2
	 v+WkpvtUAYrK9vYc903hfh6DIIhTZ0YmnuI2Vm1E9iMgktwfZIT8t3jvp3QNm+x/WD
	 z0yNuAZjUiAwAjbuExlMSDhGPK9nDL+LECFJU5Ka0RMI8zQ+6qGsbzzG4FAb4ViH4o
	 kdYRS4tqeRCmA==
Message-ID: <sashiko-outbox-194606@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rockchip-host: Enable async probe by default
Reply-To: sashiko-reviews@lists.linux.dev
To: "Igor Velkov" <iav@iav.lv>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-rockchip-pcie-async-v1-1-4dcadb94af64@iav.lv>
References: <20261103-rockchip-pcie-async-v1-1-4dcadb94af64@iav.lv>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 06:09:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Igor Velkov <iav@iav.lv>
>=20
> The probe waits for the link to come up, and with an empty slot it
> holds the deferred-probe worker for about 0.7 s. On ROCK Pi 4 with
> UHS-I enabled for the SD card, the I/O-domain driver then binds only
> after the card has switched to 1.8 V, and tuning fails ("All phases
> bad!").
>=20
> Probe asynchronously, as commit c0e1eb441b1d ("PCI: qcom: Enable async
> probe by default") does for the Qualcomm host driver. This does not
> order the I/O domain before dw_mmc in general; an explicit dependency
> was proposed in [1] and not merged.
>=20
> Link: https://lore.kernel.org/all/20230904115816.1237684-1-s.hauer@pengut=
ronix.de/ [1]
> Signed-off-by: Igor Velkov <iav@iav.lv>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-rockchip-p=
cie-async-v1-1-4dcadb94af64@iav.lv?part=3D1

