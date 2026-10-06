Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55213E274E;
	Tue,  6 Oct 2026 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276977; cv=none; b=MDY5drMbYMFKOzovZwlRDI8+en40K3GdVwR9h0hmFFgnvwbtF9kHTuve0MgbCFh0VAwv48+ul4LnCLM+R/a7mnhFm5tbuLcFyS9p6x7/e3EIR0f9/zGP525+DeqfXDvr6R/ELdS5NrFqQXi3YDTVuggT4Ix7Ybpj6hc7KbKJcGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276977; c=relaxed/simple;
	bh=R1w9XL7WweEkuZxWU4oXBPmQCv4fSrz0dDJ5nMzk3kw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mu9b/cP+5wfBAc7j+FooYAvDua4eZD2ETPe5oCI/Yg7difezuFxaSfkvkTdXzx+4+LNmR0eqqMgBKTuJviLelCph7yev1NAyAWY/QJG1T513uy3Bb4TG69XSQz1y0RpME+8J0et0BQ9bQ9roj5q0BmX50W7fgUbFbX3AutzUPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM/abrWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM/abrWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D061F00893;
	Tue,  6 Oct 2026 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276976;
	bh=R1w9XL7WweEkuZxWU4oXBPmQCv4fSrz0dDJ5nMzk3kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hM/abrWiwOsf990JbleyEIyC4PiI5wxu1wzRWV2Ihz0UvORIKh1yWvt+pVZWoo3ic
	 S2/W9PzFBsN4SoBc3CoC1hyXDErFBzbO4e5468+gOmMnkzpzQaN+9R+l1I4XNksONP
	 gqGUmWDRFhOBn6Sbx81vaq2B7OaFNan1UCHPdCAO+22RWTmSccnnAc+IxMwAEonklH
	 ZhBKqQLljO7QyQdgiS0gj040Rnef99LJJ1LT/+C5SJR8wlmEChRdiOdQAAnJmFbI3X
	 jtKg3fWUWtHjNK0DRDTm7Y1DYbr8ILRGq1pLjzRLl7xIZu1y6n5iuIEkFTmOUI9mI9
	 jOJsDXUeChfOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/18] PCI: rcar-gen4: Take over the iMSI-RX
 interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261006084638.3821710-12-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:56:15 +0000
Message-Id: <20261006085616.50D061F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

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
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D11

