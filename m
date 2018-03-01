Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1519843555-982-1-git-send-email-fkan@apm.com>
References: <1519843555-982-1-git-send-email-fkan@apm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Mar 2018 10:59:48 +0100
Message-ID: <CAJZ5v0jMOLSEzC9F67TJpgP6Z0JN1dr2uwjfrNfwDkTR8OVGyg@mail.gmail.com>
Subject: Re: [PATCH] PM / core: move device and its children to end of dpm list
To: Feng Kan <fkan@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>,
 Toan Le <toanle@apm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 7:45 PM, Feng Kan <fkan@apm.com> wrote:
> When bridge and its endpoint is enumated the devices are added to the
> dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
> This causes the bridge to be moved to the end of the dpm list when deferred
> probe kicks in. The order of the dpm list for bridge and endpoint is
> reversed.
>
> Add reordering code to re-position the bridge and its children so the order
> for suspend and resume is not altered.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Toan Le <toanle@apm.com>
> ---
>  drivers/base/core.c    | 20 ++++++++++++++++++++
>  drivers/base/dd.c      |  8 ++++----
>  include/linux/device.h |  3 +++
>  3 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 110230d..0b4ad99 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -148,6 +148,26 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>  }
>
>  /**
> + * device_pm_reorder - reorder device and its children to end of dpm list

Not just the children and not just dpm_list.

> + * @dev: current device pointer
> + *
> + * This is a lock held version of reordering the device to dpm list tail.
> + * This will move the device to the end of the dpm list if it not registered.
> + * Afterward, it will iterate through its children and do the same for them.

This isn't entirely accurate as device_reorder_to_tail() does more than that.

> + */
> +void device_pm_reorder(struct device *dev)

I'd call it device_pm_move_to_tail() as that's what it does.

"Reorder" is sort of overly generic IMO.

> +{
> +       int idx;
> +
> +       idx = device_links_read_lock();
> +       device_pm_lock();
> +       device_reorder_to_tail(dev, NULL);
> +       device_pm_unlock();
> +       device_links_read_unlock(idx);
> +}
> +EXPORT_SYMBOL_GPL(device_pm_reorder);

It is not necessary to export this symbol.

> +
> +/**
>   * device_link_add - Create a link between two devices.
>   * @consumer: Consumer end of the link.
>   * @supplier: Supplier end of the link.
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 2c964f5..3223a30 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -121,11 +121,11 @@ static void deferred_probe_work_func(struct work_struct *work)
>                  * Force the device to the end of the dpm_list since
>                  * the PM code assumes that the order we add things to
>                  * the list is a good order for suspend but deferred
> -                * probe makes that very unsafe.
> +                * probe makes that very unsafe. Also move any children
> +                * belong to the device to the end of the list as well.
> +                * This way the suspend resume order won't be corrupted.
>                  */
> -               device_pm_lock();
> -               device_pm_move_last(dev);
> -               device_pm_unlock();
> +               device_pm_reorder(dev);
>
>                 dev_dbg(dev, "Retrying from deferred list\n");
>                 if (initcall_debug && !initcalls_done)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 9d32000..1ec12d5 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1272,6 +1272,9 @@ extern void devm_device_remove_group(struct device *dev,
>  /* debugging and troubleshooting/diagnostic helpers. */
>  extern const char *dev_driver_string(const struct device *dev);
>
> +/* reorder device and its children to end of dpm list */
> +void device_pm_reorder(struct device *dev);

And this header can go into drivers/base/base.h as Bjorn said.

> +
>  /* Device links interface. */
>  struct device_link *device_link_add(struct device *consumer,
>                                     struct device *supplier, u32 flags);
> --
> 1.8.3.1
>

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
