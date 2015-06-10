Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:56120 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932406AbbFJGW1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2015 02:22:27 -0400
Received: from /spool/local
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Wed, 10 Jun 2015 16:22:25 +1000
Date: Wed, 10 Jun 2015 16:20:08 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, benh@kernel.crashing.org,
	bhelgaas@google.com, panto@antoniou-consulting.com,
	robherring2@gmail.com, grant.likely@linaro.org,
	Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v5 12/42] powerpc/pci: Cleanup on pci_controller_ops
Message-ID: <20150610062008.GA9875@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-13-git-send-email-gwshan@linux.vnet.ibm.com>
 <5577C08D.1050900@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5577C08D.1050900@ozlabs.ru>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 10, 2015 at 02:43:57PM +1000, Alexey Kardashevskiy wrote:
>On 06/04/2015 04:41 PM, Gavin Shan wrote:
>>Each PHB maintains one instance of "struct pci_controller_ops",
>>which includes various callbacks called by PCI subsystem. In the
>>definition of this struct, some callbacks have explicit names for
>>its arguments, but the left don't have.
>>
>>The patch removes all explicit names of the arguments to the
>>callbacks in "struct pci_controller_ops" to keep the code look
>>consistent.
>
>imho it is a bad idea. Self-documeted code gets less self-documented - how do
>I know what "unsigned long" parameters are for without grepping?
>

Ok. I'll change the function definations to always have explicit
argument names.

>>
>>Cc: Daniel Axtens <dja@axtens.net>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>v5:
>>   * Newly introduced
>>---
>>  arch/powerpc/include/asm/pci-bridge.h | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index 744884b..1252cd5 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -18,8 +18,8 @@ struct device_node;
>>   * PCI controller operations
>>   */
>>  struct pci_controller_ops {
>>-	void		(*dma_dev_setup)(struct pci_dev *dev);
>>-	void		(*dma_bus_setup)(struct pci_bus *bus);
>>+	void		(*dma_dev_setup)(struct pci_dev *);
>>+	void		(*dma_bus_setup)(struct pci_bus *);
>>
>>  	int		(*probe_mode)(struct pci_bus *);
>>
>>@@ -28,8 +28,8 @@ struct pci_controller_ops {
>>  	bool		(*enable_device_hook)(struct pci_dev *);
>>
>>  	/* Called during PCI resource reassignment */
>>-	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
>>-	void		(*reset_secondary_bus)(struct pci_dev *dev);
>>+	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long);
>>+	void		(*reset_secondary_bus)(struct pci_dev *);
>>  };
>>
>>  /*
>>

Thanks,
Gavin

