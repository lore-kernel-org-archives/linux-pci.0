Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346388;
	b=qvtTOsGr94/RNFBcdwJ3B9D3cMvbsXw8VIkwyCesEDJN0X/VJn065n9ZqgYUgw3L4PKO
	 WeuMpvPykFEiXrL+57OEJQxzn9ZskrIGEoNVwsR0R1W5/HdiGv7ZeVU5fFIZ0jK9/ljEA
	 uQ72piM6he9HQxdpVjj9ILoPkV3HNNquIvnMDJ4bPeGYVpIJBnM5zi84VBk6KfldCegO0
	 6spZeCltRNlM5KqSnSFLKYEFGQu94P0hQjxFnl3d8NMcnp46VKL5G/LfgtT7BhVPlwKoA
	 TCAhKYNBi1g+mwYTN5LFBRhkUEEOE6vGSIgQ7s7kUr2S8uQQkcAMVhpCH5jLs2OsH3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346388;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6Tso9LucsI7B+YNUO/MQhpbO0rviXNPtqkB5W/dZd84=;
	b=RVoOsYFFRo50INaAE0jzcg9525rhZaJcUHZfLMXToxFM8DAuCzKhYQ+McPSLTqMmFE36
	 QfWQzmFG0gRrJAwRQXZ8q0XUSyOOII6BbCg+2+r2/66pBUtlMTZavbJjDy7/h/1HBnow1
	 V+pN4iOLdXJF36pLUbncWFO1JusawL9+BpqJe6PcxhujpK5yitt0f6R9JQnSTHUFC3AOJ
	 5s0b7VLXQ8zX2SBgi8kZ92JelYjFAQpJbnOqTfLZjAU2HVU0SNLc1Gtfml8uN7M1JeZdr
	 dsPHpARyYz1GvaDkt/DroIccDEtXvda8NXaxGPwNOjkcO8HiTyLxFe3CuK+xEsNElwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTd8PXSJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68092606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTd8PXSJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B911F008A1;
	Tue, 10 Nov 2026 21:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346387;
	bh=6Tso9LucsI7B+YNUO/MQhpbO0rviXNPtqkB5W/dZd84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kTd8PXSJWNyakB/sS8LW9oxOfaLhnDrqRROdN143AUun28+yEOa8yqrtxoeIIZJso
	 wT+iXnml4dA+fl3QSFbyEylPpDM8tqTsvu1p/WSU0xn3s13tFMDfNjJcnDit36PS2L
	 GHbV55E5bpy72vXuROp5X0fLIjilYycQrQWDKmUMMCfPNtqxos0vU9CAeqVVAFQxCo
	 lQRSTy+LnKCmMcB98TCUADYSBXKQnTsJWcQdnsJmJBVdM5ToZRtcHkyD6YbOIw1sbG
	 HaNWsZzyLVTQMY/9lQKkWuO75BP9OudYwGnt8s2ggkAcft1ukp4cZJyr/7SB7YOYLc
	 OjUnxS7Ai5w3g==
Message-ID: <sashiko-outbox-207771@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] pci: Add broken-GPE quirk for some Lenovo Legions
 with Nvidia GPUs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261110-broken-gpe-legion-v4-1-3668ce0c2efd@gmail.com>
References: <20261110-broken-gpe-legion-v4-1-3668ce0c2efd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 21:33:07 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lyude Paul <lyude@redhat.com>
>=20
> On certain Lenovo Legion devices (including the 16APH8, 16AHP9, and
> 15AHP9), the firmware appears to enjoy firing a GPE on the parent PCIe
> port of the nvidia GPU very shortly after the GPU enters D3Cold. This mea=
ns
> that every time the GPU is runtime suspended, ACPI firmware immediately
> wakes up its parent PCIe port, which then wakes up the GPU. Once it falls
> asleep again, the cycle repeats.
>=20
> Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
> nova as well, and it even seems possible for this to happen without any
> driver loaded.
>=20
> This seems to simply be a bug. Luckily, there is nothing that we actually
> need ACPI wakeup events for on the GPU. Events such as display connector
> hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
> affected by this quirk.
>=20
> Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Link: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
> Co-developed-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-broken-gpe=
-legion-v4-1-3668ce0c2efd@gmail.com?part=3D1

