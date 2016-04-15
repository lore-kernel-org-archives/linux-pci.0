Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58511 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbcDOPe1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 15 Apr 2016 11:34:27 -0400
Date: Fri, 15 Apr 2016 10:34:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] PCI: acpiphp_ibm: potential uninitialized variable bug
Message-ID: <20160415153422.GB7973@localhost>
References: <20160415145106.GH8953@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160415145106.GH8953@mwanda>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 15, 2016 at 05:51:06PM +0300, Dan Carpenter wrote:
> If ibm_get_table_from_acpi() fails then "table" isn't initialized.  I
> fixed this by adding a check for failure.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to pci/hotplug for v4.7, thanks, Dan!

> diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
> index 2f6d3a1..f6221d7 100644
> --- a/drivers/pci/hotplug/acpiphp_ibm.c
> +++ b/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -138,6 +138,8 @@ static union apci_descriptor *ibm_slot_from_id(int id)
>  	char *table;
>  
>  	size = ibm_get_table_from_acpi(&table);
> +	if (size < 0)
> +		return NULL;
>  	des = (union apci_descriptor *)table;
>  	if (memcmp(des->header.sig, "aPCI", 4) != 0)
>  		goto ibm_slot_done;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
