Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925997;
	b=kird/f9h03OoD4PWYY3pMattlk/qIrR3l93v2Lj2u5Bs958eyDlxAF4AI5LoreKd3+gK
	 WVi7si+roJ+FWwYGxPyI1cfhyXOkbEnxeUH9CRUFDXpTUwTKExFsjdYPGfXk5IhcnlgfC
	 8lI+DUNqhByoGnI7HkUV1VatLy9jRil/15La3yh3ISbl4Q95ZDgE4piUqqIVcuQ3MBrP2
	 A6IcIC3/8nD9Y6YedQhlsV6e1dT+FIfQuI0qQr73abqFabeLfCTfxfbjw6prMHTxFct+t
	 12uqhQ4q3ThoLILWdtHvX9gofWL4utJhqdO87UrNVNbW9J3iUCg1cY4kIj7A8yfwS/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yo1nO+JMO3G1mOfxk7MfkH4t/+xxCi+T86iGKQ9GLvk=;
	b=Cenh0N7tZaYs61fvjMfd+M4MUBEk4lMA5bkihCP/sNNPLRs5ToC9UrXiXUoCkt7eRMT6
	 3QglnNYY/ymB2gDKGg6LSOZ2PnwlLwDeS3vOpz+pdvDUIxDJ23Wa3BQ+I9MulY4RBQVhl
	 ymz+8tfZb1f6Zz2Jwez80HXtTkg+DMmKGxlXVm3qHmb+GKtVj6N/TPlkpgsLVgDRwsPTS
	 bAxUO3Cnju9HLwSnjRV20tgUUdb8UfLHGaMfWWagq8YXuZatu1HqMlJkSKg4X601P4HJV
	 m3JUKng78QEOXFZ+ptcqNhNVHrNR8e/+nwSyLWqpVoJ25k6PfzdayAYiivM5ou4+eCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H44+BgXj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB2606A31B
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H44+BgXj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2FE1F0089F;
	Fri,  6 Nov 2026 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925996;
	bh=Yo1nO+JMO3G1mOfxk7MfkH4t/+xxCi+T86iGKQ9GLvk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H44+BgXjaiRE0gs18ue9SFbYJeB30Mt9Ytp1A6UU+WHDWv6OvfWk8Ezs1Bz3ai9re
	 l0QMToEug8kcB0MaZcuQrGd4VGNuYVNHwgXupA3CW1nGG6NMF/+EH+/JalmEr+nuu5
	 lQncrEmenVi0w02Ah9F9fznKwx4kW670GFzwzAgW6Gnbz301OyzT0NDT6L3fv3B2U2
	 reHXxkcUYUo2sOCjTkQtjuKPlUr78Q5CQs4yjY+C01UoiMHs8YcpCUU6jBja1BUc+q
	 0fnUs397iGaWvABO/zryoLYGcExeq0LCEhoMfmsUgaB9eh3ibcJc19uZbLyMTvCCla
	 XQf3jX11nYyMw==
Message-ID: <sashiko-outbox-200454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2] x86/early-quirks: Scan all functions in
 early_pci_scan_bus()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thorsten Blum" <blum@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106004343.457087-2-blum@kernel.org>
References: <20261106004343.457087-2-blum@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:46:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> early_pci_scan_bus() stops scanning a PCI slot when check_dev_quirk()
> returns nonzero, which avoids probing functions 1-7 on single-function
> devices, but also stops scanning when a function is absent on a
> multifunction device.
>=20
> This can skip early quirks on multifunction devices with holes in their
> function numbering.
>=20
> On iMac13,1 and iMac13,2, the BCM4331 AirPort card is behind root port
> 00:1c.3, also documented by the model list in commit abb2bafd295f
> ("x86/quirks: Add early quirk to reset Apple AirPort card").
>=20
> Public lspci output for 2012 iMacs [1][2] shows that 00:1c.0, 00:1c.2,
> 00:1c.3 and 00:1c.4 are present, but 00:1c.1 is missing. The old code
> stops at 00:1c.1 and never reaches 00:1c.3, so the AirPort reset quirk
> is silently skipped on these machines.
>=20
> Check function 0 first, and if it indicates a multifunction device, scan
> functions 1-7 independently so that absent functions do not cause later
> ones to be skipped.
>=20
> Fixes: 15650a2f644a ("x86/PCI: fixup early quirk probing")
> Cc: stable@vger.kernel.org
> Link: https://forum.libreelec.tv/thread/26799-wifi-not-detected-on-2012-i=
mac-in-11-0/ [1]
> Link: https://zoringroup.com/forum/5/7170/ [2]
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Acked-by: H. Peter Anvin (Rosaic) <hpa@zytor.com>
> Tested-by: Thorsten Blum <blum@kernel.org> # on an iMac13,1
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106004343.4570=
87-2-blum@kernel.org?part=3D1

