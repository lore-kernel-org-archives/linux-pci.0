Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5FA3242B2
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979284; cv=none; b=db8D4+Tc2L0/pmC387IvHaWBOEFdCmfmUiKmdRmWzLgbq+t1xUP1aDnSdXh0k1NQfIQVQ/C1sIZGzJFs1UOIbNezOskAMdnSFe9JHv6K9HXBs1UF4YQdi5FprvyFgfyLZkaowf3Jm/s8oEFYm64wbDxsBOmJ80oqM7Zfafg2N6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979284; c=relaxed/simple;
	bh=kFYT727GM5J3jAtQtYA2n4j8BchuCyahmFuD6RPxDes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UNQmpn8CAMOtVmhyatuo7/SDrUd/0klSSrcj5OAQAnSHqE1t8C6mYogtDYaKTdbPQg1I12w+V3kUe6mmpH4CtLmQqw7HFI53vaS9KjnCd7mKM4kiCgfCA9yzglRhJd/O9l2tDPfEviN6mwXc/mj+UMC99WhdZ9LaYI4Eavt2zm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgv9/sSE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgv9/sSE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86ED1F000E9;
	Mon, 13 Jul 2026 21:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783979283;
	bh=reQ7PuvXXi63L7y+XZ+KTz7zGng8/NSBAUoX/Al/Qjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tgv9/sSE2L7gzhmJkBIS1Igr9fcg8x6UWhaotria704S7mxJ/quFUxHBuh1zt56mj
	 pcAN8T2BAmlZoHODjINtZKUuoeN4YgShf2lL4hwHxsij6vfIhJjZIx8wvb0aJJgWsm
	 MniCsiXEQM6VMpTZqmUzj3XKdEN1HKLT/YKoiKuICG/JmQ7A7bQi4XIg0b56W+2h6h
	 7xICPPU+LHDxNcOYY2Hjhbrr6wVdXVmWMz2F61WP1jfRNkqyds06Z+qZfSBSAmBlJY
	 IDuNrMEifQZ7G+L+0TyPtgs4cPf+DV2LFprSXx/+N9CvRwT3/QruFhgCgMxogu3u4o
	 HgKPRg759AZWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI/TPH: fold reserved completer encoding in
 get_rp_completer_type()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260713214026.793795-1-zhipingz@meta.com>
References: <20260713214026.793795-1-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 21:48:02 +0000
Message-Id: <20260713214802.E86ED1F000E9@smtp.kernel.org>
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
> If a Root Port ever presents the reserved 0b10, that value could be
> written back to hardware, risking undefined behavior.
>=20
> Fold the reserved encoding into "not supported" so only the three
> defined values can propagate.
>=20
> Fixes: f69767a1ada3 ("PCI: Add TLP Processing Hints (TPH) support")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713214026.7937=
95-1-zhipingz@meta.com?part=3D1

