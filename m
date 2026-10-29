Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793242176;
	b=uUHI+qouHXEr2ceX5Ru3/Y6NPKCyNx//RZleliM8/CjxtWtyCNRQ6D464EeUi7xDC13T
	 uxPLa2fmtfgEPFQmddCKNvjpBr7okEDpoIVDIcuvV4CI/KIgTROyPrdA6jUzN/lVb+skr
	 lzNMewHVphTpLD2mbK2b/+vsl3sg/IGoSYvdB50N/T1wTYRe214NkxZwqNcm1AOm2mzuM
	 hzC1+xerwpAIUQOIh0UXCrRljn105e0Wnq5usOnLHSDiLZ4b/2DUQA0+9vhuQW9c0ZPkb
	 geUx/KmQc2Oxzr83EjHSsmg6GqENWuA5//hvVyZOEBNUmi1kZxSDHYysXizMIIrAZbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793242176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CVDiyfIRzU3sZ17VVB/x9CQy1nu8nDflNC28WeZzkcQ=;
	b=VQwjlYSspuzfTJLUE/rCCcgWqRDbujSFt8aQH3DWPLrlNsO/bX8KBZ/uW9M9U6uPho+l
	 3C4GVKRkgsJgfNPGxRhF+rAPkYdpgqcaU3wS/jrLIWuEnm01PDxEE76VN/nLJEovuILdi
	 T5UIB2bOErwi16hq81JixT+0Lq6Vm+XshpFDT0WnkoH76nlr2Cbcnkzz9Jh86SvtRBeeN
	 t9HMpajcjgK8j1BHq/u0UCR9OSX/8aOQ/2GiHQlcwOIIZXaDWDYYv48gh+wB7vxcqfDSi
	 jEThOgCKNxqJowBWO8Xc7fO+T4gjthjYLkTyZYz8dTzyGkkAgso6p41/BBf96JGNCYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jyf7FmdL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB570606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jyf7FmdL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535661F01825;
	Thu, 29 Oct 2026 02:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793242175;
	bh=CVDiyfIRzU3sZ17VVB/x9CQy1nu8nDflNC28WeZzkcQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jyf7FmdLVBgxPNmhroR2isY7b3bm286s13sthwFZ6KpOwEEL0ipVLmlaBjy3Sf/2G
	 Q3+DA/C/aHHJaqqsrpLVVigciYuyQz0p9zRuMk5BitpSuOi7cA6sFSRlVLWrLCE+CG
	 ADygpeVJjfR38y4nOsZpXAk8AR3RiYlauH04XBhoAK7ev0TNym88IrVqDuNw+wQZE1
	 FPs+1iBV/tch3nZDXzhDFUQVq9ycHlpX557fCodAJ1PbelO0d7nkogVud0hQPtds7K
	 kJHOOEPND5HD1Z24+hTTX5jGiQt4wOIKWD9l3c0YEugt3iAypL0GM7pfHidzI9wV1S
	 o+MJ2pKOJroUA==
Message-ID: <sashiko-outbox-188649@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: rk3588-evb1: describe the
 PCIe3x4 slot supply
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shawn Lin" <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029024006.3483210-3-shawn.lin@rock-chips.com>
References: <20261029024006.3483210-1-shawn.lin@rock-chips.com>
 <20261029024006.3483210-3-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 02:49:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Move the vpcie3v3 supply of the PCIe3x4 controller into a child node
> describing the slot, so that the PCI pwrctrl framework manages it.
>=20
> The child node is modelled as a PCI bridge, which is what dtc expects
> for a node below a PCI host bridge, and carries the regulator that
> powers the devices in the slot.
>=20
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029024006.3483=
210-1-shawn.lin@rock-chips.com?part=3D2

