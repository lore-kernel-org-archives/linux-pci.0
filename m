Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:14027 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab3JHQym (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 12:54:42 -0400
Date: Tue, 8 Oct 2013 12:54:35 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH RESEND] PCI: mvebu: Dynamically detect if the PEX link
 is up to enable hot plug
Message-ID: <20131008165435.GO5402@titan.lakedaemon.net>
References: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380650281-16175-1-git-send-email-jgunthorpe@obsidianresearch.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 01, 2013 at 11:58:00AM -0600, Jason Gunthorpe wrote:
> Otherwise hotplugging the PEX doesn't work at all since the driver
> detects the link state at probe time. Simply replacing the two tests
> of haslink with a register read is enough to fix it.
> 
> Tested on kirkwood with repeated plug/unplug of the link partner.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/pci/host/pci-mvebu.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)

Applied to mvebu/drivers with Thomas' Ack and Tested-by.

thx,

Jason.
