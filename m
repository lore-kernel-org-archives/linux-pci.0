Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33023 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdLSX3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 18:29:14 -0500
Date: Tue, 19 Dec 2017 17:29:11 -0600
From: Rob Herring <robh@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 8/9] dt-bindings: PCI: cadence: Add DT bindings for
 Cadence PCIe endpoint controller
Message-ID: <20171219232911.pazvsyc2iybyc7yy@rob-hp-laptop>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <e3cba0ecfa9189153e7dd7589dd63814315b3d87.1513620412.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e3cba0ecfa9189153e7dd7589dd63814315b3d87.1513620412.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 18, 2017 at 07:16:08PM +0100, Cyrille Pitchen wrote:
> This patch documents the DT bindings for the Cadence PCIe controller
> when configured in endpoint mode.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt

Reviewed-by: Rob Herring <robh@kernel.org>
