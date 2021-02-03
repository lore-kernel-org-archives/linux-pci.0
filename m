Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB51FC433E0
	for <linux-pci@archiver.kernel.org>; Wed,  3 Feb 2021 22:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB9E64F67
	for <linux-pci@archiver.kernel.org>; Wed,  3 Feb 2021 22:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbhBCW1s (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Feb 2021 17:27:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:54404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhBCW1r (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 17:27:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8072364F60;
        Wed,  3 Feb 2021 22:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612391227;
        bh=1OjCvlZW5TaEzpDVRBEta9g2ySXHUupUZ9vlLNUcZZo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdGfmSDhc7Fwh4RK5NuQ95sO/+6XZ1zKBkr0dhnuZPJ0CtMnFmxbIpKBi8cuCUC1z
         Yt8jidwBbN8X2MbOPa/DcVPJYI4NJTFOfJFMcZ6TE+C+0JLgvmrfBlaTAcVL2jQrNA
         Z5EaAyNcIZDxeaj+jjL0OxxI+8/l1SCWX3fM2OPI=
Date:   Wed, 3 Feb 2021 23:27:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND v4 3/6] misc: Add Synopsys DesignWare xData IP driver to
 Kconfig
Message-ID: <YBsjOAb545+Swz/T@kroah.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
 <81f95c6ff0faaf8cbb56430320abb76af772a339.1612390291.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f95c6ff0faaf8cbb56430320abb76af772a339.1612390291.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 11:12:48PM +0100, Gustavo Pimentel wrote:
> Add Synopsys DesignWare xData IP driver to Kconfig.
> 
> This driver enables/disables the PCIe traffic generator module
> pertain to the Synopsys DesignWare prototype.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Why isn't this, and patch 2, part of patch 1?  Why split this out?

thanks,

greg k-h
