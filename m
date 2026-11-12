Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495021;
	b=Kz0Y2GD3aH+xv5E8W4Y45FogYFCsBeojrngP52F9k0EbZpZqDQTpnA6Bwx47K5muDpZs
	 lx7L+W+6kq46PB45plrxwKTo/cyVnibTrCCvLvUv+ZaaUq7Y2AayywYhU7x5GKpTMdQrm
	 AYBKtsoHf/sc7AcKCM6r7De+fYuF5wd8OjBWtK3ywYyvOU7eHAHHdV3rkMFXUWTEcOJOJ
	 9NZ8vOqbHr9Y2FI20ikArs/WecV2o64JB5wyptgscOphJnuaACm5Vs12Tk0TCRjLGcHDC
	 +5/OrKD8JihPoXSIggSLSsvMmd8HqRUZcTu/i9lTTB+7VjBeYJZwXRKZbEBZ+c1ecPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495021;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Safkr3vkTGZQ0dp+p8Ztn6vQyMELpj+mvLExDkf4Vqk=;
	b=Ir5POYR9WETSNDqMCvliZDPlgnStz2SbLV6a6ZtxavcRRjy/a+p+QGMolut+WPVTtOHD
	 HDNDfnAfg4rMwZ4wtnlf4tlUeCE/2r18jJoiS+9vGCCrAF1tnB/G27G+ETNNSludp7A4k
	 2S0QYD3eolpmXw62U2RRXbO9O858Oc1yCBsj3WeJWqIBgwOKBDjkXqM6nihM1hCh78txF
	 a469tlznFizJdEAr7jh6eoEWriesXbMuyM2cmDBL+yrRIomc87WUQsUWEpkvoiyi8BsNt
	 ogvF3dEjjHgd30qDAkgo/AzScOgxZljKju1UDJhdtlod1kMbMMFEEzn+Rx69YKw7gnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fdhsqz2a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4F606A323
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fdhsqz2a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF941F00A07;
	Thu, 12 Nov 2026 14:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794495020;
	bh=Safkr3vkTGZQ0dp+p8Ztn6vQyMELpj+mvLExDkf4Vqk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Fdhsqz2aEjMxeaI2gxk/Em0MdidpGuaAYNH8NSZ5FTwXwo8fbPOeMR9npljjvlW3n
	 sVuUrBx6u5PK50P1d2J2wXj4PrwfCT5EqbH7RveXESMxX1EM37MITFLWKlN9BMFwEN
	 3eHqY/+8/xoU9twdBVdHlpBd6yPy9tS/XmNZbp/+b6A/W/dgNdI5veO4d50wBR5ZjA
	 5Komq85Bg6bYYjYxUdy88Y+Iq3EmTQ29yQsGechb97QW2hrE+Y6p7yMH2U6btZrGs+
	 3yeH+r3Xp5zhchWJoqYLTYnM3cB76YYCa90TzGcTomTyUE92G4hwm0b+I0paKn2y+R
	 EiKcBQNlkhoMg==
Message-ID: <sashiko-outbox-211386@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 16/20] vfio/pci: Restore device state from
 slot_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261112141632.918954-17-skolothumtho@nvidia.com>
References: <20261112141632.918954-1-skolothumtho@nvidia.com>
 <20261112141632.918954-17-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:50:20 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A host reset loses device configuration and IRQ state. Add slot_reset()
> to restore the configuration saved at open, discard the old PM snapshot
> and tear down IRQ configuration for userspace to rebuild. Record RESET
> before restoration so failures also report that a reset occurred. Leave
> failed devices blocked.
>=20
> Use the locked PCI power helper because native PCI recovery already
> holds pci_bus_sem for reading. Taking it again could deadlock behind a
> queued writer.
>=20
> Preserve NoINTx and recovery masking when restoring saved configuration.
> The state saved at open predates the NoINTx correction. Route PM
> restoration through access ops while the device is open. Open and close
> continue to restore state directly.
>=20
> Keep the original error_detected-only callback table for Xen PV and EEH-
> enabled builds. Xen treats a missing slot_reset callback as recovered
> but treats NONE from a callback as failure. EEH also uses callback
> presence to decide whether to keep a device. Disabling the new feature
> alone would not preserve these decisions.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141632.9189=
54-1-skolothumtho@nvidia.com?part=3D16

