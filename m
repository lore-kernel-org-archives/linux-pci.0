Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61565 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab2HFNaH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 6 Aug 2012 09:30:07 -0400
MIME-Version: 1.0
In-Reply-To: <201208051726.22729.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1208041806490.23711-100000@netrider.rowland.org>
	<201208051726.22729.rjw@sisk.pl>
Date: Mon, 6 Aug 2012 21:30:05 +0800
Message-ID: <CACVXFVPNO2yQXJjwPGm8oLeNHsj72wtHnJ5YKLg65hR2X7BWDg@mail.gmail.com>
Subject: Re: Do we need asynchronous pm_runtime_get()? (was: Re: bisected
 regression ...)
From: Ming Lei <tom.leiming@gmail.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-pci@vger.kernel.org,
	USB list <linux-usb@vger.kernel.org>,
	Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Aug 5, 2012 at 11:26 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> ---
>  drivers/base/power/runtime.c |   82 +++++++++++++++++++++++++++++++++++++++----
>  include/linux/pm.h           |    1
>  include/linux/pm_runtime.h   |   14 +++++++
>  3 files changed, 90 insertions(+), 7 deletions(-)
>
> Index: linux/drivers/base/power/runtime.c
> ===================================================================
> --- linux.orig/drivers/base/power/runtime.c
> +++ linux/drivers/base/power/runtime.c
> @@ -484,6 +484,15 @@ static int rpm_suspend(struct device *de
>         goto out;
>  }
>
> +void rpm_queue_up_resume(struct device *dev)
> +{
> +       dev->power.request = RPM_REQ_RESUME;
> +       if (!dev->power.request_pending) {
> +               dev->power.request_pending = true;
> +               queue_work(pm_wq, &dev->power.work);
> +       }
> +}
> +
>  /**
>   * rpm_resume - Carry out runtime resume of given device.
>   * @dev: Device to resume.
> @@ -524,7 +533,9 @@ static int rpm_resume(struct device *dev
>          * rather than cancelling it now only to restart it again in the near
>          * future.
>          */
> -       dev->power.request = RPM_REQ_NONE;
> +       if (dev->power.request != RPM_REQ_RESUME || !dev->power.func)
> +               dev->power.request = RPM_REQ_NONE;
> +
>         if (!dev->power.timer_autosuspends)
>                 pm_runtime_deactivate_timer(dev);
>
> @@ -533,6 +544,12 @@ static int rpm_resume(struct device *dev
>                 goto out;
>         }
>
> +       if (dev->power.func && (rpmflags & RPM_ASYNC)) {
> +               rpm_queue_up_resume(dev);
> +               retval = 0;
> +               goto out;
> +       }
> +
>         if (dev->power.runtime_status == RPM_RESUMING
>             || dev->power.runtime_status == RPM_SUSPENDING) {
>                 DEFINE_WAIT(wait);
> @@ -591,11 +608,7 @@ static int rpm_resume(struct device *dev
>
>         /* Carry out an asynchronous or a synchronous resume. */
>         if (rpmflags & RPM_ASYNC) {
> -               dev->power.request = RPM_REQ_RESUME;
> -               if (!dev->power.request_pending) {
> -                       dev->power.request_pending = true;
> -                       queue_work(pm_wq, &dev->power.work);
> -               }
> +               rpm_queue_up_resume(dev);
>                 retval = 0;
>                 goto out;
>         }
> @@ -691,6 +704,7 @@ static int rpm_resume(struct device *dev
>  static void pm_runtime_work(struct work_struct *work)
>  {
>         struct device *dev = container_of(work, struct device, power.work);
> +       void (*func)(struct device *) = NULL;
>         enum rpm_request req;
>
>         spin_lock_irq(&dev->power.lock);
> @@ -715,12 +729,24 @@ static void pm_runtime_work(struct work_
>                 rpm_suspend(dev, RPM_NOWAIT | RPM_AUTO);
>                 break;
>         case RPM_REQ_RESUME:
> -               rpm_resume(dev, RPM_NOWAIT);
> +               func = dev->power.func;
> +               if (func) {
> +                       dev->power.func = NULL;
> +                       pm_runtime_get_noresume(dev);
> +                       rpm_resume(dev, 0);
> +               } else {
> +                       rpm_resume(dev, RPM_NOWAIT);
> +               }
>                 break;
>         }
>
>   out:
>         spin_unlock_irq(&dev->power.lock);
> +
> +       if (func) {
> +               func(dev);
> +               pm_runtime_put(dev);
> +       }
>  }
>
>  /**
> @@ -877,6 +903,48 @@ int __pm_runtime_resume(struct device *d
>  }
>  EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>
> +int pm_runtime_get_and_call(struct device *dev, void (*func)(struct device *),
> +                            void (*func_async)(struct device *))
> +{
> +       unsigned long flags;
> +       int ret;
> +
> +       atomic_inc(&dev->power.usage_count);
> +
> +       spin_lock_irqsave(&dev->power.lock, flags);
> +
> +       ret = dev->power.runtime_error;
> +       if (ret) {
> +               func = NULL;
> +               goto out;
> +       }
> +
> +       if (dev->power.runtime_status != RPM_ACTIVE
> +           && dev->power.disable_depth == 0)
> +               func = NULL;

Looks the above is a bit odd, and your motivation is to call 'func'
for a suspended and runtime-PM enabled device in irq context, isn't it?

> +
> +       if (!func && func_async) {
> +               if (dev->power.func) {
> +                       ret = -EAGAIN;
> +                       goto out;
> +               } else {
> +                       dev->power.func = func_async;
> +               }
> +       }
> +
> +       rpm_resume(dev, RPM_ASYNC);
> +
> + out:
> +       spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> +       if (func) {
> +               func(dev);

Maybe the return value should be passed to caller. Also the race between
'func' and its .runtime_resume callback should be stated in comment.

In fact, maybe it is better to call 'func' always first, then call
' rpm_resume(dev, RPM_ASYNC);', otherwise the driver may
be confused about the order between 'func' and its .runtime_resume
callback.

> +               return 1;
> +       }
> +
> +       return ret;
> +}
> +
>  /**
>   * __pm_runtime_set_status - Set runtime PM status of a device.
>   * @dev: Device to handle.
> Index: linux/include/linux/pm.h
> ===================================================================
> --- linux.orig/include/linux/pm.h
> +++ linux/include/linux/pm.h
> @@ -547,6 +547,7 @@ struct dev_pm_info {
>         unsigned long           suspended_jiffies;
>         unsigned long           accounting_timestamp;
>         struct dev_pm_qos_request *pq_req;
> +       void                    (*func)(struct device *);

Another way is to define 'func' as 'runtime_pre_resume'
in 'struct dev_pm_ops', and there are some advantages about this way:

        - save one pointer in 'struct devices, since most of devices
don't need the 'func'
        - well documents on 'runtime_pre_resume'
        - caller of pm_runtime_get_and_call may be happier, maybe just
        pm_runtime_get or *_aync is enough.


Thanks,
-- 
Ming Lei
