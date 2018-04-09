Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:54999 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeDIKzr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Apr 2018 06:55:47 -0400
Date: Mon, 9 Apr 2018 12:55:43 +0200
From: Simon Horman <horms@verge.net.au>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/4] pcie-rcar: poll PHYRDY in rcar_pcie_hw_init()
Message-ID: <20180409105543.vygrjdoju4hut5fo@verge.net.au>
References: <23335d95-63ca-b107-e43d-f4c2621adc2c@cogentembedded.com>
 <35e8fb4a-4b43-dac9-7a6f-cc7083c06453@cogentembedded.com>
 <20180409105415.h4rstrzzan4k6neq@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409105415.h4rstrzzan4k6neq@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 09, 2018 at 12:54:18PM +0200, Simon Horman wrote:
> On Fri, Apr 06, 2018 at 02:02:52PM +0300, Sergei Shtylyov wrote:
> > In  all the R-Car gen1/2/3 manuals, we are instructed to poll PCIEPHYSR
> > for PHYRDY=1  at  an early stage of the PCIEC initialization -- while
> > the driver only does this on R-Car H1 (polling a PHY specific register).
> 
> Is the R-Car H1 specific code still needed with this patch in place?

Sorry, I now see you addressed that by removing the R-Car H1 code in patch 2/4.

...
