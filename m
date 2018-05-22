Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:40856 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVNQj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 May 2018 09:16:39 -0400
Date: Tue, 22 May 2018 15:16:35 +0200
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3] PCI: rcar: Poll more often in rcar_pcie_wait_for_dl()
Message-ID: <20180522131635.3dvqjgbwrorj7l4i@verge.net.au>
References: <20180522122420.24002-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180522122420.24002-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 02:24:20PM +0200, Marek Vasut wrote:
> The data link active signal usually takes ~20 uSec to be asserted,
> poll the bit more often to avoid useless delays in this function.
> Use udelay() instead of usleep() for such a small delay as suggested
> by the timer documentation and because this will be used in atomic
> context later on when the suspend/resume patches land.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
