Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501856;
	b=SIAH4yA4kis4vU17V31Tt4E468EZOLbwtiywKGXeo/nHIXzD48nntmB6pNSGoPrK8KUz
	 TlsUb5NqpaXfI7+J4qA42WpVmfSnNqOOnUjwLDsE/LgMp7TNkoV+cQAEUbSQxYdiSFjFZ
	 pB0YKbMtAyUQ756aym74IqjRCahPNvoVxTfOzu8lw8l/UDwK9/oGZFNrfA1o1JxZ19cK6
	 iXBoVkaKL7ITyeCF6PUHqdbP1hGv9xuWazTWm0CLACJfFhve6LUhIqVCMU7r1oSElSun6
	 nierP1dqhbEimcBYY3ohxJ4VpKcdUCmbzzE7O6Sd4UDaMXWtUk7N2UBGPZxGdXnwSFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MGvNI2FGgl46Wnm1wZB4c4eIr3S8Grw+3AIxK8RAD1Q=;
	b=4YaXarfG2lix+ZJl7E44RvZDMvze+gYCZEI6Tj7d0YWbn2XGQZ0WefNEb/EddotFM4NC
	 sdXT9BDIDLum+WZSK3nBQm0b7d8CDABlwNVEi2JVXU7guzPkxO62vGVOczHZ3zBHvmPYE
	 fR7GDTBNnOyx7sTyHNZpRLOtqpNVkl9hvWkXeo6kNPWoB8Q8MmzcCGK8hyQsg9dtgA1jm
	 9yr7l/JZgXEFsSeJ2iD2ZpMoelRmG0ftDfvBsyYJHtQXFJFB5z1TIJzfbSH+sEoHseOtm
	 3j1TXJjitp+tiOV+QEEbOCSgyYmyvD/DP0rWQ8qi186HDo6610Z5Vsu2i/TyJovWBHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+vhM3gm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983FA60A261D
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A+vhM3gm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFED1F000C5;
	Tue, 20 Oct 2026 13:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501856;
	bh=MGvNI2FGgl46Wnm1wZB4c4eIr3S8Grw+3AIxK8RAD1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A+vhM3gmAzsv/iVxC0AunnyjKL2ss0EGqy07ejJkZG5oEfggD84ee2n+rVCuuk0wa
	 9BxXy8UlrfQJPnfkDwT5ZyyaticOMwElPKvBGnpuCPUEuj+Z3+FZ1Ls+08WNAPV5G+
	 yRhWMoNC6931ZMUrorYRCpCrYmZy2OF7YqFyZdOkcIgIXlT2dSbFk5T4r76yrOGNJz
	 3VkWlcq5EkBNYuvN1EaPd8MeA+w/xtneBgTy+QF1TdjQAfilTMoeK2o3eip81/ApEe
	 CkIYjgzE3w+S/YNrBsSrthCfyp9Yd+cWAZ+JMyyl9U8qLhc7tOeDYeazffL4rbmse9
	 +bBuJHjsFbZnA==
Message-ID: <sashiko-outbox-179000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI: Configure Root Port MPS after scanning its
 hierarchy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Niklas Cassel" <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020122854.1500883-7-cassel@kernel.org>
References: <20261020122854.1500883-5-cassel@kernel.org>
 <20261020122854.1500883-7-cassel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 13:10:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> With the default MPS strategy (PCIE_BUS_DEFAULT), pci_configure_mps()
> only matches each device's Maximum Payload Size (MPS) to its upstream
> bridge.  Root Ports have no upstream bridge, so their MPS stays at
> whatever firmware or the hardware default (128 bytes) left there, and the
> hierarchy below them inherits that value even if the Root Port and all
> devices below it support more.
>=20
> Once the hierarchy below a Root Port has been scanned, and before drivers
> are bound, set the Root Port and every device below it to the largest MPS
> they all support, even if that is more than firmware programmed.  Do this
> from pcie_bus_configure_settings(), which the host bridge, ACPI and
> hotplug paths call after scanning, and from pci_rescan_bus() and
> pci_rescan_bus_bridge_resize(), which don't.
>=20
> If the hierarchy contains a hotplug bridge other than the Root Port,
> [ ... ]
>=20
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Co-developed-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020122854.1500=
883-5-cassel@kernel.org?part=3D2

