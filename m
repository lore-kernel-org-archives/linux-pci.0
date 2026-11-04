Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836557;
	b=tZ4xJhZ1lSJxVf3kID9LUuqSDniGIvqSwWvyrD0gJeBk5zXMnzIqNUtV3zJNpud5BAVd
	 8bBMirwIhIkPHn3FJDDCtD5BcfUw3rRLdlDbtK41GtTy9f3wEXcUE1FH39oFHWuOcXaeD
	 Bn5Jb00G9lErgAy3bdmEOFubgbEuErM+2fFKAz2h6EAPEzW8XbGPA47d+Lc8jTV1SJ/rn
	 HInbaxj7WZevonMvQRjcdkv4rqf7EwHkLmnp1OBsXvjtHWJmSUMODiaZSiRs8TYOafqUZ
	 WFHSaCvZ5P4nQ80tmQrhkjbqGq3E+TbTasGLbR59yOHajb1soWh63GbW7+LML3nvaiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836557;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tVDDDiRazdHKaTANYtvUlGSuh8StSGXpPoPoiyNpxFQ=;
	b=imZMvunMOvus4zpvOvaby2DdQD2B/09CppBcJweMKY9cUHnZ+mMqb/n7DbmhjsJQGRjq
	 Tf3FK5hkZiXvncNgB+Ly6nkpv32to+NzFsQUWfqT1Sift6d1WuohOFIVVQKFrgPa2dtT5
	 RCy8o4tqmzBiB/E6KonTHdvP4BI0nGYrNYMaCjoa3Pw/FvGVeEFAgQMkavvrFN2kjeOCa
	 UllToeRCBf53Pw/zR3aowjeBYHxJYgjBBNxfzbsvE0QQxtm6P762TEuZdo+gIovTD3n7G
	 KJdLJ7R5HvCmHqdzWVmzP2l5poT/N3hv8lj+VnBv9L8Uvh8JaPILr8Te0XX4To5sqkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkxddrHL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92736606A32E
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkxddrHL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1018E1F000C1;
	Wed,  4 Nov 2026 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836557;
	bh=tVDDDiRazdHKaTANYtvUlGSuh8StSGXpPoPoiyNpxFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kkxddrHLAv2MWwvBS7VYgleKX9j7TlZIIluon0c9fz0X08N8lV9U8p2wlCzAROqBU
	 HIIIFJjsS63v9nb0b/dbMzeRiPXxN+ussW/CZ7x8cF76UKdJKR5Vbu17JE9DXig8MM
	 gXkCdmr5vIy7CW5lsKceu6OEZaJWDW7p/zvZeOHQBfbvH9gBPyeCZJezLJYHFxdfRK
	 m69tuNhYZnvEM5K6ZUDqzvrJqtUOJSWKeGSCK9BPCPO1vgKAzONItkZJGSx2AO7JfD
	 aoTO7iwg/uzHMobij0k/ZtSZjnK/sxAUWoocyW9TSQDfOdVbny4zuX55WqT77AGLze
	 z8+xxjkc1OpKw==
Message-ID: <sashiko-outbox-198322@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/9] PCI: dw-rockchip: Set broken L1SS resume flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-rockchip-pcie-system-suspend-v8-8-0434b4f373bc@collabora.com>
References: <20261105-rockchip-pcie-system-suspend-v8-0-0434b4f373bc@collabora.com>
 <20261105-rockchip-pcie-system-suspend-v8-8-0434b4f373bc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:55:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> During system suspend, the Rockchip RC driver effectively powers off the
> controller. If the link is in L1SS and the endpoint asserts CLKREQ# to
> exit L1SS, the time required to wake the system and restore the
> PHY/REFCLK may exceed the L1SS exit timing (L10_REFCLK_ON +
> T_COMMONMODE), resulting in Link Down (LDn) and a reset of the endpoint.
> Set broken_l1ss_resume flag to indicate this limitation to the PCIe
> framework. This results in pci_suspend_retains_context() returning false
> and PCIe client can avoid relying on device state being preserved
> during system suspend.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-rockchip-p=
cie-system-suspend-v8-0-0434b4f373bc@collabora.com?part=3D8

