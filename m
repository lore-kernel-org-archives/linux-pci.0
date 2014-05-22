Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:34107 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbaEVFKT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 22 May 2014 01:10:19 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Thu, 22 May 2014 15:10:17 +1000
Date: Thu, 22 May 2014 15:10:14 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, alex.williamson@redhat.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/4] PCI: Export MSI message relevant functions
Message-ID: <20140522051013.GB20348@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1400468470-11262-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400468470-11262-2-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400468470-11262-2-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 19, 2014 at 01:01:07PM +1000, Gavin Shan wrote:
>The patch exports 2 MSI message relevant functions, which will be
>used by VFIO PCI driver. The VFIO PCI driver would be built as
>a module.
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Bjorn, could you help ack it if you don't have objection to it?
I guess Alex is probably waiting to merge the subsequent patch,
which depends on this one.

>---
> drivers/pci/msi.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
>index 955ab79..2350271 100644
>--- a/drivers/pci/msi.c
>+++ b/drivers/pci/msi.c
>@@ -324,6 +324,7 @@ void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg)
>
> 	__get_cached_msi_msg(entry, msg);
> }
>+EXPORT_SYMBOL_GPL(get_cached_msi_msg);
>
> void __write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
> {
>@@ -368,6 +369,7 @@ void write_msi_msg(unsigned int irq, struct msi_msg *msg)
>
> 	__write_msi_msg(entry, msg);
> }
>+EXPORT_SYMBOL_GPL(write_msi_msg);
>
> static void free_msi_irqs(struct pci_dev *dev)
> {

Thanks,
Gavin

