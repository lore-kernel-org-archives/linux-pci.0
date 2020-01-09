Return-Path: <SRS0=EHML=26=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D17C282DD
	for <linux-pci@archiver.kernel.org>; Thu,  9 Jan 2020 14:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4BB2077C
	for <linux-pci@archiver.kernel.org>; Thu,  9 Jan 2020 14:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbgAIOeB (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:34:01 -0500
Received: from verein.lst.de ([213.95.11.211]:54979 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729897AbgAIOeB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 09:34:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 13FDD68C4E; Thu,  9 Jan 2020 15:33:57 +0100 (CET)
Date:   Thu, 9 Jan 2020 15:33:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC 3/5] x86/PCI: Expose VMD's device in pci_sysdata
Message-ID: <20200109143356.GB22656@lst.de>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com> <1577823863-3303-4-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577823863-3303-4-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 31, 2019 at 01:24:21PM -0700, Jon Derrick wrote:
> To be used by intel-iommu code to find the correct domain.

Any reason to prefer this version over my patches 2 and 3 from the
series in August?
