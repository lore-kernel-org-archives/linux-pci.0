Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbdHHOUt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Aug 2017 10:20:49 -0400
MIME-Version: 1.0
In-Reply-To: <1502167455-10516-3-git-send-email-oza.oza@broadcom.com>
References: <1502167455-10516-1-git-send-email-oza.oza@broadcom.com> <1502167455-10516-3-git-send-email-oza.oza@broadcom.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 8 Aug 2017 09:20:26 -0500
Message-ID: <CAL_JsqL3dWA-0Sq-_8ufa-cwXZEbFQBJHCK-5wLp_xw5NrTHKw@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: iproc: Add optional brcm,pci-hotplug
To: Oza Pawandeep <oza.oza@broadcom.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com"
        <bcm-kernel-feedback-list@broadcom.com>,
        Andy Gospodarek <gospo@broadcom.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oza Pawandeep <oza.pawandeep@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Please send bindings to DT list.

On Mon, Aug 7, 2017 at 11:44 PM, Oza Pawandeep <oza.oza@broadcom.com> wrote:
> Add description for optional device tree property
> 'brcm,pci-hotplug' for PCI hotplug feature.
>
> Signed-off-by: Oza Pawandeep <oza.oza@broadcom.com>
> Reviewed-by: Ray Jui <ray.jui@broadcom.com>
>
> diff --git a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> index b8e48b4..a3bad24 100644
> --- a/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> +++ b/Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
> @@ -72,6 +72,29 @@ Optional properties:
>  - brcm,pcie-msi-inten: Needs to be present for some older iProc platforms that
>  require the interrupt enable registers to be set explicitly to enable MSI
>
> +Optional properties:
> +- brcm,pci-hotplug: PCI hotplug feature is supported.

I think we should make this a common property. We already have
"ibm,slot-pluggable", so I'd propose "slot-pluggable".

There's also "hotpluggable" for memory nodes defined, so we could
reuse that here.

> +
> +If the brcm,pcie-hotplug property is present, the following properties become
> +effective:
> +
> +- brcm,prsnt-gpio: Array of gpios, needs to be present if Hotplug is supported.

prsnt-gpios

> +
> +PCI hotplug implementation is SOC/Board specific, and also it depends on
> +how add-in card is designed (e.g. how many present pins are implemented).
> +
> +If x8 card is connected, then it might be possible that all the
> +3 present pins could go low, or at least one pin goes low.
> +
> +If x4 card is connected, then it might be possible that 2 present
> +pins go low, or at least one pin goes low.
> +
> +Example:
> +brcm,prsnt-gpio: <&pca9505 32 1>, <&pca9505 33 1>;
> +This is x4 connector: monitoring max 2 present lines.
> +brcm,prsnt-gpio: <&pca9505 32 1>, <&pca9505 33 1>, <&pca9505 34 1>;
> +This is x8 connector: monitoring max 3 present lines.
> +
>  Example:
>         pcie0: pcie@18012000 {
>                 compatible = "brcm,iproc-pcie";
> --
> 1.9.1
>
