Return-Path: <SRS0=vrGS=JT=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=vrGS=JT=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Pingfan Liu <kernelfans@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 3/4] drivers/base: clean up the usage of devices_kset_move_last()
Date: Tue, 03 Jul 2018 16:26:40 +0200
Message-ID: <3375966.ydPZj5TMVj@aspire.rjw.lan>
In-Reply-To: <1530600642-25090-4-git-send-email-kernelfans@gmail.com>
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com> <1530600642-25090-4-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, July 3, 2018 8:50:41 AM CEST Pingfan Liu wrote:
> Clean up the referring to the code in commit 52cdbdd49853 ("driver core:
> correct device's shutdown order"). So later we can revert it safely.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> ---
>  drivers/base/core.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 684b994..db3deb8 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>  {
>  	struct device_link *link;
>  
> -	/*
> -	 * Devices that have not been registered yet will be put to the ends
> -	 * of the lists during the registration, so skip them here.
> -	 */
> -	if (device_is_registered(dev))
> -		devices_kset_move_last(dev);
> -
>  	if (device_pm_initialized(dev))
>  		device_pm_move_last(dev);

You can't do this.

If you do it, that will break power management in some situations.

Thanks,
Rafael
