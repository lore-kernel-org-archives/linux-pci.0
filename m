Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:49254 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbaBLAnQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Feb 2014 19:43:16 -0500
Received: by mail-ig0-f178.google.com with SMTP id uq10so9994640igb.5
        for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2014 16:43:16 -0800 (PST)
Date: Tue, 11 Feb 2014 17:43:14 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] pci: fix kernel-doc notation warning
Message-ID: <20140212004314.GG21057@google.com>
References: <52EF06C0.1050104@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52EF06C0.1050104@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 02, 2014 at 07:02:24PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix a "blank" kernel-doc line to have an asterisk instead of
> being totally empty.  This fixes the kernel-doc warning:
> 
> Warning(drivers/pci/msi.c:962): bad line: 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

I applied this fix already (but it's not in -next yet):

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/msi&id=39af663b5fd25c9dd427e12e106763b6b4f9572c

Thanks!

Bjorn

> ---
>  drivers/pci/msi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lnx-314-rc1.orig/drivers/pci/msi.c
> +++ lnx-314-rc1/drivers/pci/msi.c
> @@ -959,7 +959,7 @@ EXPORT_SYMBOL(pci_disable_msi);
>  /**
>   * pci_msix_vec_count - return the number of device's MSI-X table entries
>   * @dev: pointer to the pci_dev data structure of MSI-X device function
> -
> + *
>   * This function returns the number of device's MSI-X table entries and
>   * therefore the number of MSI-X vectors device is capable of sending.
>   * It returns a negative errno if the device is not capable of sending MSI-X
