Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 9 Oct 2017 12:15:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jia-Ju Bai <baijiaju1990@163.com>
Cc: patrik.r.jakobsson@gmail.com, airlied@linux.ie,
        bhelgaas@google.com, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, simon@nikanor.nu, scott@matheina.com,
        tvboxspy@gmail.com, dan.a.cashman@gmail.com,
        golubev.mikhail@gmail.com, devel@driverdev.osuosl.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] pci: Fix a possible sleep-in-atomic bug in
 pci_set_power_state
Message-ID: <20171009171517.GL25517@bhelgaas-glaptop.roam.corp.google.com>
References: <1507536980-9345-1-git-send-email-baijiaju1990@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507536980-9345-1-git-send-email-baijiaju1990@163.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Rafael, linux-pm]

Hi Jia-Ju,

On Mon, Oct 09, 2017 at 04:16:20PM +0800, Jia-Ju Bai wrote:
> The drivers vt6655 and gma500 call pci_set_power_state under a spinlock, which may sleep.
> The function call paths are:
> gma_power_begin (acquire the spinlock) (drivers/gpu/drm/gma500/power.c)
>   gma_resume_pci
>     pci_set_power_state
>       __pci_start_power_transition (drivers/pci/pci.c)
>         msleep --> may sleep
> 
> gma_power_begin (acquire the spinlock) (drivers/gpu/drm/gma500/power.c)
>   gma_resume_pci
>     pci_enable_device
>       pci_enable_device_flags (drivers/pci/pci.c)
>         do_pci_enable_device
>           pci_set_power_state
>             __pci_start_power_transition
>               msleep --> may sleep
> 
> vt6655_suspend (acquire the spinlock) (drivers/staging/vt6655/device_main.c)
>   pci_set_power_state
>     __pci_start_power_transition (drivers/pci/pci.c)
>       msleep --> may sleep
> 
> To fix these bugs, msleep is replaced with mdelay in __pci_start_power_transition
> 
> These bugs are found by my static analysis tool and my code review.

We can either

  - change pci_set_power_state() so it can be called while holding a
    spinlock (as this patch does), or
    
  - change the drivers so they don't hold the spinlock while calling 
    pci_set_power_state().

I think the latter is better because d3cold_delay is typically 100ms,
and that's a long time to spin with interrupts disabled.

I assume it's easy to produce an actual failure here?  Why haven't we
seen bug reports about this?

Bjorn

> Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
> ---
>  drivers/pci/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 6078dfc..7b763a3 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -823,7 +823,7 @@ static void __pci_start_power_transition(struct pci_dev *dev, pci_power_t state)
>  		 */
>  		if (dev->runtime_d3cold) {
>  			if (dev->d3cold_delay)
> -				msleep(dev->d3cold_delay);
> +				mdelay(dev->d3cold_delay);
>  			/*
>  			 * When powering on a bridge from D3cold, the
>  			 * whole hierarchy may be powered on into
> -- 
> 1.7.9.5
> 
> 
