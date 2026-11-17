Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930910;
	b=imszlhoDj/KothxeCgadM1zgSjj9grO+2qDcMd2Dg0u756aHWtKmTaJKDSnkUMYBQK2g
	 JaWd3mPQoUdAXHnrxAaFWazNkUDVpyswxSUtvOgyE4B1vIOpC6IqXhNTmi3i/3SIRxb1w
	 1KtME+xspXOdy8fvXxGuoDAhlmpSbkEoGi+L+wn6Jq9cwNJm2djgiTN0R6BvWusoz5cQF
	 /dzhdzTcLmmpB0XtwzujbsSlM2XoQi+RaEzHDAp9GIdEaHRzMAS9bqbkl3g/2lq/D5Rj1
	 DVzGwEAjbdaoSU1QEzZYXUQBJELeKZD+J58CIriiB2TnEXBO355nZlh2QdeBkFbltKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930910;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=NSDZg4lKM868mCut1hwt7C3QqlV1RrLkhZMnguyo28U=;
	b=0PS3n44rohu7SceaRiFDZXsYNxbIuYUU5GYh2FbVntgF3XoqAd8Vtyzn6WLVlwK+iwpH
	 DK9DKizFOungeD+JQSxpqDN1rGdeuWgDNr3dvLgk+LFy7verJQ+M8qyL2SEvVwTJPLBQQ
	 LuFVcZZJ/3mSuPhSd3HUd+xE5QWhulc6qbGRnFKnFhkJrJKjzGS3kqDOuk+MG00YlWwwX
	 b3zUlFuJ4akciGzn8J4JuCMLXKnVFxA+TpbK+6yz8jgdSvYOUHiSPCxDWdkupVm6gnfBm
	 7uXQd9KZGaVKRqdQgDnqHqJSTb0bYuV4rLevPVab/pFxWBEOrewRxELrb57LaOuFe+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9KBOrt9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ECC606A32A;
	Tue, 17 Nov 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9KBOrt9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357A31F000C4;
	Tue, 17 Nov 2026 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930910;
	bh=NSDZg4lKM868mCut1hwt7C3QqlV1RrLkhZMnguyo28U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D9KBOrt9FdSPa1Ftoriduv0s4TgMLwyPNGunXkoILi6TBoRlQqcW0Ta4lMr7ZCCUg
	 qqvsWgr24YKRJnrQ1k+M5IT6kaAz2oeACYSbQnZKLDUcrSxA0ERfynQ/i6XX7JIO4C
	 Ox1SBS4HCYglJte94wlb8Ntt/4g+WHu2afr513Fd8Ui7m3X2T4hL2n6wO4iQoyt5Xf
	 ErU1oI+pzQ8QTkqOGUemF+aWLpAbItAfzBmv+5580O26Wfbv/9A/ipvdkWFRRfId1N
	 eNr6VbptqtVQ+BSGYDIlB0XpElQUBmmRkKAl4eh2dkJPbkD8Dm1QQGuKQ5jcqCcpr7
	 9cp5wVQMbXS1A==
Subject: Re: [PATCH net-next v4 1/6] net: enetc: Add pseudo-MAC support for
 ENETCv4 Ports via a fixed-link node
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org
Date: Tue, 17 Nov 2026 15:55:09 +0000
Message-ID: <179493090971.3136.9721533094333369940@kernel.org>
In-Reply-To: <4f51bfd237fa584c7d9187d7b82f36e261853ea3.1794581338.git.claudiu.manoil@nxp.com>
References: <4f51bfd237fa584c7d9187d7b82f36e261853ea3.1794581338.git.claudiu.manoil@nxp.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In enetc4_link_init()
  (drivers/net/ethernet/freescale/enetc/enetc4_pf.c:1025-1047), the…
- [Low] In drivers/net/ethernet/freescale/enetc/enetc4_pf.c,
  enetc4_link_init() (lines 1035-1047) only builds the pseudo-MAC fixed-…
- [Low] enetc4_add_ppm_fixed_link()
  (drivers/net/ethernet/freescale/enetc/enetc4_pf.c:996) writes a…

--

net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link node

This lets ENETCv4 pseudo-MAC ports probe without a static DT "ethernet"
node. At probe time an of_changeset adds a "fixed-link" child node whose
speed is read from PCR[PSPEED]. The pseudo-MAC path runs when the port has
no OF node or only an OF_DYNAMIC node, and the changeset is reverted on
teardown and on the probe error unwind.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> index 71c971618388b..b7e7201e6a71a 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c

