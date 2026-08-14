Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062F3D5642
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786739653; cv=none; b=WqCG/waSCdFC3bTnZj/dnVl3927f6wi07hESLEF3P/cTSrV4vaapVdOojWKK6bk2NCidRmg2uBv/JHXAIfFJ4hdkW8WgjrlMnRmkdfJz+mhGy0MATwZEbRIfSQztrlsqBWFP0EYsWtWXvPeHr7LaRAdTWsSGi+yHgGSwVKFYdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786739653; c=relaxed/simple;
	bh=6iZTovpaup83717W4St0hB82Av61xDVEXKa2vq9jTdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fCzB2cuhtSiaKXUvihqKfOWdYwO3Zcs/aApLgMVoOxN/tT0ytvN1cBLAXYpQVSbVyjcLi2TWxgsTkbzLY4lrQGUg+tBR+pNy0OUnRQOgEhdc19SyZTZatNkgpMFNbGGbSqlhQLeqDIFO++6mRLSHCI4QG8lBSJ8A3bwJkEWBycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqrf0nzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqrf0nzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AFE51F000E9;
	Fri, 14 Aug 2026 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786739652;
	bh=61ijt7mpkUJWfE8/uyjYET6ziwS8iLTByb7fJfNbh40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqrf0nzck8mv0XPfkxSwcs5EjW2jhaBiBSqnsDHaSk/HwijXAwW7S4H6d1R1tho3L
	 hkIEtS+2UIv1i6m9D2MTp0PGNvzU6tnas5R8Iy+ypsnOopTcRa2wWAMAp12oCWyk75
	 B3Y8f7sxPcOmAVPgkRCdkl9oEi1HqXe8+8qnSiQ6wR1a3oHauG7hY5aRGT7sLotHDk
	 LC4ooVdE9a/8QO2DL46fWuGGcg3dhbktnMoc+rZJ/E1JMyIBVpdYXchDOMXnHaA1Gs
	 FLEp0daPmzN69hsZUv8URaz3P+wUs8dgbsiuQ2/KasV5yckKW4eDRqOZb/vHNDBt3x
	 dbRfSye9d0tAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 5/5] PCI: pciehp: Clear stale 14-Bit Tag Requester
 Enable on hot add
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vidya Sagar" <vidyas@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814201621.2281245-6-vidyas@nvidia.com>
References: <20260814201621.2281245-1-vidyas@nvidia.com>
 <20260814201621.2281245-6-vidyas@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 20:34:11 +0000
Message-Id: <20260814203412.0AFE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent lockless updates to bitfields `bus->flit_mode`, `dev->f=
m_enabled`, and neighboring flags can cause silent data corruption.
--

--- Patch [5]: [PATCH V3 5/5] PCI: pciehp: Clear stale 14-Bit Tag Requester=
 Enable on hot add ---
commit c3e9cc0a2fb59bb295c18b992a944ec4dd73a497
Author: Vidya Sagar <vidyas@nvidia.com>

PCI: pciehp: Clear stale 14-Bit Tag Requester Enable on hot add

This commit addresses an issue where a hot swap changing the link mode
leaves a stale 14-Bit Tag Requester Enable on a Downstream Port. It refresh=
es
the port's tag before the first config read to ensure completions can be
matched and the device enumerates properly.

> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pcieh=
p_hpc.c
> index 4c62140a3cb44..95f9d5abdec2f 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -302,6 +302,14 @@ int pciehp_check_link_status(struct controller *ctrl)
>  	if (ctrl->inband_presence_disabled)
>  		pcie_wait_for_presence(pdev);
> =20
> +	/*
> +	 * The link is up, but a newly inserted card may have trained it in a
> +	 * different mode than the card that was removed left it in.  Drop a
> +	 * now stale 14-Bit Tag Requester Enable on the Port before the first
> +	 * config read below, which the Port issues as the requester.
> +	 */
> +	pci_bridge_refresh_14bit_tag(pdev);

[Severity: High]
Does calling pci_bridge_refresh_14bit_tag() here introduce a data race with
other bitfield updates?

Inside pci_bridge_refresh_14bit_tag() and its helper=20
__pci_dev_clear_stale_14bit_tag(), there are lockless bitfield updates on l=
ive
devices:

drivers/pci/pci.c:__pci_dev_clear_stale_14bit_tag() {
    ...
    dev->fm_enabled =3D !!(dev3_sta & PCI_DEV3_STA_SEGMENT);
    ...
}

and

drivers/pci/pci.c:pci_bridge_refresh_14bit_tag() {
    ...
    bus->flit_mode =3D flit_now;
    ...
}

In C, bitfield assignments compile to read-modify-write operations on the
underlying memory word. The dev->fm_enabled flag shares a 32-bit word with
critical flags like dev->state_saved and dev->is_msi_managed.

If the read-modify-write cycle of fm_enabled overlaps with another flag upd=
ate
(like power management setting dev->state_saved =3D true, or driver teardown
updating dev->is_msi_managed), one of the updates can be lost.

Losing state_saved =3D true causes pci_restore_state() to silently skip res=
toring
device config space on resume. Losing is_msi_managed =3D true can cause dev=
res
double-frees.

Additionally, bus->flit_mode shares a word with bus->unsafe_warn, which cou=
ld
be concurrently updated via sysfs (e.g. pci_generic_config_write32).

Is it possible to add locking or change these bitfields to avoid the
read-modify-write races during link events?

> +
>  	found =3D pci_bus_check_dev(ctrl->pcie->port->subordinate,
>  					PCI_DEVFN(0, 0));
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814201621.2281=
245-1-vidyas@nvidia.com?part=3D5
