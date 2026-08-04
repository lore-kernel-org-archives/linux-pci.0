Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9523BCF7
	for <linux-pci@vger.kernel.org>; Tue,  4 Aug 2026 03:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814884; cv=none; b=uRYNZPrzFnlHyVeaiKDqhgRItY7hH4B0DgNpHVVyMQRR9eGK1q6I/CHQiP4EhVbs3oFYBbtCi3WR8b72i989VsFzK5AKkpDabBu4/QUJCfAGyCwsSz0CNH/3wft2C4UD8YdvB3B2llA4IP+HzbPOmGjOAHsAMSDnElVrDMyUd84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814884; c=relaxed/simple;
	bh=9cw2KdKKXF0jqdiLvrCP6rWiJGW0vkgAGGQ3FcwGnzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J2LjjEvyYXGWhPFys1j3pZT4iglOICtUCHj7KHfvqwv73jpn/6Uj3h5G5hoVmQOeTEBs9WCXobnS26yB2KZwhDtuM2Fm9PQ65mg1W1drcWTpAiidX37W/Y2k/KKeGMyeQDNi4+5utuIxAZeiUTAtODuYyC7+te3QIfwIIx4cPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op51s4YY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Op51s4YY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9341F000E9;
	Tue,  4 Aug 2026 03:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785814883;
	bh=9cw2KdKKXF0jqdiLvrCP6rWiJGW0vkgAGGQ3FcwGnzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Op51s4YYB9FN1L5PQGVbbDFvKbpbCsSXW/MfIrj+nkgmmEWZB2KW18ZQdBw/hpABw
	 MEyg1AI3FnEVi5MkDg+uNuSCR/rTNBOIc/A9anmDuDhN4v7X2lmqjbmzgtpqsZVBNZ
	 GR8P+ZThk4aAA99g+1BvsoJ7vcvLuHbemH/+wXXhMpQjW7to9cisBZkCfcP0su0gFk
	 2i+ajdC+ZpDMko7TtNsLPmUBlFFEuQmWWtTKOE+sJjazuYa/WzUKrhDeE04sOdFAYW
	 NvCdiL2fMhqu2B0G5xxgpQK/G+7cVaLWCLwZ0z4bG0ftoKaPz43pTxwuK1je91OuDk
	 ohwlETsCBAAdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] PCI: endpoint: Define endpoint DMA BAR metadata
 format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260804033855.2115817-2-den@valinux.co.jp>
References: <20260804033855.2115817-1-den@valinux.co.jp>
 <20260804033855.2115817-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:41:22 +0000
Message-Id: <20260804034123.4A9341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Define the BAR-resident metadata format used by endpoint functions that
> expose an endpoint-integrated DMA controller to the host.
>=20
> A VSEC-based discovery scheme would be a natural fit, and existing
> dw-edma-pcie providers such as Synopsys EDDA and AMD (Xilinx) MDB/CPM6
> already use VSECs for DMA discovery. However, some endpoint controllers
> cannot provide enough writable configuration-space storage for a
> complete, controller-defined payload. Keep the extensible metadata in a
> BAR instead, where the endpoint function controls the layout and size.
>=20
> The format describes the DMA register window, exported channel counts,
> descriptor windows, optional auxiliary windows, endpoint-local descriptor
> and auxiliary DMA addresses, and a ready bit that tells the host when the
> described BAR windows are usable. Channel entries keep the auxiliary
> window optional so layouts that need a separate data or auxiliary aperture
> can describe it without a format bump.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804033855.2115=
817-1-den@valinux.co.jp?part=3D1

