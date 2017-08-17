Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:40260 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbdHQH61 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Aug 2017 03:58:27 -0400
Date: Thu, 17 Aug 2017 09:58:26 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: PCIe oops for NULL pointer dereference during next-20170807 and
 next-20170815
Message-ID: <20170817075825.GR30515@8bytes.org>
References: <c6ae57b6-1175-4ba4-b66d-d2f5393d06fc@rock-chips.com>
 <2ac52f40-c34f-6c31-b8db-868c40a977a3@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2ac52f40-c34f-6c31-b8db-868c40a977a3@rock-chips.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 17, 2017 at 03:02:31PM +0800, Shawn Lin wrote:
> So should we revert this commit or maybe we could add some checking
> into gic-v2m and gic-v3-its to see if the dev is iommu-capable? If not,
> we should create another routine to map MSI msg.

Yes, fixing this in gic code is the right approach. I usually don't
revert patches to hide problems somewhere else.


Regards,

	Joerg
