Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v9 14/16] drivers: acpi: iort: replace rid map type with
 type mask
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 iommu@lists.linux-foundation.org
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-15-lorenzo.pieralisi@arm.com>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <300db741-2ad9-3a44-13b3-03980ce3713c@linaro.org>
Date: Tue, 29 Nov 2016 20:29:16 +0800
MIME-Version: 1.0
In-Reply-To: <20161121100148.24769-15-lorenzo.pieralisi@arm.com>
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
> IORT tables provide data that allow the kernel to carry out
> device ID mappings between endpoints and system components
> (eg interrupt controllers, IOMMUs). When the mapping for a
> given device ID is carried out, the translation mechanism
> is done on a per-subsystem basis rather than a component
> subtype (ie the IOMMU kernel layer will look for mappings
> from a device to all IORT node types corresponding to IOMMU
> components), therefore the corresponding mapping API should
> work on a range (ie mask) of IORT node types corresponding
> to a common set of components (eg IOMMUs) rather than a
> specific node type.
>
> Upgrade the IORT iort_node_map_rid() API to work with a
> type mask instead of a single node type so that it can
> be used for mappings that span multiple components types
> (ie IOMMUs).
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
