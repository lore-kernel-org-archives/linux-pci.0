Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1519433209-14581-1-git-send-email-fkan@apm.com>
References: <1519433209-14581-1-git-send-email-fkan@apm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 24 Feb 2018 10:35:25 +0100
Message-ID: <CAJZ5v0hDM=DtBZA1awz7ao62cpe4CAhUz1L7KkLTv=G3YQhuEw@mail.gmail.com>
Subject: Re: [PATCH] PCIe bridge deferred probe breaks suspend resume
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
 Bjorn Helgaas <bhelgaas@google.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Feb 24, 2018 at 1:46 AM, Feng Kan <fkan@apm.com> wrote:
> This is not a patch, but rather a question regarding the deferred
> probe's effect on PCIe PM ordering. This happens on our system
> which defer the probing of root bridge due to  the IOMMU not being
> ready. Because of the deferred action, the bridge is moved to the
> end of the dpm_list which results in incorrect suspend and resume
> sequence.
>
> In the cases I have seen, the bridge is always reordered because of
> startup sequence. They are always place after the endpoint. If that
> is the case the following code should be able to prevent such cases.
> However, is there some cases here that would violate such situation?

The code in dd.c assumes that the device being probed has no children
(or consumers, for that matter) and so it is safe to move it to the
end of the list.

If the device has children (or consumers), moving it to the end of the
list by itself doesn't work, which is the case for you.

> ---
>  drivers/base/dd.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index de6fd09..5b96d5c 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -116,15 +116,17 @@ static void deferred_probe_work_func(struct work_struct *work)
>                  */
>                 mutex_unlock(&deferred_probe_mutex);
>
> -               /*
> -                * Force the device to the end of the dpm_list since
> -                * the PM code assumes that the order we add things to
> -                * the list is a good order for suspend but deferred
> -                * probe makes that very unsafe.
> -                */
> -               device_pm_lock();
> -               device_pm_move_last(dev);
> -               device_pm_unlock();
> +                if (!dev_is_pci(dev)) {

You can't do this here.

It is not clear why all PCI devices should be an exception in the
first place.  There may be PCI devices without children that need to
be moved to the end of the list and you'd break that case.

> +                        /*
> +                         * Force the device to the end of the dpm_list since
> +                         * the PM code assumes that the order we add things to
> +                         * the list is a good order for suspend but deferred
> +                         * probe makes that very unsafe.
> +                         */
> +                        device_pm_lock();
> +                        device_pm_move_last(dev);
> +                        device_pm_unlock();
> +                }
>
>                 dev_dbg(dev, "Retrying from deferred list\n");
>                 if (initcall_debug && !initcalls_done)
> --

You can try to replace the device_pm_move_last(dev) in
deferred_probe_work_func(struct() with device_reorder_to_tail(), but
that has to be called under device_links_read_lock/unloc () and
device_pm_lock/unloc() (in the right order).

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
