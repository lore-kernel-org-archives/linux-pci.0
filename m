Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5030E85D;
	Mon, 28 Sep 2026 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559413; cv=none; b=uL96lbX7FC/Q7sPsOBmLRUqlUKT9py1HPLd6Cef6nbW2OzC05C9A8TIsNwQHsz5aNQfbxxfLtEj/cJFMfbRrHMSmwQmTDy2t4qLlQswdgGUF8ZvWCEunvmECev4V9reFg1ztNDh6MWkC5+trsDS6HmG2GiT5ytE7UxffxYPlgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559413; c=relaxed/simple;
	bh=3CZT6FvHFcjIfbfMsSd9o9bbjfEeV/SGsvgORzyeau8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m5uDaKNQEoRzsmbhhSTv3SGqFgwQOiWdnOpqKXWAiBqlDfIOe0WsX072vPqDsRCzx6tZ6igyRbGsbcSScOBcKtBiciO345nNl0OLxjKV8nO+JX5oNwHAH14WJQTKOQgt3AfqEvfHjYEhNWmLh6dj9qLMACnHzZQloN7Qbofy5YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFQK/wvA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFQK/wvA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC7F1F00893;
	Mon, 28 Sep 2026 01:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559412;
	bh=gnSbMVqPuBSVtxtHkcwpAgbyvvNi44PWZc6kccp/lNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oFQK/wvACWEDpi1pQYndgivdPauJ7xknQAOGXhBJQAPQIYmBtSpBJABr+fxZyvfLI
	 4H5fLccqLf3jqt1b2lwd5oNX3pVsuGPZMcP9XMKaSkNnSWEDyJNYGK9twLueyUUT6d
	 dpO5hUa/7TbEEO+JAkNYC/vPEK35rp7/ksg8ibOoY/0YJ5CTKDJT86QklMl//ie4Xn
	 xRg7hFpPjTn9YkJLXgFQthlQJcbjVlfEDpuTYFOJ8vgawUSF0S3sfIv+gxeOtxO4RA
	 /xd+fPs70ffJnO2AcIxgn25wuhJh8r3JXrOgRbEd3+UaPEeEvJBrPsph7NhKgD2nBB
	 wFivt3TkAElMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/22] X.509: Move certificate length retrieval into
 new helper
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260928011123.450800-8-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-8-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:36:51 +0000
Message-Id: <20260928013651.EDC7F1F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D7

