Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912802;
	b=vb5SO/hg8+Z8MhGl2mh1Frn1riJ/9HBrsNbf5aLcLPJKkLt3BiD/7P+9G8kHU8iCm4Pw
	 lK4vlIOauwqDcEcHlWxjeuStg6RlkDjTO+4R9+DWFw2bIaoLshzVsMdSvbe196ESn2yEL
	 RRsWVoNp0zz9wY5oPccHTQL89oYmyanpIUt7KiK9YNj3j8vYQkxmGi0nJyP+XEbgrKn02
	 uy7nV6mJKxmfP37B26yKjNbR7h9TEM3AWilBI3cDe9GvU1GhAlKVEaUCWS9t8ancdUsKI
	 MVEviO1EqIa5fX4UlpCU5HQs85guP09/UeEb+O183CsPls8yw+CUQiBrme3psEH9fOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912802;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VhdXceebTUXX5YAMdtzPNGIW4juB+WNS8/aLK7SSixI=;
	b=K8oY1Yut3cquvElr+SX0w9DB9Gdzdyd1h/XS9QtztKv2ZYFCLrMRPkAosYuVtJH4/Vtd
	 Nf1hEmZsHbs+vFn+4F1bVgdCu2KKyH3Fz4x1NhX3R7JGZgJKnx7KHgA8adfeAux8cUAs4
	 MR2Uj03q/lz4rgicdtaO1J6N25F+PFQAvbPL629n1H2SU1Z2dJFq+QT+iw8OtapD5zbUK
	 mO0dS+wTzs74pDwli+9iZkNf1CGl+pOUnjfSqM4tVA5p5Mr2jNwkOCS6kj9GPpUPV01bi
	 8aPcXLIftgY8kifgo1Fw/OhI88Wg7EQFnWqyetK6ZXMBm9WAvo1hy5SggFO28gUZZ5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bi3SU5lq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3191A606A326
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bi3SU5lq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ED61F0089F;
	Thu,  5 Nov 2026 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912802;
	bh=VhdXceebTUXX5YAMdtzPNGIW4juB+WNS8/aLK7SSixI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bi3SU5lqYbpenW6FugZ7UiWoH7OkUJLnCegoVxcEwAOhIcYMCi21cVwOiC45Coe1m
	 ek5R6Xg4y4TRVcLuNvSdvvd84SB61GU5iGedOw5ZJPbNreHJ5DuneCWCjAH95K8Q3R
	 zuNDTEuaHL4YplVBKie9A+vt2eD4XHSuncDt5FrdJVLXvrXTDlM33Ijw1RipjKrL40
	 +MgoCDyZaEBlWzXIPbS3B6fwtJ0m+zyUiEq79boCtUdCjQSCTR78NCnwMY8XqXyAnH
	 FO+tLOViB25+sTp8s9P18XK88DkSozN73NeCh5zE5CMWtX8yaw2qaD2bYVmwa5eD/k
	 kUcsgScRP2PSA==
Message-ID: <sashiko-outbox-200186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add d3cold delay quirk for NVIDIA LR10 NVSwitch
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jennifer Chan" <jenniferchan@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105201010.2297078-1-jenniferchan@meta.com>
References: <20261105201010.2297078-1-jenniferchan@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:06:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On a Supermicro HGX A100 system (X12DGO-6), each of the six LR10
> NVSwitches (10de:1af1) sits alone behind a PLX PEX 8725 (10b5:8725)
> downstream port.  "nvidia-smi -r" resets all GPUs: NVML unbinds the
> switches from the nvidia-nvswitch driver, resets each one through sysfs
> (reset_method "bus", a Secondary Bus Reset of its port) and binds them
> again.  The PCI core waits 100 ms after the link comes back, the switch
> answers config reads and the reset completes.  When nvidia-nvswitch then
> probes the switches, one fails in pci_enable_device() with
>=20
>   Unable to change power state from D3cold to D0, device inaccessible
>=20
> four others fail to initialize with -EIO, and the NVSwitch fabric does
> not come back.
>=20
> The same systems recover every time on a kernel that sleeps 1 s after
> [ ... ]
> up the hierarchy keep the default delay.
>=20
> Fixes: ac91e6980563 ("PCI: Unify delay handling for reset and resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jennifer Chan <jenniferchan@meta.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105201010.2297=
078-1-jenniferchan@meta.com?part=3D1

