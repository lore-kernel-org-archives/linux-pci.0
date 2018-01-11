Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 11 Jan 2018 17:57:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 00/26] PCI: deprecate pci_get_bus_and_slot()
Message-ID: <20180111235727.GA113206@bhelgaas-glaptop.roam.corp.google.com>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 19, 2017 at 12:37:36AM -0500, Sinan Kaya wrote:
> Deprecate pci_get_bus_and_slot() in favor of pci_get_domain_bus_and_slot()
> in order to remove domain 0 assumptions in the kernel.
> 
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
> extract the domain number. Other places, use the actual domain number from
> the device.
> 
> Changes from v3:
> * rebase to linux-next
> * drop drm i915 as it is going through the drm tip
> * commit summary cleanups
> 
> Sinan Kaya (26):

I applied most of these on pci/deprecate-get-bus-and-slot for v4.16.
Details below:

>   alpha/PCI: deprecate pci_get_bus_and_slot()

Applied.

>   powerpc/PCI: deprecate pci_get_bus_and_slot()

Aplied with Michael's ack.

>   x86/PCI: deprecate pci_get_bus_and_slot()
>   ata: deprecate pci_get_bus_and_slot()
>   agp: nvidia: deprecate pci_get_bus_and_slot()
>   edd: deprecate pci_get_bus_and_slot()
>   ibft: deprecate pci_get_bus_and_slot()
>   drm/gma500: deprecate pci_get_bus_and_slot()
>   drm/nouveau: deprecate pci_get_bus_and_slot()

Applied.

>   Drivers: ide: deprecate pci_get_bus_and_slot()

Applied with David's ack.

>   iommu/amd: deprecate pci_get_bus_and_slot()

Applied with Gary's informal approval converted to
Reviewed-by: Gary R Hook <gary.hook@amd.com>.

>   powerpc/powermac: deprecate pci_get_bus_and_slot()

Applied.

>   bnx2x: deprecate pci_get_bus_and_slot()
>   pch_gbe: deprecate pci_get_bus_and_slot()

Applied with David's ack.

>   PCI: cpqhp: deprecate pci_get_bus_and_slot()
>   PCI: ibmphp: deprecate pci_get_bus_and_slot()

Applied.

>   PCI/quirks: deprecate pci_get_bus_and_slot()
>   PCI/syscall: deprecate pci_get_bus_and_slot()

Applied (squashed together).

>   xen: deprecate pci_get_bus_and_slot()

Applied.

>   openprom: deprecate pci_get_bus_and_slot()

Applied with David's ack.

>   backlight: deprecate pci_get_bus_and_slot()

Dropped because Lee applied it.

>   video: fbdev: intelfb: deprecate pci_get_bus_and_slot()
>   video: fbdev: nvidia: deprecate pci_get_bus_and_slot()
>   video: fbdev: riva: deprecate pci_get_bus_and_slot()

Applied with Bartlomiej's ack.

>   i7300_idle: remove unused file

Dropped because Greg KH picked it up.

>   PCI: Remove pci_get_bus_and_slot() function

Deferred so pull requests during the merge window can happen in any
order.  We can remove it at the end of the merge window or during the
next cycle.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
