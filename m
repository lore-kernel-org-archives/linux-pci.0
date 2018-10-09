Return-Path: <SRS0=286E=MV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3616EC64EB8
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 16:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D329E2087D
	for <linux-pci@archiver.kernel.org>; Tue,  9 Oct 2018 16:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D329E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeJIXVF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:21:05 -0400
Received: from foss.arm.com ([217.140.101.70]:40910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeJIXVF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Oct 2018 19:21:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A89A80D;
        Tue,  9 Oct 2018 09:03:28 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4AE4A3F5D3;
        Tue,  9 Oct 2018 09:03:28 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id A3A561AE0B3B; Tue,  9 Oct 2018 17:03:27 +0100 (BST)
Date:   Tue, 9 Oct 2018 17:03:27 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/12] error handling and pciehp maintenance
Message-ID: <20181009160327.GE9259@arm.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181004221137.GB21834@localhost.localdomain>
 <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

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

Thanks for the heads-up here. This feature is currently in development for
arm64:

http://lkml.kernel.org/r/20181001141648.1DBED68BDF@newverein.lst.de

but the latest review comments suggest that it's a fair way from ready yet,
so I wouldn't hold your breath.

Will
