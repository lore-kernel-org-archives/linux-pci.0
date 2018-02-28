Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 28 Feb 2018 13:56:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Feng Kan <fkan@apm.com>
Subject: Re: [PATCH] PM / core: move device and its children to end of dpm list
Message-ID: <20180228195641.GI127842@bhelgaas-glaptop.roam.corp.google.com>
References: <1519843555-982-1-git-send-email-fkan@apm.com>
MIME-Version: 1.0
In-Reply-To: <1519843555-982-1-git-send-email-fkan@apm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org,
 linux-pci@vger.kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
 Toan Le <toanle@apm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:45:55AM -0800, Feng Kan wrote:
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

Do you expect drivers to use this, or only the driver core in
drivers/base/?  There is a drivers/base/base.h; maybe this would fit
there rather than being exposed to the rest of the kernel via
include/linux/device.h?

>  /* Device links interface. */
>  struct device_link *device_link_add(struct device *consumer,
>  				    struct device *supplier, u32 flags);
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
