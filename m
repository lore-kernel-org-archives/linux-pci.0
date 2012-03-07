MIME-Version: 1.0
In-Reply-To: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
References: <1331018040-30725-1-git-send-email-yinghai@kernel.org>
Date: Tue, 6 Mar 2012 21:44:34 -0700
Message-ID: <CABhMZUU_YNMXAU0Mr5zQMzxrk_XkFzk1HrwAN0SQxDf8n+F9kA@mail.gmail.com>
Subject: Re: [PATCH 00/23] PCI, x86: pci root bus hotplug support
From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 6, 2012 at 12:13 AM, Yinghai Lu <yinghai@kernel.org> wrote:
> will add pci_stop_and_remove_bus() to support remove bus in
> /sys/devices/pci.../pci_bus/...
>
> it support pci root bus removal.

Does this series support hot-add, too, or just removal?

If it is intended to support hot-add, I didn't see any support for
_CBA, which I *think* is the way hotplug-capable host bridges are
required to report MMCONFIG areas.

> To rescan root, need to
> echo 1 > /sys/bus/pci/rescan_root
>
> this patcheset include some IOMM and dmar and pnpacpi fix with device ref=
count leaking.
>
> The patches need to apply to pci/for-linus and pci/linux-next
> and [PATCH 00/36] PCI: pci_host_bridge related cleanup and busn_alloc
>
> could get from
> =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linu=
x-yinghai.git for-pci-root-bus-hotplug
>
> Thanks
>
> Yinghai
>
> Yinghai Lu (23):
> =A0PCI, sys: Use device_type and attr_groups with pci dev
> =A0PCI, sysfs: create rescan_bridge under /sys/.../pci/devices/... for pc=
i bridges
> =A0PCI: Add pci_bus_add_single_device()
> =A0PCI: make pci_rescan_bus_bridge_resize use pci_scan_bridge instead
> =A0PCI: clean up rescan_bus_bridge_resize
> =A0PCI: rescan with bus or bridge using callback method too
> =A0pci, dmar: Update dmar units devices list during hotplug
> =A0PNPACPI: Fix device ref leaking in acpi_pnp_match
> =A0IOMMU: Fix tboot force iommu logic
> =A0PCI, x86: Fix non acpi path pci_sysdata leaking with release_fn
> =A0PCI: separate out pci_assign_unassigned_bus_resources()
> =A0PCI: Move back pci_rescan_bus()
> =A0PCI: move pci_stop_and_remove_behind_bridge down
> =A0PCI: add __pci_remove_bus_devices()
> =A0PCI: add pci_stop_and_remove_bus()
> =A0PCI: add pci bus removal through /sys/.../pci_bus/.../remove
> =A0PCI, ACPI: make acpi_pci_root_remove remove pci root bus too
> =A0PCI, ACPI: add acpi_pci_root_rescan()
> =A0PCI: add /sys/bus/pci/rescan_root
> =A0PCI: add __pci_scan_root_bus() that can skip bus_add
> =A0x86, PCI: add __pci_scan_root_bus_on_node() that can skip bus_add
> =A0x86, PCI: add __pcibios_scan_specific_bus that can skip bus_add
> =A0x86, PCI: add pcibios_root_rescan
>
> =A0Documentation/ABI/testing/sysfs-bus-pci | =A0 27 +++++
> =A0arch/x86/include/asm/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0arch/x86/pci/common.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 28 +++=
--
> =A0arch/x86/pci/legacy.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 44 +++=
+++-
> =A0drivers/acpi/pci_root.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 66 +++++=
++++++
> =A0drivers/iommu/intel-iommu.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0193 +++++++++=
+++++++++++++++++++--
> =A0drivers/pci/bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 39=
 ++++++
> =A0drivers/pci/pci-sysfs.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0137 +++++=
+++++++++++++++--
> =A0drivers/pci/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 +
> =A0drivers/pci/probe.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 43 +=
+++++-
> =A0drivers/pci/remove.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 77 +=
+++++++-----
> =A0drivers/pci/setup-bus.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 20 +---
> =A0drivers/pnp/pnpacpi/core.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07 +-
> =A0include/linux/dmar.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04=
 +
> =A0include/linux/pci.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A06=
 +
> =A015 files changed, 604 insertions(+), 90 deletions(-)
>
> --
> 1.7.7
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
