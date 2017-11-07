Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 6 Nov 2017 18:50:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ibmphp_pci: Use common error handling code in
 unconfigure_boot_device()
Message-ID: <20171107005052.GF9538@bhelgaas-glaptop.roam.corp.google.com>
References: <9db967bd-b7f9-d7e8-a858-a409f07c2a51@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9db967bd-b7f9-d7e8-a858-a409f07c2a51@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Oct 30, 2017 at 01:30:13PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 30 Oct 2017 13:26:32 +0100
> 
> * Add a jump target so that a specific error message is stored only once
>   at the end of this function implementation.
> 
> * Replace two calls of the macro "err" by goto statements.
> 
> * Adjust two condition checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to pci/hotplug for v4.15, thanks.

I'm a little hesitant because (a) this driver is probably dead, and
(b) if we *do* want to do anything to it, I'd love to see a major
overhaul to bring it into line with other hotplug drivers.  But I did
apply this anyway.

> ---
>  drivers/pci/hotplug/ibmphp_pci.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/ibmphp_pci.c b/drivers/pci/hotplug/ibmphp_pci.c
> index dc1876feb06f..25edd0b18b75 100644
> --- a/drivers/pci/hotplug/ibmphp_pci.c
> +++ b/drivers/pci/hotplug/ibmphp_pci.c
> @@ -1267,20 +1267,19 @@ static int unconfigure_boot_device(u8 busno, u8 device, u8 function)
>  			size = size & 0xFFFFFFFC;
>  			size = ~size + 1;
>  			end_address = start_address + size - 1;
> -			if (ibmphp_find_resource(bus, start_address, &io, IO) < 0) {
> -				err("cannot find corresponding IO resource to remove\n");
> -				return -EIO;
> -			}
> +			if (ibmphp_find_resource(bus, start_address, &io, IO))
> +				goto report_search_failure;
> +
>  			debug("io->start = %x\n", io->start);
>  			temp_end = io->end;
>  			start_address = io->end + 1;
>  			ibmphp_remove_resource(io);
>  			/* This is needed b/c of the old I/O restrictions in the BIOS */
>  			while (temp_end < end_address) {
> -				if (ibmphp_find_resource(bus, start_address, &io, IO) < 0) {
> -					err("cannot find corresponding IO resource to remove\n");
> -					return -EIO;
> -				}
> +				if (ibmphp_find_resource(bus, start_address,
> +							 &io, IO))
> +					goto report_search_failure;
> +
>  				debug("io->start = %x\n", io->start);
>  				temp_end = io->end;
>  				start_address = io->end + 1;
> @@ -1327,6 +1326,10 @@ static int unconfigure_boot_device(u8 busno, u8 device, u8 function)
>  	}	/* end of for */
>  
>  	return 0;
> +
> +report_search_failure:
> +	err("cannot find corresponding IO resource to remove\n");
> +	return -EIO;
>  }
>  
>  static int unconfigure_boot_bridge(u8 busno, u8 device, u8 function)
> -- 
> 2.14.3
> 
