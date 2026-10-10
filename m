Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB5357D17;
	Sat, 10 Oct 2026 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791638039; cv=none; b=BkxjRPg+4B4vG7t4KGz2uuRuULR9RtMymOgQlPmjNEs6CtZxf2G5irnqq/66ENn0OE1uhqGoxYnSv8h7sqvkBRwPkg8IIvXGXOq/dVMGscmGTrKg795iy/Jn39NrJL/3JKCEyy1mueJpKvep51XuB97z0W35DEh/vDPjmB/E3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791638039; c=relaxed/simple;
	bh=7pBLBPAdNH3FGD/jtBPlALWXr3xTTHu3z53NWRJP4c4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lBNN9Swl43Fvnsm8P+MCLaH/f/4GOp9l9vAlqcmTftbhjERrCw9gyWdiTtRqqR9n5OgtF4o4fFphwAvu+R/DOzwe3YwQ+OtfDp18XpXsePThlO3wpMmWg4UlH42eCixxvMlU65JzjxCnjj2IpOq09YVhlEgWHkDlce27OP29f5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3Y4HurX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3Y4HurX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F201F000FF;
	Sat, 10 Oct 2026 13:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791638038;
	bh=iDhAThjPk28N8bwGOSRD/Cf/sRD6TaHQL/rrrDLIhl4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P3Y4HurXtuYiY7eqDaWpRPjJAvSH0EndXJ/Mxx6eqh8Z1vkrnkSqExnaDWqudkcAm
	 YVbqDwuHCneaW7Lx9eFyoozcjVuRCnvWSbcgc4E7vPnbFuai36ztCioDXsB8ip0AAB
	 bOFs7GP9jSMBxwsy9Gh76lVJq64JjJskNwXdgdbWFykcqDdgCtxbNpySyt3Dm/nrDL
	 48jBAONtRvrTuIrRaTjwRvtQhzssC4fip10833OlhaJY25cKYr1qP8yRPukC6xXabL
	 KrMdKg5NRN52txVbbZmLCbirfaaUDMv8e9dJDDx04BcjFCoGOMLWi+A9bqSzUd6jqz
	 GIss4rtZMGJtg==
