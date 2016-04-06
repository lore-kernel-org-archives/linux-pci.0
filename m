Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 6 Apr 2016 10:55:34 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org, bhelgaas@google.com, corbet@lwn.net,
	aik@ozlabs.ru, alex.williamson@redhat.com,
	benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
	warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
	nikunj@linux.vnet.ibm.com, gwshan@linux.vnet.ibm.com
Subject: Re: [RFC v5 2/7] PCI: Do not Use IORESOURCE_STARTALIGN to identify
 bridge resources
Message-ID: <20160406005534.GB6187@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1459863813-2830-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1459863813-2830-3-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459863813-2830-3-git-send-email-xyjxie@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 05, 2016 at 09:43:30PM +0800, Yongji Xie wrote:
>Now we use the IORESOURCE_STARTALIGN to identify
>bridge resources in __assign_resources_sorted().
>That's quite fragile. We can't make sure that
>the PCI devices' resources will not use
>IORESOURCE_STARTALIGN any more.
>
>In this patch, we try to use a more robust way
>to identify bridge resources.
>
>Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
>---
> drivers/pci/setup-bus.c |   10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
>index 7796d0a..bffcf1e 100644
>--- a/drivers/pci/setup-bus.c
>+++ b/drivers/pci/setup-bus.c
>@@ -391,6 +391,7 @@ static void __assign_resources_sorted(struct list_head *head,
> 	struct pci_dev_resource *dev_res, *tmp_res, *dev_res2;
> 	unsigned long fail_type;
> 	resource_size_t add_align, align;
>+	int index;
>
> 	/* Check if optional add_size is there */
> 	if (!realloc_head || list_empty(realloc_head))
>@@ -411,11 +412,14 @@ static void __assign_resources_sorted(struct list_head *head,
>
> 		/*
> 		 * There are two kinds of additional resources in the list:
>-		 * 1. bridge resource  -- IORESOURCE_STARTALIGN
>-		 * 2. SR-IOV resource   -- IORESOURCE_SIZEALIGN
>+		 * 1. bridge resource
>+		 * 2. SR-IOV resource
> 		 * Here just fix the additional alignment for bridge
> 		 */
>-		if (!(dev_res->res->flags & IORESOURCE_STARTALIGN))
>+		index = dev_res->res - dev_res->dev->resource;
>+		if (pci_is_bridge(dev_res->dev) &&
>+			index >= PCI_BRIDGE_RESOURCES &&
>+			index <= PCI_BRIDGE_RESOURCE_END)
> 			continue;

Yongji, the condition seems incorrect. According to the comments in
the code, it's resizing bridge's windows. So I think the code would
be something like below?

		if (!pci_is_bridge(dev_res->dev) ||
		    index < PCI_BRIDGE_RESOURCES ||
		    index > PCI_BRIDGE_RESOURCE_END)
			continue;

>
> 		add_align = get_res_add_align(realloc_head, dev_res->res);

Thanks,
Gavin
