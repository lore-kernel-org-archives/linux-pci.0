Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:56049 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbdKON2e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2017 08:28:34 -0500
Date: Wed, 15 Nov 2017 05:28:29 -0800
From: Simon Horman <horms@verge.net.au>
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-pci@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH V2 2/5] PCI: rcar: Clean up the macros
Message-ID: <20171115132829.6qpfwbs4iseaulob@verge.net.au>
References: <20171110215843.432-1-marek.vasut+renesas@gmail.com>
 <20171110215843.432-3-marek.vasut+renesas@gmail.com>
 <20171113070326.qteltu72qpniogcf@verge.net.au>
 <4e43ddcf-9d97-c8de-8f46-1735f9f1bab6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4e43ddcf-9d97-c8de-8f46-1735f9f1bab6@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 13, 2017 at 07:11:54PM +0100, Marek Vasut wrote:
> On 11/13/2017 08:03 AM, Simon Horman wrote:
> > On Fri, Nov 10, 2017 at 10:58:40PM +0100, Marek Vasut wrote:
> >> Just clean up the macros in the RCar PCI driver, no functional change.
> > 
> > Could you describe the cleanup in slightly more detail?
> > My reading is 1. Use BIT() macro 2. tidy up whitespace.
> > 
> That's all there is, indeed.

Right, but I'd rather that the changelog be expanded to include that
information. With that fixed feel free to add:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
