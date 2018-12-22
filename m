Return-Path: <SRS0=4uNc=O7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E6FC43387
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 17:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02A30219D6
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 17:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732740AbeLVR2j (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:28:39 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:40969 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbeLVR2j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Dec 2018 12:28:39 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 5D6C630000CC2;
        Sat, 22 Dec 2018 09:03:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 328BBEB941; Sat, 22 Dec 2018 09:03:17 +0100 (CET)
Date:   Sat, 22 Dec 2018 09:03:17 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 06/11] platform/x86: apple-gmux: hide PCI specific code
Message-ID: <20181222080317.qicyihyauia6n63w@wunner.de>
References: <20181222001452.7474-1-okaya@kernel.org>
 <20181222001452.7474-7-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222001452.7474-7-okaya@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 22, 2018 at 12:14:47AM +0000, Sinan Kaya wrote:
> Code is scanning PCI bus to find out if it is switchable or not. If
> CONFIG_PCI is not set, assume unswitchable.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/apple-gmux.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index fd2ffebc868f..b552b54bf58b 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -742,8 +742,12 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  	 * If Thunderbolt is present, the external DP port is not fully
>  	 * switchable. Force its AUX channel to the discrete GPU.
>  	 */
> +#ifdef CONFIG_PCI
>  	gmux_data->external_switchable =
>  		!bus_for_each_dev(&pci_bus_type, NULL, NULL, is_thunderbolt);
> +#else
> +	gmux_data->external_switchable = false;
> +#endif
>  	if (!gmux_data->external_switchable)
>  		gmux_write8(gmux_data, GMUX_PORT_SWITCH_EXTERNAL, 3);

This driver is only used on 2008+ MacBook Pros and the 2013+ Mac Pro,
all of which have PCI and are pretty much unusable with CONFIG_PCI=n.

So it is okay to just add "depends on PCI" for this driver, as you did
with other drivers, and I think that's preferrable to an #ifdef.

You can also drop the "platform/x86: " prefix from the subject if you
like, all previous commits to this driver just use "apple-gmux: ".

If you are okay with these changes, feel free to add my Reviewed-by
when respinning.

Thanks,

Lukas
