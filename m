Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728E62EA47C
	for <linux-pci@vger.kernel.org>; Tue,  7 Jul 2026 08:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412744; cv=none; b=iJgwFziInpDEYRhqeP+P5Sn0tXJq1I4rpAILkTYPmLkJDm6xFexcyYpWwVOcrphTuJw6pP3G9yEuJunqfbuTsYNuotgUZvNTyM5wz5tXPvh7X6yFRCeHe/oTO98HGdggewmUEUmERq2kkijtCWpJturap0KTNKkKzydjteWWNpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412744; c=relaxed/simple;
	bh=Dx1MQblMv53JKQF+HCMyt+h3DC6Dbkc5ZB/MmctWWxc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=efotft4NKW1fPaVJ0z9fSmyf2ogJOobUE4BdyvESbgZeyvf6NHoNwsVA+6jeEtj4AaRYT0ujLSgid4bb/X7tmtxH7jSB25nqERG7mjYph5APJFJq8YIp6OWUSNfZNb39g61Zxa78TCd/NV86TqGqcdv/j8s2vMm3IZxZ9IHoELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAxZcapY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAxZcapY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096021F000E9;
	Tue,  7 Jul 2026 08:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783412743;
	bh=xiBlZWyj1X1iwTkqpL1rPt2wk1FDI2jxihmAXjagRXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KAxZcapYU9Ot9wsJGe+a2hgKtBvyzxIqHvQ5642ViG7omQ+SLrV3ZO+0unokyLjEg
	 quxK4nQ+K8/O7lkdPjcxm9S+/TKr8RKBhApcW+9TIoGTKqcI2p241T5UEsZ12erYDM
	 0Wbu0O8g68c5K8t0wW42opHR9VqR9Zkl0psjyC738JlBwXxH0uXDa/Wr+ycFJB229T
	 hakSeaYxGU3mup6imO4Vsq1OpKhiknzu5KJdRTMhGq+Oi/oy2sAMuEsaGuYZ5fKoPK
	 lQZCANEHSDGBtlhnf+5KSiltBRpt7aXIJ0n+013y1bIeOYDx8R3SHJrX0yr8Y8bHCB
	 /WujrJ4eg7SrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI/ASPM: Mask ASPM states based on Devicetree
 properties
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260707-aspm-v4-1-d66f85b728b0@oss.qualcomm.com>
References: <20260707-aspm-v4-1-d66f85b728b0@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 08:25:42 +0000
Message-Id: <20260707082543.096021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Modifying `link->aspm_enabled` prematurely prevents actual hardwar=
e reprogramming on multi-function devices.
- [High] Clearing `link->aspm_enabled` in the DT override bypasses `pcie_co=
nfig_aspm_link()`'s state update, leaving the PCI saved state stale.
--

--- Patch [1]: [PATCH v4] PCI/ASPM: Mask ASPM states based on Devicetree pr=
operties ---
commit 4caf5c21d07024c2e213a7a9879d47b07cc88588
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

PCI/ASPM: Mask ASPM states based on Devicetree properties

Some platforms require selectively disabling specific ASPM states on a given
PCIe link to avoid link instability. This patch introduces support for
devicetree properties like aspm-no-l0s, aspm-no-l1, and aspm-no-l1ss
to mask out unsupported ASPM states during default link state initializatio=
n.

Link [1]: https://github.com/devicetree-org/dt-schema/pull/188
Link [2]: https://github.com/devicetree-org/dt-schema/pull/190

> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 172783e7f519a..19f5582a910dc 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c

[ ... ]

> @@ -846,6 +889,36 @@ static void pcie_aspm_override_default_link_state(st=
ruct pcie_link_state *link)
> =20
>  	/* For devicetree platforms, enable L0s and L1 by default */
>  	if (of_have_populated_dt()) {
> +		bool no_l0s =3D pcie_link_has_aspm_override(link, "aspm-no-l0s");
> +		bool no_l1 =3D pcie_link_has_aspm_override(link, "aspm-no-l1");
> +		bool no_l1ss =3D pcie_link_has_aspm_override(link, "aspm-no-l1ss");
> +
> +		if (no_l0s) {
> +			link->aspm_support &=3D ~PCIE_LINK_STATE_L0S;
> +			link->aspm_default &=3D ~PCIE_LINK_STATE_L0S;
> +			link->aspm_enabled &=3D ~PCIE_LINK_STATE_L0S;

[Severity: High]
Does prematurely modifying link->aspm_enabled prevent actual hardware
reprogramming on multi-function devices?

If link->aspm_enabled is updated here, later when pcie_config_aspm_link() is
called, it might see that (link->aspm_enabled =3D=3D state) and return earl=
y:

drivers/pci/pcie/aspm.c:pcie_config_aspm_link() {
    if (link->aspm_enabled =3D=3D state)
        return;
    ...
    list_for_each_entry(child, &linkbus->devices, bus_list)
        pcie_config_aspm_dev(child, dwstream);
}

Will this early return skip the loop that programs the LNKCTL register for =
PCI
functions greater than 0, leaving them with firmware-enabled ASPM states th=
at
violate the Devicetree override?

> +		}
> +
> +		/*
> +		 * Clear L1SS in hardware before updating aspm_support. Once
> +		 * aspm_capable is derived from aspm_support, pcie_config_aspm_link()
> +		 * skips pcie_config_aspm_l1ss() entirely via the aspm_capable guard,
> +		 * leaving firmware-enabled L1SS substates active in hardware.
> +		 * This applies equally when disabling L1 (which implies L1SS).
> +		 */
> +		if ((no_l1 || no_l1ss) && (link->aspm_enabled & PCIE_LINK_STATE_L1SS))
> +			pcie_config_aspm_l1ss(link, 0);
> +
> +		if (no_l1) {
> +			link->aspm_support &=3D ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);
> +			link->aspm_default &=3D ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);
> +			link->aspm_enabled &=3D ~(PCIE_LINK_STATE_L1 | PCIE_LINK_STATE_L1SS);

[Severity: High]
Does returning early from pcie_config_aspm_link() also leave the PCI saved
state stale?

Because pcie_config_aspm_link() returns early when link->aspm_enabled match=
es
the requested state, it skips the saved state updates:

drivers/pci/pcie/aspm.c:pcie_config_aspm_link() {
    if (link->aspm_enabled =3D=3D state)
        return;
    ...
    pci_save_aspm_l1ss_state(link->downstream);
    pci_update_aspm_saved_state(link->downstream);
    pci_save_aspm_l1ss_state(parent);
    pci_update_aspm_saved_state(parent);
}

If the PCI saved state retains the firmware-enabled ASPM configuration, won=
't
pci_restore_state() write those stale states back to hardware upon resume f=
rom
suspend, FLR, or AER recovery, re-enabling the ASPM states that the
Devicetree override intended to disable?

> +		} else if (no_l1ss) {
> +			link->aspm_support &=3D ~PCIE_LINK_STATE_L1SS;
> +			link->aspm_default &=3D ~PCIE_LINK_STATE_L1SS;
> +			link->aspm_enabled &=3D ~PCIE_LINK_STATE_L1SS;
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-aspm-v4-1-=
d66f85b728b0@oss.qualcomm.com?part=3D1
