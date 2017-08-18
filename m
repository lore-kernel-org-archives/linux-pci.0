Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 18 Aug 2017 16:14:52 -0700 (PDT)
Message-Id: <20170818.161452.1186139926380057795.davem@davemloft.net>
To: thierry.reding@gmail.com
Subject: Re: [PATCH] PCI: Allow PCI express root ports to find themselves
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170817110614.11454-1-thierry.reding@gmail.com>
References: <1502936730-7368-1-git-send-email-dingtianhong@huawei.com>
 <20170817110614.11454-1-thierry.reding@gmail.com>
Mime-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, gabriele.paoloni@huawei.com, asit.k.mallick@intel.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linuxarm@huawei.com,
 alexander.duyck@gmail.com, ashok.raj@intel.com, eric.dumazet@gmail.com,
 mpe@ellerman.id.au, jeffrey.t.kirsher@intel.com, dingtianhong@huawei.com,
 ganeshgr@chelsio.com, Bob.Shaw@amd.com, leedom@chelsio.com,
 patrick.j.cramer@intel.com, bhelgaas@google.com, werner@chelsio.com,
 linux-arm-kernel@lists.infradead.org, amira@mellanox.com,
 linux-pci@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, David.Laight@aculab.com,
 Suravee.Suthikulpanit@amd.com, robin.murphy@arm.com, l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 17 Aug 2017 13:06:14 +0200

> From: Thierry Reding <treding@nvidia.com>
> 
> If the pci_find_pcie_root_port() function is called on a root port
> itself, return the root port rather than NULL.
> 
> This effectively reverts commit 0e405232871d6 ("PCI: fix oops when
> try to find Root Port for a PCI device") which added an extra check
> that would now be redundant.
> 
> Fixes: a99b646afa8a ("PCI: Disable PCIe Relaxed Ordering if unsupported")
> Fixes: c56d4450eb68 ("PCI: Turn off Request Attributes to avoid Chelsio T5 Completion erratum")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> This applies on top of and was tested on next-20170817.
> 
> Michael, it'd be great if you could test this one again to clarify
> whether or not the fix that's already in Linus' tree is still needed, or
> whether it's indeed obsoleted by this patch.

Applied, thanks everyone.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
