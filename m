Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:49524 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390006AbeHGWAq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Aug 2018 18:00:46 -0400
Date: Tue, 07 Aug 2018 12:44:48 -0700 (PDT)
Message-Id: <20180807.124448.1502585319140215353.davem@davemloft.net>
To: mr.nuke.me@gmail.com
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
        jakub.kicinski@netronome.com, keith.busch@intel.com,
        alex_gagniuc@dellteam.com, austin_bolen@dell.com,
        shyam_iyer@dell.com, ariel.elior@cavium.com,
        everest-linux-l2@cavium.com, michael.chan@broadcom.com,
        ganeshgr@chelsio.com, jeffrey.t.kirsher@intel.com,
        tariqt@mellanox.com, saeedm@mellanox.com, leon@kernel.org,
        dirk.vandermerwe@netronome.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-rdma@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [PATCH v6 1/9] PCI: Check for PCIe downtraining conditions
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180806232600.25694-1-mr.nuke.me@gmail.com>
References: <CAErSpo4PK+SQLNfdkLNt9eLc7bpbxbkZCsa8T-tQpid601n0SQ@mail.gmail.com>
        <20180806232600.25694-1-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Date: Mon,  6 Aug 2018 18:25:35 -0500

> PCIe downtraining happens when both the device and PCIe port are
> capable of a larger bus width or higher speed than negotiated.
> Downtraining might be indicative of other problems in the system, and
> identifying this from userspace is neither intuitive, nor
> straightforward.
> 
> The easiest way to detect this is with pcie_print_link_status(),
> since the bottleneck is usually the link that is downtrained. It's not
> a perfect solution, but it works extremely well in most cases.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Feel free to merge this entire series via the PCI tree.

For the series:

Acked-by: David S. Miller <davem@davemloft.net>
