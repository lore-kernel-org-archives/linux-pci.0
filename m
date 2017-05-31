Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 31 May 2017 12:17:48 -0500
From: Rob Herring <robh@kernel.org>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 2/7] dt-bindings: PCI: Describe ATS property for root
 complex nodes
Message-ID: <20170531171748.rcrwpkgqgx7lin23@rob-hp-laptop>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
 <20170524180143.19855-3-jean-philippe.brucker@arm.com>
 <20170530100153.GI2818@8bytes.org>
 <035be7ba-e850-a5a9-08fa-802a04feb600@arm.com>
MIME-Version: 1.0
In-Reply-To: <035be7ba-e850-a5a9-08fa-802a04feb600@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
 linux-pci@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
 thunder.leizhen@huawei.com, rjw@rjwysocki.net, will.deacon@arm.com,
 okaya@codeaurora.org, linux-acpi@vger.kernel.org,
 iommu@lists.linux-foundation.org, hanjun.guo@linaro.org, sudeep.holla@arm.com,
 bhelgaas@google.com, tn@semihalf.com, sunil.kovvuri@gmail.com,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, lenb@kernel.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 30, 2017 at 11:58:50AM +0100, Jean-Philippe Brucker wrote:
> On 30/05/17 11:01, Joerg Roedel wrote:
> > On Wed, May 24, 2017 at 07:01:38PM +0100, Jean-Philippe Brucker wrote:
> >> +- ats-supported: if present, the root complex supports the Address
> >> +  Translation Service (ATS). It is able to interpret the AT field in PCIe
> >> +  Transaction Layer Packets, and forward Translation Completions or
> >> +  Invalidation Requests to endpoints.
> >> +
> >> +  Device drivers should not enable ATS in endpoints unless this property
> >> +  is present.
> > 
> > Device drivers should never enable ATS, this is the job of the IOMMU
> > driver. This should be clarified in the text.
> 
> Right, I will change this.

Driver details should not be in DT to begin with.

Rob

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
