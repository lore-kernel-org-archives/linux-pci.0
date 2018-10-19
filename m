Return-Path: <SRS0=b7f5=M7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AD6ECDE43
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 18:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F80521476
	for <linux-pci@archiver.kernel.org>; Fri, 19 Oct 2018 18:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T5bqeL5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F80521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeJTCZf (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 19 Oct 2018 22:25:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37134 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeJTCZf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Oct 2018 22:25:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so16829980pfi.4
        for <linux-pci@vger.kernel.org>; Fri, 19 Oct 2018 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=nmeckNFphp/x15aPxZY+QfLLPrluX8Ha3iNeceCHXR0=;
        b=T5bqeL5LfyW6P8gqFxda7vnjy6IAxOqPyFkv0PgB5x/+Qu7ZfuV3o3xTckTa9V7j2G
         jF6wwHddEDCK+1JLYoYg+udap+i4lWOA7klTDzmnGkfnebOjG6We5MAhTvm4VzVmdePH
         6sarJYOZ8BnDIJT2GW5ap+HewSnzP1LQlRMh7GPPw2cvXoUxFpVkksIJQeiWfeaRGduz
         pW1ZEIF133SYZFttuxW+RPkYBReeIujsNcqMSIcSjQzKB9uYQLjCOKDcISJojMpPuzi3
         dOegDod43mpUiqUfB7mi34SZ7/GlljCYAAd/pL+U9XYwz5ycYIivUIjWqeoics9ga0LT
         W8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=nmeckNFphp/x15aPxZY+QfLLPrluX8Ha3iNeceCHXR0=;
        b=nXS9UOOimFOev7J99uCRALu4JGP6dNjHgNk07egE/7Kb4GFvNawdYH4jHfWxPTpEzZ
         TFWenhjvvO2AQe94r+Cjv381HAOIMLufzTDVTV0VNLKILdy4XPl1VduPGrSeqTSRBK5J
         rWgO3+bOgwFsJS+lacnA/rpTlzWnyHTmFr7gC3bS+dJaHz5m4gsYzVhAcd/V2QtvXfPE
         hMLjQBAoBHxzZ5ktoSZtPts2/6rtq1kZ02AGt1cqgPoDe1kbnaw7e03MNE+xZNkgsd2y
         XrvwITxWZB/qoZUnBjBg4B2n+cNlUgl7jRvCrssNEeryALBPDlsZ3o1U63AU5slvID8X
         i/kw==
X-Gm-Message-State: ABuFfohlAHhSIm4JrJIDXLEHWvXq4kC0leUUQgVnUhnaQTVBICkgpsBZ
        wN4IfBE9hXbl56N/PsRWLL3yrQ==
X-Google-Smtp-Source: ACcGV60hu30sK8WGsyOOmc9OyGfiaulMhF1Tfiwp1vHNedYePnQLmlk7+2KpKHMdD2AVMwNv7Bt44A==
X-Received: by 2002:a63:3c46:: with SMTP id i6-v6mr33222663pgn.286.1539973103049;
        Fri, 19 Oct 2018 11:18:23 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e3-v6sm31153305pgc.71.2018.10.19.11.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 11:18:22 -0700 (PDT)
Date:   Fri, 19 Oct 2018 11:18:22 -0700 (PDT)
X-Google-Original-Date: Fri, 19 Oct 2018 11:11:52 PDT (-0700)
Subject:     Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
In-Reply-To: <20181019120952.32763-7-hch@lst.de>
CC:     yamada.masahiro@socionext.com, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, linux@dominikbrodowski.net,
        linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-153e4e0b-8fe9-4712-849f-f01455ef56f4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Oct 2018 05:09:49 PDT (-0700), Christoph Hellwig wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAVE_PCI symbol that indicates availability
> of PCI support and the handle the rest in drivers/pci.
>
> Note that for powerpc we now select HAVE_PCI globally instead of the
> convoluted mess of conditional or or non-conditional support per board,
> similar to what we do e.g. on x86.  For alpha PCI is selected for the
> non-jensen configs as it was the default before, and a lot of code does
> not compile without PCI enabled.  On other architectures with limited
> PCI support that wasn't as complicated I've left the selection as-is.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

...

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a344980287a5..071952cd4cae 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -39,8 +39,10 @@ config RISCV
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_PCI
>  	select MODULES_USE_ELF_RELA if MODULES
>  	select THREAD_INFO_IN_TASK
> +	select PCI_MSI if PCI
>  	select RISCV_TIMER
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select ARCH_HAS_PTE_SPECIAL
> @@ -216,28 +218,12 @@ source "kernel/Kconfig.hz"
>
>  endmenu
>
> -menu "Bus support"
> -
> -config PCI
> -	bool "PCI support"
> -	select PCI_MSI
> -	help
> -	  This feature enables support for PCI bus system. If you say Y
> -	  here, the kernel will include drivers and infrastructure code
> -	  to support PCI bus devices.
> -
> -	  If you don't know what to do here, say Y.
> -
>  config PCI_DOMAINS
>  	def_bool PCI
>
>  config PCI_DOMAINS_GENERIC
>  	def_bool PCI
>
> -source "drivers/pci/Kconfig"
> -
> -endmenu
> -
>  menu "Power management options"
>
>  source kernel/power/Kconfig

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I'm assuming this will go in via PCI tree of some sort, so I'm not going to 
touch it any further.

Thanks for cleaning this up!
