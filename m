Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E66C64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 22:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619F120877
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 22:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619F120877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725760AbeJEFFB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:05:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:38822 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725758AbeJEFFB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 01:05:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2018 15:09:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,341,1534834800"; 
   d="scan'208";a="97516469"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.44])
  by orsmga002.jf.intel.com with ESMTP; 04 Oct 2018 15:09:13 -0700
Date:   Thu, 4 Oct 2018 16:11:37 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 00/12] error handling and pciehp maintenance
Message-ID: <20181004221137.GB21834@localhost.localdomain>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 04, 2018 at 04:40:15PM -0500, Bjorn Helgaas wrote:
> On Tue, Sep 18, 2018 at 05:58:36PM -0600, Keith Busch wrote:
> > I ran into a lot of trouble testing error handling, and this series is
> > just trying to simplify some things. The first 4 fix up aer_inject, and
> > the rest are cleanup to make better use of kernel APIs.
> > 
> > Keith Busch (12):
> >   PCI: Set PCI bus accessors to noinline
> >   PCI/AER: Covertly inject errors
> >   PCI/AER: Reuse existing service device lookup
> >   PCI/AER: Abstract AER interrupt handling
> >   PCI/AER: Remove dead code
> >   PCI/AER: Remove error source from aer struct
> >   PCI/AER: Use kfifo for tracking events
> >   PCI/AER: Use kfifo helper inserting locked elements
> >   PCI/AER: Don't read upstream ports below fatal errors
> >   PCI/AER: Use threaded IRQ for bottom half
> >   PCI/AER: Use managed resource allocations
> >   PCI/pciehp: Use device managed allocations
> > 
> >  drivers/pci/access.c              |   4 +-
> >  drivers/pci/hotplug/pciehp_core.c |  14 +-
> >  drivers/pci/hotplug/pciehp_hpc.c  |  48 ++----
> >  drivers/pci/pcie/Kconfig          |   2 +-
> >  drivers/pci/pcie/aer.c            | 219 ++++++---------------------
> >  drivers/pci/pcie/aer_inject.c     | 306 ++++++++++++++++++++------------------
> >  drivers/pci/pcie/portdrv.h        |   4 -
> >  drivers/pci/pcie/portdrv_core.c   |   1 +
> >  8 files changed, 227 insertions(+), 371 deletions(-)
> 
> Thanks a lot for doing this!  I applied these to pci/hotplug for
> v4.20, except for "PCI/AER: Don't read upstream ports below fatal
> errors", which seems to be already there via another posting, and
> "PCI/pciehp: Use device managed allocations", which needs a few
> tweaks.

Sounds good, and thanks for applying!

In case this went unnoticed, patch 2's aer_inject using ftrace hooks
to pci config accessors is really cool and fixes several kernel crashes
I encountered, but it may not work on every architecture. I'm not sure
how widely aer_inject is used, so maybe there are no concerns with the
DYNAMIC_FTRACE_WITH_REGS dependency, but I just want to reemphasize that
dependency in case there are valid objections.
