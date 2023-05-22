Return-Path: <linux-pci-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5604C7EE26
	for <linux-pci@archiver.kernel.org>; Mon, 22 May 2023 13:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjEVNJf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 22 May 2023 09:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjEVNJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 May 2023 09:09:34 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9F549E;
        Mon, 22 May 2023 06:09:32 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 147F092009C; Mon, 22 May 2023 15:09:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1093692009B;
        Mon, 22 May 2023 14:09:31 +0100 (BST)
Date:   Mon, 22 May 2023 14:09:30 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH v5 30/44] rtc: add HAS_IOPORT dependencies
In-Reply-To: <20230522105049.1467313-31-schnelle@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.2305221314480.27887@angie.orcam.me.uk>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com> <20230522105049.1467313-31-schnelle@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 May 2023, Niklas Schnelle wrote:

> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 753872408615..a38a919b3f15 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -956,6 +956,7 @@ comment "Platform RTC drivers"
>  config RTC_DRV_CMOS
>  	tristate "PC-style 'CMOS'"
>  	depends on X86 || ARM || PPC || MIPS || SPARC64
> +	depends on HAS_IOPORT || MACH_DECSTATION
>  	default y if X86
>  	select RTC_MC146818_LIB
>  	help

 For the DECstation part:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

  Maciej
