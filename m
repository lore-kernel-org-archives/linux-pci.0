Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57428188596
	for <linux-pci@vger.kernel.org>; Tue, 12 May 2026 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546785; cv=none; b=VeIWDT5VOD5Ff6NyNNOPi17n9YRRkfJBYmhXqR2BD2wdLtQME8Qjvqy4AWjpbUb0vd37xDt/XO3pH8tp8ctOltBPySRr/p7JFtOgP6fCdoXcOVy2TCfexbX8VE5XMSXx5ZL16cZGMUucbL6glRPQHVzf9Shyx0e/5ssSZUgLe8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546785; c=relaxed/simple;
	bh=jKnne6m8czSI6RbrKq62WPQhY/TFhfbjcXMlvDX2aDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hq0DsAn5e2aBx1D+43uWcKaeWCGWkDssjnl34TYVerUTJ47Pt2jJONNp4wh5l+ok5E0CxbDrfBoAMMnACO93BsnciHbHtDtyTFyAH0P+d3BY9nTMaoCEempG6uwQv9fHfoim9fUdlO51eWcUvf2WWUSIDX7dfL/Rw15LRaTgY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fz6pqo63; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fz6pqo63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82F7C2BCB0;
	Tue, 12 May 2026 00:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778546784;
	bh=jKnne6m8czSI6RbrKq62WPQhY/TFhfbjcXMlvDX2aDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=fz6pqo63Ez0A4BsC9bCj3a60U7OyKiC9i4dcppA3ZUTVRTPtXN2jQxbnLZjHdki8p
	 U+WzfMT3171C660IkUQOVx0gbaZW3tMZljQxf2T8SbfxMrUhawSTkM5pAoZPPf3N0D
	 NIJQcsRfApu7xNgEEnFDAiGeHH2L3CV4fIso2yuGbrQJM2cVLAB5iXzGzUY+irz+Up
	 d9Me7BDXJjMQ9UOgMtu+TAkTluulcCSRmcm02OM97X3BBHoJ+dfCPMQ2YtTNQKXIdy
	 o+pU6fWVFrBQepymtKw25EOzBz+soRMtUy81PU9Y2Rx67poNhNqhCh42H0450xSqkZ
	 K/BAjYczEWHOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Reply-To: sashiko@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com>
References: <20260511-aspm-v1-1-b4a9fe955cf9@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 May 2026 00:46:24 +0000
Message-Id: <20260512004624.B82F7C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Modifying `link->aspm_support` bypasses `pcie_config_aspm_l1ss()`,=
 failing to disable ASPM L1 Substates in hardware if the bootloader previou=
sly enabled them.
- [Medium] The `aspm-no-l1` override only masks `PCIE_LINK_STATE_L1` from `=
link->aspm_support`, failing to mask the functionally dependent L1 PM Subst=
ates (`PCIE_LINK_STATE_L1SS`), leading to sysfs inconsistency.
--

commit 3739505256d4ced724de1faf6f3f111a9994fa59
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI/ASPM: Mask ASPM states based on Devicetree properties

This commit updates ASPM link initialization to check for aspm-no-l0s,
aspm-no-l1, and aspm-no-l1ss Devicetree properties. It masks the
corresponding ASPM states from link->aspm_support before applying the
default ASPM policy.

Link: https://github.com/devicetree-org/dt-schema/pull/188
Link: https://github.com/devicetree-org/dt-schema/pull/190

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 925373b98dff0..3111ef7fd226e 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

> @@ -806,6 +813,15 @@ static void pcie_aspm_override_default_link_state(st=
ruct pcie_link_state *link)
> =20
>  	/* For devicetree platforms, enable L0s and L1 by default */
>  	if (of_have_populated_dt()) {
> +		if (pcie_link_has_aspm_override(link, "aspm-no-l0s"))
> +			link->aspm_support &=3D ~PCIE_LINK_STATE_L0S;
> +
> +		if (pcie_link_has_aspm_override(link, "aspm-no-l1"))
> +			link->aspm_support &=3D ~PCIE_LINK_STATE_L1;

Should this also clear PCIE_LINK_STATE_L1SS?

If we clear only PCIE_LINK_STATE_L1, link->aspm_capable will retain the
L1SS bits while dropping the L1 bit. The sysfs visibility check in
aspm_ctrl_attrs_are_visible() relies on aspm_capable, which means the main
L1 control attribute will be hidden, but the L1.1 and L1.2 substate
attributes will be incorrectly exposed.

Any userspace attempts to enable these exposed L1SS attributes via sysfs
will silently fail, as pcie_config_aspm_link() enforces:

if (!(state & PCIE_LINK_STATE_L1))
        state &=3D ~PCIE_LINK_STATE_L1SS;

> +
> +		if (pcie_link_has_aspm_override(link, "aspm-no-l1ss"))
> +			link->aspm_support &=3D ~PCIE_LINK_STATE_L1SS;

Will modifying link->aspm_support here bypass disabling ASPM L1 Substates
in hardware if the bootloader previously enabled them?

By clearing bits from link->aspm_support, the changes propagate to
link->aspm_capable. Later, when the kernel applies the ASPM policy in
pcie_config_aspm_link(), the hardware update for L1SS is guarded by:

if (link->aspm_capable & PCIE_LINK_STATE_L1SS)

Because the capability bit was cleared by the DT override, the kernel skips
calling pcie_config_aspm_l1ss() entirely, leaving the hardware actively
using L1SS if the firmware or bootloader had enabled it.

Would setting bits in link->aspm_disable instead (similar to
pci_disable_link_state()) correctly disable these states in hardware
while keeping aspm_capable intact?

> +
>  		if (link->aspm_support & PCIE_LINK_STATE_L0S)
>  			link->aspm_default |=3D PCIE_LINK_STATE_L0S;
>  		if (link->aspm_support & PCIE_LINK_STATE_L1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511-aspm-v1-1-=
b4a9fe955cf9@oss.qualcomm.com?part=3D1
