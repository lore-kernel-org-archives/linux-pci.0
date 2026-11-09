Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259048;
	b=onMX+L9ePy3dZNMhtMzuMWmqBMgBBBXpKLfrepuifa7ybmgmrtrKjokG2pyOPwMzooiY
	 6Fatg+9dfaxRk/r2hPy2OR1wbmuDTMWx2PsXGVUaOYLz3C9YkArNWu5aeb0RzuHDiVI5R
	 RLZgqvLyXWR3JBt06YYA5Asb4K739yZrtfK/8T4aygTHMl6nw8r3Kcrjtw+dAO1KeQuXl
	 fNWsNHEX1xmEm4K0EXJYxBAPujhETkPoA4ajbn5KilhTJz3TQ9cEG50CFgQR7iXahpcht
	 dwgcI+N8BKKM613HqMG/HGeqKJ7FbSH8pV8V+lIBnptFsvUPE/zmn5H1s4T0y71lQ9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259048;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WJbla5Uc1Eegm9/kP/2qvy8ovU/aSS/PYflYf9uwp88=;
	b=j5z6T0c5Uc1YbFWa1NCy1RmamYDjBI3L0Wq1Fo2NbwEO5UCptwz7RXQDhrCPsVzD5xlp
	 a4DuIRe1W1wF4INZowAEyKCELFg5LaLDVH+JwSIvre0WpB76nXafRSiZ3WQVdHJqb3HzW
	 Y5/Cpd57WIb6cDPFzidCb3SMlmKIZvg7swu2fp9W1jJF/CFVysuZniOrYFUVdbNx5KV/d
	 7Rm+BHE77zmdLtqman6rxgMcyRnFzOlolX81CSao76vFrCAryBR9u9fdUPJUuRf94T8MO
	 EyI7grexNUY8PlF0jOBSWejVZTgA6uDrPFrmpIUbGNsmRJrMJ2v7BtcZD8zDwv9yRqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLi8ZrfI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07083606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLi8ZrfI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937E91F0089F;
	Mon,  9 Nov 2026 21:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259047;
	bh=WJbla5Uc1Eegm9/kP/2qvy8ovU/aSS/PYflYf9uwp88=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=MLi8ZrfIb5RFmCI9Xodwx5/zXUQmanjwq/VN30sBrCtiNSJs365b9eVP8sV4kXzn9
	 sVRZcgDE3A1QHEvXToFt28VqgBVZL76nDJ6c88jru5oDYhNcOU1zD5nOXVzSQfPF0+
	 FAD7XKu4mGzuwTKjQRVqcXHDl5S6TjvC6sagEOIhYDjEZJT+VmQe3/3b0m9BoCDl/S
	 i/8kTmwzGoy173cHDS653LyscZpzMfIDw7kpJBVCdy9dzqgBo67ojhwTNwCUKyoLBh
	 NGkQ60uSHDw2GuuajbHvFmFQUL2VJYxDM06DcQjauv2CY9V30C6Se2+EeGH27ld5xj
	 hxsuhQeODcmow==
Message-ID: <sashiko-outbox-205658@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 10/11] PCI: Move Ricoh RL5C476 MMC quirk to
 setup-cardbus.c
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-11-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-11-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:17:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> ricoh_mmc_fixup_rl5c476() disables the proprietary MMC controller of the
> Ricoh RL5C476 through Function 0 of the chip, which is a CardBus bridge.
> When CONFIG_CARDBUS is not set, CardBus bridges are ignored and, as
> Function 0 is then missing, pci_scan_slot() does not enumerate the other
> Functions of the chip either. The quirk has nothing to do in that case.
>=20
> Move the quirk to setup-cardbus.c so it is only built with CARDBUS.
> CARDBUS defaults to y when CONFIG_PCCARD is enabled, so existing configs
> for systems with these chips should mostly keep the quirk.
>=20
> CONFIG_MMC_RICOH_MMC is an option of the SDHCI PCI card reader driver
> (CONFIG_MMC_SDHCI_PCI), which drives the SD controller of both the
> RL5C476 and the R5C832 family. On the R5C832 family, the MMC controller
> is disabled through the FireWire Function, which does not need CardBus.
> Thus, do not make MMC_RICOH_MMC depend on CARDBUS.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D10

