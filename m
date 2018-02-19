Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Sun, 18 Feb 2018 20:51:07 -0600
From: Rob Herring <robh@kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 11/37] dt-bindings: document stall and PASID properties
 for IOMMU masters
Message-ID: <20180219025107.v3f3eapukupm7g5j@rob-hp-laptop>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-12-jean-philippe.brucker@arm.com>
MIME-Version: 1.0
In-Reply-To: <20180212183352.22730-12-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, ilias.apalodimas@linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org, xuzaibo@huawei.com,
 jonathan.cameron@huawei.com, will.deacon@arm.com, okaya@codeaurora.org,
 lorenzo.pieralisi@arm.com, ashok.raj@intel.com, tn@semihalf.com,
 joro@8bytes.org, robdclark@gmail.com, bharatku@xilinx.com,
 linux-acpi@vger.kernel.org, catalin.marinas@arm.com, rfranz@cavium.com,
 lenb@kernel.org, devicetree@vger.kernel.org, jacob.jun.pan@linux.intel.com,
 alex.williamson@redhat.com, yi.l.liu@intel.com, thunder.leizhen@huawei.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
 shunyong.yang@hxt-semitech.com, dwmw2@infradead.org, liubo95@huawei.com,
 rjw@rjwysocki.net, jcrouse@codeaurora.org, iommu@lists.linux-foundation.org,
 hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com,
 christian.koenig@amd.com, nwatters@codeaurora.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 12, 2018 at 06:33:26PM +0000, Jean-Philippe Brucker wrote:
> On ARM systems, some platform devices behind an IOMMU may support stall
> and PASID features. Stall is the ability to recover from page faults and
> PASID offers multiple process address spaces to the device. Together they
> allow to do paging with a device. Let the firmware tell us when a device
> supports stall and PASID.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  Documentation/devicetree/bindings/iommu/iommu.txt | 24 +++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt
> index 5a8b4624defc..8066b3852110 100644
> --- a/Documentation/devicetree/bindings/iommu/iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/iommu.txt
> @@ -86,6 +86,30 @@ have a means to turn off translation. But it is invalid in such cases to
>  disable the IOMMU's device tree node in the first place because it would
>  prevent any driver from properly setting up the translations.
>  
> +Optional properties:
> +--------------------
> +- dma-can-stall: When present, the master can wait for a transaction to
> +  complete for an indefinite amount of time. Upon translation fault some
> +  IOMMUs, instead of aborting the translation immediately, may first
> +  notify the driver and keep the transaction in flight. This allows the OS
> +  to inspect the fault and, for example, make physical pages resident
> +  before updating the mappings and completing the transaction. Such IOMMU
> +  accepts a limited number of simultaneous stalled transactions before
> +  having to either put back-pressure on the master, or abort new faulting
> +  transactions.
> +
> +  Firmware has to opt-in stalling, because most buses and masters don't
> +  support it. In particular it isn't compatible with PCI, where
> +  transactions have to complete before a time limit. More generally it
> +  won't work in systems and masters that haven't been designed for
> +  stalling. For example the OS, in order to handle a stalled transaction,
> +  may attempt to retrieve pages from secondary storage in a stalled
> +  domain, leading to a deadlock.
> +
> +- pasid-bits: Some masters support multiple address spaces for DMA, by
> +  tagging DMA transactions with an address space identifier. By default,
> +  this is 0, which means that the device only has one address space.

So 3 would mean 8 address spaces?

Maybe pasid-num-bits would be a bit clearer. Either way,

Reviewed-by: Rob Herring <robh@kernel.org>

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
