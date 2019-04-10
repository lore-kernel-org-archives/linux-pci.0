Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BA8C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 08:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34930204FD
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 08:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554884183;
	bh=rKjHnzRWOdzY2O5Fsf83bi15P7EFHUFI1vh7gVnauvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AmbmehSayjzZ22chKI1EPVKiWV1OqXhSRTcTFCqX72AMDBXk2D+9WibID6WzTicTl
	 wyUL3/g6vURrpbLx41rK+QZEc7TW7tyVXUM0c7QaYt42nACUwZgFQ3fLfh8KBMMyhI
	 /C3ePQWoqgpvG0LO1caeDkOnu1WjmaL/DCtWM4SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfDJIQW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:16:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37847 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfDJIQW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Apr 2019 04:16:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id v14so1525369wmf.2;
        Wed, 10 Apr 2019 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EA/aq9S/+GfrhWnl5dtJCDqgCdCuVUBYk4FOtE4najY=;
        b=ds52kFbQLrRvCgyyDB45sCCl+jVMLYSu7S0EQDnC1Uqajrfz/gihtXfNMo/E0QEn6N
         OVmUMWIAv/fymEGZ0QAQj946dztUhEBDOLyQ+cBKyzGK8rT9WEfj+rUCghmcC5v0PSM4
         aEVXVIhMDhU2jy/iiwdFIP2e1cfah6KRIrU07sFLO4hWMWVYpsFevxza2kc9OLh/Ai3F
         DPBDLv9o7gQ9MHwv0JoMgA5lVlXxKn3m3s0dxW0Pu/t/+MLN1+NeYmmmQiUWgGRb9KzE
         owPX7cMIbKuy6y4xr99MLCogZMj1nSP9gwWFXDlU8gTeLz9aX6eOc9/GBeNSct5ZrpDk
         RXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EA/aq9S/+GfrhWnl5dtJCDqgCdCuVUBYk4FOtE4najY=;
        b=bEhZ8F/2AxivMv5IJq/P8yrwqlhnQLP9eIKuU3q6fwdVRFH4/i9Sb4QZHmpquZUWKh
         shuUm03bkWqVtQXQpL6SMRPMUyCsvyLvJb9cBknI4XGws6vVtdeXchhHjfywWmmkINTU
         aXm7heX77oLV7PDGi2kBbZYO4z5Fm3KJz42sXAHe0qKtX+TncfmhLGWpTeVuHXK1HKkh
         ARNHIROmoJe/geULJ9FWR4azJsIhKPoFvz1IM9axaQO1pQTXiaavxV2apz6uJBqYclN4
         zLveA7ZfHbD2HiNRuMWbmlAwRfXIwEWEHL+6XGZuOEGrSjn6Xe/VrMVNp/gsKMPV27e0
         GP+g==
X-Gm-Message-State: APjAAAUy5DmHZb8GqEF7ciRVGdTTS6/YhJFZtBtzrLukJw+2CvN86iSP
        LbiK97LgKH1cm5NXqt+pGN0=
X-Google-Smtp-Source: APXvYqxrid2tsl48d58BeOWWpWv+0VefqWAAX7rIOOAHGaK4+bB0MHItVxioZr9CqbtLt1+QmkZayw==
X-Received: by 2002:a1c:5f08:: with SMTP id t8mr1746298wmb.65.1554884179767;
        Wed, 10 Apr 2019 01:16:19 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r196sm2235207wmf.22.2019.04.10.01.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 01:16:19 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:16:17 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Message-ID: <20190410081617.GA54229@gmail.com>
References: <20190410080220.21705-1-hch@lst.de>
 <20190410080220.21705-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410080220.21705-3-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



(+Cc. Patch quoted below. Acked-by from an x86 perspective.)

* Christoph Hellwig <hch@lst.de> wrote:

