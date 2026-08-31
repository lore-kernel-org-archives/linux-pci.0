Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF046EF78
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190208; cv=none; b=U3i7qYOi4EuCpdwIp+emucZPOGTC9drVG1KdkuG8gQFRdE+JIxFOmwK6Dh6U5DYn+O2x+dl6mMRMgk22gVqdIZNo7qUla4Hypkqjp2HEUOMr3GRQGjTj2uV0h387RBeYXxQeGE/yTAUX5DcHaVt/W+AYsK41izQ4sbq77AsCaek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190208; c=relaxed/simple;
	bh=o5S4N2WG7+ASkXliwSfmU24jgliMMPprx3s8d/iW3xY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UUvSd2f3zaURC6waoJyDPd0I5VSR1FPePrA/bWxyFBRff/jpojQ4Eoxsq2eHBwzwcn9A1rfDftJhErP19v+wTrFOwt2sCQ6R0CUPj3YtuB2ZZDsE9IiFVVYBEIDe6YTjCV5fe2iRp4vIHblgudIPqj3a0m3UxdsGTFt5O6bx2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osm3q/hk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osm3q/hk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095F41F000E9;
	Mon, 31 Aug 2026 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788190207;
	bh=o5S4N2WG7+ASkXliwSfmU24jgliMMPprx3s8d/iW3xY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=osm3q/hk0E57YxcGDhahfchrPGkln/FDU7VAu8xBqapKZJywOkWjxNMPVUDDRz07A
	 mzS0pFTNInKv22HorsayPKNfmrP49rURQA5D07GHkdoYnYTKx1WrD/TSr3fNuH7E/J
	 Mz8kbnGpmh2jolmRyVFOKs/3S0oOBs+WkH1x92zY4EOh9jv6M+WpQFIi8ipbA9bbnj
	 Hrxxc6b5w5pP9qgOHtLEKRTnKlAhAZqgQPb27g0DR9pzNu1hhFoQ3zqswtmzxL6k+i
	 Me++oq56q7nCi4IHjZdrq+4cdGTyFoJBIftWb+MA0hF1yQnp4zI/I3/3Peu8zrVsPQ
	 3jUiuVDHTWXFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] PCI: Wait for device readiness after
 D3hot -> D0uninitialized transition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-304-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-304-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:30:06 +0000
Message-Id: <20260831153007.095F41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Bjorn Helgaas <helgaas@kernel.org>
>=20
> [ Upstream commit 41167a1e98536b4baf0846fd259c8124bd1c4e1b ]
>=20
> For a device that advertises No_Soft_Reset =3D=3D 0, a transition from D3=
hot to
> D0uninitialized is a soft reset, and the resulting internal device state =
is
> undefined.
>=20
> Per PCIe r7.0, sec 2.3.1, a transition from D3hot to D0uninitialized
> mandates a minimum 10 ms delay before accessing the device. Following this
> delay, the device is permitted to respond to initial configuration reques=
ts
> with a Request Retry Status (RRS) completion status if it needs more time
> to initialize.
>=20
> Call pci_dev_wait() after pci_power_up() performs a D3hot->D0uninitialized
> transition to ensure the device is ready to accept config accesses, as is
> done after the similar transition in pci_pm_reset().
>=20
> If the device is already ready, this is essentially a no-op except for one
> additional config read.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Link: https://patch.msgid.link/20260518191220.636213-3-bhelgaas@google.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-304-sashal@kernel.org?part=3D1

