Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Taku Izumi" <izumi.taku@jp.fujitsu.com>
To: "'Yinghai Lu'" <yinghai@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"'Len Brown'" <lenb@kernel.org>,
	"'Jiang Liu'" <jiang.liu@huawei.com>
References: <20121030040237.GA10472@google.com> <1351618965-16761-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1351618965-16761-1-git-send-email-yinghai@kernel.org>
Subject: RE: 
Date: Tue, 6 Nov 2012 14:03:42 +0900
Message-ID: <0b3b01cdbbdc$18597ed0$490c7c70$@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  Reviewed and tested by Taku Izumi <izumi.taku@jp.fujitsu.com>

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org] On Behalf Of Yinghai Lu
> Sent: Wednesday, October 31, 2012 2:43 AM
> To: Bjorn Helgaas; Len Brown; Taku Izumi; Jiang Liu
> Cc: linux-pci@vger.kernel.org; linux-acpi@vger.kernel.org; Yinghai Lu
> Subject:
> 
> Subject: [PATCH resend 0/8] PCI, ACPI, x86: pci root bus hotplug support resources assign and remove path
> 
> 1. add support for assign resource for hot add path.
> 2. stop and remove root bus during acpi root remove.
> 
> 
> could get from
>         git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git for-pci-root-bus-hotplug
> 
> Yinghai Lu (8):
>   PCI: Separate out pci_assign_unassigned_bus_resources()
>   PCI: Move pci_rescan_bus() back to probe.c
>   PCI: Move out pci_enable_bridges out of assign_unsigned_bus_res
>   PCI, ACPI: assign unassigned resource for hot add root bus
>   PCI: Add pci_stop/remove_root_bus()
>   PCI, ACPI: Make acpi_pci_root_remove stop/remove pci root bus
>   PCI, ACPI: delete root bus prt during hot remove path
>   PCI, ACPI: remove acpi_root_driver in reserse order
> 
>  drivers/acpi/pci_root.c |   21 ++++++++++++++++++++-
>  drivers/pci/probe.c     |   22 ++++++++++++++++++++++
>  drivers/pci/remove.c    |   36 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/setup-bus.c |   22 +---------------------
>  include/linux/pci.h     |    3 +++
>  5 files changed, 82 insertions(+), 22 deletions(-)
> 
> --
> 1.7.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


