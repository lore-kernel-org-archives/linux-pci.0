Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:38240 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752469AbdFQFLv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Jun 2017 01:11:51 -0400
Date: Sat, 17 Jun 2017 07:11:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 02/13] switchtec: export class symbol for use in
 upper layer driver
Message-ID: <20170617051145.GD6040@kroah.com>
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170615203729.9009-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170615203729.9009-3-logang@deltatee.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 15, 2017 at 02:37:18PM -0600, Logan Gunthorpe wrote:
> We switch to class_register/unregister and a declared class which
> is exported for use in the switchtec_ntb driver.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Stephen Bates <sbates@raithlin.com>
> Reviewed-by: Kurt Schwemmer <kurt.schwemmer@microsemi.com>
> ---
>  drivers/pci/switch/switchtec.c | 21 +++++++++++----------
>  include/linux/switchtec.h      |  2 ++
>  2 files changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index c4369ba7bbc1..e9bf17b1934e 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -21,8 +21,6 @@
>  #include <linux/fs.h>
>  #include <linux/uaccess.h>
>  #include <linux/poll.h>
> -#include <linux/pci.h>
> -#include <linux/cdev.h>
>  #include <linux/wait.h>
>  
>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
> @@ -35,9 +33,14 @@ module_param(max_devices, int, 0644);
>  MODULE_PARM_DESC(max_devices, "max number of switchtec device instances");
>  
>  static dev_t switchtec_devt;
> -static struct class *switchtec_class;
>  static DEFINE_IDA(switchtec_minor_ida);
>  
> +struct class switchtec_class = {
> +	.owner = THIS_MODULE,
> +	.name = "switchtec",
> +};
> +EXPORT_SYMBOL(switchtec_class);

EXPORT_SYMBOL_GPL()?

And do you really have to move from a dynamic class to a static one?  I
know it will work just the same, but I hate seeing static structures
that have reference counts on them :)

thanks,

greg k-h

> +
>  enum mrpc_state {
>  	MRPC_IDLE = 0,
>  	MRPC_QUEUED,
> @@ -1026,7 +1029,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
>  
>  	dev = &stdev->dev;
>  	device_initialize(dev);
> -	dev->class = switchtec_class;
> +	dev->class = &switchtec_class;
>  	dev->parent = &pdev->dev;
>  	dev->groups = switchtec_device_groups;
>  	dev->release = stdev_release;
> @@ -1313,11 +1316,9 @@ static int __init switchtec_init(void)
>  	if (rc)
>  		return rc;
>  
> -	switchtec_class = class_create(THIS_MODULE, "switchtec");
> -	if (IS_ERR(switchtec_class)) {
> -		rc = PTR_ERR(switchtec_class);
> +	rc = class_register(&switchtec_class);
> +	if (rc)
>  		goto err_create_class;
> -	}
>  
>  	rc = pci_register_driver(&switchtec_pci_driver);
>  	if (rc)
> @@ -1328,7 +1329,7 @@ static int __init switchtec_init(void)
>  	return 0;
>  
>  err_pci_register:
> -	class_destroy(switchtec_class);
> +	class_unregister(&switchtec_class);
>  
>  err_create_class:
>  	unregister_chrdev_region(switchtec_devt, max_devices);
> @@ -1340,7 +1341,7 @@ module_init(switchtec_init);
>  static void __exit switchtec_exit(void)
>  {
>  	pci_unregister_driver(&switchtec_pci_driver);
> -	class_destroy(switchtec_class);
> +	class_unregister(&switchtec_class);
>  	unregister_chrdev_region(switchtec_devt, max_devices);
>  	ida_destroy(&switchtec_minor_ida);
>  
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index 508cda78a430..3b87618fc42f 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -267,4 +267,6 @@ static inline struct switchtec_dev *to_stdev(struct device *dev)
>  	return container_of(dev, struct switchtec_dev, dev);
>  }
>  
> +extern struct class switchtec_class;
> +
>  #endif
> -- 
> 2.11.0
