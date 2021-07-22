Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA4C4338F
	for <linux-pci@archiver.kernel.org>; Thu, 22 Jul 2021 21:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3612360EB6
	for <linux-pci@archiver.kernel.org>; Thu, 22 Jul 2021 21:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhGVVPP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Jul 2021 17:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230465AbhGVVPP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 17:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 096D060EB4;
        Thu, 22 Jul 2021 21:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626990949;
        bh=38/gCLLIKRNs+3LlTom+83SP70ITg2eDDYyBdiaRcM0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gwPTLMcqh6IZK4DjqkeRFtR3rE+94T1+Y0rWXqZUkBjwEHXFDoUM15zOYhX83L3WM
         jz+QDDmtV1SRrgnf4o96O0IabnpgaxGfh7e0d1m+XubinAbe8eMaeqspA4EVTUZihM
         dHTviUPYCjQi9vJRpsIAI/yJiOpCHXBR+1nkx2C8jGkQZQiBVBEgmmwJOg8MBuOuW6
         wdm8mEoeOaXFh96Ys7LEuzzFm7DI2yLPE091ZXcfdRxHWZ82NdvoYnh2IcYnK/0fxm
         rGfePFtavJnhQE/kEjVaXGCPskBrmFRSK3Oox0XZmBl++Sgt8svmkZ34XhNXs9Mz4r
         T8YsYfCrGZl6A==
Date:   Thu, 22 Jul 2021 16:55:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/9] PCI/VGA: Move vgaarb to drivers/pci
Message-ID: <20210722215547.GA351340@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae9d6b3-dce4-82f8-a315-56a0ecf657c0@infradead.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 02:38:43PM -0700, Randy Dunlap wrote:
> On 7/22/21 2:29 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > The VGA arbiter is really PCI-specific and doesn't depend on any GPU
> > things.  Move it to the PCI subsystem.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/gpu/vga/Kconfig           | 19 -------------------
> >  drivers/gpu/vga/Makefile          |  1 -
> >  drivers/pci/Kconfig               | 19 +++++++++++++++++++
> >  drivers/pci/Makefile              |  1 +
> >  drivers/{gpu/vga => pci}/vgaarb.c |  0
> >  5 files changed, 20 insertions(+), 20 deletions(-)
> >  rename drivers/{gpu/vga => pci}/vgaarb.c (100%)
> > 
> 
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 0c473d75e625..7c9e56d7b857 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -252,6 +252,25 @@ config PCIE_BUS_PEER2PEER
> >  
> >  endchoice
> >  
> > +config VGA_ARB
> > +	bool "VGA Arbitration" if EXPERT
> > +	default y
> > +	depends on (PCI && !S390)
> 
> You can drop the PCI part above.
> 
> > +	help
> > +	  Some "legacy" VGA devices implemented on PCI typically have the same
> > +	  hard-decoded addresses as they did on ISA. When multiple PCI devices
> > +	  are accessed at same time they need some kind of coordination. Please
> > +	  see Documentation/gpu/vgaarbiter.rst for more details. Select this to
> 
> Move that Doc file also...

Thanks!  Fixed both locally.
