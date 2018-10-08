Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBD7C677D4
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3752145D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLGs92pY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3752145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbeJIAgC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIAgC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 20:36:02 -0400
Received: from localhost (unknown [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80FC5213A2;
        Mon,  8 Oct 2018 17:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539019397;
        bh=ijEAh/+H+ZIvne1k5RznMTRebK6sUi6Bfvs7Vj2HGGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLGs92pYL/7iIq0DJda/uMNBxCVExJkjWaHgsXTrRVgR8hksiQV8OdjB/N3ZYyEox
         Lme/XHrKynaPquNTiN2shP87r3ocSFvcGAVsL0WsqcbuSCnaTXSBOMwsbayLJ2Ur/T
         uVdXMVRUBfVO12113/C4GqLbUWJHa/BHph7isjSw=
Date:   Mon, 8 Oct 2018 12:23:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] error handling and pciehp maintenance
Message-ID: <20181008172316.GM120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181004221137.GB21834@localhost.localdomain>
 <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181008161847.GA30971@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008161847.GA30971@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 08, 2018 at 10:18:47AM -0600, Keith Busch wrote:
> On Fri, Oct 05, 2018 at 12:31:45PM -0500, Bjorn Helgaas wrote:
> > [+cc arm64 folks, LKML: This conversation is about this patch:
> > 
> >   https://lore.kernel.org/linux-pci/20180918235848.26694-3-keith.busch@intel.com
> > 
> > which fixes some PCIe AER error injection bugs, but also makes the error
> > injector dependent on DYNAMIC_FTRACE_WITH_REGS, which not all arches
> > support.  Note that this question is only about the error *injection*
> > module used for testing.  It doesn't affect AER support itself.]
> > 
> > On Thu, Oct 04, 2018 at 04:11:37PM -0600, Keith Busch wrote:
> > > On Thu, Oct 04, 2018 at 04:40:15PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Sep 18, 2018 at 05:58:36PM -0600, Keith Busch wrote:
> > > > > I ran into a lot of trouble testing error handling, and this series is
> > > > > just trying to simplify some things. The first 4 fix up aer_inject, and
> > > > > the rest are cleanup to make better use of kernel APIs.
> > > > > 
> > > > > Keith Busch (12):
> > > > >   PCI: Set PCI bus accessors to noinline
> > > > >   PCI/AER: Covertly inject errors
> > > > >   PCI/AER: Reuse existing service device lookup
> > > > >   PCI/AER: Abstract AER interrupt handling
> > > > >   PCI/AER: Remove dead code
> > > > >   PCI/AER: Remove error source from aer struct
> > > > >   PCI/AER: Use kfifo for tracking events
> > > > >   PCI/AER: Use kfifo helper inserting locked elements
> > > > >   PCI/AER: Don't read upstream ports below fatal errors
> > > > >   PCI/AER: Use threaded IRQ for bottom half
> > > > >   PCI/AER: Use managed resource allocations
> > > > >   PCI/pciehp: Use device managed allocations
> > > > > 
> > > > >  drivers/pci/access.c              |   4 +-
> > > > >  drivers/pci/hotplug/pciehp_core.c |  14 +-
> > > > >  drivers/pci/hotplug/pciehp_hpc.c  |  48 ++----
> > > > >  drivers/pci/pcie/Kconfig          |   2 +-
> > > > >  drivers/pci/pcie/aer.c            | 219 ++++++---------------------
> > > > >  drivers/pci/pcie/aer_inject.c     | 306 ++++++++++++++++++++------------------
> > > > >  drivers/pci/pcie/portdrv.h        |   4 -
> > > > >  drivers/pci/pcie/portdrv_core.c   |   1 +
> > > > >  8 files changed, 227 insertions(+), 371 deletions(-)
> > > > 
> > > > Thanks a lot for doing this!  I applied these to pci/hotplug for
> > > > v4.20, except for "PCI/AER: Don't read upstream ports below fatal
> > > > errors", which seems to be already there via another posting, and
> > > > "PCI/pciehp: Use device managed allocations", which needs a few
> > > > tweaks.
> > > 
> > > Sounds good, and thanks for applying!
> > > 
> > > In case this went unnoticed, patch 2's aer_inject using ftrace hooks
> > > to pci config accessors is really cool and fixes several kernel crashes
> > > I encountered, but it may not work on every architecture. I'm not sure
> > > how widely aer_inject is used, so maybe there are no concerns with the
> > > DYNAMIC_FTRACE_WITH_REGS dependency, but I just want to reemphasize that
> > > dependency in case there are valid objections.
> > 
> > Oh, indeed, I hadn't noticed this arch dependency.  AFAICT, the new
> > DYNAMIC_FTRACE_WITH_REGS dependency means aer_inject will work only
> > on these arches:
> > 
> >   arm		# if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
> >   powerpc	# if PPC64 && CPU_LITTLE_ENDIAN
> >   riscv		# ARCH_RV64I only
> >   s390
> >   x86
> > 
> > Notably missing is arm64, which has DYNAMIC_FTRACE but not
> > DYNAMIC_FTRACE_WITH_REGS.
> > 
> > Bjorn
> 
> Looks like the kbuild bot found an ARM kernel config that has
> DYNAMIC_FTRACE_WITH_REGS set, and then the module can't compile
> there. I'll need to update this patch regardless, and I think the right
> thing to do is maintain the "old" way with conditional compiling for
> any arch specific features.

Sounds messy, but probably the best route.

I dropped these patches for now:

  PCI/AER: Covertly inject errors with ftrace hooks
  PCI/AER: Reuse existing pcie_port_find_device() interface
  PCI/AER: Abstract AER interrupt handling
