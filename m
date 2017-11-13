Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:55186 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdKMHDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2017 02:03:30 -0500
Date: Mon, 13 Nov 2017 08:03:26 +0100
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 2/5] PCI: rcar: Clean up the macros
Message-ID: <20171113070326.qteltu72qpniogcf@verge.net.au>
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
 <20171110215843.432-3-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171110215843.432-3-marek.vasut+renesas@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Nov 10, 2017 at 10:58:40PM +0100, Marek Vasut wrote:
> Just clean up the macros in the RCar PCI driver, no functional change.

Could you describe the cleanup in slightly more detail?
My reading is 1. Use BIT() macro 2. tidy up whitespace.
