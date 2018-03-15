Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1520274579-30492-1-git-send-email-fkan@apm.com>
References: <1520274579-30492-1-git-send-email-fkan@apm.com>
From: Feng Kan <fkan@apm.com>
Date: Thu, 15 Mar 2018 11:41:33 -0700
Message-ID: <CAL85gmAAVoCCXoLH+c0ROSBy4mS3z86tnbX+7Avh5oGT=fHcfA@mail.gmail.com>
Subject: Re: [PATCH V3] PM / core: fix deferred probe breaking suspend resume
 order
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Feng Kan <fkan@apm.com>, Toan Le <toanle@apm.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 5, 2018 at 10:29 AM, Feng Kan <fkan@apm.com> wrote:
> When bridge and its endpoint is enumerated the devices are added to the
> dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
> This causes the bridge to be moved to the end of the dpm list when
> deferred probe kicks in. The order of the dpm list for bridge and
> endpoint is reversed.
>
> Add reordering code to move the bridge and its children and consumers to
> the end of the pm list so the order for suspend and resume is not altered.
> The code also move device and its children and consumers to the tail of
> device_kset list if it is registered.
>
> Signed-off-by: Feng Kan <fkan@apm.com>
> Signed-off-by: Toan Le <toanle@apm.com>
> ---
>  V3:
>         1. additional code comment changes
>  V2:
>         1. change patch title from "move device and its children..."
>         2. move define based on Bjorn's comment
>         3. rename function name and comment content
>
>  drivers/base/base.h |  3 +++
>  drivers/base/core.c | 20 ++++++++++++++++++++
>  drivers/base/dd.c   |  4 +---
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index d800de6..a75c302 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -161,3 +161,6 @@ static inline void module_remove_driver(struct device_driver *drv) { }
>  extern void device_links_no_driver(struct device *dev);
>  extern bool device_links_busy(struct device *dev);
>  extern void device_links_unbind_consumers(struct device *dev);
> +
> +/* device pm support */
> +void device_pm_move_to_tail(struct device *dev);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 110230d..3b37906 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -148,6 +148,26 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>  }
>
>  /**
> + * device_pm_move_to_tail - Move set of devices to the end of device lists
> + * @dev: current device pointer
> + *
> + * This is a device_reorder_to_tail() wrapper taking the requisite locks.
> + *
> + * It moves the device along with all of its children and all of its consumers
> + * to the ends of the device_kset and dpm_list, recursively.
> + */
> +void device_pm_move_to_tail(struct device *dev)
> +{
> +       int idx;
> +
> +       idx = device_links_read_lock();
> +       device_pm_lock();
> +       device_reorder_to_tail(dev, NULL);
> +       device_pm_unlock();
> +       device_links_read_unlock(idx);
> +}
> +
> +/**
>   * device_link_add - Create a link between two devices.
>   * @consumer: Consumer end of the link.
>   * @supplier: Supplier end of the link.
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 2c964f5..96fab29 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -123,9 +123,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>                  * the list is a good order for suspend but deferred
>                  * probe makes that very unsafe.
>                  */
> -               device_pm_lock();
> -               device_pm_move_last(dev);
> -               device_pm_unlock();
> +               device_pm_move_to_tail(dev);
>
>                 dev_dbg(dev, "Retrying from deferred list\n");
>                 if (initcall_debug && !initcalls_done)
> --
> 1.8.3.1
>
Hi, just wanted to check if there is anything else I need to change on
this. Thanks.

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
