Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:59449 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932287AbcIQIeq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2016 04:34:46 -0400
Date: Sat, 17 Sep 2016 10:35:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Wei Zhang <wzhang@fb.com>
Subject: Re: [PATCHv2 1/4] pci: Add is_removed state
Message-ID: <20160917083506.GA1235@wunner.de>
References: <1473199219-3369-1-git-send-email-keith.busch@intel.com>
 <1473199219-3369-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1473199219-3369-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 06, 2016 at 04:00:16PM -0600, Keith Busch wrote:
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -4924,7 +4924,14 @@ bool pci_device_is_present(struct pci_dev *pdev)
>  {
>  	u32 v;
>  
> -	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
> +	if (pdev->is_removed)
> +		return false;
> +
> +	if (!pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0)) {
> +		pdev->is_removed = 1;
> +		return false;
> +	}
> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(pci_device_is_present);

I've kept this series on my development branch and found a bug now:

In the above hunk, it's okay to return false if pdev->is_removed is set,
but it's not okay to set pdev->is_removed if pci_bus_read_dev_vendor_id()
returns false.  That's because pci_bus_read_dev_vendor_id() can fail for
other reasons, such as the device being powered down to D3cold, or
currently unreachable because a PCIe port above it was suspended to D3hot
so that the link is down.  Those are transient issues, the device isn't
removed in those cases.

IOW the hunk should look like this:

 {
 	u32 v;
 
+	if (pdev->is_removed)
+		return false;
+
 	return pci_bus_read_dev_vendor_id(pdev->bus, pdev->devfn, &v, 0);
 }

And this should then probably be moved to patch [2/4].

Best regards,

Lukas
