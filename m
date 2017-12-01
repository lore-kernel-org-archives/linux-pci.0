Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Fri, 1 Dec 2017 11:13:25 +0200
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V4 3/5] device property: Introduce a common API to fetch
 device match data
Message-ID: <20171201091325.weepl5rtxg4zqqyd@paasikivi.fi.intel.com>
References: <1512096776-22883-1-git-send-email-okaya@codeaurora.org>
 <1512096776-22883-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <1512096776-22883-4-git-send-email-okaya@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-arm-msm@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-pci@vger.kernel.org,
 timur@codeaurora.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 open list <linux-kernel@vger.kernel.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sinan,

Thanks for the patch.

On Thu, Nov 30, 2017 at 09:52:54PM -0500, Sinan Kaya wrote:
> There is an OF/ACPI function to obtain the driver data. We want to hide
> OF/ACPI details from the device drivers and abstract following the device
> family of functions.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/base/property.c  | 14 ++++++++++++++
>  include/linux/property.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 7ed99c1..6adec89 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -15,6 +15,7 @@
>  #include <linux/kernel.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/of_graph.h>
>  #include <linux/property.h>
>  #include <linux/etherdevice.h>
> @@ -1335,3 +1336,16 @@ int fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
>  	return fwnode_call_int_op(fwnode, graph_parse_endpoint, endpoint);
>  }
>  EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
> +
> +void *device_get_match_data(struct device *dev)
> +{
> +	void *ret;
> +
> +	if (IS_ENABLED(CONFIG_OF) && dev->of_node)

Most of the dev->of_node checks have been removed from property.c and
replaced by calls to the firmware specific fwnode operations. What remains
should probably be moved there, too (apart from dev_fwnode).

How about adding a new op for this one to struct fwnode_operations in
include/linux/fwnode.h?

> +		ret = (void *)of_device_get_match_data(dev);
> +	else
> +		ret = acpi_get_match_data(dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(device_get_match_data);
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 6bebee1..01fa55b 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -275,6 +275,8 @@ int device_add_properties(struct device *dev,
>  
>  enum dev_dma_attr device_get_dma_attr(struct device *dev);
>  
> +void *device_get_match_data(struct device *dev);
> +
>  int device_get_phy_mode(struct device *dev);
>  
>  void *device_get_mac_address(struct device *dev, char *addr, int alen);

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
