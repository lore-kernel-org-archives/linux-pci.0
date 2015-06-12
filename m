Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750893AbbFLJE5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 12 Jun 2015 05:04:57 -0400
Message-ID: <557AA0B2.9050000@redhat.com>
Date: Fri, 12 Jun 2015 11:04:50 +0200
From: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>
MIME-Version: 1.0
To: Duc Dang <dhdang@apm.com>, Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ian Campbell <ian.campbell@citrix.com>,
	Tanmay Inamdar <tinamdar@apm.com>, patches@apm.com
Subject: Re: [PATCH 1/1] PCI: X-Gene: Disable Configuration Request Retry
 Status for X-Gene v1 PCIe
References: <1434053294-10962-1-git-send-email-dhdang@apm.com>
In-Reply-To: <1434053294-10962-1-git-send-email-dhdang@apm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

W dniu 11.06.2015 o 22:08, Duc Dang pisze:> X-Gene v1 PCIe controller has a bug in Configuration Request Retry
> Status (CRS) logic:
>    When CPU tries to read Vendor ID and Device ID of not-existed
>    remote device, the controller returns 0xFFFF0001 instead of
>    0xFFFFFFFF; this will add significant delay in boot time as
>    pci_bus_read_dev_vendor_id will wait for 60 seconds before
>    giving up.
> 
> So for X-Gene v1 PCIe controllers, disable CRS capability
> advertisement by clearing CRS Software Visibility bit before
> returning the Root Capability value to the callers. This is done
> by implementing X-Gene PCIe specific xgene_pcie_config_read32 for
> CFG read accesses to replace the generic default pci_generic_config_read32
> function.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>
> ---
>   drivers/pci/host/pci-xgene.c | 48 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 47 insertions(+), 1 deletion(-)

Tested-by: Marcin Juszkiewicz <mjuszkiewicz@redhat.com>

Confirmed. It fixed issue.

[    0.842339] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.848235] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.855255] PCI host bridge /soc/pcie@1f2b0000 ranges:
[    0.860678]   No bus range found for /soc/pcie@1f2b0000, using [bus 00-ff]
[    0.867950]    IO 0xe010000000..0xe01000ffff -> 0x00000000
[    0.873753]   MEM 0xe180000000..0xe1ffffffff -> 0x80000000
[    0.879592] xgene-pcie 1f2b0000.pcie: (rc) x1 gen-1 link up
[    0.885529] xgene-pcie 1f2b0000.pcie: PCI host bridge to bus 0000:00
[    0.892248] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.898036] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.904556] pci_bus 0000:00: root bus resource [mem 0xe180000000-0xe1ffffffff] (bus address [0x80000000-0xffffffff])
[    0.915741] pci 0000:00:00.0: IOMMU is currently not supported for PCI
[    0.922936] pci 0000:01:00.0: IOMMU is currently not supported for PCI
[    0.929937] pci 0000:01:00.0: of_irq_parse_pci() failed with rc=-19
[    0.936616] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
[    0.947422] pci 0000:02:00.0: IOMMU is currently not supported for PCI
[    0.954439] vgaarb: device added: PCI:0000:02:00.0,decodes=io+mem,owns=none,locks=none
[    0.962946] pci 0000:00:00.0: BAR 14: assigned [mem 0xe180000000-0xe182ffffff]
[    0.970593] pci 0000:01:00.0: BAR 14: assigned [mem 0xe180000000-0xe182ffffff]
[    0.978239] pci 0000:02:00.0: BAR 0: assigned [mem 0xe180000000-0xe181ffffff pref]
[    0.986260] pci 0000:02:00.0: BAR 2: assigned [mem 0xe182000000-0xe1827fffff]
[    0.993828] pci 0000:02:00.0: BAR 6: assigned [mem 0xe182800000-0xe18281ffff pref]
[    1.001852] pci 0000:02:00.0: BAR 1: assigned [mem 0xe182820000-0xe182823fff]
[    1.009397] pci 0000:01:00.0: PCI bridge to [bus 02]
[    1.014637] pci 0000:01:00.0:   bridge window [mem 0xe180000000-0xe182ffffff]
[    1.022200] pci 0000:00:00.0: PCI bridge to [bus 01-02]
[    1.027713] pci 0000:00:00.0:   bridge window [mem 0xe180000000-0xe182ffffff]
[    1.035344] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
[    1.042709] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    1.049577] pci 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    1.056538] pci 0000:01:00.0: TI XIO2000a quirk detected; secondary bus fast back-to-back transfers disabled

compared to

[ 2040.117742] pci 0000:00:00.0: BAR 14: assigned [mem 0xe180000000-0xe182ffffff]

Similar with Radeon card.
