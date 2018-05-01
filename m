Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55693 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeEAFxj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 May 2018 01:53:39 -0400
Date: Tue, 1 May 2018 07:53:19 +0200
From: Simon Horman <horms@verge.net.au>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3] PCI: rcar: Clean up the macros
Message-ID: <20180501055319.irtspgcupxac32bd@verge.net.au>
References: <20180408180431.17323-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180408180431.17323-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Apr 08, 2018 at 08:04:31PM +0200, Marek Vasut wrote:
> This patch replaces the (1 << n) with BIT(n) and cleans up whitespace,
> no functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Marek, thanks for your patch.

Lorenzo, this seems pretty well baked.
Could you consider applying it?

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
