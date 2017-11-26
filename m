Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44204 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdKZTdy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Nov 2017 14:33:54 -0500
Date: Sun, 26 Nov 2017 13:33:50 -0600
From: Rob Herring <robh@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: PCI: cadence: Add DT bindings for
 Cadence PCIe endpoint controller
Message-ID: <20171126193350.4ortdptrxdibnyot@rob-hp-laptop>
References: <cover.1511439189.git.cyrille.pitchen@free-electrons.com>
 <0a11e9742db04fd5b4bc08568b3ab5a056a0ef9d.1511439189.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0a11e9742db04fd5b4bc08568b3ab5a056a0ef9d.1511439189.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Nov 23, 2017 at 04:01:49PM +0100, Cyrille Pitchen wrote:
> This patch documents the DT bindings for the Cadence PCIe controller
> when configured in endpoint mode.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt    | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt

Acked-by: Rob Herring <robh@kernel.org>
