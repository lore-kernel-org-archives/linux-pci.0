Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbdISTpe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Sep 2017 15:45:34 -0400
Date: Tue, 19 Sep 2017 14:45:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bhumika Goyal <bhumirks@gmail.com>
Cc: julia.lawall@lip6.fr, bhelgaas@google.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/pci/intel_mid_pci: make intel_mid_pci_ops const and
 __initconst
Message-ID: <20170919194532.GG22312@bhelgaas-glaptop.roam.corp.google.com>
References: <1505751895-9799-1-git-send-email-bhumirks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505751895-9799-1-git-send-email-bhumirks@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 18, 2017 at 09:54:55PM +0530, Bhumika Goyal wrote:
> Make this const as it is only used during a copy operation. This usage
> is inside init function and the structure is not referenced after
> initialisation, so make it __initconst too.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

I applied this to pci/misc for v4.15, thanks!

If this conflicts with patches going via x86, I'll gladly drop it from my
tree; just let me know.

> ---
>  arch/x86/pci/intel_mid_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index b901ece..63fbe8f 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -279,7 +279,7 @@ static void intel_mid_pci_irq_disable(struct pci_dev *dev)
>  	}
>  }
>  
> -static struct pci_ops intel_mid_pci_ops = {
> +static const struct pci_ops intel_mid_pci_ops __initconst = {
>  	.read = pci_read,
>  	.write = pci_write,
>  };
> -- 
> 1.9.1
> 
