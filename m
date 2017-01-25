Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33545 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdAYEdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2017 23:33:22 -0500
Received: by mail-pf0-f177.google.com with SMTP id y143so55180358pfb.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Jan 2017 20:33:22 -0800 (PST)
Subject: Re: [PATCH V7 00/11] IOMMU probe deferral support
To: Sricharan R <sricharan@codeaurora.org>, robin.murphy@arm.com,
        will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <dc2a024b-2378-3a67-f098-8f2b42982766@linaro.org>
Date: Wed, 25 Jan 2017 12:33:18 +0800
MIME-Version: 1.0
In-Reply-To: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2017/1/24 0:18, Sricharan R wrote:
> This series calls the dma ops configuration for the devices
> at a generic place so that it works for all busses.
> The dma_configure_ops for a device is now called during
> the device_attach callback just before the probe of the
> bus/driver is called. Similarly dma_deconfigure is called during
> device/driver_detach path.
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
> Took the reworked patches [2] from Robin's branch and
> rebased on top of Lorenzo's ACPI IORT ARM support series [3].
>
> * Tested with platform and pci devices for probe deferral
>   and reprobe on arm64 based platform.
> * Need help for testing with ACPI.

Cherry picked this patch set with no conflict with my platform
msi patches, and test it on Hisilicon D03 (ARM64 platform with
SMMUv3) with ACPI, it boots ok as before and the native NIC and
SAS (platform devices) are working properly.

for ACPI and the core code changes:

Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
