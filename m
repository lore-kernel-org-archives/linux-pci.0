Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeEAKx2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 May 2018 06:53:28 -0400
Date: Tue, 1 May 2018 11:53:21 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Simon Horman <horms@verge.net.au>
Cc: Marek Vasut <marek.vasut@gmail.com>, linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3] PCI: rcar: Clean up the macros
Message-ID: <20180501105321.GA19391@e107981-ln.cambridge.arm.com>
References: <20180408180431.17323-1-marek.vasut+renesas@gmail.com>
 <20180501055319.irtspgcupxac32bd@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180501055319.irtspgcupxac32bd@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 01, 2018 at 07:53:19AM +0200, Simon Horman wrote:
> On Sun, Apr 08, 2018 at 08:04:31PM +0200, Marek Vasut wrote:
> > This patch replaces the (1 << n) with BIT(n) and cleans up whitespace,
> > no functional change.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Phil Edworthy <phil.edworthy@renesas.com>
> > Cc: Simon Horman <horms+renesas@verge.net.au>
> > Cc: Wolfram Sang <wsa@the-dreams.de>
> > Cc: linux-renesas-soc@vger.kernel.org
> > Reviewed-by: Niklas S??derlund <niklas.soderlund+renesas@ragnatech.se>
> 
> Marek, thanks for your patch.
> 
> Lorenzo, this seems pretty well baked.
> Could you consider applying it?
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Applied to pci/rcar for v4.18, thanks.

Lorenzo
