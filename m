Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753543AbdF0U7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 16:59:55 -0400
Date: Tue, 27 Jun 2017 15:59:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Anvin <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>, linux-pci@vger.kernel.org
Subject: Re: [patch 2/7] x86/pci: Abort if legacy init fails
Message-ID: <20170627205952.GC764@bhelgaas-glaptop.roam.corp.google.com>
References: <20170316215002.726697858@linutronix.de>
 <20170316215057.047576516@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170316215057.047576516@linutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

s|x86/pci: |x86/PCI: | for these three, to follow previous convention.

On Thu, Mar 16, 2017 at 10:50:04PM +0100, Thomas Gleixner wrote:
> If the legacy pci init fails, then there are no pci config space accesors
> available, but the code continues and tries to scan the busses, which fails
> due to the lack of config space accessors.

s/pci/PCI/ above.

> Return right away, if the last init fallback fails.
> 
> Switch the few printks to pr_info while at it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/pci/legacy.c |   18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> --- a/arch/x86/pci/legacy.c
> +++ b/arch/x86/pci/legacy.c
> @@ -24,12 +24,10 @@ static void pcibios_fixup_peer_bridges(v
>  
>  int __init pci_legacy_init(void)
>  {
> -	if (!raw_pci_ops) {
> -		printk("PCI: System does not support PCI\n");
> -		return 0;
> -	}
> +	if (!raw_pci_ops)
> +		return 1;
>  
> -	printk("PCI: Probing PCI hardware\n");
> +	pr_info("PCI: Probing PCI hardware\n");
>  	pcibios_scan_root(0);
>  	return 0;
>  }
> @@ -46,7 +44,7 @@ void pcibios_scan_specific_bus(int busn)
>  		if (!raw_pci_read(0, busn, devfn, PCI_VENDOR_ID, 2, &l) &&
>  		    l != 0x0000 && l != 0xffff) {
>  			DBG("Found device at %02x:%02x [%04x]\n", busn, devfn, l);
> -			printk(KERN_INFO "PCI: Discovered peer bus %02x\n", busn);
> +			pr_info("PCI: Discovered peer bus %02x\n", busn);
>  			pcibios_scan_root(busn);
>  			return;
>  		}
> @@ -60,8 +58,12 @@ static int __init pci_subsys_init(void)
>  	 * The init function returns an non zero value when
>  	 * pci_legacy_init should be invoked.
>  	 */
> -	if (x86_init.pci.init())
> -		pci_legacy_init();
> +	if (x86_init.pci.init()) {
> +		if (pci_legacy_init()) {
> +			pr_info("PCI: System does not support PCI\n");
> +			return -ENODEV;
> +		}
> +	}
>  
>  	pcibios_fixup_peer_bridges();
>  	x86_init.pci.init_irq();
> 
> 
