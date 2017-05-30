Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 30 May 2017 12:28:31 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 6/7] iommu/arm-smmu-v3: Add support for PCI ATS
Message-ID: <20170530102831.GJ2818@8bytes.org>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
 <20170524180143.19855-7-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
In-Reply-To: <20170524180143.19855-7-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, thunder.leizhen@huawei.com, rjw@rjwysocki.net,
 will.deacon@arm.com, okaya@codeaurora.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, bhelgaas@google.com, tn@semihalf.com,
 sunil.kovvuri@gmail.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 24, 2017 at 07:01:42PM +0100, Jean-Philippe Brucker wrote:
> * TLB invalidation by range is batched and committed with a single sync.
>   Batching ATC invalidation is inconvenient, endpoints limit the number of
>   inflight invalidations. We'd have to count the number of invalidations
>   queued and send a sync periodically. In addition, I suspect we always
>   need a sync between TLB and ATC invalidation for the same page.

This sounds like the number of outstanding ATS invalidations is not
managed by the SMMU hardware, is that right?


	Joerg


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
