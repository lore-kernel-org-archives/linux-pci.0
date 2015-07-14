Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33951 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbGNWPQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2015 18:15:16 -0400
Received: by obre1 with SMTP id e1so15126506obr.1
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2015 15:15:16 -0700 (PDT)
Date: Tue, 14 Jul 2015 17:15:11 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Don't update VF's BAR
Message-ID: <20150714221511.GM24416@google.com>
References: <1435649834-3148-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1435649834-3148-1-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 30, 2015 at 03:37:14PM +0800, Wei Yang wrote:
> VF BARs are RO zero, so updating VF BARs will not take any effect.
> See the SR-IOV spec r1.1, sec 3.4.1.11.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  drivers/pci/setup-res.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 232f925..334b394 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -37,6 +37,13 @@ void pci_update_resource(struct pci_dev *dev, int resno)
>  	struct resource *res = dev->resource + resno;
>  
>  	/*
> +	 * Per SRIOV SPEC 3.4.1.11, VF BARs are RO zero.
> +	 * If this is a VF, just return.
> +	 */
> +	if (dev->is_virtfn)
> +		return;

Does this fix a problem?  Are you seeing the "BAR %d: error updating"
message?

I wouldn't think we would even call pci_update_resource() for VFs, except
for pci_restore_bars().  Maybe we should check there?

If the PCI core is assigning space directly to VF BARs and trying to update
them, I'd like to know about that rather than silently ignoring it.

> +
> +	/*
>  	 * Ignore resources for unimplemented BARs and unused resource slots
>  	 * for 64 bit BARs.
>  	 */
> -- 
> 1.7.9.5
> 
