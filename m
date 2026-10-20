Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520996;
	b=FTnjt094YNvgEqiRaZ6fp+rGdNGXx//U5j53SZhwXa/KQKgAVqZBKHVh6pV3VJyNxk/5
	 ebSwwBo5y0FO/g9SNkQsqmxYZJU7723pQ4KiktEBH+antGRQtTEUbkHjorRbdCvyx3qZn
	 7bmDyYE+6f/ioWf8T0IP87rmeDg3HFsZXo8FiLCSuOHTXhfmQrLbZtxLGFxG9Pjb0/B0t
	 M45t/YaKbavSOMmzGIPLahy8uMi2vLVD6xg/5myPWsEG35SzKN2gs7ET9yhVIL43roanV
	 VEJSkRS0o9u6ufGHuzKr2BMBAVv6mJZa9uwUSOaNpTV8Oz1vfkM0YtSDffFJtVItH/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520996;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=322B6qfp2HOcSk2gNbfNRP/Et234NFJ6hoNRUuZI6j8=;
	b=EGdyz0tFnwqS0AOaNn3akkBPC1+ql7YkAcTshjDSRgCCedf/jVeGVSOm/fSrYgRybCpt
	 ew3QXNF1tHvfhkPfAH/HW+VxMGc4cgJ8jv1eYS3M/bzPieSTyJOn4quLbpnEBiMAxY+Ln
	 RMy0L8Re97xTtAq3IKvLvW6un1j5694GkSeyi4jK3uobIEGPrMRElXiKNovFCT7pm/RyH
	 v5pZZVDvLbrI+uoGoq3XHGXK4mf1f/NYclRS9ss0qOpRX4JSVvo20XhecwpkDs4HortV1
	 VocdwkW5JYHwyfgh1gIDXvPxH3yoxggzW/yYZIXamxCWYRBsHwUvhV69+KKGP/chbmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DY1sAC+t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A4606A31C
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DY1sAC+t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1994A1F000C9;
	Tue, 20 Oct 2026 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520996;
	bh=322B6qfp2HOcSk2gNbfNRP/Et234NFJ6hoNRUuZI6j8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DY1sAC+tqzg5BKni54q1+5n23+38Es5aYdv0CSZbBJmjqTwpGDSeMOrS/KuGULPO4
	 hSq/qRNLIrAEI/0pQxMTDDEuuEWkg7vNoktnNC57Q2PwbsUy6lsLZmm0Q98qUVvgh/
	 GAxjcTHbcMBomZpkyBv6UkTb8AqXyNVq6qflPnR0Fgm5MbEk3UYHaAqlTP9py1feVS
	 8BSJ2Z+nknHX29AWsa9Mcm4SbJkVdC6iAWrpQwPjOJ8qHLwTsTCF/21iXmx/FhwVDB
	 kkd6hEkBIKPwhxpmscL0BBGay8deXm3WfctbIWM5m7G7qB0jnY5Or6bl3Or0iQEH8i
	 1NlPr73FxIdhw==
Message-ID: <sashiko-outbox-179474@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] PCI/DPC: Avoid access to non-existent AER
 capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020181924.3003553-2-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:29:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lukas Wunner <lukas@wunner.de>
>=20
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
>=20
> In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
> DPC event handling") amended the DPC driver to access the AER capability
> without checking for its presence.
>=20
> In May 2020, commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
> parsing for AER ownership") fixed it by inserting a call to
> pcie_aer_is_native() in dpc_probe(), which implicitly checks for presence
> of an AER capability.
>=20
> [ ... ]
> for AER-unsupporting devices.  The check will become obsolete and will be
> removed with the imminent baseline capability error reporting.
>=20
> Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=3Ddpc-native" to allow DPC=
 without AER control")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181924.3003=
553-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D1

