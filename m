Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:58722 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeBPUms (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Feb 2018 15:42:48 -0500
Date: Fri, 16 Feb 2018 15:42:46 -0500 (EST)
Message-Id: <20180216.154246.733588003782380192.davem@davemloft.net>
To: ganeshgr@chelsio.com
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        netdev@vger.kernel.org, hare@suse.de, nirranjan@chelsio.com,
        indranil@chelsio.com, venkatesh@chelsio.com, leedom@chelsio.com,
        stable@vger.kernel.org, arjun@chelsio.com
Subject: Re: [PATCH] PCI/cxgb4: Extend T3 PCI quirk to T4+ devices
From: David Miller <davem@davemloft.net>
In-Reply-To: <1518705198-15987-1-git-send-email-ganeshgr@chelsio.com>
References: <1518705198-15987-1-git-send-email-ganeshgr@chelsio.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Ganesh Goudar <ganeshgr@chelsio.com>
Date: Thu, 15 Feb 2018 20:03:18 +0530

> From: Casey Leedom <leedom@chelsio.com>
> 
> We've run into a problem where our device is attached
> to a Virtual Machine and the use of the new pci_set_vpd_size()
> API doesn't help.  The VM kernel has been informed that
> the accesses are okay, but all of the actual VPD Capability
> Accesses are trapped down into the KVM Hypervisor where it
> goes ahead and imposes the silent denials.
> 
> The right idea is to follow the kernel.org
> commit 1c7de2b4ff88 ("PCI: Enable access to non-standard VPD for
> Chelsio devices (cxgb3)") which Alexey Kardashevskiy authored
> to establish a PCI Quirk for our T3-based adapters. This commit
> extends that PCI Quirk to cover Chelsio T4 devices and later.
> 
> The advantage of this approach is that the VPD Size gets set early
> in the Base OS/Hypervisor Boot and doesn't require that the cxgb4
> driver even be available in the Base OS/Hypervisor.  Thus PF4 can
> be exported to a Virtual Machine and everything should work.
> 
> Fixes: 67e658794ca1 ("cxgb4: Set VPD size so we can read both VPD structures")
> Cc: <stable@vger.kernel.org>  # v4.9+
> Signed-off-by: Casey Leedom <leedom@chelsio.com>
> Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
> Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>

Applied, thanks.
