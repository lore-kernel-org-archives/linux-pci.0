Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:30876 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614Ab3AJWTX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 10 Jan 2013 17:19:23 -0500
Message-ID: <50EF3E65.3030302@redhat.com>
Date: Thu, 10 Jan 2013 17:19:17 -0500
From: Don Dutile <ddutile@redhat.com>
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@infradead.org>
CC: linux-pci <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pci: fix iov.c kernel-doc warnings
References: <50EE1594.4070905@infradead.org>
In-Reply-To: <50EE1594.4070905@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/09/2013 08:12 PM, Randy Dunlap wrote:
> From: Randy Dunlap<rdunlap@infradead.org>
>
> Fix kernel-doc warning in iov.c:
>
> Warning(drivers/pci/iov.c:752): No description found for parameter 'numvfs'
>
> Signed-off-by: Randy Dunlap<rdunlap@infradead.org>
> ---
>   drivers/pci/iov.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-38-rc2.orig/drivers/pci/iov.c
> +++ lnx-38-rc2/drivers/pci/iov.c
> @@ -739,7 +739,7 @@ EXPORT_SYMBOL_GPL(pci_num_vf);
>   /**
>    * pci_sriov_set_totalvfs -- reduce the TotalVFs available
>    * @dev: the PCI PF device
> - * numvfs: number that should be used for TotalVFs supported
> + * @numvfs: number that should be used for TotalVFs supported
>    *
>    * Should be called from PF driver's probe routine with
>    * device's mutex held.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for cleanup; /my bad.
Should checkpatch report this issue?  if it does, then
my (double-down) bad for missing that correction when I ran it against the patch.

