Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41852 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754721Ab3JQNMG (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 17 Oct 2013 09:12:06 -0400
Date: Thu, 17 Oct 2013 09:12:01 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH] PCI: mvebu - The bridge secondary status register
 should be 0
Message-ID: <20131017131201.GE22434@titan.lakedaemon.net>
References: <1381868190-8595-1-git-send-email-jgunthorpe@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381868190-8595-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 15, 2013 at 02:16:30PM -0600, Jason Gunthorpe wrote:
> There are no writable bits in the secondary status register, only
> write 1 to clear bits. The driver never sets any of the write 1 to
> clear bits so the status register should always be 0, just remove
> the set from the write path.
> 
> Someday the write 1 to clear bits should be copied/cleared directly
> from registers in the HW.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to mvebu/drivers

thx,

Jason.
