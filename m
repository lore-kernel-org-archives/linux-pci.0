Return-Path: <SRS0=EHML=26=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16810C282DD
	for <linux-pci@archiver.kernel.org>; Thu,  9 Jan 2020 14:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ABF20880
	for <linux-pci@archiver.kernel.org>; Thu,  9 Jan 2020 14:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgAIOhD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:37:03 -0500
Received: from verein.lst.de ([213.95.11.211]:55031 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730751AbgAIOhD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 09:37:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25B8D68BFE; Thu,  9 Jan 2020 15:37:01 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:37:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC 5/5] x86/PCI: Remove unused X86_DEV_DMA_OPS
Message-ID: <20200109143700.GD22656@lst.de>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com> <1577823863-3303-6-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577823863-3303-6-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 31, 2019 at 01:24:23PM -0700, Jon Derrick wrote:
> VMD was the only user of device dma operations. Now that the IOMMU has
> been made aware of direct DMA aliases, VMD domain devices can reference
> the VMD endpoint directly and the VMD device dma operations has been
> made obsolete.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

This seems to be a 1:1 copy of my patch from August?
