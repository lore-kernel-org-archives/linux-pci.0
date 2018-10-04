Return-Path: <SRS0=kgUF=MQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429E9C64EB8
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 21:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F2A213A2
	for <linux-pci@archiver.kernel.org>; Thu,  4 Oct 2018 21:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR7OpPaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F2A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJEEff (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbeJEEff (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Oct 2018 00:35:35 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AEE820854;
        Thu,  4 Oct 2018 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538689218;
        bh=mdoT6mtC+8j/Xsm6CRBuGv13jWvre1tN7tLgBKEdmSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mR7OpPaL2Qrj+pI4alGKxoGAj8Rsqon5uZf2FCiHemB/K0zOt8FBHi50ISYGNIIeD
         XmqkosPSIeYsAbw6SFxLUZ7zLHrfeIq6TQfIAtj1XqpUxFqV00tw2syKxpHOJXF0vh
         MGf3YEOsIecebZz18J1Zvc5FuciBi1oJwrU/N7Qc=
Date:   Thu, 4 Oct 2018 16:40:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>, poza@codeaurora.org,
        Lukas Wunner <lukas@wunner.de>, Christoph Hellwig <hch@lst.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 00/12] error handling and pciehp maintenance
Message-ID: <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
References: <20180918235848.26694-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918235848.26694-1-keith.busch@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 18, 2018 at 05:58:36PM -0600, Keith Busch wrote:
> I ran into a lot of trouble testing error handling, and this series is
> just trying to simplify some things. The first 4 fix up aer_inject, and
> the rest are cleanup to make better use of kernel APIs.
> 
> Keith Busch (12):
>   PCI: Set PCI bus accessors to noinline
>   PCI/AER: Covertly inject errors
>   PCI/AER: Reuse existing service device lookup
>   PCI/AER: Abstract AER interrupt handling
>   PCI/AER: Remove dead code
>   PCI/AER: Remove error source from aer struct
>   PCI/AER: Use kfifo for tracking events
>   PCI/AER: Use kfifo helper inserting locked elements
>   PCI/AER: Don't read upstream ports below fatal errors
>   PCI/AER: Use threaded IRQ for bottom half
>   PCI/AER: Use managed resource allocations
>   PCI/pciehp: Use device managed allocations
> 
>  drivers/pci/access.c              |   4 +-
>  drivers/pci/hotplug/pciehp_core.c |  14 +-
>  drivers/pci/hotplug/pciehp_hpc.c  |  48 ++----
>  drivers/pci/pcie/Kconfig          |   2 +-
>  drivers/pci/pcie/aer.c            | 219 ++++++---------------------
>  drivers/pci/pcie/aer_inject.c     | 306 ++++++++++++++++++++------------------
>  drivers/pci/pcie/portdrv.h        |   4 -
>  drivers/pci/pcie/portdrv_core.c   |   1 +
>  8 files changed, 227 insertions(+), 371 deletions(-)

Thanks a lot for doing this!  I applied these to pci/hotplug for
v4.20, except for "PCI/AER: Don't read upstream ports below fatal
errors", which seems to be already there via another posting, and
"PCI/pciehp: Use device managed allocations", which needs a few
tweaks.
