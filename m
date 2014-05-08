Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:41136 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751945AbaEHPP6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 8 May 2014 11:15:58 -0400
Date: Thu, 8 May 2014 16:15:27 +0100
From: Will Deacon <will.deacon@arm.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"sthokal@xilinx.com" <sthokal@xilinx.com>,
	"jgunthorpe@obsidianresearch.com" <jgunthorpe@obsidianresearch.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH v6 1/3] ARM: kconfig: allow PCI support to be selected
 with ARCH_MULTIPLATFORM
Message-ID: <20140508151526.GE8981@arm.com>
References: <1399478839-3564-1-git-send-email-will.deacon@arm.com>
 <1399478839-3564-2-git-send-email-will.deacon@arm.com>
 <536B9DE9.80100@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <536B9DE9.80100@wwwdotorg.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 08, 2014 at 04:08:25PM +0100, Stephen Warren wrote:
> On 05/07/2014 10:07 AM, Will Deacon wrote:
> > When targetting ARCH_MULTIPLATFORM, we may include support for SoCs with
> > PCI-capable devices (e.g. mach-virt with virtio-pci).
> > 
> > This patch allows PCI support to be selected for these SoCs by selecting
> > CONFIG_MIGHT_HAVE_PCI when CONFIG_ARCH_MULTIPLATFORM=y.
> 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> 
> > @@ -314,6 +314,7 @@ config ARCH_MULTIPLATFORM
> >  	select CLKSRC_OF
> >  	select COMMON_CLK
> >  	select GENERIC_CLOCKEVENTS
> > +	select MIGHT_HAVE_PCI
> 
> Doesn't ARCH_MULTIPLATFORM allow ARCH_$soc to be selected, and ARCH_$soc
> selects MIGHT_HAVE_PCI?
> 
> That way, you can only enable PCI support if you have actually enabled
> an SoC that has PCI, and equally ARCH_$soc selects MIGHT_HAVE_PCI just
> like it always used to work before ARCH_MULTIPLATFORM.

Yeah, I initially had this only for mach-virt, but the last review suggested
moving it here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/252937.html

Will
