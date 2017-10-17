Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:50095 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758529AbdJQTwR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2017 15:52:17 -0400
Date: Tue, 17 Oct 2017 14:52:14 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Correct example to match reality
Message-ID: <20171017195214.xs27wrtztdpzy76y@rob-hp-laptop>
References: <1507729813-21501-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507729813-21501-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 11, 2017 at 03:50:13PM +0200, Geert Uytterhoeven wrote:
> Correct the USB subnodes in the example, cfr. commit f7d569c1e6a6fa73
> ("ARM: dts: r8a779x: Fix PCI bus dtc warnings"):
>   1. Drop the bogus 'device_type = "pci"' properties,
>   2. Correct the unit addresses.
> 
> Update other bits in the example to match real use:
>   1. Rename the USB subnodes from "pci" to "usb",
>   2. Update the "phys" property.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