[ ... ]

> +static int enetc4_add_ppm_fixed_link(struct enetc_pf *pf,
> +				     struct device_node *np)
> +{
> +	struct device_node *fixed_link;
> +	struct of_changeset *ocs;
> +	int speed, err;
> +
> +	enetc4_get_pcr_speed(&pf->si->hw, &speed);
> +	speed = enetc_phylink_match_pseudo_mac_speed(speed);
> +

[ ... ]

> +	fixed_link = of_changeset_create_node(ocs, np, "fixed-link");
> +	if (!fixed_link) {
> +		err = -ENOMEM;
> +		goto err_destroy;
> +	}
> +
> +	err = of_changeset_add_prop_u32(ocs, fixed_link, "speed", speed);

[Severity: Low]
This isn't a bug, but can this write a speed value that the fixed-link
binding doesn't allow?

enetc_phylink_pseudo_mac_caps[] in enetc_pf_common.c includes SPEED_25000
and SPEED_20000. When PCR[PSPEED] maps to 20000 Mbps or more,
enetc_phylink_match_pseudo_mac_speed() returns 20000 or 25000.

In Documentation/devicetree/bindings/net/ethernet-controller.yaml, the
fixed-link speed property only allows:

    enum: [10, 100, 1000, 2500, 5000, 10000]

phylink still accepts these values. But the node is built at runtime, so
dt-schema never checks it.

Should the binding be extended (as was done for 5000)? Or should the
driver stick to the speeds the binding lists?

> +	if (err)
> +		goto err_put_node;

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

[Severity: Low]
Is this comment accurate?

The PCI-synthesized node isn't empty. of_pci_make_dev_node() fills it in
through of_pci_add_properties() (compatible, reg, ...) before it applies
the changeset. The only accurate part is that it has no fixed-link child.

The branch also doesn't really cover a missing OF node. That case just
returns -ENODEV below.

Related to this: at this commit, the PCI core doesn't create a node for an
ENETC endpoint function. pci_bus_add_device() only does it for bridges:

    if (pci_is_bridge(dev))
        of_pci_make_dev_node(dev);

drivers/pci/quirks.c has no ENETC entries either. So a pseudo-MAC port
without a node always hits the "Missing of_node for Pseudo-MAC port" error
here.

A later patch in the series, "PCI: Create OF node for NXP ENETC pseudo-MAC
functions", fixes that. It adds DECLARE_PCI_FIXUP_FINAL() entries for
PCI_VENDOR_ID_PHILIPS device IDs 0xe101 and 0xe110 that call
of_pci_make_dev_node(). With the whole series applied, only the comment
wording is left.

> +	if (enetc_is_pseudo_mac(priv->si) && (!node || dynamic)) {
> +		pf->if_mode = PHY_INTERFACE_MODE_INTERNAL;

[Severity: Medium]
Is the OF_DYNAMIC flag enough to show that the node has no link
description?

__of_node_dup() sets OF_DYNAMIC, and DT overlays create their nodes with
it in add_changeset_node(). An overlay can also be applied on top of the
node from of_pci_make_dev_node() to add phy-mode or fixed-link.

In either case, this branch:

- skips of_get_phy_mode()
- forces PHY_INTERFACE_MODE_INTERNAL
- calls enetc4_add_ppm_fixed_link(), which calls
  of_changeset_create_node(ocs, np, "fixed-link") without checking for an
  existing fixed-link child

__of_attach_node() puts the new node at the head of the child list:

    np->sibling = np->parent->child;
    np->parent->child = np;

phylink_parse_fixedlink() looks the node up with
fwnode_get_named_child_node(), so it would find the driver-synthesized
fixed-link before the DT one.

Would that leave two fixed-link children and replace the DT-provided speed
with the PCR[PSPEED] value?

The commit message says:

    The pseudo-MAC path is selected when the port has no OF node, or when it
    only has the empty PCI-synthesized node (OF_DYNAMIC), which carries no
    fixed-link description.

Nothing in the code checks that, though. Would a check such as
of_get_child_by_name(node, "fixed-link") or
of_property_present(node, "phy-mode") make the code match the
description?

> +
> +		if (!node) {
> +			dev_err(dev, "Missing of_node for Pseudo-MAC port\n");
> +			return -ENODEV;
> +		}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794581338.git.claudiu.manoil%40nxp.com
