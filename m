Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40420 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933715AbeEIHxT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 03:53:19 -0400
Received: by mail-pf0-f195.google.com with SMTP id f189so25215643pfa.7
        for <linux-pci@vger.kernel.org>; Wed, 09 May 2018 00:53:19 -0700 (PDT)
Date: Wed, 9 May 2018 15:52:48 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 4/9] PCI: armada8k: Drop unnecessary root_bus_nr setting
Message-ID: <20180509075246.GB24899@dragon>
References: <1525844386-5433-1-git-send-email-shawn.guo@linaro.org>
 <1525844386-5433-4-git-send-email-shawn.guo@linaro.org>
 <20180509092925.2d2cd2f3@windsurf.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180509092925.2d2cd2f3@windsurf.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 09, 2018 at 09:29:25AM +0200, Thomas Petazzoni wrote:
> Hello Shawn,
> 
> On Wed,  9 May 2018 13:39:41 +0800, Shawn Guo wrote:
> > The root_bus_nr initialization has already been done in function
> > dw_pcie_host_init().
> 
> The formulation "has already been done" makes me think it's been done
> *before* pp->root_bus_nr = -1, which is not what happens. I believe a
> better formulation here would be:
> 
> dw_pcie_host_init() already initializes the root_bus_nr field of
> 'struct pcie_port', so there is no need to initialize it prior to
> calling dw_pcie_host_init().

Yes, this is better.  I will improve the commit log as suggested.
Thanks.

> 
> >  The -1 assignment in platform driver before
> > calling into dw_pcie_host_init() is not really needed.  Drop it.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Other than my comment on the commit log:
> 
> Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks.

Shawn
