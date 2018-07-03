Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34449 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeGCVBv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Jul 2018 17:01:51 -0400
Date: Tue, 3 Jul 2018 15:01:48 -0600
From: Rob Herring <robh@kernel.org>
To: Alan Douglas <adouglas@cadence.com>
Cc: bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: PCI: cadence: Add DT bindings for
 optional PHYs
Message-ID: <20180703210148.GA29718@rob-hp-laptop>
References: <1529915453-4633-1-git-send-email-adouglas@cadence.com>
 <1529915453-4633-4-git-send-email-adouglas@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529915453-4633-4-git-send-email-adouglas@cadence.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2018 at 09:30:51AM +0100, Alan Douglas wrote:
> Update DT documentation to include optional PHYs for cadence PCIe
> host and endpoint controllers.
> 
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |    5 +++++
>  .../bindings/pci/cdns,cdns-pcie-host.txt           |    6 ++++++
>  2 files changed, 11 insertions(+), 0 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
