Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:54570 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdJKQNX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2017 12:13:23 -0400
Received: by mail-lf0-f41.google.com with SMTP id d10so2667935lfg.11
        for <linux-pci@vger.kernel.org>; Wed, 11 Oct 2017 09:13:22 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: PCI: rcar: Correct example to match reality
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <1507729813-21501-1-git-send-email-geert+renesas@glider.be>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <850057d8-19dd-6eb8-7f0d-2a147196feaa@cogentembedded.com>
Date: Wed, 11 Oct 2017 19:13:19 +0300
MIME-Version: 1.0
In-Reply-To: <1507729813-21501-1-git-send-email-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/11/2017 04:50 PM, Geert Uytterhoeven wrote:

> Correct the USB subnodes in the example, cfr. commit f7d569c1e6a6fa73
> ("ARM: dts: r8a779x: Fix PCI bus dtc warnings"):
>    1. Drop the bogus 'device_type = "pci"' properties,
>    2. Correct the unit addresses.
> 
> Update other bits in the example to match real use:
>    1. Rename the USB subnodes from "pci" to "usb",
>    2. Update the "phys" property.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
