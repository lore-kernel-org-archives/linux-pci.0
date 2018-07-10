Return-Path: <SRS0=si9H=J2=gmail.com=kernelfans@kernel.org>
Return-Path: <SRS0=si9H=J2=gmail.com=kernelfans@kernel.org>
MIME-Version: 1.0
References: <1530600642-25090-1-git-send-email-kernelfans@gmail.com>
 <2108146.dv4EAOf6IP@aspire.rjw.lan> <CAFgQCTsGC8NH+5kXYD7vykJeUsaAzCAjgxSP-R0EqA3YvgsY0w@mail.gmail.com>
 <8816662.k3KXbdkA2e@aspire.rjw.lan>
In-Reply-To: <8816662.k3KXbdkA2e@aspire.rjw.lan>
From: Pingfan Liu <kernelfans@gmail.com>
Date: Tue, 10 Jul 2018 14:33:25 +0800
Message-ID: <CAFgQCTvyPY5KiaSR0P0z+K_CTOA45kvjm=w7tWnTbvH_yy858w@mail.gmail.com>
Subject: Re: [PATCH] driver core: Drop devices_kset_move_last() call from really_probe()
To: rjw@rjwysocki.net
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	Grygorii Strashko <grygorii.strashko@ti.com>, Christoph Hellwig <hch@infradead.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
	lukas@wunner.de, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 6, 2018 at 6:01 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The devices_kset_move_last() call in really_probe() is a mistake
> as it may cause parents to follow children in the devices_kset list
> which then causes system shutdown to fail.  Namely, if a device has
> children before really_probe() is called for it (which is not
> uncommon), that call will cause it to be reordered after the children
> in the devices_kset list and the ordering of that list will not
> reflect the correct device shutdown order.
>
> Also it causes the devices_kset list to be constantly reordered
> until all drivers have been probed which is totally pointless
> overhead in the majority of cases.
>
> For that reason, revert the really_probe() modifications made by
> commit 52cdbdd49853.
>
> Fixes: 52cdbdd49853 (driver core: correct device's shutdown order)
> Link: https://lore.kernel.org/lkml/CAFgQCTt7VfqM=UyCnvNFxrSw8Z6cUtAi3HUwR4_xPAc03SgHjQ@mail.gmail.com/
> Reported-by: Pingfan Liu <kernelfans@gmail.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/base/dd.c |    8 --------
>  1 file changed, 8 deletions(-)
>
> Index: linux-pm/drivers/base/dd.c
> ===================================================================
> --- linux-pm.orig/drivers/base/dd.c
> +++ linux-pm/drivers/base/dd.c
> @@ -434,14 +434,6 @@ re_probe:
>                         goto probe_failed;
>         }
>
> -       /*
> -        * Ensure devices are listed in devices_kset in correct order
> -        * It's important to move Dev to the end of devices_kset before
> -        * calling .probe, because it could be recursive and parent Dev
> -        * should always go first
> -        */
> -       devices_kset_move_last(dev);
> -
>         if (dev->bus->probe) {
>                 ret = dev->bus->probe(dev);
>                 if (ret)
>
Tested-by: Pingfan Liu <kernelfans@gmail.com>