Subject: Re: [PATCH net-next v1 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a DT overlay
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Sat, 10 Oct 2026 13:13:57 +0000
Message-ID: <179163803729.434549.9259246544327692524@kernel.org>
In-Reply-To: =?utf-8?q?=3C5c38f45b9ff1d73c6942d42e23940ecd9ab7b71f=2E1791548?=
 =?utf-8?q?316=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
References: =?utf-8?q?=3C5c38f45b9ff1d73c6942d42e23940ecd9ab7b71f=2E17915483?=
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

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On the new pseudo-MAC overlay path, the driver treats
  PCR[PSPEED] as the boot-time source of truth for link speed, but then…
- [Medium] enetc4_link_init() uses `of_node_check_flag(node, OF_DYNAMIC)`
  to mean "empty PCI-synthesized node with no fixed-link description",…
- [Medium] The overlay's `speed = <2500>` is documented as a placeholder
  (enetc4_pseudo_mac.dtso header, the enetc4_pl_get_fixed_state()…
- [Medium] When of_overlay_fdt_apply() fails, the partly applied overlay
  changeset is leaked.
- [Low] Not reported (baseline: discard).
- [Low] The comment above the __dtbo_enetc4_pseudo_mac_begin/_end externs
  in enetc4_pf.c says the blob is "created by cmd_wrap_S_dtb in…
- [Low] Not reported (baseline: discard).

--

net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a DT overlay

This adds support for ENETCv4 pseudo-MAC ports that have no static DT
description. The driver applies an embedded fixed-link DT overlay onto the
PCI function's dynamic OF node. A phylink get_fixed_state callback then
reports the link speed, which is read from PCR[PSPEED].

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 71c971618388b..7999355b5b9f5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c

[ ... ]

> @@ -12,6 +12,10 @@
>  
>  #define ENETC_SI_MAX_RING_NUM	8
>  
> +/* embedded overlay blob, created by cmd_wrap_S_dtb in scripts/Makefile.lib */

[Severity: Low]
This isn't a bug, but the comment points to the wrong file. At this
revision, cmd_wrap_S_dtb and the %.dtbo.S rule live in scripts/Makefile.dtbs,
and scripts/Makefile.lib does not contain them. The comment looks like it was
copied from drivers/misc/lan966x_pci.c.

> +extern char __dtbo_enetc4_pseudo_mac_begin[];
> +extern char __dtbo_enetc4_pseudo_mac_end[];
> +

[ ... ]

> +/* Pseudo-MAC ports have no real PHY; the link is fixed. The overlay puts
> + * phylink into fixed-link mode, but the operating speed is taken live from
> + * PCR[PSPEED] here rather than from the DT 'speed' cell.
> + */
> +static void enetc4_pl_get_fixed_state(struct phylink_config *config,
> +				      struct phylink_link_state *state)
> +{
> +	struct enetc_pf *pf = phylink_to_enetc_pf(config);
> +	int speed;
> +
> +	enetc4_get_pcr_speed(&pf->si->hw, &speed);
> +
> +	state->link = 1;
> +	state->an_complete = 1;
> +	state->duplex = DUPLEX_FULL;
> +	state->speed = enetc_phylink_match_pseudo_mac_speed(speed);

[Severity: Medium]
Can this rewrite the PCR[PSPEED] value that firmware programmed?

enetc_phylink_match_pseudo_mac_speed() rounds down to the nearest table
entry. phylink then passes the rounded speed to enetc4_pl_mac_link_up(). That
function calls enetc4_set_port_speed() without checking for a pseudo-MAC
port:

enetc4_set_port_speed() {
    ...
	if (speed == old_speed)
		return;

	val = enetc_port_rd(&priv->si->hw, ENETC4_PCR) & (~PCR_PSPEED);
	val |= PCR_PSPEED_VAL(speed);
	enetc_port_wr(&priv->si->hw, ENETC4_PCR, val);
	priv->speed = speed;
}

priv->speed starts at 0, so the first link-up always writes PCR. PCR_PSPEED
is a linear field in 10 Mbps units. If firmware or the switch owner set a
speed that is not in the table, such as 3000 or 40000 Mbps, it would be
overwritten with 2500 or 25000. Later get_fixed_state reads would then return
the rounded value, and the original setting stays lost until reset.

The commit message says the speed is "determined at boot time by the Port
PCR[PSPEED] register configuration". Should enetc4_set_port_speed() skip
pseudo-MAC ports here?

> +}
> +

[ ... ]

> +static int enetc4_apply_overlay(struct enetc_ndev_priv *priv)
> +{
> +	u32 size = __dtbo_enetc4_pseudo_mac_end - __dtbo_enetc4_pseudo_mac_begin;
> +	struct device_node *np = dev_of_node(priv->dev);
> +	int err;
> +
> +	if (!np)
> +		return dev_err_probe(priv->dev, -ENODEV,
> +				     "Missing of_node for Pseudo-MAC port\n");
> +
> +	err = of_overlay_fdt_apply(__dtbo_enetc4_pseudo_mac_begin, size,
> +				   &priv->ovcs_id, np);
> +	if (err)
> +		return dev_err_probe(priv->dev, err,
> +				     "Failed to apply fixed-link overlay\n");

[Severity: Medium]
Does this leak the overlay changeset when of_overlay_fdt_apply() fails?

of_overlay_fdt_apply() sets *ret_ovcs_id even when of_overlay_apply()
fails. Its kernel-doc says:

 * On error return, the changeset may be partially applied.  This is especially
 * likely if an OF_OVERLAY_POST_APPLY notifier returns an error.  In this case
 * the caller should call of_overlay_remove() with the value in *@ret_ovcs_id.

Here the error is returned without calling of_overlay_remove(). Then
enetc4_link_init() does a plain return err, which skips the
err_mdiobus_create label where enetc4_put_overlay() is called. Next,
enetc4_pf_netdev_create() jumps to err_link_init and calls free_netdev(),
which frees the only copy of priv->ovcs_id.

That would leak the overlay_changeset, its FDT copy, the unflattened tree and
the IDR slot. Any partly applied nodes would also stay under the PCI
function's OF node.

Could this failure path call enetc4_put_overlay(), or use goto
err_mdiobus_create in enetc4_link_init()?

> +
> +	return 0;
> +}
> +
>  static int enetc4_link_init(struct enetc_ndev_priv *priv,
>  			    struct device_node *node)
>  {
> +	bool dynamic = node && of_node_check_flag(node, OF_DYNAMIC);
>  	struct enetc_pf *pf = enetc_si_priv(priv->si);
>  	struct device *dev = priv->dev;
>  	int err;
>  
> -	err = of_get_phy_mode(node, &pf->if_mode);
> -	if (err) {
> -		dev_err(dev, "Failed to get PHY mode\n");
> -		return err;
> +	/* Pseudo-MAC ENETCs are described by a runtime fixed-link overlay
> +	 * rather than static DT. This covers both a missing OF node and a
> +	 * PCI-synthesized (OF_DYNAMIC) node, which is an empty node created
> +	 * by the PCI core and thus carries no fixed-link description.
> +	 */
> +	if (enetc_is_pseudo_mac(priv->si) && (!node || dynamic)) {

[Severity: Medium]
Does OF_DYNAMIC reliably mean the node has no link description?

The flag only records that the node was allocated at runtime. Nodes created
by any runtime overlay or changeset have it as well. A PCI-created node also
keeps it after another overlay adds phy-mode or fixed-link to it. The node
from of_pci_make_dev_node() is not empty either, because
of_pci_add_properties() adds reg, compatible, ranges and other properties.

Suppose a runtime overlay supplies a pseudo-MAC node with its own phy-mode
and fixed-link, or link-gpios. This branch would then:

- force phy-mode to INTERNAL
- merge the driver's dtbo over the existing fixed-link child, overwriting
  speed and full-duplex
- block removal of the earlier overlay, because node_overlaps_later_cs()
  would refuse it
- install get_fixed_state

phylink_get_fixed_state() checks the callback before the link GPIO:

	if (pl->config->get_fixed_state)
		pl->config->get_fixed_state(pl->config, state);
	else if (pl->link_gpio)
		state->link = !!gpiod_get_value_cansleep(pl->link_gpio);

So a configured link GPIO would never be read, and the link would always be
reported up. Before this patch, such nodes went through of_get_phy_mode() and
phylink's normal fixed-link handling.

Would it be better to check for an existing fixed-link child or phy-mode
property instead of OF_DYNAMIC?

> +		pf->if_mode = PHY_INTERFACE_MODE_INTERNAL;
> +
> +		err = enetc4_apply_overlay(priv);
> +		if (err)
> +			return err;
> +

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pseudo_mac.dtso b/drivers/net/ethernet/freescale/enetc/enetc4_pseudo_mac.dtso
> new file mode 100644
> index 0000000000000..e3d3e4259fbd4
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pseudo_mac.dtso

[ ... ]

> + * This overlay is applied by the ENETC4 PF driver onto the PCI function's own
> + * dynamic OF node (created by the PCI core when CONFIG_PCI_DYNAMIC_OF_NODES
> + * is enabled). The overlay only selects fixed-link mode and carries the duplex
> + * setting; the 'speed' property is a placeholder.

[ ... ]

> +		__overlay__ {
> +			fixed-link {
> +				speed = <2500>;

[Severity: Medium]
Is this speed value really just a placeholder?

phylink_parse_fixedlink() reads it into pl->link_config.speed and then does:

	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
			    pl->supported, true);

This limits pl->supported and link_config.lp_advertising to the 2500 Mbps
modes. enetc4_pl_get_fixed_state() later overrides only state->speed, duplex
and link.

phylink_ethtool_ksettings_get() copies pl->supported into its result but
takes the speed from phylink_get_fixed_state(). On a port whose PSPEED
decodes to 10000, ethtool would show Speed: 10000Mb/s while listing only
2500 Mbps modes as supported and as advertised by the link partner.

pl->link_config.speed is also used to validate ethtool -s requests in fixed
mode.

Are the "placeholder" descriptions accurate in this file, in the
enetc4_pl_get_fixed_state() comment and in the commit message?

> +				full-duplex;
> +			};
> +		};
> +	};
> +};

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791548316.git.claudiu.manoil%40nxp.com
