Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902BC3E1CF4
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035753; cv=none; b=gibfKuitrhHbLxPSWu8+5FZqj6Ti6gt1CEwrTVziN862B8o8TWAmrfwC82MpzDFQOnGSh9DwPcwXLAficxC3AooVXlbcqWP7D0XQ0hR/pRn1wMCtzCpqJqRpGUEjOxYOphkZ8N4wu5NmmdpT7RC7nf0Lc/Pyb77wBrVPUt7GgSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035753; c=relaxed/simple;
	bh=751OhSFwNq0ftEIhSzfbX2okMF/qwTtw9YTx5b279As=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Prv3fR5+Mz2NjybwxIViKDf6qApVZLAOOiU8u6cUm96//ro+/OoYEq6nzTM4octEKuv758sYBPwE8bC3Ln7qf6A4ePvzmzyeOsYgYnZKwVhJUvU5b4TUlakvYjEYTMdQyheQsHEh3MJQZdELdqOFR0AvuMyxjbsJqUI/gJug+8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m65UinCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m65UinCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA421F000C4;
	Thu, 15 Oct 2026 03:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035749;
	bh=751OhSFwNq0ftEIhSzfbX2okMF/qwTtw9YTx5b279As=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m65UinCu0O/05oUdL9oOueVFFe2JzHcRHKKng1GC4eP1rwHdjdDt6uuNfZPLxa286
	 Rbw6ilX30GhR/SZTsD+ugkYCRXvo35N9PEa3sCEKKjQR5d0IA3DGcCN5EYZtE0Bg5b
	 gCSPg5iQ2GCztoRCQRYaAq7oYVEfsSPlbBhC2rbH49SSWInbqWR4pkk1Bvdr+gaN3c
	 o78l2UElLGbwKJkaC/6K5QUl7TSOfWH+GCbzm8z+SKROjA2q4He2hrR/VhZyIJcVEd
	 kuiLdS6I39Pd5/c34htwUWteF8k8IO3JgxP2bcInqJGLYpTcLwJ/P5+7nW/iD9MUQj
	 S8u2xlkqT/MFg==
Message-ID: <sashiko-outbox-172215@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/18] PCI: rcar-gen4: Route Root Port AER to a
 virtual Root Port IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-15-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-15-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:42:29 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> On R-Car Gen4 SoCs, the APP block exposes the Root Port interrupt
> signals in PCIEINTSTS0 and routes them to platform IRQs: AER to
> intreq_pcim_lperr, and PME and bandwidth notifications to
> intreq_pcim_sub. On an R-Car S4 with GIC ITS, a link retrain set
> LnkSta.LBMS and latched PCIEINTSTS0[23] (cfg_bw_mgt_msi), but the Root
> Port's MSI never fired while endpoint MSIs worked fine. With iMSI-RX the
> Root Port MSI capabilities are already hidden, but its INTx maps to
> intreq_pcim_sub. Note that even before this driver took over the IRQ
> with rcar_gen4_pcie_msi_irq_handler, the port service was unable to
> request it, as the DWC core used that IRQ for its chained MSI handler.
> In either case, iMSI-RX or an external MSI controller, Root Port
> interrupts are not delivered to the port services.
>=20
> Set no_rp_msi so the Root Port services use INTx regardless of the MSI
> controller. Use a virtual IRQ to deliver notifications from separate
> [ ... ]
> disabled, so the level parents can retry through the reset checks.
> This avoids losing notifications without a raw lock around port
> services that take regular spinlocks.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D14

