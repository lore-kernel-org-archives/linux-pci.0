Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [PATCH v9 15/16] drivers: acpi: iort: add single mapping function
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-16-lorenzo.pieralisi@arm.com>
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
Message-ID: <dad19582-43ce-3882-1592-c99ee96d07fb@linaro.org>
Date: Wed, 30 Nov 2016 11:22:42 +0800
MIME-Version: 1.0
In-Reply-To: <20161121100148.24769-16-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
> The current IORT id mapping API requires components to provide
> an input requester ID (a Bus-Device-Function (BDF) identifier for
> PCI devices) to translate an input identifier to an output
> identifier through an IORT range mapping.
>
> Named components do not have an identifiable source ID therefore
> their respective input/output mapping can only be defined in
> IORT tables through single mappings, that provide a translation
> that does not require any input identifier.
>
> Current IORT interface for requester id mappings (iort_node_map_rid())
> is not suitable for components that do not provide a requester id,
> so it cannot be used for IORT named components.
>
> Add an interface to the IORT API to enable retrieval of id
> by allowing an indexed walk of the single mappings array for
> a given component, therefore completing the IORT mapping API.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
