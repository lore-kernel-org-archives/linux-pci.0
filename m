Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux-foundation.org
Subject: [PATCH 2/7] dt-bindings: PCI: Describe ATS property for root complex
 nodes
Date: Wed, 24 May 2017 19:01:38 +0100
Message-Id: <20170524180143.19855-3-jean-philippe.brucker@arm.com>
In-Reply-To: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, will.deacon@arm.com,
 joro@8bytes.org, thunder.leizhen@huawei.com, rjw@rjwysocki.net,
 okaya@codeaurora.org, robh+dt@kernel.org, hanjun.guo@linaro.org,
 sudeep.holla@arm.com, bhelgaas@google.com, tn@semihalf.com,
 sunil.kovvuri@gmail.com, robin.murphy@arm.com, lenb@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Address Translation Service (ATS) is an extension to PCIe allowing
endpoints to manage their own IOTLB, called Address Translation Cache
(ATC). Instead of having every memory transaction processed by the IOMMU,
the endpoint can first send an Address Translation Requests for an IOVA,
obtain the corresponding Physical Address from the IOMMU and store it in
its ATC. Subsequent transactions to this memory region can be performed on
the PA, in which case they are marked 'translated' and (partially) bypass
the IOMMU.

Since the extension uses fields that were previously reserved in the
PCIe Translation Layer Packet, it seems ill-advised to enabled it on a
system that doesn't fully support ATS.

To "old" root complexes that simply ignored the new AT field, an Address
Translation Request will look exactly like a Memory Read Request, so the
root bridge will forward a memory read to the IOMMU instead of a
translation request. If the access succeeds, the RC will send a Read
Completion, which looks like a Translation Completion, back to the
endpoint. As a result the endpoint might end up storing the content of
memory instead of a physical address in its ATC. In reality, it's more
likely that the size fields will be invalid and either end will detect the
error, but in any case, it is undesirable.

Add a way for firmware to tell the OS that ATS is supported by the PCI
root complex.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 Documentation/devicetree/bindings/pci/pci-iommu.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
index 0def586fdcdf..f21a68ec471a 100644
--- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
+++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
@@ -44,6 +44,14 @@ Optional properties
 - iommu-map-mask: A mask to be applied to each Requester ID prior to being
   mapped to an IOMMU specifier per the iommu-map property.
 
+- ats-supported: if present, the root complex supports the Address
+  Translation Service (ATS). It is able to interpret the AT field in PCIe
+  Transaction Layer Packets, and forward Translation Completions or
+  Invalidation Requests to endpoints.
+
+  Device drivers should not enable ATS in endpoints unless this property
+  is present.
+
 
 Example (1)
 ===========
-- 
2.12.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
