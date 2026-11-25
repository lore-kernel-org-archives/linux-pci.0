Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572194;
	b=05qVOoGNijoNiHagAnU63OuLgW+QQKapRKHsETLfZ671tqJ7BCzm5433Kg/qCt78K4dH
	 QQ6Fm7zNf3/n0AOBIj1L/POmjhEgSPky7sCJAJtmI5oea7tHqGxEfw0BtPS+uiJNJZCRv
	 Uon5m5KHFoiN5q/DBFpc+z8cqLv51oOJrY+izK3rMaGZfL1SfihLlK3GfQuMkxXrDHO4b
	 Pxc7ejbnpFVWNyXTsOffsWe9t33eXhQ4a2pLDKXggnaPqujj6fvZj/VGrcO8GXBPzvyU0
	 r5ifQnau7S8gDYD6FL97eUvckmfqgUjyVPfuvOp5cQo/1jvDr04XtfJkt6eeDG5mNCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572194;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/wqJvCSVgxUotmrOkGob59wCP3oQ6o0wP+DRtiunJ0o=;
	b=Cey/o8YoThxTyYFsXBMG/pifAGhVioM4K+gRRfNucDqb+fKy1lZFPj4m6Xzi6byWSb2e
	 ywm2hdycJif+sLAbN3tIDCws4NvLy8ySCPXRaZvUQT835v6+RTuSzzSXSD759cjCa51CX
	 7R/NCWEa3PshJ1WuS1g0CaWrJBJ6DVPs+z4uNdaeHkl9nJOUPgKa93wjTDKyQ+C2DS6mI
	 9XZijek/VqhUROpo1kK2x1XDBKCJFekg8G45pcpO3krj4LN54YhFTOVNQ42jmIH6hk48c
	 AN9f4EwX5G4i143jAZ8Q/iZrFdgmUq/ByRh5zmRztd8v5uRHD7F4+VwQ3v7IOweGesA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i875ACVm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD2606A31E
	for <linux-pci@vger.kernel.org>; Wed, 25 Nov 2026 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i875ACVm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A051F000C0;
	Wed, 25 Nov 2026 02:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795572194;
	bh=/wqJvCSVgxUotmrOkGob59wCP3oQ6o0wP+DRtiunJ0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i875ACVmQ0B14BMKSfIsES7i2bf2bXG8mcI9rn99mX0MQ4QKEUXY47SpwbMELRfjb
	 85pYcr1euiM9mVR1ZfugorSO5kxFvSXABDaN5heBL67P8/nd+KEfLV5uCBs3jnOhBS
	 EUjFpXvm5WYCxZKjOEUJ8MiL+YATJLNeKdAcUPwME8zzxVKz/peTk1hgPIdmSRI1Sm
	 0cIUhvyTYPMpvrox7w9wLtqjJN7UD4M4WBkMfPxsrHdelqZmEUeARMB/zyYK4Hnt7/
	 fe/bcF3tUiYtOKPsfLALQJfu6I1rBziTRmcWmk+F2SjlsyzxlGH3f3GmOOQ+AuhmKy
	 IQTzjNTugPoeA==
Message-ID: <sashiko-outbox-232387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/AER: Keep ANFE masked on PLDA PCIe-to-PCI bridge
Reply-To: sashiko-reviews@lists.linux.dev
To: "ChunAn Wu" <an.wu@canonical.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261125020013.639193-1-an.wu@canonical.com>
References: <20261125020013.639193-1-an.wu@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:03:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Since commit eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
> Errors"), pci_aer_init() unmasks Advisory Non-Fatal Errors (ANFE) on
> devices with native AER.
>=20
> On a Dell server, a BMC VGA sits behind a PLDA PCIe-to-PCI
> bridge.  When enumeration reads an absent device on the bridge's secondary
> bus, the bridge returns a UR completion and, with ANFE unmasked, also
> signals the error.  Platform firmware reports it as a fatal error even
> though the hardware severity is non-fatal.  The kernel then resets the
> Root Port, the bridge loses its configuration, recovery fails and the VGA
> becomes inaccessible, so the console goes black.  Kernels before v7.3 are
> not affected.
>=20
> Set no_aer_anfe for this bridge with an early fixup, as done for the Apple
> T2 Secure Enclave in commit 7209846a169f ("PCI/AER: Keep ANFE masked on
> Apple T2 Secure Enclave"), so that pci_aer_init() leaves ANFE masked.
>=20
> Fixes: eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125020013.6391=
93-1-an.wu@canonical.com?part=3D1
