Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753017AbcLHSFm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 13:05:42 -0500
Date: Thu, 8 Dec 2016 12:05:38 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix improper handling of pcie hotplug events.
Message-ID: <20161208180538.GB28421@bhelgaas-glaptop.roam.corp.google.com>
References: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Nov 19, 2016 at 12:32:44AM -0800, Ashok Raj wrote:
> This patch series fixes pciehp for certain special conditions observed during
> testing.
> 
> Ashok Raj (3):
>   pciehp: Prioritize data-link event over presence detect
>   pciehp: Fix led status when enabling already enabled slot.

I applied the above on pci/hotplug for v4.10, without the stable
annotation.  If we get reports that would justify stable backports, we
can always request that later.  The ideal thing would be to get those
reports soon enough that we can reference them in the changelog and
add the stable annotations back before these get merged for v4.10.

>   pciehp: Fix race condition handling surprise link-down

I'm holding off on this one, pending resolution of the locking
question.

>  drivers/pci/hotplug/pciehp_ctrl.c |  6 +++---
>  drivers/pci/hotplug/pciehp_hpc.c  | 21 ++++++++++++---------
>  2 files changed, 15 insertions(+), 12 deletions(-)
> 
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
