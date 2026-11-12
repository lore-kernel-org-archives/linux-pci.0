Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443366;
	b=fEsgj3xLYfUWIlUxo+RvBImGHVswJlpY5Z50bvcASnXDW4vAUC/bPBTPIm3LfuHRRmAu
	 vmaVmSf/BU8VYfIrQj0ScRo7IJiunK4RyEgdp5847rYDGfhw1lmp3fiMzk5u8pwSJ1GsE
	 fXdqbBzBF133Wq3kwLhm5yKGVdD3LJ3P2FfDCFieaK70ZG3artimN8bQrNCeVH1lT8npn
	 Y7E0q1Zfo/anTBDO5YnXrJ+kB1M8qxLBgKKTjZh1E6z+pAhcPNZeoqsvQmZu6OKnMhYJR
	 DkgQT6RWFvAAm+nGDCNxJPRXMbcyQq2D2KNNMj7JVnrkmbee0yEu93/E43HrhKax7HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0dHfdUeU5kkJAnQ1FS8FGfBenR6jk9I/2EW0oqMLXzA=;
	b=W5OkoY/8cMUFG5l+81Ywjl18djHf0GSb6xjA6BjyprKUjigu6Uf52dIkpSoReHKltosm
	 zYSicKJ3Wmh7xRRI04avCYCqIuSFM7Tq1tQX2CP+2o9px2bijN1KgM+7Vx+q9/mRlJQL8
	 r3O7dq5DaTr9rUhnbmhZTT/zCwxB8prI3ItzuATswP4V6nWvXwnSoxC+prgEk6bGBfrNW
	 O5aBJOGq1bnZa2wVDHVABZdhMMoTkyK0I5ITNUaO/faWmurTJYuRTzbdnpRLnqSFMj/RP
	 7/eSU6WVfkCyHF2YljVFYHTp7RlyH2AblF9jSsEspqMHU6eKV7Szjv1inIyZx3EiUpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbCnYHr+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DA606A31C
	for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2026 00:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbCnYHr+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF91F00A05;
	Thu, 12 Nov 2026 00:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443366;
	bh=0dHfdUeU5kkJAnQ1FS8FGfBenR6jk9I/2EW0oqMLXzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbCnYHr+BTJ7psH3NxXRKL9W5f/BxVJ6GD4srTs2qT9mzLoBM7GsQ836IDuu3wt7b
	 w2lD5tVC2YMa7dNKJR6y7JWEGllkodZSQ9FEpqSMU5sILLy1Ylm5PrnWJPnUmlCG07
	 ITn/JIpFBR8KFVZ/W6gPsV7roq4nrI0UdHxr60CG2dpRrafMkNeE8cW1KPBxxjQQQ8
	 pKtRDGbxFMHu3Mn4wa3RS3tgOrt4VJRi6hRU20i7yQw8d4VUdr166weq5dyV4KtGQk
	 ohdmTcg72mTFMIJuHS0xAMvS2kwWm1n9BIaYs3ZRuwPBDiU4ANVjBxUYJvpyRGB0sv
	 G0Y/2dy4nBngw==
Message-ID: <sashiko-outbox-209920@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] tpm: Include <asm/cpu_device_id.h> unconditionally
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111234821.4814-7-pavel.e.popov@intel.com>
References: <20261111234821.4814-1-pavel.e.popov@intel.com>
 <20261111234821.4814-7-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:29:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> <asm/cpu_device_id.h> now has a generic version, so the #ifdef
> CONFIG_X86 around the include is no longer needed.
>=20
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234821.4814=
-1-pavel.e.popov@intel.com?part=3D6

