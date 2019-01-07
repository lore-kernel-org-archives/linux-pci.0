Return-Path: <SRS0=70A0=PP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FC8C43387
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E252089F
	for <linux-pci@archiver.kernel.org>; Mon,  7 Jan 2019 13:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866810;
	bh=rQtsAov2XKflsGBmQT3/O2we5qTIcIRo8+0mOuoWrbY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=umxGMNfticm2xeYwH18DsNF0bheiqOjnVYkKXQDULdHxlgDmLJFaPTxpaHnjkmgUa
	 lhcO2T/rl4ji4NFrovdKqlpMynGwKsCbalEojuHN9anILAkLCubE2CJVZVJIzyEsKd
	 X+aCVEJQzYXJNKLUXisKvIgRcHT0egjqxWWPISdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbfAGNN1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:13:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42751 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfAGNN1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jan 2019 08:13:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id w13so229250oiw.9;
        Mon, 07 Jan 2019 05:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDTTwulV5RYEF9kVzyxWDsgN/esS14by7n9kp6a8+N8=;
        b=VnpL8js88OytZTyIveGPTCwMoY3Rn/vJPcqZyjmLX0wE4ZQVcTnLNWFytpnoWG0Pxo
         lYa0llPbcd2hDhHjECeBAJzysG+URtYPY5ms9OExEPurgGZa2iSJ3QBxUUptogzFUO4d
         fSeSn6qpBzH7TGtWZN2a5fB55rKObRWTEhiSMhn7fFdyWqKihbMFtb7R/AjYdXH+2z8p
         +LfZxy/mZjPfPdssk507HIvYOiGRRX/pML3+GpLO8+k7vvausA0GPoPovTDucAGtSkLI
         fSNDQq/HTM4/Y0D96qncM6jnEtRx4AZVuUiB/gjJBwwC3R66rr5Ck6F2oMleY8ZDU7Da
         uopQ==
X-Gm-Message-State: AA+aEWbOs5eDBn4huk7rvXTveFtLkYcgTTwJf1byRsxgdIKrb2kUmH2X
        zKgsZimcOIBfUtRag5tRStREjO51b9hlrRVcYhI=
X-Google-Smtp-Source: ALg8bN6rfU9JpVzz07uAS6rtpligZDDkHn4NqgE23xd1rT7WXlkoPa5zNaOzoYP/OlZ7JkmRc9vf4UkqKZSd18V7Jts=
X-Received: by 2002:aca:3d42:: with SMTP id k63mr42573636oia.95.1546866805929;
 Mon, 07 Jan 2019 05:13:25 -0800 (PST)
MIME-Version: 1.0
References: <20190107130152.83350-1-mika.westerberg@linux.intel.com>
In-Reply-To: <20190107130152.83350-1-mika.westerberg@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jan 2019 14:13:14 +0100
Message-ID: <CAJZ5v0iJfUK6FDQ=W6=2+wEG2GHKDT5r_aoRapUn4Qi0FTjaGg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Block power management of certain ports with slot
 implemented bit set
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 7, 2019 at 2:01 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Gigabyte X299 DESIGNARE EX motherboard has one PCIe root port that is
> connected to Alpine Ridge Thunderbolt controller. This port has slot
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
> If there is nothing connected to any of the Thunderbolt ports the root
> port will not have any runtime PM active children and is thus
> automatically runtime suspended pretty soon after boot by PCI PM core.
> Now, when a device is connected the BIOS SMI handler responsible for
> enumerating newly added devices is not able to find anything because the
> port is in D3.
>
> For this reason we block power management of PCIe root and downstream
> ports that have slot implemented set and have node in ACPI namespace.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202031
> Reported-by: Kedar A Dongre <kedar.a.dongre@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> Changes from v1:
>
>  - Block PM for all root and downstream ports with slot implemented bit set
>    and has an ACPI companion.
>
> The previous version can be found here:
>
>   https://patchwork.kernel.org/patch/10711553/
>
>  drivers/pci/pci.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c9d8e3c837de..04bdbcf1dfb7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2510,10 +2510,14 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
>   */
>  bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  {
> +       int type;
> +
>         if (!pci_is_pcie(bridge))
>                 return false;
>
> -       switch (pci_pcie_type(bridge)) {
> +       type = pci_pcie_type(bridge);
> +
> +       switch (type) {
>         case PCI_EXP_TYPE_ROOT_PORT:
>         case PCI_EXP_TYPE_UPSTREAM:
>         case PCI_EXP_TYPE_DOWNSTREAM:
> @@ -2546,6 +2550,18 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>                 if (bridge->is_hotplug_bridge)
>                         return false;
>
> +               /*
> +                * Some systems such as Gigabyte X299 the root port is
> +                * not marked hotplug capable but ACPI based hotplug is
> +                * still used to bring in the Thunderbolt controller. To
> +                * make sure those ports do not enter D3 and possibly
> +                * confuse the BIOS SMI handler, block D3 for them.
> +                */
> +               if (has_acpi_companion(&bridge->dev) &&
> +                   type != PCI_EXP_TYPE_UPSTREAM &&
> +                   pcie_caps_reg(bridge) & PCI_EXP_FLAGS_SLOT)
> +                       return false;
> +
>                 /*
>                  * It should be safe to put PCIe ports from 2015 or newer
>                  * to D3.
> --
> 2.19.2
>
