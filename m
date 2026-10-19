Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3FB491B0C
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420829; cv=none; b=S2iNbD2s4jElFfnvGsnEkCyRYy19iEy6FTo3I2dkoGgc4qIvW0WbqJcyKAp/xKQzR0mp4INA7zmwAQdq5wK0iTgPB20W/CdszxqezkQuyLY9CViS9h6Vv6oBpFn7Y4Y0930cxVho3Iu7zstIZvdlCBBCiDUQJ6zq6pPE1x27XOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420829; c=relaxed/simple;
	bh=6O2HhcjPYQic5ln7m2/RzoLUsXD1ygP4KQwH3K5B4jU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=o5IKheD4/wnKiJ4QirRHMjQFgHBNwpP2KFVLnLhcQ5IKGqmlMfAVfkUtlrKE0/eEhSADJzaqf2Hh0ScOIPkboiRMvZbs/5HfZ/llO1TTUZCl3zdPsO9XjuF+OWePMDyja8R4OWkvkd3dz55RcmM4BAkqjL8YKwdftl+G//7/ZTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/uDyZBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/uDyZBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111ED1F000C5;
	Mon, 19 Oct 2026 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420828;
	bh=6O2HhcjPYQic5ln7m2/RzoLUsXD1ygP4KQwH3K5B4jU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/uDyZBDRGHbtdaYMZojNge/NfsoOL5JAsOnVFs3Db2UJXS8sL7E0ChOptoDtNzpd
	 ChkP5N6QJd3ghpVezsvRpdb9Lr3Iixwd0r7/FCgI1+buXdqGVdXXxqlot40U83ZCFr
	 pXGSupR8qkgOQRnKX3gvDBXRIMg4aBr2MqjzdcRq9hjPwBzof0YrZEFhGwKSYbMN1C
	 fphJy2IBV6fniEhSrhhW0Fc2xbAd9CZl1j/zsA6UUjlNU/vT6XsUPTmaR6I3wx/Juj
	 QkApiR7ZUwF3fOTPtcs99yVBMyYuDhL4FW5JNdxmQv6voRVCMbi/YKtBDAQPk5BOHJ
	 4qfh0c2QPJzYg==
Message-ID: <sashiko-outbox-177469@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] PCI/portdrv: Allow probing even
 without child services
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019135441.1420968-203-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-203-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 14:40:27 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Brian Norris <briannorris@chromium.org>
>=20
> [ Upstream commit 834171efeefffb1a0f2136f32e76669bbc11db86 ]
>=20
> The PCIe port driver fails to probe if it finds no child services,
> presumably under the assumption that the driver is not useful in that cas=
e.
> However, the driver *can* still be useful for power management support --
> namely, it still configures the port for runtime PM / D3, which may be
> important for allowing a bridge to enter low power modes.
>=20
> Thus, allow probe to succeed even if no IRQs and no child services are
> available. This also mirrors existing behavior for ports that don't suppo=
rt
> any portdrv services (PCIe hotplug, AER, DPC, PME, bwctrl), where we'd al=
so
> probe successfully.
>=20
> [ ... ]
> [bhelgaas: reorder pcie_port_device_register() decls per Lukas]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Link: https://patch.msgid.link/20260722160942.v4.1.I5fd5d83f518681b3949d8=
ab2f16ba8244fd3e774@changeid
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-203-sashal@kernel.org?part=3D1

