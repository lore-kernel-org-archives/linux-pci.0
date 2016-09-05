Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35120 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933500AbcIENT4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2016 09:19:56 -0400
Received: by mail-pa0-f52.google.com with SMTP id hb8so61795335pac.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Sep 2016 06:19:55 -0700 (PDT)
Subject: Re: [PATCH v4 05/15] drivers: platform: add fwnode base platform
 devices retrieval
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1471274620-20754-6-git-send-email-lorenzo.pieralisi@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tomasz Nowicki <tn@semihalf.com>, Jon Masters <jcm@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Nate Watterson <nwatters@codeaurora.org>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Hanjun Guo <hanjun.guo@linaro.org>
Message-ID: <7659b956-c49d-bd0d-7a1d-8dfc3da6f409@linaro.org>
Date: Mon, 5 Sep 2016 21:19:43 +0800
MIME-Version: 1.0
In-Reply-To: <1471274620-20754-6-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2016/8/15 23:23, Lorenzo Pieralisi wrote:
> The platform device kernel API does not provide functions to
> retrieve a platform device through the corresponding struct
> device fwnode pointer.
>
> Implement the fwnode platform_device look-up in drivers core
> code by using the bus_find_device() API and a corresponding
> matching function. The OF equivalent (eg of_find_device_by_node())
> will reuse the newly introduced function when OF code will
> take care of setting up the device->fwnode value that is
> currently left dangling for platform devices instantiated out
> of device tree nodes.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/base/platform.c         | 23 +++++++++++++++++++++++
>  include/linux/platform_device.h |  3 +++
>  2 files changed, 26 insertions(+)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 6482d47..3ef150d 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -760,6 +760,29 @@ err_out:
>  }
>  EXPORT_SYMBOL_GPL(__platform_create_bundle);
>
> +static int fwnode_dev_match(struct device *dev, void *data)
> +{
> +	return dev->fwnode == data;
> +}
> +
> +/**
> + * platform_find_device_by_fwnode() - Find the platform_device associated
> + *				      with a fwnode
> + * @fwnode: Pointer to firmware node
> + *
> + * Returns platform_device pointer, or NULL if not found
> + */
> +struct platform_device *
> +platform_find_device_by_fwnode(struct fwnode_handle *fwnode)
> +{
> +	struct device *dev;
> +
> +	dev = bus_find_device(&platform_bus_type, NULL, fwnode,
> +			      fwnode_dev_match);
> +	return dev ? to_platform_device(dev) : NULL;
> +}
> +EXPORT_SYMBOL(platform_find_device_by_fwnode);

As SMMU is registered as platform devices, I think we need such
API to retrieve the platform device with fwnode handle, actually
Kefeng introduced a similar patch [1], but your patch is more
generic, so this patch make sense to me,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

[1]: https://patchwork.kernel.org/patch/7743661/
