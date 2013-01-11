Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58166 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab3AKSQF (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jan 2013 13:16:05 -0500
Received: by mail-la0-f45.google.com with SMTP id ep20so2077799lab.18
        for <linux-pci@vger.kernel.org>; Fri, 11 Jan 2013 10:16:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50EE1594.4070905@infradead.org>
References: <50EE1594.4070905@infradead.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 11 Jan 2013 11:15:43 -0700
Message-ID: <CAErSpo6DCgCP44fyubP==x-V9qg6y+fs3R9wrmyL-WGHG+8gsw@mail.gmail.com>
Subject: Re: [PATCH] pci: fix iov.c kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 9, 2013 at 6:12 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix kernel-doc warning in iov.c:
>
> Warning(drivers/pci/iov.c:752): No description found for parameter 'numvfs'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks, Randy.  I applied this to my for-linus branch and it will
appear in v3.8 along with the code it applies to.

Bjorn

> ---
>  drivers/pci/iov.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-38-rc2.orig/drivers/pci/iov.c
> +++ lnx-38-rc2/drivers/pci/iov.c
> @@ -739,7 +739,7 @@ EXPORT_SYMBOL_GPL(pci_num_vf);
>  /**
>   * pci_sriov_set_totalvfs -- reduce the TotalVFs available
>   * @dev: the PCI PF device
> - * numvfs: number that should be used for TotalVFs supported
> + * @numvfs: number that should be used for TotalVFs supported
>   *
>   * Should be called from PF driver's probe routine with
>   * device's mutex held.
