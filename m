Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34534 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbdA3HJU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Jan 2017 02:09:20 -0500
MIME-Version: 1.0
In-Reply-To: <1485188293-20263-7-git-send-email-sricharan@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org> <1485188293-20263-7-git-send-email-sricharan@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 30 Jan 2017 08:09:18 +0100
Message-ID: <CAJZ5v0jv-q_EeNhJ4F11yPS85aeD7YFQMcpH+fctTFL12Mk4XQ@mail.gmail.com>
Subject: Re: [PATCH V7 06/11] of/acpi: Configure dma operations at probe time
 for platform/amba/pci bus devices
To: Sricharan R <sricharan@codeaurora.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jan 23, 2017 at 5:18 PM, Sricharan R <sricharan@codeaurora.org> wrote:
> Configuring DMA ops at probe time will allow deferring device probe when
> the IOMMU isn't available yet. The dma_configure for the device is
> now called from the generic device_attach callback just before the
> bus/driver probe is called. This way, configuring the DMA ops for the
> device would be called at the same place for all bus_types, hence the
> deferred probing mechanism should work for all buses as well.
>
> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>        |                         |
> pci_bus_add_device     (device_add/driver_register)
>        |                         |
> device_attach           device_initial_probe
>        |                         |
> __device_attach_driver    __device_attach_driver
>        |
> driver_probe_device
>        |
> really_probe
>        |
> dma_configure
>
> Similarly on the device/driver_unregister path __device_release_driver is
> called which inturn calls dma_deconfigure.
>
> This patch changes the dma ops configuration to probe time for
> both OF and ACPI based platform/amba/pci bus devices.
>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
