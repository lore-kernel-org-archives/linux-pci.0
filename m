Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801377;
	b=HLb/IRHD2rg5uBJRWhu9NQ4AGYOwHwvqhuitQwD/QxgJqE/XaCAHceu2dfBgqLXvNV3V
	 eqiZd8vy5ZUAspaENK1PMCKPL4cadoiR9ZUJcwxIGeF8bwW29yEh52TNkqS+tTGOwx2Zr
	 bIkz4/Cx5REFjJpehAwopyt6woiyZlyAs7ZPnzXWUYirNH4Zk9b5hjKVF5OYtEJ73jvEZ
	 031IzoMHGUt4V//qasAsSKeldkbLUPdogsWhjaZxEekC/p0QF28vb0SkqkeYozCcZvl5x
	 UOYbVzQc1Qlp4RYDXjgN8U3Pl9tKfn4Hl+B8HSL8aE801NrzzOfcqwX3AAxUu9zpl6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801377;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7OmBhYerWzk6088/+t/+9ffCYHDE0VMhfvqb+WQ0TmE=;
	b=AIC4yyLmt9Fd/YhKEFhhO7TQul/IdgXF34qNQ2m/DaNym+2yFh89ykbAPqiRNepI64UZ
	 R8DOHf1sc2CQicjFVbmBxeJIhg/RfmnT3bGq1wmLFTG8Fu5LcrROt3bSuFkinCNcMdsSS
	 MfPoC3VgzyeUvM+Jl6i079wbKzIAxzxpheayE94ARHJDmASt9febbYg+JcATJ1LbZtJLc
	 kwVgem1nZyF/AkB76r0wi6O+lKQbr2tVz67ykycKZZfCdMNIZGQ9zfCDZEFZ+QTxnb3Hy
	 NuVZmWO6XZUqG1VBDKj3BtEuvUBtBecjRmmho7xSMdeQkO8ZdE53mhLNO4gfX8foyLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXzEjAcn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1D3606A336
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXzEjAcn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B271F00A18;
	Wed,  4 Nov 2026 14:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801377;
	bh=7OmBhYerWzk6088/+t/+9ffCYHDE0VMhfvqb+WQ0TmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eXzEjAcnqRwpQJl2GrXDECrqFbv2zUZPqovVAX389Ii4KsGzg3BUgYDPMN0R+Mvlr
	 LSaLCia1+pgU9MsYgXncfxw8Zc67cgKzQ7YiXVn8qR1eCUM9AH3Jtkwmo8mDnWEAEo
	 eexVxgDZDWwJ8srDUpM/NxTtlGC5SZ/JLGTRz7pBuuomb9Y30YjU1IWX2cmOF3g1jt
	 4gCaQ61j+CpDe+Z/lcViL7YGqINw5Uef1CmTcd39C8HHfzUm+/hpzisaHIxbiYNdM0
	 6dq3SeTnufKi8cKYd6DXEyNe1RqF1ubFwZRukV7kaI1cRdyH3HOSp2l7c7uTPZ8KUL
	 JIPxZJlnvM2YA==
Message-ID: <sashiko-outbox-197403@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 5/5] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Manoil" <claudiu.manoil@nxp.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <e01cc93899ec6e774a568c72d1f38788f65c8577.1793712309.git.claudiu.manoil@nxp.com>
References: <cover.1793712309.git.claudiu.manoil@nxp.com>
 <e01cc93899ec6e774a568c72d1f38788f65c8577.1793712309.git.claudiu.manoil@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 14:09:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> NXP ENETCv4 pseudo-MAC (PPM) ports can be probed as pure PCI endpoints,
> without any "ethernet" node in the static device tree. The ENETC4 driver
> describes their fixed link by attaching a fixed-link node to the PCI
> function's own OF node, which requires that node to exist.
>=20
> Request the PCI core to synthesize a per-function OF node for these
> devices by registering of_pci_make_dev_node() as a final fixup, following
> the existing precedent for the Xilinx, Red Hat and EFAR devices. The
> helper is a no-op when the function already has a static OF node, so this
> has no effect on platforms that describe ENETC via static DT. It only
> takes effect when CONFIG_PCI_DYNAMIC_OF_NODES is enabled.
>=20
> Both ENETC4 PCI device IDs are covered (0xe101 and 0xe110), since either
> can be instantiated as a pseudo-MAC port on S32N79.
>=20
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793712309.gi=
t.claudiu.manoil@nxp.com?part=3D5

