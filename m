Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416948;
	b=CsqrL6l8e30l5JK7Bf5d5ovVQuZ4WfVYHKWgvDRzqAdbx0ZYYPmq7Sdxr8GfHHb8wj58
	 cdDQYrm2Smp+0SSJj/UAFYkg4O7o1euaZpeWoBlkU2Y1X5eHOfX9V/UBnYsdW14wyDtIG
	 z8Iy/IiCgb2knS7k3+lgT1+agNUL1Jyi6ewwQALyEeTkeyGhQIOPV7PLErxtJRsVhypYj
	 kewYjEr+PxB0qJKOhZLXjS3M71zFpZ5mZNGL8uB8f4F6EXErX2YQo+32IY/Y4++duIoSq
	 MMDSoKymfz3an9QIX3imiLxv9kh8nMQNiU/EgxoDDQhVhxVy6PR8Nj73Pb1WzUVKKmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416948;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cOfFlp6bO6i/FqBYSiep7rAGIpU7paxYRheGtlQOPBo=;
	b=Rq8mz0k2PtF+mHjkBiSiAVr4uLFbqFbpAr3SrZecV6KN/o1H6iQ9scZlmOw7vubzo6xQ
	 tRZF16gjSmu2/qfjqSlN9Jbax41XNzhCnX+A9UzunZOv5eBI7MVsPcivupzLZBLGTxOMF
	 VwJsGwphF9KPxat5em5z3wqTUeIPRW13IXOr30dw4vUsA5KjUGHnHBhmTFTJek4wMjVz/
	 2IzvYjl2SwHD2bUHx4ZKM7+1jjTeyfF+iL10TTKVyMRHYsdjBGqsY7zMOE56Pb/o8CP6Z
	 Af9VDq+F+C73J0z3y4pqg3e9Znal0eQKhkTjp6tdh0dluGTUHQsOUjF4VbjkuThXAnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AR62WAXQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8958606A31C
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AR62WAXQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820831F00A06;
	Wed, 11 Nov 2026 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416948;
	bh=cOfFlp6bO6i/FqBYSiep7rAGIpU7paxYRheGtlQOPBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AR62WAXQ1Lg/Mo1XeIcZw0Wcs7dIjwbMObrZprydMC5IwfIR3iS5YICAD82UAlFwV
	 3e9Xz/0iTVANeVKpM0Gmv4HjZ78Z21luAIwLiYe1/IS4/q06QXQHmzhqa+7YfDRmyf
	 7VpNP1EKEb2i9Gncj6Cv5gtvpr3yCw2kw1DUJZMGbRYZOfwJDxhHxMG5B13psCMmX6
	 WbaA3ShhfMS1By8yv0UKSZzrOpI1hjQKb5mE/AR9c3E9Q5V1WJEVKxyU0XHwkt79rc
	 WN7+iCHnimWle6KTZDPb293/TRs5WVaXmtM8tiF8eZ8s8CLtEF3GMj+1mxqaT1exuH
	 m3FyKlhYBBLfg==
Message-ID: <sashiko-outbox-209377@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/3] PCI: Cache bridge firmware secondary bus number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-vfct-regression-v6-1-393797bbb6e3@amd.com>
References: <20261111-vfct-regression-v6-0-393797bbb6e3@amd.com>
 <20261111-vfct-regression-v6-1-393797bbb6e3@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:09:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: dead fw_sec_bus_sampled in pci_read_bridge_windows() and
  log mismatch
--

commit 263ccf4863cf26244ff7441d7c145a467a3a1fcd
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI: Cache bridge firmware secondary bus number

This commit caches the firmware-assigned secondary bus number on bridge
devices in pci_read_bridge_windows() so downstream devices can query the
original bus number after bus renumbering.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..f20a4b8f7a23b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -505,14 +505,26 @@ static void pci_read_bridge_windows(struct pci_dev =
*bridge)
>  {
>  	u32 buses;
> +	u8 secondary;
> +	u8 subordinate;
>  	u16 io;
>  	u32 pmem, tmp;
>  	struct resource res;
> =20
>  	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
>  	res.flags =3D IORESOURCE_BUS;
> -	res.start =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> -	res.end =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	secondary =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> +	subordinate =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	res.start =3D secondary;
> +	res.end =3D subordinate;
> +
> +	if (!bridge->fw_sec_bus_sampled) {
> +		bridge->fw_sec_bus_sampled =3D true;
> +		if (secondary > 0 && secondary < 0xff) {
> +			bridge->fw_sec_busnr =3D secondary;
> +			bridge->fw_sec_bus_valid =3D true;
> +		}
> +	}

[Severity: Low]
As reported by Lazar, Lijo on v5 [1], is bridge->fw_sec_bus_sampled needed
here, and does the commit message match where the bus number is now saved?

pci_read_bridge_windows() is only called from pci_setup_device() ->
pci_scan_device() when a struct pci_dev is first allocated and zeroed.
Later bus rescans find the existing device in pci_scan_single_device() via
pci_get_slot() and return early without calling pci_setup_device() or
pci_read_bridge_windows() again, so fw_sec_bus_sampled is always false on
entry and is never read elsewhere.

Also, the commit message still describes saving the bus number during pass
0 of bridge scanning and guarding against rescans, which no longer matches
caching it in pci_read_bridge_windows() (and since a valid secondary bus
number is always non-zero, fw_sec_bus_valid is redundant with checking
fw_sec_busnr !=3D 0).

[1] https://lore.kernel.org/r/eba45235-a6b1-4a48-9c56-9e069c299478@amd.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-vfct-regre=
ssion-v6-0-393797bbb6e3@amd.com?part=3D1
