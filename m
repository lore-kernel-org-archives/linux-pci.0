Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752343AbcLGXbI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Dec 2016 18:31:08 -0500
Date: Wed, 7 Dec 2016 17:31:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix improper handling of pcie hotplug events.
Message-ID: <20161207233104.GK22129@bhelgaas-glaptop.roam.corp.google.com>
References: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479544367-7195-1-git-send-email-ashok.raj@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Ashok,

On Sat, Nov 19, 2016 at 12:32:44AM -0800, Ashok Raj wrote:
> This patch series fixes pciehp for certain special conditions observed during
> testing.
> 
> Ashok Raj (3):
>   pciehp: Prioritize data-link event over presence detect
>   pciehp: Fix led status when enabling already enabled slot.
>   pciehp: Fix race condition handling surprise link-down
> 
>  drivers/pci/hotplug/pciehp_ctrl.c |  6 +++---
>  drivers/pci/hotplug/pciehp_hpc.c  | 21 ++++++++++++---------
>  2 files changed, 15 insertions(+), 12 deletions(-)

These are all marked for stable, which probably makes sense, but
without bug reports that show the specific bad things that happen, I
can't justify that.  Per Documentation/stable_kernel_rules.txt, we
should have examples of "real bugs that bother people."

Bjorn
