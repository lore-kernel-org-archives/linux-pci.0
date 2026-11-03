Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731201;
	b=DomYuTi8ftFMTokPR6XRZbnTtwVG8FzHgfUSZsdy0eGcPZOr6r31t63H5lCG0YhzwjMw
	 NOMW5wIsEWA+vEgdyfJGk/Xvn1xVoQOCDvHY9PSy0DfaDr8757cWnYyLIo5a0XalQztnG
	 hYwS1+z7yEEely+XFCx3BfhjLNjJqQbtE/VDJBvSYo32oNu7kUjYZUXpVLS7F/pv828LT
	 J3ozVRN3Ti1ZhB5Pxm+q3/Ty4qqMPL9Tfu0jT6Iqc0CQjxUDNASV3G2cLmcBLCmkH7xt3
	 TbDG5Rs4A5g+gp4kJ6x/vrOU7bQMDc9pazBOO2P7rQM8xS3SF+d1e5zsTIoWk/XfvnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731201;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IZyyXmdA1D9MAOGe9k+rknKdAhjb+yMZpEmqN0cgo0o=;
	b=LLNCEx6pDPoeblhLOCh/Rm+24hpdNQ8PreF4FAxM2ApMna8R9QjD7NTd1ouJVVDpzjZ5
	 FpHnbAriI8oG98qk5wKA7+QtpAolTUEG0SxJ0uvcqs9bOH4tZFhr5pdvbw4wjO4UMjJpa
	 t4sCA2W6wi8SG6cJTivGtGbrgy/yd/K4f2fbVIu0Wl5Fm1sYjwIk8jFf8MdZ7f321wC7s
	 5w3sVuxx/52LpaiJxrH7KwPCN1j7IoWW35lFynSNqxn0pDBm9JU/PFWWYzLFhs9Pn0I8I
	 NwbLIZbCMI/QU3J3kL7vXwned8WuibFGNRw/HZSL6g3pg2rcLFPo+iNm/rZ3MjXal4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrbHV87k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFF1606A31B
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UrbHV87k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065DA1F000C1;
	Tue,  3 Nov 2026 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731201;
	bh=IZyyXmdA1D9MAOGe9k+rknKdAhjb+yMZpEmqN0cgo0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UrbHV87ka4Tv2OBkTF2ZUgoBgU3aYlbibuB+sEbIQERX2AAyPjeW0pin0y32ADotA
	 K4h1WaesRqaws+AQNoOCcgABE3KQHYG2TY25lrWyYJ9UxtiY8MQcqFryvh7ZkSllhv
	 4BPpX9+Ykxkp04CGHMv2hEx2Ag32fWJJpjBJ8sc5egvWT7jcXW4Nc03mgDHNRD6McR
	 V5Tp3p7JT7hqCy3k1cUiYZA250w2Fzw1Ecd/x6ol4exduNh7Pz9gMkb6jOlwnRNc3C
	 Vo/pXtqrx2ZlgUcU52XmdYVNcnC6CO/IQ1VPAZfRwKj9nn4dgiDlrKv8VzovGO0MCC
	 s7YS1f/ljsvyw==
Message-ID: <sashiko-outbox-195854@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/5] PCI: Don't suspend IOMMU when probing reset
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicolin Chen" <nicolinc@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <c66d5221a8e4356316d4f614c8584a80dc9d71b6.1793729707.git.nicolinc@nvidia.com>
References: <cover.1793729707.git.nicolinc@nvidia.com>
 <c66d5221a8e4356316d4f614c8584a80dc9d71b6.1793729707.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:40:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> reset_method_store() in drivers/pci/pci-sysfs.c discovers supported reset
> methods by calling reset_fn(pdev, PCI_RESET_PROBE, ...) without holding a
> device_lock, since the probe path is expected to query the device's reset
> capability without changing device state.
>=20
> However, pci_reset_bus_function() and __pci_dev_specific_reset() violate
> that contract after pci_dev_reset_iommu_prepare/done() were added, which
> moves the device into a blocking domain and abruptly aborts any in-flight
> DMA. Doing this for a probe -- a state-query call that does not even hold
> device_lock -- can cause driver timeouts and data loss on a DMAing device.
>=20
> The peer reset helpers all handle this correctly: they short-circuit on a
> probe input before touching the IOMMU.
>=20
> Skip pci_dev_reset_iommu_prepare()/_done() entirely when probe is set. The
> inner reset routines already implement their own probe semantics, and they
> perform the capability checks and return without changing device state.
>=20
> Fixes: f5b16b802174 ("PCI: Suspend iommu function prior to resetting a de=
vice")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793729707.gi=
t.nicolinc@nvidia.com?part=3D1

