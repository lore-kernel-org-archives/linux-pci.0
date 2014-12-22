Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:43531 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbaLVVNu (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Dec 2014 16:13:50 -0500
Date: Mon, 22 Dec 2014 16:13:48 -0500 (EST)
Message-Id: <20141222.161348.332125635285859975.davem@davemloft.net>
To: prashant@broadcom.com
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	nholland@tisys.org, marcelo.leitner@gmail.com, bhelgaas@google.com,
	rajatxjain@gmail.com, mchan@broadcom.com
Subject: Re: [PATCH net]tg3: tg3_disable_ints using uninitialized mailbox
 value to disable interrupts
From: David Miller <davem@davemloft.net>
In-Reply-To: <1419106577-12891-1-git-send-email-prashant@broadcom.com>
References: <1419106577-12891-1-git-send-email-prashant@broadcom.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Prashant Sreedharan <prashant@broadcom.com>
Date: Sat, 20 Dec 2014 12:16:17 -0800

> During driver load in tg3_init_one, if the driver detects DMA activity before
> intializing the chip tg3_halt is called. As part of tg3_halt interrupts are
> disabled using routine tg3_disable_ints. This routine was using mailbox value
> which was not initialized (default value is 0). As a result driver was writing
> 0x00000001 to pci config space register 0, which is the vendor id / device id.
> 
> This driver bug was exposed because of the commit a7877b17a667 (PCI: Check only
> the Vendor ID to identify Configuration Request Retry). Also this issue is only
> seen in older generation chipsets like 5722 because config space write to offset
> 0 from driver is possible. The newer generation chips ignore writes to offset 0.
> Also without commit a7877b17a667, for these older chips when a GRC reset is
> issued the Bootcode would reprogram the vendor id/device id, which is the reason
> this bug was masked earlier.
> 
> Fixed by initializing the interrupt mailbox registers before calling tg3_halt.
> 
> Please queue for -stable.
> 
> Reported-by: Nils Holland <nholland@tisys.org>
> Reported-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Signed-off-by: Prashant Sreedharan <prashant@broadcom.com>
> Signed-off-by: Michael Chan <mchan@broadcom.com>

Applied and queued up for -stable, thanks.
