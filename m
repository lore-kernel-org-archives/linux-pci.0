Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F3F3921E7;
	Tue,  7 Apr 2026 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546856; cv=none; b=Bq9R/r1NbPeTRsCZkqP5/1SxJRc/nh/8ogjxNd9yT2IpYUroSxScmhjJHnXpjJ6+lOS4nwR/9iiOK2MUW2y30oLoibE/Sjz6CDCS7YHaJbIMiQ8eMz1vddDwQ/6T05FlbdauCphItfGhxyiTZFxqlihslsbJjbq8amf8eD4aGo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546856; c=relaxed/simple;
	bh=Ke+4cfFIuUyaAYRB85WlhtaSzn9Vsqf7eLubNm2wrC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0SEjTTTNPneD2ijgza6uz4htZdSOu0bhQ/KnibN6FToo/c5XgbMgvHWcXSqX5jEBmczFoPbmPpAT94Bdr5WG6adW80a0wsm2jjQ78PvPYggnD0jwtCGh/2DcHI/bdQfPCKGGWxJc31UvY+LUk1qkpeNhpaDlxjdGH86c7rd8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m30OgZ4+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m30OgZ4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F639C116C6;
	Tue,  7 Apr 2026 07:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775546856;
	bh=Ke+4cfFIuUyaAYRB85WlhtaSzn9Vsqf7eLubNm2wrC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m30OgZ4+3p1ReP/oAexgtmU1wpHtdCwMpqLsPQ1M0sfld/z/FFzZXpYDh4e3fybYj
	 /pxqvDO1Tk2YWl7SwXOzZpmgZPuybaqhOnBhM2OusK35qXxa6nPe47jMcbyPObRx9A
	 LIBBR24hxE+0GEJyrHG5Mor7C5RciZv0K1Y119quGDDpBWRKWuWFCrZtXtkdQBW4P/
	 0NSGF1V4uZmeRTPBIIxtlEIQSD1QF0mJS+7VB4QuEvtYAR4nRExM1YEGb6Y1NIFanM
	 5dyrIFv4Z+WGfhdSU+6/pMy8q4brJ4lkLN1g/LKq88orVqzymK08dPIflO6p1CiWaw
	 stDhRXnwwdSEw==
Date: Tue, 7 Apr 2026 12:57:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Alexey Kardashevskiy <aik@ozlabs.ru>, 
	Johan Hovold <johan@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Leon Romanovsky <leon@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Robin Murphy <robin.murphy@arm.com>, maz@kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Saravana Kannan <saravanak@kernel.org>, Mark Brown <broonie@kernel.org>, alexander.stein@ew.tq-group.com, 
	andrew@codeconstruct.com.au, andrew@lunn.ch, andriy.shevchenko@linux.intel.com, 
	astewart@tektelic.com, bhelgaas@google.com, brgl@kernel.org, davem@davemloft.net, 
	devicetree@vger.kernel.org, driver-core@lists.linux.dev, hkallweit1@gmail.com, 
	jirislaby@kernel.org, joel@jms.id.au, kees@kernel.org, kuba@kernel.org, 
	lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, linux@armlinux.org.uk, 
	netdev@vger.kernel.org, pabeni@redhat.com, robh@kernel.org
Subject: Re: [PATCH v5 8/9] driver core: Replace dev->of_node_reused with
 dev_of_node_reused()
Message-ID: <xoo5ymm44t66hr5ti2apl3u7mmenbic66gi7siiiwxtdgn6bhh@hvfzixit53pf>
References: <20260406232444.3117516-1-dianders@chromium.org>
 <20260406162231.v5.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260406162231.v5.8.I806b8636cd3724f6cd1f5e199318ab8694472d90@changeid>

On Mon, Apr 06, 2026 at 04:23:01PM -0700, Douglas Anderson wrote:
> In C, bitfields are not necessarily safe to modify from multiple
> threads without locking. Switch "of_node_reused" over to the "flags"
> field so modifications are safe.
> 
> Cc: Johan Hovold <johan@kernel.org>
> Acked-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Manivannan Sadhasivam <mani@kernel.org> # PCI_PWRCTRL

- Mani

