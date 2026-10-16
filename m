Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067A377EAC;
	Fri, 16 Oct 2026 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138507; cv=none; b=qd6dmiASNAoYVGsk9GRKyOwf7IZY0ymY3TZtw6tK2OWZBRouY8VDJSeB2fo3Mwy+GEhuE12ARYdw2aMcvIhJxc00e4JK5P/DV9yvCkUJcHqURBLcJ4jY4EcKqeIJUTG78XqPto21RfQEUYCJwZUD/bS+LvGkwWLC3/xhCTw+01k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138507; c=relaxed/simple;
	bh=dHL2K4hZcbv3gpJ0meEra9CDkE5P8NpYUDndTG6l2s8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tdJvVS+io6D775GtmbOPgBS1iVuAsUdas5kz2zSw6wfAgprZcJL07ACdD2vxBn1EIKRe8Fm/OgQxopjANPfIYq0OjkAE3m7gpJG2wtRAYEULtuAWPTQeM6309JmUgIh3zjhlglumXsKgg92Qt2f3XD37aml1mbCZMoigd7SqEWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=in/+l1kq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="in/+l1kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5681F000C4;
	Fri, 16 Oct 2026 08:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792138505;
	bh=WhJQShRZnAAN8bJPhh/C1URcM7H1xauzce/dmuhwcd4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=in/+l1kqD9B55xfTvz+qShZqoytkdmfyNuIzyYA8TWW88Z57BimZF6kPi0hoBnjGD
	 6+uOD50bj4dgVffX/BI8O/KmKsztgmT4Uv6woQZ8EmMuWiDGRD+IHXT/49/wXIHbjb
	 p+jwdxjO4c/baFS93cStqA+LFEyMV82b4ls8xXV4g0OW4C//MDnEvrFe68qyJ0FXce
	 gxQ9+vq/i8T+qCetUde1kAe+MO/Y28IXr1vZvPuo0Kds60eZn/O1SNh8T7RFfjTVgB
	 FLRs5fgHHd1YSdCq9UZMGJd9AFkkljdFMr2PrPBl4FGxYU2mmUt4VugT9VqpzBDTsI
	 07cRrNsJTq7Pg==
Subject: Re: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, kuba@kernel.org
Date: Fri, 16 Oct 2026 08:15:04 +0000
Message-ID: <179213850452.434549.17833070545168867976@kernel.org>
In-Reply-To: =?utf-8?q?=3Cd7b51cb29758538a4c68a700dd8cd41b6e7e08b6=2E1791908?=
 =?utf-8?q?694=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
References: =?utf-8?q?=3Cd7b51cb29758538a4c68a700dd8cd41b6e7e08b6=2E17919086?=
 =?utf-8?q?94=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Build break when CONFIG_OF_DYNAMIC=n.
- [Medium] enetc4_link_init() uses the OF_DYNAMIC flag alone to decide
  that a pseudo-MAC port's node is 'an empty node created by the PCI…
- [Medium] The pseudo-MAC fixed-link speed is the boot-time PCR[PSPEED]
  rounded down to a phylink-supported value, and the existing link-up…
- [Low] enetc4_add_ppm_fixed_link() can write 20000 or 25000 into the
  synthesized node's fixed-link 'speed' property.

--

net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link node

This commit lets ENETCv4 pseudo-MAC ports probe when they have no static
DT description. At probe time it uses an of_changeset to add a
fixed-link child node to the port's OF node, with the speed taken from
PCR[PSPEED], so that phylink can pick it up. The changeset is reverted
and destroyed on teardown and on the probe error path.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 71c971618388b..70e34ca6ddf8e 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c

[ ... ]

> @@ -946,23 +955,112 @@ static void enetc4_pci_remove(void *data)

[ ... ]

