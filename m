Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35977 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbbBXIoy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 Feb 2015 03:44:54 -0500
Received: by pdjp10 with SMTP id p10so31939659pdj.3
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 00:44:53 -0800 (PST)
Date: Tue, 24 Feb 2015 02:44:50 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>, benh@au1.ibm.com,
	gwshan@linux.vnet.ibm.com
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v12 11/21] powerpc/pci: Don't unset PCI resources for VFs
Message-ID: <20150224084450.GH6220@google.com>
References: <20150224082939.32124.45744.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150224083413.32124.11968.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150224083413.32124.11968.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 24, 2015 at 02:34:13AM -0600, Bjorn Helgaas wrote:
> From: Wei Yang <weiyang@linux.vnet.ibm.com>
> 
> If we're going to reassign resources with flag PCI_REASSIGN_ALL_RSRC, all
> resources will be cleaned out during device header fixup time and then get
> reassigned by PCI core.  However, the VF resources won't be reassigned and
> thus, we shouldn't clean them out.
> 
> If the pci_dev is a VF, skip the resource unset process.

I think this patch is correct, but we should include a little more detail
in the changelog to answer questions like mine and Ben's
(http://lkml.kernel.org/r/1423528584.4924.70.camel@au1.ibm.com).

> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/kernel/pci-common.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 2a525c938158..82031011522f 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -788,6 +788,10 @@ static void pcibios_fixup_resources(struct pci_dev *dev)
>  		       pci_name(dev));
>  		return;
>  	}
> +
> +	if (dev->is_virtfn)
> +		return;
> +
>  	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
>  		struct resource *res = dev->resource + i;
>  		struct pci_bus_region reg;
> 
