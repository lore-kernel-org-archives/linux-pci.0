Return-Path: <SRS0=u0zl=SM=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF9C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0101320820
	for <linux-pci@archiver.kernel.org>; Wed, 10 Apr 2019 21:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554932705;
	bh=gqbFpcPltWDygFGRpM8CcSE/qGbr51/gDWzkajQfu+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rhpi00eRHbENwEmC8lNxmho1KnBupho2J3U6mhFujsxbdKHqOUPIeSpm0gbbA5Qxh
	 KgIY59KTlEHINSoT6Gs7HKa+FF4/suCIsg1YMPnZGnJg3nSjU3BAvgyENCzsFNxq0g
	 GAgGAoqyNZDmQ2yd3aQpNQKFyp4R1Esg5SxijPBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfDJVpE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 10 Apr 2019 17:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfDJVpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Apr 2019 17:45:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521C520820;
        Wed, 10 Apr 2019 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554932702;
        bh=gqbFpcPltWDygFGRpM8CcSE/qGbr51/gDWzkajQfu+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RYa8/w+bRisf5ihIXFc6ovT2WBrvB5MVrsb7MQfzMusHYe/7jAmLZAy/S9Ni3n6IY
         QdADAR6jH7SkbvZ1d48rTy08SAAoKmau+uaz6/RbwIWvmq/mg+915VbOFmQV2ObnKq
         +wIgwO0CFJqghG5M6A9+q4hLHnw6VR+kJsQ5VJDA=
Date:   Wed, 10 Apr 2019 16:45:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH 2/2] x86/pci: Clean up usage of X86_DEV_DMA_OPS
Message-ID: <20190410214500.GK256045@google.com>
References: <20190410080220.21705-1-hch@lst.de>
 <20190410080220.21705-3-hch@lst.de>
 <20190410081617.GA54229@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410081617.GA54229@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Keith, Jonathan (VMD guys)]

I'm OK with this from a PCI perspective.  It would be nice if

  dma_domain_list
  dma_domain_list_lock
  add_dma_domain()
  del_dma_domain()
  set_dma_domain_ops()

could all be moved to vmd.c, since they're really only used there.

But we don't really have a good way to call host bridge-specific code
like set_dma_domain_ops() except via pcibios_add_device().  Someday
maybe pcibios_add_device() will become a host bridge method.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>


On Wed, Apr 10, 2019 at 10:16:17AM +0200, Ingo Molnar wrote:
> (+Cc. Patch quoted below. Acked-by from an x86 perspective.)
> 
> * Christoph Hellwig <hch@lst.de> wrote:
> 
> > We have supported per-device dma_map_ops in generic code for a long
> > time, and this symbol just guards the inclusion of the dma_map_ops
> > registry used for vmd.  Stop enabling it for anything but vmd.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/x86/Kconfig               | 3 ---
> >  drivers/misc/mic/Kconfig       | 4 ++--
> >  drivers/pci/controller/Kconfig | 1 +
> >  drivers/pci/controller/vmd.c   | 7 -------
> >  4 files changed, 3 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 38c62ff8a3f0..d8e2e6519a61 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -28,7 +28,6 @@ config X86_64
> >  	select MODULES_USE_ELF_RELA
> >  	select NEED_DMA_MAP_STATE
> >  	select SWIOTLB
> > -	select X86_DEV_DMA_OPS
> >  	select ARCH_HAS_SYSCALL_WRAPPER
> >  
> >  #
> > @@ -703,7 +702,6 @@ config STA2X11
> >  	bool "STA2X11 Companion Chip Support"
> >  	depends on X86_32_NON_STANDARD && PCI
> >  	select ARCH_HAS_PHYS_TO_DMA
> > -	select X86_DEV_DMA_OPS
> >  	select SWIOTLB
> >  	select MFD_STA2X11
> >  	select GPIOLIB
> > @@ -2877,7 +2875,6 @@ config HAVE_ATOMIC_IOMAP
> >  
> >  config X86_DEV_DMA_OPS
> >  	bool
> > -	depends on X86_64 || STA2X11
> >  
> >  config HAVE_GENERIC_GUP
> >  	def_bool y
> > diff --git a/drivers/misc/mic/Kconfig b/drivers/misc/mic/Kconfig
> > index 242dcee14689..6736f72cc14a 100644
> > --- a/drivers/misc/mic/Kconfig
> > +++ b/drivers/misc/mic/Kconfig
> > @@ -4,7 +4,7 @@ comment "Intel MIC Bus Driver"
> >  
> >  config INTEL_MIC_BUS
> >  	tristate "Intel MIC Bus Driver"
> > -	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
> > +	depends on 64BIT && PCI && X86
> >  	help
> >  	  This option is selected by any driver which registers a
> >  	  device or driver on the MIC Bus, such as CONFIG_INTEL_MIC_HOST,
> > @@ -21,7 +21,7 @@ comment "SCIF Bus Driver"
> >  
> >  config SCIF_BUS
> >  	tristate "SCIF Bus Driver"
> > -	depends on 64BIT && PCI && X86 && X86_DEV_DMA_OPS
> > +	depends on 64BIT && PCI && X86
> >  	help
> >  	  This option is selected by any driver which registers a
> >  	  device or driver on the SCIF Bus, such as CONFIG_INTEL_MIC_HOST
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index 6012f3059acd..011c57cae4b0 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -267,6 +267,7 @@ config PCIE_TANGO_SMP8759
> >  
> >  config VMD
> >  	depends on PCI_MSI && X86_64 && SRCU
> > +	select X86_DEV_DMA_OPS
> >  	tristate "Intel Volume Management Device Driver"
> >  	---help---
> >  	  Adds support for the Intel Volume Management Device (VMD). VMD is a
> > diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> > index cf6816b55b5e..999a5509e57e 100644
> > --- a/drivers/pci/controller/vmd.c
> > +++ b/drivers/pci/controller/vmd.c
> > @@ -95,10 +95,8 @@ struct vmd_dev {
> >  	struct irq_domain	*irq_domain;
> >  	struct pci_bus		*bus;
> >  
> > -#ifdef CONFIG_X86_DEV_DMA_OPS
> >  	struct dma_map_ops	dma_ops;
> >  	struct dma_domain	dma_domain;
> > -#endif
> >  };
> >  
> >  static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
> > @@ -293,7 +291,6 @@ static struct msi_domain_info vmd_msi_domain_info = {
> >  	.chip		= &vmd_msi_controller,
> >  };
> >  
> > -#ifdef CONFIG_X86_DEV_DMA_OPS
> >  /*
> >   * VMD replaces the requester ID with its own.  DMA mappings for devices in a
> >   * VMD domain need to be mapped for the VMD, not the device requiring
> > @@ -438,10 +435,6 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
> >  	add_dma_domain(domain);
> >  }
> >  #undef ASSIGN_VMD_DMA_OPS
> > -#else
> > -static void vmd_teardown_dma_ops(struct vmd_dev *vmd) {}
> > -static void vmd_setup_dma_ops(struct vmd_dev *vmd) {}
> > -#endif
> >  
> >  static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
> >  				  unsigned int devfn, int reg, int len)
> > -- 
> > 2.20.1
> > 
