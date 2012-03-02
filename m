Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54795 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab2CBUIJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 2 Mar 2012 15:08:09 -0500
Received: by pbcun15 with SMTP id un15so469671pbc.19
        for <linux-pci@vger.kernel.org>; Fri, 02 Mar 2012 12:08:08 -0800 (PST)
Date: Fri, 2 Mar 2012 12:00:27 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Myron Stowe <myron.stowe@redhat.com>
Cc: jbarnes@virtuousgeek.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: add spinlock held check to
 'pcibios_fwaddrmap_lookup()'
Message-ID: <20120302200027.GA4817@kroah.com>
References: <20120302194501.26152.22845.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120302194501.26152.22845.stgit@amt.stowe>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 02, 2012 at 12:45:01PM -0700, Myron Stowe wrote:
> 'pcibios_fwaddrmap_lookup()' is used to maintain FW-assigned BIOS BAR
> values for reinstatement when normal resource assignment attempts
> fail and must be called with the 'pcibios_fwaddrmap_lock' spinlock
> held.
> 
> This patch adds a WARN_ON notification if the spinlock is not currently
> held by the caller.
> 
> Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
> ---
> 
>  arch/x86/pci/i386.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
> index 33e6a0b..831971e 100644
> --- a/arch/x86/pci/i386.c
> +++ b/arch/x86/pci/i386.c
> @@ -57,6 +57,8 @@ static struct pcibios_fwaddrmap *pcibios_fwaddrmap_lookup(struct pci_dev *dev)
>  {
>  	struct pcibios_fwaddrmap *map;
>  
> +	WARN_ON(!spin_is_locked(&pcibios_fwaddrmap_lock));
> +

What is this going to help with?  How can someone then recover from this
issue?  Just adding a warning message isn't going to fix any problems
here, why not fix the root cause?

thanks,

greg k-h
