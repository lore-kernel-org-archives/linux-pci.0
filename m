Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794284934;
	b=gnbv0Rqfkf3/MoAf3c998hF79Ih2NyrTxpnBI2uTZag7M0SSoPK2Qn/WPQ453U9r4rMY
	 LWOnoNuviSjhYDVmP2hI9I0vR4kGNX8+UnkWVjXJ9pIeMFi/2XagH9ZP5w9HkhzN82Fqv
	 eikF+tNhmEbtMO8l0DU79oB8dnredNxykoYd7i9NtEqLlkYXWS1z5pgYX0Yy5O5w29Hbq
	 dA3K/9bCEPW3L+WGrU0jquq/08181JZi52tCxsHJbSaz2CgYI9eV6bPAx0dtxUIQ8Ftjr
	 yfrE+X3c1pci7iMu38kzl+bSVVmyCHzF9QVXJr5ryve5eYosAkB7cyFfgH549aBzeqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794284934;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2r8PWUotBUTDzwd0KfIKIugcWMOiPDYZEr3wrfJLcSI=;
	b=YJbcV/iAvl6TDhjAvx34ENXaeUFoKQfPwdPPDNxS+pC9vrrRylKp24xBehKfVsNmP4rN
	 sE8E1xuYsF8Lo5ehGxLZ/xBAYZLcytaAyZ1oF1aCr9EZRpm7V6pt2rIhKHJF6bI7PvFCS
	 6H0qWnRRb/usLRRsR3n7gUOF1HP8fBUt2YNtw0KSrLQ863Kzn71lZwMoRrMu72H9WpO3e
	 wkMqiymeqimUXYz6nhfJ4pUuSuGVAuQ9gITYtGzsKXiEgJ47w42FIWPx1WFTVgXehR89v
	 s9+tFMKQI5ATPziWUGLGEtU6qUhDXasmavm8w+5AvIWBtuN59hKUllSbp+U4PitlJLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzO7xMPR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAEE606A31C
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzO7xMPR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC1E1F0089F;
	Tue, 10 Nov 2026 04:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794284933;
	bh=2r8PWUotBUTDzwd0KfIKIugcWMOiPDYZEr3wrfJLcSI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PzO7xMPR5gz5VzllYYwI+qWrI9HteUpkhtHJV6K3h7anHAwD3jqT5meAfYc94dcih
	 78mkLfkO4nwZf2Phg6+NERfgboTdk2lctcewQzHbVMXB3pPJf1crp6W6OeXdjhNFT8
	 B6TD0iB6ZWacbRQCmrxbNSHstMPJFb3HkzQAf1BEoz+KY3tfe5k+uM+72/eH3gcCSR
	 mSnrl1rpnuKGEBQHN7ZcXAttMT5pGh9u0yk7P0dFXzNgl5rGCsahIMaab/mEMTuppH
	 MILWGlriWwQvKvjX7BtvmCUQWJF2Ai9KZydoa6g+y5HQ+6aQCyPJ0pyTdcGOUIGNen
	 gl75l1BioROYg==
Message-ID: <sashiko-outbox-206202@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/25] PCI/TSM: Rename pf0 to host
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-11-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-11-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:28:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and function
> names from pf0 to host) as part of converting pci_tsm_host
> to be any device that knows how to speak any of CMA, IDE, or
> TDISP.
>=20
> This commit just renames the functions and provides no functional
> change. That will happen in the next commit.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D10

