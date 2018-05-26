Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37091 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031606AbeEZKFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 26 May 2018 06:05:32 -0400
Received: by mail-wr0-f193.google.com with SMTP id i12-v6so13009949wrc.4
        for <linux-pci@vger.kernel.org>; Sat, 26 May 2018 03:05:32 -0700 (PDT)
Subject: Re: [PATCH] PCI: rcar: Clean up PHY init on failure
To: Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20180525183326.5245-1-marek.vasut+renesas@gmail.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <48e8ce58-c024-ca82-bc01-2294aea0368f@cogentembedded.com>
Date: Sat, 26 May 2018 13:05:29 +0300
MIME-Version: 1.0
In-Reply-To: <20180525183326.5245-1-marek.vasut+renesas@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5/25/2018 9:33 PM, Marek Vasut wrote:

> If the Gen3 PHY fails to power up, the code does not undo the
> initialization caused by phy_init(). Add the missing failure
> handling to the rcar_pcie_phy_init_gen3() function.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> Fixes: 517ca93a7159 ("PCI: rcar: Add R-Car gen3 PHY support")
[...]

    Oops, it's my sloppy coding again. Sorry about that...

MBR, Sergei
