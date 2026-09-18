Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AD9346E55;
	Fri, 18 Sep 2026 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702257; cv=none; b=khc3rGuRqNQ6nVv803gKQHn/hrR8lqYE6bsEvmCQ8gH71eMNPbqUrh+iCXLrfzyAysQmhsF7xuugqu1ClgRCvhqRRfu+4nRZN8R//qHFM7evGft2DBum595fRQUecUa1fCYBcV367ZQ+O3Ch6pji5V0VHRJ9tQQScbea4D0R1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702257; c=relaxed/simple;
	bh=zC6FSlhelZdXleyAGdBq0YXPorgeYggRQYUgrNreClk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nWbU575C2z5c3tR8fKl8ddkvcwVJ6kWEDuapCdD9wHAcNj3HYeu6DVXu1Lzd7PcVeY6d1T/gXyNi2FTHCmjgwSTNtA21IwlhpffOyXtFH1lf8bR0Se+WCQqFln+8w6C4FMrvo6eOfo+QEWTpQoZHicREHNMiEur9Ic3kVkecoIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnbT54J6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnbT54J6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FD81F000FF;
	Fri, 18 Sep 2026 03:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789702256;
	bh=zC6FSlhelZdXleyAGdBq0YXPorgeYggRQYUgrNreClk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fnbT54J68mmpAS1OE5Ki1xRo3tO8FvL68T7ZbacgEZOU9xPevkmCW6P0VQ1SAtyp4
	 6vpziMSvuuUrhRwf1oD0nzpMdmQdpCfaYmkCq+iVONuYaUIYmtR4nvarZ0aYLotvmz
	 2kzzE8Zpjty9MlOHaQy/xpDkfAvzFKwDE4kcQHyC9WkUbm8a0lFSw+aNQW63LSS+VA
	 gX6eKgIL+Y04y5sgyX7Fis2iMlkiiK4DU/rt79VUmr0l1DVI5lRmiB8MtSAPlMOPBi
	 /a5AT4GYj6DPJbFF0YPYJhAstEP2yaLfobBa27Lx8kab/VSSsUrXsDGsg/g5ZhY3aJ
	 j087EBlvbAy/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] PCI: rcar-gen4: Route Root Port PME and bandwidth
 notifications
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260918032038.2216471-11-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:30:55 +0000
Message-Id: <20260918033055.A8FD81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Root Port's PME and link bandwidth notifications are latched in
> PCIEINTSTS0 and routed to intreq_pcim_sub, the interrupt shared with the
> integrated MSI receiver and the reset requests. Dispatch them to the
> virtual Root Port IRQ from both interrupt paths: the DesignWare chained
> handler through the pre-MSI callback, and the directly requested handler
> used with an external MSI controller or pci=3Dnomsi.
>=20
> Enable the sources only while the interrupt is owned and the Root Port
> IRQ is unmasked, and clear the latches in the ack together with the AER
> ones. On an R-Car S4 with the GIC ITS as MSI parent, a Link Retrain now
> reaches the bandwidth controller service, which clears LnkSta.LBMS.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D10

