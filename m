Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A081A48488F
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392977; cv=none; b=utPKY0XhRI8tIBHPrhIJ/VeBc0W56vT60fFTRK7v259UwLVHOhRfVdhpZtVeiOoMD8qhnCnMpU1ZMFQ2aqOuM/0W4kYad1W0p0qKo9kds3ychejefcFmTLjccZlo54sZqfeRy2MDUQoPfCSr0F4udJp3l50nKnC/HlspfCYXSiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392977; c=relaxed/simple;
	bh=yI9IlE1NiYPhx7Pp0c+Nihaggzbb34LJbPO6BJnEneA=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gJN0J3zHieM2qKuc3QXA5ZY1/Z68pDpZLEBLTYj21GMuJLC1yJYoQo/oc+e5VQQQrrmm3eo8BOwsJr/Q9tfWayMpbFEBanHgF+M5G6Ph1uKBmwwNBg62pnlBIpO796OALwxcvVpcMkDla//vqA6Xxr3xeGdZ+nf330DsASQuMD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyGtk7p1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyGtk7p1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648501F000C4;
	Mon, 19 Oct 2026 06:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392976;
	bh=yI9IlE1NiYPhx7Pp0c+Nihaggzbb34LJbPO6BJnEneA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HyGtk7p18tlLaWCCh2gN+A87hWErkZ36lLxdYktilgSYjXdDq/EzkqOHbXKn7sHdZ
	 dDRpMbU+qCB9qv7WpfuTmC7E8DMDsB9c1Dcz4uwG4JsSUZaTsca3ZOHn4xO1/4DS51
	 +G+dyOmKs3OpK38p8BYsOur1Nm+KBKpCE34Ekmf34pYxq2n9TU6naQpmct9XTTybNd
	 eE9m900XuEiImwRlEjcl93rqqs1GuDtwAHevt5mzTsyxXJMSa25VYOL6UVV+lvae+x
	 3Vf5b5P0WXjYJMmGi1TByIljk91wwQ91khCoDJJielTLjeTq0pf05Zf9en97xnQJmX
	 8w/wQPXnjM6IQ==
Message-ID: <sashiko-outbox-176720@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/14] PCI: rzg3s-host: Create the INTx IRQ domain
 before setting the chained handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-5-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-5-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:56:15 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> rzg3s_pcie_init_irqdomain() installs the chained INTx handlers before
> creating the INTx IRQ domain. irq_set_chained_handler_and_data() also
> enables the interrupt, so an INTx interrupt arriving in between is
> handled by rzg3s_pcie_intx_irq_handler() while host->intx_domain is
> still NULL, leading to a NULL pointer dereference.
>=20
> Move the IRQ domain creation before the loop that installs the chained
> handlers.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D4

