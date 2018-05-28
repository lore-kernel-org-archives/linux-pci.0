Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56656 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754251AbeE1Jdc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 May 2018 05:33:32 -0400
Date: Mon, 28 May 2018 11:33:28 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marek Vasut <marek.vasut@gmail.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] PCI: rcar: Clean up PHY init on failure
Message-ID: <20180528093327.nd5j5k4dnicxr2us@verge.net.au>
References: <20180525183326.5245-1-marek.vasut+renesas@gmail.com>
 <CAMuHMdUi2uFNOhYB0Y_SH20xfYzqbrBqgn=LgMv4=j+TqyjqWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMuHMdUi2uFNOhYB0Y_SH20xfYzqbrBqgn=LgMv4=j+TqyjqWg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 25, 2018 at 09:27:42PM +0200, Geert Uytterhoeven wrote:
> CC Sergei
> 
> On Fri, May 25, 2018 at 8:33 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> > If the Gen3 PHY fails to power up, the code does not undo the
> > initialization caused by phy_init(). Add the missing failure
> > handling to the rcar_pcie_phy_init_gen3() function.
> >
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Fixes: 517ca93a7159 ("PCI: rcar: Add R-Car gen3 PHY support")
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
