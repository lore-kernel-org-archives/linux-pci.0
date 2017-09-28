Return-Path: <SRS0=yaEI=A5=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=yaEI=A5=linuxfoundation.org=gregkh@kernel.org>
Date: Thu, 28 Sep 2017 11:02:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>,
	Alan Cox <alan@linux.intel.com>,
	Dan J Williams <dan.j.williams@intel.com>
Subject: Re: [RFC 2/3] module: Ignore delete_id parameter
Message-ID: <20170928090234.GB12599@kroah.com>
References: <1506544822-2632-1-git-send-email-jonathan.derrick@intel.com>
 <1506544822-2632-3-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1506544822-2632-3-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 27, 2017 at 04:40:21PM -0400, Jon Derrick wrote:
> The PCI driver delete_id parameter is handled in each individual driver
> registration callback.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  kernel/module.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index de66ec8..2b2dccf 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3620,6 +3620,13 @@ static int unknown_module_param_cb(char *param, char *val, const char *modname,
>  		return 0;
>  	}
>  
> +	/*
> +	 * Ignore driver delete list arguments. They are handled by driver
> +	 * registration callbacks
> +	 */
> +	if (strcmp(param, "delete_id") == 0)
> +		return 0;

Why?  This is only for the PCI core as you have defined it in this
patchset, but you just broke this module id for all other kernel modules
in the system :(

If you want to do this, you need to provide this feature for _all_
kernel drivers...

thanks,

greg k-h
