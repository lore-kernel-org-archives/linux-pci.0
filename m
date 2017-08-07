Return-Path: <SRS0=FD0M=7J=davemloft.net=davem@kernel.org>
Return-Path: <SRS0=FD0M=7J=davemloft.net=davem@kernel.org>
Date: Sun, 06 Aug 2017 20:47:44 -0700 (PDT)
Message-Id: <20170806.204744.1934067595236180060.davem@davemloft.net>
To: dingtianhong@huawei.com
Cc: leedom@chelsio.com, ashok.raj@intel.com, bhelgaas@google.com,
 helgaas@kernel.org, werner@chelsio.com, ganeshgr@chelsio.com,
 asit.k.mallick@intel.com, patrick.j.cramer@intel.com,
 Suravee.Suthikulpanit@amd.com, Bob.Shaw@amd.com, l.stach@pengutronix.de,
 amira@mellanox.com, gabriele.paoloni@huawei.com, David.Laight@aculab.com,
 jeffrey.t.kirsher@intel.com, catalin.marinas@arm.com, will.deacon@arm.com,
 mark.rutland@arm.com, robin.murphy@arm.com, alexander.duyck@gmail.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxarm@huawei.com
Subject: Re: [PATCH v9 0/4] Add new PCI_DEV_FLAGS_NO_RELAXED_ORDERING flag
From: David Miller <davem@davemloft.net>
In-Reply-To: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

From: Ding Tianhong <dingtianhong@huawei.com>
Date: Sat, 5 Aug 2017 15:15:09 +0800

> Some devices have problems with Transaction Layer Packets with the Relaxed
> Ordering Attribute set.  This patch set adds a new PCIe Device Flag,
> PCI_DEV_FLAGS_NO_RELAXED_ORDERING, a set of PCI Quirks to catch some known
> devices with Relaxed Ordering issues, and a use of this new flag by the
> cxgb4 driver to avoid using Relaxed Ordering with problematic Root Complex
> Ports.
> 
> It's been years since I've submitted kernel.org patches, I appolgise for the
> almost certain submission errors.

Which tree should merge this?  The PCI tree or my networking tree?
