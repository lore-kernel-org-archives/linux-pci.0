Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9101F3B8A
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786677079; cv=none; b=eKd8n9ZMSJs0fo0lfiTWBwDwOngLPYiUpGF3vhfBJyDkDD0fcBqfflJhX4UorOx1m59Zf33BGpad3PPLkU4iG7HGGcYJx1TC3mD3h+8vYUlahz3DfUnFZoNczWGOErVnkH5EszMfCZq8yfqAKjRNYMQT/UXhHcpPWdAvTiJoKU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786677079; c=relaxed/simple;
	bh=g4+A1Uxlgbd46xKZ5Sb01VO9pnw/Rb+AFNFVSMwXuS4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IqY9wSgxCC7oVDt8rJj4yVFsRg+1AFakRboowc4MSPDs9P57UlJOlOghSkz4Q2+TU30FHWgMa6tUTsca+XxDEuw137tuNro/EVcVAQFK8Df6piTg1dY5BXtSJZIR8rAEo51C+mOLaU1jkgOpi3PuQ+mtdLhufN1yMdhR+sTKLUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrqFmaIr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrqFmaIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221DC1F000E9;
	Fri, 14 Aug 2026 03:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786677078;
	bh=g4+A1Uxlgbd46xKZ5Sb01VO9pnw/Rb+AFNFVSMwXuS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QrqFmaIrY3GfSD62MoFRnI/XF8yRoomTK7AJ4qaIypO0c2T0rSKeMq1fYn+EMy7z5
	 H6jP5ayP9XecKSVPH+5dFStcccyn0MaGusXseVCR+ICEgD09kYd2P+9J7mtDblbHri
	 9owgplW/xLGqq6cLwUO5QyIcFg2K1YZ8cX4PPViGdQ1QgNb9rdKMbyJxEXjXG+ryuH
	 s7BOs78XNka7D4Xb5pzrSNxmUOgNvjENmMUs6oWMVYiyrQ5zH6bOeJeQDtyIj+D6Q9
	 7ljhTOj1xqt77DAahC7ktMkp5VaIjk1TQZ4R3hNVw03i+XG5rdfOUnXeHxLnUhEw+S
	 FN7cHNzrE7YZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/5] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814015647.3370124-6-praan@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-6-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 03:11:13 +0000
Message-Id: <20260814031118.221DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> returns -EINVAL if the device does not support ATS. While this provides
> a silent safety check, it conflates support detection with configuration.
>=20
> Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
> a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
> the function supports ATS.
>=20
> Update the function documentation to mention that callers must verify
> ATS support (via pci_ats_supported()) before calling pci_prepare_ats().
>=20
> Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814015647.3370=
124-1-praan@google.com?part=3D5

