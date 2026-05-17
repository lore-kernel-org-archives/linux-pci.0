Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083002F0661
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779052915; cv=none; b=lRvRL7MeOb4GZAjL5kb2TBkdUX5BaKp8ou9oZKknvLGi+BgFdB1sBuYVCYchHw/7vPCR7MfROmNVBxoGt0IAZc1wFFSRxbxT2Y7e5VV+QrKcuwqw9WwIYyrveub133jsU7Gh+YmCRFtKtLlbyPWLO3zWlh9zFVvWj5Uv5wKp3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779052915; c=relaxed/simple;
	bh=b6yLdFKopyjDfx4WQ3C6hq8Xo8sq+E0p6lNCXgLfYbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3+H1MnF9y4DL6k45flc7g09L2C0staZKdyVFzk9h0fN5kmE7zLFWlwPXbB2qVfCQRYcfs4Rgz+/DhWq4DhLT2nlkvBGBOz8tcnekxUSU4yNnVQ84XOucFVyVg845Qoeu8CR+3IgXj0hiaJP9ZJn8vGGHiRpd2rPLihnr/wqsm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5XZ1M2c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5XZ1M2c"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so17147165e9.0
        for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779052912; x=1779657712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47iB118/0PzBRujH61PMBcnpDbponJHAi7Tbqe+j/Zw=;
        b=p5XZ1M2cULdQiprPiupCg6Lz5TrkXDprEZaPHGSCBum314zmP8JNYrzqfZ6BfTxtSx
         DGl/gnRMMAFPEbWfUVmdXbh+ZnhDLxN/jW6hMB6d07DAt8efYfqzPyQRPoHuSdqPhQ2k
         tRH2fpsxPPhynyHJvPAvouXz6KkPuLdHxmfn2IkagG1CStK2u8nF6GXKVFiDUSIeOa+I
         0741ifzUMb/j6nsRkX0Rqn2tANpvwCGPSxSxHxrvf/2ObZKajf47QZHjguDgpoC+wiaf
         pJcq80yWCSJ71AcM7UfrQGfFxtxqz/o7Fum9VunE8ZbQBPMTTRimf+unTWnNGOgx2RvI
         YRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779052912; x=1779657712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=47iB118/0PzBRujH61PMBcnpDbponJHAi7Tbqe+j/Zw=;
        b=JsA1gxcn4DVAFDiFZGWt1a0acyrlvWxb5rsOMKIjeYGWSk8BpbehzlBWAGwzWCVKSi
         NkmhtUkzG3EyTMo6EvchCbUq2cBjD19V8l6XRr9fi+TJbK2nuBW6FdkcvTqxAy/zWyNW
         /+u8p5caC3lOBN70OTshinPq6n7wDyPuE5eofMwhWlXSVvQt/5oYZv5zU9HVI0spMvqe
         P0jfBQ6TpzOrXEbPdYAXgp3XO3+tdAAZ8ZkTPg9cEymZpCt7qFcmmItH+sMEFxulD3N1
         1CPfxO0ZXeFduS7uGpBJqRyPx/VH8gVOWsnwxICnwAbzzaT/leSmayOUh+6VFHtEJEzS
         istw==
X-Forwarded-Encrypted: i=1; AFNElJ+QbSYSlEj+OcvtDIOVwQXciMnCDAOSP+60A1/6ihhfIB+Susyej1hU74gj0ixLzQsBOqm57xbkh6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyIalAAswQxjv9HtJ00Kvxf5SwwhD+fnGusZYKCa7YXS59zljT
	LF86c7HIPvFbNKPSBYk7FQzgbV54zOfSh3nwyizvhPnNgG2SS9Ka3PkU
X-Gm-Gg: Acq92OHDL7oXHYXAWHwntiikasNyLdibTZvmlGfUtQAkwxn6MADUhmXZkt1l0X6DAl9
	w2b4VRwetZPw+xztTwa1KnwJtTUPXRi3pU9T/9Z6NJmam0Xvps+ybGv/ya6URA9Laz+54MbChsB
	/fD03VBLOIx8S0Clb39k2zbosCGHd5e9vBA2I6ggBM+5OB5+nSy7Q6/exbsKw8oMwri4lQpcgy8
	idG1+SjH2nRGElF746cZqCrrAEjVeqWC/JzudfbNrEoGeuIElF8XhGSLc2K40KV7voOSto4CJWg
	VEAHkhBEOEIxhNN3Cu79gQ7eU8y8U/wc6876OQKcY+1HxYzDCN46wr11LgljQ/BCKqy5RzP1V4d
	YxDxFGXLcM18fAfiF5a5ds9CsASQApV/Wk2HLNbysT8pbyjUX2lpuIlYD3Vr+93bVEE/EDO9tKA
	+VR09Uw8vID7744i2peGvG/vzMUWQVO4+e0h2Zm6VaXYA=
