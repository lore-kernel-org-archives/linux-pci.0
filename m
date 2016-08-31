Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33081 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934973AbcHaPCi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Aug 2016 11:02:38 -0400
Date: Wed, 31 Aug 2016 10:02:36 -0500
From: Rob Herring <robh@kernel.org>
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: bhelgaas@google.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Niklas Cassel <niklass@axis.com>
Subject: Re: [PATCH RESEND] bindings: PCI: artpec: correct pci binding example
Message-ID: <20160831150236.GA10586@rob-hp-laptop>
References: <1472162516-8966-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472162516-8966-1-git-send-email-niklass@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Aug 26, 2016 at 12:01:56AM +0200, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@axis.com>
> 
>  - Increase config size. When using a PCIe switch,
>    the previous config size only had room for one device.
>  - Add bus range. Inherited optional property.
>  - Map downstream I/O to PCI address 0. We can map it to any
>    address, but let's be consistent with other drivers.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  Documentation/devicetree/bindings/pci/axis,artpec6-pcie.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

As this is just a binding change, I've applied it.

Rob
