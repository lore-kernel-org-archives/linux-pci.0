Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:34271 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbeDMRXY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Apr 2018 13:23:24 -0400
Date: Fri, 13 Apr 2018 12:23:22 -0500
From: Rob Herring <robh@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: horms@verge.net.au, bhelgaas@google.com, linux-pci@vger.kernel.org,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 5/5] DT: pci: rcar-pci: document R8A77980 bindings
Message-ID: <20180413172322.k7nmtz3xnlaenvxq@rob-hp-laptop>
References: <26e803ca-06b6-28c5-b87c-fc639b322d6f@cogentembedded.com>
 <461a6029-1e03-a292-62d2-aca7de274de6@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <461a6029-1e03-a292-62d2-aca7de274de6@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 08, 2018 at 09:10:43PM +0300, Sergei Shtylyov wrote:
> Document the R-Car V3H (R8A77980) SoC in the R-Car PCIe bindings.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> Changes in version 2:
> - new patch.
> 
>  Documentation/devicetree/bindings/pci/rcar-pci.txt |    1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rob Herring <robh@kernel.org>
