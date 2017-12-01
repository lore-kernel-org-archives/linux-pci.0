Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
From: Sinan Kaya <okaya@codeaurora.org>
To: linux-pci@vger.kernel.org,
	timur@codeaurora.org
Subject: [PATCH V4 1/5] Documentation: DT: qcom_hidma: Bump HW revision for
 the bugfixed HW
Date: Thu, 30 Nov 2017 21:52:52 -0500
Message-Id: <1512096776-22883-2-git-send-email-okaya@codeaurora.org>
In-Reply-To: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
References: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Vinod Koul <vinod.koul@intel.com>,
 linux-arm-msm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Sinan Kaya <okaya@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

A new version of the HIDMA IP has been released with bug fixes. Bumping the
hardware version to differentiate from others.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
index 55492c2..5d93d6d 100644
--- a/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
+++ b/Documentation/devicetree/bindings/dma/qcom_hidma_mgmt.txt
@@ -47,8 +47,8 @@ When the OS is not in control of the management interface (i.e. it's a guest),
 the channel nodes appear on their own, not under a management node.
 
 Required properties:
-- compatible: must contain "qcom,hidma-1.0" for initial HW or "qcom,hidma-1.1"
-for MSI capable HW.
+- compatible: must contain "qcom,hidma-1.0" for initial HW or
+  "qcom,hidma-1.1"/"qcom,hidma-1.2" for MSI capable HW.
 - reg: Addresses for the transfer and event channel
 - interrupts: Should contain the event interrupt
 - desc-count: Number of asynchronous requests this channel can handle
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
