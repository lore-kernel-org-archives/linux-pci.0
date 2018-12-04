Return-Path: <SRS0=uO3t=ON=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58689C04EB8
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 20:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD962081C
	for <linux-pci@archiver.kernel.org>; Tue,  4 Dec 2018 20:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD962081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbeLDUkw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:40:52 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39955 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeLDUkw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Dec 2018 15:40:52 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id D8355300002BC;
        Tue,  4 Dec 2018 21:40:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 9805F593B; Tue,  4 Dec 2018 21:40:49 +0100 (CET)
Date:   Tue, 4 Dec 2018 21:40:49 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20181204204049.4zr7onei267t4pic@wunner.de>
References: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204112048.35378-1-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
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
> ---
> I checked booting Windows on the same system and it does not put any of the
> PCIe root ports to low power states so there is no issue in Windows. I'm
> also quite certain Windows does not have similar blacklist.
> 
> I wonder if our pci_bridge_d3_possible() heuristics would need to be
> refined somehow? At least if this blacklist starts growing.

We do blacklist such non-native hotplug ports, but of course only if
the Hot-Plug Capable bit is set:

	/*
	 * Hotplug ports handled by firmware in System Management Mode
	 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
	 */
	if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
		return false;

I guess your question boils down to, is there any better way to recognize
ports which are handled by the platform firmware?  Does acpiphp bind to
this port?

Thanks,

Lukas
