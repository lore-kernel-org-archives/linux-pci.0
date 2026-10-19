Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5136E3D75D7
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392904; cv=none; b=DdIMCVsV1ip3GG9RiQg78dQjwHLlahE+RShSxW+Te5e2DdXj8bG1g/gdvN/0hAxrmGInh3vZeQ2ZPvxytudam38JRf7kxfcLRZaHsUsm6SMNg7NqPn07RE1Y58+7RfbaTQFfY1Lq8EknVm+Y7xWjIvXJbdNCatuV1m9OkPQGtzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392904; c=relaxed/simple;
	bh=AzjxbkxchTNF+RFGgZmVcfY43E8Qbp7Bc/Gwd51lbtE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=tozhJehz95XaPUbCJgPwj7jzWy5RltRT/Bbkk3ndafEfpjaCkeLDRy0QwiGW3YREk5PHBvEcPIU1nneOSLTFm5k1zxJu70U6oQob3oPjTtoFDbF+ETV6ixtyLr6hQfsIPk18mF1VeK5dNqb2Xyhs0CwFP0KCQMB/WyH2PFfYrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsGl8ivs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsGl8ivs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B321F000C4;
	Mon, 19 Oct 2026 06:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392902;
	bh=AzjxbkxchTNF+RFGgZmVcfY43E8Qbp7Bc/Gwd51lbtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QsGl8ivs+M5kU3Gf/1/zzVVZLYMEgVs09MalLTj2Sq3nz74sFSDU58PdXU7qtkpr5
	 bD3uitrpzAh/F00yqThd+1uzy6ZBb9LpnC4t8eoRtog6Dz1klz0rGA3JRaDO+TA/In
	 o3rYEsZl3pAL6ezsvJOLwMn7hm9OUe78eOiNhzsv4xffHr+LAmWohE9xOQHSR7Zpig
	 Vi9m7TCvT7WNpY3B1L9fe/zdM2oq8tXEpUsYEkW2etmAk10TZNoeb8mSeFPJUte8VF
	 8Bp80cXabZHj5XZ8xGPKjxIH0b9yhtrQ5jhv+wqQuPLR45i76bjWRKLkARJXYcNdGu
	 Ds86hoi5NDuFg==
Message-ID: <sashiko-outbox-176713@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/14] PCI: rzg3s-host: Drop nop instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-9-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-9-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:55:02 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> On the RZ/G3S PCIe IP variant (which is similar to those used on the
> RZ/G3E, RZ/V2H, and RZ/V2N SoCs), access to the PCIe Type 1 registers
> requires setting the PCI_PERM.CFG_HWINIT_EN bit. Since this bit is not
> set on the code paths where rzg3s_pcie_set_max_link_speed() is called,
> the writes to PCI_EXP_LNKCTL2.TLS are nops. Drop them.
>=20
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D8

