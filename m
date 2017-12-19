Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41088 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753280AbdLSX23 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Dec 2017 18:28:29 -0500
Date: Tue, 19 Dec 2017 17:28:26 -0600
From: Rob Herring <robh@kernel.org>
To: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, adouglas@cadence.com,
        stelford@cadence.com, dgary@cadence.com, kgopi@cadence.com,
        eandrews@cadence.com, thomas.petazzoni@free-electrons.com,
        sureshp@cadence.com, nsekhar@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/9] dt-bindings: PCI: cadence: Add DT bindings for
 Cadence PCIe host controller
Message-ID: <20171219232826.odhkybf2xostfei2@rob-hp-laptop>
References: <cover.1513620412.git.cyrille.pitchen@free-electrons.com>
 <ee768eb717027e335d51313ef95bdd0399e54468.1513620412.git.cyrille.pitchen@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ee768eb717027e335d51313ef95bdd0399e54468.1513620412.git.cyrille.pitchen@free-electrons.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Dec 18, 2017 at 07:16:05PM +0100, Cyrille Pitchen wrote:
> From: Scott Telford <stelford@cadence.com>
> 
> This patch adds documentation for the DT bindings of the Cadence PCIe
> controller when configured in host (Root Complex) mode.
> 
> Signed-off-by: Scott Telford <stelford@cadence.com>
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@free-electrons.com>
> ---
>  .../bindings/pci/cdns,cdns-pcie-host.txt           | 60 ++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt

Reviewed-by: Rob Herring <robh@kernel.org>
