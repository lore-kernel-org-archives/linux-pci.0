Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH v9 08/16] drivers: acpi: iort: add node match function
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 iommu@lists.linux-foundation.org
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-9-lorenzo.pieralisi@arm.com>
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <07ed6a31-c791-8832-530c-42ac58806848@linaro.org>
Date: Tue, 29 Nov 2016 20:14:41 +0800
MIME-Version: 1.0
In-Reply-To: <20161121100148.24769-9-lorenzo.pieralisi@arm.com>
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
> Device drivers (eg ARM SMMU) need to know if a specific component
> is part of the IORT table, so that kernel data structures are not
> initialized at initcalls time if the respective component is not
> part of the IORT table.
>
> To this end, this patch adds a trivial function that allows detecting
> if a given IORT node type is present or not in the ACPI table, providing
> an ACPI IORT equivalent for of_find_matching_node().
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
