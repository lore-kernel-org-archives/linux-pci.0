Return-Path: <SRS0=Sdll=QA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B649AC282C3
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E9921855
	for <linux-pci@archiver.kernel.org>; Thu, 24 Jan 2019 13:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfAXNZo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:25:44 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:39359 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfAXNZo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jan 2019 08:25:44 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 768A31002A009;
        Thu, 24 Jan 2019 14:25:42 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 34489AEC6; Thu, 24 Jan 2019 14:25:42 +0100 (CET)
Date:   Thu, 24 Jan 2019 14:25:42 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kedar A Dongre <kedar.a.dongre@intel.com>,
        Peter Wu <peter@lekensteyn.nl>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Blacklist power management of Gigabyte X299
 DESIGNARE EX PCIe ports
Message-ID: <20190124132542.wqofwg7bswnn5g3j@wunner.de>
References: <20190124131227.45612-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124131227.45612-1-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 24, 2019 at 04:12:27PM +0300, Mika Westerberg wrote:
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

Unfortunately this doesn't take my comment voiced Jan 8 into account:

   "Please constrain either the blacklist entry for the Gigabyte mainboard
    or the blacklist check itself to x86 using IS_ENABLED() or #ifdef to
    avoid code bloat on other arches."
    https://patchwork.kernel.org/patch/10750549/#22408911

Note that CONFIG_DMI may be enabled on arm64 and ia64 which have no use
for this quirk.  It's generally undesirable to have arch-specific quirks
in generic code and folks running Linux on memory-constrained mips routers
have complained before that quirks.c contains too much code unrelated to
their arch.

Thanks,

Lukas
