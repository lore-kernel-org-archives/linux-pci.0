Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55606 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdKMHvD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2017 02:51:03 -0500
Date: Mon, 13 Nov 2017 08:50:58 +0100
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V3] PCI: rcar: Use runtime PM to control controller clock
Message-ID: <20171113075058.ixqqgqxanrpqthjk@verge.net.au>
References: <20171110215411.31912-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110215411.31912-1-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 10:54:11PM +0100, Marek Vasut wrote:
> From: Dien Pham <dien.pham.ry@rvc.renesas.com>
> 
> The controller clock can be switched off during suspend/resume,
> let runtime PM take care of that.
> 
> Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Phil Edworthy <phil.edworthy@renesas.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-renesas-soc@vger.kernel.org
> To: linux-pci@vger.kernel.org

Acked-by: Simon Horman <horms+renesas@verge.net.au>
