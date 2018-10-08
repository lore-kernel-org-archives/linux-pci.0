Return-Path: <SRS0=j7M/=MU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C31DC65C20
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 16:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A0B82089D
	for <linux-pci@archiver.kernel.org>; Mon,  8 Oct 2018 16:16:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A0B82089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbeJHX2q (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:28:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:1294 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJHX2q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 8 Oct 2018 19:28:46 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 09:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="95668818"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by fmsmga004.fm.intel.com with ESMTP; 08 Oct 2018 09:16:16 -0700
Date:   Mon, 8 Oct 2018 10:18:47 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20181008161847.GA30971@localhost.localdomain>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181004221137.GB21834@localhost.localdomain>
 <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 05, 2018 at 12:31:45PM -0500, Bjorn Helgaas wrote:
> [+cc arm64 folks, LKML: This conversation is about this patch:
> 
>   https://lore.kernel.org/linux-pci/20180918235848.26694-3-keith.busch@intel.com
> 
> which fixes some PCIe AER error injection bugs, but also makes the error
> injector dependent on DYNAMIC_FTRACE_WITH_REGS, which not all arches
> support.  Note that this question is only about the error *injection*
> module used for testing.  It doesn't affect AER support itself.]
> 
> On Thu, Oct 04, 2018 at 04:11:37PM -0600, Keith Busch wrote:
> > On Thu, Oct 04, 2018 at 04:40:15PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 18, 2018 at 05:58:36PM -0600, Keith Busch wrote:
> > > > I ran into a lot of trouble testing error handling, and this series is
> > > > just trying to simplify some things. The first 4 fix up aer_inject, and
> > > > the rest are cleanup to make better use of kernel APIs.
> > > > 
> > > > Keith Busch (12):
> > > >   PCI: Set PCI bus accessors to noinline
> > > >   PCI/AER: Covertly inject errors
> > > >   PCI/AER: Reuse existing service device lookup
> > > >   PCI/AER: Abstract AER interrupt handling
> > > >   PCI/AER: Remove dead code
> > > >   PCI/AER: Remove error source from aer struct
> > > >   PCI/AER: Use kfifo for tracking events
> > > >   PCI/AER: Use kfifo helper inserting locked elements
> > > >   PCI/AER: Don't read upstream ports below fatal errors
> > > >   PCI/AER: Use threaded IRQ for bottom half
> > > >   PCI/AER: Use managed resource allocations
> > > >   PCI/pciehp: Use device managed allocations
> > > > 
> > > >  drivers/pci/access.c              |   4 +-
> > > >  drivers/pci/hotplug/pciehp_core.c |  14 +-
> > > >  drivers/pci/hotplug/pciehp_hpc.c  |  48 ++----
> > > >  drivers/pci/pcie/Kconfig          |   2 +-
> > > >  drivers/pci/pcie/aer.c            | 219 ++++++---------------------
> > > >  drivers/pci/pcie/aer_inject.c     | 306 ++++++++++++++++++++------------------
> > > >  drivers/pci/pcie/portdrv.h        |   4 -
> > > >  drivers/pci/pcie/portdrv_core.c   |   1 +
> > > >  8 files changed, 227 insertions(+), 371 deletions(-)
> > > 
> > > Thanks a lot for doing this!  I applied these to pci/hotplug for
> > > v4.20, except for "PCI/AER: Don't read upstream ports below fatal
> > > errors", which seems to be already there via another posting, and
> > > "PCI/pciehp: Use device managed allocations", which needs a few
> > > tweaks.
> > 
> > Sounds good, and thanks for applying!
> > 
> > In case this went unnoticed, patch 2's aer_inject using ftrace hooks
> > to pci config accessors is really cool and fixes several kernel crashes
> > I encountered, but it may not work on every architecture. I'm not sure
> > how widely aer_inject is used, so maybe there are no concerns with the
> > DYNAMIC_FTRACE_WITH_REGS dependency, but I just want to reemphasize that
> > dependency in case there are valid objections.
> 
> Oh, indeed, I hadn't noticed this arch dependency.  AFAICT, the new
> DYNAMIC_FTRACE_WITH_REGS dependency means aer_inject will work only
> on these arches:
> 
>   arm		# if (!XIP_KERNEL) && !CPU_ENDIAN_BE32 && MMU
>   powerpc	# if PPC64 && CPU_LITTLE_ENDIAN
>   riscv		# ARCH_RV64I only
>   s390
>   x86
> 
> Notably missing is arm64, which has DYNAMIC_FTRACE but not
> DYNAMIC_FTRACE_WITH_REGS.
> 
> Bjorn

Looks like the kbuild bot found an ARM kernel config that has
DYNAMIC_FTRACE_WITH_REGS set, and then the module can't compile
there. I'll need to update this patch regardless, and I think the right
thing to do is maintain the "old" way with conditional compiling for
any arch specific features.