> +static int enetc4_add_ppm_fixed_link(struct enetc_ndev_priv *priv)
> +{
> +	struct device_node *np = dev_of_node(priv->dev);
> +	struct device_node *fixed_link;
> +	struct of_changeset *ocs;
> +	int speed, err;
> +
> +	if (!np)
> +		return dev_err_probe(priv->dev, -ENODEV,
> +				     "Missing of_node for Pseudo-MAC port\n");
> +
> +	enetc4_get_pcr_speed(&priv->si->hw, &speed);
> +	speed = enetc_phylink_match_pseudo_mac_speed(speed);

[Severity: Medium]
Does this rounding end up overwriting the boot-time PCR[PSPEED] value?

enetc4_get_pcr_speed() decodes PSPEED as (pspeed + 1) * 10, so the
result can be any multiple of 10 Mbps. enetc_phylink_match_pseudo_mac_speed()
then rounds down to the first table entry that is <= that value, with no
warning. For example, 4000 becomes 2500 and 40000 becomes 25000.

The rounded value goes into the fixed-link "speed" property. On link-up,
phylink passes it to enetc4_pl_mac_link_up(), which has no pseudo-MAC
check:

enetc4_pl_mac_link_up()
    enetc4_set_port_speed(priv, speed);

priv->speed starts at 0, so the first call always does a read-modify-write
of ENETC4_PCR with PCR_PSPEED_VAL(rounded speed).

Suppose the switch owner programmed a PSPEED that is not in the table.
Wouldn't the driver replace it with a lower rate? priv->speed is used by
enetc_qos.c for the CBS port_transmit_rate. Wouldn't it also stop
matching the real internal link?

This seems to conflict with the commit message statement that "the fixed
link reflects the actual boot-time configuration". I could not confirm
whether firmware actually programs rates outside the table.

> +
> +	ocs = kzalloc_obj(*ocs);
> +	if (!ocs)
> +		return -ENOMEM;
> +
> +	of_changeset_init(ocs);

[Severity: Medium]
Will this build when CONFIG_OF_DYNAMIC is not set?

This function calls of_changeset_init(), of_changeset_create_node(),
of_changeset_add_prop_u32(), of_changeset_add_prop_bool() and
of_changeset_apply(). enetc4_put_ppm_fixed_link() also calls
of_changeset_revert() and of_changeset_destroy(). All of these are
declared in include/linux/of.h only under #ifdef CONFIG_OF_DYNAMIC.

The #else branch only has stubs for the of_reconfig_* helpers.
drivers/of/dynamic.c is also only built with OF_DYNAMIC=y.

config NXP_ENETC4 only depends on PTP_1588_CLOCK_OPTIONAL and PCI_MSI.
OF_DYNAMIC is a hidden symbol that is only enabled when something
selects it (OF_OVERLAY, PCI_DYNAMIC_OF_NODES, ...).

With NXP_ENETC4=y/m and OF_DYNAMIC=n, wouldn't the build fail? I'd
expect implicit declaration errors first, then undefined symbols at
modpost or link time. That includes CONFIG_OF=n builds through
COMPILE_TEST.

The commit message says:

  This is intentionally not a hard Kconfig dependency, since the ENETC4
  driver also serves regular ports described by static DT; when
  PCI_DYNAMIC_OF_NODES is absent the PCI function has no of_node and the
  pseudo-MAC probe path fails gracefully with a clear -ENODEV error.

If nothing selects OF_DYNAMIC, the driver would not build at all, so it
never gets to the -ENODEV path. Should NXP_ENETC4 select or depend on
OF_DYNAMIC, or should these calls be guarded?

> +
> +	fixed_link = of_changeset_create_node(ocs, np, "fixed-link");
> +	if (!fixed_link) {
> +		err = -ENOMEM;
> +		goto err_destroy;
> +	}
> +
> +	err = of_changeset_add_prop_u32(ocs, fixed_link, "speed", speed);

[Severity: Low]
This isn't a functional bug, but can this write a speed that the
fixed-link binding doesn't allow?

enetc_phylink_pseudo_mac_caps[] includes SPEED_25000 and SPEED_20000. For
PSPEED >= 20 Gbps, enetc_phylink_match_pseudo_mac_speed() returns 20000
or 25000.

For the object form of fixed-link, the "speed" property in
Documentation/devicetree/bindings/net/ethernet-controller.yaml only
allows:

  enum: [10, 100, 1000, 2500, 5000, 10000]

The commit message says the node is added "exactly as if it had come
from static DT". A static DT describing this port the same way would
fail dtschema validation. phylink_parse_fixedlink() accepts these speeds
at runtime, so nothing breaks.

Should the binding be extended to 20000 and 25000, or should the driver
avoid emitting them?

[ ... ]

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
> +	/* Pseudo-MAC ENETCs are described by a runtime-synthesized fixed-link
> +	 * node rather than static DT. This covers both a missing OF node and a
> +	 * PCI-synthesized (OF_DYNAMIC) node, which is an empty node created
> +	 * by the PCI core and thus carries no fixed-link description.
> +	 */
> +	if (enetc_is_pseudo_mac(priv->si) && (!node || dynamic)) {
> +		pf->if_mode = PHY_INTERFACE_MODE_INTERNAL;

[Severity: Medium]
Can OF_DYNAMIC be relied on to mean the node has no link description?

OF_DYNAMIC only records that a node was allocated at runtime.
__of_node_dup() sets it on every runtime-created node. That includes
nodes created by the overlay engine (add_changeset_node()->__of_node_dup())
and PCI-synthesized nodes that a later overlay fills in. The
PCI-synthesized node is not empty either, since it has compatible and
reg.

Take an OF_DYNAMIC pseudo-MAC node that already has phy-mode and a
fixed-link child. This path skips of_get_phy_mode() and forces
PHY_INTERFACE_MODE_INTERNAL. enetc4_add_ppm_fixed_link() then adds a
second child named "fixed-link" without checking for an existing one.

__of_attach_node() inserts the new node at the head of the parent's
child list:

	np->sibling = np->parent->child;
	np->parent->child = np;

So phylink_parse_fixedlink()->fwnode_get_named_child_node(fwnode,
"fixed-link") would find the synthesized node first. Wouldn't the
overlay's speed, pause, asym-pause and link-gpios be silently ignored?
The tree would also end up with two sibling nodes of the same name.

Before this patch, such a node went through of_get_phy_mode() and its
own fixed-link was used. Would a check based on the node's contents (no
phy-mode, no phy-handle, and !of_phy_is_fixed_link()) match the intent
in the comment better than the flag?

I couldn't find in-tree code that applies such an overlay to an ENETC
node today, so this may be theoretical for now.

> +
> +		err = enetc4_add_ppm_fixed_link(priv);
> +		if (err)
> +			return err;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791908694.git.claudiu.manoil%40nxp.com
