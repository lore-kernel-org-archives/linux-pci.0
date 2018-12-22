Return-Path: <SRS0=4uNc=O7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B26C43387
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 16:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B67021B8C
	for <linux-pci@archiver.kernel.org>; Sat, 22 Dec 2018 16:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbeLVQsj (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:48:39 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:59057 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731648AbeLVQsj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Dec 2018 11:48:39 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 2658A3000088B;
        Sat, 22 Dec 2018 17:40:14 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id DD0551D37BD; Sat, 22 Dec 2018 17:40:13 +0100 (CET)
Date:   Sat, 22 Dec 2018 17:40:13 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        linux-acpi@vger.kernel.org, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 03/11] vga-switcheroo: make PCI dependency explicit
Message-ID: <20181222164013.2l7etklpxjrrobnm@wunner.de>
References: <20181222090720.19234-1-okaya@kernel.org>
 <20181222090720.19234-4-okaya@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222090720.19234-4-okaya@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Dec 22, 2018 at 09:07:12AM +0000, Sinan Kaya wrote:
> This driver depends on the PCI infrastructure but the dependency has not
> been explicitly called out.
> 
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

This series doesn't have a cover letter so it's unclear to me through
which tree it's supposed to go in?  Each patch through the individual
subsystem tree or all through the same tree?  If the former I guess I
could push this to drm-misc...

Thanks,

Lukas

> ---
>  drivers/gpu/vga/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
> index b677e5d524e6..d5f1d8e1c6f8 100644
> --- a/drivers/gpu/vga/Kconfig
> +++ b/drivers/gpu/vga/Kconfig
> @@ -21,6 +21,7 @@ config VGA_SWITCHEROO
>  	bool "Laptop Hybrid Graphics - GPU switching support"
>  	depends on X86
>  	depends on ACPI
> +	depends on PCI
>  	select VGA_ARB
>  	help
>  	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
> -- 
> 2.19.0
