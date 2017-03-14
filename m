Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/4] pci: Allow lockless access path to PCI mmconfig
To: Andi Kleen <andi@firstfloor.org>, bhelgaas@google.com
References: <20170302232104.10136-1-andi@firstfloor.org>
Cc: x86@kernel.org, linux-pci@vger.kernel.org, eranian@google.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <0bb90a87-e03d-2b14-0e58-bd0f41bf84a9@zytor.com>
Date: Tue, 14 Mar 2017 10:28:17 -0700
MIME-Version: 1.0
In-Reply-To: <20170302232104.10136-1-andi@firstfloor.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/02/17 15:21, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The Intel uncore driver can do a lot of PCI config accesses to read
> performance counters. I had a situation on a 4S system where it
> was spending 40+% of CPU time grabbing the pci_cfg_lock due to that.
> 
> For 64bit x86 with MMCONFIG there isn't really any reason to take
> a lock. The access is directly mapped to an underlying MMIO area,
> which can fully operate lockless.
> 
> Add a new flag that allows the PCI mid layer to skip the lock
> and set it for the 64bit mmconfig code.
> 
> There's a small risk that someone relies on this lock for synchronization,
> but I think that's unlikely because there isn't really any useful
> synchronization at this individual operation level. Any useful
> synchronization would likely need to protect at least a
> read-modify-write or similar.  So I made it unconditional without opt-in.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  arch/x86/pci/mmconfig_64.c |  1 +
>  drivers/pci/access.c       | 14 ++++++++++----
>  include/linux/pci.h        |  2 ++
>  3 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> index bea52496aea6..8bf10f41e626 100644
> --- a/arch/x86/pci/mmconfig_64.c
> +++ b/arch/x86/pci/mmconfig_64.c
> @@ -121,6 +121,7 @@ int __init pci_mmcfg_arch_init(void)
>  		}
>  
>  	raw_pci_ext_ops = &pci_mmcfg;
> +	pci_root_ops.ll_allowed = true;
>  

"ll_allowed" is pretty awful naming... you spend almost all the
characters telling us nothing.  I spend several seconds trying to figure
out what "ll" stood for, and without the context of the patch I'd have
had to go a massive grep.  Just call it "lockless" or something.

	-hpa
