Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbeCGMlJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Mar 2018 07:41:09 -0500
Date: Wed, 7 Mar 2018 12:41:05 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 5/5] PCI: tegra: use seq_open_data
Message-ID: <20180307124105.GE15139@e107981-ln.cambridge.arm.com>
References: <20180301233724.20440-1-linux@rasmusvillemoes.dk>
 <20180301233724.20440-5-linux@rasmusvillemoes.dk>
 <20180302104207.GB27178@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180302104207.GB27178@ulmo>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 02, 2018 at 11:42:07AM +0100, Thierry Reding wrote:
> On Fri, Mar 02, 2018 at 12:37:24AM +0100, Rasmus Villemoes wrote:
> > Simplify the code slightly by having seq_open_data do the ->private
> > assignment.
> > 
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > ---
> >  drivers/pci/host/pci-tegra.c | 11 +----------
> >  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> I had to go hunt for patch 1/5 to be able to tell if this is indeed
> equivalent. It is, so:
> 
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>

I can't apply this patch standalone so I assume this will go via
some other tree; I will drop it from the PCI patch queue, if I
should not please do let me know.

Thanks,
Lorenzo
