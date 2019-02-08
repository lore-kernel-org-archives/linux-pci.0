Return-Path: <SRS0=vzDi=QP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC732C282C2
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 00:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BD921917
	for <linux-pci@archiver.kernel.org>; Fri,  8 Feb 2019 00:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549585655;
	bh=1Lqfhv5rLwnY5efCvLYfqgfoIXpcjI8TjLO+TpDKSTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e5Nx+R7Pw1dOTe9tQruBIj1pTWkvTvsiJh4eIPQQbRPdOwwsHv/dUKwLh5XAJUKsb
	 xW99eo/qaixdwNfG0mI4aN3S1hRbZon9HsFsx4LbeoaOGNpeXRrDQmKJPNv8Ld/U3F
	 4t4Up4JZc1E6Q2nH33YQr3nsjIpd/Mb0FKoheMvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfBHA1f (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfBHA1e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Feb 2019 19:27:34 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CD472073F;
        Fri,  8 Feb 2019 00:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549585653;
        bh=1Lqfhv5rLwnY5efCvLYfqgfoIXpcjI8TjLO+TpDKSTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uQq6r3m+hA3LcLT2T4ReAZz4Hsed4oZR0xi41i/+bZDf6wYuCUWw9YzqRv9cGZ8MP
         cNOobt4Vj87NHXJoE1JywxIUXJ0JfOL6TWu3QMpNMofs3PPUh5TisZ7F2nalsDwVTw
         dFBAnxiPiBHQpje3Tc3d+kzWql3DqEzCCj0HxjiQ=
Date:   Thu, 7 Feb 2019 18:27:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, Peter Wu <peter@lekensteyn.nl>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20190208002731.GS7268@google.com>
References: <20190131163856.50260-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131163856.50260-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 31, 2019 at 07:38:56PM +0300, Mika Westerberg wrote:
> Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
> connected to an Alpine Ridge Thunderbolt controller. This port has slot
> implemented bit set in the config space but other than that it is not
> hotplug capable in the sense we are expecting in Linux (it has
> dev->is_hotplug_bridge set to 0):
> 
> 00:1c.4 PCI bridge: Intel Corporation 200 Series PCH PCI Express Root Port #5
>         Bus: primary=00, secondary=05, subordinate=46, sec-latency=0
>         Memory behind bridge: 78000000-8fffffff [size=384M]
>         Prefetchable memory behind bridge: 00003800f8000000-00003800ffffffff [size=128M]
>         ...
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>         ...
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>                         Slot #8, PowerLimit 25.000W; Interlock- NoCompl+
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- LinkChg-
>                         Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet- Interlock-
>                         Changed: MRL- PresDet+ LinkState+
> 
> This system is using ACPI based hotplug to notify the OS that it needs
> to rescan the PCI bus (ACPI hotplug).
> 
> If there is nothing connected in any of the Thunderbolt ports the root
> port will not have any runtime PM active children and is thus
> automatically runtime suspended pretty soon after boot by PCI PM core.
> Now, when a device is connected the BIOS SMI handler responsible for
> enumerating newly added devices is not able to find anything because the
> port is in D3.
> 
> Prevent this from happening by blacklisting PCI power management of this
> particular Gigabyte system.

Since this is one of those issues we seem to have to discover
experimentally, I'd like to include a URL here to a kernel.org
bugzilla that has a dmesg log, "lspci -vvvnn" output, an acpidump, and
anything else that might be useful to extend or generalize this in the
future.  Maybe dmidecode output, too?

If somebody creates the bugzilla, I can add the URL; no need to repost
just for that.

> Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> Changes from v3:
> 
>   * Added #ifdef CONFIG_X86/#endif over DMI entry as suggested by Lukas.
> 
> v3: https://patchwork.kernel.org/patch/10778957/
> v2: https://patchwork.kernel.org/patch/10750549/
> v1: https://patchwork.kernel.org/patch/10711553/
> 
>  drivers/pci/pci.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c25acace7d91..7f5385badc1b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2501,6 +2501,25 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
>  		pm_runtime_put_sync(parent);
>  }
>  
> +static const struct dmi_system_id bridge_d3_blacklist[] = {
> +#ifdef CONFIG_X86
> +	{
> +		/*
> +		 * Gigabyte X299 root port is not marked as hotplug
> +		 * capable which allows Linux to power manage it.
> +		 * However, this confuses the BIOS SMI handler so don't
> +		 * power manage root ports on that system.
> +		 */
> +		.ident = "X299 DESIGNARE EX-CF",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co., Ltd."),
> +			DMI_MATCH(DMI_BOARD_NAME, "X299 DESIGNARE EX-CF"),
> +		},
> +	},
> +#endif
> +	{ }
> +};
> +
>  /**
>   * pci_bridge_d3_possible - Is it possible to put the bridge into D3
>   * @bridge: Bridge to check
> @@ -2546,6 +2565,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (bridge->is_hotplug_bridge)
>  			return false;
>  
> +		if (dmi_check_system(bridge_d3_blacklist))
> +			return false;
> +
>  		/*
>  		 * It should be safe to put PCIe ports from 2015 or newer
>  		 * to D3.
> -- 
> 2.20.1
> 
