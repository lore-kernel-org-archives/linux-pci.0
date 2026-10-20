Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489805;
	b=oVEFBWY5PKKyt1dJ/3ADxDR76mCSx6qliD04WEGk9d0Ze9a9NFjGYPel+nomOPHCZFaH
	 hWFc+FS9JrjFmwTvE0sRFIj/08oMBE0eTBDOkAfbrsDJelgVYzFE7WaNHB+OqeoAHTkx+
	 2Q95iS40C/jiDQIlapyvzKWJIi/mxdZW+pcYjulqBvQmcJaleRYRthfEc24CnULpOcsfb
	 o5opVtpFBac78uUM4LNQ2oj+AkzL/wPQkG2L+asuxC8K7080B5y7KXO2AP3JhA/sr+PLh
	 mNzT1A5hPgYgZSgdIciAhBw6polfxUaq/9cDrdKJPlUdW32TEPH8bLSLsQ1OzDETwtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rhWyrRCm/rxO54GBeYt0nYqoKU8/GOaxHgLdu0RnMqU=;
	b=RaJ7EtOexplvs+8JcSlS26W7cYYIOfngzK5EcylbzJY8lRQ//RKNN9oZfHDNf34Gmym4
	 RZp5ZFxczJAekMeruamFdarKwde9RSycrxW/MjJDiP64AepkvIaykpmDvbW6lXmatwZSk
	 o/28FHtOWXQRQffNdKWfQymRDuWOlrIwf4PZfVRN107/1McSCfdnDtx1NSU3hw+5qY7mL
	 nJeWqLsQBPGa8SHWoBAqzNoC0n2WlO3+8D4L7bxBzDbdN0SAbGWlnU9u/VeIYxuYEPCZG
	 pgADHuEFGfpPMVwp9OhLmndhElFaZeXh64EGgxSqld5rQhKRf0lgURmU5lxOjTzf2NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okDV2QMI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9033606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=okDV2QMI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8D61F000C4;
	Tue, 20 Oct 2026 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792489804;
	bh=rhWyrRCm/rxO54GBeYt0nYqoKU8/GOaxHgLdu0RnMqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=okDV2QMIRbOxr5UqIlQ3PUlr26kBKuz+DRuknA3dSaSsqk2lzLEKagXaaRiEo5fTp
	 K9PIi4jrE9q9wt7MLoEnvlfLsDuL44cTJd+rD0Di1l2depVnqq5TFSP7QDR6deZXjF
	 Tpa0/Sumw2XaN6BSWOwJ2v65sm3TF3qNsFCQJIFmzIGzJFrvrK5hHNzkGDZukmyDPV
	 EjFuEZOv2kf4wbrCMnjNlctCcXk0amEeb2t6eW9qA6NcTtyyAuIkiYv1sapoGODk92
	 hUnFjV1uV1pr6GhjfUFjRKep4H55dk67Em7ePXTxhW86APS/95h9q0v62nP1mpJYVl
	 Lq5ThfpVNnvEA==
Message-ID: <sashiko-outbox-178759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/17] PCI: rcar-gen4: Route Root Port AER to a
 virtual Root Port IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-14-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-14-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 09:50:04 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

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
> Hide the Root Port MSI/MSI-X capabilities so the port services use
> INTx regardless of the MSI controller. Do this in the R-Car host setup,
> [ ... ]
> disabled, so the level parents can retry through the reset checks.
> This avoids losing notifications without a raw lock around port
> services that take regular spinlocks.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D13

