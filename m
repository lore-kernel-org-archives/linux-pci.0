Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FFA3955F1;
	Thu,  3 Sep 2026 21:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788469335; cv=none; b=u3pHAAKoxsGx0FOAG68K1XxQpD/igH1EjSTqFlewRAjuIpfYfqV9mpJ+u0iz3YX+n/q6jM/9Dx74bYMKqyLiqpEljrwVobD/GoZHU6sqgAe8DcWEAgjugGxbTM9mYMDf1S4eg440QXFrZio/o5bGOAmlpHBkqmrVGNhKmT3QlCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788469335; c=relaxed/simple;
	bh=ksXJXaWJfELWlFRuZ8i8BzVcPf9rrAqJSRB1XZi7lWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UvqD/bDgoglwXRdjqWPKYz4bSIEeT5Z9g4caI5LQU0CxRK9CZS7xZ9m2dRk015s5rRT9rZtxsgKbF/lU9dR5PPgHgVClUfkEz09UzdwopQ1d6NUoBrzi6I6pauWqI/DsW1NsOqw75ncoYPk3gtyp9/zJdMj8eeDA957YRasEqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoX4KdLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoX4KdLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8B01F000E9;
	Thu,  3 Sep 2026 21:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788469323;
	bh=vD2gtvFCT3P/QySK6YgzKpg3/pzk24Y9WdrFDBdWooM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CoX4KdLmnjdilh32k8ZnrLtC0wLzoOAjTs/RcZzo+6ezwGADpgKwaNkidhGmrQ5lQ
	 mX+ROuwKnNLgzAA1vFGpdbtQtJD59Q5x7FrLYUr0n4l3y30h47Mp5qfuRR9fyrBlda
	 XVtwp6GcjsvRxW3YB3LcN2egVbMv0XbjRGB12OXpR+xgFU4sOb082SU0s25ob0dNpP
	 fCah0PsQRSfd6QjAjjj8EcukeQ2VH+4m0b5MqEMvt/KsAL+ZP+bunfDWEWh2+8K7KM
	 YQAaS/45Mf6K3HADxD65fKb63r97/idwcWkPLDq6Rpx4k8F+o3CAFhsrra0vxaqunj
	 B47vrAXopteUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] PCI: rcar-gen4: Add Application/Local register
 reset control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260903205153.283553-3-marek.vasut+renesas@mailbox.org>
References: <20260903205153.283553-1-marek.vasut+renesas@mailbox.org>
 <20260903205153.283553-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 21:02:02 +0000
Message-Id: <20260903210202.CC8B01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The return value of `reset_control_deassert()` for `DW_PCIE_CORE_R=
ST` is ignored, which can lead to a system crash (SError) if the deassertio=
n fails.
--

commit 3d2b0c33735de6a173b91f3402a1d145ece0119d
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: rcar-gen4: Add Application/Local register reset control

This commit adds support for the Application/Local register reset control
for the R-Car Gen4 PCIe controller. It ensures the core reset is deasserted
after the core clock is enabled, and asserted on errors or shutdown to fix
a reinitialization failure when unbinding and rebinding the driver.

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

[Severity: High]
Should the return value of reset_control_deassert() be checked here?

If the deassertion fails (e.g., returning -ENOMEM or -EIO), the PCIe core
hardware block might remain in a reset state. The code then proceeds to
access hardware registers shortly after:

rcar_gen4_pcie_common_init() {
    ...
    val =3D readl(rcar->base + PCIEMSR0);
    ...
}

On ARM64 platforms like R-Car, attempting MMIO reads to a peripheral that is
held in reset typically triggers a synchronous external abort (SError),
resulting in an unrecoverable kernel panic.

Since device probing can be triggered interactively via sysfs as noted in
the commit message, an unhandled reset failure could turn a normal probing
error into a system crash.

Would it be safer to check this return value and jump to err_unprepare on
failure, similar to how DW_PCIE_PWR_RST is checked later in this function?

> +
>  	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
>  		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>  		/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903205153.2835=
53-1-marek.vasut+renesas@mailbox.org?part=3D3