> ---
> Not fixing any known bugs; problem is theoretical and found by code
> inspection. Change is done somewhat manually and only lightly tested
> (mostly compile-time tested).
> 
> (no changes since v4)
> 
> Changes in v4:
> - Use accessor functions for flags
> 
> Changes in v3:
> - New
> 
>  drivers/base/core.c                      | 2 +-
>  drivers/base/pinctrl.c                   | 2 +-
>  drivers/base/platform.c                  | 2 +-
>  drivers/net/pcs/pcs-xpcs-plat.c          | 2 +-
>  drivers/of/device.c                      | 6 +++---
>  drivers/pci/of.c                         | 2 +-
>  drivers/pci/pwrctrl/core.c               | 2 +-
>  drivers/regulator/bq257xx-regulator.c    | 2 +-
>  drivers/regulator/rk808-regulator.c      | 2 +-
>  drivers/tty/serial/serial_base_bus.c     | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c | 2 +-
>  include/linux/device.h                   | 7 ++++---
>  12 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 8a83d7c93361..30825bf83234 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -5283,7 +5283,7 @@ void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
>  {
>  	of_node_put(dev->of_node);
>  	dev->of_node = of_node_get(dev2->of_node);
> -	dev->of_node_reused = true;
> +	dev_set_of_node_reused(dev);
>  }
>  EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
>  
> diff --git a/drivers/base/pinctrl.c b/drivers/base/pinctrl.c
> index 6e250272c843..0bbc83231234 100644
> --- a/drivers/base/pinctrl.c
> +++ b/drivers/base/pinctrl.c
> @@ -24,7 +24,7 @@ int pinctrl_bind_pins(struct device *dev)
>  {
>  	int ret;
>  
> -	if (dev->of_node_reused)
> +	if (dev_of_node_reused(dev))
>  		return 0;
>  
>  	dev->pins = devm_kzalloc(dev, sizeof(*(dev->pins)), GFP_KERNEL);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index d44591d52e36..199e6fb25770 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -856,7 +856,7 @@ struct platform_device *platform_device_register_full(
>  	pdev->dev.parent = pdevinfo->parent;
>  	pdev->dev.fwnode = pdevinfo->fwnode;
>  	pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
> -	pdev->dev.of_node_reused = pdevinfo->of_node_reused;
> +	dev_assign_of_node_reused(&pdev->dev, pdevinfo->of_node_reused);
>  
>  	if (pdevinfo->dma_mask) {
>  		pdev->platform_dma_mask = pdevinfo->dma_mask;
> diff --git a/drivers/net/pcs/pcs-xpcs-plat.c b/drivers/net/pcs/pcs-xpcs-plat.c
> index b8c48f9effbf..f4b1b8246ce9 100644
> --- a/drivers/net/pcs/pcs-xpcs-plat.c
> +++ b/drivers/net/pcs/pcs-xpcs-plat.c
> @@ -349,7 +349,7 @@ static int xpcs_plat_init_dev(struct dw_xpcs_plat *pxpcs)
>  	 * up later. Make sure DD-core is aware of the OF-node being re-used.
>  	 */
>  	device_set_node(&mdiodev->dev, fwnode_handle_get(dev_fwnode(dev)));
> -	mdiodev->dev.of_node_reused = true;
> +	dev_set_of_node_reused(&mdiodev->dev);
>  
>  	/* Pass the data further so the DW XPCS driver core could use it */
>  	mdiodev->dev.platform_data = (void *)device_get_match_data(dev);
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index f7e75e527667..be4e1584e0af 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -26,7 +26,7 @@
>  const struct of_device_id *of_match_device(const struct of_device_id *matches,
>  					   const struct device *dev)
>  {
> -	if (!matches || !dev->of_node || dev->of_node_reused)
> +	if (!matches || !dev->of_node || dev_of_node_reused(dev))
>  		return NULL;
>  	return of_match_node(matches, dev->of_node);
>  }
> @@ -192,7 +192,7 @@ ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len)
>  {
>  	ssize_t sl;
>  
> -	if (!dev || !dev->of_node || dev->of_node_reused)
> +	if (!dev || !dev->of_node || dev_of_node_reused(dev))
>  		return -ENODEV;
>  
>  	sl = of_modalias(dev->of_node, str, len - 2);
> @@ -254,7 +254,7 @@ int of_device_uevent_modalias(const struct device *dev, struct kobj_uevent_env *
>  {
>  	int sl;
>  
> -	if ((!dev) || (!dev->of_node) || dev->of_node_reused)
> +	if ((!dev) || (!dev->of_node) || dev_of_node_reused(dev))
>  		return -ENODEV;
>  
>  	/* Devicetree modalias is tricky, we add it in 2 steps */
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 9f8eb5df279e..1f9b669abdb0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -38,7 +38,7 @@ int pci_set_of_node(struct pci_dev *dev)
>  	struct device *pdev __free(put_device) =
>  		bus_find_device_by_of_node(&platform_bus_type, node);
>  	if (pdev)
> -		dev->bus->dev.of_node_reused = true;
> +		dev_set_of_node_reused(&dev->bus->dev);
>  
>  	device_set_node(&dev->dev, of_fwnode_handle(no_free_ptr(node)));
>  	return 0;
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 7754baed67f2..72963a92362a 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -39,7 +39,7 @@ static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>  		 * If we got here then the PCI device is the second after the
>  		 * power control platform device. Mark its OF node as reused.
>  		 */
> -		dev->of_node_reused = true;
> +		dev_set_of_node_reused(dev);
>  		break;
>  	}
>  
> diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
> index dab8f1ab4450..40e0f1a7ae81 100644
> --- a/drivers/regulator/bq257xx-regulator.c
> +++ b/drivers/regulator/bq257xx-regulator.c
> @@ -143,7 +143,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
>  	struct regulator_config cfg = {};
>  
>  	pdev->dev.of_node = pdev->dev.parent->of_node;
> -	pdev->dev.of_node_reused = true;
> +	dev_set_of_node_reused(&pdev->dev);
>  
>  	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
>  	if (!pdata)
> diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
> index e66408f23bb6..8297d31cde9f 100644
> --- a/drivers/regulator/rk808-regulator.c
> +++ b/drivers/regulator/rk808-regulator.c
> @@ -2115,7 +2115,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
>  	int ret, i, nregulators;
>  
>  	pdev->dev.of_node = pdev->dev.parent->of_node;
> -	pdev->dev.of_node_reused = true;
> +	dev_set_of_node_reused(&pdev->dev);
>  
>  	regmap = dev_get_regmap(pdev->dev.parent, NULL);
>  	if (!regmap)
> diff --git a/drivers/tty/serial/serial_base_bus.c b/drivers/tty/serial/serial_base_bus.c
> index a12935f6b992..5f23284a8778 100644
> --- a/drivers/tty/serial/serial_base_bus.c
> +++ b/drivers/tty/serial/serial_base_bus.c
> @@ -74,7 +74,7 @@ static int serial_base_device_init(struct uart_port *port,
>  	dev->parent = parent_dev;
>  	dev->bus = &serial_base_bus_type;
>  	dev->release = release;
> -	dev->of_node_reused = true;
> +	dev_set_of_node_reused(dev);
>  
>  	device_set_node(dev, fwnode_handle_get(dev_fwnode(parent_dev)));
>  
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> index 2ecd049dacc2..8b9449d16324 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -593,7 +593,7 @@ int ast_vhub_init_dev(struct ast_vhub *vhub, unsigned int idx)
>  		d->gadget.max_speed = USB_SPEED_HIGH;
>  	d->gadget.speed = USB_SPEED_UNKNOWN;
>  	d->gadget.dev.of_node = vhub->pdev->dev.of_node;
> -	d->gadget.dev.of_node_reused = true;
> +	dev_set_of_node_reused(&d->gadget.dev);
>  
>  	rc = usb_add_gadget_udc(d->port_dev, &d->gadget);
>  	if (rc != 0)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 5b0fb6ad4c72..a79865a212e9 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -483,6 +483,8 @@ struct device_physical_location {
>   *		driver/bus sync_state() callback.
>   * @DEV_FLAG_DMA_COHERENT: This particular device is dma coherent, even if the
>   *		architecture supports non-coherent devices.
> + * @DEV_FLAG_OF_NODE_REUSED: Set if the device-tree node is shared with an
> + *		ancestor device.
>   */
>  enum struct_device_flags {
>  	DEV_FLAG_READY_TO_PROBE = 0,
> @@ -492,6 +494,7 @@ enum struct_device_flags {
>  	DEV_FLAG_DMA_OPS_BYPASS = 4,
>  	DEV_FLAG_STATE_SYNCED = 5,
>  	DEV_FLAG_DMA_COHERENT = 6,
> +	DEV_FLAG_OF_NODE_REUSED = 7,
>  
>  	DEV_FLAG_COUNT
>  };
> @@ -573,8 +576,6 @@ enum struct_device_flags {
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:	Set after successful invocation of bus type's .offline().
> - * @of_node_reused: Set if the device-tree node is shared with an ancestor
> - *              device.
>   * @flags:	DEV_FLAG_XXX flags. Use atomic bitfield operations to modify.
>   *
>   * At the lowest level, every device in a Linux system is represented by an
> @@ -681,7 +682,6 @@ struct device {
>  
>  	bool			offline_disabled:1;
>  	bool			offline:1;
> -	bool			of_node_reused:1;
>  
>  	DECLARE_BITMAP(flags, DEV_FLAG_COUNT);
>  };
> @@ -715,6 +715,7 @@ __create_dev_flag_accessors(dma_skip_sync, DEV_FLAG_DMA_SKIP_SYNC);
>  __create_dev_flag_accessors(dma_ops_bypass, DEV_FLAG_DMA_OPS_BYPASS);
>  __create_dev_flag_accessors(state_synced, DEV_FLAG_STATE_SYNCED);
>  __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
> +__create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
>  
>  #undef __create_dev_flag_accessors
>  
> -- 
> 2.53.0.1213.gd9a14994de-goog
> 

-- 
மணிவண்ணன் சதாசிவம்
