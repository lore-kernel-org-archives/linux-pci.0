Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:19700 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab3LDU1l (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 4 Dec 2013 15:27:41 -0500
Date: Wed, 4 Dec 2013 15:27:38 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: MVEBU: Remove duplicate clock get
Message-ID: <20131204202738.GO29282@titan.lakedaemon.net>
References: <1386178241-10453-1-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1386178241-10453-1-git-send-email-andrew@lunn.ch>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 04, 2013 at 06:30:41PM +0100, Andrew Lunn wrote:
> Probably due to a merge conflict resolution gone bad, the pci clock is
> got twice. Remove the second redundent of_clk_get_by_name().
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/pci/host/pci-mvebu.c | 8 --------
>  1 file changed, 8 deletions(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
