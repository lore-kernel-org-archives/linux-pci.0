Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794535951;
	b=fVQIRYTYb4uIJgD4NLrsOM+XDbPHTEFurxo+NWfqq4PepYbAE24n7YLqJLhQj6o8DEA+
	 9ETP0m4RXKZYZgR14I7sahLQ3dxNDfS4DOtlQnkYb3XiWDMS8R4AqIa1NWH5sZ3rv3A91
	 pY3Cyv91AJobs52FXN26TrurYDGoKoisdth6h2wl5tpHjPe+rOC5lXnKlicNeXS1qkW8L
	 LMidrbpPekJLLRvzreJYtS6zb7Sa94gQ+z7UvTXFQhpcGl97jUTa6YUm2rd6LFGFIiStY
	 3vSRo0i8vcOHeATdTFLrPAMQvIWKVpxJtE4cbf7mbZ0k1RojovXlLgEK56u+rW9emMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794535951;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QNjZ2czQKubTiROPrGQO3TA2OQ1C0AKWAIPYpsD16Vo=;
	b=fljU6qoVmk2+z4urPAre7RfqvCd/KpVsNauqKuNbo4BpFvV514fwfuYn+vPzlhZ/iGiC
	 +TMaoglE0g3/4XqOoz8LFbU34ypKM95gpHojPOcBGmmWDGa5lp/p9MxUOvy4o186Vmnvo
	 /GGm6Lxshw+aCGlyWN41ZTQrKjayc0JGdCWb/TZak7SfHoESbOL8HPuN9N9u8DXg9KYya
	 RP/79p5LBVXosO3jFls1lELMzoe/ICHG9uoiCBAk/XPdMKzSGarxiyfc0jxHQf9QaTfqs
	 zKmoVVbVbP9jw+7QFove5I9SNcUIxurZ+wXmLj8wHJn5ZUzLz1hzTwh4/igWmNtRcIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+X7blCD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED744606A31C
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 02:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+X7blCD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61ECE1F000C5;
	Fri, 13 Nov 2026 02:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794535950;
	bh=QNjZ2czQKubTiROPrGQO3TA2OQ1C0AKWAIPYpsD16Vo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i+X7blCDnxLJRGMP3xNd2u5wjBStLSfzEl3U26gw1dD6ApyAe08eBDG6FFdH/EIgg
	 r3AtK2l04cDUpkZUVW+T7ihCDNRsQr/A6CvUNgQbuQVXdxSlV4yWIOEcqOAHdMPCOr
	 IZL6NagYpPN5/YVZdCGuSTcg1/V4eX62fYpq24ouCatRFYV5O3b83JvANNRTTWItVB
	 koQuw8Z6gGXaSv6PTiJ9xVei+F8wYgn6IBPiDLnktT9b1DYiL0lHlWv3a9AFr3QZZM
	 gMbi0s9hVSoMGlIkPxeqRtoNV3OF/xKxJ0VSq7wkt222LDZIQxWXCSENOth1Csmctf
	 Uk7yBDIKC72zw==
Message-ID: <sashiko-outbox-212080@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Disable spurious s2idle wake from the NVMe root
 port on ThinkPad P1 Gen 9
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kean Ren" <rh_king@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113014824.2396883-1-rh_king@163.com>
References: <20261113014824.2396883-1-rh_king@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 02:12:30 +0000
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
- [Medium] PCI: p1g9_rp05_wakeup_dmi matches single SKU 21UFZE0PCN
  instead of 21UF model
--

commit 75de6a519b5eeaae2e4b61c8891c8afd3aa3c727
Author: Kean Ren <rh_king@163.com>

PCI: Disable spurious s2idle wake from the NVMe root port on ThinkPad P1 Ge=
n 9

This commit adds a DMI-based PCI quirk to disable ACPI wakeup on PCIe root
port 00:1c.4 on the Lenovo ThinkPad P1 Gen 9 (21UF) to prevent spurious
PMEs from aborting s2idle suspend.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index f7cd4149f8130..ead7a6c456986 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6610,3 +6610,55 @@ static void pci_mask_replay_timer_timeout(struct p=
ci_dev *pdev)
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9750, pci_mask_replay_timer=
_timeout);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_GLI, 0x9755, pci_mask_replay_timer=
_timeout);
>  #endif
> +
> +/*
> + * Lenovo ThinkPad P1 Gen 9 (21UF): the firmware enables the ACPI wake
> + * capability of PCIe root port 00:1c.4, which is the root port of the
> + * primary NVMe SSD.  When the NVMe controller is put into D3 during
> + * system suspend, a spurious PME is raised on that root port, which in
> + * turn fires ACPI GPE 0x6F (SCI) and aborts s2idle before the system
> + * reaches the low-power state.  The NVMe device itself is not a wake
> + * source (its own ACPI wake is disabled), so disable the root port's
> + * wake capability as well.
> + *
> + * No firmware with a fix is available: the issue reproduces with BIOS
> + * N4SET31W (1.10) and N4SET32W (1.11), the latest version at the time
> + * of writing.  Match the model only; if a fixed BIOS is released later,
> + * this quirk can be removed or restricted to the affected BIOS
> + * versions.
> + */
> +static const struct dmi_system_id p1g9_rp05_wakeup_dmi[] __initconst =3D=
 {
> +	{
> +		.ident =3D "Lenovo ThinkPad P1 Gen 9 (21UF)",
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "21UFZE0PCN"),
> +		},
> +	},
> +	{ }
> +};

[Severity: Medium]
Should p1g9_rp05_wakeup_dmi match "21UF" instead of "21UFZE0PCN"?

On Lenovo ThinkPads, DMI_PRODUCT_NAME holds the 10-character Machine Type
Model string, where the first four characters ("21UF") identify the model
and the remaining six ("ZE0PCN") identify a specific factory configuration
and regional SKU.  Matching the full "21UFZE0PCN" string leaves the quirk
inactive on all other 21UF configurations running the same BIOS, so s2idle
suspend will still abort on those machines.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113014824.2396=
883-1-rh_king@163.com?part=3D1
