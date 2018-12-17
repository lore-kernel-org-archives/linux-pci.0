Return-Path: <SRS0=7Kzx=O2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BDEC43387
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 20:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F9F21848
	for <linux-pci@archiver.kernel.org>; Mon, 17 Dec 2018 20:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545078511;
	bh=3Y40BjRDV23ndSs/iS+0hmvoWXR9Tlsw8Fvp4uJBOr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xm8he/b25UwFAWf5y9idxQJSz6qZpJQ5bpI+FXhZHrmjZq7qHvtIE+XFxHA4JX8ct
	 FrH1CvYYrGB8kupTxiaEZ67tLfr/XzYsm2LtkNmfBpoobQAm436ZFqnx/vU9LSZhDg
	 xd/F2TFXnpBXaMtUNhg8q6iTjGlmOLPqO16ftsEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389183AbeLQU2a (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:28:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbeLQU2a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Dec 2018 15:28:30 -0500
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D012133F;
        Mon, 17 Dec 2018 20:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545078508;
        bh=3Y40BjRDV23ndSs/iS+0hmvoWXR9Tlsw8Fvp4uJBOr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oo7mv3qzNC/MRNAB+RJPVLha10WucycYOrU8kRCS15dTxRfllLSMnzuQR55RKA/9+
         +NFq/PTCzHCWZoUNNIyjkt/MX55ujHo3W2nBXoMvB3gDviVtxGBHl61aYz8fLKZnrC
         AfZcV8bJoEZhgwPrYtCvMfC2IQ74fLuQkppGTyhI=
Date:   Mon, 17 Dec 2018 14:28:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181217202827.GC28981@google.com>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 04, 2018 at 02:20:48PM +0300, Mika Westerberg wrote:
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

Ugh.  I don't see how this is a maintainable solution.  Are we going
to have to just update this blacklist empirically as we get reports of
systems that are "broken"?

I say "broken" because I don't think we can point to anything here
that doesn't conform to the specs, so maybe we tripped over something
that *should* be covered in the spec, or maybe we're just not
interpreting something correctly.

For example, it looks like PCI_EXP_FLAGS_SLOT is set, but Linux
basically ignores it.  Maybe if PCI_EXP_FLAGS_SLOT is set but we
aren't using pciehp, we should assume any hotplug would be handled via
acpiphp?  And in that case, we should avoid doing anything that would
prevent platform firmware from enumerating things below the bridge?

> Prevent this from happening by blacklisting PCI power management of this
> particular Gigabyte system.
> 
> Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>

Is there a bugzilla or any other URL we could include here to help with
future changes in this area?

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> I checked booting Windows on the same system and it does not put any of the
> PCIe root ports to low power states so there is no issue in Windows. I'm
> also quite certain Windows does not have similar blacklist.
> 
> I wonder if our pci_bridge_d3_possible() heuristics would need to be
> refined somehow? At least if this blacklist starts growing.
> 
>  drivers/pci/pci.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c9d8e3c837de..1c6e47522c84 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2501,6 +2501,23 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
>  		pm_runtime_put_sync(parent);
>  }
>  
> +static const struct dmi_system_id bridge_d3_blacklist[] = {
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
> +	{ }
> +};
> +
>  /**
>   * pci_bridge_d3_possible - Is it possible to put the bridge into D3
>   * @bridge: Bridge to check
> @@ -2546,6 +2563,9 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
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
> 2.19.2
> 
