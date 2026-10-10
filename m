Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AF24AA57E;
	Sat, 10 Oct 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791638043; cv=none; b=HFEfF3wo3xso9RgURKEFF84PGERH2lOp61fpLyj44nrDYmdanSs+sOVBeqJYX9vLHT5aa636Ea4SIL9a/Ai+JCE5xgAyluKbg2kqcFOu9FmwFA9of2v2QXPPeKxL82/SBqiKc16o4X0hkOvHUSxnUr3BZLknQB6PprC2a6ckJVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791638043; c=relaxed/simple;
	bh=J7GH/JN/ZX72ZdyYyBNAJyI91bJTaAegzQLGO9sf6G4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2tepglarjq4S9AKsJrJmMjN2tjOadhK1Ms9ufNeGO7GgfQ45ildQRA5AFcIE6KKEFDHHR4hYDS+DVngyI982isDeYawADugn9jhYnyYg5DOhJa8yqEXfs1DJYxrIirw1EUE21U1o0QtyuWNmCvvf7V0V8+JXhSID14f/XjHM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwakj9hR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwakj9hR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EECD1F000FF;
	Sat, 10 Oct 2026 13:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791638041;
	bh=sRqibyqwEH/XEkVldHbxa4bwXKyzmW+BdJMplLDzpA0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dwakj9hRnl0DbTqx09GNwSL+5STRFZtDxckteLNboG+yt7Q5wLzYeVQVlREJDTIMu
	 iXdyhIqt+XVQ0X7bg9lr1Nl6X1q/Oouuc20spwi1nvByEG1X2RUzv8u7gv0n0cXsFG
	 sMwSth99BTRiRwS1L3WNQfa6n6hfh0syLzvxdLoIMSIobYFOMnQu9pNT+Ar3GGpEJT
	 KALIiVfB0AifgwJ/b1MJ3qCtuvgib/NuI6ILlFBZRkv8cAgSg+XcAsESRCCNUJ4HFn
	 AdPu4FRDq4tiB3d7VniunYREMNqzLg+le0sIafczz0Z7o3qJjxY5qvLjk9byggqhJ8
	 N5vB5o4LryVYg==
Subject: Re: [PATCH net-next v1 5/5] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sat, 10 Oct 2026 13:14:00 +0000
Message-ID: <179163804057.434549.10568746991677094690@kernel.org>
In-Reply-To: =?utf-8?q?=3C2706e800774bb7e72992a8cc9d17ce7be039f046=2E1791548?=
 =?utf-8?q?316=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
References: =?utf-8?q?=3C2706e800774bb7e72992a8cc9d17ce7be039f046=2E17915483?=
 =?utf-8?q?16=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Overlay changeset leak when of_overlay_fdt_apply() fails in
  the pseudo-MAC probe path that this patch makes reachable.
- [Low] enetc4_link_init() assumes any OF_DYNAMIC node is 'an empty node
  created by the PCI core' by the quirk this patch adds.

--

PCI: Create OF node for NXP ENETC pseudo-MAC functions

This patch registers of_pci_make_dev_node() as a final PCI fixup for the
NXP ENETC4 device IDs 0xe101 and 0xe110. The PCI core then creates an OF
node for pseudo-MAC functions that have no static DT node. The ENETC4
driver applies a fixed-link overlay to that node.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index de9bbccda21fd..86f0a182224b2 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -6391,6 +6391,8 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REDHAT, 0x0005, of_pci_make_dev_node);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_EFAR, 0x9660, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe101, of_pci_make_dev_node);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PHILIPS, 0xe110, of_pci_make_dev_node);

[Severity: Low]
This quirk provides the node that enetc4_link_init() in
drivers/net/ethernet/freescale/enetc/enetc4_pf.c uses. Is OF_DYNAMIC
specific enough to identify that node?

drivers/net/ethernet/freescale/enetc/enetc4_pf.c:enetc4_link_init() {
	bool dynamic = node && of_node_check_flag(node, OF_DYNAMIC);
    ...
	/* Pseudo-MAC ENETCs are described by a runtime fixed-link overlay
	 * rather than static DT. This covers both a missing OF node and a
	 * PCI-synthesized (OF_DYNAMIC) node, which is an empty node created
	 * by the PCI core and thus carries no fixed-link description.
	 */
	if (enetc_is_pseudo_mac(priv->si) && (!node || dynamic)) {
		pf->if_mode = PHY_INTERFACE_MODE_INTERNAL;

		err = enetc4_apply_overlay(priv);
    ...
}

The node from of_pci_make_dev_node() is not empty. It is filled in by
of_pci_add_properties() and is tagged through np->data:

drivers/pci/of.c:of_pci_make_dev_node() {
    ...
	ret = of_pci_add_properties(pdev, cset, np);
    ...
	np->data = cset;
    ...
}

OF_DYNAMIC is also set on any node created by a runtime overlay or
of_changeset. Suppose a pseudo-MAC function's node comes from such an
overlay and already has phy-mode or fixed-link. Then of_get_phy_mode()
is skipped, PHY_INTERFACE_MODE_INTERNAL is forced, and the driver
applies its own overlay on top. If a fixed-link child already exists,
that overlay changes the existing node instead of adding a new one.

The stacked overlay would also block removal of the user's overlay while
the driver is bound.

Would a stricter check help here? For example, the driver could check
that no phy-mode or fixed-link is present, or it could recognise the
PCI-core changeset node. Also, the "empty node" wording in the comment
does not match what of_pci_make_dev_node() creates.

[Severity: Medium]
With this quirk, pseudo-MAC functions now reach the overlay apply path
in the ENETC4 driver. Can the overlay changeset leak there if
of_overlay_fdt_apply() fails?

drivers/net/ethernet/freescale/enetc/enetc4_pf.c:enetc4_apply_overlay() {
    ...
	err = of_overlay_fdt_apply(__dtbo_enetc4_pseudo_mac_begin, size,
				   &priv->ovcs_id, np);
	if (err)
		return dev_err_probe(priv->dev, err,
				     "Failed to apply fixed-link overlay\n");
    ...
}

If of_overlay_apply() fails in drivers/of/overlay.c, the changeset is
kept on purpose. of_overlay_fdt_apply() still sets *ret_ovcs_id, and its
documentation says the caller should call of_overlay_remove() with that
id. This covers resolve or init failures, PRE_APPLY or POST_APPLY
notifier errors, and -ENOMEM from build_changeset.

None of the callers removes the changeset:

enetc4_pf_netdev_create()
  enetc4_link_init()
    enetc4_apply_overlay()   <- returns err, priv->ovcs_id still set
    return err;              <- before err_mdiobus_create, so
                                enetc4_put_overlay() is skipped
  goto err_link_init;        <- skips enetc4_link_deinit()
  free_netdev(ndev);         <- frees priv and the only copy of ovcs_id

After this, the ovcs, its IDR entry, the copied FDT, the unflattened
overlay tree and the changeset node references can no longer be freed.
In the POST_APPLY failure case, the fixed-link node also stays attached
to the PCI function's node. This repeats on every failed bind attempt.

Should the error branch in enetc4_apply_overlay() call
enetc4_put_overlay(priv) before it returns?

>  
>  /*
>   * Devices known to require a longer delay before first config space access

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791548316.git.claudiu.manoil%40nxp.com
