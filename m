Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486275;
	b=Zw665SBragcH8aIUA5EsZ3GLvFperY1DkjktHdjWzTHsN6Xw4o4xMxhoQEUZFcTxLU1B
	 osuIuDCG+exmZ7MXQXYip3AtvmT1bvtM0kr2z+secrgTqm5MKaBSFqtJU09nQ8Vx1SdAg
	 mWDB87HyPnyl9dErFpCDApSwwY08WVZOU1Lt5xK9krBHL/Zptd7FEY2rpYb1y/lL220Ip
	 aaE8UNiP5gU0EIsRWwE756SQGU3wi/zNEWsXOwl38FaxbCMHKQ5maabib9Aj212KGqpje
	 PDghBUW31KqxezFqIrz6dqEmPzjIVcNLpIg/wTQcrBPLc6eTmFyKKFStEbzzwTwBnuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486275;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cgcCepA99HY09swFU2vy2pR3FyWSoxS87Jw6drVHX8w=;
	b=1S/vI3io457Y2S74JXy8qVUtEz9p5/0jUWsR7ig9iUU8a+WqzwkI0CjGmOeES7k3S56k
	 eXSYEv3up5yqe/BhokyhWjl6IsaIuBtrcCRa+7OMuIzE3ZecDvWZJLWo54T2Z5uzdwrIz
	 KOLmXaBMWDpRHPI38qBYbGv5/2V+UAnBv6Z8L3n35ol+v+GklaLz/z+bQjcwP0HpcT+vW
	 M8IfecaBHT01EJvs+DYjblvd/DMEcovYtCd//CEbl555LXqQ3SmmRtkuTYPpNLo6WJWDI
	 VrVhD47kGX47nP9Qg1IhormcZfooCMPQfHvwpi5HLPx+a3+8Ybi94xobaOljy1ptQLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eff7IUoz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93659606A31A
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eff7IUoz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC581F000C4;
	Tue, 20 Oct 2026 08:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792486275;
	bh=cgcCepA99HY09swFU2vy2pR3FyWSoxS87Jw6drVHX8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Eff7IUoztn0bpmT6NO9M++UaWZjPj5fnba7OeBOOjpdcGay8chPanwGlXGGpP8YrP
	 /4eP17T/oWW9RqhNXl73EuftV8AVYjiEiAzPNqKjYDLnw2FxdMU2pSfbOPa5y8NyuO
	 EbF4q27zJ7sZpvPAF2X9911+Kpz7g/cssXhSFEIuBFYQVyEVVQCOsvdy+Ks0SaTBJC
	 ZHAuJ/oGBfJBVPMPa8nWQCf4nR0yYy9qjHGj+6QsdbNtTaLaNVsPo+cvsoIUn1ddCu
	 8OMshYVOLdK3NMWtee4JcgNiCFYrY0fnQE12oOok9IdwMQRMNry/s5ettTpDOBLmWI
	 fqWmMGxfFlZGw==
Message-ID: <sashiko-outbox-178636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/17] PCI: dwc: Free the MSI domain after the host
 .deinit() callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-11-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:51:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> dw_pcie_host_deinit() frees the iMSI-RX domain before calling the host
> .deinit() callback. For a core-owned parent interrupt,
> dw_pcie_free_msi() removes the chained handler right before the domain.
> A glue driver that owns the parent interrupt and demultiplexes the MSIs
> itself through dw_handle_msi_irq() can only stop its handler in
> .deinit(), after the domain is gone, so a late interrupt can still
> dispatch into the freed domain.
>=20
> Remove the domain after .deinit(), in dw_pcie_host_deinit() and in the
> dw_pcie_host_init() unwind. Keep removing the chained handlers of
> core-owned interrupts before .deinit(), which powers the controller
> down. Clear pp->irq_domain when the domain is removed so the unwind can
> tell whether it exists.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D10