X-Received: by 2002:a05:600c:4fc9:b0:48e:706b:53e3 with SMTP id 5b1f17b1804b1-48fe60e51eamr169141375e9.1.1779052912227;
        Sun, 17 May 2026 14:21:52 -0700 (PDT)
Received: from foxbook (bfk48.neoplus.adsl.tpnet.pl. [83.28.48.48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf80d04sm66981515e9.36.2026.05.17.14.21.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 17 May 2026 14:21:51 -0700 (PDT)
Date: Sun, 17 May 2026 23:21:47 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Jihong Min <hurryman2212@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman
 <mathias.nyman@intel.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Mario
 Limonciello <mario.limonciello@amd.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "Mario Limonciello
 (AMD)" <superm1@kernel.org>, Yaroslav Isakov <yaroslav.isakov@gmail.com>
Subject: Re: [PATCH v6 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Message-ID: <20260517232147.34931718.michal.pecio@gmail.com>
In-Reply-To: <20260517130407.795157-2-hurryman2212@gmail.com>
References: <20260517130407.795157-1-hurryman2212@gmail.com>
	<20260517130407.795157-2-hurryman2212@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 22:04:06 +0900, Jihong Min wrote:
> AMD Promontory 21 (PROM21) xHCI controllers use generic xHCI
> operation, but the PCI function also exposes optional
> controller-specific sensor functionality. Add a small PROM21 PCI glue
> driver for AMD 1022:43fc and 1022:43fd controllers.
> 
> The driver delegates USB host operation to the common xhci-pci core,
> collects the parent-provided MMIO resource data, and creates a "hwmon"
> auxiliary device for optional child drivers. Failure to create the
> auxiliary device is logged but does not fail the xHCI probe, since the
> auxiliary device is only needed for sensor support.
> 
> Make the PROM21 PCI glue a hidden Kconfig tristate that follows
> USB_XHCI_PCI. This keeps the glue built in with a built-in xhci-pci core
> and builds it as a module with a modular xhci-pci core. A built-in
> xhci-pci core must not hand PROM21 controllers to a PROM21 glue driver
> that is only available as a module, otherwise USB behind those controllers
> can be unavailable during initramfs and PROM21 temperature sensor support
> may not appear until the controller is rebound after the module loads.
> 
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Jihong Min <hurryman2212@gmail.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Tested-by: Yaroslav Isakov <yaroslav.isakov@gmail.com>
> ---
>  drivers/usb/host/Kconfig                      |   7 +
>  drivers/usb/host/Makefile                     |   1 +
>  drivers/usb/host/xhci-pci-prom21.c            | 136 ++++++++++++++++++
>  drivers/usb/host/xhci-pci.c                   |  11 ++
>  drivers/usb/host/xhci-pci.h                   |   3 +
>  include/linux/platform_data/usb-xhci-prom21.h |  22 +++
>  6 files changed, 180 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-pci-prom21.c
>  create mode 100644 include/linux/platform_data/usb-xhci-prom21.h
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 0a277a07cf70..89bf262235e1 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -42,6 +42,13 @@ config USB_XHCI_PCI
>  	depends on USB_PCI
>  	default y
>  
> +config USB_XHCI_PCI_PROM21
> +	tristate
> +	depends on X86
> +	depends on USB_XHCI_PCI
> +	default USB_XHCI_PCI
> +	select AUXILIARY_BUS
> +

Instead of the X86 heuristic, would it be possible to build glue
code if and only if SENSORS_PROM21_XHCI is enabled?

This seems to work:

 config SENSORS_PROM21_XHCI
        tristate "AMD Promontory 21 xHCI temperature sensor"
-       depends on USB_XHCI_PCI_PROM21
+       depends on USB_XHCI_PCI

 config USB_XHCI_PCI_PROM21
        tristate
-       depends on X86
        depends on USB_XHCI_PCI
-       default USB_XHCI_PCI
+       default USB_XHCI_PCI if SENSORS_PROM21_XHCI != 'n'
        select AUXILIARY_BUS

I don't know if it's the best way, perhaps it would be preferable for
the hwmon driver to select the glue, but then I'm not sure how to force
glue to become 'y' when xhci-pci is 'y'.

>  config USB_XHCI_PCI_RENESAS
>  	tristate "Support for additional Renesas xHCI controller with firmware"
>  	depends on USB_XHCI_PCI
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index a07e7ba9cd53..174580c1281a 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
>  obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
>  obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
>  obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
> +obj-$(CONFIG_USB_XHCI_PCI_PROM21)	+= xhci-pci-prom21.o
>  obj-$(CONFIG_USB_XHCI_PCI_RENESAS)	+= xhci-pci-renesas.o
>  obj-$(CONFIG_USB_XHCI_PLATFORM) += xhci-plat-hcd.o
>  obj-$(CONFIG_USB_XHCI_HISTB)	+= xhci-histb.o
> diff --git a/drivers/usb/host/xhci-pci-prom21.c b/drivers/usb/host/xhci-pci-prom21.c
> new file mode 100644
> index 000000000000..be0933ca5c62
> --- /dev/null
> +++ b/drivers/usb/host/xhci-pci-prom21.c
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Promontory 21 xHCI host controller PCI Bus Glue.
> + *
> + * This does not add any PROM21-specific USB or xHCI operation. It exists only
> + * to publish an auxiliary device for integrated temperature sensor support.
> + *
> + * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/device/devres.h>
> +#include <linux/errno.h>
> +#include <linux/idr.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_data/usb-xhci-prom21.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +
> +#include "xhci-pci.h"
> +
> +struct prom21_xhci_auxdev {
> +	struct auxiliary_device *auxdev;
> +	struct prom21_xhci_pdata pdata;
> +	int id;
> +};
> +
> +static DEFINE_IDA(prom21_xhci_auxdev_ida);
> +
> +static void prom21_xhci_auxdev_release(struct device *dev, void *res)
> +{
> +	struct prom21_xhci_auxdev *prom21_auxdev = res;
> +
> +	auxiliary_device_destroy(prom21_auxdev->auxdev);
> +	ida_free(&prom21_xhci_auxdev_ida, prom21_auxdev->id);
> +}
> +
> +static int prom21_xhci_create_auxdev(struct pci_dev *pdev)
> +{
> +	struct prom21_xhci_auxdev *prom21_auxdev;
> +	struct usb_hcd *hcd = pci_get_drvdata(pdev);
> +
> +	if (!hcd)
> +		return -ENODEV;

Shouldn't be necessary after successful xhci_pci_common_probe().

> +
> +	prom21_auxdev = devres_alloc(prom21_xhci_auxdev_release,
> +				     sizeof(*prom21_auxdev), GFP_KERNEL);
> +	if (!prom21_auxdev)
> +		return -ENOMEM;
> +
> +	prom21_auxdev->pdata.pdev = pdev;
> +	prom21_auxdev->pdata.regs = hcd->regs;
> +	prom21_auxdev->pdata.rsrc_len = hcd->rsrc_len;
> +
> +	prom21_auxdev->id = ida_alloc(&prom21_xhci_auxdev_ida, GFP_KERNEL);
> +	if (prom21_auxdev->id < 0) {
> +		int ret = prom21_auxdev->id;
> +
> +		devres_free(prom21_auxdev);
> +		return ret;
> +	}
> +
> +	prom21_auxdev->auxdev = auxiliary_device_create(&pdev->dev,
> +							KBUILD_MODNAME, "hwmon",
> +							&prom21_auxdev->pdata,
> +							prom21_auxdev->id);
> +	if (!prom21_auxdev->auxdev) {
> +		ida_free(&prom21_xhci_auxdev_ida, prom21_auxdev->id);
> +		devres_free(prom21_auxdev);
> +		return -ENOMEM;

The usual "goto error" pattern could be used instead of increasingly
long sequences of xxx_free() calls.

> +	}
> +
> +	devres_add(&pdev->dev, prom21_auxdev);
> +	return 0;
> +}
> +
> +static void prom21_xhci_destroy_auxdev(struct pci_dev *pdev)
> +{
> +	devres_release(&pdev->dev, prom21_xhci_auxdev_release, NULL, NULL);
> +}
> +

It seems that these three functions above are everything that you truly
want to add; the rest is boilerplate required by this two-module scheme
to work, plus ID tables which must be duplicated and kept in sync.

I wonder if a separate module is really justified, as opposed to simply
linking this file into xhci_pci.ko when directed by Kconfig.

The downside would be slightly higher memory usage on systems where the
hwmon driver is enabled but not needed. OTOH, same systems would likely
see reduced disk waste.

> +static int prom21_xhci_probe(struct pci_dev *dev,
> +			     const struct pci_device_id *id)
> +{
> +	int retval;
> +
> +	retval = xhci_pci_common_probe(dev, id);
> +	if (retval)
> +		return retval;
> +
> +	retval = prom21_xhci_create_auxdev(dev);
> +	if (retval) {
> +		/*
> +		 * The auxiliary device only provides optional temperature sensor
> +		 * support. Keep the xHCI controller usable if it fails.
> +		 */
> +		dev_err(&dev->dev,
> +			"failed to create PROM21 hwmon auxiliary device: %d\n",
> +			retval);
> +	}
> +
> +	return 0;
> +}
> +
> +static void prom21_xhci_remove(struct pci_dev *dev)
> +{
> +	prom21_xhci_destroy_auxdev(dev);
> +	xhci_pci_remove(dev);
> +}
> +
> +static const struct pci_device_id pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
> +	{ /* end: all zeroes */ }
> +};
> +MODULE_DEVICE_TABLE(pci, pci_ids);
> +
> +static struct pci_driver prom21_xhci_driver = {
> +	.name = "xhci-pci-prom21",
> +	.id_table = pci_ids,
> +
> +	.probe = prom21_xhci_probe,
> +	.remove = prom21_xhci_remove,
> +
> +	.shutdown = usb_hcd_pci_shutdown,
> +	.driver = {
> +		.pm = pm_ptr(&usb_hcd_pci_pm_ops),
> +	},
> +};
> +module_pci_driver(prom21_xhci_driver);
> +
> +MODULE_AUTHOR("Jihong Min <hurryman2212@gmail.com>");
> +MODULE_DESCRIPTION("AMD Promontory 21 xHCI PCI Host Controller Driver");
> +MODULE_IMPORT_NS("xhci");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index 585b2f3117b0..039c26b241d0 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -696,12 +696,23 @@ static const struct pci_device_id pci_ids_renesas[] = {
>  	{ /* end: all zeroes */ }
>  };
>  
> +/* handled by xhci-pci-prom21 if enabled */
> +static const struct pci_device_id pci_ids_prom21[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD) },
> +	{ /* end: all zeroes */ }
> +};
> +
>  static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  {
>  	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_RENESAS) &&
>  			pci_match_id(pci_ids_renesas, dev))
>  		return -ENODEV;
>  
> +	if (IS_ENABLED(CONFIG_USB_XHCI_PCI_PROM21) &&
> +	    pci_match_id(pci_ids_prom21, dev))
> +		return -ENODEV;
> +
>  	return xhci_pci_common_probe(dev, id);
>  }
>  
> diff --git a/drivers/usb/host/xhci-pci.h b/drivers/usb/host/xhci-pci.h
> index e87c7d9d76b8..11f435f94322 100644
> --- a/drivers/usb/host/xhci-pci.h
> +++ b/drivers/usb/host/xhci-pci.h
> @@ -4,6 +4,9 @@
>  #ifndef XHCI_PCI_H
>  #define XHCI_PCI_H
>  
> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FC	0x43fc
> +#define PCI_DEVICE_ID_AMD_PROM21_XHCI_43FD	0x43fd
> +
>  int xhci_pci_common_probe(struct pci_dev *dev, const struct pci_device_id *id);
>  void xhci_pci_remove(struct pci_dev *dev);
>  
> diff --git a/include/linux/platform_data/usb-xhci-prom21.h b/include/linux/platform_data/usb-xhci-prom21.h
> new file mode 100644
> index 000000000000..ee672ad452a8
> --- /dev/null
> +++ b/include/linux/platform_data/usb-xhci-prom21.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD Promontory 21 xHCI auxiliary device platform data.
> + *
> + * Copyright (C) 2026 Jihong Min <hurryman2212@gmail.com>
> + */
> +
> +#ifndef _LINUX_PLATFORM_DATA_USB_XHCI_PROM21_H
> +#define _LINUX_PLATFORM_DATA_USB_XHCI_PROM21_H
> +
> +#include <linux/compiler_types.h>
> +#include <linux/types.h>
> +
> +struct pci_dev;
> +
> +struct prom21_xhci_pdata {
> +	struct pci_dev *pdev;
> +	void __iomem *regs;
> +	resource_size_t rsrc_len;
> +};
> +
> +#endif
> -- 
> 2.53.0
> 
