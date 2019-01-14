Return-Path: <SRS0=hqs4=PW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8A6C43387
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 23:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F3120657
	for <linux-pci@archiver.kernel.org>; Mon, 14 Jan 2019 23:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547507079;
	bh=Bmk2lqWpwsD+tggpMwOUSXkWTZW7+liEP4R9/AuuIPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JSw/+nNp8k/qPh/KDSuVmdtQN4GkLTio357WEMInj1Dp3HbWWbZMowewxuUQR8Jzd
	 MEOHBpI7p6cy9ZIk4YVTVYy+QEQMfpEtfrYvP7A02K7tdFqVvvmO9loWaOrB/+fENR
	 c+AlpDGvmdin/MBKhtSxKOjUF0UtIVZFfyG+Af/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfANXEc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:04:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbfANXEZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Jan 2019 18:04:25 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4EB20657;
        Mon, 14 Jan 2019 23:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547507064;
        bh=Bmk2lqWpwsD+tggpMwOUSXkWTZW7+liEP4R9/AuuIPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=unXL13xLDwTIcjSjDOd5012t6h/c7ULvuqWOY1N4E4TmKd4Pf3Mi6k/kffVbMkxNL
         r3E/v5t1PkDu9DD9z8eHnFJrh+8QcNKBp0MR2z23QTWcXHLyMLziz0NxnsA6UB8bT7
         rZM5uPv6HDpXHdg+4AXWDL4sthmsTdzr27BU1GrI=
Date:   Mon, 14 Jan 2019 17:04:21 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix PCI kconfig menu organization
Message-ID: <20190114230421.GC33971@google.com>
References: <20190114213546.9921-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190114213546.9921-1-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 14, 2019 at 03:35:46PM -0600, Rob Herring wrote:
> After commit eb01d42a7778 ("PCI: consolidate PCI config entry in
> drivers/pci"), all the PCI kconfig options appear below "PCI support"
> rather than within a sub-menu. This is because menuconfig expects all
> kconfig entries to be enclosed in an if/endif section. Add the missing
> if/endif.
> 
> With this, "depends on PCI" is redundant in the sub-menu  entries and
> can be removed.
> 
> Fixes: eb01d42a7778 ("PCI: consolidate PCI config entry in drivers/pci")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied to for-linus for v5.0, thanks!

> ---
>  drivers/pci/Kconfig | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 4310c7a4212e..2ab92409210a 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -21,13 +21,14 @@ menuconfig PCI
>  	  support for PCI-X and the foundations for PCI Express support.
>  	  Say 'Y' here unless you know what you are doing.
>  
> +if PCI
> +
>  config PCI_DOMAINS
>  	bool
>  	depends on PCI
>  
>  config PCI_DOMAINS_GENERIC
>  	bool
> -	depends on PCI
>  	select PCI_DOMAINS
>  
>  config PCI_SYSCALL
> @@ -37,7 +38,6 @@ source "drivers/pci/pcie/Kconfig"
>  
>  config PCI_MSI
>  	bool "Message Signaled Interrupts (MSI and MSI-X)"
> -	depends on PCI
>  	select GENERIC_MSI_IRQ
>  	help
>  	   This allows device drivers to enable MSI (Message Signaled
> @@ -59,7 +59,6 @@ config PCI_MSI_IRQ_DOMAIN
>  config PCI_QUIRKS
>  	default y
>  	bool "Enable PCI quirk workarounds" if EXPERT
> -	depends on PCI
>  	help
>  	  This enables workarounds for various PCI chipset bugs/quirks.
>  	  Disable this only if your target machine is unaffected by PCI
> @@ -67,7 +66,7 @@ config PCI_QUIRKS
>  
>  config PCI_DEBUG
>  	bool "PCI Debugging"
> -	depends on PCI && DEBUG_KERNEL
> +	depends on DEBUG_KERNEL
>  	help
>  	  Say Y here if you want the PCI core to produce a bunch of debug
>  	  messages to the system log.  Select this if you are having a
> @@ -77,7 +76,6 @@ config PCI_DEBUG
>  
>  config PCI_REALLOC_ENABLE_AUTO
>  	bool "Enable PCI resource re-allocation detection"
> -	depends on PCI
>  	depends on PCI_IOV
>  	help
>  	  Say Y here if you want the PCI core to detect if PCI resource
> @@ -90,7 +88,6 @@ config PCI_REALLOC_ENABLE_AUTO
>  
>  config PCI_STUB
>  	tristate "PCI Stub driver"
> -	depends on PCI
>  	help
>  	  Say Y or M here if you want be able to reserve a PCI device
>  	  when it is going to be assigned to a guest operating system.
> @@ -99,7 +96,6 @@ config PCI_STUB
>  
>  config PCI_PF_STUB
>  	tristate "PCI PF Stub driver"
> -	depends on PCI
>  	depends on PCI_IOV
>  	help
>  	  Say Y or M here if you want to enable support for devices that
> @@ -111,7 +107,7 @@ config PCI_PF_STUB
>  
>  config XEN_PCIDEV_FRONTEND
>          tristate "Xen PCI Frontend"
> -        depends on PCI && X86 && XEN
> +        depends on X86 && XEN
>          select PCI_XEN
>  	select XEN_XENBUS_FRONTEND
>          default y
> @@ -133,7 +129,6 @@ config PCI_BRIDGE_EMUL
>  
>  config PCI_IOV
>  	bool "PCI IOV support"
> -	depends on PCI
>  	select PCI_ATS
>  	help
>  	  I/O Virtualization is a PCI feature supported by some devices
> @@ -144,7 +139,6 @@ config PCI_IOV
>  
>  config PCI_PRI
>  	bool "PCI PRI support"
> -	depends on PCI
>  	select PCI_ATS
>  	help
>  	  PRI is the PCI Page Request Interface. It allows PCI devices that are
> @@ -154,7 +148,6 @@ config PCI_PRI
>  
>  config PCI_PASID
>  	bool "PCI PASID support"
> -	depends on PCI
>  	select PCI_ATS
>  	help
>  	  Process Address Space Identifiers (PASIDs) can be used by PCI devices
> @@ -167,7 +160,7 @@ config PCI_PASID
>  
>  config PCI_P2PDMA
>  	bool "PCI peer-to-peer transfer support"
> -	depends on PCI && ZONE_DEVICE
> +	depends on ZONE_DEVICE
>  	select GENERIC_ALLOCATOR
>  	help
>  	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
> @@ -184,12 +177,11 @@ config PCI_P2PDMA
>  
>  config PCI_LABEL
>  	def_bool y if (DMI || ACPI)
> -	depends on PCI
>  	select NLS
>  
>  config PCI_HYPERV
>          tristate "Hyper-V PCI Frontend"
> -        depends on PCI && X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
> +        depends on X86 && HYPERV && PCI_MSI && PCI_MSI_IRQ_DOMAIN && X86_64
>          help
>            The PCI device frontend driver allows the kernel to import arbitrary
>            PCI devices from a PCI backend to support PCI driver domains.
> @@ -198,3 +190,5 @@ source "drivers/pci/hotplug/Kconfig"
>  source "drivers/pci/controller/Kconfig"
>  source "drivers/pci/endpoint/Kconfig"
>  source "drivers/pci/switch/Kconfig"
> +
> +endif
> -- 
> 2.19.1
> 
