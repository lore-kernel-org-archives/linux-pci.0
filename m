Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36055 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753383AbcK3D1E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2016 22:27:04 -0500
Received: by mail-pf0-f179.google.com with SMTP id 189so36006074pfz.3
        for <linux-pci@vger.kernel.org>; Tue, 29 Nov 2016 19:27:04 -0800 (PST)
Subject: Re: [PATCH v9 16/16] drivers: acpi: iort: introduce
 iort_iommu_configure
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-17-lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <af73cb66-6da9-1457-4333-78e7866326fd@linaro.org>
Date: Wed, 30 Nov 2016 11:26:38 +0800
MIME-Version: 1.0
In-Reply-To: <20161121100148.24769-17-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
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
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> [ACPI core]
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
