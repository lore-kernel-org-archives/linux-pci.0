Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017643C108E;
	Tue,  6 Oct 2026 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276853; cv=none; b=AVU632NVQb8keCZOMBZLSbUMk+87oXUu6qmyOPtqud7jKUDxAIHxIt9z8vzTm4HZGnDyhD+vZl3CqnDG9rOhcu8Ykv5ZO5/fZYDiFsjM1B/xtcntL0VQq3zKTNE6AmUVqJxGcpoWSRWjaXPwkp7o09w0ty+j3fdKtWMz2GW1zQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276853; c=relaxed/simple;
	bh=k96U/KZ2LJqFlt6umC/rXmNknvOlwn7bPmnu0VgPzGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mwIcAZFAa8BOv607alls38sz+5t3E1cObP4oIW9p2wsaqQxRpnZthIFHpiGq6lhWz1G/uWq+aJ51KUi7f3lmyy5lSYxn9pbseItIklqqM8ATwkUk4ruwW2TPZdHdMPnubY6gOkaT/7cuHPsM2tPyEs2lH+KQ3wBX5t5x+m8G7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4SIV4lb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4SIV4lb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72371F000FF;
	Tue,  6 Oct 2026 08:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276848;
	bh=k96U/KZ2LJqFlt6umC/rXmNknvOlwn7bPmnu0VgPzGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U4SIV4lb5IBN6uEv/uySUWsc7xG765v5njmZ5Zd3k7goWrYElCpE25KKgtFSyAkAb
	 yCmouzgi0XeLI8MfMdEIXtBxLMkx42nG/uAaUmfcs6EMcFJojfPTOTS/DuU7cjp60W
	 m9QG3fmOAbWlpb9ojGgX0L5CrobcUO2WnZmQBhU1JN9hxp6f8m307Vi9sM9HixlOUL
	 vjPTRy8NHsS/qzIIfw7HTCS/tTtgTaP/PXPeYxpPCjAfOOR8+PXcWdKmD3r1qzKhWK
	 jDpG9bKqrHJ6Y6P/Tm88ejaNp771zKhgGv3Zm31oVlclyjnYksn1e8mG2pP6eCm7yR
	 DD4mYyFJjaJNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/18] PCI: rcar-gen4: Route Root Port AER to a
 virtual Root Port IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: robh@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261006084638.3821710-15-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-15-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:54:07 +0000
Message-Id: <20261006085407.E72371F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D14

