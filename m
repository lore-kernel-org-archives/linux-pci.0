Return-Path: <SRS0=Hy4z=SU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1704C10F0E
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 20:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B94217F9
	for <linux-pci@archiver.kernel.org>; Thu, 18 Apr 2019 20:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555621056;
	bh=7JLL91FUIyHT7pGG0sl4mCrtu002Sx+Zn9GWrjbnwLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zzTK1/IVr/WjavAdSuiii4Bu1LHmj8gd+8UEnmcYv6zc3JL3t3uzYytXroFzmhV3K
	 hHWMyy2cLpFN8mLiL0G3jQUTx1WLZgPljdHcuis7RZhgs8pvSasGjrVmAlJXgV3nZU
	 N/ho8lGJZIn0iVnhh++7kccd5c6G1HYN7s0NQDp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbfDRU5c (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:33088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388710AbfDRU5b (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 18 Apr 2019 16:57:31 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E927420869;
        Thu, 18 Apr 2019 20:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555621050;
        bh=7JLL91FUIyHT7pGG0sl4mCrtu002Sx+Zn9GWrjbnwLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tTKD3ykZdubnTOyoPm1VZdT9zmaJOyP0WzXF9ImHnafJD4TrJ/a2F9vW9d5555BTm
         3F6U1qPtznnoz24PUshdLzY4nZnJgJKnVG4cpzzehWOgtnV4qw1LX3gCoQlFbYtrXv
         9RODjVJsN1F+sWI4Jd3gRdGGWxq++Bj2RH6uALWQ=
Date:   Thu, 18 Apr 2019 15:57:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 00/3] MIPS: SGI-IP27 rework part2
Message-ID: <20190418205726.GB126710@google.com>
References: <20190319154755.31049-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319154755.31049-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Tue, Mar 19, 2019 at 04:47:49PM +0100, Thomas Bogendoerfer wrote:
> SGI IP27 (Origin/Onyx2) and SGI IP30 (Octane) have a similair
> architecture and share some hardware (ioc3/bridge). To share
> the software parts this patchset reworks SGI IP27 interrupt
> and pci bridge code. By using features Linux gained during the
> many years since SGI IP27 code was integrated this even results
> in code reduction and IMHO cleaner code.
> 
> Tests have been done on a two module O200 (4 CPUs) and an
> Origin 2000 (8 CPUs).

Thanks for doing all this work!  It seems like it basically converts
some of the SGI PCI code to the structure typical of current host
controller drivers and moves it to drivers/pci/controller, which all
seems great to me.

The patches were kind of in limbo as far as Patchwork.  Lorenzo
handles the native host controller drivers, so I just delegated them
to him, so now they should be on his radar.

Bjorn

> My next step in integrating SGI IP30 support is splitting ioc3eth
> into a MFD and subdevice drivers, which will be submitted soon.
> 
> Changes in v3:
> 
> - dropped patches accepted by Paul
> - moved IP27 specific __phys_to_dma/__dma_to_phys into its own file
> - moved pcibios_to_node into IP27 specific file
> - moved PCI bus address resources setup out of pci-xtalk code into
>   IP27 specific code
> - dropped bit from hub_irq_data and use hwirq from irq_data
> - introduced intr_addr for setting up bridge interrupts (IP30 preperation)
> 
> Changes in v2:
> 
> - replaced HUB_L/HUB_S by __raw_readq/__raw_writeq
> - removed union bridge_ate
> - replaced remaing fields in slice_data by per_cpu data
> - use generic_handle_irq instead of do_IRQ
> - use hierarchy irq domain for stacking bridge and hub interrupt
> - moved __dma_to_phys/__phy_to_dma to mach-ip27/dma-direct.h
> - use dev_to_node() for pcibus_to_node() implementation
> 
> Thomas Bogendoerfer (3):
>   MIPS: SGI-IP27: move IP27 specific code out of pci-ip27.c into new
>     file
>   MIPS: SGI-IP27: use generic PCI driver
>   MIPS: SGI-IP27: abstract chipset irq from bridge
> 
>  arch/mips/Kconfig                          |   3 +
>  arch/mips/include/asm/mach-ip27/topology.h |  11 +-
>  arch/mips/include/asm/pci/bridge.h         |  14 +-
>  arch/mips/include/asm/sn/irq_alloc.h       |  11 +
>  arch/mips/include/asm/xtalk/xtalk.h        |   9 -
>  arch/mips/pci/Makefile                     |   1 -
>  arch/mips/pci/ops-bridge.c                 | 302 --------------
>  arch/mips/pci/pci-ip27.c                   | 214 ----------
>  arch/mips/sgi-ip27/Makefile                |   4 +-
>  arch/mips/sgi-ip27/ip27-init.c             |   2 +
>  arch/mips/sgi-ip27/ip27-irq.c              | 191 ++++-----
>  arch/mips/sgi-ip27/ip27-pci.c              |  30 ++
>  arch/mips/sgi-ip27/ip27-xtalk.c            |  61 ++-
>  drivers/pci/controller/Kconfig             |   3 +
>  drivers/pci/controller/Makefile            |   1 +
>  drivers/pci/controller/pci-xtalk-bridge.c  | 610 +++++++++++++++++++++++++++++
>  include/linux/platform_data/xtalk-bridge.h |  22 ++
>  17 files changed, 822 insertions(+), 667 deletions(-)
>  create mode 100644 arch/mips/include/asm/sn/irq_alloc.h
>  delete mode 100644 arch/mips/pci/ops-bridge.c
>  delete mode 100644 arch/mips/pci/pci-ip27.c
>  create mode 100644 arch/mips/sgi-ip27/ip27-pci.c
>  create mode 100644 drivers/pci/controller/pci-xtalk-bridge.c
>  create mode 100644 include/linux/platform_data/xtalk-bridge.h
> 
> -- 
> 2.13.7
> 
