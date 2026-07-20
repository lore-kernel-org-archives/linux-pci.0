Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7F407CD6
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568635; cv=none; b=WiHmVj9MiM4W/4rTT0blmau7J55xeYm57FC+cUkiTXcpPEMHzII1Vu2tEzHViqx7OB7kbPScfZQuy989vOlJHyAgn8BtgsYSVvAwmatGdrydIAeEd+l1QRSrBRsHMvnZ0Q4Nbl2A81TT+csczaKVmvfAQn7HreNOYaF5usP4+GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568635; c=relaxed/simple;
	bh=fsa+sJnSVGd+C1LZrAd2F9aNQHk9Ct/JXM/E65OFiss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FUvsRlDBgGXTCUcVpYyYPyO6+3WOJMWTNFcaHDj5zFVHq5qWqScVFokxu8J/fyqEEKEQT8BPfGpAm4g99VRhUlb6WziCkW93/JWwypfemmTPpizReUk9n3Yk2I5CWy8eBIZ+Grdx0psHa5AwQlla0fPEEFbqfOmwjkqHqpnmHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERWhUBQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERWhUBQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12131F000E9;
	Mon, 20 Jul 2026 17:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784568628;
	bh=6/odTySXoU7O3m+02zazo+atNX93gN8RICeQtFTL4a4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ERWhUBQ1gJ4Wfoy8wXMh/EssGShgy3RqOxcKrYJ2DokVT0vm+4fSBgHxmwEIbUkvZ
	 zkNDbGHeKVohGoAZrAwgPet7qeSjQHc1p7JMNFY9ANRcHYv3LYT2obOOq02/hUgqPq
	 rprJXObScuZOR2OZ1j5LWbTSi8+rZxwkFZGrY4/hITZLLishCwpx9VZeN11BWrC1p6
	 DtbNvQs2k2898chMGiflHHq57g7y5A+5y66zCwYy1S8QDnrR32cEAti+m+uDlcfpe7
	 KYzzODuYmC30sE6acUS5F3FGYsFFMhodjZ/fp4pZPi7BTC5hJZd/73ntDmopbW1+um
	 oKX+0tw9lUkSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI/TPH: treat reserved 0b10 completer encoding as
 unsupported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260720172304.117134-1-zhipingz@meta.com>
References: <20260720172304.117134-1-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 17:30:28 +0000
Message-Id: <20260720173028.B12131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> get_rp_completer_type() returns the Root Port's "TPH Completer
> Supported" field (bits 13:12 of Device Capabilities 2) verbatim. The
> 0b10 encoding is reserved, but pcie_enable_tph() feeds the raw value
> into the requester type:
>=20
> 	pdev->tph_req_type =3D min(pdev->tph_req_type, rp_req_type);
>=20
> and later writes tph_req_type to the TPH Requester Enable field, which
> only defines 0b00 (disable), 0b01 (TPH only) and 0b11 (extended TPH).
>=20
> No known hardware presents the reserved 0b10 in this field, so this is
> defensive hardening rather than a fix for observed silicon: fold the
> reserved encoding into "not supported" so only the three architected
> values can ever reach the Requester Enable field.
>=20
> Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720172304.1171=
34-1-zhipingz@meta.com?part=3D1

