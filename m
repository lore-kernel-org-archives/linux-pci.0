Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258870;
	b=uI1V1yUXnAtI13qvMbtujuQMZ/8RI3Y7YuHEQHrXWGYuwiqtn5Paf/lamjP0l+DovwnA
	 fEJCv0mFKYDUJnvmIxEU2R3H4ww+LUXacgvwJp4U2syCf6u6o1ukBi+IPXsVearRsefFm
	 rfXlJB068vnU52+S14BxunfMFaxWygO63I29nAF+OTICr4u1KiS84m57b6r96NGx/cbQ4
	 qyKYhkDV8IKWCu3Ke8bneRKorWxycssWQ8tb53QPhwwaQ0tWwjRMJW7A7VE7MltZIqOyE
	 u85XqmpdJHkOFjF/z2oFQI8REAZCgjqNxoErmaZNUUzsBBSdR/EGpsWVah9ChCAToLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258870;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vAyZPmhHAcJ1en2D6VcSWvklw7FVzSD0sf8hXP67i/Q=;
	b=P7BinVniFa2wpDEy2HBbZ9vtIqcvVy5mHjPEynTZTZM3I5ewptnAXVWAJI+Xz19K0vwR
	 hO1H4/IBkVFNcl6cZ8YoyWyFKW1Oee8AMviKgW25HgM5yNBYITN4n1GrtEiRoHeHwiT5+
	 72GO2BSzO3kkyh2WhQLoSQV4XQm86MJ80M/z6Xnga1zFHQftP9Dk2fViVmMYM4VCmOwKT
	 R6UQm3t0AoCMrN+9pYQN3ojYnwMOnJ/uddKoMDQZaSxDZ2UV5fG8DeGMrBvugIQeD9AAU
	 E+SzzYAqqjiP1lq9EL9eCHbA6lbj/RhFulVg0EYPX/lk/YfyCd9RqFP1v210Zxh6A3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFecXI2e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFD7606A326
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFecXI2e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276E01F008A1;
	Mon,  9 Nov 2026 21:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258870;
	bh=vAyZPmhHAcJ1en2D6VcSWvklw7FVzSD0sf8hXP67i/Q=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=SFecXI2efwXGlg4HTSTjqwPmeoUxPzUugDoYEp07Yx0q8i6tneXp5T2FvSJQV++xw
	 +EQa8IZ4J2KObJB8Q6/SL8ebGyNPz/W5hAOkX0XZmqhCuusnIqkBD0PVFsO+K+EJAn
	 RPwP8IAbsZEhq5ccnEmA0/7MYySIimrfaaSJMVsg+SAc1xFxazpc28RhMAbLSXU//r
	 ecFmHyQRPF/TbOTRiDex1vLVungkXoa7Eya7/FYTwRX0GWo4/QSsX45x1ybMo0uG/7
	 g6SK9YwFX2wctYlG56RrnE81N5jx+5lm6h9RvknZT0cYQGzDyhyBb0yCEPB+Dg6wXF
	 2Xb8CQw5COJrQ==
Message-ID: <sashiko-outbox-205651@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] PCI: Move CardBus resource names to
 setup-cardbus.c
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-12-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-12-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:14:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_resource_name() contains a table of resource names specific to
> CardBus bridges. Move the CardBus-specific part into
> pci_cardbus_resource_name() in setup-cardbus.c to make the core code
> cleaner.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D11

