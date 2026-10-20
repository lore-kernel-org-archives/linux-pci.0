Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486938;
	b=HNV3/hWdwrsStpA3g+QuLH7Az6klA5ZMPIdbpy6UkkrN3xOQI/0iNY6+oIdYvp6kzWu+
	 ZHmgjVtC24QLacfzlRwgpNIKttGN2GTMbeENNSAcbQ607dL5QyBRPXRrW+fADQkxKCC5w
	 USjSI+3ZXHnefWBN14+Xk7MRT/tWfTPkHz20JAmroDEDDGtZyfSzjeA6I7EV+ONEvY+lv
	 WOSAa8sxTPp4OcDgGGbEWxVP7oB9Op5ifcmuyCEXo1yCqsLkqRBLxzSIGV/uAafAT8gF7
	 hHLCC0uLyj4NWUaAHBH6ZP+2T3Lw1rs6ghEC0i2ooQ54sG9/0BGod0JTK57cZemB/5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486938;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jzuF7UhZNGbtrqDBpYFsSJRMo0Zpkz9plX6EDA/Rs+s=;
	b=nU9d/IrDSIEN+TQ4ycP0xfb0e8HpVryxxKZ9cpm8cdAxr187lqTCcM0FYLbaVEajRPDW
	 jOCnb+rxGx0PAmrm2vimoLgn1mJtZBYW63hAxbgkER21UGyqK8ZTz1BR1KDrVDy3bHEbQ
	 Gq3lLZppj64s/SaL+TZjeV67y2Nn8+Caxa6DUr8HTJT3Q7Hg0adN+taRTxiuzuBuZMpER
	 Rv/RhDdkStTLaK1cpWylLKWw4wEEQRK4MqT5s6hOGmUDQMwPaYRqkXoU4+rskX9oVzvmJ
	 G1k5r04Hwlw5VtKRkJ63CvRrthgfSRoUYVxdH12P7nhAfmv9bYaoIhu5qq7SoMxnc9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYkJBiEm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591C5606A32A
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYkJBiEm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CD11F000CA;
	Tue, 20 Oct 2026 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792486938;
	bh=jzuF7UhZNGbtrqDBpYFsSJRMo0Zpkz9plX6EDA/Rs+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYkJBiEmAuBWOABZnZXVHlc63w0Uo/XEUwPwiJIMDjsHrtNNa6qR8TWHjaVoSN98e
	 I78oK4o8qhpTr6F/4nHtCM0+CkOVrKATXrJM+XaAyjNmPsmRSL8DmXideFRWrL6NFW
	 d9S+oXKfHnTMyhUCBKcaio9/mbIKNslbM7XYnmZPW4WJyfykVzssOSqTw9PDznRLeD
	 abLCoITVsaNdRvRIIkRAkAlyXsoGIyRKYoV76RIcdg7FD/O+tDp217pafTU9Toa6Y2
	 wzOu2y3UuMpClmPJquGIkkCHs70Ra4Io0SgbwBigBAsGGAFXjLEFW34/YWuAkjntsi
	 5Jugw1UFj2YOg==
Message-ID: <sashiko-outbox-178679@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/17] PCI: rcar-gen4: Take over the iMSI-RX
 interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-12-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 09:02:17 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> On R-Car Gen4 SoCs, intreq_pcim_sub ("msi") carries more than the
> integrated MSI receiver: the controller's reset requests and the Root
> Port's PME and bandwidth notifications are signalled on the same line,
> and the following patches need to handle them. With the DesignWare core
> owning the line through its chained handler, the driver would have to
> hook into that handler when iMSI-RX is used and request the line itself
> otherwise.
>=20
> Instead, request the interrupt in the driver in all configurations and
> set pp->msi_irq[0] to -ENODEV so the core does not install its chained
> handler, as spear13xx, keembay and dra7xx do. The handler demultiplexes
> the MSIs through dw_handle_msi_irq() when the APP block reports
> msi_ctrl_int, in hard IRQ context like the chained handler did. With an
> external MSI controller or pci=3Dnomsi the iMSI-RX is not set up, so keep
> msi_ctrl_int masked, and the handler has nothing to do there yet.
>=20
> Request the interrupt in probe with IRQF_NO_AUTOEN and enable it at the
> end of .init(), before endpoint drivers can use MSIs from their probe.
> Disable it in .deinit(), before the controller is powered down, and
> around a Root Port reset, as the handler reads the controller registers.
> Suspend and resume go through the same two callbacks.
>=20
> The DT routes downstream INTx to the same line, but the driver has never
> supported INTx (no INTx domain, INTx enables never set), so requesting
> the line exclusively takes nothing away.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D11

