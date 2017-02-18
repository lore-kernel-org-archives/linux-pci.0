Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44497 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753461AbdBRUlD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Feb 2017 15:41:03 -0500
To: Keith Busch <keith.busch@intel.com>,
        Myron Stowe <myron.stowe@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Wei Zhang <wzhang@fb.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20170210145124.GA24594@kroah.com>
 <1486749440-24309-1-git-send-email-logang@deltatee.com>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <stephen.bates@microsemi.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <20e55da4-b3c1-7c57-15cf-b0aa52442e18@deltatee.com>
Date: Sat, 18 Feb 2017 13:22:20 -0700
MIME-Version: 1.0
In-Reply-To: <1486749440-24309-1-git-send-email-logang@deltatee.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH] switchtec: cleanup cdev init
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

Please don't apply this patch and instead apply the switchtec driver as
we submitted in v2. As per the discussion in [1], not using the cdev's
kobj parent results in incorrect reference counting and a possible use
of the cdev after its containing structure is freed.

I've also done a quick review around the kernel and found the pattern in
question to be quite prevalent. It's used in, at least, these drivers:

drivers/dax/dax.c:708
drivers/input/evdev.c:1419
drivers/input/joydev.c:908
drivers/input/mousedev.c:904
drivers/gpio/gpiolib.c:1039
drivers/char/tpm/tpm-chip.c:190
drivers/platform/chrome/cros_ec_dev.c:411
drivers/infiniband/hw/hfi1/device.c:72
drivers/infiniband/core/uverbs_main.c:1168
drivers/infiniband/core/user_mad.c:1186
drivers/infiniband/core/user_mad.c:1205
drivers/iio/industrialio-core.c:1721
drivers/media/cec/cec-core.c:140
drivers/media/media-devnode.c:258

Dan Williams has proposed a helper API in [2] that could make this code
appear significantly less suspect which I think would be a good idea.
However, for now, I feel the switchtec code should also follow this
pattern (ie. the way it was submitted in v2) and can be changed or
cleaned up when/if the above numerous examples are fixed up.

Thanks,

Logan

[1] https://lkml.org/lkml/2017/2/10/589
[2] https://lkml.org/lkml/2017/2/13/700




On 10/02/17 10:57 AM, Logan Gunthorpe wrote:
> Per a suggestion from Greg Kroah-Hartman [1], don't set the cdev's
> kobject parent. This allows us to use device_register instead of init
> and add.
> 
> [1] https://lkml.org/lkml/2017/2/10/370
> ---
>  drivers/pci/switch/switchtec.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 82bfd18..014eaec 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1222,24 +1222,23 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>  		return ERR_PTR(minor);
>  
>  	dev = &stdev->dev;
> -	device_initialize(dev);
>  	dev->devt = MKDEV(MAJOR(switchtec_devt), minor);
> -	dev->class = switchtec_class;
> -	dev->parent = &pdev->dev;
> -	dev->groups = switchtec_device_groups;
> -	dev->release = stdev_release;
> -	dev_set_name(dev, "switchtec%d", minor);
>  
>  	cdev = &stdev->cdev;
>  	cdev_init(cdev, &switchtec_fops);
>  	cdev->owner = THIS_MODULE;
> -	cdev->kobj.parent = &dev->kobj;
>  
>  	rc = cdev_add(&stdev->cdev, dev->devt, 1);
>  	if (rc)
>  		goto err_cdev;
>  
> -	rc = device_add(dev);
> +	dev->class = switchtec_class;
> +	dev->parent = &pdev->dev;
> +	dev->groups = switchtec_device_groups;
> +	dev->release = stdev_release;
> +	dev_set_name(dev, "switchtec%d", minor);
> +
> +	rc = device_register(dev);
>  	if (rc) {
>  		cdev_del(&stdev->cdev);
>  		put_device(dev);
> 
