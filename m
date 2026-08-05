Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584E3749FD
	for <linux-pci@vger.kernel.org>; Wed,  5 Aug 2026 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948374; cv=none; b=Ky8L1vRx8lDeAt6sDsFBGpx0Q7Evo7LFR00hn/3NKaqGwu0n++flm4sZgDa2mlSFjXQgWnVfmxjsxC8hf5FZqLRdbXnhMzThWf3waA0dnaUhU5GhTM/vE4xroHmibplZTC582TJ5l3iGpsWBABg1Y7F5lbEwOlX2oaxFmFxfg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948374; c=relaxed/simple;
	bh=gEL68mjnWiqmUcoRyhQdbilUsRYelV9MmT9U4J/YaYM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W1D1gGlM+yUpVO5mrSIfsBMQYF68ys2IcTi5+D6Ozujo7fbAe7qO55kBud+OAzd1XZmSk9um0hkkA8k8mz7s4L9+ycO1Qi4Oxy0qiAEDUodJAGI+y/LJCGSEVFmxxKf/5wpV0fUnnMrFWludzzSYZkQAHONmM1EjLzkBDmy/Uyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsHq6Rir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsHq6Rir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500281F00A3A;
	Wed,  5 Aug 2026 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948372;
	bh=gEL68mjnWiqmUcoRyhQdbilUsRYelV9MmT9U4J/YaYM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FsHq6RirXU40VoJTn7yUZpFaiPVBjNnKjqtnTCpW5pH1KfF1LLrP1W4UwAbnJ9PyX
	 c47WDxdXXw+tHgbB3hA28spbpT7Ug2LrCjUjimiNed2QfNWWTxKlICCkAvA2P7o5US
	 vVi2xHlugmDaas9+Bra1hFmZlrP1+hnpgOGQelFXu/0/WQrmoAs+CgCG9JqaeTEzdm
	 iy2aDRXxudzq7DZf5G4jatzJ9E/UT9OMWxJIxedLI9D8lu7XzbA4xwXxIwl70/MiGK
	 PKiPZmJMxVxPxTYPVBJe2JvwE8UJVhpHhRMSMg5yU1xh5wpLmEEwunpCMw1+wq2ejL
	 EbVPUFfc40RPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/16] gpu: nova-core: use projection for PFALCON and
 PFALCON2 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: ojeda@kernel.org, "Danilo Krummrich" <dakr@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260805-typed_register-v2-12-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-12-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:46:11 +0000
Message-Id: <20260805164612.500281F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add fixed size region types `PFalconRegisters` and `PFalcon2Registers` and
> update PFALCON and PFALCON registers to be fixed register on them and not
> relative registers on `NovaRegisters`.
>=20
> Update `Falcon` struct to store projected views when constructing and
> access with `self.pfalcon` and `self.pfalcon2`.
>=20
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D12

