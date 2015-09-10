Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36210 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227AbbIJJP5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2015 05:15:57 -0400
Received: by padhk3 with SMTP id hk3so37689758pad.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2015 02:15:57 -0700 (PDT)
Message-ID: <55F14A4E.80206@linaro.org>
Date: Thu, 10 Sep 2015 17:15:58 +0800
From: Hanjun Guo <hanjun.guo@linaro.org>
MIME-Version: 1.0
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org,
	catalin.marinas@arm.com, will.deacon@arm.com
CC: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 0/4] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
References: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
In-Reply-To: <1440597279-11802-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/26/2015 09:54 PM, Suravee Suthikulpanit wrote:
> This patch adds support to setup DMA coherency for PCI device using
> the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
> is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
> support for ARM64 which is currently in development.
>
> Also, this should not affect other architectures that does not define
> CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.
>
> I have included the following patch from Jeremy before cleaning up
> the acpi_check_dma() function (in patch 2).
>
>      http://www.spinics.net/lists/linux-usb/msg128582.html)
>
> Changes from V2: (https://lkml.org/lkml/2015/8/25/549)
>      * Return -ENOSUPP instead of -1 (per Rafael's suggestion)
>      * Add WARN() when fail to setup DMA for PCI device when booting
>        ACPI (per Arnd's suggestion)
>      * Added Acked-by from Rob.
>      * Minor clean up
>
> Changes from V1: (https://lkml.org/lkml/2015/8/13/182)
>      * Include patch 1 from Jeremy to enable support for _CCA=0
>      * Clean up acpi_check_dma() per Bjorn suggestions
>      * Split the original V1 patch into two patches (patch 3 and 4)
>
>
> Jeremy Linton (1):
>    Honor ACPI _CCA attribute setting
>
> Suravee Suthikulpanit (3):
>    ACPI/scan: Clean up acpi_check_dma
>    PCI: OF: Move of_pci_dma_configure() to pci_dma_configure()
>    PCI: ACPI: Add support for PCI device DMA coherency

For this series,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
