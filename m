Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:39187 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756224AbaD2Q5d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Apr 2014 12:57:33 -0400
Date: Tue, 29 Apr 2014 12:57:28 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>,
	thomas.petazzoni@free-electrons.com, linux-pci@vger.kernel.org,
	jg1.han@samsung.com
Subject: Re: [PATCH v3] pci: pci-mvebu: Use '%pa' for printing
 'phys_addr_t' type
Message-ID: <20140429165728.GM28159@titan.lakedaemon.net>
References: <1398776287-14229-1-git-send-email-fabio.estevam@freescale.com>
 <20140429165419.GA13735@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140429165419.GA13735@google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 29, 2014 at 10:54:19AM -0600, Bjorn Helgaas wrote:
...
> I'm ready to merge the following, given an ack from Thomas or Jason.
> Jingoo, I added your reviewed-by, since this is essentially what you
> reviewed before.
> 
> Bjorn
> 
> 
> commit 5bbf2f268b9001c2e46aff6ff17cee0e8a6b8fb8
> Author: Fabio Estevam <fabio.estevam@freescale.com>
> Date:   Tue Apr 29 09:58:07 2014 -0300
> 
>     PCI: mvebu: Use '%pa' for printing 'phys_addr_t' type
>     
>     Fix the following build warning that happens when building
>     multi_v7_defconfig with CONFIG_ARM_LPAE=y:
>     
>       drivers/pci/host/pci-mvebu.c:334:5: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'phys_addr_t' [-Wformat=]
>     
>     Fix the warning by using '%pa' to printing 'phys_addr_t' type.  While at
>     it, also use the more standard notation [mem 0x-0x] for memory region.
>     
>     Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