> We have supported per-device dma_map_ops in generic code for a long
> time, and this symbol just guards the inclusion of the dma_map_ops
> registry used for vmd.  Stop enabling it for anything but vmd.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/Kconfig               | 3 ---
>  drivers/misc/mic/Kconfig       | 4 ++--
>  drivers/pci/controller/Kconfig | 1 +
>  drivers/pci/controller/vmd.c   | 7 -------
>  4 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 38c62ff8a3f0..d8e2e6519a61 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -28,7 +28,6 @@ config X86_64
>  	select MODULES_USE_ELF_RELA
>  	select NEED_DMA_MAP_STATE
>  	select SWIOTLB
> -	select X86_DEV_DMA_OPS
>  	select ARCH_HAS_SYSCALL_WRAPPER
>  
>  #
> @@ -703,7 +702,6 @@ config STA2X11
>  	bool "STA2X11 Companion Chip Support"
>  	depends on X86_32_NON_STANDARD && PCI
>  	select ARCH_HAS_PHYS_TO_DMA
> -	select X86_DEV_DMA_OPS
>  	select SWIOTLB
>  	select MFD_STA2X11
>  	select GPIOLIB
> @@ -2877,7 +2875,6 @@ config HAVE_ATOMIC_IOMAP
>  
>  config X86_DEV_DMA_OPS
>  	bool
> -	depends on X86_64 || STA2X11
>  
>  config HAVE_GENERIC_GUP
>  	def_bool y
> diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
> index 242dcee14689..6736f72cc14a 100644
> --- a/drivers/misc/mic/Kconfig
> +++ b/drivers/misc/mic/Kconfig
> @@ -4,7 +4,7 @@ comment "Intel MIC Bus Driver"
>  
>  config INTEL_MIC_BUS
>  	tristate "Intel MIC Bus Driver"
> -	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
> +	depends on 64BIT && PCI && X86
>  	help
>  	  This option is selected by any driver which registers a
>  	  device or driver on the MIC Bus, such as CONFIG_INTEL_MIC_HOST,
> @@ -21,7 +21,7 @@ comment "SCIF Bus Driver"
>  
>  config SCIF_BUS
>  	tristate "SCIF Bus Driver"
> -	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
> +	depends on 64BIT && PCI && X86
>  	help
>  	  This option is selected by any driver which registers a
>  	  device or driver on the SCIF Bus, such as CONFIG_INTEL_MIC_HOST
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 6012f3059acd..011c57cae4b0 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -267,6 +267,7 @@ config PCIE_TANGO_SMP8759
>  
>  config VMD
>  	depends on PCI_MSI && X86_64 && SRCU
> +	select X86_DEV_DMA_OPS
>  	tristate "Intel Volume Management Device Driver"
>  	---help---
>  	  Adds support for the Intel Volume Management Device (VMD). VMD is a
> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index cf6816b55b5e..999a5509e57e 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -95,10 +95,8 @@ struct vmd_dev {
>  	struct irq_domain	*irq_domain;
>  	struct pci_bus		*bus;
>  
> -#ifdef CONFIG_X86_DEV_DMA_OPS
>  	struct dma_map_ops	dma_ops;
>  	struct dma_domain	dma_domain;
> -#endif
>  };
>  
>  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> @@ -293,7 +291,6 @@ static struct msi_domain_info vmd_msi_domain_info = {
>  	.chip		= &vmd_msi_controller,
>  };
>  
> -#ifdef CONFIG_X86_DEV_DMA_OPS
>  /*
>   * VMD replaces the requester ID with its own.  DMA mappings for devices in a
>   * VMD domain need to be mapped for the VMD, not the device requiring
> @@ -438,10 +435,6 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
>  	add_dma_domain(domain);
>  }
>  #undef ASSIGN_VMD_DMA_OPS
> -#else
> -static void vmd_teardown_dma_ops(struct vmd_dev *vmd) {}
> -static void vmd_setup_dma_ops(struct vmd_dev *vmd) {}
> -#endif
>  
>  static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
>  				  unsigned int devfn, int reg, int len)
> -- 
> 2.20.1
> 
