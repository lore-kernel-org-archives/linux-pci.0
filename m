Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 31 Aug 2017 08:39:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Oza Pawandeep <oza.oza@broadcom.com>
Subject: Re: [PATCH v6 0/3] PCI hotplug feature
Message-ID: <20170831133951.GA8154@bhelgaas-glaptop.roam.corp.google.com>
References: <1504155029-24729-1-git-send-email-oza.oza@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <1504155029-24729-1-git-send-email-oza.oza@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Scott Branden <sbranden@broadcom.com>, Oza Pawandeep <oza.pawandeep@gmail.com>,
 Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Andy Gospodarek <gospo@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 31, 2017 at 10:20:26AM +0530, Oza Pawandeep wrote:
> These patches bring in PCI hotplug support for iproc family chipsets.
> 
> It includes DT binding documentation and, the implementation in
> iproc pcie RC driver.
> 
> Changes since v5:
> [RESEND]

Not sure what the point of resending this as v6 was, since v5 was
posted 6 minutes earlier and you don't mention any changes in v6?

> Changes since v4:
> Rebased to pci-next
> Added; Acked-by: Rob Herring <robh@kernel.org>
> 
> Changes since v3:
> Resend. just to be in sync previous in-flight patches.
> 
> Changes since v2:
> Addressed Rob Herring's comments.
> Changed subject to "dt-bindings: PCI:..."
> Made generic PCI hotplug properties 'slot-pluggable' and 'prsnt-gpios'
> Rebased the patches on top of Lorenzo's patches.
> 
> Oza Pawandeep (3):
>   dt-bindings: PCI: Add PCI hotplug property
>   dt-bindings: PCI iproc: Implement optional property prsnt-gpios
>   PCI: iproc: Implement PCI hotplug support
> 
>  .../devicetree/bindings/pci/brcm,iproc-pcie.txt    |  14 ++
>  Documentation/devicetree/bindings/pci/pci.txt      |  15 ++
>  drivers/pci/host/pcie-iproc-platform.c             |   3 +
>  drivers/pci/host/pcie-iproc.c                      | 166 ++++++++++++++++++---
>  drivers/pci/host/pcie-iproc.h                      |   7 +
>  5 files changed, 187 insertions(+), 18 deletions(-)
> 
> -- 
> 1.9.1
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
