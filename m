Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v9 09/16] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 iommu@lists.linux-foundation.org
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-10-lorenzo.pieralisi@arm.com>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <11ea77fa-688f-d31d-bd3c-35ca52e0a18b@linaro.org>
Date: Tue, 29 Nov 2016 20:17:58 +0800
MIME-Version: 1.0
In-Reply-To: <20161121100148.24769-10-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-acpi@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
 Tomasz Nowicki <tn@semihalf.com>, Joerg Roedel <joro@8bytes.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Will Deacon <will.deacon@arm.com>, Sinan Kaya <okaya@codeaurora.org>,
 Eric Auger <eric.auger@redhat.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Jon Masters <jcm@redhat.com>,
 Dennis Chen <dennis.chen@arm.com>, Prem Mallappa <prem.mallappa@broadcom.com>,
 Robin Murphy <robin.murphy@arm.com>, Nate Watterson <nwatters@codeaurora.org>
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
> In ARM ACPI systems, IOMMU components are specified through static
> IORT table entries. In order to create platform devices for the
> corresponding ARM SMMU components, IORT kernel code should be made
> able to parse IORT table entries and create platform devices
> dynamically.
>
> This patch adds the generic IORT infrastructure required to create
> platform devices for ARM SMMUs.
>
> ARM SMMU versions have different resources requirement therefore this
> patch also introduces an IORT specific structure (ie iort_iommu_config)
> that contains hooks (to be defined when the corresponding ARM SMMU
> driver support is added to the kernel) to be used to define the
> platform devices names, init the IOMMUs, count their resources and
> finally initialize them.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
