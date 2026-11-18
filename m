Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026420;
	b=XG4iAYlvYs3PhxMGckDNwFiBvAKC6XO+QPj2Kj+gAF0G0cL4kda9FnXw8nIGzHFItbz8
	 EDicBzNWulX+nROb6gWZbBbhneQtGJAzZTIR1FFAnJyyFyZ2VBVmf89jG6k2PO8qrQgaB
	 thgX2BTfoYKCwz4SuCvrKm2Iqa5njCaH6K6b9eSwNU5svkCF3MJ+/8J3qOWXSOQ+bB2sU
	 VVOKpZaA4Au4+z4dSBTNe87jMPc1APpxY/Jf4lqa8FpDlOg9boLHja0nUyPX8w0QRE2ME
	 M1ZGklZg6APpcLZOS814s2rAuT9UwAtp17MDf9Yao+mt4qybwZfrLdxqEUnd1XV8DXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026420;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sE9ZrUWQuA92zFu99YwuuIrFAGyWC56QUMh1euSw5fg=;
	b=r/7Hb/hUp/94YtOSsmizbNMGJGdFivWpwiKHYnngooLXbPTjTwGDwAgVHUBUSo/QSRwZ
	 3FxAe6LkVgfaXFJ1Rp85b0cpAiarVsNLGi2LcFVYXtYXf/89vuEPMnOkE4vr/1XOZuGOU
	 oBKrldEgSkSMpG0dlHtVDDNoAwD5YXgG/hlvJOn+q7RtYUSmqQlTKA0FBEdfnzYgZqnyE
	 rqPhLMDKolhTB8iZVxBartPHzbs6epAWQTH01UMqRAuNjcHNa0ID4fml68wmPjbKF3IX0
	 Y2UAnAEk3x7/IvayEj5CodbvYzP04q5ZdmBi2D+jn1ajNeUmHNfozTy0/s53c6OlKAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSKhejvs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E65606A320
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MSKhejvs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5749B1F000C5;
	Wed, 18 Nov 2026 18:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026420;
	bh=sE9ZrUWQuA92zFu99YwuuIrFAGyWC56QUMh1euSw5fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MSKhejvsy/Xg4wSorMsYymgAy1QNu1PlpfDg591vzl2urMpiAwayausnR9p5DQkjT
	 wCY7YJlGZmOYLQkHE1sxJDFO9pzIt/Du4xxF1wQuqvzogY1XEGJnSx/NgTmcKg2WfP
	 DVxIZmpcnJs4UGEO3AgxYET6KoeAfrgHsCND5mrM+9aOwSDjOS+JDg7wE95wjMWDxq
	 yXHClNLd4MRf7fajN8l7rsPXTUXGjdBvbEAVUH4ikZHE3BEkwhQrazn/ZoSFAF8ubB
	 1vesSnvlBH//kJb2GjO2jrCV11xgH4H0otInk3WoMIJok8IlrokFPXY5rTeB2echn+
	 cGnnEuSSLd8KA==
Message-ID: <sashiko-outbox-221752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] PCI/portdrv: Don't require AER to bind DPC
 service
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118181718.3907441-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261118181718.3907441-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:26:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> get_port_device_capability() binds the DPC service only if
> pci_aer_available() is true.  pci_aer_available() is false with
> "pci=3Dnoaer" or when MSI is disabled.
>=20
> The DPC driver does not need either of these.  pci_aer_available()
> depends on MSI only because the AER driver does not work with INTx
> (commit 3e77a3f7895e ("PCI: Disable AER with pci=3Dnomsi")).  The DPC
> driver does not depend on MSI or on the AER driver, and it works on
> ports without an AER capability.
>=20
> PCIe r7.0 sec 6.2.11 recommends that the OS link control of DPC to
> control of AER.  PCI Firmware r3.3, sec 4.5.2.4, requires the same for
> _OSC.  Both are about ownership, not about using the AER driver.
> host->native_aer and the _OSC negotiation already cover ownership.
>=20
> [ ... ]
>     uncorrectable error that used to be ignored with "pci=3Dnoaer" now
>     triggers DPC, which takes the link down and resets the devices below
>     the port.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118181718.3907=
441-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D4

