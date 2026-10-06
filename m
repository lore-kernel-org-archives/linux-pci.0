Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0483B8D4F;
	Tue,  6 Oct 2026 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276667; cv=none; b=aQS978zpt1vadWYqHDV6n0wbRbuRCgrdVsui7ydRmmBRgrc/OFdreL79KV0VgrOiVOEArNnwzbOLMxEEsbhfOEL41zWIutzBuEa46TrYSiqpdQC3108P7tP9eSTfYTdJecgxSBqG1l+L6Y64nEc+niQzu3KqyfVXSkHzBRiBXf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276667; c=relaxed/simple;
	bh=hPuTMyOHC3cQYnEtZaVTjdhRZVnARB4SZA68C9fM+Ns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BSKiFwizXgJB5aW48XcKBFpXODVQ11xGcJN/aM2bpQechEg81sJuGQ2EJyrsm75PJvxLwEupYlaOa7JcveQezJQUB+o3olCCcwiWME/yr2Vvck8kaDdoIslXMEpkEO6LN5bCxkWeKzlIplxtFRwfrT3PeS+EOKvCWfHDrsse+7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw187PCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw187PCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4291F000FF;
	Tue,  6 Oct 2026 08:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276665;
	bh=hPuTMyOHC3cQYnEtZaVTjdhRZVnARB4SZA68C9fM+Ns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nw187PCEd3aLCkg8rL9exRGp/fkUmFeiUsckuQvyfHkFoG09ztcEI5uKs8E+RvnpJ
	 qnJloQdp/NQid8CsnP6MA4oeq7QpzTw1WIwdP0TlauJAFuGFREzMybVp5BWrbJpeHx
	 DcRcJjkUCiSWDMP2cHGTiTbN2ttYmsHbkiveLlTibp5bxx9F5cyOyO2ko235lMVVXs
	 G1EmgawV3tq3HwmEGDnNwAvGomqfRipBovp4SPG40Nuaxf8A2mZnVTn6/J592FB59+
	 w/0PyaSmotCBUyJ2eTEL1L/gZvlnwJ2Kh/PRbkzlDJreO8+Hi/ZJDpbRPAHdTKsiPX
	 2oxtBxk091vqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/18] PCI: dwc: Factor out the PORT_LINK_DEBUG1
 link-up check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261006084638.3821710-3-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:51:04 +0000
Message-Id: <20261006085105.2D4291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> dw_pcie_link_up() reads PORT_LINK_DEBUG1 when the glue driver provides
> no .link_up() callback. A callback that needs a platform-specific check
> on top of that register would have to duplicate the register read.
>=20
> Factor the check out into dw_pcie_link_up_debug_check() and export it
> for modular glue drivers. pcie-rcar-gen4 will be the first user: its APP
> link-up events remain latched after the link goes down, so it has to
> combine them with the live PORT_LINK_DEBUG1 state.
>=20
> No functional change.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D2

