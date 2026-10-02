Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A82544A41F
	for <linux-pci@vger.kernel.org>; Fri,  2 Oct 2026 11:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939856; cv=none; b=CQW873BopBHg+4PiBeGFR5AhhtA0OdjGUt/8+9XAzzhwLCkhRcuASLS894v2A8LLVGkcHOcYCqXe0GTAZG5CXe4rgc5FPtQTJsyq+lwCNqDm1t+Nk4bM7Mej+MxdJG5t9gVrs2G76Nm3CRfo+LVDFp2nH9pEvQtUYPgcyhxgbUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939856; c=relaxed/simple;
	bh=viohaJu2YuX/lw3MbMG4NT8J6/e7Q403+ZcEBW7kw3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aIAiRfsJ/elCndFTebsqoRht2QauNeoZeMWnWJFL15DRWVMzSTaILPSe67SuA/MCIBjekJjEwHBBWySwy3O6xVCOn3R3xTxbMnZgQ5IT92pQVOmAAccpQse60xS+alX5pjg0PW31I/8hLvowixRHM32FnsK6+iHLvd3oOJ+RGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eV6rNFvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eV6rNFvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D382A1F000FF;
	Fri,  2 Oct 2026 11:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790939855;
	bh=viohaJu2YuX/lw3MbMG4NT8J6/e7Q403+ZcEBW7kw3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eV6rNFvFFtDNXTt4kTi4NFgfmXzeWeSfHZaJF7CyNo4DZZnGMMRHZAdoaEkI8UQ/d
	 RhtgIDRQ3gOxuZfCYkJVkZsKXUslNBsYOjhq7O30Dua31eSrroGHPFgA2DOpB8iOAb
	 Ntxu08XuXQPhySDjkQ1n2irrTseehJRJ8p5pF/VaTHdlPCnLJLvaThT4G/SpOXdKAN
	 nA2DcjqkRoS9keja3NOeQzYMiuaetkTKMkm5dWbBrNMM97vzg+wDaPTriuI3yLnHM3
	 GQ9I2sZjTTSGZVnoFNFH6dK7vqRmb2uBORl8uIG+hEmWiWZvwuwCsSiKmceov6zzqd
	 cynwyDaTEAUrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] PCI: rzg3s-host: Drop nop instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261002110935.2004349-5-claudiu.beznea@kernel.org>
References: <20261002110935.2004349-1-claudiu.beznea@kernel.org>
 <20261002110935.2004349-5-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 11:17:34 +0000
Message-Id: <20261002111734.D382A1F000FF@smtp.kernel.org>
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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002110935.2004=
349-1-claudiu.beznea@kernel.org?part=3D4

