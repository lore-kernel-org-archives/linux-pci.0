Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30523AB5C3;
	Fri, 16 Oct 2026 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138510; cv=none; b=JDg0Vag80EW8jrdV97GQzDwq80H7vheFGLGxHHw+07LgLFIvaaqznnhFPOn0oKksyEkxrlMyP1b8wcAa08mBdXBb7bsLWXqIXNxSGplm6xOgKGJGnbb10T7V9gbYn184BWiXlGbqLCn3bOrmN5oZYoGbUi/cUzB7wgQQDDUXz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138510; c=relaxed/simple;
	bh=C781Q9Dpg4mhX4EJwmvCbFOVmZC/834VPOpP602oOSo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goaX2XY488yWvBowRON0dDNJ3QSLra6Sh6oL6njzJgS/0SOnAFPWmokuv/3FBA8FGUWQGIPVSc0N5dNgltNGbgh5Nd3WgiEOKx8Nw4AtA1A60Yg1jpMJg8AloKHafiMKYBBdhZ9Bp49Lwp0BnkjUxLrD1g+jSqA2UyXMk/oMtpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3HoR69N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3HoR69N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86FD1F000C4;
	Fri, 16 Oct 2026 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792138508;
	bh=7iX2LduCj2QBORGgOA5qAc9wAVGmHeDDqzdxNNO5lH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=P3HoR69NWQas+DSDi7cf+UPAc/WEcIr8qnViw6w0PzcvNZepHzdJvNz2bStuyxx6t
	 ZIg3/SSkaX4VQ5jbmMggkZkpWNjO8583q+TlmzsUb49+AAtzN5RM0OgYsu6uxeOT2C
	 nlxjaeYwV0F9tZsAqiyLkExhxgf8GufIPBKl7lslKQn0MEP1EQByfFlU5Ga9juaBot
	 khS4N2GMVR3+ZguhpKv1vv2vzWOLf6Ip4GSrPDruPs2R+v8giRDrxRH+MVFfUKDv4I
	 9eNcOVuhjnYaxRvnQA9xwztyokRksQJqf/XHRFBg3tcSiuFlSTo1NsyEyLjBklyASo
	 Ho01VSgi0k8Tg==
Subject: Re: [PATCH net-next v2 5/5] PCI: Create OF node for NXP ENETC
 pseudo-MAC functions
From: netdev-bot+sashiko@kernel.org
To: claudiu.manoil@nxp.com
Cc: netdev@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, linux-pci@vger.kernel.org, kuba@kernel.org
Date: Fri, 16 Oct 2026 08:15:07 +0000
Message-ID: <179213850739.434549.5377140925132800234@kernel.org>
In-Reply-To: =?utf-8?q?=3C2a24aaa96c6a0204e3ff293f2a1d22b58cf2171f=2E1791908?=
 =?utf-8?q?694=2Egit=2Eclaudiu=2Emanoil=40nxp=2Ecom=3E?=
References: =?utf-8?q?=3C2a24aaa96c6a0204e3ff293f2a1d22b58cf2171f=2E17919086?=
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On the in-tree arm64 defconfig, the ENETCv4 pseudo-MAC (PPM)
  ports this series adds still fail to probe.
- [Low] `enetc4_add_ppm_fixed_link()` and its teardown helper in
  drivers/net/ethernet/freescale/enetc/enetc4_pf.c call these changeset…

--

PCI: Create OF node for NXP ENETC pseudo-MAC functions

This patch registers of_pci_make_dev_node() as a final fixup for the two
ENETC4 PCI device IDs (0xe101 and 0xe110). The PCI core can then
synthesize an OF node for ENETCv4 pseudo-MAC ports that have no static
DT node. The ENETC4 driver needs that node so it can attach a fixed-link
child to it.

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

[Severity: Medium]
With the in-tree arm64 defconfig, will the pseudo-MAC ports on
S32N79-RDB still fail to probe?

When CONFIG_PCI_DYNAMIC_OF_NODES is not set, these fixups end up calling
the empty stub in drivers/pci/pci.h:

    static inline void of_pci_make_dev_node(struct pci_dev *pdev) { }

PCI_DYNAMIC_OF_NODES is a plain bool with no default, and nothing in the
tree selects it:

    config PCI_DYNAMIC_OF_NODES
    	bool "Create Device tree nodes for PCI devices"
    	depends on OF_IRQ
    	select OF_DYNAMIC

NXP_ENETC4 neither selects nor implies it. arch/arm64/configs/defconfig
does not set it, but it does set CONFIG_ARCH_S32=y and
CONFIG_NXP_ENETC4=m.

The series enables &netc_iep18 in s32n79-rdb.dts. The
netc_iep18: pcie@241200000 node in s32n79.dtsi has no child function
nodes, so on that config each PPM PF enumerates with no OF node.
enetc4_link_init() then calls enetc4_add_ppm_fixed_link(), which returns
early:

    if (!np)
    	return dev_err_probe(priv->dev, -ENODEV,
    			     "Missing of_node for Pseudo-MAC port\n");

The commit message notes that the quirk "only takes effect when
CONFIG_PCI_DYNAMIC_OF_NODES is enabled". The driver patch in this series
also deliberately avoids a hard Kconfig dependency.

Should the series also enable CONFIG_PCI_DYNAMIC_OF_NODES for this
board? That could be a defconfig update, or a select/imply that does not
break ports described by static DT.

[Severity: Low]
This one is in a related patch from the same series ("net: enetc: Add
pseudo-MAC support for ENETCv4 Ports via a fixed-link node"), which the
OF node created here is meant to serve. Can enetc4_pf.c fail to build
when CONFIG_OF_DYNAMIC is disabled?

enetc4_add_ppm_fixed_link() and its teardown helper call the changeset
API unconditionally:

    of_changeset_init(ocs);

    fixed_link = of_changeset_create_node(ocs, np, "fixed-link");

The same applies to of_changeset_add_prop_u32(),
of_changeset_add_prop_bool(), of_changeset_apply(),
of_changeset_revert() and of_changeset_destroy().

In include/linux/of.h, all of these are declared only under
#ifdef CONFIG_OF_DYNAMIC. The #else branch only stubs the of_reconfig_*
helpers.

OF_DYNAMIC has no default and is only enabled through select (for
example by OF_OVERLAY or PCI_DYNAMIC_OF_NODES). NXP_ENETC4 only depends
on PTP_1588_CLOCK_OPTIONAL and PCI_MSI, and NET_VENDOR_FREESCALE allows
COMPILE_TEST.

In that case, NXP_ENETC4=y/m with OF_DYNAMIC=n looks like a valid
config. Examples are arm64 ARCH_S32 with OF_OVERLAY=n, or a COMPILE_TEST
build with OF=n. Both would hit implicit declaration errors.

arm64 defconfig hides this because it sets CONFIG_OF_OVERLAY=y. No later
patch in the series seems to add a select OF_DYNAMIC or an IS_ENABLED()
guard.

Would a select OF_DYNAMIC on NXP_ENETC4, or an equivalent guard, be
needed here?

>  
>  /*
>   * Devices known to require a longer delay before first config space access

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1791908694.git.claudiu.manoil%40nxp.com
