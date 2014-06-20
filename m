Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from 8bytes.org ([85.214.48.195]:48562 "EHLO mail.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967284AbaFTMXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 20 Jun 2014 08:23:23 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.8bytes.org (Postfix) with SMTP id 43BB212B2C2
	for <linux-pci@vger.kernel.org>; Fri, 20 Jun 2014 14:23:22 +0200 (CEST)
Date: Fri, 20 Jun 2014 14:23:20 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
	linux-hotplug@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] iommu/vt-d: fix bug in handling multiple RMRRs for the
 same PCI device
Message-ID: <20140620122320.GJ31771@8bytes.org>
References: <1403248086-13853-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403248086-13853-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 20, 2014 at 03:08:06PM +0800, Jiang Liu wrote:
> Function dmar_iommu_notify_scope_dev() makes a wrong assumption that
> there's one RMRR for each PCI device at most, which causes DMA failure
> on some HP platforms. So enhance dmar_iommu_notify_scope_dev() to
> handle multiple RMRRs for the same PCI device.
> 
> Fixbug: https://bugzilla.novell.com/show_bug.cgi?id=879482
> 
> Cc: <stable@vger.kernel.org> # 3.15
> Reported-by: Tom Mingarelli <thomas.mingarelli@hp.com>
> Tested-by: Linda Knippers <linda.knippers@hp.com>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>

Applied to iommu/fixes, thans Jiang.


