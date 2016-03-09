Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:49321 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752745AbcCIAfE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 8 Mar 2016 19:35:04 -0500
Message-ID: <59423.117.114.135.40.1457483288.squirrel@mprc.pku.edu.cn>
In-Reply-To: <20160308174238.20498.35018.stgit@bhelgaas-glaptop2.roam.corp.google.c
     om>
References: <20160308174238.20498.35018.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Date: Wed, 9 Mar 2016 08:28:08 +0800 (CST)
Subject: Re: [PATCH] unicore32: Remove unused HAVE_ARCH_PCI_SET_DMA_MASK
     definition
From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
To: "Bjorn Helgaas" <bhelgaas@google.com>
Cc: "Xuetao" <gxt@mprc.pku.edu.cn>, linux-pci@vger.kernel.org
Reply-To: gxt@mprc.pku.edu.cn
MIME-Version: 1.0
Content-Type: text/plain;charset=gb2312
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> HAVE_ARCH_PCI_SET_DMA_MASK is unused, so remove the #define for it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Pretty good. Thanks
Acked-by: GUAN Xuetao <gxt@mprc.pku.edu.cn>

> ---
>  arch/unicore32/include/mach/hardware.h |    5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/arch/unicore32/include/mach/hardware.h
> b/arch/unicore32/include/mach/hardware.h
> index 9e20b5d..2514623 100644
> --- a/arch/unicore32/include/mach/hardware.h
> +++ b/arch/unicore32/include/mach/hardware.h
> @@ -28,11 +28,6 @@
>  #define PCIBIOS_MIN_IO			0x4000 /* should lower than 64KB */
>  #define PCIBIOS_MIN_MEM			io_v2p(PKUNITY_PCIMEM_BASE)
>
> -/*
> - * We override the standard dma-mask routines for bouncing.
> - */
> -#define	HAVE_ARCH_PCI_SET_DMA_MASK
> -
>  #define pcibios_assign_all_busses()	1
>
>  #endif  /* __MACH_PUV3_HARDWARE_H__ */
>

