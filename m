Return-Path: <SRS0=Zwnb=M5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9D9ECDE30
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 09:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6728D21526
	for <linux-pci@archiver.kernel.org>; Wed, 17 Oct 2018 09:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6728D21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbeJQR2b (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:28:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:47269 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeJQR2b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Oct 2018 13:28:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9H9Aheb019037;
        Wed, 17 Oct 2018 04:10:44 -0500
Message-ID: <33a2232671caa008541f8de542f8e7a27ab88248.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/8] powerpc: remove CONFIG_PCI_QSPAN
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Date:   Wed, 17 Oct 2018 20:10:42 +1100
In-Reply-To: <20181017080201.10866-3-hch@lst.de>
References: <20181017080201.10866-1-hch@lst.de>
         <20181017080201.10866-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2018-10-17 at 10:01 +0200, Christoph Hellwig wrote:
> This option isn't actually used anywhere.

Oh my, that's ancient. Probably didn't make the cut from arch/ppc to
arch/powerpc

> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/Kconfig | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a80669209155..e8c8970248bc 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -955,7 +955,6 @@ config PCI
>  	bool "PCI support" if PPC_PCI_CHOICE
>  	default y if !40x && !CPM2 && !PPC_8xx && !PPC_83xx \
>  		&& !PPC_85xx && !PPC_86xx && !GAMECUBE_COMMON
> -	default PCI_QSPAN if PPC_8xx
>  	select GENERIC_PCI_IOMAP
>  	help
>  	  Find out whether your system includes a PCI bus. PCI is the name of
> @@ -969,14 +968,6 @@ config PCI_DOMAINS
>  config PCI_SYSCALL
>  	def_bool PCI
>  
> -config PCI_QSPAN
> -	bool "QSpan PCI"
> -	depends on PPC_8xx
> -	select PPC_I8259
> -	help
> -	  Say Y here if you have a system based on a Motorola 8xx-series
> -	  embedded processor with a QSPAN PCI interface, otherwise say N.
> -
>  config PCI_8260
>  	bool
>  	depends on PCI && 8260

