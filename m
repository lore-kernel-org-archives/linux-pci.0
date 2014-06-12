Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp08.au.ibm.com ([202.81.31.141]:51545 "EHLO
	e23smtp08.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbaFLXdp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jun 2014 19:33:45 -0400
Received: from /spool/local
	by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 13 Jun 2014 09:33:42 +1000
Date: Fri, 13 Jun 2014 09:33:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	ben@decadent.org.uk, gwshan@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: Fix unaligned access testing AF transaction pending
Message-ID: <20140612233336.GA4404@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20140612152732.4162.23298.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140612152732.4162.23298.stgit@bling.home>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 12, 2014 at 09:28:07AM -0600, Alex Williamson wrote:
>pci_wait_for_pending() uses word access, so we shouldn't be passing
>an offset that is only byte aligned.  Use the control register offset
>instead, shifting the mask to match.
>
>Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>Reported-by: Ben Hutchings <ben@decadent.org.uk>
>Cc: stable@vger.kernel.org

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> drivers/pci/pci.c |    9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>index 759475e..81012ec 100644
>--- a/drivers/pci/pci.c
>+++ b/drivers/pci/pci.c
>@@ -3109,8 +3109,13 @@ static int pci_af_flr(struct pci_dev *dev, int probe)
> 	if (probe)
> 		return 0;
>
>-	/* Wait for Transaction Pending bit clean */
>-	if (pci_wait_for_pending(dev, pos + PCI_AF_STATUS, PCI_AF_STATUS_TP))
>+	/*
>+	 * Wait for Transaction Pending bit to clear.  A word-aligned test
>+	 * is used, so we use the conrol offset rather than status and shift
>+	 * the test bit to match.
>+	 */
>+	if (pci_wait_for_pending(dev, pos + PCI_AF_CTRL,
>+				 PCI_AF_STATUS_TP << 8))
> 		goto clear;
>
> 	dev_err(&dev->dev, "transaction is not cleared; "
>

Thanks,
Gavin

