Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38996 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdKMSL5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2017 13:11:57 -0500
Subject: Re: [PATCH V2 2/5] PCI: rcar: Clean up the macros
To: Simon Horman <horms@verge.net.au>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
 <20171110215843.432-3-marek.vasut+renesas@gmail.com>
 <20171113070326.qteltu72qpniogcf@verge.net.au>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <4e43ddcf-9d97-c8de-8f46-1735f9f1bab6@gmail.com>
Date: Mon, 13 Nov 2017 19:11:54 +0100
MIME-Version: 1.0
In-Reply-To: <20171113070326.qteltu72qpniogcf@verge.net.au>
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/13/2017 08:03 AM, Simon Horman wrote:
> On Fri, Nov 10, 2017 at 10:58:40PM +0100, Marek Vasut wrote:
>> Just clean up the macros in the RCar PCI driver, no functional change.
> 
> Could you describe the cleanup in slightly more detail?
> My reading is 1. Use BIT() macro 2. tidy up whitespace.
> 
That's all there is, indeed.

-- 
Best regards,
Marek Vasut
