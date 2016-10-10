Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752316AbcJJR2j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Oct 2016 13:28:39 -0400
Date: Mon, 10 Oct 2016 12:28:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Jesper Nilsson <jespern@axis.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@axis.com
Subject: Re: [PATCH 1/8] PCI: artpec6: Name private struct pointer "artpec6"
 consistently
Message-ID: <20161010172834.GC12748@localhost>
References: <20161007163233.24751.17505.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20161008074045.GQ30704@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161008074045.GQ30704@axis.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Oct 08, 2016 at 09:40:45AM +0200, Jesper Nilsson wrote:
> On Fri, Oct 07, 2016 at 11:32:33AM -0500, Bjorn Helgaas wrote:
> > Use a device-specific name, "artpec6", for struct artpec6_pcie pointers
> > to hint that this is device-specific information.  No functional change
> > intended.
> 
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

Hi Jesper,

I updated this series to keep "artpec6_pcie" instead of changing to
"artpec" and change the accessor names similarly.  I repushed the
branch.

> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> /^JN - Jesper Nilsson
> -- 
>                Jesper Nilsson -- jesper.nilsson@axis.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
