Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018844;
	b=yVSpLcMHEmsXjjP9W/xf3gwsiwUtvUzrIu83Z/T01X/vUMJ41rgbg9iuxr42LCcbJTep
	 Lv/JQDuS3brQ6h2ThKVa8A8MHnGGY1u76ElYcrJbN3HA8gNGFQpRfPFtIIt12O4j8On2C
	 E8W1dzOffrUO+MfMGuGoaI5/S9aSOq5jnaR9NNUi1qdMS9t/lJy60BCNUj/sExsEQ0OnX
	 qup+LZGL2d5qb5VLew+lBna9TKnk/FtKFyii/dpTsw0zsyyJA//zhb7NU53AlmeRR5H77
	 pDoCIL+3pF4BIVTAv5h3M8u/F/eh7sNXcphjQiLorzdtWT6qq0v86Q6zneTqcSc4QKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nCzzchpgAJy+qQDTdAsztKxL099Cv8ajUcS5uRqfQRg=;
	b=t4x1zq8z7/XKDWrg0myZB3NShiFu1uh0DzhWsCY8uEFjLJXivR2JojuVBtca72yEEu9S
	 ++KNXxSj4TCsV0+vYYP2ETmRfLiI4KNe6yaY84DsYfKD+d89XgF/IHPnK728agtrN5R28
	 7zDYW6WOcBHJbgJXBcuGIO3CWj9DgGypzFRXuZeSjLyI0yehPIHYxAKijqdWDMLhZTaPm
	 P8HL2CUVpbsSb/XPjloTO1Sl7QcuUPl/uBgrW1sZjDnkhI2IAPMZ4DUIfXNLuZFLzqIG1
	 BANZdJjrRAJVUlggbY8fNL2jtYP0K5Sd91ZsN0E5DX4TQEU71AxWtvRjhS7LH8HRx8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQrG8uWi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78810606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WQrG8uWi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277011F000C4;
	Wed, 18 Nov 2026 16:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795018844;
	bh=nCzzchpgAJy+qQDTdAsztKxL099Cv8ajUcS5uRqfQRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WQrG8uWiqbgZb6JawzwseF3CF3cNQIZJFr2nCmggfAumaiLb7H3/0Jsng+frwNfrf
	 E1i0nQtxSfyKXKdMhGZDGHhgafBdW0CG32ZP0HOSH/gXFijc1Ccmp6dFgeG4QuZb5i
	 oWAfXvRWP1d+bCDPOskQs9L99TNav6TG05GyPi2FBVV4H87uKzskys0LIS2902ue7V
	 /S5j3AYS/MLRc/XBg4TSA+3fACm1B0EpCUyLtrAn9pZAeqI2lSUVPAu33ObR53EU/8
	 bHWSrc/mjdwFnfliZYj+nM6iqWbK3ykuq43DSrkvM4wgXL/67JIkSwDyeEFNb5NrHr
	 /vVVcERYi0s4w==
Message-ID: <sashiko-outbox-221462@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] x86/quirks: Cast PCI_D0 to u16 in apple_airport_reset()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SGFiaWwgRXJlbiBUw7xya2Vy?= <habilerenturker@hotmail.com>
Cc: =?utf-8?b?bGludXgtcGNpQHZnZXIua2VybmVsLm9yZw==?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261118161559.63617-1-habilerenturker@hotmail.com>
References: <20261118161559.63617-1-habilerenturker@hotmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:20:43 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI_D0 is defined as pci_power_t, whereas pmcsr & PCI_PM_CTRL_STATE_MASK
> evaluates to a u16 integer.
>=20
> This causes Sparse (make C=3D1) to report:
>         warning: restricted pci_power_t degrades to integer
>=20
> Add (__force u16) casts on PCI_D0 to explicitly eliminate warnings.
>=20
> Signed-off-by: Habil Eren T=C3=BCrker <habilerenturker@hotmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118161559.6361=
7-1-habilerenturker@hotmail.com?part=3D1

