Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28272367B95;
	Thu,  3 Sep 2026 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469449; cv=none; b=lBL9+HEtUoV8mBfI17trGV9I7aX/vOgo3TITH+7gEHo2/ewSLM9jIX5wN7KHfCw5mhEGIGwvZQ5kl6x54RWBfcC2vGNpqUMspBRTYlBZQFO3Cl1HEco1UBApUMViAlz82YoX27P35WN45dqhk+BO0BJ1GMSx4xgKaR1GdMfjsmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469449; c=relaxed/simple;
	bh=OUXu2C6aC5vaGXGHQ6sKblkM4H1nC9boqJydVjfyeZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vko+e7+qCDVws1RYBz/8QzIXqPiM3YMWI4VdGTQ+44QthOY6N1VD8GkU1uVTObC9ORkAHeBQf/rl8DcB5xzTbL6Go4nnDRd9OuR2t5aSlRZZjQylj8z2do6bJjtlZYs1CRGU/U6u1BQlcPQKdT8Z5wJiQiqN/jHDlnpzPH+TryU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Irliw2dp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Irliw2dp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CF91F000E9;
	Thu,  3 Sep 2026 21:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469446;
	bh=H82do250BPii3s1zzmpDjzpw33VhBZgiJ9qZWgKKEUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Irliw2dpCyL0xftbLmbPApACivqzyjDDOmD4ckWsuRMSSsLmuYM4rJ8E6fr5eOpNJ
	 hJcYS3r4y2hN3Ol9brvR0myHEKO1A0GtoZ/TyNWe8TH4z8Kg6qkRcGZbyF4SsNLb3/
	 4JITWZ1tUxj2UAIa5vyXedE29ooROR6lY6xYAy1Qw8CRNHQOYE8B/DPgIwCA/8hwG8
	 OsLdXSmlfnJjhIbXMvMxdiJ3EA+FzbPf49DvHAtm3wriQO1YkoR/UyrLk/0LLVFmV4
	 GGUL9te//2uSNC8epGkmOYdK7jZGKgDw4SWyk5O1p7FsEgNwzuw2t1t/AiorDiJipD
	 zS7v14q8m5Y7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: renesas: r8a779h0: Add PCIe
 Application/Local register reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260903205153.283553-6-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
 <20260903205153.283553-6-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 21:04:05 +0000
Message-Id: <20260903210406.20CF91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The PCIe CORE_RST handling introduced in this series (commit "PCI:=
 rcar-gen4: Add Application/Local register reset control") ignores the retu=
rn value of `reset_control_deassert()` and fails to explicitly assert the r=
eset before deasserting it. This violates mandatory API error-handling and =
fails to guarantee the state transition (toggle) required to properly reset=
 the hardware.
--

commit 3d2b0c33735de6a173b91f3402a1d145ece0119d
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: rcar-gen4: Add Application/Local register reset control

This commit adds support for the core reset (Application/Local register
reset) in the R-Car Gen4 PCIe controller. It asserts the core reset on
shutdown or error, and deasserts it during initialization. This is
intended to fix a reinitialization failure where unbinding and rebinding
the driver fails to access the controller DBI.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index fbe465a29068f..0c760041aacc0 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -197,6 +197,8 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen=
4_pcie *rcar)
>  		return ret;
>  	}
> =20
> +	reset_control_deassert(dw->core_rsts[DW_PCIE_CORE_RST].rstc);
> +

[Severity: High]
Looking at rcar_gen4_pcie_common_init() in
drivers/pci/controller/dwc/pcie-rcar-gen4.c, does this code need to check
the return value of reset_control_deassert()?

If the core reset fails to deassert, subsequent register accesses (such as
readl(rcar->base + PCIEMSR0)) can cause a synchronous external abort,
crashing the system.

Also, should this explicitly assert the reset before deasserting it to
ensure a proper state toggle?

If the bootloader or previous kernel (via kexec) leaves the controller
deasserted, the lack of an initial toggle leaves the hardware in a stale
state. This breaks the controller reinitialization fix the patch intended to
provide, since as the commit message notes, failing to toggle the reset
causes DBI accesses to fail and return zeroes.

>  	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
>  		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903205153.2835=
53-1-marek.vasut+renesas@mailbox.org?part=3D6
