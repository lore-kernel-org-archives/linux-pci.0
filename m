Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F5838737A
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790088870; cv=none; b=MnTjc748GBpjMhSGSh9yOCotqbxeFkd3dTHrJBCFOcrcv28TPSRybkIGOTjUEYVMKPTrwcQk7hDBM7XdrXGroVox5Xur0fDYo3i+cIHy0xGMuOCLHFSdRJfZUb4XEurkao/LsjNwrlUftyv/Co8f6cNZ5AOJ4AoYU1UeylDs/G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790088870; c=relaxed/simple;
	bh=+FV2lw6472JgpNBxD4YH8I5kn+Jwv5JTkV0hTlrpNUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sSB/xEtPlLodtQF5HvdcywWp3865Ow/7wFuVTk6VvuMyC3j32GK9nEJls7jm+Zjb/7hiYw8ec5akQ53z9QYDgUT3+1EgHdvNAfAoItPzIvt8zpO6qekfp1ciKfkIJxvACQsKmJmUlGMYMdNDjZ1yxRaOBuIrTHA2t8NjIU+msX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS4+gET9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS4+gET9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43561F000FF;
	Tue, 22 Sep 2026 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790088868;
	bh=+FV2lw6472JgpNBxD4YH8I5kn+Jwv5JTkV0hTlrpNUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IS4+gET9o6EP+n68PqZZGhmAxSr1IS0mZ9CSfoHKGAlaQQ+V/JRfjUoPC/FH5W86M
	 NkMR5RaqvukTcd3QjhWVcEIUGbcK0jc1IP6aZPDczQ1Z5RoqzISxxUIb0RiREf30Xb
	 wbBSsTfWWIB8KN+yBCyMuxOHeiAfRqrRxQVMMy7JIjUhjmjFp0Cc3xZddnRpVTcjaC
	 dLHFa3OKnZFISiQMkTjxFivUBGch+B7CwuMjg6aAIHB23kG8OfqgSgd+vV8CxpJ61S
	 PexHmYBpw2X3mxxfVFJtPXUFxqaz9WxUUzGgJv1PFpNb0AHMN2OcVVtEI87gyNE8d4
	 fLhjLWT8x7j7g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/8] PCI: rzg3s-host: Drop nop instructions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260922144629.586997-4-claudiu.beznea@kernel.org>
References: <20260922144629.586997-1-claudiu.beznea@kernel.org>
 <20260922144629.586997-4-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 14:54:28 +0000
Message-Id: <20260922145428.B43561F000FF@smtp.kernel.org>
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
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922144629.5869=
97-1-claudiu.beznea@kernel.org?part=3D3

