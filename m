Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116889;
	b=kR7ZXenzCvEPATudt+8ugs2zqxL3Q5E47cldxahiQV/2b6LL19LalP+vQ44kVN3DPLNO
	 GCVOxADQ7I2SjqLgJIUPgTCSoP4TLBbA1A6tp7tPjNIcj7kE9WESTnufvYMMW5hvOFfQf
	 79zTlWfBZMv1E4wq987pyq16qkaaa+FkhBhRV6aG1aPCuA1Z7ot83b7YvFQ3Wt1R6FxG3
	 /Ny6wVU5KPXbWyPzfsVQwDiGefb2+/eJEwyZ1K4PaNtPF1DQbU2sBkiQmUU1J4TN8aPuK
	 t7RHo7LZB20w673jEbgRVC8ju/9HionzHMVoPnIU0CC6D07DFO4chxHKKEaKM+/V/xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IPgMHpKRaAJg0ZS0Tvf9O3OIcvT9ccTqXy96PJBT890=;
	b=VDr1IP0UKgjoI1pezRawN0a4BEOb1Ex+ORUwwwAlkyqUF5E1QuChWIL45d5jFEBQh6Qm
	 JlQjKLhKlczv+UF2bvAJPwbXupXebwRWN4KU07mCzRV6OCCFcAdShV2Jr1fmaAK1+rmfd
	 UdG1w2FCOhle0QwiI90mnyWKwEBbTrvH9pwenztwA5wqqm5Qa7TtEKqgiVrW9HH3J1ISw
	 BWqfsSK1+IieQUxFT/R7XjRxhYX8ANOEZ7OcsZy6MfHkvzTqw3pY40tohruNyIDr3WvFx
	 tbmINbmEcKzsCRGqrHPh5Wq5/BOPeSCpgzakt/nVa8IGn4NHDPxaVyMlMqsVzfuBkjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6eHNXzu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5186606A324
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 19:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B6eHNXzu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835241F000C7;
	Thu, 19 Nov 2026 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116889;
	bh=IPgMHpKRaAJg0ZS0Tvf9O3OIcvT9ccTqXy96PJBT890=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B6eHNXzuU6zz4wrEqqAhmAi4TJ/xpPdFF6TPRh65k9o9HozBcwZtJ5paHRoY1B9Jg
	 P4OglIbJOdLm86QBNx6l+vCaB6fbNivhpJ/Tm+Bh+Ag04mW5nlTBWv0DhdDHmmHREl
	 6oU2btBorrSbQmn2iktOdjxS1zfQ+NFYIIzNzzX5JFiWu0MH8fPRyVZSF7SryqCIYg
	 lGyhaO8gzgxPEon7uuTZzuBtRdXPTQ/fCRQLp0pWMHMwM5lxOYgIqBYx1VoT7oUjX7
	 iJcdm5cEZKYS1IQiJg/RYPX3CFWHhAlpVDhBgv4rzr0kcFayVFf1poh+Q4ITUT9MBM
	 nz4zIg4QTYFeA==
Message-ID: <sashiko-outbox-223938@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: hv: Don't use container_of() on non-vPCI buses in
 config block ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dexuan Cui" <decui@microsoft.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261119192937.570043-1-decui@microsoft.com>
References: <20261119192937.570043-1-decui@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:34:49 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Aditya Bhamidipati <abhamidipati@microsoft.com>
>=20
> hv_read_config_block(), hv_write_config_block() and
> hv_register_block_invalidate() are exported through hvpci_block_ops for
> mlx5_core, which calls them for its PCI function whenever it runs in a
> Hyper-V guest. They assume that pdev->bus->sysdata is embedded in a
> struct hv_pcibus_device and use container_of() on it.
>=20
> That only holds for buses created by pci-hyperv. A Hyper-V guest can also
> have PCI devices behind other host bridges, for example the ACPI-enumerat=
ed
> ECAM root ports used for ePCIe (emulated PCIe) device assignment on Azure.
> For such a device, container_of() yields a bogus hv_pcibus_device, and
> mlx5_core crashes on a ConnectX VF. On a 7.0-based kernel it crashes in
> get_pcichild_wslot(), called from hv_register_block_invalidate() while
> the VF probes. On a 7.3-based kernel the VHCA invalidate work sends a
> [ ... ]
>=20
> Fixes: e5d2f910cfec ("PCI: hv: Add a paravirtual backchannel in software")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Bhamidipati <abhamidipati@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192937.5700=
43-1-decui@microsoft.com?part=3D1

