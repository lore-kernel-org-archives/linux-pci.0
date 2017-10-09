Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751752AbdJIIRj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2017 04:17:39 -0400
Date: Mon, 9 Oct 2017 10:17:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jia-Ju Bai <baijiaju1990@163.com>
Cc: patrik.r.jakobsson@gmail.com, airlied@linux.ie,
        bhelgaas@google.com, forest@alittletooquiet.net, simon@nikanor.nu,
        scott@matheina.com, tvboxspy@gmail.com, dan.a.cashman@gmail.com,
        golubev.mikhail@gmail.com, devel@driverdev.osuosl.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] pci: Fix a possible sleep-in-atomic bug in
 pci_set_power_state
Message-ID: <20171009081747.GA23371@kroah.com>
References: <1507536980-9345-1-git-send-email-baijiaju1990@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1507536980-9345-1-git-send-email-baijiaju1990@163.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

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

Wait, no, why not fix the callers to not have a spinlock.  Those are the
only users of these calls that are doing so incorrectly, don't change
the PCI core for the fault of 2 broken drivers.

thanks,

greg k-h
