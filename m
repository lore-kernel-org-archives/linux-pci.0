Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8FE320CD3;
	Tue, 23 Jun 2026 05:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782190976; cv=none; b=C3osMsyfDOBRPnjY6XgFr0k/MAlx46ndp6RssY0T2+pXiBV6gINt4+9hxHJIke4ggqVmJKKC1WlkC2WKCr02B8TzPq0azGx2b32xfQkOHwf9MSjdsZRLUxK/v0WeLdUaF0O+y3Xl25tj3pr52ogHD9rafR4M0DSq1snT3rq1P58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782190976; c=relaxed/simple;
	bh=0sDLqc9vY8lXdqCckzROIBXY201g9foe/d4E+9MJ/kU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PCMgQj8C7wY849syKG/lJVRfNNfE2fmbNwddzOM5npsRBIzrSTUadLLZ7fPDWGi3wqubyuJ5fBHg44j2/qZW+fvV0sDf6YkwvUjD0PpM9cZxdkhYjvGY29Z63oURYlsep5CF24HgOtOmvSnYwJllEz5dHfB9lSE0CsCsod/1YNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzaHRyvK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzaHRyvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E10C1F000E9;
	Tue, 23 Jun 2026 05:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782190974;
	bh=9ofmpTq8rckY71biN9+MwQN2jxEmUYZXW3Q3DIrZfRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RzaHRyvKlu4Vb81n18yBg+zRITO5lcNjF7Cx1B/om4Hhemu8ZwYvlTMg52emsPNDG
	 8sTaAuOrTbUSiyWcd+It/ctMtJR3ASwlOiAMuspzUNddqAKffCHTrS8MCaaJ8Wff8m
	 a06wy+4uGaCrXhmnDh/i5zAjWutK+gxH5MMu7ky4t2KYQgyCMYepjguPgYrH/kSuHD
	 hymZC5q+LML7I+ScOl7hS0tQ6PvOcohDLiQCEcduf6u+hetNuEQNiqLsW1Wx7juhra
	 AYJjE1hMpsefXI6vULXepip9azhrwUNiZlbGzskOQvCVgNzlxcr3O2CZHCSHhFDqHp
	 pKXwODxOb1ovg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/21] X.509: Move certificate length retrieval into
 new helper
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: ojeda@kernel.org, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623045406.2589547-7-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-7-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:02:54 +0000
Message-Id: <20260623050254.9E10C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lukas Wunner <lukas@wunner.de>
>=20
> The upcoming in-kernel SPDM library (Security Protocol and Data Model,
> https://www.dmtf.org/dsp/DSP0274) needs to retrieve the length from
> ASN.1 DER-encoded X.509 certificates.
>=20
> Such code already exists in x509_load_certificate_list(), so move it
> into a new helper for reuse by SPDM.
>=20
> Export the helper so that SPDM can be tristate.  (Some upcoming users of
> the SPDM libray may be modular, such as SCSI and ATA.)
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D6

