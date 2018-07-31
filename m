Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 31 Jul 2018 13:44:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V5 0/3] PCI: separate hotplug handling from fatal error
 handling
Message-ID: <20180731184457.GN45322@bhelgaas-glaptop.roam.corp.google.com>
References: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1530571967-19099-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 02, 2018 at 06:52:44PM -0400, Sinan Kaya wrote:
> This is what happens when you insert a fatal error to a hotplug slot. See
> multiple link up/down messages.
> 
> /_#_[__333.699731]_pcieport_0001:00:00.0:_AER:_Uncorrected_(Fatal)_error_received:_id=0000
> [  333.748116] pcieport 0001:00:00.0: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, id
> [  333.816044] pcieport 0001:00:00.0:   device [17cb:0404] error status/mask=00040000/00400000
> [  333.871581] pcieport 0001:00:00.0:    [18] Malformed TLP (First)
> [  333.914675] pcieport 0001:00:00.0:   TLP Header: 40000001 000000ff 00000000 00000000
> [  333.968397] pciehp 0001:00:00.0:pcie004: Slot(2): Link Down
> [  334.043234] iommu: Removing device 0001:01:00.4 from group 0
> [  334.095952] iommu: Removing device 0001:01:00.3 from group 0
> [  334.144644] iommu: Removing device 0001:01:00.2 from group 0
> [  334.194653] iommu: Removing device 0001:01:00.1 from group 0
> [  334.243564] pciehp 0001:00:00.0:pcie004: Slot(2): Link Up
> [  334.282556] iommu: Removing device 0001:01:00.0 from group 0
> [  334.330994] pciehp 0001:00:00.0:pcie004: Slot(2): Link Up event queued;
> currently getting powered off
> [  334.890587] pciehp 0001:00:00.0:pcie004: Timeout on hotplug command
> 0x13f1 (issued 282900 msec ago)
> [  335.070190] pciehp 0001:00:00.0:pcie004: Slot(2): Link Down
> [  335.106960] pciehp 0001:00:00.0:pcie004: Slot(2): Link Down event queued; currently getting powered on
> [  335.191119] pcieport 0001:00:00.0: AER: Device recovery failed
> [  346.590153] pciehp 0001:00:00.0:pcie004: Timeout on hotplug command 0x17f1 (issued 10250 msec ago)
> 
> 
> Since DPC/AER patch to refactor fatal error handling, both hotplug
> driver and AER/DPC driver will try removing devices and perform enumeration on
> link events/AER events.
> 
> Perfect environment for race condition without a change.
> 
> Try to mask hotplug interrupts during AER/DPC fatal error handling.
> 
> Changes from v4:
> * add mask_irq() and unmask_irq() callbacks to struct pcie_driver
> * refactor reset_slot() to use pciehp_mask_irq() an pciehp_unmask_irq()
> 
> Sinan Kaya (3):
>   PCI: pciehp: implement mask and unmask interrupt functions
>   PCI: pciehp: reuse pciehp_mask/unmask_irq() in reset_slot()
>   PCI: Mask and unmask hotplug interrupts during reset
> 
>  drivers/pci/hotplug/pciehp.h      |  2 ++
>  drivers/pci/hotplug/pciehp_core.c | 19 +++++++++++++++++++
>  drivers/pci/hotplug/pciehp_hpc.c  | 36 ++++++++++++++++++++++++++++--------
>  drivers/pci/pcie/err.c            | 11 +++++++++++
>  drivers/pci/pcie/portdrv.h        |  2 ++
>  5 files changed, 62 insertions(+), 8 deletions(-)

There's been a ton of discussion about this, and I didn't see a clear
consensus emerge, so I'm going to drop it for now.  If it's still
needed, please repost it and I'll watch for reviewers.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
