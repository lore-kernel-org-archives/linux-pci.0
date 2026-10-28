Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157175;
	b=z64vCc4FhGRpI/WKEL3B2XLG0nCnD4ma7ZR2Z28jvHm1cJQS/odMLAUzDR4B96oIoiVm
	 dCXpMtMvdubUxw+eZ0IKbFvvSH/IRP0eokJ67pQWJO3u0HsFXSyDKCzAWJ+DVyzSob/0O
	 YNXUHEak/aNoXfjhtBHksXl8+ztJzdj5PihvyV81AULvgNGkbIDHHah4yCAc+DYFuz1Ka
	 QKXPo8IRBpEWX2VeIgaGB6C/oreh7gnt9rkYlTVSjJRE4iHZAThLpE2tn4oYn9FF2MZfx
	 dRwxk0mYCEO+osNS2glRkaB5t2T9EWaK8Vmg78H8c2L8XYNz96USemyaQbx6ZMfTzyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157175;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YzjJ8+JChWrgMYLmiCuTXOguvUHIFo746MzmqkwDr4s=;
	b=c4BsPtyHVFjdNkl4aOQ7k3k1BoivKeV4smadKaiKBNDTP9QSdX7X63jc9DNmT5FuTCRc
	 hNyp5NvrR2xOc3eT63+aIo3iLk672060d+wxIdi6jf5ymjmAgBBKMCs/LNU6rjJXjZm/C
	 IyFAWHK4GEU98d3LzEeyuT/fgbMZq2rgC82vlax0mv9I8+jSr2MPM92bo3/JhU93K8sj7
	 TZXSyB3970PvGZP7VH3ruG9/EdGP+cgX5VH6dH9/sNjjL/EtW01Ov/O46dUwk/kRxys+y
	 6oyxR8UOtvX7QjOEB166xS08Of6Ik8ErCAt8PY+IgQpWe9xTbszoKRNPvGiHhaLPptA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USeO2Vy6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA621606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=USeO2Vy6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876441F01829;
	Wed, 28 Oct 2026 03:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157174;
	bh=YzjJ8+JChWrgMYLmiCuTXOguvUHIFo746MzmqkwDr4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=USeO2Vy6N8JX8H+IzQ0mGDTLnB/ui394j6/dEmxzh/pJlUTY5jdJsjpBTkko7VbCj
	 2vtdEBM4bIjKQMZB4WKWwPkatcBzYM5gvZUZgDDm8R1IgTGZWwNXSD/JXZdM2i06os
	 4Or08WzPZZaMPSyHxSpR7CakBSUpVojFyLCNqWL7iULZKgkg/J4keNIvCoMUQgXLfa
	 WmtD0WM3bA0uTwkb44RLzGMI+uYLQpHL3V3wJdalKm3bfn1crXqDP9KZ1WkDx5BNay
	 2yoRCUV2rfwdGpf+AbL1i5Cx1vzFjLFiAOAuKN28ModJ5z4GJ0YzoL5X+YvHSVNz3c
	 fzBcrjQRwmpVQ==
Message-ID: <sashiko-outbox-187397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/16] PCI: dwc: Use cached PCIe capability offset in
 core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-3-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-3-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:12:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Convert the DWC core users of
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to dw_pcie_get_pcie_cap():
>=20
>   dw_pcie_wait_for_link()
>   dw_pcie_link_set_max_speed()
>   dw_pcie_link_get_max_link_width()
>   dw_pcie_link_set_max_link_width()
>   dw_pcie_ep_init_non_sticky_registers()
>=20
> These functions are reached in exactly the same situations in which the
> replaced dw_pcie_find_capability() call used to be executed, so DBI is
> accessible whenever the helper performs its first lookup. Because the
> lookup happens at the point of use, there is no window in which
> pci->pcie_cap could be used uninitialized, neither in Root Complex nor
> in Endpoint mode.
>=20
> While at it, remove the now redundant capability lookup in
> dw_pcie_link_get_max_link_width(): the offset variable it filled is the
> one used for the register access.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D2

