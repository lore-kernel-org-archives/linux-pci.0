Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 8 Aug 2017 18:22:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ding Tianhong <dingtianhong@huawei.com>
Subject: Re: [PATCH v9 1/4] PCI: Add new PCIe Fabric End Node flag,
 PCI_DEV_FLAGS_NO_RELAXED_ORDERING
Message-ID: <20170808232200.GO16580@bhelgaas-glaptop.roam.corp.google.com>
References: <1501917313-9812-1-git-send-email-dingtianhong@huawei.com>
 <1501917313-9812-2-git-send-email-dingtianhong@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1501917313-9812-2-git-send-email-dingtianhong@huawei.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, gabriele.paoloni@huawei.com, asit.k.mallick@intel.com,
 catalin.marinas@arm.com, will.deacon@arm.com, linuxarm@huawei.com,
 alexander.duyck@gmail.com, ashok.raj@intel.com, jeffrey.t.kirsher@intel.com,
 linux-pci@vger.kernel.org, ganeshgr@chelsio.com, Bob.Shaw@amd.com,
 leedom@chelsio.com, patrick.j.cramer@intel.com, bhelgaas@google.com,
 werner@chelsio.com, linux-arm-kernel@lists.infradead.org, amira@mellanox.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, David.Laight@aculab.com,
 Suravee.Suthikulpanit@amd.com, robin.murphy@arm.com, davem@davemloft.net,
 l.stach@pengutronix.de
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 05, 2017 at 03:15:10PM +0800, Ding Tianhong wrote:
> From: Casey Leedom <leedom@chelsio.com>
> 
> The patch adds a new flag PCI_DEV_FLAGS_NO_RELAXED_ORDERING to indicate that
> Relaxed Ordering (RO) attribute should not be used for Transaction Layer
> Packets (TLP) targetted towards these affected root complexes. Current list
> of affected parts include some Intel Xeon processors root complex which suffers from
> flow control credits that result in performance issues. On these affected
> parts RO can still be used for peer-2-peer traffic. AMD A1100 ARM ("SEATTLE")
> Root complexes don't obey PCIe 3.0 ordering rules, hence could lead to
> data-corruption.

This needs to include a link to the Intel spec
(https://software.intel.com/sites/default/files/managed/9e/bc/64-ia-32-architectures-optimization-manual.pdf,
sec 3.9.1).

It should also include a pointer to the AMD erratum, if available, or
at least some reference to how we know it doesn't obey the rules.

Ashok, thanks for chiming in.  Now that you have, I have a few more
questions for you:

  - Is the above doc the one you mentioned as being now public?
  
  - Is this considered a hardware erratum?
  
  - If so, is there a pointer to that as well?
  
  - If this is not considered an erratum, can you provide any guidance
    about how an OS should determine when it should use RO?
    
Relying on a list of device IDs in an optimization manual is OK for an
erratum, but if it's *not* an erratum, it seems like a hole in the
specs because as far as I know there's no generic way for the OS to
discover whether to use RO.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
