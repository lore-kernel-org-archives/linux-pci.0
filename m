Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34808 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754082AbcKPA4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Nov 2016 19:56:37 -0500
MIME-Version: 1.0
In-Reply-To: <20161109141948.19244-17-lorenzo.pieralisi@arm.com>
References: <20161109141948.19244-1-lorenzo.pieralisi@arm.com> <20161109141948.19244-17-lorenzo.pieralisi@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Nov 2016 01:56:35 +0100
Message-ID: <CAJZ5v0jmEi+PZ8gGBYOjQi0CZ+0PNEZZ2uHGLcavtZWH+iiXTw@mail.gmail.com>
Subject: Re: [PATCH v7 16/16] drivers: acpi: iort: introduce iort_iommu_configure
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Nov 9, 2016 at 3:19 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> DT based systems have a generic kernel API to configure IOMMUs
> for devices (ie of_iommu_configure()).
>
> On ARM based ACPI systems, the of_iommu_configure() equivalent can
> be implemented atop ACPI IORT kernel API, with the corresponding
> functions to map device identifiers to IOMMUs and retrieve the
> corresponding IOMMU operations necessary for DMA operations set-up.
>
> By relying on the iommu_fwspec generic kernel infrastructure,
> implement the IORT based IOMMU configuration for ARM ACPI systems
> and hook it up in the ACPI kernel layer that implements DMA
> configuration for a device.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>

For the ACPI core part:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
