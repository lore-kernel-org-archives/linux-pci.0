Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56041 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbdKON1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2017 08:27:39 -0500
Date: Wed, 15 Nov 2017 05:27:33 -0800
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 5/5] PCI: rcar: Add the suspend/resume for pcie-rcar
 driver
Message-ID: <20171115132733.ydkd7yvayowh5vwu@verge.net.au>
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
 <20171110215843.432-6-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110215843.432-6-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 10:58:43PM +0100, Marek Vasut wrote:
> From: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> 
> This adds the suspend/resume supports for pcie-rcar. The resume handler
> reprograms the hardware based on the software state kept in specific
> device structures. Also it doesn't need to save any registers.
> 
> Signed-off-by: Kazufumi Ikeda <kaz-ikeda@xc.jp.nec.com>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org

Acked-by: Simon Horman <horms+renesas@verge.net.au>
