Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209A1A08AF
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783390819; cv=none; b=o1188JhZE/DbitA3Z7WbovX0x5PKc7xTQgIL/+qMkQRVZ6GwOZWXK3DeHtq/yPeg5cz/Wqp58Lbo79rT73ZFlWroG6BiZf+IYLtXLFR5oo/Rb9dvpxIlZac7H1sChssI3BD7nhN5IiGdy0kRv49t5tuH/eUsIcfJ5J1a0Aw6b8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783390819; c=relaxed/simple;
	bh=nnk0Xs7ZqlsmZXYnbP46sSTwylofwiYyQuGhLUi9cIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YdA1B+lp0p17eHLxI7XnCnu3rFY3GJsM2cgZbULmfNsOy/kL9DbkRw9mzWYFrkPNmapr32W0xHm/famQuq6ajwBTOCB7rsj7y9C/XA9eVZ0NPbojzeYAI1u10wxfvwGPafLweUl3xdsXGgiovH/ovqisxVCEHQj/6u5NRpqcL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5mTJo/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5mTJo/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7271F000E9;
	Tue,  7 Jul 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783390818;
	bh=c5jXpoKrxiY/JkO6vzWFEYR4RnQdo1/8daD+ZrwmH20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F5mTJo/AwbBfrlunR7Cn1Nzu+dDOgWeN1SeqKqsdQrizcLnyk3yMQciCKvyDyPNxi
	 sRLaPTpm5h85T9X27bKT2GrZ/Jo3NAiOs8/xbn+zvDYPKLvKi+LdIoBuHlDD0C/4Ae
	 yDVXuEe+lSbjE4K91ptLcNHO+LPR6bKbsdJ67Md93WbJZPi8S/Pd2J1bsGexRtiKrM
	 YfJaqRPzdO2aSPt5tDjrTrx+WVdHZjNgrXgqohUOn3WhRcezZ8LPSv/D8xOqZXn1Kx
	 Eo3XZtauF3PWUS9tSFuYGXSBIyB1qWlAjHzxQ6bM5i+/u66K1tbr1N0Gyx1sGBjqDH
	 VWNPjEPD926/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: Disable ASPM L0s for Realtek RTS525A
Reply-To: sashiko-reviews@lists.linux.dev
To: "Max Lee" <max.lee@canonical.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260707021527.639611-1-max.lee@canonical.com>
References: <20260610024723.188514-1-max.lee@canonical.com>
 <20260707021527.639611-1-max.lee@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 02:20:17 +0000
Message-Id: <20260707022018.1C7271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Realtek RTS525A PCIe card reader reports an AER Correctable Replay
> Timer Timeout storm when ASPM L0s is enabled on its link.  On an affected
> HP ZBook Power 16 inch G11, the Root Port received tens of millions of
> AER interrupts from the RTS525A even when the rtsx_pci driver was
> blacklisted and the endpoint was not enabled by a driver.
>=20
> For example:
>=20
>   pcieport 0000:00:1c.6: AER: Multiple Correctable error message received=
 from 0000:58:00.0
>   rtsx_pci 0000:58:00.0: PCIe Bus Error: severity=3DCorrectable, type=3DD=
ata Link Layer, (Transmitter ID)
>   rtsx_pci 0000:58:00.0:   device [10ec:525a] error status/mask=3D0000100=
0/00006000
>   rtsx_pci 0000:58:00.0:    [12] Timeout
>   pcieport 0000:00:1c.6: AER: Correctable error message received from 000=
0:58:00.0
>=20
> Testing with OS-native AER control showed that disabling only L0s on the
> RTS525A link stops new AER interrupt and counter growth while leaving L1
> enabled.  Disabling L1, L1 substates, or Clock PM alone did not stop the
> storm.
>=20
> Prevent the broken L0s configuration by removing L0s from the RTS525A
> advertised ASPM capability.  This avoids enabling the non-working ASPM
> state instead of masking the resulting AER Replay Timer Timeout reports.
>=20
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Lee <max.lee@canonical.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707021527.6396=
11-1-max.lee@canonical.com?part=3D1

