Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377814;
	b=Kq45ePgWvkXvntNcZfVsSHXcnkkTINuvNqruvOQ2JyK4g+3wrIktJMxVIKkOGnuCd/lO
	 S3mJXTFqQ187O7nKMMeMYqCQtdvvLZjpwVmFLOwnhpHZX3fTDczjia20U7Y0SJnc4ZLqW
	 4axmRr455D5mxnnqkXA/98bsIKynI3h4jDnMjn4+c0m76s5QvQNu69P94yZuMq2Li2vLw
	 RSJMtfRaJNhYLUPEVB9DP3siPw8y1gptfrn+9rPiaG+NrWwjSVsoSJXh87NlVwH4jI2zN
	 VDoONUkAbf4YHUN0+8F9S6ONZhkLgBDCARWsYfCKKpbuATnbfcLF1o1TZVv/heJQxRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377814;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EYNq80LVG8+O6hN8e37MQ/yNVhYwG2SMRoWwZupfLaU=;
	b=NbljCimn9yGoW/eiGKl581Ed8ns97CpOK+A7iWVLnNmi5Mfo8VG88TV08SZJibuatiVm
	 XpplhLx8ioDE25up0240mgPae/05NfUgw15RgySpKygtUf9iAjckTwWQrM4jMfGJns3EK
	 QZ6xi18Lc3TZPiR+BvMdPbiSiaXb56eDS8m60INRa0LlTpK6A9ZIN1owwOGo4onEfXxBv
	 xOQrxM3hR/DLwIDfUQJtRNi0+CX2F5fgKcv8g25NiX2dK1xPdLsE++6LgyM93w3ZyuXtd
	 cEZ6RMm2VyLX5Z+qcrQVFaGZZWDf5tPYeaNrjGSv1qU6gb1NHp5YMabCIQvD1fwtLEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFZTTNFg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EED606A320
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFZTTNFg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15541F00ACC;
	Wed, 11 Nov 2026 06:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377814;
	bh=EYNq80LVG8+O6hN8e37MQ/yNVhYwG2SMRoWwZupfLaU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFZTTNFgi+DNcGOHFcNcYX64PGIzvwPOIAB/65w+nD+1m2TzIFUzK1DwmQncz9P8/
	 JdUEpExTv9VJ+43huRJpp3JtEwl4wqniKuk7cN2u7/jswRZlBa8yevysqs6BlIDLPt
	 zQJi8quuWOwqonuCvureauirhPMNGgC0IUVhtoIEzmNmj8aVhZq7iG3GZuGeZB3V7j
	 +oui/2yAs94wL3g5V6KISXBRTPOTmeXWgB/7KwWj30q3BcUK35lkm+sKXP9TJZpLL9
	 /WV+o2RVCBWzNUkEjyeeQ2J2QsyRI/j3ofMnwV6/q+CtjagcEFESrF0ANPo8UgDuFg
	 Cw04E3HCxc42Q==
Message-ID: <sashiko-outbox-208418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/19] PCI: liveupdate: Add feature header to struct
 pci_ser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-16-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-16-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:52 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> struct pci_ser currently defines its own PCI-specific required_flags and
> optional_flags bitmasks (capped at 64 bits without recorded structure
> size) and stores dev_ser_size in the parent structure even though KHO
> block headers now record entry_size directly. In addition, struct
> pci_ser and struct pci_dev_ser still carry __packed despite having
> naturally aligned fields on 64-bit architectures.
>=20
> Precede struct pci_ser with struct kho_ser_hdr via DECLARE_KHO_SER,
> removing required_flags, optional_flags, and
> PCI_SER_REQUIRED_FLAGS_SUPPORTED. Remove dev_ser_size and
> PCI_DEV_SER_MIN_SIZE so restoration derives the struct pci_dev_ser stride
> from the KHO block header entry_size. Drop __packed from struct pci_ser
> and struct pci_dev_ser, adding an explicit u32 reserved field to struct
> pci_ser for 8-byte alignment, and bump PCI_LUO_FLB_COMPATIBLE from pci to
> pci-v2.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D15

